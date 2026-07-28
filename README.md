# koljasam.com

Personal website, built with [Hugo](https://gohugo.io). Content is editable via [Pages CMS](https://pagescms.org) (see `.pages.yml`).

## Structure

- `content/projects/` — project cards shown on the homepage. Front matter: `title`, `description`, `url`, `failed` (optional; if set, the card is marked discontinued and sinks below active ones), `thumbnail`, `date`.
- `content/posts/` — blog posts, listed on the homepage (latest 10) and in full at `/posts/`.
- `assets/images/projects/` — source thumbnails for project cards; resized and re-encoded to WebP at build time (see `layouts/partials/thumbnail.html`).
- `static/images/` — images referenced inline from blog posts (served as-is).

## Build

```bash
hugo
```

Or for local development with live reload:

```bash
hugo server
```
