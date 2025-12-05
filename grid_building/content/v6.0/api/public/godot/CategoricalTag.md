---
title: "CategoricalTag"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/categoricaltag/"
---

# CategoricalTag

```csharp
GridBuilding.Godot.Systems.Placement.Data.Placeable
class CategoricalTag
{
    // Members...
}
```

Tag resource for categorizing placeables into groups for gameplay and UI.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Data/Placeable/CategoricalTag.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Data.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Description

```csharp
#region Exported Properties

    /// <summary>
    /// Multiline description with BBCode support for UI display.
    /// </summary>
    [Export] public string Description { get; set; } = string.Empty;
```

Multiline description with BBCode support for UI display.

### DisplayName

```csharp
/// <summary>
    /// Display name for UI and gameplay.
    /// </summary>
    [Export] public string DisplayName { get; set; } = string.Empty;
```

Display name for UI and gameplay.

### Icon

```csharp
/// <summary>
    /// Small image representing the tag in UI elements.
    /// </summary>
    [Export] public Texture2D Icon { get; set; }
```

Small image representing the tag in UI elements.


## Methods

### ToString

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Gets a string representation of the tag.
    /// </summary>
    /// <returns>The display name of the tag</returns>
    public override string ToString()
    {
        return DisplayName;
    }
```

Gets a string representation of the tag.

**Returns:** `string`

### Validate

```csharp
/// <summary>
    /// Validates the tag properties.
    /// </summary>
    /// <returns>Array of validation issues</returns>
    public string[] Validate()
    {
        var issues = new List<string>();

        if (string.IsNullOrEmpty(DisplayName))
        {
            issues.Add("Display name cannot be empty");
        }

        return issues.ToArray();
    }
```

Validates the tag properties.

**Returns:** `string[]`

