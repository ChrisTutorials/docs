# GridBuilding Documentation Repository

This repo contains the Hugo source for the GridBuilding documentation website. Follow these conventions:

## Structure
- `content/` holds the Markdown source (staging).
- `public/` contains the built site (web visible).
- Versioned directories (`/v6.0/`, `/v5.1/`, `/v5.0/`) live under `content/` and are rendered to matching URLs.
- `latest` aliases are implemented via frontmatter `aliases` pointing at the current version.

## Workflow
1. Author Markdown files in `content/`.
2. Run `hugo` to regenerate `public/` (no manual edits in `public/`).
3. Deploy the `public/` output as the live site.

## Hugo Best Practices
- Keep `/vX.Y/` as source of truth; remove legacy `/gridbuilding/` or `/latest/` folders.
- Use aliases in frontmatter to expose `/latest/` or other friendly URLs.
- Prefer AST-generated API docs under `/gridbuilding/v6.0/api/` for accuracy.

## Notes
- This directory is part of the same repo as the GridBuilding codebase; update docs from the `docs/grid_building` folder.
