---
title: "ModeMetadata"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/modemetadata/"
---

# ModeMetadata

```csharp
GridBuilding.Core.Types
class ModeMetadata
{
    // Members...
}
```

Simple metadata for a mode (name, description, icon, transition info).
For comprehensive settings, see ModeSettings in ModeSettings.cs.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ModeTypes.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = string.Empty;
```

### Description

```csharp
public string Description { get; set; } = string.Empty;
```

### IconPath

```csharp
public string IconPath { get; set; } = string.Empty;
```

### AllowTransitions

```csharp
public bool AllowTransitions { get; set; } = true;
```

### TransitionDuration

```csharp
public float TransitionDuration { get; set; } = 0.5f;
```

