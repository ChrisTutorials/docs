---
title: "MouseButtonEventArgs"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/mousebuttoneventargs/"
---

# MouseButtonEventArgs

```csharp
GridBuilding.Core.Common.Types
class MouseButtonEventArgs
{
    // Members...
}
```

Mouse button event arguments

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/InputTypes.cs`  
**Namespace:** `GridBuilding.Core.Common.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Button

```csharp
public MouseButton Button { get; set; }
```

### Position

```csharp
public Vector2 Position { get; set; }
```

### IsPressed

```csharp
public bool IsPressed { get; set; }
```

### ClickCount

```csharp
public int ClickCount { get; set; }
```

### Timestamp

```csharp
public float Timestamp { get; set; }
```

