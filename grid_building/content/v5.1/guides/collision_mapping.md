---
title: Collision Mapping
description: Collision Mapping documentation for the Grid Building system
---


---

How the plugin turns 2D collision into grid tiles for placement rules and indicators. 
[CollisionMapper](../api/CollisionMapper/) is the central orchestrator that extracts collision geometry from objects and produces tile position → rule / object maps.
Introduced in v5.0.0 as a refactoring and enhancement of previous collision handling logic.

**Grid Building 5.0.0 features thoroughly tested and validated collision detection** with:
- **Multi-shape collision support** for complex building footprints
- **Precise edge case handling** for overlapping geometries  
- **Optimized physics queries** with intelligent caching
- **Validated collision mathematics** backed by comprehensive automated tests

## Purpose

When a player previews or places a building/object, the system needs to know which grid tiles are "touched" by that object's collision so that:


The Collision Mapping subsystem standardizes this translation with consistent geometric rules and thresholds. In practice, the subsystem is most often invoked by indicator code (for example [IndicatorManager](../api/IndicatorManager/) / [RuleCheckIndicator](../api/RuleCheckIndicator/)) during preview and placement: the indicator layer asks the mapper to map the preview instance's collision against the active `TileMapLayer` and then creates per-tile indicators for every tile that passes the mapping and significance filters.

## Key Components

| Component                     | Responsibility                                                                                                               |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| [CollisionMapper](../api/CollisionMapper/)             | Orchestrates extraction of collision geometry from objects and produces tile position → rule / object maps.                  |
| [CollisionMapper](../api/CollisionMapper/) caching      | The mapper implements per-frame geometry caching (polygon, bounds, tile results) to reduce repeated work during previews.   |
| [CollisionTestSetup2D](../api/CollisionTestSetup2D/) | Lightweight context wrapper storing an object's transform, origin offset, and cached geometry meta used in mapping.          |
| [RuleCheckIndicator](../api/RuleCheckIndicator/)          | Visual probe shape whose bounds define the sampling region; per-frame it revalidates placement using mapped collision tiles. |
| [GBGeometryMath](../api/GBGeometryMath/)              | Static geometry helpers: shape → polygon conversion (shape→polygon conversion continues to use GBGeometryMath).            |
| [CollisionGeometryUtils](../api/CollisionGeometryUtils/) | Stateless helpers that drive the unified polygon→tile path (delegates to CollisionGeometryCalculator). Contains conservative test defaults (edge epsilon, min area fraction) used across tests and the mapper. |
| [CollisionGeometryCalculator](../api/CollisionGeometryCalculator/) | Pure geometry calculator: precise polygon/tile overlap, clipping and area calculations used by CollisionGeometryUtils and tests. |
| [CollisionProcessor](../api/CollisionProcessor/)      | Runtime processor that unifies polygon and shape paths, returns relative offsets for indicators and manages internal caching for performance optimization. |
| [TileCheckRule](../api/TileCheckRule/)               | Rule data object listing which collision layers (mask) it applies to and additional semantic constraints.                    |
| [GridTargetingState](../api/GridTargetingState/)          | Aggregates targeting context: maps, positioner, currently inspected TileMap layer, etc.                                      |

## At a glance

		- The mapping pipeline now uses a unified geometry path: [CollisionGeometryUtils](../api/CollisionGeometryUtils/) (test-friendly helpers) delegates to the precise [CollisionGeometryCalculator](../api/CollisionGeometryCalculator/) for polygon→tile overlap calculations. Defaults used in tests are: edge epsilon = 0.01 and min area fraction = 0.05 (5%).
		- Shapes: shape→polygon conversion is still performed via `GBGeometryMath.convert_shape_to_polygon`, then fed through the unified polygon path. Shape processing uses a baseline `shape_epsilon` ≈ 0.035 in the shape path.
			- Round primitives (circle / capsule) use a slightly lower per-tile threshold (~0.025) and additional corner pruning / mirroring logic to avoid spurious corner tiles.
		- Polygons: the mapper-level polygon sliver suppression constant remains `MIN_POLY_TILE_OVERLAP_RATIO = 0.12` (12%) and is defined on the runtime mapper where rule-level aggregation occurs.

