---
title: UI Selection Components
description: Documentation for placeable selection UI components including list and grid layouts
---


---

> Status: Stable - Recently enhanced with fixed view height, fixed icon size, and improved usability

This document describes the new UI components that replace the basic `ItemList`-driven placeable selection with a richer, extensible system supporting variant cycling via left/right arrows.

## Recent Improvements (v5.0.0)

The placeable view UI has been enhanced with several usability improvements:

- **Fixed View Height**: Consistent list height prevents layout shift during variant cycling
- **Fixed Icon Size**: Icons maintain consistent size across all variants for visual stability  
- **Improved Usability**: Enhanced keyboard navigation and visual feedback
- **Better Theming**: Refined cyan/magenta dark UI palette integration
- **Simplified Grid Architecture**: Grid containers now created programmatically (no separate template scene needed)
- **Flexible Grid Layouts**: Configurable column counts (1-10 columns) for different UI styles
- **Tab Header Sizing**: Automatic 32px icon constraint prevents oversized tab headers

## PlaceableSelectionUI Configuration (v5.0.0)

### Grid Layout Properties

**`grid_columns`** (int, default: 1)
- Number of columns for the grid layout
- Range: 1-10
- **Default: 1** creates single-column vertical list (typical for most games)
- Set to 2-3 for compact grid layout (optional, as used in some demos)

```gdscript
var selection_ui = PlaceableSelectionUI.new()
selection_ui.grid_columns = 1  # Single column (default)
# selection_ui.grid_columns = 3  # Or 3-column grid for compact layout
```

### Sizing Properties

**`fixed_template_height`** (int, default: 48)
- Fixed height for all templates to prevent resizing during variant cycling
- Set to 0 to disable height enforcement and allow natural sizing

**`fixed_icon_size`** (int, default: 40)
- Fixed icon size for all placeable view icons within grid items
- Ensures consistent icon dimensions across variants
- Set to 0 to use template defaults

### Visual Properties

**`show_category_tab_names`** (bool, default: true)
- Controls visibility of category tab text labels
- When `false`: Tabs show only icons (compact mode, as in platformer demo)
- When `true`: Tabs show both icons and text labels (as in top-down and isometric demos)

**Tab Header Icon Sizing**
- Tab icons are automatically constrained to 32px width via theme override
- Prevents oversized tab headers when using large sprites as category icons
- Icons scale down proportionally if source images are larger than 32px

### Demo Configurations

**Default Configuration (Typical):**
```gdscript
grid_columns = 1  # Single-column list (default)
fixed_template_height = 48
fixed_icon_size = 40
show_category_tab_names = true  # Icons + text
```

**Compact Grid Layout (Optional):**
Some demos use a 3-column grid for more compact UI:

```gdscript
grid_columns = 3  # 3-column grid (compact)
fixed_template_height = 48
fixed_icon_size = 40
show_category_tab_names = false  # Icons only for space savings
```

**Note:** The platformer demo uses compact mode (`show_category_tab_names = false`) for space efficiency, while top-down and isometric demos show full tab labels.

## Simplified Grid Architecture (v5.0.0)

Previous versions used a separate `grid_template` PackedScene for the grid container. This has been simplified in v5.0.0:

**Old Approach (pre-v5.0.0):**
```gdscript
@export var grid_template : PackedScene  # Separate scene file required
var grid = grid_template.instantiate()
```

**New Approach (v5.0.0):**
```gdscript
@export_range(1, 10, 1) var grid_columns : int = 1
var grid = GridContainer.new()
grid.columns = grid_columns
grid.add_theme_constant_override("h_separation", 8)
grid.add_theme_constant_override("v_separation", 8)
```

**Benefits:**
- Simpler architecture - no separate template scene needed
- Easier configuration - just set `grid_columns` property
- More flexible - change column count per instance without creating new template scenes
- Less file management overhead

## Goals

- Provide a flexible per-entry layout (icon, name, variant index, navigation arrows)
- Support *variant sequences* (e.g. different visual styles or upgrade tiers) under a single selectable slot
- Clean keyboard & mouse navigation
- Theming consistent with the cyan/magenta dark UI palette
- Configurable grid layouts with 1-10 columns
- Per-demo customization of tab visibility and sizing

## Components Overview

### PlaceableSequence (Resource)

Groups an ordered list of placeable-like resources (each expected to expose `display_name` and optional `icon`).

Fields:

