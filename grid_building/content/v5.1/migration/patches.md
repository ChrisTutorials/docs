---
title: 'v5.1.x Patch Notes'
description: 'Patch-level changes and improvements across v5.1.x releases'
---


---


<Aside type="note" title="About Patch Versions">
Patch versions (5.1.1, 5.1.2, etc.) contain bug fixes, documentation improvements, and minor internal refactorings that don't change the public API surface. This document tracks all patch-level changes within the v5.1 minor version.
</Aside>

## Future Patches

This section will document any future patch-level changes for v5.1.x releases.

<Aside type="caution" title="Breaking Change">
If you were using the `PlaceableInstance` component in v5.0.0, you'll need to migrate to the new metadata-based approach. See the [Placement Persistence](../guides/placement-persistence/) guide for details.
</Aside>

**Why this is minor:** The change doesn't affect the public API surface - it's an internal implementation improvement that makes persistence more reliable and easier to use.

**Changes:**
- Removed `PlaceableInstance` node-based tracking
- Added `gb_placement` metadata dictionary for tracking placed objects
- Introduced `GBPlacementPersistence` utility class for save/load operations
- Updated all placement workflows to use metadata instead of components

**Migration Steps:**
1. Replace `PlaceableInstance` references with metadata queries using `get_meta("gb_placement")`
2. Update save/load logic to use `GBPlacementPersistence.get_all_placed_objects()` and `save_placement_data()`
3. See the [Placement Persistence Migration](../guides/placement-persistence/#migrating-from-v500) guide for detailed examples

## Version 5.0.0

**Release Date:** September 2025

**Summary:** Initial stable release of Grid Building v5.0.

- Complete rewrite of placement and building systems
- Rule-based placement validation framework
- Comprehensive indicator management system
- Full multiplayer support with deterministic workflows
- Extensive API documentation and guides
