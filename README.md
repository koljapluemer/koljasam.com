# koljasam.com

Personal site built with Eleventy and Markdown content.

## Tech stack
- Eleventy 3.x static site generator
- Tailwind CSS with Flowbite components compiled via PostCSS
- Nunjucks layouts with Markdown content files

## How to run
1. Install dependencies: `npm install`
2. Start local dev server with Tailwind in watch mode: `npm run dev`
3. Build the static CSS bundle and static site into `_site`: `npm run build`

## Project structure
- `src/` site content and configs consumed by Eleventy
- `src/_includes/layouts/` base layouts for pages
- `src/_includes/partials/` reusable fragments
- `src/styles/` Tailwind entrypoint
- `src/projects/` individual project write-ups in Markdown
- `static/` pass-through assets (compiled CSS, Flowbite JS, images)
