---
title: Grid Targeting
description: Grid Targeting documentation for Grid Building system
---


---

> Overview of the Grid Targeting subsystem and how cursor positions map to grid coordinates.

This page introduces the Grid Targeting subsystem used by the building workflow and explains how mouse/viewport positions become snapped grid coordinates other systems can use.

- API: [GridTargetingSystem](../api/GridTargetingSystem/)
- Related: [GridTargetingState](../api/GridTargetingState/), [GridPositioner2D](../api/GridPositioner2D/), [GridTargetingSettings](../api/GridTargetingSettings/)

## What it does

Grid Targeting is responsible for turning pointer input into a stable, snapped target that the building and validation pipelines can consume.

**v5.0.0 Architectural Improvement:** Clear separation between positioning and targeting:
- **GridPositioner2D**: Pure input handling & positioning
- **TargetingShapeCast2D**: Dedicated collision detection
- **[IndicatorManager](../api/IndicatorManager/)**: Visual feedback & validation

**Core Responsibilities:**
- Convert viewport/world coordinates to grid-space
- Apply snapping rules (cell, edge, corner) and epsilon filtering to avoid flicker at boundaries
- Expose the current target info for other systems (validation, indicators, placement)

See also: [Building System Process](./building_system_process/)

## Data flow

1. Input is sampled from the active viewport (mouse/touch position)
2. [GridTargetingSystem](../api/GridTargetingSystem/) computes a target using [GridPositioner2D](../api/GridPositioner2D/) and settings from [GridTargetingSettings](../api/GridTargetingSettings/)
3. Resulting target info is stored in [GridTargetingState](../api/GridTargetingState/)
4. Downstream systems consume it:
	- Indicators highlight the hovered cell(s)
	- Placement validation evaluates rules against the target
	- Building system uses it to place or preview objects

## Position calculation basics

- World position → grid coords: sampling the world-space cursor and converting to integer cell coordinates based on configured cell size/origin.
- Snapping modes: center-of-cell, edge-aligned, or corner-snapping depending on your chosen settings.
- Epsilon filtering: small movement within a cell won’t constantly resignal target changes; this prevents UI flicker.

{{< gb-note type="tip" >}}
Use [GridTargetingSettings](../api/GridTargetingSettings/) to fine-tune snapping behavior and epsilon values for your specific game requirements.
{{< /gb-note >}}

## Consuming the current target

Most systems don’t compute targeting directly—they read it from state or receive updates.

- Poll model/state: read the latest target info from [GridTargetingState](../api/GridTargetingState/)
- Event-driven: connect to target update signals emitted by your coordination layer
- Render-time: indicators query the state and render highlights for hovered cells

Typical consumers:

- Validation/Rules: evaluate [PlacementValidator](../api/PlacementValidator/) with the current target
- Indicators: [TargetHighlighter](../api/TargetHighlighter/) and related components
- UI: hover tooltips or debug text using [GridTargetingDebugText](../api/GridTargetingDebugText/)
- **Object Info Display**: [TargetInformer](../api/TargetInformer/) shows information about targeted and manipulated objects

## TargetInformer UI Component (v5.0.0+)

The [TargetInformer](../api/TargetInformer/) is a dynamic UI component that displays object information with intelligent priority handling across different game states.

### Features

- **Responsive to Targeting**: Shows info immediately when hovering over objects via `GridTargetingState.target_changed` signal
- **Manipulation Priority**: Automatically switches to show manipulated objects when manipulation is active
- **Building Preview**: Displays info for building preview objects during placement
- **Graceful Fallbacks**: Handles missing settings and null targets without errors

### Priority System

The TargetInformer implements a three-tier priority system:

| Priority | Context | Signal Source | Use Case |
|----------|---------|--------------|----------|
| **1. Highest** | Manipulation | `ManipulationState.active_target_node_changed` | Shows info for objects being moved/demolished |
| **2. Middle** | Building | `BuildingState.preview_changed` | Shows info for building preview objects |
| **3. Lowest** | Targeting | `GridTargetingState.target_changed` | Shows info for hovered objects (passive targeting) |

