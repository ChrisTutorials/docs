---
title: Configuration & Settings
description: Configuration & Settings documentation for the Grid Building system
---


---


All tunable behavior is consolidated into a structured configuration resource hierarchy rooted at **[GBConfig](../api/GBConfig/)**.

## Goals

- Single injection point (DI) for systems needing settings
- Clear separation between *game design knobs* and *runtime state*
- Support for future serialization & profile overrides

## Major Enhancements in v5.0.0

### 🏗️ **Architectural Improvements**
- **Unified Configuration System**: Complete consolidation of all settings in [GBConfig](../api/GBConfig/) resource
- **Dependency Injection Integration**: Full integration with [GBCompositionContainer](../api/GBCompositionContainer/) for better decoupling
{/* Supports 4.5 as well. Minimum 4.4+. */}
- **Enhanced Hot Reload**: Better support for runtime configuration changes

### 🔧 **Configuration Enhancements**
- **GBConfig Consolidation**: All configuration now centralized in single root resource
- **Enhanced Access Patterns**: More efficient configuration access with better caching
- **Improved Validation**: Better editor-time validation and error reporting
- **Migration Support**: Automatic migration from v4.x configuration structures

### 📊 **New Configuration Categories**
- **Enhanced [GBActions](../api/GBActions/)**: More comprehensive input action definitions
- **Improved [GBSettings](../api/GBSettings/)**: Better organization of general settings and knobs
- **Advanced [GBVisualSettings](../api/GBVisualSettings/)**: Enhanced visual configuration with theme support
- **Better [ManipulationSettings](../api/ManipulationSettings/)**: More detailed manipulation configuration options

### 🐛 **Debugging & Tooling**
- **Configuration Debugging**: Better support for inspecting configuration during development
- **Enhanced Validation**: More comprehensive editor-time validation
- **Migration Tools**: Automated tools for upgrading from v4.x configurations
- **Performance Monitoring**: Built-in configuration performance tracking

## Configuration Hierarchy (Conceptual)

```
GBConfig
  ├── GBActions            (input action names)
  ├── GBSettings           (general numeric / boolean knobs)
  │     ├── grid_size_px
  │     ├── placement_epsilon
  │     ├── multi_place_enabled
  │     └── ...
  ├── GBTemplates          (paths / resource refs to common scene templates)
  ├── GBVisualSettings     (colors, indicator styles, animation speeds)
  ├── ManipulationSettings (rotation step, snap toggle, message strings)
  ├── ActionLogSettings    (UI display messages, action log configuration)
  └── (Future) RuleSettings (per rule thresholds)
```

## Access Pattern

