---
title: "PlaceableListEntry"
description: "Rich, keyboard- and mouse-friendly list entry for selecting a Placeable or sequence variant.
Purpose:
- Drop-in UI cell meant to replace a plain ItemList row with a richer control
that shows an icon, name, and optional variant index with left/right arrows.
- Works either with a single placeable Resource or with a sequence of variants
(for example a PlaceableSequence containing multiple Placeable resources).
Key Features:
- Emits Selected when the user clicks or presses Enter/Space.
- Emits VariantChanged when cycling variants via arrow buttons or Left/Right keys.
- Provides public getters so documentation and examples never rely on private helpers:
- GetActivePlaceable() returns the currently active resource in this entry.
- GetActiveVariantIndex() returns the active variant index.
- GetActiveDisplayName() resolves a display name from the active object.
Input and Accessibility:
- Mouse: left click selects; on-screen left/right buttons cycle variants.
- Keyboard: when focused, Left/Right cycle variants; Enter/Space select.
Data requirements:
- The active object should provide a DisplayName string and optional Icon Texture2D.
- When sequence is used, it should expose Count() and GetVariant(index)."
weight: 20
url: "/gridbuilding/v6-0/api/godot/placeablelistentry/"
---

# PlaceableListEntry

```csharp
GridBuilding.Godot.Systems.UI.Placeable
class PlaceableListEntry
{
    // Members...
}
```

Rich, keyboard- and mouse-friendly list entry for selecting a Placeable or sequence variant.
Purpose:
- Drop-in UI cell meant to replace a plain ItemList row with a richer control
that shows an icon, name, and optional variant index with left/right arrows.
- Works either with a single placeable Resource or with a sequence of variants
(for example a PlaceableSequence containing multiple Placeable resources).
Key Features:
- Emits Selected when the user clicks or presses Enter/Space.
- Emits VariantChanged when cycling variants via arrow buttons or Left/Right keys.
- Provides public getters so documentation and examples never rely on private helpers:
- GetActivePlaceable() returns the currently active resource in this entry.
- GetActiveVariantIndex() returns the active variant index.
- GetActiveDisplayName() resolves a display name from the active object.
Input and Accessibility:
- Mouse: left click selects; on-screen left/right buttons cycle variants.
- Keyboard: when focused, Left/Right cycle variants; Enter/Space select.
Data requirements:
- The active object should provide a DisplayName string and optional Icon Texture2D.
- When sequence is used, it should expose Count() and GetVariant(index).

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/UI/Placeable/PlaceableListEntry.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Placeable

```csharp
#endregion

        #region Exported Properties
        /// <summary>
        /// Single placeable resource to display/select when no sequence is provided.
        /// </summary>
        [Export]
        public Resource Placeable
        {
            get => _placeable;
            set
            {
                _placeable = value;
                _currentVariantIndex = 0;
                _UpdateView();
            }
        }
```

Single placeable resource to display/select when no sequence is provided.

### Sequence

```csharp
/// <summary>
        /// Optional sequence wrapper providing variants (e.g. PlaceableSequence).
        /// Should implement Count() and GetVariant(index).
        /// </summary>
        [Export]
        public Resource Sequence
        {
            get => _sequence;
            set
            {
                _sequence = value;
                _currentVariantIndex = 0;
                _UpdateVariantVisibility();
                _UpdateView();
            }
        }
```

Optional sequence wrapper providing variants (e.g. PlaceableSequence).
Should implement Count() and GetVariant(index).

### IconSize

```csharp
/// <summary>
        /// Icon size for the entry.
        /// </summary>
        [Export]
        public Vector2 IconSize
        {
            get => _iconSize;
            set
            {
                _iconSize = value;
                if (_iconRect != null)
                {
                    _iconRect.CustomMinimumSize = _iconSize;
                }
            }
        }
```

Icon size for the entry.

### FixedEntryHeight

