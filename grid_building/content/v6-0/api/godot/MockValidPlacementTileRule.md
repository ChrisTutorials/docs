---
title: "MockValidPlacementTileRule"
description: "Mock ValidPlacementTileRule for testing."
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockvalidplacementtilerule/"
---

# MockValidPlacementTileRule

```csharp
GridBuilding.Godot.Tests.Placement
class MockValidPlacementTileRule
{
    // Members...
}
```

Mock ValidPlacementTileRule for testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/ValidPlacementTileRuleTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### EnsureSettings

```csharp
// Expose protected method for testing
        public new ValidPlacementTileRuleSettings EnsureSettings() => base.EnsureSettings();
```

**Returns:** `ValidPlacementTileRuleSettings`

### DoesTileHaveValidData

```csharp
// Override validation logic for testing
        public override bool DoesTileHaveValidData(
            RuleCheckIndicator indicator,
            Godot.Collections.Array<TileMapLayer> maps)
        {
            if (indicator == null)
                return false;

            if (!indicator.ValidateRuntime())
                return false;

            // For testing, just check if indicator is marked as valid
            return indicator.Valid;
        }
```

**Returns:** `bool`

**Parameters:**
- `RuleCheckIndicator indicator`
- `Godot.Collections.Array<TileMapLayer> maps`

