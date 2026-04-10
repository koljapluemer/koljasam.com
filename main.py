import json
import re
import subprocess
from pathlib import Path

import markdown
from jinja2 import Environment, FileSystemLoader

GRID_COLUMNS = 3


def parse_int(value: object, default: int = 1) -> int:
    try:
        parsed = int(value)
    except (TypeError, ValueError):
        return default
    return max(1, parsed)


def normalize_text(value: object) -> str | None:
    if not isinstance(value, str):
        return None
    stripped = value.strip()
    return stripped or None


def render_markdown(value: str) -> str:
    return markdown.markdown(value, extensions=["extra"], output_format="html5")


def render_markdown_inline(value: str) -> str:
    html = render_markdown(value)
    match = re.fullmatch(r"<p>(.*)</p>", html, flags=re.DOTALL)
    if match:
        return match.group(1)
    return html


def load_cards(base_dir: Path) -> list[dict]:
    cards_dir = base_dir / "cards"
    thumbnails_dir = base_dir / "thumbnails"

    cards: list[dict] = []
    for card_path in cards_dir.glob("*.json"):
        data = json.loads(card_path.read_text())
        if data.get("publish") is False:
            continue

        title = data.get("title")
        if not title:
            continue

        rows = parse_int(data.get("rows"), 1)
        cols = min(parse_int(data.get("cols"), 1), GRID_COLUMNS)
        card_type = str(data.get("type", "item"))

        thumbnail_path = thumbnails_dir / f"{card_path.stem}.webp"

        cards.append(
            {
                "title": title,
                "description": data.get("description"),
                "type": card_type,
                "url": data.get("url"),
                "rows": rows,
                "cols": cols,
                "image_left": cols > rows,
                "paused": data.get("paused") is True,
                "links": normalize_links(data.get("links")),
                "thumbnail": f"thumbnails/{thumbnail_path.name}" if thumbnail_path.exists() else None,
                "failed": normalize_text(data.get("failed")),
                "git_touched_at": git_last_touched_timestamp(base_dir, card_path),
            }
        )

    cards.sort(key=lambda c: c["git_touched_at"], reverse=True)
    return cards


def load_milestones(base_dir: Path) -> list[dict]:
    milestones_dir = base_dir / "milestones"
    thumbnails_dir = base_dir / "thumbnails"
    milestones: list[dict] = []

    for milestone_path in milestones_dir.glob("*.json"):
        data = json.loads(milestone_path.read_text())
        thumbnail_path = thumbnails_dir / f"{milestone_path.stem}.webp"
        evaluation = normalize_text(data.get("evaluation"))
        goal = normalize_text(data.get("goal"))
        show_the_world = normalize_text(data.get("showTheWorld"))
        raw_comments = data.get("comments") if isinstance(data.get("comments"), list) else []
        comments_html = [
            render_markdown(str(comment)) for comment in raw_comments if normalize_text(comment) is not None
        ]
        milestones.append(
            {
                "id": milestone_path.stem,
                "title": normalize_text(data.get("title")),
                "goal": goal,
                "goal_html": render_markdown(goal) if goal else None,
                "evaluation": evaluation,
                "evaluation_html": render_markdown_inline(evaluation) if evaluation else None,
                "started": normalize_text(data.get("started")),
                "ended": normalize_text(data.get("ended")),
                "showTheWorld": show_the_world,
                "showTheWorld_html": render_markdown_inline(show_the_world) if show_the_world else None,
                "comments": raw_comments,
                "comments_html": comments_html,
                "thumbnail": f"thumbnails/{thumbnail_path.name}" if thumbnail_path.exists() else None,
                "git_touched_at": git_last_touched_timestamp(base_dir, milestone_path),
            }
        )

    milestones.sort(key=lambda m: m["id"], reverse=True)
    return milestones


def git_last_touched_timestamp(repo_dir: Path, file_path: Path) -> int:
    rel_path = file_path.relative_to(repo_dir)
    cmd = ["git", "log", "-1", "--format=%ct", "--", str(rel_path)]
    result = subprocess.run(cmd, cwd=repo_dir, capture_output=True, text=True, check=False)
    if result.returncode != 0:
        return 0
    value = result.stdout.strip()
    if not value:
        return 0
    try:
        return int(value)
    except ValueError:
        return 0


def normalize_links(raw_links: object) -> list[dict]:
    if not isinstance(raw_links, dict):
        return []
    links: list[dict] = []
    for label, url in raw_links.items():
        if not isinstance(label, str) or not isinstance(url, str):
            continue
        links.append({"label": label, "url": url})
    return links


def main() -> None:
    base_dir = Path(__file__).parent
    cards = load_cards(base_dir)
    milestones = load_milestones(base_dir)

    env = Environment(loader=FileSystemLoader(base_dir))
    template = env.get_template("index.html.jinja")
    html = template.render(cards=cards)

    output_path = base_dir / "index.html"
    output_path.write_text(html)
    milestones_template = env.get_template("milestones.html.jinja")
    milestones_html = milestones_template.render(milestones=milestones)
    milestones_output_path = base_dir / "milestones.html"
    milestones_output_path.write_text(milestones_html)

    print(f"Generated index.html with {len(cards)} cards")
    print(f"Generated milestones.html with {len(milestones)} milestones")


if __name__ == "__main__":
    main()
