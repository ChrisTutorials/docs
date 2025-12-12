# Build Artifacts Branch Workflow

We now keep generated static-site assets (`grid_building/public/**`, `item_drops/public/**`, `world_time/public/**`, `*/diagrams/**`, etc.) on a dedicated branch called **`build-artifacts`**. This keeps `main` clean for source changes while preserving a full history of published docs.

## Daily Development (source work on `main`)

1. Work on source files as usual on `main`.
2. Commit and push code/doc changes.
3. If the work requires new docs output, regenerate the site locally but **do not commit those public/ files on `main`**.

## Publishing Updated Docs

1. Ensure `main` is up to date and contains the source changes you want published.
2. Regenerate the site locally (e.g., `hugo` or the relevant docs build commands). This will update `public/**` and `diagrams/**`.
3. Switch to the artifacts branch:
   ```bash
   git switch build-artifacts
   ```
4. Merge or rebase the latest `main` into `build-artifacts` so the branch has the matching source revision:
   ```bash
   git merge origin/main
   ```
5. Run the docs build again (recommended) to ensure outputs match the new commit.
6. Stage and commit all generated assets:
   ```bash
   git add grid_building/public item_drops/public world_time/public
   git add grid_building/public/gridbuilding item_drops/public/diagrams world_time/public/diagrams
   git commit -m "Publish generated site outputs"
   ```
7. Push the branch:
   ```bash
   git push origin build-artifacts
   ```
8. Trigger whatever deployment consumes that branch (e.g., GitHub Pages, rsync, etc.).

## Notes

- Never delete or force-push `build-artifacts`; it holds the historical published content.
- Keep `main` free of generated outputs. If you accidentally add them, use `git reset` or `git checkout -- public/…` before committing.
- If you need to inspect a historical build, check out the corresponding commit on `build-artifacts`.
