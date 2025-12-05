---
title: "CoordinateTestResult"
description: "Result of coordinate conversion test"
weight: 20
url: "/gridbuilding/v6-0/api/godot/coordinatetestresult/"
---

# CoordinateTestResult

```csharp
GridBuilding.Godot.Shared.Utils.Validation
class CoordinateTestResult
{
    // Members...
}
```

Result of coordinate conversion test

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/Camera2DValidator.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Success

```csharp
public bool Success { get; set; }
```

### Accuracy

```csharp
public float Accuracy { get; set; }
```

### WorldPos

```csharp
public Vector2 WorldPos { get; set; }
```

### Expected

```csharp
public Vector2 Expected { get; set; }
```

### Error

```csharp
public string Error { get; set; } = "";
```

