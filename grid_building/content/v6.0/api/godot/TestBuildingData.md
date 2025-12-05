---
title: "TestBuildingData"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/testbuildingdata/"
---

# TestBuildingData

```csharp
GridBuilding.Godot.Tests.Environments
class TestBuildingData
{
    // Members...
}
```

Test building data for testing purposes

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

### Size

```csharp
public Vector2I Size { get; set; }
```

### BuildTime

```csharp
public float BuildTime { get; set; }
```

### Cost

```csharp
public int Cost { get; set; }
```

### WalkableTiles

```csharp
public List<Vector2I> WalkableTiles { get; set; } = new();
```

