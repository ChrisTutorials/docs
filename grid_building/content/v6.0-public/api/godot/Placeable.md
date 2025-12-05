---
title: "Placeable"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/placeable/"
---

# Placeable

```csharp
GridBuilding.Godot.Systems.Placement.Data
class Placeable
{
    // Members...
}
```

Object that can be placed into the game world by instancing the packed_scene.
Ported from: godot/addons/grid_building/systems/placement/data/placeable/placeable.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Data/Placeable.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DisplayName

```csharp
#region Properties

    /// <summary>
    /// Display name for in-game reading.
    /// </summary>
    [Export]
    public StringName DisplayName { get; set; }
```

Display name for in-game reading.

### Icon

```csharp
/// <summary>
    /// Texture icon for UI elements.
    /// </summary>
    [Export]
    public Texture2D? Icon { get; set; }
```

Texture icon for UI elements.

### PackedScene

```csharp
/// <summary>
    /// Scene to instance when placed.
    /// </summary>
    [Export]
    public PackedScene? PackedScene { get; set; }
```

Scene to instance when placed.

### Tags

```csharp
/// <summary>
    /// Category tags for grouping placeables.
    /// </summary>
    public global::Godot.Collections.Array<CategoricalTag> Tags { get; set; } = new();
```

Category tags for grouping placeables.

### PlacementRules

```csharp
/// <summary>
    /// Placement rules specific to this placeable.
    /// If IgnoreBaseRules is false, these rules are combined with
    /// base rules from GBSettings.PlacementRules.
    /// </summary>
    public global::Godot.Collections.Array<PlacementRule> PlacementRules { get; set; } = new();
```

Placement rules specific to this placeable.
If IgnoreBaseRules is false, these rules are combined with
base rules from GBSettings.PlacementRules.

### IgnoreBaseRules

```csharp
/// <summary>
    /// When true, skips base placement rules from GBSettings.PlacementRules
    /// and uses ONLY the rules defined in PlacementRules.
    /// 
    /// Use cases:
    /// - false (default): Inherit common rules + add object-specific rules
    /// - true: Completely custom validation (e.g., special objects with unique placement logic)
    /// </summary>
    [Export]
    public bool IgnoreBaseRules { get; set; } = false;
```

When true, skips base placement rules from GBSettings.PlacementRules
and uses ONLY the rules defined in PlacementRules.
/// Use cases:
- false (default): Inherit common rules + add object-specific rules
- true: Completely custom validation (e.g., special objects with unique placement logic)


## Methods

### GetLoadData

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Gets a serialized reference to the placeable for both the FILE_PATH and the file path as a backup.
    /// </summary>
    /// <param name="includeUid">Whether to include UID (only works in editor)</param>
    /// <returns>Dictionary containing load data</returns>
    public global::Godot.Collections.Dictionary<string, Variant> GetLoadData(bool includeUid)
    {
        var dictionary = new global::Godot.Collections.Dictionary<string, Variant>
        {
            [Names.FILE_PATH] = ResourcePath
        };

        if (includeUid) // Only works in editor
        {
            var uid = ResourceLoader.GetResourceUid(ResourcePath);
            dictionary[Names.UID] = ResourceUid.IdToText(uid);
        }

        return dictionary;
    }
```

Gets a serialized reference to the placeable for both the FILE_PATH and the file path as a backup.

**Returns:** `global::Godot.Collections.Dictionary<string, Variant>`

**Parameters:**
- `bool includeUid`

### LoadResource

```csharp
/// <summary>
    /// Function to help locate the placeable using FILE_PATH or file path as backup and returning it.
    /// </summary>
    /// <param name="loadData">Dictionary containing load data</param>
    /// <returns>The loaded Placeable resource</returns>
    public static Placeable? LoadResource(global::Godot.Collections.Dictionary<string, Variant> loadData)
    {
        Placeable? placeable = null;

        if (OS.HasFeature("editor") && loadData.ContainsKey(Names.UID)) // UIDs only load in editor
        {
            var uidStr = loadData[Names.UID].AsString();
            var uidInt = ResourceUid.TextToId(uidStr);

            if (ResourceUid.HasId(uidInt))
            {
                placeable = GD.Load<Placeable>(uidStr);
                return placeable;
            }
        }

        var filePath = loadData[Names.FILE_PATH].AsString();
        placeable = GD.Load<Placeable>(filePath);
        return placeable;
    }
```

Function to help locate the placeable using FILE_PATH or file path as backup and returning it.

**Returns:** `Placeable?`

**Parameters:**
- `global::Godot.Collections.Dictionary<string, Variant> loadData`

### GetPackedRootName

```csharp
/// <summary>
    /// Gets the name of the root node in the packed_scene.
    /// </summary>
    /// <returns>Root node name or "NO_PACKED_SCENE" if no scene</returns>
    public StringName GetPackedRootName()
    {
        if (PackedScene != null)
        {
            var bundled = PackedScene.GetBundledScene();
            if (bundled.ContainsKey("names"))
            {
                var names = bundled["names"].AsGodotArray();
                if (names.Count > 0)
                {
                    return names[0].AsStringName();
                }
            }
        }

        return "NO_PACKED_SCENE";
    }
```

Gets the name of the root node in the packed_scene.

**Returns:** `StringName`

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues that were found in the placeable.
    /// </summary>
    /// <returns>Array of validation issues</returns>
    public global::Godot.Collections.Array<string> GetEditorIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();

        if (PackedScene == null)
        {
            issues.Add("[packed_scene] is null but should be set to the scene you want to instance from a placeable.");
        }

        for (int ruleIdx = 0; ruleIdx < PlacementRules.Count; ruleIdx++)
        {
            if (PlacementRules[ruleIdx] == null)
            {
                issues.Add($"Placement rule [{ruleIdx}] is null at {ResourcePath}");
            }
        }

        return issues;
    }
```

Returns an array of issues that were found in the placeable.

**Returns:** `global::Godot.Collections.Array<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns all found runtime issues including the editor issues as a baseline.
    /// </summary>
    /// <returns>Array of runtime validation issues</returns>
    public global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = GetEditorIssues();
        return issues;
    }
```

Returns all found runtime issues including the editor issues as a baseline.

**Returns:** `global::Godot.Collections.Array<string>`

### _ValidateProperty

```csharp
#endregion

    #region Validation

    /// <summary>
    /// In editor validation.
    /// </summary>
    /// <param name="property">Property being validated</param>
    public override void _ValidateProperty(global::Godot.Collections.Dictionary property)
    {
        if (property.ContainsKey("name"))
        {
            var propertyName = property["name"].AsString();

            if (propertyName == Names.FILE_PATH)
            {
                property["hint"] = PropertyHint.ObjectId;
            }

            if (propertyName == "packed_scene" && PackedScene == null)
            {
                GD.PrintErr("[packed_scene] is null but should be set to the scene you want to instance from a placeable.");
            }

            if (propertyName == "placement_rules")
            {
                for (int ruleIdx = 0; ruleIdx < PlacementRules.Count; ruleIdx++)
                {
                    if (!GodotObject.IsInstanceValid(PlacementRules[ruleIdx]))
                    {
                        GD.PrintErr($"Building rule [{ruleIdx}] is NOT valid at {ResourcePath}");
                    }
                }
            }
        }
    }
```

In editor validation.

**Returns:** `void`

**Parameters:**
- `global::Godot.Collections.Dictionary property`

