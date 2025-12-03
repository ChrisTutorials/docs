---
title: Compatibility Notes (v5.0.0)
description: Short compatibility mappings and rename notes for v5.0.0
---


---

This page collects short, hand-authored compatibility mappings for common renames and signature changes introduced in `v5.0.0`. Use these notes as a quick lookup while migrating — for full details see [Breaking Changes](../guides/breaking-changes/).

## Class & symbol mappings

- DragBuildManager → DragManager

  - Quick mapping: replace references to `DragBuildManager` with `DragManager`.
  - Preferred method: use `DragManager.is_dragging()` instead of older `is_drag_building()` checks where possible.
  - API: `../api/DragManager/`

- [GBOwnerContext](/v5-0/api/GBOwnerContext/).set_owner(...) signature

  - Quick mapping: `GBOwnerContext.set_owner(value)` now expects a typed `GBOwner` instance. Update callsites to construct or pass a `GBOwner` object.
  - API: `../api/GBOwnerContext/` and `../api/GBOwner/`

- GBLogger access

  - Quick mapping: obtain the logger from the composition container or assigned injector instead of constructing `GBLogger` manually:

  Before:

  ```gdscript
  var logger := GBLogger.new()
  logger.log("...")
  ```

  After (preferred):

  ```gdscript
  var logger := composition_container.get_logger()
  logger.log("...")
  ```

  - API: `../api/GBLogger/` and `../api/GBCompositionContainer/`

- GBInjectable base

  - Many runtime classes now extend `GBInjectable` to support the DI lifecycle. If you extended internal classes, review the new base class for lifecycle methods and ref-counting behaviour.
  - API: `../api/GBInjectable/`

## Small code snippets

- Replace usage of DragBuildManager instantiation with the new manager or via the container:

```gdscript
# Before
var m := DragBuildManager.new()

# After (preferred)
var m := composition_container.get_systems().drag
if m.is_dragging():
    # ...
```

## Notes

- These compatibility notes are intentionally short — consult the [Breaking Changes](../guides/breaking-changes/) page for full migration rationale and the `../api/` pages for the complete current API surface.