**Example Behavior:**
```gdscript
# Scenario 1: Just hovering over objects
# Player moves mouse over smithy → TargetInformer shows "Smithy" info

# Scenario 2: Start manipulation
# Player selects smithy for move → TargetInformer switches to show manipulation info

# Scenario 3: Hover another object while manipulating
# Player hovers over house while still moving smithy
# TargetInformer STAYS on smithy (manipulation has priority)

# Scenario 4: End manipulation
# Player completes move → TargetInformer returns to showing hovered object
```

### Setup

The TargetInformer connects automatically to all required signals when you call `resolve_gb_dependencies()`:

```gdscript
var informer = TargetInformer.new()
informer.info_parent = Control.new()  # Container for info labels
add_child(informer)
informer.add_child(informer.info_parent)

# Connect to composition container
informer.resolve_gb_dependencies(composition_container)
# Now responds to targeting, manipulation, and building state changes
```

### Configuration

The TargetInformer uses [TargetInfoSettings](../api/TargetInfoSettings/) for display formatting:

```gdscript
# These settings are typically configured in your GBSettings resource
target_info.position_format = "Position: (%s, %s)"
target_info.position_decimals = 2

# The TargetInformer automatically uses these settings when available
# Falls back to default formatting if settings are null
```

### Integration with Info Mode

The TargetInformer works seamlessly with the Info mode toggle:

```gdscript
# When mode changes to INFO
mode_state.current = GBEnums.Mode.INFO
# TargetInformer becomes visible (if mode_state is connected)

# When mode changes to OFF
mode_state.current = GBEnums.Mode.OFF  
# TargetInformer hides automatically
```

### Custom Object Names

Override `_to_string()` on your object nodes to customize the display name:

```gdscript
# On your placeable object script
func _to_string() -> String:
	return "Smithy (Level 2)"  # Shows in TargetInformer
```

{{< gb-note type="tip" title="Best Practice" >}}
Connect the TargetInformer early in your scene setup (usually in `_ready()`) so it's ready to respond to targeting changes immediately when the game starts.
{{< /gb-note >}}

## Configuration

Use [GridTargetingSettings](../api/GridTargetingSettings/) to control:

- Cell size and origin
- Snapping mode and tolerance (epsilon)
- Edge/corner behavior for non-centered snapping

These settings are typically provided via your composition container and shared with the [GridPositioner2D](../api/GridPositioner2D/).

## Debugging and validation

- Visualize: enable an indicator layer to color the active cell and neighbors.
- Inspect text: add [GridTargetingDebugText](../api/GridTargetingDebugText/) to render current cell, world pos, and snap mode.
- Validate: run your rule set through [PlacementValidator](../api/PlacementValidator/) using the current target to confirm expected acceptance/rejection.

## Visibility Behavior

The Grid Targeting system controls when the positioner is visible based on multiple interaction factors:

### Basic Visibility Rules

1. **Mouse Input Enabled**: When `enable_mouse_input` is `true`, positioner follows mouse and respects all visibility settings
2. **Mouse Input Disabled**: When `enable_mouse_input` is `false`, positioner operates without mouse interaction and ignores mouse-specific visibility rules

### Hide on Handled Behavior

The `hide_on_handled` setting provides smart visibility management:

| Mouse Input | hide_on_handled | UI Element Hovered | Positioner Visible |
|-------------|-----------------|-------------------|-------------------|
| ✅ Enabled  | ✅ true         | ❌ No              | ✅ Yes            |
| ✅ Enabled  | ✅ true         | ✅ Yes             | ❌ No (hidden)    |
| ✅ Enabled  | ❌ false        | ❌ No              | ✅ Yes            |
| ✅ Enabled  | ❌ false        | ✅ Yes             | ✅ Yes (visible)  |
| ❌ Disabled | ✅ true         | Any               | ✅ Yes (ignores UI) |
| ❌ Disabled | ❌ false        | Any               | ✅ Yes            |

### Practical Examples

```gdscript
# Example 1: Mouse-driven with auto-hide
settings.enable_mouse_input = true
settings.hide_on_handled = true
# Result: Positioner follows mouse, hides when hovering UI elements

# Example 2: Keyboard-only mode
settings.enable_mouse_input = false
settings.hide_on_handled = true  # This setting is ignored
# Result: Positioner stays visible, controlled by keyboard/code

# Example 3: Always visible mode
settings.enable_mouse_input = true
settings.hide_on_handled = false
# Result: Positioner follows mouse, always visible even over UI
```

## Related reading

- [Building System Process](./building_system_process/)
- [Placement Chain](./placement_chain/)