Systems receive a [GBConfig](../api/GBConfig/) reference during construction (DI). They **do not store individual primitive values**; they store references to the resolved [Resource](https://docs.godotengine.org/en/stable/classes/class_resource.html) subclasses (e.g. [BuildingSettings](../api/BuildingSettings/)).
There are some exceptions to this like [RuleCheckIndicator](../api/RuleCheckIndicator/) which saves a direct reference to the [IndicatorVisualSettings](../api/IndicatorVisualSettings/) to allow for multiple templates within a [GBCompositionContainer](../api/GBCompositionContainer/) to have different visual styles
or to display different image texture sizes.

## Key Settings

| Setting                   | Typical | Purpose                                                   |
| ------------------------- | ------- | --------------------------------------------------------- |
| `grid_size_px`            | 16      | Base tile dimension (square)                              |
| `placement_epsilon`       | 0.05    | Fractional tile area threshold (collision mapping)        |
| `rotation_step_deg`       | 90      | Rotation snap increment                                   |
| `multi_place_enabled`     | true    | Keep preview active after confirm                         |
| `indicator_default_shape` | Rect    | Shape used when placeable lacks explicit preview geometry |
| `indicator_valid_color`   | #00d084 | Positive feedback color                                   |
| `indicator_invalid_color` | #ff4d4f | Failure tint color                                        |

## Actions vs Settings

Input action names live in [GBActions](../api/GBActions/) so changing a binding (e.g. `rotate_item`) requires editing only one resource; systems reference the symbolic name.

## Setting Up Input Actions

The plugin requires specific input actions to be configured in your project's **InputMap** (Project → Project Settings → Input Map). While the plugin validates these actions exist, you must add them manually.

### Required Mode Control Actions

Add these actions to your InputMap for basic mode switching:

<DataTable 
  columns={[
    { key: 'action', label: 'Action', width: '180px', nowrap: true },
    { key: 'description', label: 'Description' },
    { key: 'suggestedKey', label: 'Suggested Key', nowrap: true }
  ]}
  rows={[
    { action: 'info_mode', description: 'Info/inspection mode', suggestedKey: '1 (Number key)' },
    { action: 'build_mode', description: 'Build/placement mode', suggestedKey: '2 (Number key)' },
    { action: 'moving_mode', description: 'Move/manipulation mode', suggestedKey: '3 (Number key)' },
    { action: 'demolish_mode', description: 'Demolish mode', suggestedKey: '4 (Number key)' },
    { action: 'off_mode', description: 'Exit all modes', suggestedKey: 'Escape' }
  ]}
  firstColumnCode={true}
  emphasisColumn="suggestedKey"
></DataTable>

### Required Building Actions

<DataTable 
  columns={[
    { key: 'action', label: 'Action', width: '180px', nowrap: true },
    { key: 'description', label: 'Description' },
    { key: 'suggestedKey', label: 'Suggested Key', nowrap: true },
    { key: 'requiredWhen', label: 'Required When' }
  ]}
  rows={[
    { action: 'confirm', description: 'Confirm placement', suggestedKey: 'Left Mouse Button or Enter', requiredWhen: 'Always required' },
    { action: 'rotate_right', description: 'Rotate clockwise', suggestedKey: 'E', requiredWhen: 'Only if using manipulatable objects with rotation' },
    { action: 'rotate_left', description: 'Rotate counter-clockwise', suggestedKey: 'Q', requiredWhen: 'Only if using manipulatable objects with rotation' },
    { action: 'flip_horizontal', description: 'Flip horizontally', suggestedKey: 'F', requiredWhen: 'Only if using manipulatable objects with flipping' },
    { action: 'flip_vertical', description: 'Flip vertically', suggestedKey: 'V', requiredWhen: 'Only if using manipulatable objects with flipping' }
  ]}
  firstColumnCode={true}
  emphasisColumn="suggestedKey"
></DataTable>

### Keyboard Grid Navigation (Optional)

For keyboard-based grid cursor control, add these actions. **Note:** These are only required if you want players to navigate the grid using keyboard input instead of mouse-only interaction.

<DataTable 
  columns={[
    { key: 'action', label: 'Action', width: '200px', nowrap: true },
    { key: 'description', label: 'Description' },
    { key: 'suggestedKey', label: 'Suggested Key', nowrap: true }
  ]}
  rows={[
    { action: 'positioner_up', description: 'Move cursor up', suggestedKey: 'W or Arrow Up' },
    { action: 'positioner_down', description: 'Move cursor down', suggestedKey: 'S or Arrow Down' },
    { action: 'positioner_left', description: 'Move cursor left', suggestedKey: 'A or Arrow Left' },
    { action: 'positioner_right', description: 'Move cursor right', suggestedKey: 'D or Arrow Right' },
    { action: 'positioner_center', description: 'Center cursor', suggestedKey: 'C' }
  ]}
  firstColumnCode={true}
  emphasisColumn="suggestedKey"
></DataTable>

### Adding Actions via Project Settings

1. Open **Project → Project Settings**
2. Navigate to the **Input Map** tab
3. For each action:
   - Type the action name (e.g., `build_mode`) in the "Add New Action" field
   - Click "Add"
   - Click the "+" button next to the action to add a key binding
   - Press the desired key (e.g., "2" for build_mode)
   - Click "OK"

{{< gb-note type="tip" title="Action Validation" >}}
The plugin automatically validates that all required actions exist at runtime. If any are missing, you'll see warnings in the console with the exact action names that need to be added.
{{< /gb-note >}}

## Templates & Resources

[GBTemplates](../api/GBTemplates/) centralizes packed scenes / resources (e.g. default indicator scene, selection UI prefab). This avoids scattering hard‑coded `load()` paths across systems.

## Visual Settings

Color & UI style values are grouped for consistent theming. Indicator style (line thickness, alpha) is referenced both by preview node and any rule overlays.

## Validation & Tooling

An editor script can assert on load:

- All required actions exist in the project's `InputMap`
- All template paths resolve
- Epsilon within sane bounds (0 < epsilon < 0.5)

Failing fast prevents subtle runtime errors.

## Extensibility

To add a new setting category:

1. Create a new `Resource` subclass (e.g. `GBRuleSettings`)
1. Add exported fields
1. Reference it from [GBConfig](../api/GBConfig/)
1. Add accessor helpers or pass full config as before

## Cross‑References

- Input & Actions: `systems/input_and_actions.md`
- Manipulation System: `systems/manipulation_system.md`
- Placement Rules: `systems/placement_rules.md`
- Collision Mapping: `systems/collision_mapping.md`

______________________________________________________________________

Support / Purchase Hub: **[Linktree – All Grid Builder Links](https://linktr.ee/gridbuilder)**