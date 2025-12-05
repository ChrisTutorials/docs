---
title: "GridRotationUtils"
description: "Utility class for grid rotation operations"
weight: 10
url: "/gridbuilding/v6-0/api/core/gridrotationutils/"
---

# GridRotationUtils

```csharp
GridBuilding.Core.Math
class GridRotationUtils
{
    // Members...
}
```

Utility class for grid rotation operations

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Math/GridRotationUtils.cs`  
**Namespace:** `GridBuilding.Core.Math`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### DegreesToCardinal

```csharp
public static CardinalDirection DegreesToCardinal(float degrees)
    {
        var normalized = ((degrees % 360) + 360) % 360;
        if (normalized < 22.5f || normalized >= 337.5f) return CardinalDirection.North;
        if (normalized < 67.5f) return CardinalDirection.Northeast;
        if (normalized < 112.5f) return CardinalDirection.East;
        if (normalized < 157.5f) return CardinalDirection.Southeast;
        if (normalized < 202.5f) return CardinalDirection.South;
        if (normalized < 247.5f) return CardinalDirection.Southwest;
        if (normalized < 292.5f) return CardinalDirection.West;
        return CardinalDirection.Northwest;
    }
```

**Returns:** `CardinalDirection`

**Parameters:**
- `float degrees`

### GetDirectionTileDelta

```csharp
public static Vector2I GetDirectionTileDelta(CardinalDirection direction)
    {
        return direction switch
        {
            CardinalDirection.North => new Vector2I(0, -1),
            CardinalDirection.Northeast => new Vector2I(1, -1),
            CardinalDirection.East => new Vector2I(1, 0),
            CardinalDirection.Southeast => new Vector2I(1, 1),
            CardinalDirection.South => new Vector2I(0, 1),
            CardinalDirection.Southwest => new Vector2I(-1, 1),
            CardinalDirection.West => new Vector2I(-1, 0),
            CardinalDirection.Northwest => new Vector2I(-1, -1),
            _ => new Vector2I(0, 0)
        };
    }
```

**Returns:** `Vector2I`

**Parameters:**
- `CardinalDirection direction`

