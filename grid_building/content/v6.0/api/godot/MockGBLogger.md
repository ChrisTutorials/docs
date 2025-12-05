---
title: "MockGBLogger"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mockgblogger/"
---

# MockGBLogger

```csharp
GridBuilding.Godot.Tests.Helpers
class MockGBLogger
{
    // Members...
}
```

Mock implementation of Logger.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/MockGBCompositionContainer.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### LogInfo

```csharp
public void LogInfo(string message)
    {
        GD.Print($"[Mock INFO] {message}");
    }
```

**Returns:** `void`

**Parameters:**
- `string message`

### LogWarning

```csharp
public void LogWarning(string message)
    {
        GD.Print($"[Mock WARN] {message}");
    }
```

**Returns:** `void`

**Parameters:**
- `string message`

### LogError

```csharp
public void LogError(string message)
    {
        GD.PrintErr($"[Mock ERROR] {message}");
    }
```

**Returns:** `void`

**Parameters:**
- `string message`

### LogWarnings

```csharp
public void LogWarnings(Godot.Collections.Array<string> warnings)
    {
        foreach (var warning in warnings)
        {
            LogWarning(warning);
        }
    }
```

**Returns:** `void`

**Parameters:**
- `Godot.Collections.Array<string> warnings`

