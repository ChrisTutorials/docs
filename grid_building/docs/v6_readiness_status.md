### Version 6 Readiness Status

- **Overall Status:** ⚠️ *Yellow* – tooling and checks are in place, but some health gates are not yet fully enforced.

#### Scope

- **Code:** `GridBuilding` plugin (`/home/chris/game_dev/plugins/gameplay/GridBuilding`)
- **Docs:** GridBuilding v6 content (`/home/chris/docs/grid_building/content/v6-0/**`)
- **Workspace:** `/home/chris/game_dev/toolkits/cs` orchestration + analyzers

#### Central Health Hub

This document is the **central health hub for GridBuilding 6.0**. Use it as the first stop for:

- High-level readiness status and gates.
- The unified v6 migration / known-issues backlog.
- Pointers to deeper reports and analysis documents.

**Authoritative health documents and reports:**

- Core plugin health assessment: `../HEALTH_ASSESSMENT.md`
- C# runtime architecture & optimization reports:
  - `game_dev/plugins/gameplay/GridBuilding/docs/reports/MAJOR_SYSTEMS_ARCHITECTURE_SCORECARD.md`
  - `game_dev/plugins/gameplay/GridBuilding/docs/reports/HEALTH_OPTIMIZATION_EXECUTION_SUMMARY.md`
- GDScript tools test-suite analysis:
  - `game_dev/plugins/tools/grid_building/docs/EXECUTIVE_SUMMARY.md`
 - UI user-id service architecture:
   - `game_dev/plugins/gameplay/GridBuilding/docs/reports/UI_USER_ID_ARCHITECTURE.md`
 - Multiplayer building & targeting architecture:
   - `game_dev/plugins/gameplay/GridBuilding/docs/reports/MULTIPLAYER_SERVICE_ARCHITECTURE.md`

#### Automated Health Profiles

- **docs_v6**
  - **Tools:** `DocumentationValidator`, `DocScanner`, `ApiValidation`
  - **Coverage:**
    - Hugo front matter + structure validation
    - Duplicate-title and path normalization checks
    - Content-quality scan (performance claims, weak language, heading hierarchy)
    - v6 API docs validation
  - **Gate:** v6 docs are considered *ready* when this profile reports **0 critical failures** and no blocking structural errors.

- **gridbuilding_health**
  - **Tools:** `CodeAnalysis` (GridBuilding-focused metrics), `GDScriptAnalyzer` (plugin analysis)
  - **Coverage:**
    - C# code size/complexity metrics for GridBuilding
    - GDScript plugin analysis for basic safety/structure
  - **Gate:** GridBuilding code is considered *ready* when:
    - GridBuilding metrics run without errors
    - GDScript analysis completes with **no critical issues**.

- **workspace_health**
  - **Tools:** `CodeAnalysis`, `GDScriptAnalyzer`
  - **Coverage:**
    - Workspace-wide code metrics + regression metadata
    - Plugin script analysis
  - **Gate:** Used as a **background signal**; not a hard blocker for v6, but must not show new critical regressions introduced by v6 work.

#### Current Tooling Readiness

- **Orchestration CLI**
  - **Status:** ✅ Implemented
  - **Entrypoint examples:**
    - `dotnet run --project Orchestration -- --profile docs_v6 --format json --output reports/docs_v6_health_summary.json`
    - `dotnet run --project Orchestration -- --profile docs_v6 --format markdown`
  - **Notes:** Uses shared `JsonHelper` for safe JSON I/O and can emit both JSON and Markdown summaries.

- **Documentation + Content Checks**
  - **Status:** ✅ Configured for v6 (inventory, mapping, doc scan, API validation).
  - **Risk:** Any remaining issues will show up as **failed runs** or **critical failures** in the `docs_v6` profile summary.

- **Code + Test Health**
  - **Status:** ⚠️ Partial
    - Code metrics + GDScript analysis are wired.
    - `TestVerifier` and `ProductionReadiness` analyzers exist conceptually but are not yet fully implemented/enforced.
  - **Risk:** v6 is not yet gated on “100% passing tests” at the orchestration level; manual review of GridBuilding tests is still required.

#### v6 Migration & Known Issues Backlog

This table centralizes the major open items that affect GridBuilding 6.0 readiness. Detailed design and rationale live in the reports linked above.

| Area | Description | Repo/Location | Status |
|------|-------------|---------------|--------|
| Core excluded files & Godot deps | Refactor ~50–66 excluded Core files to remove Godot APIs or move them into the `Godot/` layer; delete or migrate reflection-based loggers (`ClassCountLogger`, `CoreLogger`). | `game_dev/plugins/gameplay/GridBuilding/Core/*` | In progress |
| Consumer sync (addons) | Sync Thistletide and demo `addons/grid_building` copies with the source plugin under `plugins/domains/gameplay/GridBuilding`. | `projects/Thistletide`, `demos/grid_building_dev` | Not started |
| Orchestration gating | Finish `TestVerifier` + `ProductionReadiness` analyzers and enforce `docs_v6` + `gridbuilding_health` profiles as CI gates for v6. | `game_dev/toolkits/cs/Orchestration` | Planned |
| Tools plugin test optimization | Apply the 6-phase plan from the tools plugin test analysis to remove redundant GDScript tests while preserving coverage. | `game_dev/plugins/tools/grid_building/docs/*` | Planned |
| Legacy DI / CompositionContainer cleanup | Remove any remaining `CompositionContainer` / legacy DI usages on the Godot side in favor of `ServiceRegistry` and `ServiceCompositionRoot`. | `game_dev/plugins/gameplay/GridBuilding/Godot/*` | In progress |
| v6 guides alignment | For major Core/Godot behavior or architecture changes, update or add guides under `content/v6.0/guides/**` and reference the change in this backlog. | `docs/grid_building/content/v6.0/guides/*` | Continuous |
| UI user-id migration | Migrate UI components (e.g., TargetInformer, ActionLog) to use service-layer user ids instead of identity `@export` fields, as defined in the UI user-id architecture doc. | `game_dev/plugins/gameplay/GridBuilding/Godot/Systems/UI/*` | Planned |
| Multiplayer service architecture | Implement the multiplayer service architecture (one Building/Placement system, one Manipulation system, per-user TargetingShapeCast2D nodes) as defined in the multiplayer architecture doc. | `game_dev/plugins/gameplay/GridBuilding/Godot/*` | Planned |

#### Actions Required to Move to Green

- **[Docs v6]**
  - Run `docs_v6` profile regularly and fix:
    - Any **critical** structural or API validation errors.
    - High-severity DocScanner findings (unproven performance claims, misleading technical statements).

- **[GridBuilding Code]**
  - Ensure:
    - `gridbuilding_health` profile runs clean (no analyzer failures).
    - GridBuilding test projects compile and run without `<Compile Remove="Tests/**" />` exclusions.
    - New runtime systems follow **ServiceCompositionRoot + ServiceRegistry** (no new `CompositionContainer`-based entry points).
    - Any `GridBuilding.Godot.Services.DI.CompositionContainer` usage is treated as **temporary migration scaffolding** and must be removed before the final v6.0 release.

- **[Automation]**
  - Integrate Orchestration `docs_v6` and `gridbuilding_health` commands into CI.
  - Treat any **critical failures** from these profiles as **release blockers** for version 6.
