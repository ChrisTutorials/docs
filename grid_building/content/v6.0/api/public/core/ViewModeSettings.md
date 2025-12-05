---
title: "ViewModeSettings"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/viewmodesettings/"
---

# ViewModeSettings

```csharp
GridBuilding.Core.Types
class ViewModeSettings
{
    // Members...
}
```

Settings for view modes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ModeSettings.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DefaultMode

```csharp
public ViewMode DefaultMode { get; set; } = ViewMode.Normal;
```

### CameraSpeed

```csharp
public float CameraSpeed { get; set; } = 10.0f;
```

### ZoomSpeed

```csharp
public float ZoomSpeed { get; set; } = 1.0f;
```

### EnableEdgePanning

```csharp
public bool EnableEdgePanning { get; set; } = true;
```

### EdgePanMargin

```csharp
public int EdgePanMargin { get; set; } = 50;
```

### SmoothTransitions

```csharp
public bool SmoothTransitions { get; set; } = true;
```

### TransitionSpeed

```csharp
public float TransitionSpeed { get; set; } = 2.0f;
```

