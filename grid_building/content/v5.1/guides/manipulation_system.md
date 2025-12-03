---
title: Manipulation System
description: Manipulation System documentation for the Grid Building system
---


## Rotation & Variant Handling

### Grid-Aware Rotation System

The manipulation system features a **configurable grid-aware rotation system** that automatically handles complex transform hierarchies, particularly important for isometric games with skewed parent transforms.

**Rotation Increment Configuration:**

Rotation is controlled by `rotate_increment_degrees` in [ManipulationSettings](../api/ManipulationSettings/). The system supports any increment angle:

```gdscript
# ManipulationSettings configuration examples

# 4-direction (default): 90° increments - RTS-style
manipulation_settings.rotate_increment_degrees = 90.0

# 8-direction: 45° increments - isometric with diagonals
manipulation_settings.rotate_increment_degrees = 45.0

# 6-direction: 60° increments - hex-style grids
manipulation_settings.rotate_increment_degrees = 60.0

# 12-direction: 30° increments - fine-grained control
manipulation_settings.rotate_increment_degrees = 30.0

# 16-direction: 22.5° increments - high precision
manipulation_settings.rotate_increment_degrees = 22.5

# Custom: Any angle supported
manipulation_settings.rotate_increment_degrees = 15.0  # 24 directions
```

**Common Use Cases by Direction Count:**

| Directions | Increment | Best For |
|-----------|-----------|----------|
| 4-direction | 90° | Top-down games, simple RTS-style building, platformers |
| 6-direction | 60° | Hexagonal grid systems requiring rotation alignment |
| 8-direction | 45° | Isometric games with diagonal movement, enhanced placement variety |
| 12-direction | 30° | Advanced placement systems with fine rotation control |
| 16-direction | 22.5° | High-precision rotation, specialized building mechanics |
| Custom | Any angle | Game-specific rotation requirements |

**Grid-Aware Rotation Features:**

- **Transform Matrix Math**: Correctly handles complex parent hierarchies (rotation + skew) using transform matrices
- **Automatic Grid Snapping**: Snaps rotated objects to grid tile centers after rotation
- **Angle-Agnostic**: Transform math works correctly with any increment value
- **Isometric Support**: Properly accounts for skewed parent transforms in isometric projections
- **Return Value**: Returns rotation angle in degrees (0-360 range) for game logic integration

The system **never mutates the original resource**; it applies rotation through transforms passed to rule evaluation.

### Variant Changes

Variant changes (from the UI) trigger:

- Reset rotation (configurable – default: preserve rotation)
- Clear cached collision geometry (variant may have different shapes)
- Re‑evaluate rules immediately

## Interaction with Placement Chain

The Manipulation System produces a *placement context* consumed by the Placement Chain (`systems/placement_chain.md`):

- World position / snapped tile
- Active placeable & variant data
- Indicator collision setup
- Previously computed collision tiles (optional reuse)

The chain returns aggregated rule results which the Manipulation System maps to: indicator tint, tooltip text, can_place flag.

## Event Flow

| Trigger           | System Reaction                                                                                       |
| ----------------- | ----------------------------------------------------------------------------------------------------- |
| Selection changed | Reset state, build new preview indicator                                                              |
| Move cursor       | Rebuild test setup → rule pass → indicator update                                                     |
| Rotate (action)   | Adjust rotation → invalidate tiles → rule pass                                                        |
| Cycle variant     | Swap variant ref → invalidate tiles → rule pass                                                       |
| Confirm place     | If `can_place` true: emit placed event, persist structure, optionally keep preview (multi‑place mode) |
| Cancel            | Clear preview; state returns to idle                                                                  |

## Post-Placement Commands (Move / Demolish / Info)

The Manipulation System also mediates interactions with **existing** placed instances:

| Command  | High-Level Steps                                                                                                                                       | Notes                                                                     |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------- |
| Move     | Pick instance → capture its resource + state → enter move preview (same validation loop) → confirm to re‑instantiate at new location → remove original | Original instance remains until confirm; cancel restores without changes. |
| Demolish | Select instance → optional dependency / cost check → remove node + free resources → emit demolish event                                                | Can reuse rule pipeline for pre-removal constraints.                      |
| Info     | Hover/select → fetch [PlaceableInstance](../api/PlaceableInstance/) metadata → display UI panel / tooltip                                                                         | No rule validation; may highlight occupied tiles.                         |

State Transitions:

- Idle → Move: sets selected_placeable from instance, enters preview mode.
- Idle → Demolish: triggers removal path (no preview) or enters a confirm overlay state.
- Idle → Info: temporary highlight; state often stays Idle (non-exclusive).

Input Mapping Examples (conceptual – defined in [GBActions](../api/GBActions/)):

