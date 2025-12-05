---
title: "PlaceableTestObject"
description: "Test object representing a placeable item for testing"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placeabletestobject/"
---

# PlaceableTestObject

```csharp
GridBuilding.Godot.Test.Factories
class PlaceableTestObject
{
    // Members...
}
```

Test object representing a placeable item for testing

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/PlaceableTestFactory.cs`  
**Namespace:** `GridBuilding.Godot.Test.Factories`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id { get; set; } = string.Empty;
```

### Name

```csharp
public string Name { get; set; } = string.Empty;
```

### Size

```csharp
public Vector2I Size { get; set; } = Vector2I.One;
```

### Position

```csharp
public Vector2 Position { get; set; } = Vector2.Zero;
```

### IsPlaceable

```csharp
public bool IsPlaceable { get; set; } = true;
```

### BuildTime

```csharp
public float BuildTime { get; set; } = 5.0f;
```

### Cost

```csharp
public int Cost { get; set; } = 100;
```

### ErrorMessage

```csharp
public string ErrorMessage { get; set; } = string.Empty;
```

### CustomProperties

```csharp
public Dictionary<string, Variant> CustomProperties { get; set; } = new();
```

### CollisionShape

```csharp
public CollisionShapeDefinition CollisionShape { get; set; } = null;
```

