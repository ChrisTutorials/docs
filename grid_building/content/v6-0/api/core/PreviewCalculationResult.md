---
title: "PreviewCalculationResult"
description: "Result of preview calculation containing footprint and visual data.
This is a pure Core DTO that can be used without Godot dependencies."
weight: 10
url: "/gridbuilding/v6-0/api/core/previewcalculationresult/"
---

# PreviewCalculationResult

```csharp
GridBuilding.Core.Data.Placement
class PreviewCalculationResult
{
    // Members...
}
```

Result of preview calculation containing footprint and visual data.
This is a pure Core DTO that can be used without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/Placement/PreviewCalculationResult.cs`  
**Namespace:** `GridBuilding.Core.Data.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### FootprintData

```csharp
/// <summary>
    /// The footprint data used for this calculation.
    /// </summary>
    public FootprintData FootprintData { get; set; } = null!;
```

The footprint data used for this calculation.

### FootprintPositions

```csharp
/// <summary>
    /// Calculated footprint positions for the preview.
    /// </summary>
    public List<Vector2I> FootprintPositions { get; set; } = new();
```

Calculated footprint positions for the preview.

### Bounds

```csharp
/// <summary>
    /// Bounding rectangle of the preview in grid coordinates.
    /// </summary>
    public RectangleI Bounds { get; set; }
```

Bounding rectangle of the preview in grid coordinates.

### IsValidPlacement

```csharp
/// <summary>
    /// Whether the preview placement is valid at the calculated position.
    /// </summary>
    public bool IsValidPlacement { get; set; }
```

Whether the preview placement is valid at the calculated position.

### Transparency

```csharp
/// <summary>
    /// Recommended transparency for the preview (0.0 to 1.0).
    /// </summary>
    public float Transparency { get; set; } = 0.5f;
```

Recommended transparency for the preview (0.0 to 1.0).

### TintColor

```csharp
/// <summary>
    /// Recommended color tint for the preview.
    /// </summary>
    public Color TintColor { get; set; }
```

Recommended color tint for the preview.

### ShapeData

```csharp
/// <summary>
    /// Shape configuration for the preview.
    /// </summary>
    public PreviewShapeData ShapeData { get; set; } = new();
```

Shape configuration for the preview.

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

