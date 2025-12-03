---
title: Placement Rules
description: Placement Rules documentation for the Grid Building system
---


---

This page documents the placement rule classes and validation system in Grid Building v5.0.0.

## Core Concepts

# Placement Rules System

The placement rules system provides **extensible validation logic** for determining where objects can be placed. This is a **core entry point** for customizing building behavior.

## 🎯 Key Entry Points

**Base Classes (extend these):**
- **[PlacementRule](../api/PlacementRule/)** - Base class for all validation
- **[TileCheckRule](../api/TileCheckRule/)** - Spatial/per-tile validation

**Common Rule Classes (use these):**
- **[CollisionsCheckRule](../api/CollisionsCheckRule/)** - Physics collision validation
- **[WithinTilemapBoundsRule](../api/WithinTilemapBoundsRule/)** - Tilemap boundary validation
- **[ValidPlacementTileRule](../api/ValidPlacementTileRule/)** - Custom tile validation

1. `setup(params: RuleValidationParameters) -> Array[String]` — validate context & capture references.
1. `validate_placement() -> RuleResult` — compute pass/fail (and message).
1. `apply() -> bool` (optional) — run only after *all* rules pass (e.g. spend inventory materials).
1. `tear_down()` — cleanup when preview target changes or build mode exits.

Each [RuleResult](../api/RuleResult/) couples: the rule instance, `is_successful: bool`, and a human‑readable message.

Rules that operate on per‑tile indicators usually extend [TileCheckRule](../api/TileCheckRule/), which adds:

- `indicators : Array[RuleCheckIndicator]` (shape casts / tile probes)
- `visual_priority` & `fail_visual_settings` for indicator coloring precedence.

[RuleFilters](../api/RuleFilters/).only_tile_check(rules) helps extract all [TileCheckRule](../api/TileCheckRule/) instances from a mixed array.

## Major Enhancements in v5.0.0

### 🏗️ **Architectural Improvements**
- **Enhanced RuleResult Structure**: More detailed validation reporting with better error messages
- **Improved Diagnostics**: Better logging and debugging support for rule execution
- **Performance Optimizations**: Reduced allocations and faster validation cycles
{/* Supports 4.5 as well. Minimum 4.4+. */}

### 🔧 **Validation Enhancements**
- **Detailed Error Messages**: All rules now provide more specific failure reasons
- **Better Rule Execution Tracing**: Enhanced debugging capabilities for rule validation
- **Improved Visual Priority**: More sophisticated indicator coloring precedence
- **Enhanced Collision Detection**: Better physics collision handling and reporting

### 📊 **Migration from v4.3.1**
- **Automatic Compatibility**: Legacy rule implementations continue to work
- **Enhanced Error Reporting**: Gradual migration path to detailed error messages
{/* Removed internal testing class reference */}

## Shipped Rule Classes

| Class                       | File                                                             | Purpose                                                                                 | Notes                                                                                            |
| --------------------------- | ---------------------------------------------------------------- | --------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| [PlacementRule](../api/PlacementRule/)             | `placement_rules/placement_rule.gd`                              | Base contract (setup / validate / apply / tear_down).                                   | Do not implement placement logic here directly.                                                  |
| [TileCheckRule](../api/TileCheckRule/)             | `placement_rules/tile_check_rule.gd`                             | Base for indicator / per‑tile spatial checks.                                           | Supplies `indicators` list & visual metadata.                                                    |
| [CollisionsCheckRule](../api/CollisionsCheckRule/)       | `placement_rules/template_rules/collisions_check_rule.gd`        | Verifies presence or absence of physics overlaps per indicator.                         | Supports `pass_on_collision`, custom messages, layer listing, and exceptions for preview bodies. |
| [WithinTilemapBoundsRule](../api/WithinTilemapBoundsRule/)   | `placement_rules/template_rules/within_tilemap_bounds_rule.gd`   | Ensures each indicator rests over a used tile in the target `TileMapLayer`.             | Returns success if there are zero indicators (nothing to validate).                              |
| [ValidPlacementTileRule](../api/ValidPlacementTileRule/)    | `placement_rules/template_rules/valid_placement_tile_rule.gd`    | (See file for exact logic) Validates indicator tiles against a tile validity condition. | Per‑tile [TileCheckRule](../api/TileCheckRule/) variant.                                                                |
| [SpendMaterialsRuleGeneric](../api/SpendMaterialsRuleGeneric/) | `placement_rules/template_rules/spend_materials_rule_generic.gd` | Generic resource‑spend gate (base for inventory integration).                           | Abstracted material spending.                                                                    |
| `SpendMaterialsRule`        | `grid_building_inventory/rules/spend_materials_rule.gd`          | Consumes items from an `ItemContainer` (inventory addon) once placement is confirmed.   | Builds a failure list of missing resources; `apply()` spends them.                               |
| [RuleCheckIndicator](../api/RuleCheckIndicator/)        | `placement/rule_check_indicator/rule_check_indicator.gd`         | (Support resource) Provides shape / tile position & validation for rules.               | Not a rule itself but central to tile checks.                                                    |

