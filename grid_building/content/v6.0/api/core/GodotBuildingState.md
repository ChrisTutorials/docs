---
title: "GodotBuildingState"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/godotbuildingstate/"
---

# GodotBuildingState

```csharp
GridBuilding.Core.Common.Types
class GodotBuildingState
{
    // Members...
}
```

Minimal BuildingState implementation for Godot compatibility

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/GodotCompatibility.cs`  
**Namespace:** `GridBuilding.Core.Common.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingId

```csharp
public string BuildingId { get; set; } = "";
```

### Status

```csharp
public GodotBuildingStatus Status { get; set; } = GodotBuildingStatus.Planning;
```

### GridPosition

```csharp
public Vector2I GridPosition { get; set; } = new(0, 0);
```

### Flags

```csharp
public BuildingFlags Flags { get; set; } = BuildingFlags.None;
```

