---
title: "MockSpendMaterialsRuleGeneric"
description: "Mock SpendMaterialsRuleGeneric for testing."
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockspendmaterialsrulegeneric/"
---

# MockSpendMaterialsRuleGeneric

```csharp
GridBuilding.Godot.Tests.Placement
class MockSpendMaterialsRuleGeneric
{
    // Members...
}
```

Mock SpendMaterialsRuleGeneric for testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/SpendMaterialsRuleGenericTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetPreSetupIssues

```csharp
// Expose protected method for testing
        public new Godot.Collections.Array<string> GetPreSetupIssues(GridTargetingState gts) 
            => base.GetPreSetupIssues(gts);
```

**Returns:** `Godot.Collections.Array<string>`

**Parameters:**
- `GridTargetingState gts`

### GetPostSetupIssues

```csharp
public new Godot.Collections.Array<string> GetPostSetupIssues() 
            => base.GetPostSetupIssues();
```

**Returns:** `Godot.Collections.Array<string>`