- `display_name: String` – Label for the whole sequence (used when variant elements lack a name)
- `placeables: Array[Resource]` – Ordered variants
- `icon: Texture2D (optional)` – Representative icon if you want a static image (falls back to first variant's icon)

Utility methods:

- `count() -> int`
- `get_variant(index: int) -> Resource`
- `variant_display_name(index: int) -> String`

### PlaceableListEntry (PanelContainer)

Single UI row representing a [PlaceableSequence](../api/PlaceableSequence/).

Features:

- Displays active variant icon & name
- Variant index label (e.g. `2/3`) when more than one
- Left/Right arrow buttons (hidden if `count() <= 1`)
- Keyboard: Left / Right to cycle variants; Enter / Space or mouse click selects
- Emits:
  - `selected(entry)`
  - `variant_changed(entry, variant_index)`

### [PlaceableList](../api/PlaceableList/) (Control)

Scrollable container managing multiple [PlaceableListEntry](../api/PlaceableListEntry/) instances.

Features:

- Vertical navigation with Up / Down keys
- Maintains selection state & highlight
- Emits `selection_changed(entry)` when selection or active variant (of selected) changes
- API:
  - `add_sequence(sequence: PlaceableSequence)`
  - `clear()`
  - `get_selected_entry()`

### Demo Scene

`res://templates/grid_building_templates/ui/placement_selection/placeable_list_demo.tscn` populates several sequences (some with a single variant, others with three) to demonstrate behavior.

## Usage Example

```gdscript
var seq := PlaceableSequence.new()
seq.display_name = "Wall Segments"
for i in 4:
    var variant := load("res://placeables/wall_variant_%d.tres" % i)
    seq.placeables.append(variant)
placeable_list.add_sequence(seq)
```

React to selection:

```gdscript
placeable_list.selection_changed.connect(func(entry):
    var active_variant = entry._active_object() # internal helper; expose wrapper if needed
    # Use active_variant to drive preview/build
)
```

## Design Notes

Why not extend [Placeable](../api/Placeable/)? Keeping [PlaceableSequence](../api/PlaceableSequence/) separate avoids changing existing placement validation paths (each variant is still a normal placeable resource). The sequence groups them only for UI selection convenience.

Why not `ItemList`? We need per-row controls (arrows) and custom layout + theming per entry which `ItemList` does not support without hacks.

## Keyboard & Accessibility

- Initial selection auto-focuses first entry
- Up/Down traverse entries
- Left/Right only act on currently focused entry to change its variant
- Entry `tooltip_text` reflects variant status: `Name (Variant 2/3)`

## Extensibility Ideas

Future enhancements (not implemented yet):

- Drag & drop reordering within a sequence
- Favorite pinning & filtering
- Persist last chosen variant per sequence in player profile
- Search box above the list

\\n## Theming
Each entry uses dynamic `StyleBoxFlat` overrides for normal/selected states. Integrate with a global theme by replacing these overrides or injecting a custom style via a factory method later.

## Integration Steps

1. Replace existing ItemList usage in [PlaceableSelectionUI](../api/PlaceableSelectionUI/) with [PlaceableList](../api/PlaceableList/) node.
1. Wrap all single placeables into sequences of length 1 (helper factory recommended).
1. On selection change, resolve active variant to feed existing placement preview flow (no rule changes required).

\\n## Helper Factory (Suggested)
(Not yet implemented) A small utility that takes an Array of [Placeable](../api/Placeable/) or `Array[PlaceableSequence|Placeable]` and returns only sequences (wrapping singles). This reduces UI wiring code.

```gdscript
static func normalize_sequences(items: Array) -> Array[PlaceableSequence]:
    var out: Array[PlaceableSequence]
    for it in items:
        if it is PlaceableSequence:
            out.append(it)
        elif it is Placeable:
            var seq := PlaceableSequence.new()
            seq.display_name = it.display_name
            seq.placeables.append(it)
            out.append(seq)
    return out
```

## Validation & Edge Cases

- Empty sequence: arrows hidden; entry still selectable (might represent a placeholder). Consider preventing empty sequences in production builds.
- Null icons: entry reserves icon space for alignment consistency.
- Rapid variant cycling: stateless; no debounce needed unless variant load is heavy.

## Migration Checklist

- [ ] Add sequences wrapping for all existing placeables
- [ ] Replace old selection signal binding with new `selection_changed`
- [ ] Update any tests referencing the UI list to accept sequences
- [ ] Add factory utility if repetition appears

______________________________________________________________________

Last Updated: 2025-08-09