- `gb_move`
- `gb_demolish`
- `gb_info`

These actions integrate with the Placement Chain (see `systems/placement_chain.md#move--demolish--info-commands`) for shared validation & feedback when applicable.

## Automatic Cancellation & Cleanup

### 🛡️ Edge Case Protection

The manipulation system includes **automatic cancellation** to handle edge cases where the source object is deleted during an active manipulation:

**Scenario:** Player starts moving an object, but the original source node gets deleted (by external systems, gameplay events, or user actions) before the move is confirmed.

**Automatic Behavior:**
1. **Source Monitoring**: ManipulationSystem monitors the source object's `tree_exiting` signal during active manipulations
2. **Auto-Cancel**: When source deletion is detected, manipulation is automatically canceled
3. **Cleanup**: Preview copy is freed and manipulation state is reset
4. **Indicator Cleanup**: IndicatorManager listens to `manipulation.canceled` signal and automatically frees all active indicators

**Signal Flow:**
```
Source Node Deleted
  ↓
tree_exiting signal
  ↓
ManipulationSystem._on_source_tree_exiting()
  ↓
cancel() called → data.status = CANCELED
  ↓
ManipulationState.canceled signal emitted
  ↓
IndicatorManager._on_manipulation_canceled()
  ↓
Indicators freed, state cleaned up
```

**Benefits:**
- **No Orphaned Nodes**: Prevents preview copies and indicators from remaining in scene after source deletion
- **Consistent State**: Manipulation state automatically returns to idle
- **Signal-Based Architecture**: Decoupled cleanup via signals (IndicatorManager doesn't need direct ManipulationSystem references)
- **Defensive Programming**: Handles unexpected deletion scenarios gracefully

**Implementation Details:**
- Signal connection happens in `ManipulationSystem._start_move()` when manipulation begins
- Signal disconnection happens in `cancel()` to prevent memory leaks
- IndicatorManager connects to cancellation signal during initialization via dependency injection

This automatic cleanup ensures robust behavior even when game logic or external systems delete objects unexpectedly during manipulation operations.

## Performance Notes

- Per‑frame validation only active while previewing; system can suspend checks if the cursor hasn't moved and no rotation/variant change occurred (micro‑optimization).
- Cached tile map keyed by (variant_id, rotation, snapped_tile) can amortize rapid back‑and‑forth cursor motion.

## Extensibility

Add new interaction (e.g. scaling) by:

1. Extending [ManipulationSettings](../api/ManipulationSettings/) to hold scale steps
1. Injecting scale into test setup transform
1. Adjust rule evaluators that depend on size

## How Rotation & Indicators Work

### Polygon-Based Collision (Why It's Better Than AABB)

The system uses **polygon-based collision geometry** instead of axis-aligned bounding boxes (AABB) for indicator generation. This provides **rotation-independent tile calculations**.

**The AABB Problem:**
```
5x5 object at 0° → 25 tiles
5x5 object at 45° → 49 tiles (box expands diagonally!)
5x5 object at 90° → 25 tiles
```
AABB grows with rotation, causing inconsistent tile counts and confusing player experience.

**The Polygon Solution:**
```
5x5 object at 0° → 25 tiles
5x5 object at 45° → 25 tiles (same!)
5x5 object at 90° → 25 tiles (same!)
```
Uses actual collision shape geometry, providing consistent results regardless of rotation.

### Implementation: Normalize → Calculate → Display

```gdscript
# Step 1: Normalize for calculation (canonical geometry)
copy.rotation = 0.0  # Polygon maintains exact shape
calculate_tiles(copy)  # Always consistent count

# Step 2: Transfer rotation for display
ManipulationParent.rotation = original_rotation

# Step 3: Scene tree inheritance
# All child indicators automatically inherit rotation
```

**Key Benefit**: Calculate with canonical geometry, display with inherited transforms. Best of both worlds!

### Transform Inheritance Architecture

```
ManipulationParent (rotation=90°)
├── Preview Object       ← Inherits rotation automatically
└── IndicatorManager
    └── Indicators (25)  ← All inherit parent rotation
```

This ensures perfect alignment with zero manual synchronization code.

## Cross‑References

- Placement Rules Pipeline: `systems/placement_rules.md`
- Context & State Overview: `systems/context_and_state.md`
- Configuration & Settings: `systems/configuration_and_settings.md`
- Input & Actions: `systems/input_and_actions.md`
- Building System Process: `systems/building_system_process.md`
- **[Rotation Transfer Fix](./rotation-transfer-fix/)** - Critical fix for rotated object handling

______________________________________________________________________

Support / Purchase Hub: **[Linktree – All Grid Builder Links](https://linktr.ee/gridbuilder)**