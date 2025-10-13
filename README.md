# koljasam.com

Personal site built with Eleventy and Markdown content.

## Tech stack
- Eleventy 3.x static site generator
- Node.js/npm scripts for local dev and builds
- Nunjucks layouts with Markdown content files

## How to run
1. Install dependencies: `npm install`
2. Start local dev server with auto-reload: `npm run dev`
3. Build the static site into `_site`: `npm run build`

## Project structure
- `src/` site content and configs consumed by Eleventy
- `src/_includes/layouts/` base layouts for pages
- `src/_includes/partials/` reusable fragments
- `src/projects/` individual project write-ups in Markdown
