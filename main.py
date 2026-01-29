import re
from pathlib import Path

import fitz
from jinja2 import Environment, FileSystemLoader
from PIL import Image


def extract_title_from_typ(typ_path: Path) -> str | None:
    """Extract title from a .typ file using regex."""
    content = typ_path.read_text()
    match = re.search(r'title:\s*\[(.*?)\]', content)
    if match:
        return match.group(1)
    return None


def generate_thumbnail(pdf_path: Path, output_path: Path) -> None:
    """Generate a thumbnail from the first page of a PDF."""
    doc = fitz.open(pdf_path)
    page = doc[0]
    pix = page.get_pixmap(matrix=fitz.Matrix(1, 1))
    img = Image.frombytes("RGB", [pix.width, pix.height], pix.samples)
    img.save(output_path)
    doc.close()


def main():
    base_dir = Path(__file__).parent
    a4_dir = base_dir / "A4"

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

        # Generate thumbnail
        thumbnail_path = folder / "thumbnail.png"
        generate_thumbnail(pdf_file, thumbnail_path)
        print(f"Generated thumbnail for {folder.name}")

        cards.append({
            "title": title,
            "pdf_path": f"A4/{folder.name}/{pdf_file.name}",
            "thumbnail": f"A4/{folder.name}/thumbnail.png",
        })

    # Render template
    env = Environment(loader=FileSystemLoader(base_dir))
    template = env.get_template("index.html.jinja")
    html = template.render(cards=cards)

    output_path = base_dir / "index.html"
    output_path.write_text(html)
    print(f"Generated index.html with {len(cards)} cards")


if __name__ == "__main__":
    main()
