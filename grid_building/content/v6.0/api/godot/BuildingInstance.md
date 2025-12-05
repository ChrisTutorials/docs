---
title: "BuildingInstance"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/buildinginstance/"
---

# BuildingInstance

```csharp
GridBuilding.Godot.Tests.Environments
class BuildingInstance
{
    // Members...
}
```

Building instance data

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/BuildingTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id { get; set; } = "";
```

### Name

```csharp
public string Name { get; set; } = "";
```

### GridPosition

```csharp
public Vector2I GridPosition { get; set; }
```

### Size

```csharp
public Vector2I Size { get; set; }
```

### BuildTime

```csharp
public float BuildTime { get; set; }
```

### ConstructionProgress

```csharp
public float ConstructionProgress { get; set; }
```

### IsCompleted

```csharp
public bool IsCompleted { get; set; }
```

