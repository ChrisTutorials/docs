---
title: "CollisionStatistics"
description: "Collision statistics"
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionstatistics/"
---

# CollisionStatistics

```csharp
GridBuilding.Godot.Tests.Environments
class CollisionStatistics
{
    // Members...
}
```

Collision statistics

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/CollisionTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestedObjects

```csharp
public int TestedObjects { get; set; }
```

### TotalTestSetups

```csharp
public int TotalTestSetups { get; set; }
```

### AverageTestSetupsPerObject

```csharp
public double AverageTestSetupsPerObject => TestedObjects > 0 ? (double)TotalTestSetups / TestedObjects : 0;
```

