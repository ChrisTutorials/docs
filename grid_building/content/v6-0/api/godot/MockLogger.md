---
title: "MockLogger"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/mocklogger/"
---

# MockLogger

```csharp
GridBuilding.Godot.Tests.Core.Contexts
class MockLogger
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/SystemsContextTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Warnings

```csharp
public List<string> Warnings { get; } = new();
```

### Errors

```csharp
public List<string> Errors { get; } = new();
```

### DebugMessages

```csharp
public List<string> DebugMessages { get; } = new();
```


## Methods

### LogWarning

```csharp
public void LogWarning(string message) => Warnings.Add(message);
```

**Returns:** `void`

**Parameters:**
- `string message`

### LogError

```csharp
public void LogError(string message) => Errors.Add(message);
```

**Returns:** `void`

**Parameters:**
- `string message`

### LogDebug

```csharp
public void LogDebug(string message) => DebugMessages.Add(message);
```

**Returns:** `void`

**Parameters:**
- `string message`