Currently supported primitive shapes (converted to polygons):

- `RectangleShape2D` → 4-point polygon
- `CircleShape2D` → N-gon approximation (default 16 segments)
- `CapsuleShape2D` / Capsule approximation → approximated polygon (often replaced by explicit `CollisionPolygon2D` in assets)


## Shape → Polygon Conversion

All collision evaluation reduces to polygon vs tile area overlap. Each source shape is converted into a local-space polygon and then transformed into world space using the owning node's global transform plus any indicator offset. For complex objects with multiple shapes, polygons are processed independently and merged into a tile coverage map.

Advantages:

- Unified overlap test implementation (single polygon→tile path simplifies verification and testing)
- Enables accurate partial-tile filtering via area-based thresholds (prevents hairline contacts from triggering tiles)
- Supports arbitrary future shapes by adding a single shape→polygon converter; all downstream code re-uses the unified overlap routine

## How it works

The grid uses uniform tiles (commonly 16×16).

1) Collect sources matching the rule’s layer mask.
2) Convert each shape to a polygon in world space (polygons are already polygons).
3) Iterate candidate tiles from the polygon’s bounds and test overlap. In the current implementation this iteration and overlap testing is performed by `CollisionGeometryCalculator.calculate_tile_overlap()` (via `CollisionGeometryUtils.compute_polygon_tile_offsets()`), ensuring polygon and shape code paths produce identical tile sets.
4) Apply significance filters (shape_epsilon ≈ 0.035 for shapes; 0.025 for round shapes; 12% for polygons) and de‑duplicate tiles.

### Significance filters


These thresholds prevent hairline contacts and micro‑slivers from creating indicators or failing rules. Polygons use clipped area so we can discard tiles with negligible true coverage. Round-shape corner tiles are subject to stricter corner thresholds (commonly ~20% of tile area) during corner pruning to eliminate spurious single‑pixel touches on curved geometry.

### Multiple Shapes & Aggregation

If multiple shapes overlap the same tile, that tile is inserted only once; the system aggregates contributing objects or rules in a list attached to the tile coordinate key.

## Collision Layers & Rule Filtering

Each [TileCheckRule](../api/TileCheckRule/) declares an `apply_to_objects_mask`. During mapping, collision objects are filtered by their collision layer bits. A tile is considered relevant for a rule only if at least one contributing object has a matching layer bit set. This ensures rules don't falsely trigger on unrelated decorative collisions.

Examples:


## Indicator Integration

[RuleCheckIndicator](../api/RuleCheckIndicator/) performs per-frame validation:

1. Indicator requests collision mapping within its shape bounds
1. Placement rules are evaluated against the mapped tile set
1. Visual state (valid/invalid color) updates immediately when geometry changes (e.g. moving over edge cases)

The indicator shape itself does not contribute to collision mapping—it's a sampling window that caps unnecessary tile iteration.

## Indicator Positioning

After collision mapping determines which tiles are occupied by a test object, the system needs to position visual indicators to show validation results. The positioning follows a specific transformation from absolute collision coordinates to relative indicator placement.

### Collision-to-Indicator Positioning Flow

1. **Collision Detection**: The collision mapping system identifies absolute tile positions where the test object's collision shapes (CollisionShape2D, CollisionPolygon2D) would intersect with the tilemap.

2. **Position Normalization**: Each collision tile position is normalized into a consistent relative offset pattern using modulo arithmetic:
   ```gdscript
   var offset_x = (position.x % 7) - 3  # Range: -3 to +3 tiles
   var offset_y = (position.y % 7) - 3  # Range: -3 to +3 tiles
   ```

3. **Relative Positioning**: Indicators are positioned relative to the test object's current location, not at the absolute collision coordinates. This ensures indicators maintain consistent spatial relationships when the test object moves.

4. **World Coordinate Translation**: The normalized offsets are applied to the test object's tile position and converted back to world coordinates for final indicator placement.