```csharp
/// <summary>
        /// Fixed height for list entries to maintain consistent sizing.
        /// When set to a positive value, enforces a fixed height regardless of content.
        /// When set to 0, height enforcement is disabled and the entry will size naturally.
        /// Default: 56 pixels to match template standard sizing.
        /// </summary>
        [ExportGroup("Sizing Settings")]
        [Export]
        public int FixedEntryHeight { get; set; } = 56;
```

Fixed height for list entries to maintain consistent sizing.
When set to a positive value, enforces a fixed height regardless of content.
When set to 0, height enforcement is disabled and the entry will size naturally.
Default: 56 pixels to match template standard sizing.


## Methods

### _Ready

```csharp
#endregion

        #region Godot Lifecycle
        public override void _Ready()
        {
            _WireNodes();
            _InitInteraction();
            _UpdateVariantVisibility();
            _UpdateView();
            FocusMode = FocusMode.All;
            _EnforceEntryHeight();
        }
```

**Returns:** `void`

### SetSelected

```csharp
#endregion

        #region Selection State
        /// <summary>
        /// Sets the selected state of this entry.
        /// </summary>
        /// <param name="selected">Whether the entry is selected</param>
        public void SetSelected(bool selected)
        {
            _selected = selected;
            // Note: Visual selection state is now handled by PlaceableUIInteraction
            // This method just tracks the logical selection state
            if (_nameLabel != null)
            {
                _nameLabel.AddThemeColorOverride(
                    "font_color", 
                    new Color(1, 1, 1, 1) 
                );
            }
        }
```

Sets the selected state of this entry.

**Returns:** `void`

**Parameters:**
- `bool selected`

### IsSelected

```csharp
/// <summary>
        /// Gets whether this entry is selected.
        /// </summary>
        /// <returns>True if selected</returns>
        public bool IsSelected() => _selected;
```

Gets whether this entry is selected.

**Returns:** `bool`

### _GuiInput

```csharp
#endregion

        #region Input Handling
        public override void _GuiInput(InputEvent @event)
        {
            // Handle keyboard navigation only - mouse clicks are handled by PlaceableUIInteraction
            if (@event is InputEventKey keyEvent && keyEvent.Pressed)
            {
                switch (keyEvent.Keycode)
                {
                    case Key.Left:
                        if (_SequenceHasVariants())
                        {
                            _CycleVariant(-1);
                            AcceptEvent();
                        }
                        break;
                    case Key.Right:
                        if (_SequenceHasVariants())
                        {
                            _CycleVariant(1);
                            AcceptEvent();
                        }
                        break;
                    case Key.Enter:
                    case Key.KpEnter:
                    case Key.Space:
                        EmitSignal(SignalName.Selected, this);
                        AcceptEvent();
                        break;
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `InputEvent event`

### GetActivePlaceable

```csharp
/// <summary>
        /// Returns the currently active placeable resource for this entry.
        /// </summary>
        /// <returns>The active placeable resource</returns>
        public Resource GetActivePlaceable() => _ActiveObject();
```

Returns the currently active placeable resource for this entry.

**Returns:** `Resource`

### GetActiveVariantIndex

```csharp
/// <summary>
        /// Returns the active variant index (0-based) within the sequence.
        /// </summary>
        /// <returns>The current variant index</returns>
        public int GetActiveVariantIndex() => _currentVariantIndex;
```

Returns the active variant index (0-based) within the sequence.

**Returns:** `int`

### GetActiveDisplayName

```csharp
/// <summary>
        /// Returns a display name for the active variant.
        /// </summary>
        /// <returns>Display name string</returns>
        public string GetActiveDisplayName()
        {
            var obj = _ActiveObject();
            if (obj == null)
                return "";

            var dn = _GetProperty(obj, "display_name");
            if (dn != null)
                return dn.ToString();

            var nprop = _GetProperty(obj, "name");
            if (nprop != null)
                return nprop.ToString();

            return "";
        }
```

Returns a display name for the active variant.

**Returns:** `string`

### _ExitTree

```csharp
#endregion

        #region Cleanup
        public override void _ExitTree()
        {
            _uiInteraction?.Cleanup();
            base._ExitTree();
        }
```

**Returns:** `void`

