---
title: "MockPlacementRule"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mockplacementrule/"
---

# MockPlacementRule

```csharp
GridBuilding.Godot.Tests.Validation
class MockPlacementRule
{
    // Members...
}
```

Mock implementation of IPlacementRule for testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/PlacementReportTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; }
```


## Methods

### ValidatePlacement

```csharp
public RuleResult ValidatePlacement()
    {
        return RuleResult.Build(this, _issues);
    }
```

**Returns:** `RuleResult`