### Key Positioning Behaviors

- Movement Following: When the test object moves, indicators automatically follow while preserving their relative layout pattern.
- Consistent Patterns: The modulo-based normalization produces deterministic indicator layouts for the same collision patterns.
- Tile-Based Offsets: Indicators are placed using whole-tile offsets relative to the test object's center (no sub-tile offsets).
- Shape-Aware Placement: Different collision silhouettes (rectangles, circles, polygons) produce different mapped tile sets and therefore different indicator arrangements.

### Initial Collision Testing

The positioning system begins by mapping collision geometry into candidate tiles and then deciding which tiles should receive indicators:

- CollisionShape2D Sources: Rectangle, circle, and capsule shapes are converted to polygons (via `GBGeometryMath.convert_shape_to_polygon`) and tested for tile overlap.
- CollisionPolygon2D Sources: Polygons are tested directly using polygon→tile overlap and clipping.
- Layer Mask Filtering: Only collision objects matching the rule's `apply_to_objects_mask` contribute to the mapped tile set used for indicator generation.
- Significance Thresholds: Minimum overlap requirements and pruning heuristics are applied before indicators are created to avoid noise from negligible contacts.
The positioning system begins with comprehensive collision testing against the test object's shapes:


This approach transforms raw collision detection results into meaningful spatial feedback, showing players exactly where placement constraints apply relative to their intended build location.

## Precision vs Performance

Optimizing collision mapping is about choosing sensible defaults that preserve placement accuracy while avoiding per-frame expensive computation during previews. The subsystem uses a few small techniques to balance precision and runtime cost:

Optimizations:

- Bounds pruning: most geometry is quickly rejected by testing tile-bounds overlap before performing precise polygon clipping.
- Per-frame caching: [CollisionMapper](../api/CollisionMapper/) and [CollisionProcessor](../api/CollisionProcessor/) implement internal geometry caching to reuse intermediate polygons and tile masks during continuous previews.
- Unified polygon path: converting shapes to polygons and running a single polygon→tile routine reduces duplicated code and allows a single, optimized hot path ([CollisionGeometryCalculator](../api/CollisionGeometryCalculator/)).
- Sliver suppression & significance filters: area-based thresholds eliminate tiny overlaps that would otherwise create noisy indicators or false rule failures.

### Normalization helpers

The repo exposes small helpers and filters to make indicator placement deterministic and easier to reason about:

- [GBCollisionTileFilter](../api/GBCollisionTileFilter/) — utilities for normalizing tile spans, enforcing odd-span centering, and mirroring/pruning corner tiles for round primitives. See the API page: [GBCollisionTileFilter](../api/GBCollisionTileFilter/).
- Tile offset normalization — the indicator positioning flow uses modulo-based normalization (documented above) to convert absolute collision tile coordinates into stable relative offsets.

Performance Notes:

- Caching scope: caches are intentionally per-preview (per-indicator) and invalidated when transforms or the target tilemap change; internal polygon caches are maintained to avoid expensive rebuilds across many previews.
- Hot-path cost: the most expensive work is polygon clipping and exact area calculation in [CollisionGeometryCalculator](../api/CollisionGeometryCalculator/). Keep complex polygon vertex counts reasonable in authored assets when possible.
- Tuning knobs: use the mapper and geometry utils constants (edge epsilon, min area fraction, `MIN_POLY_TILE_OVERLAP_RATIO`) to relax or tighten sensitivity — configuration is documented on the respective API pages (see links).

## Cross-links

- [CollisionMapper](../api/CollisionMapper/)
- [CollisionProcessor](../api/CollisionProcessor/)
- [CollisionGeometryUtils](../api/CollisionGeometryUtils/)
- [CollisionGeometryCalculator](../api/CollisionGeometryCalculator/)
- [GBCollisionTileFilter](../api/GBCollisionTileFilter/)



______________________________________________________________________

