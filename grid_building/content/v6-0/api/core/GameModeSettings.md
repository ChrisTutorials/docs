---
title: "GameModeSettings"
description: "Settings for game modes"
weight: 10
url: "/gridbuilding/v6-0/api/core/gamemodesettings/"
---

# GameModeSettings

```csharp
GridBuilding.Core.Types
class GameModeSettings
{
    // Members...
}
```

Settings for game modes

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ModeSettings.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DefaultMode

```csharp
public GameMode DefaultMode { get; set; } = GameMode.Play;
```

### AutoPause

```csharp
public bool AutoPause { get; set; } = false;
```

### TimeScale

```csharp
public float TimeScale { get; set; } = 1.0f;
```

### ShowFPS

```csharp
public bool ShowFPS { get; set; } = false;
```

### EnableDebugInfo

```csharp
public bool EnableDebugInfo { get; set; } = false;
```

### SaveOnExit

```csharp
public bool SaveOnExit { get; set; } = true;
```

