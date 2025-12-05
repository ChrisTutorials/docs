---
title: "MockNodeLocator"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mocknodelocator/"
---

# MockNodeLocator

```csharp
GridBuilding.Godot.Tests.Placement
class MockNodeLocator
{
    // Members...
}
```

Mock NodeLocator that returns a specific container.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/SpendMaterialsRuleGenericTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### LocateContainer

```csharp
public override Node? LocateContainer(Node? searchRoot)
        {
            return _container as Node;
        }
```

**Returns:** `Node?`

**Parameters:**
- `Node? searchRoot`

