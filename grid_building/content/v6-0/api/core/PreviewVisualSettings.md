---
title: "PreviewVisualSettings"
description: "Preview visual settings for placement visualization
Pure C# implementation without Godot dependencies"
weight: 10
url: "/gridbuilding/v6-0/api/core/previewvisualsettings/"
---

# PreviewVisualSettings

```csharp
GridBuilding.Core.Services.Placement
class PreviewVisualSettings
{
    // Members...
}
```

Preview visual settings for placement visualization
Pure C# implementation without Godot dependencies

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Placement/PlacementTypes.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShowPreview

```csharp
public bool ShowPreview { get; set; } = true;
```

### ShowInvalidCells

```csharp
public bool ShowInvalidCells { get; set; } = true;
```

### ShowValidCells

```csharp
public bool ShowValidCells { get; set; } = true;
```

### ValidColor

```csharp
public string ValidColor { get; set; } = "#00FF00";
```

### InvalidColor

```csharp
public string InvalidColor { get; set; } = "#FF0000";
```

### Opacity

```csharp
public float Opacity { get; set; } = 0.5f;
```

