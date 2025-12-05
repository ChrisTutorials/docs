---
title: "MockTileCheckRule"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mocktilecheckrule/"
---

# MockTileCheckRule

```csharp
GridBuilding.Godot.Tests.Placement
class MockTileCheckRule
{
    // Members...
}
```

Mock TileCheckRule for testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/TileCheckRuleTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ValidatePlacement

```csharp
public override RuleResult ValidatePlacement()
        {
            if (!IsReady)
            {
                return base.ValidatePlacement();
            }
            
            return RuleResult.Build(this, new Godot.Collections.Array<string>());
        }
```

**Returns:** `RuleResult`

