---
title: Breaking Changes
title: Breaking Changes
description: Incompatible changes in Grid Building v5.0.0 and how to update
---


## ⚠️ Critical Breaking Changes from 4.3.1 → 5.0.0

This page summarizes the user-facing API and migration steps required when upgrading from `4.3.1` to `5.0.0`. It focuses on public-facing changes (classes, method signatures, resources) rather than internal refactors.

## Summary of major breaking changes (4.3.1 → 5.0.0)
- Dependency Injection / Composition Container is now the primary integration pattern. See `../api/GBCompositionContainer/` and `../api/GBInjectorSystem/`.
- Configuration consolidated into the `GBConfig` resource (`../api/GBConfig/`).
- Validation contract standardized: `validate()` results are represented as boolean success + diagnostic collections via `get_runtime_issues()` / `get_editor_issues()` (multiple files expose these methods).
- Godot API change: migrate any `TileMap` usage to `TileMapLayer` for 2D tile placement/queries.
- Important signature/rename breaks (examples): `GBOwnerContext.set_owner(...)` now requires a `GBOwner`; `DragBuildManager` was renamed to `DragManager` and exposes `is_dragging()`.

The sections below expand each item with concrete before/after examples and file references.

---

## 1) Dependency Injection (DI) and Composition Container

What changed
- The plugin moved from ad-hoc, direct node/system instantiation to a composition-based approach. New public resources/classes include `GBCompositionContainer`, `GBInjectorSystem`, and `GBSystemsContext` (see `../api/GBCompositionContainer/`, `../api/GBInjectorSystem/`, and `../api/GBSystemsContext/`).

Impact
- Callsites that previously created systems directly (e.g., `BuildingSystem.new()`) should now obtain systems via the injector/composition pattern.
- For most end users the recommended integration is:
    1. Add a `GBInjectorSystem` node to your gameplay (runtime) scene where grid-building features are used — this keeps injection local to the gameplay context rather than embedding injector state in level resources.
    2. Create or use a `GBCompositionContainer` resource and assign it to the `GBInjectorSystem` using its exported `composition_container` property. You can use the supplied composition container templates or create your own `GBCompositionContainer` resource file (`.tres`).

Migration guidance (example)
```gdscript
# In the editor: add a GBInjectorSystem node to your gameplay scene and set its
# `composition_container` export to a `GBCompositionContainer` resource saved in your project (e.g. res://data/gb_container.tres).
# This avoids direct runtime calls to `GBCompositionContainer.new()` in your gameplay scripts.
```

Files to review
- `../api/GBCompositionContainer/`
- `../api/GBInjectorSystem/`
- `../api/GBSystemsContext/`

Notes
- The `GBInjectorSystem` listens for scene tree additions and injects dependencies automatically into nodes it manages. Prefer wiring composition via the injector's exported `composition_container` property rather than instantiating containers in gameplay code.
- Use the provided composition container templates (look under the plugin templates folder) or author a `GBCompositionContainer` resource and save it into your project.
- Important: before upgrading, save any existing configuration or exported setting resources (templates, visuals, action sets, etc.) to disk as `.tres` or `.res` files in your project and then reassign them into a `GBConfig` resource. Many exported properties were removed in favor of DI and will not be present after upgrade; saving them ensures you don't lose configuration.

---

## 2) Configuration consolidated under `GBConfig`

What changed
- Multiple scattered exported properties were consolidated into a single `GBConfig` resource. See `../api/GBConfig/` for the API and structure.

Impact
- If you previously used exported properties on different nodes for configuration, move those values into a `GBConfig` resource and assign it to the composition container (or via the `GBInjectorSystem`'s assigned composition container).

Migration example (before)
```gdscript
@export var grid_size: Vector2i = Vector2i(16,16)
@export var indicator_material: Material
```

After (example)
```gdscript
var config := GBConfig.new()
config.settings.grid_size = Vector2i(16,16)
config.settings.visual_settings.indicator_material = indicator_material
# Save `config` as a .tres resource and assign it to your GBCompositionContainer used by the GBInjectorSystem.
```

Files to review: `../api/GBConfig/`

---

## 3) Validation contract standardized

What changed
- Validation flows now favor a boolean success contract plus explicit issue collection via `get_runtime_issues()` and `get_editor_issues()`. Many systems and resources implement these methods.

Impact
- Replace mixed/ambiguous `validate()` return handling with checks that call `validate()` (or other entry points) and then inspect `get_runtime_issues()` when reporting or failing.

Example
```gdscript
# Before: validate() might have returned mixed types
var res = system.validate()

# After: use boolean + diagnostics
var ok: bool = system.validate()
var issues: Array[String] = system.get_runtime_issues()
if not ok:
        container.get_logger().log_issues(issues)
```

Common locations of issue helpers (examples)
- `../api/GBLogger/` (has `get_runtime_issues()`)
- `../api/BuildingSystem/`
- `../api/GridTargetingSystem/`
- Many `../api/*` pages correspond to `resources/*` and `placement/*` GDScript files and expose `get_runtime_issues()` / `get_editor_issues()` in their API.

---

## 4) Godot TileMap → TileMapLayer

What changed
- Godot deprecated some `TileMap` usages for tile-layer operations. Code and exported properties that previously referenced `TileMap` should be migrated to `TileMapLayer` where appropriate.

Migration example
```gdscript
# Before
@export var tile_map: TileMap

# After
@export var tile_map_layer: TileMapLayer
```
---
title: Breaking Changes (redirect)
description: This page has moved. See the Breaking Changes guide under Guides.

This page has been moved to the Guides section to appear in the main Guides navigation. Please see:

- [Breaking Changes — Guides](/v5-0/guides/breaking-changes/)

The canonical content now lives at `v5-0/guides/breaking-changes/`. The migration subfolder retains migration-specific checklists and notes; the primary breaking-changes narrative is centralized under Guides.