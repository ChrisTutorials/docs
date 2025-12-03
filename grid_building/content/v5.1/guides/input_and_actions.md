---
title: Input Actions Configuration
description: Input Actions Configuration documentation for the Grid Building system
---


---

The plugin integrates with Godot's standard InputMap system. [GBActions](../api/GBActions/) is a simple resource containing **editable action names** that correspond to the input mappings configured in Godot's project settings.

## Overview

> **Refactored in v5.0.0**: Action names consolidated from scattered locations into centralized [GBActions](../api/GBActions/) resource.

There is **no custom input system** - the plugin simply responds to standard Godot input events through the InputMap. [GBActions](../api/GBActions/) provides a centralized location for these action name strings, making them easier to manage and customize.

## What GBActions Is

[GBActions](../api/GBActions/) is **not a system** - it's a simple configuration resource containing:

- **String constants** for action names (e.g., `"gb_select"`, `"gb_rotate"`)
- **Editable properties** that can be customized per project
- **Centralized location** for all input action names used by the plugin
- **Mapping to Godot's InputMap** configured in Project Settings → Input Map

## How It Works

1. **Plugin User Setup**: In Godot's Project Settings → Input Map, the user defines input actions
2. **GBActions Resource**: Contains string names matching the InputMap action names
3. **Systems Integration**: Multiple systems read from [GBActions](../api/GBActions/) to know which input actions to listen for:
   - [ManipulationSystem](../api/ManipulationSystem/): Mode switching (moving_mode, demolish_mode, info_mode, off_mode, confirm_build)
   - [ManipulationParent](../api/ManipulationParent/): Transform actions (rotate_left, rotate_right, flip_horizontal, flip_vertical)
   - [BuildingSystem](../api/BuildingSystem/): Build mode actions (build_mode, off_mode, confirm_build)
   - [GridPositioner2D](../api/GridPositioner2D/): Keyboard positioner movement (positioner_up/down/left/right/center) AND mouse movement tracking
   - [PlaceableSelectionUI](../api/PlaceableSelectionUI/): UI interaction actions
4. **Standard Godot Input**: All input handling uses Godot's built-in `Input.is_action_pressed()`, etc.

## Major Enhancements in v5.0.0

### 🏗️ **Architectural Improvements**
- **Centralized Action Names**: Action name strings refactored from scattered locations ([BuildingSystem](../api/BuildingSystem/), [ManipulationSystem](../api/ManipulationSystem/)) into [GBActions](../api/GBActions/) resource
- **Distributed Input Handling**: Transform input (rotate, flip) now handled by [ManipulationParent](../api/ManipulationParent/) directly, while mode switching remains in [ManipulationSystem](../api/ManipulationSystem/)
- **Easier Customization**: All input action names in one location for project-specific customization
- **Better Organization**: Clear separation between plugin action names and project input configuration

### 🔧 **Configuration Refactoring**
- **GBActions Resource**: **Refactored** (not new) - consolidates action name strings previously scattered across multiple systems
- **Editable Action Names**: Each action name is an exported property that can be customized
- **Project Integration**: Seamless integration with Godot's standard InputMap system

### 📊 **Action Categories**
- **Building Actions**: Core building mode controls (`gb_select`, `gb_cancel`, `gb_rotate`)
- **Manipulation Actions**: Move, rotate, flip, and demolish controls
- **Navigation Actions**: Grid targeting and camera controls
- **UI Actions**: User interface interaction controls

### ⌨️ Keyboard & Positioner Actions (New in v5.0.0)

v5 introduced explicit keyboard actions to nudge and recenter the grid positioner. These actions are defined on the [GBActions](../api/GBActions/) resource under the `Movement` group and are handled by the [GridPositioner2D](../api/GridPositioner2D/) implementation by default.

- `positioner_up` — Nudge the positioner up one step
- `positioner_down` — Nudge the positioner down one step
- `positioner_left` — Nudge the positioner left one step
- `positioner_right` — Nudge the positioner right one step
- `positioner_recenter` — Recenter the positioner to the viewport/camera center (snapped to the active grid)

These actions make keyboard-only movement possible and improve accessibility for users who prefer discrete keyboard positioning over mouse pointing.

Note: the default action names are stored in `res://templates/grid_building_templates/resources/settings/actions/action_settings_template.tres` (a [GBActions](../api/GBActions/) resource). Update those strings or your project's InputMap to change bindings.

### 🐛 **Debugging & Testing**
- **Action Name Validation**: Easier to debug input issues with centralized action names
- **Project Customization**: Clear documentation of which actions need InputMap configuration
- **Consistency Checking**: All systems use the same action name references

## Core Actions (Proposed)

| Action Name             | Default Binding (Example) | Purpose                                        |
| ----------------------- | ------------------------- | ---------------------------------------------- |
| `gb_select`             | Left Mouse Button         | Pick placeable / confirm placement             |
| `gb_cancel`             | Right Mouse Button / Esc  | Cancel preview / exit mode                     |
| `gb_rotate`             | R key / Mouse Wheel Click | Rotate active preview                          |
| `gb_cycle_variant_next` | E / Mouse Wheel Up        | Next variant in sequence                       |
| `gb_cycle_variant_prev` | Q / Mouse Wheel Down      | Previous variant                               |
| `gb_toggle_mode`        | Tab                       | Cycle build modes (build / demolish / inspect) |
| `gb_multi_place_toggle` | M                         | Enable/disable multi‑place session             |

(Adapt these to actual project actions if already defined.)

## Setup Process

### 1. Configure InputMap
In Godot's **Project Settings → Input Map**, add these actions:
- `gb_select` → Left Mouse Button
- `gb_cancel` → Right Mouse Button / Escape
- `gb_rotate` → R key
- etc.

