---
Scope: GridBuilding + shared docs Hugo pipeline
Horizon: Q1 2026 (transition to content-only canonical repos)
---

We are migrating all docs repositories to store only canonical `content/` (plus templates/assets) in git, while generated `public/` builds are produced on demand by `game_dev/toolkits/cs`. This roadmap tracks the enabling work.

🔴 **Critical**
1. [ ] Preserve legacy content (5.0 / 5.1)
   - [ ] Snapshot current `public/v5.0` and `public/v5.1` trees into canonical `content/` structures so the source of truth remains accessible even if we never regenerate those versions.
   - [ ] Verify historical assets (images, diagrams) exist under `content/` or `static/` and are referenced via relative paths.
   - [ ] Update docs explaining which versions are “frozen” vs regenerated.
2. [ ] Repository hygiene for generated output
   - [ ] Add `public/**`, `diagrams/**`, and other build artifacts to `.gitignore` on `main`.
   - [ ] Ensure no residual generated files remain in the index (clean working tree after build).
   - [ ] Clarify branch policy (e.g., optional `build-artifacts` snapshots only when needed).
3. [ ] Toolkit build + deploy automation
   - [ ] Extend `game_dev/toolkits/cs` to build Hugo content for 5.0, 5.1, 6.0 on demand (CLI + API).
   - [ ] Provide configuration inputs per version (base URL, theme overrides, legacy shortcodes).
   - [ ] Wire outputs to deployment targets (local preview + CI stages).

🟠 **High**
1. [ ] Validation and test coverage for all site versions
   - [ ] Add automated tests that run the toolkit build for 5.0, 5.1, 6.0 and confirm success (no missing content, broken links, or Hugo warnings treated as errors).
   - [ ] Include regression checks for legacy-only pages (e.g., 5.0 migration docs) so we detect accidental deletions.
2. [ ] Content/source parity checks
   - [ ] Implement diff tooling that compares rendered HTML slotting vs canonical markdown to ensure no sections are dropped.
   - [ ] Add CI job that fails if `git status` shows generated files on `main` after documentation scripts run.
3. [ ] Documentation + training
   - [ ] Expand `BUILD_ARTIFACTS_BRANCH_WORKFLOW.md` (or successor doc) to cover content-only workflow, toolkit usage, and deployment commands.
   - [ ] Record screencast / quickstart for regenerating a specific version locally.

🟡 **Medium**
1. [ ] Optional artifacts branch automation
   - [ ] Provide script to regenerate and push `build-artifacts` only when a historical snapshot is desired (tagged releases, audits).
   - [ ] Include retention policy for those snapshots.
2. [ ] Performance + caching
   - [ ] Cache Hugo resources between version builds to reduce CI time.
   - [ ] Evaluate incremental builds per version.
3. [ ] Extended linting
   - [ ] Add markdown lint / link-checkers tailored for multi-version content directories.

🟢 **Low**
1. [ ] Diagram regeneration pipeline
   - [ ] Integrate Mermaid/PlantUML generation so diagrams live as source and render on demand.
2. [ ] Developer experience polish
   - [ ] VS Code tasks / launch configs for running toolkit builds per version.
3. [ ] Analytics hooks
   - [ ] Document how analytics snippets differ per version and ensure the toolkit can inject them at build time if needed.
