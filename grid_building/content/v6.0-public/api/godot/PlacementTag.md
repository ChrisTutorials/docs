---
title: "PlacementTag"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/placementtag/"
---

# PlacementTag

```csharp
GridBuilding.Godot.Systems.Placement
class PlacementTag
{
    // Members...
}
```

Placement Tag Resource
A simple tag resource used to categorize placement objects.
Used by the placement system to filter and organize placeable items.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/PlacementTag.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TagName

```csharp
#region Exported Properties

    /// <summary>
    /// The name of this placement tag.
    /// </summary>
    [Export] public string TagName { get; set; } = string.Empty;
```

The name of this placement tag.


## Methods

### ToString

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Gets a string representation of the placement tag.
    /// </summary>
    /// <returns>The tag name</returns>
    public override string ToString()
    {
        return TagName;
    }
```

Gets a string representation of the placement tag.

**Returns:** `string`

### Validate

```csharp
/// <summary>
    /// Validates the placement tag.
    /// </summary>
    /// <returns>Array of validation issues</returns>
    public string[] Validate()
    {
        var issues = new List<string>();

        if (string.IsNullOrEmpty(TagName))
        {
            issues.Add("Tag name cannot be empty");
        }

        return issues.ToArray();
    }
```

Validates the placement tag.

**Returns:** `string[]`

### Matches

```csharp
/// <summary>
    /// Checks if this tag matches another tag by name.
    /// </summary>
    /// <param name="other">The other tag to compare with</param>
    /// <returns>True if tag names match</returns>
    public bool Matches(PlacementTag other)
    {
        if (other == null)
            return false;

        return TagName.Equals(other.TagName, StringComparison.OrdinalIgnoreCase);
    }
```

Checks if this tag matches another tag by name.

**Returns:** `bool`

**Parameters:**
- `PlacementTag other`

### Matches

```csharp
/// <summary>
    /// Checks if this tag matches a tag name string.
    /// </summary>
    /// <param name="tagName">The tag name to compare with</param>
    /// <returns>True if tag names match</returns>
    public bool Matches(string tagName)
    {
        return TagName.Equals(tagName, StringComparison.OrdinalIgnoreCase);
    }
```

Checks if this tag matches a tag name string.

**Returns:** `bool`

**Parameters:**
- `string tagName`

### Equals

```csharp
/// <summary>
    /// Override Equals method.
    /// </summary>
    /// <param name="obj">Object to compare with</param>
    /// <returns>True if objects are equal</returns>
    public override bool Equals(object obj)
    {
        return obj is PlacementTag other && Matches(other);
    }
```

Override Equals method.

**Returns:** `bool`

**Parameters:**
- `object obj`

### GetHashCode

```csharp
/// <summary>
    /// Override GetHashCode method.
    /// </summary>
    /// <returns>Hash code for the placement tag</returns>
    public override int GetHashCode()
    {
        return TagName?.GetHashCode(StringComparison.OrdinalIgnoreCase) ?? 0;
    }
```

Override GetHashCode method.

**Returns:** `int`