### 2. Customize GBActions (Optional)
Edit the [GBActions](../api/GBActions/) resource to change action names if needed:
```gdscript
@export var select_action: String = "my_custom_select"  # Instead of "gb_select"
```

### 3. Systems Integration
Multiple systems read from [GBActions](../api/GBActions/) to know which input actions to listen for:
- **ManipulationSystem**: Mode switching actions (moving_mode, demolish_mode, info_mode, off_mode, confirm_build)
- **ManipulationParent**: Transform actions (rotate_left, rotate_right, flip_horizontal, flip_vertical) - handles input directly via `_unhandled_input()`
- **BuildingSystem**: Build mode actions (build_mode, off_mode, confirm_build)
- **GridPositioner2D**: Keyboard positioner movement (positioner_up/down/left/right/center) AND mouse movement tracking
- **PlaceableSelectionUI**: UI interaction actions
- **All input handling**: Uses standard Godot `Input.is_action_pressed(actions.action_name)`

## Action Flow Architecture

### Input Event Processing
**Flow: Raw Input Event → Godot InputMap → GBActions Resource → Multiple Systems → State Update → UI/Visual Feedback**

The input handling is distributed across multiple systems based on responsibility:
- **Mode switching** (moving_mode, demolish_mode, etc.): Handled by [ManipulationSystem](../api/ManipulationSystem/)
- **Transform actions** (rotate, flip): Handled by [ManipulationParent](../api/ManipulationParent/) via `_unhandled_input()`
- **Build actions** (build_mode, confirm_build): Handled by [BuildingSystem](../api/BuildingSystem/) and [DragManager](../api/DragManager/)
- **Positioner movement**: Handled by [GridPositioner2D](../api/GridPositioner2D/) - both keyboard (positioner_up/down/left/right/center) and mouse tracking

### Key Points
- **No custom input system** - pure Godot InputMap integration
- **GBActions is just a string container** - editable action name references
- **Systems read action names** from GBActions resource at runtime
- **Plugin user configures** the actual key bindings in Godot's InputMap
- **Distributed responsibility**: Each system handles input relevant to its domain

## Handling Flow

1. Input event received through Godot's standard input system
2. Multiple systems check for relevant actions:
   - [ManipulationSystem](../api/ManipulationSystem/): `Input.is_action_pressed(GBActions.moving_mode)` for mode switching
   - [ManipulationParent](../api/ManipulationParent/): `Input.is_action_pressed(GBActions.rotate_left)` for transforms
   - [BuildingSystem](../api/BuildingSystem/): `Input.is_action_pressed(GBActions.build_mode)` for building
   - [GridPositioner2D](../api/GridPositioner2D/): `Input.is_action_pressed(GBActions.positioner_up)` for keyboard movement, plus mouse motion events for mouse tracking
3. Each system processes the input and updates relevant state
4. UI updates automatically through signals

### Positioner movement changes in v5.0.0

Movement responsibility for the positioner has shifted in v5: the [GridPositioner2D](../api/GridPositioner2D/) now owns movement (keyboard and mouse handling) and includes a default movement implementation in its script (`grid_positioner_2d.gd`). Previously, mouse movement and cursor-to-grid translation were handled by [GridTargetingSystem](../api/GridTargetingSystem/); those responsibilities have been relocated into the positioner implementation.

What this means for you:

- Prefer using [GridPositioner2D](../api/GridPositioner2D/) (the provided [GridPositioner2D](../api/GridPositioner2D/) script) as your positioner node so that keyboard nudging, recentering, and mouse movement behave as expected by default.
- If you use a custom positioner node (not [GridPositioner2D](../api/GridPositioner2D/)), you must implement the movement logic yourself (for example, handle the `positioner_*` actions or mouse movement and call the positioner's API to update the grid position).
- Tests and demo scenes assume a [GridPositioner2D](../api/GridPositioner2D/) node with its script attached; reusing the provided template scenes is the simplest upgrade path.

Practical checklist:

- Ensure your [GBConfig](../api/GBConfig/) / composition container provides a [GBActions](../api/GBActions/) resource with the `positioner_*` actions defined and that your InputMap binds keys for them.
- Use the template [GridPositioner2D](../api/GridPositioner2D/) from `res://templates/grid_building_templates/` or call `GridPositioner2D.new()` and configure its collision shape to match your grid.
- If you rely on mouse-only movement and don't want the positioner to track mouse input, disable mouse movement in the [GridTargetingSettings](../api/GridTargetingSettings/) (see `GBConfig.settings.targeting`).

## Event Guarding

During preview:
- Confirm suppressed if `can_place` false
- Rotate / variant cycling allowed even when invalid
- Cancel always available

## Multi‑Place Mode

If enabled, after a successful placement the preview remains active; selection persists. Exiting requires explicit cancel or mode switch.

## Mouse vs Keyboard Cohesion

Variant cycling supports both dedicated keys and mouse wheel for rapid iteration. Ensure the InputMap binds both for accessibility.

## Input Feedback

Invalid actions (e.g. confirm when invalid) should produce subtle feedback:
- Flash invalid indicator color
- Optional tooltip / message via [GBMessages](../api/GBMessages/)

## Cross‑References

- Manipulation System: `systems/manipulation_system.md`
- Configuration & Settings (Actions list resource): `systems/configuration_and_settings.md`
- Placeable Selection UI: `systems/placeable_selection_ui.md`

______________________________________________________________________

Community & Purchase Hub: **[Linktree – All Grid Builder Links](https://linktr.ee/gridbuilder)**
