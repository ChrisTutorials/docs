---
title: "PlaceableList"
description: "Scrollable list managing PlaceableListEntry nodes, providing selection & keyboard navigation.
Ported from: godot/addons/grid_building/systems/ui/placeable/sequence/placeable_list.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placeablelist/"
---

# PlaceableList

```csharp
GridBuilding.Godot.Systems.UI.Placeable.Sequence
class PlaceableList
{
    // Members...
}
```

Scrollable list managing PlaceableListEntry nodes, providing selection & keyboard navigation.
Ported from: godot/addons/grid_building/systems/ui/placeable/sequence/placeable_list.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/PlaceableList.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI.Placeable.Sequence`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EntryScene

```csharp
#endregion

    #region Exported Properties

    /// <summary>
    /// Scene template for creating list entries.
    /// </summary>
    [Export]
    public PackedScene EntryScene { get; set; }
```

Scene template for creating list entries.


## Methods

### _Ready

```csharp
#endregion

    #region Godot Lifecycle

    public override void _Ready()
    {
        base._Ready();
        
        WireNodes();
        FocusMode = Control.FocusMode.All;
    }
```

**Returns:** `void`

### _GuiInput

```csharp
public override void _GuiInput(InputEvent @event)
    {
        base._GuiInput(@event);

        // Handle keyboard navigation
        if (@event is InputEventKey keyEvent && keyEvent.Pressed)
        {
            switch (keyEvent.Keycode)
            {
                case Key.Up:
                    NavigateSelection(-1);
                    AcceptEvent();
                    break;
                case Key.Down:
                    NavigateSelection(1);
                    AcceptEvent();
                    break;
                case Key.Enter:
                    ActivateSelectedEntry();
                    AcceptEvent();
                    break;
            }
        }
    }
```

**Returns:** `void`

**Parameters:**
- `InputEvent event`

### Clear

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Clears all entries from the list.
    /// </summary>
    public void Clear()
    {
        foreach (var entry in _entries)
        {
            if (IsInstanceValid(entry))
            {
                entry.QueueFree();
            }
        }
        
        _entries.Clear();
        _selectedEntry = null;
    }
```

Clears all entries from the list.

**Returns:** `void`

### AddSequence

```csharp
/// <summary>
    /// Adds a sequence to the list.
    /// </summary>
    /// <param name="sequence">The sequence resource to add</param>
    /// <returns>The created entry node, or null if failed</returns>
    public Node AddSequence(Resource sequence)
    {
        if (EntryScene == null)
        {
            GD.PushWarning("PlaceableList: entry_scene not set");
            return null;
        }
        
        if (sequence == null)
        {
            GD.PushWarning("PlaceableList: add_sequence called with null sequence");
            return null;
        }

        var entry = EntryScene.Instantiate();
        _vbox.AddChild(entry);
        
        // Set sequence property if the entry has it
        if (entry.HasMethod("set_sequence"))
        {
            entry.Call("set_sequence", sequence);
        }
        
        // Connect signals if available
        if (entry.HasSignal("selected"))
        {
            entry.Connect("selected", Callable.From(OnEntrySelected));
        }
        
        if (entry.HasSignal("variant_changed"))
        {
            entry.Connect("variant_changed", Callable.From(OnEntryVariantChanged));
        }
        
        _entries.Add(entry);
        
        // Auto-select first entry
        if (_selectedEntry == null)
        {
            SelectEntry(entry);
        }
        
        return entry;
    }
```

Adds a sequence to the list.

**Returns:** `Node`

**Parameters:**
- `Resource sequence`

### GetSelectedEntry

```csharp
/// <summary>
    /// Gets the currently selected entry.
    /// </summary>
    /// <returns>The selected entry node, or null if none selected</returns>
    public Node GetSelectedEntry()
    {
        return _selectedEntry;
    }
```

Gets the currently selected entry.

**Returns:** `Node`

### GetEntries

```csharp
/// <summary>
    /// Gets all entries in the list.
    /// </summary>
    /// <returns>List of entry nodes</returns>
    public IReadOnlyList<Node> GetEntries()
    {
        return _entries.AsReadOnly();
    }
```

Gets all entries in the list.

**Returns:** `IReadOnlyList<Node>`

### SelectEntry

```csharp
/// <summary>
    /// Selects a specific entry.
    /// </summary>
    /// <param name="entry">The entry to select</param>
    public void SelectEntry(Node entry)
    {
        if (!_entries.Contains(entry))
        {
            return;
        }

        // Deselect previous entry
        if (_selectedEntry != null && _selectedEntry.HasMethod("set_selected"))
        {
            _selectedEntry.Call("set_selected", false);
        }

        // Select new entry
        _selectedEntry = entry;
        if (_selectedEntry.HasMethod("set_selected"))
        {
            _selectedEntry.Call("set_selected", true);
        }

        // Emit selection changed signal
        EmitSignal(SignalName.SelectionChanged, _selectedEntry);
    }
```

Selects a specific entry.

**Returns:** `void`

**Parameters:**
- `Node entry`

