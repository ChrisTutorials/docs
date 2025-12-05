---
title: "EditModeSettings"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/editmodesettings/"
---

# EditModeSettings

```csharp
GridBuilding.Core.Types
class EditModeSettings
{
    // Members...
}
```

Settings for edit modes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ModeSettings.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DefaultMode

```csharp
public EditMode DefaultMode { get; set; } = EditMode.Place;
```

### ShowGrid

```csharp
public bool ShowGrid { get; set; } = true;
```

### SnapToGrid

```csharp
public bool SnapToGrid { get; set; } = true;
```

### GridSize

```csharp
public int GridSize { get; set; } = 32;
```

### ShowPlacementPreview

```csharp
public bool ShowPlacementPreview { get; set; } = true;
```

### EnableUndoRedo

```csharp
public bool EnableUndoRedo { get; set; } = true;
```

### MaxUndoSteps

```csharp
public int MaxUndoSteps { get; set; } = 50;
```

