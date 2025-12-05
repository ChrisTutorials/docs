---
title: "KeyEventArgs"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/keyeventargs/"
---

# KeyEventArgs

```csharp
GridBuilding.Core.Common.Types
class KeyEventArgs
{
    // Members...
}
```

Key event arguments

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/InputTypes.cs`  
**Namespace:** `GridBuilding.Core.Common.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Key

```csharp
public KeyCode Key { get; set; }
```

### IsPressed

```csharp
public bool IsPressed { get; set; }
```

### IsRepeat

```csharp
public bool IsRepeat { get; set; }
```

### ShiftPressed

```csharp
public bool ShiftPressed { get; set; }
```

### CtrlPressed

```csharp
public bool CtrlPressed { get; set; }
```

### AltPressed

```csharp
public bool AltPressed { get; set; }
```

### Timestamp

```csharp
public float Timestamp { get; set; }
```

