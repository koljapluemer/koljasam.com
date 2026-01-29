import json
import re
from pathlib import Path

import fitz
from jinja2 import Environment, FileSystemLoader
from PIL import Image

MAX_WIDTH = 800  # 2x for HiDPI/Retina displays
WEBP_QUALITY = 80


def optimize_image(img: Image.Image, output_path: Path) -> None:
    """Resize image to max width and save as WebP."""
    if img.width > MAX_WIDTH:
        ratio = MAX_WIDTH / img.width
        new_height = int(img.height * ratio)
        img = img.resize((MAX_WIDTH, new_height), Image.Resampling.LANCZOS)

    # Convert to RGB if necessary (WebP doesn't support all modes)
    if img.mode in ("RGBA", "P"):
        img = img.convert("RGB")

    img.save(output_path, "WEBP", quality=WEBP_QUALITY)


def load_projects(projects_dir: Path) -> list[dict]:
    """Load project data from JSON files and optimize images."""
    projects = []
    for json_file in sorted(projects_dir.glob("*.json")):
        with open(json_file) as f:
            data = json.load(f)

        # Optimize project image
        original_image = projects_dir / data["image"]
        if original_image.exists():
            optimized_name = original_image.stem + ".webp"
            optimized_path = projects_dir / optimized_name

            img = Image.open(original_image)
            optimize_image(img, optimized_path)

            data["image"] = f"projects/{optimized_name}"
        else:
            data["image"] = f"projects/{data['image']}"

        projects.append(data)
    return projects


def extract_title_from_typ(typ_path: Path) -> str | None:
    """Extract title from a .typ file using regex."""
    content = typ_path.read_text()
    match = re.search(r'title:\s*\[(.*?)\]', content)
    if match:
        return match.group(1)
    return None


def generate_thumbnail(pdf_path: Path, output_path: Path) -> None:
    """Generate an optimized WebP thumbnail from the first page of a PDF."""
    doc = fitz.open(pdf_path)
    page = doc[0]
    pix = page.get_pixmap(matrix=fitz.Matrix(1, 1))
    img = Image.frombytes("RGB", [pix.width, pix.height], pix.samples)
    doc.close()

    optimize_image(img, output_path)


def main():
    base_dir = Path(__file__).parent
    a4_dir = base_dir / "A4"
    projects_dir = base_dir / "projects"

    # Load projects and split into active/archived
    all_projects = load_projects(projects_dir)
    projects = [p for p in all_projects if not p.get("archived")]
    archived_projects = [p for p in all_projects if p.get("archived")]
    print(f"Loaded {len(projects)} active projects, {len(archived_projects)} archived")

    cards = []

    for folder in sorted(a4_dir.iterdir()):
        if not folder.is_dir():
            continue

        # Find .typ file
        typ_files = list(folder.glob("*.typ"))
        if not typ_files:
            print(f"Skipping {folder.name}: no .typ file found")
            continue
        typ_file = typ_files[0]

        # Find PDF file
        pdf_files = list(folder.glob("*.pdf"))
        if not pdf_files:
            print(f"Skipping {folder.name}: no PDF found")
            continue
        pdf_file = pdf_files[0]

        # Extract title
        title = extract_title_from_typ(typ_file)
        if not title:
            print(f"Skipping {folder.name}: could not extract title")
            continue

        # Generate optimized thumbnail
        thumbnail_path = folder / "thumbnail.webp"
        generate_thumbnail(pdf_file, thumbnail_path)
        print(f"Generated thumbnail for {folder.name}")

        cards.append({
            "title": title,
            "pdf_path": f"A4/{folder.name}/{pdf_file.name}",
            "thumbnail": f"A4/{folder.name}/thumbnail.webp",
        })

    # Render template
    env = Environment(loader=FileSystemLoader(base_dir))
    template = env.get_template("index.html.jinja")
    html = template.render(cards=cards, projects=projects, archived_projects=archived_projects)

    output_path = base_dir / "index.html"
    output_path.write_text(html)
    print(f"Generated index.html with {len(cards)} cards")


if __name__ == "__main__":
    main()
