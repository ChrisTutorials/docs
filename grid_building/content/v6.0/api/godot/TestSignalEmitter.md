---
title: "TestSignalEmitter"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/testsignalemitter/"
---

# TestSignalEmitter

```csharp
GridBuilding.Godot.Tests.GoDotTest
class TestSignalEmitter
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/SignalIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### EmitTestSignal

```csharp
public void EmitTestSignal() => EmitSignal(SignalName.TestSignal);
```

**Returns:** `void`

### EmitDataSignal

```csharp
public void EmitDataSignal(string value) => EmitSignal(SignalName.DataSignal, value);
```

**Returns:** `void`

**Parameters:**
- `string value`

### EmitComplexSignal

```csharp
public void EmitComplexSignal(Vector2 pos, int id) => EmitSignal(SignalName.ComplexSignal, pos, id);
```

**Returns:** `void`

**Parameters:**
- `Vector2 pos`
- `int id`

