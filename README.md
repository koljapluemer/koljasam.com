# koljasam.com

Personal website.

## Build

Regenerate `index.html` from the A4 experiments:

```bash
uv run python main.py
```

This scans the `A4/` folder for subfolders with PDFs, generates thumbnails, and renders `index.html` from the Jinja template.