> Only classes present in the repository are listed. No speculative or future rule names are included.

## Validation Flow (Simplified)

```text
1. Indicators prepared & attached (via Indicator / Placement setup).
2. For each rule in configured order:
  rule.setup(params)  (once per preview change)
  result := rule.validate_placement()
  aggregate failure state & collect messages
3. If all results successful:
  for each rule: rule.apply() (side‑effects like spending materials)
4. On preview change / exit:
  rule.tear_down()
```

There is no global fatal short‑circuit flag built into the base class; each pipeline step decides whether to continue based on aggregated success.

## Key Behaviors by Rule

### CollisionsCheckRule

- Toggles behavior with `pass_on_collision` (expect overlap vs expect empty space).
- Temporarily overrides each indicator's `collision_mask` then restores it.
- Adds preview bodies as exceptions so a building never collides with itself.
- Reports counts (passed / failed / collision occurrences) at verbose log level.

### WithinTilemapBoundsRule

- Converts each indicator global position to tile coordinates on the target `TileMapLayer`.
- Success requires a valid tile (tile data present) for every indicator.
- Gracefully handles null / freed indicators with warnings (cleaned elsewhere).

### ValidPlacementTileRule

- Performs a tile validity test (consult file for exact assertion logic).
- Supplies messages for success/failure similar to the bounds rule.

### SpendMaterialsRule (Inventory Addon)

- Searches for an `ItemContainer` on the placer (or its children) that can hold all required item types.
- `validate_placement()` builds a missing item list; failure message enumerates deficits.
- `apply()` removes counted items (ensuring atomic resource deduction post‑success).

### SpendMaterialsRuleGeneric

- Underlying generic implementation invoked by specialized spend rules; provides shared messages / logic.

## Implementing a Custom Rule

1. Extend [PlacementRule](../api/PlacementRule/) or [TileCheckRule](../api/TileCheckRule/).
1. Export any configuration properties (messages, thresholds, masks).
1. In `setup(params)` call `super.setup(params)` first; return collected issue strings.
1. In `validate_placement()` guard with `if not guard_ready():` for robustness.
1. Return a [RuleResult](../api/RuleResult/) (never `null`). Keep messages concise & player‑oriented.
1. If you need side‑effects only on successful placement, override `apply()`.
1. Add the rule resource to your placement rule list (project settings, config resource, or placeable‑specific rule array).

## Indicator Visual Priority

When multiple [TileCheckRule](../api/TileCheckRule/) instances fail for the same tile, indicator appearance is selected by the failing rule with the highest `visual_priority` that provides `fail_visual_settings`. This centralizes which failure reason drives tile coloring.

## Logging & Diagnostics

Rules use the shared logger from `RuleValidationParameters`:

- Warnings for null / invalid indicators (should be rare; indicates cleanup race).
- Verbose summaries including pass/fail counts ([CollisionsCheckRule](../api/CollisionsCheckRule/), [WithinTilemapBoundsRule](../api/WithinTilemapBoundsRule/)).

Use these logs to confirm rule ordering and detect misconfigured masks or missing containers.

## Inventory Integration (SpendMaterialsRule)

To enable resource spending:

1. Add the Inventory addon (`addons/grid_building_inventory/`).
1. Create a `SpendMaterialsRule` resource and set `materials_to_spend` (array of `BaseItemStack`).
1. Ensure the placer (typically the player / controller node) or a child has an `ItemContainer` that `does_it_allow()` every item type required.
1. Add the rule to the active rule set. On successful placement, items are automatically deducted in `apply()`.

## Cross References

- [Collision Mapping](/v5-0/guides/collision_mapping/): Collision detection and mapping system
- [Indicator Setup Report](/v5-0/guides/indicator_setup_report/): Indicator configuration diagnostics
- [Isometric Implementation](/v5-0/guides/isometric-implementation/): Implementing Grid Building in isometric games (shapes, rotation, collision)
- [Building System Process](/v5-0/guides/building_system_process/): Complete building system workflow
- [Dependency Injection](/v5-0/guides/dependency_injection/): Dependency injection patterns

______________________________________________________________________

Support / Purchase Hub: **[Linktree – All Grid Builder Links](https://linktr.ee/gridbuilder)**
