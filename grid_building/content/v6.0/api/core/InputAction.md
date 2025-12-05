---
title: "InputAction"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/inputaction/"
---

# InputAction

```csharp
GridBuilding.Core.Types
class InputAction
{
    // Members...
}
```

Represents an input action with associated data

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/InputAction.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ActionName

```csharp
/// <summary>
    /// Name of the input action
    /// </summary>
    public string ActionName { get; set; } = string.Empty;
```

Name of the input action

### IsPressed

```csharp
/// <summary>
    /// Whether the action is currently pressed
    /// </summary>
    public bool IsPressed { get; set; }
```

Whether the action is currently pressed

### IsJustPressed

```csharp
/// <summary>
    /// Whether the action was just pressed this frame
    /// </summary>
    public bool IsJustPressed { get; set; }
```

Whether the action was just pressed this frame

### IsJustReleased

```csharp
/// <summary>
    /// Whether the action was just released this frame
    /// </summary>
    public bool IsJustReleased { get; set; }
```

Whether the action was just released this frame

### Strength

```csharp
/// <summary>
    /// Strength/value of the action (0.0 to 1.0)
    /// </summary>
    public float Strength { get; set; }
```

Strength/value of the action (0.0 to 1.0)

### Device

```csharp
/// <summary>
    /// Input device that triggered this action
    /// </summary>
    public InputDevice Device { get; set; }
```

Input device that triggered this action

### Timestamp

```csharp
/// <summary>
    /// Timestamp when the action was triggered
    /// </summary>
    public System.DateTime Timestamp { get; set; } = System.DateTime.UtcNow;
```

Timestamp when the action was triggered

