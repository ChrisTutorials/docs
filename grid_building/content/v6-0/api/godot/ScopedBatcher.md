---
title: "ScopedBatcher"
description: "Inner class for scoped batching that auto-flushes on disposal."
weight: 20
url: "/gridbuilding/v6-0/api/godot/scopedbatcher/"
---

# ScopedBatcher

```csharp
GridBuilding.Godot.Shared.Utils.Logging
class ScopedBatcher
{
    // Members...
}
```

Inner class for scoped batching that auto-flushes on disposal.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/MessageBatcher.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Dispose

```csharp
/// <summary>
    /// Flushes messages and restores previous enabled state.
    /// </summary>
    public void Dispose()
    {
        _batcher.Flush();
        _batcher.Enabled = _oldEnabled;
    }
```

Flushes messages and restores previous enabled state.

**Returns:** `void`