Support / Purchase Hub: **[Linktree – All Grid Builder Links](https://linktr.ee/gridbuilder)**

## Examples

### Small 15×15 rectangle on 16×16 grid

- Bounds cover approximately one tile
- Overlap area = 225 px² (> 5% threshold) so the tile is mapped
- Mapped tiles: 1

### Thin edge polygon (0.1×0.1) touching a tile corner

- Very small area compared to tile size (e.g. 0.01 px²) — below the min-area threshold
- Filtered out and produces 0 mapped tiles

### Complex building with multiple CollisionShapes

- Each shape is converted independently to polygons and mapped
- Tiles are aggregated and de-duplicated; if multiple shapes contribute the same tile, the tile stores references to all contributors (useful for rule attribution)

## Tests

Automated coverage includes layer filtering, rectangle + polygon overlap (multi‑tile), significance filters, trapezoid heuristics, and concave handling.

Targeted regressions:

## Authoring tips


## Extensibility

To add a new shape type:

1. Implement shape → polygon conversion in [GBGeometryMath](../api/GBGeometryMath/)
1. Add test ensuring correct vertex count and bounds
1. (If needed) Expose editor tooling to simplify generating the polygon

To adjust sensitivity:



## Known limitations & future work

| Area                  | Current State                                               | Potential Enhancement                                       |
| --------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| Concave polygons      | Supported (processed as provided) but no auto-decomposition | Decompose to convex parts for potential faster intersection |
| Rotated tileset grids | Assumes axis-aligned square tiles                           | Add support for isometric / staggered grids                 |
| Large dynamic objects | Per-frame full remap                                        | Add incremental dirty-region updates                        |
| Epsilon globality     | Single threshold shared across rules                        | Per-rule or per-layer override                              |

## Parenting & movement

1) Shapes: offsets pivot around the owner’s tile (stable if only the positioner moves).
2) Polygons: offsets pivot around the positioner’s tile.
3) Offsets = `tile_pos - center_tile`.

## Summary

Collision mapping converts all relevant 2D collision shapes into polygons, determines significantly overlapped tiles using a fractional area threshold, filters them by rule-relevant collision layers, and feeds this tile set into placement validation and visual feedback. The design balances accuracy (tight polygon outlines) with performance (bounds pruning + epsilon) to deliver responsive, reliable placement previews.

## Change log (focused excerpts)

| Date       | Change                                                                                     | Rationale                                               | Impact                                                             |
| ---------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------- | ------------------------------------------------------------------ |
| 2025-09-16 | Added comprehensive "Indicator Positioning" section documenting collision-to-indicator transformation | Document how collision detection results are transformed into relative indicator positioning | Improves developer understanding of positioning system architecture |
| 2025-08-18 | Reverted experimental bounds-center polygon pivot to positioner-centered model             | Preserve established test & gameplay frame of reference | Keeps existing offset expectations; removes need for test rewrites |
| 2025-08-18 | Introduced generic rectangle/circle tile normalization utilities ([GBCollisionTileFilter](../api/GBCollisionTileFilter/)) | Remove magic size branches (32x48, radius 24)           | More maintainable, symmetrical coverage without hardcoded cases    |
| 2025-08-18 | Restored trapezoid expected coverage (13 tiles) after mapper corrections                   | Validate intended geometry                              | Prevents silent coverage shrink regression                         |
| 2025-08-21 | Added polygon min‑area filter (12%) and rectangle center‑anchored odd‑span normalization | Eliminate slivers; ensure full used‑space (e.g., Smithy bottom‑middle) | Stable, predictable coverage; parity with tests |
| 2025-08-21 | Changed CollisionObject2D shape pivoting: shape offsets pivot around the *owner's* tile (owner-centered) while polygon sources remain positioner-centered; allowed Area2D rectangle sources to contribute | Decouple shape offsets from the targeting positioner and avoid surprising offset changes when moving only the positioner | More intuitive behavior; requires no test rebase for most cases |
| 2025-08-21 | Per-shape tuning for round primitives: lower area threshold and corner pruning, plus symmetric mirroring enforcement | Remove spurious corner tiles for circles/capsules and ensure left/right symmetry | Improved UX for round shapes and consistent indicator geometry |

______________________________________________________________________

Last updated: 2025-09-16