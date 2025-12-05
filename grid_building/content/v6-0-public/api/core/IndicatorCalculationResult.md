---
title: "IndicatorCalculationResult"
description: "Result of indicator calculation containing placement positions and validity data.
This is a pure Core DTO that can be used without Godot dependencies."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/indicatorcalculationresult/"
---

# IndicatorCalculationResult

```csharp
GridBuilding.Core.Data.Placement
class IndicatorCalculationResult
{
    // Members...
}
```

Result of indicator calculation containing placement positions and validity data.
This is a pure Core DTO that can be used without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/Placement/IndicatorCalculationResult.cs`  
**Namespace:** `GridBuilding.Core.Data.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PositionValidityMap

```csharp
/// <summary>
    /// Dictionary mapping grid positions to their placement validity.
    /// Key: Grid position in tile coordinates
    /// Value: True if placement is valid at this position
    /// </summary>
    public Dictionary<Vector2I, bool> PositionValidityMap { get; set; } = new();
```

Dictionary mapping grid positions to their placement validity.
Key: Grid position in tile coordinates
Value: True if placement is valid at this position

### PositionRulesMap

```csharp
/// <summary>
    /// Dictionary mapping grid positions to applicable rule identifiers.
    /// Key: Grid position in tile coordinates
    /// Value: List of rule identifiers that apply to this position
    /// </summary>
    public Dictionary<Vector2I, List<string>> PositionRulesMap { get; set; } = new();
```

Dictionary mapping grid positions to applicable rule identifiers.
Key: Grid position in tile coordinates
Value: List of rule identifiers that apply to this position

### IndicatorPositions

```csharp
/// <summary>
    /// List of grid positions where indicators should be placed.
    /// This is the computed footprint of the object for placement validation.
    /// </summary>
    public List<Vector2I> IndicatorPositions { get; set; } = new();
```

List of grid positions where indicators should be placed.
This is the computed footprint of the object for placement validation.

### IsOverallValid

```csharp
/// <summary>
    /// Overall placement validity based on all positions.
    /// </summary>
    public bool IsOverallValid { get; set; }
```

Overall placement validity based on all positions.

### Issues

```csharp
/// <summary>
    /// Issues encountered during calculation.
    /// </summary>
    public List<string> Issues { get; set; } = new();
```

Issues encountered during calculation.

### Notes

```csharp
/// <summary>
    /// Additional diagnostic information.
    /// </summary>
    public List<string> Notes { get; set; } = new();
```

Additional diagnostic information.


## Methods

### HasIssues

```csharp
/// <summary>
    /// Gets whether the calculation has any issues.
    /// </summary>
    public bool HasIssues() => Issues.Count > 0;
```

Gets whether the calculation has any issues.

**Returns:** `bool`

### AddIssue

```csharp
/// <summary>
    /// Adds an issue to the result.
    /// </summary>
    public void AddIssue(string issue)
    {
        Issues.Add(issue);
    }
```

Adds an issue to the result.

**Returns:** `void`

**Parameters:**
- `string issue`

### AddNote

```csharp
/// <summary>
    /// Adds a note to the result.
    /// </summary>
    public void AddNote(string note)
    {
        Notes.Add(note);
    }
```

Adds a note to the result.

**Returns:** `void`

**Parameters:**
- `string note`

### GetPositionValidity

```csharp
/// <summary>
    /// Gets validity for a specific position.
    /// </summary>
    public bool GetPositionValidity(Vector2I position)
    {
        return PositionValidityMap.TryGetValue(position, out var validity) ? validity : false;
    }
```

Gets validity for a specific position.

**Returns:** `bool`

**Parameters:**
- `Vector2I position`

### GetPositionRules

```csharp
/// <summary>
    /// Gets applicable rules for a specific position.
    /// </summary>
    public List<string> GetPositionRules(Vector2I position)
    {
        return PositionRulesMap.TryGetValue(position, out var rules) ? rules : new List<string>();
    }
```

Gets applicable rules for a specific position.

**Returns:** `List<string>`

**Parameters:**
- `Vector2I position`

