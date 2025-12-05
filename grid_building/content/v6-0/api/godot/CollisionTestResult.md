---
title: "CollisionTestResult"
description: "Result of collision test"
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisiontestresult/"
---

# CollisionTestResult

```csharp
GridBuilding.Godot.Tests.Environments
class CollisionTestResult
{
    // Members...
}
```

Result of collision test

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/CollisionTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Success

```csharp
public bool Success { get; set; }
```

### Message

```csharp
public string Message { get; set; } = "";
```

### ActualCollisionCount

```csharp
public int ActualCollisionCount { get; set; }
```

### ExpectedCollisionCount

```csharp
public int ExpectedCollisionCount { get; set; }
```

### CollisionPositions

```csharp
public Dictionary<Vector2I, Vector2> CollisionPositions { get; set; } = new();
```

### ProcessingTime

```csharp
public double ProcessingTime { get; set; }
```


## Methods

### Failure

```csharp
public static CollisionTestResult Failure(string errorMessage)
        {
            return new CollisionTestResult
            {
                Success = false,
                Message = errorMessage
            };
        }
```

**Returns:** `CollisionTestResult`

**Parameters:**
- `string errorMessage`

