import json
from pathlib import Path

from jinja2 import Environment, FileSystemLoader

GRID_COLUMNS = 3


def parse_int(value: object, default: int = 1) -> int:
    try:
        parsed = int(value)
    except (TypeError, ValueError):
        return default
    return max(1, parsed)


def load_cards(base_dir: Path) -> list[dict]:
    cards_dir = base_dir / "cards"
    thumbnails_dir = base_dir / "thumbnails"

    cards: list[dict] = []
    for card_path in sorted(cards_dir.glob("*.json")):
        data = json.loads(card_path.read_text())

        title = data.get("title") or data.get("name")
        if not title:
            continue

        rows = parse_int(data.get("rows"), 1)
        cols = min(parse_int(data.get("cols"), 1), GRID_COLUMNS)

        thumbnail_path = thumbnails_dir / f"{card_path.stem}.webp"

        cards.append(
            {
                "title": title,
                "description": data.get("description"),
                "type": str(data.get("type", "item")),
                "url": data.get("url"),
                "rows": rows,
                "cols": cols,
                "image_left": cols > rows,
                "thumbnail": f"thumbnails/{thumbnail_path.name}" if thumbnail_path.exists() else None,
            }
        )

    return cards


def main() -> None:
    base_dir = Path(__file__).parent
    cards = load_cards(base_dir)

    env = Environment(loader=FileSystemLoader(base_dir))
    template = env.get_template("index.html.jinja")
    html = template.render(cards=cards)

    output_path = base_dir / "index.html"
    output_path.write_text(html)
    print(f"Generated index.html with {len(cards)} cards")


if __name__ == "__main__":
    main()
