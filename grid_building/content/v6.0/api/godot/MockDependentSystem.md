---
title: "MockDependentSystem"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mockdependentsystem/"
---

# MockDependentSystem

```csharp
GridBuilding.Godot.Tests.BehaviorVerification
class MockDependentSystem
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/EdgeCaseTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.BehaviorVerification`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### AddDependency

```csharp
public void AddDependency(MockDependentSystem dependency)
    {
        _dependencies.Add(dependency);
    }
```

**Returns:** `void`

**Parameters:**
- `MockDependentSystem dependency`

### Initialize

```csharp
public void Initialize()
    {
        // Check for circular dependencies
        var visited = new HashSet<string>();
        if (HasCircularDependency(visited))
        {
            throw new InvalidOperationException($"Circular dependency detected involving {_name}");
        }
    }
```

**Returns:** `void`

