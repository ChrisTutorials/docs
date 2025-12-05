---
title: "TestCollisionScenario"
description: "Test collision scenario data"
weight: 20
url: "/gridbuilding/v6-0/api/godot/testcollisionscenario/"
---

# TestCollisionScenario

```csharp
GridBuilding.Godot.Tests.Environments
class TestCollisionScenario
{
    // Members...
}
```

Test collision scenario data

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/CollisionTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "";
```

### Description

```csharp
public string Description { get; set; } = "";
```

### TestPosition

```csharp
public Vector2 TestPosition { get; set; }
```

### ExpectedCollisionCount

```csharp
public int ExpectedCollisionCount { get; set; }
```

### TestObjects

```csharp
public CollisionObject2D[] TestObjects { get; set; } = new CollisionObject2D[0];
```

