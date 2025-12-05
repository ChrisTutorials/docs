---
title: "InputEventData"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/inputeventdata/"
---

# InputEventData

```csharp
GridBuilding.Core.Systems
class InputEventData
{
    // Members...
}
```

Input event data structure

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/InputManager.cs`  
**Namespace:** `GridBuilding.Core.Systems`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
public InputEventType Type { get; set; }
```

### ActionName

```csharp
public string ActionName { get; set; } = string.Empty;
```

### Position

```csharp
public Vector2 Position { get; set; }
```

### AxisValue

```csharp
public float AxisValue { get; set; }
```

### GestureType

```csharp
public GestureType GestureType { get; set; }
```

### GesturePoints

```csharp
public Vector2[] GesturePoints { get; set; } = Array.Empty<Vector2>();
```

