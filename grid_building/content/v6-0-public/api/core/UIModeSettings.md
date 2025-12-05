---
title: "UIModeSettings"
description: "Settings for UI modes"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/uimodesettings/"
---

# UIModeSettings

```csharp
GridBuilding.Core.Types
class UIModeSettings
{
    // Members...
}
```

Settings for UI modes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ModeSettings.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DefaultMode

```csharp
public UIMode DefaultMode { get; set; } = UIMode.Normal;
```

### ShowTooltips

```csharp
public bool ShowTooltips { get; set; } = true;
```

### EnableAnimations

```csharp
public bool EnableAnimations { get; set; } = true;
```

### AnimationSpeed

```csharp
public float AnimationSpeed { get; set; } = 1.0f;
```

### AutoHidePanels

```csharp
public bool AutoHidePanels { get; set; } = false;
```

### AutoHideDelay

```csharp
public float AutoHideDelay { get; set; } = 3.0f;
```

