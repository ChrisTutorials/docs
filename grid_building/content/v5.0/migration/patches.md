---
title: 'v5.0.x Patch Notes'
description: 'Patch-level changes and improvements across v5.0.x releases'
---


---


<Aside type="note" title="About Patch Versions">
Patch versions (5.0.1, 5.0.2, etc.) contain bug fixes, documentation improvements, and minor internal refactorings that don't change the public API surface. This document tracks all patch-level changes within the v5.0 minor version.
</Aside>

<Aside type="tip" title="No v5.0.x Patches Released">
Version 5.0.0 was immediately followed by v5.1.0, which includes all improvements originally planned for v5.0.1. 

Major improvements like the metadata-based placement persistence system are available in [v5.1.0](/v5-1/).

See the [v5.1 Breaking Changes Guide](/v5-1/migration/breaking-changes/) for migration details.
</Aside>

## Future Patches

This section will document any future patch-level changes if v5.0.x patches are released
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
