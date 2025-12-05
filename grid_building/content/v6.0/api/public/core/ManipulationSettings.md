---
title: "ManipulationSettings"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/manipulationsettings/"
---

# ManipulationSettings

```csharp
GridBuilding.Core.Systems.Manipulation
class ManipulationSettings
{
    // Members...
}
```

Settings for manipulation operations.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Placement/Manipulation/ManipulationTypes.cs`  
**Namespace:** `GridBuilding.Core.Systems.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RotationStep

```csharp
public float RotationStep { get; set; } = 45f;
```

### SnapToGrid

```csharp
public bool SnapToGrid { get; set; } = true;
```

### ShowMovePreview

```csharp
public bool ShowMovePreview { get; set; } = true;
```

### ShowRotationPreview

```csharp
public bool ShowRotationPreview { get; set; } = true;
```

### ShowFlipPreview

```csharp
public bool ShowFlipPreview { get; set; } = true;
```

### ConfirmDemolish

```csharp
public bool ConfirmDemolish { get; set; } = true;
```

### MoveSpeed

```csharp
public float MoveSpeed { get; set; } = 1f;
```

### RotationSpeed

```csharp
public float RotationSpeed { get; set; } = 90f;
```

