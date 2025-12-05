---
title: "CameraValidationResult"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/cameravalidationresult/"
---

# CameraValidationResult

```csharp
GridBuilding.Godot.Camera
class CameraValidationResult
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Camera/Camera2DValidator.cs`  
**Namespace:** `GridBuilding.Godot.Camera`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; set; }
```

### Warnings

```csharp
public List<string> Warnings { get; set; }
```

### Errors

```csharp
public List<string> Errors { get; set; }
```

### ValidBounds

```csharp
public Rect2 ValidBounds { get; set; }
```

### RecommendedZoom

```csharp
public float RecommendedZoom { get; set; }
```

### RecommendedPosition

```csharp
public Vector2 RecommendedPosition { get; set; }
```

