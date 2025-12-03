---
title: 'Placement Persistence - See v5.1'
description: 'Placement persistence was introduced in v5.1 - see v5.1 documentation'
---


---


<Aside type="caution" title="Feature Not Available in v5.0">
**Placement Persistence** with metadata-based tracking was introduced in **v5.1.0**, not v5.0.

This guide has been moved to the v5.1 documentation.
</Aside>

## Where to Find This Content

The complete Placement Persistence guide is available in v5.1:

👉 **[v5.1 Placement Persistence Guide](/v5-1/guides/placement-persistence/)**

## What Changed?

Version 5.0 had a preliminary [PlaceableInstance](../api/PlaceableInstance/) component-based approach that was:

- Poorly documented
- Not part of the official public API
- Never fully implemented

Version 5.1 introduced a complete rewrite with:

- ✅ Lightweight metadata-based tracking
- ✅ [GBPlacementPersistence](../api/GBPlacementPersistence/) utility class
- ✅ Comprehensive save/load API
- ✅ Full documentation and examples

## Migration Path

If you're using v5.0 and need placement persistence:

1. **Upgrade to v5.1** - See [v5.1 Breaking Changes](/v5-1/migration/breaking-changes/)
2. **Follow the v5.1 Guide** - [Placement Persistence Guide](/v5-1/guides/placement-persistence/)
3. **Use the new API** - `GBPlacementPersistence.save_all_placements()` and `.load_all_placements()`

## Why This Matters

Placement persistence is essential for:

- **Save/Load Systems** - Preserve player-built structures across game sessions
- **Level Editors** - Save and reload custom levels
- **Multiplayer Sync** - Replicate placed objects across clients
- **Undo/Redo** - Track and restore placement history

All of these features require v5.1 or later.
