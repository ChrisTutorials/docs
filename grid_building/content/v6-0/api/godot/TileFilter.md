---
title: "TileFilter"
description: "Filters tiles based on exclusions, inclusions, or predicates."
weight: 20
url: "/gridbuilding/v6-0/api/godot/tilefilter/"
---

# TileFilter

```csharp
GridBuilding.Godot.Tests.Validation
class TileFilter
{
    // Members...
}
```

Filters tiles based on exclusions, inclusions, or predicates.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/TileFilterTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### AddExclusion

```csharp
public void AddExclusion(TileCoord tile) => _exclusions.Add(tile);
```

**Returns:** `void`

**Parameters:**
- `TileCoord tile`

### AddExclusions

```csharp
public void AddExclusions(IEnumerable<TileCoord> tiles)
    {
        foreach (var tile in tiles)
        {
            _exclusions.Add(tile);
        }
    }
```

**Returns:** `void`

**Parameters:**
- `IEnumerable<TileCoord> tiles`

### AddExclusionRegion

```csharp
public void AddExclusionRegion(TileCoord topLeft, TileCoord bottomRight)
    {
        for (int y = topLeft.Y; y <= bottomRight.Y; y++)
        {
            for (int x = topLeft.X; x <= bottomRight.X; x++)
            {
                _exclusions.Add(new TileCoord(x, y));
            }
        }
    }
```

**Returns:** `void`

**Parameters:**
- `TileCoord topLeft`
- `TileCoord bottomRight`

### ClearExclusions

```csharp
public void ClearExclusions() => _exclusions.Clear();
```

**Returns:** `void`

### AddInclusion

```csharp
public void AddInclusion(TileCoord tile) => _inclusions.Add(tile);
```

**Returns:** `void`

**Parameters:**
- `TileCoord tile`

### SetPredicate

```csharp
public void SetPredicate(Func<TileCoord, bool> predicate) => _predicate = predicate;
```

**Returns:** `void`

**Parameters:**
- `Func<TileCoord, bool> predicate`

### ClearPredicate

```csharp
public void ClearPredicate() => _predicate = null;
```

**Returns:** `void`

### Filter

```csharp
public List<TileCoord> Filter(List<TileCoord> tiles)
    {
        if (tiles == null)
            throw new ArgumentNullException(nameof(tiles));

        IEnumerable<TileCoord> result = tiles;

        if (_mode == FilterMode.IncludeOnly)
        {
            result = result.Where(t => _inclusions.Contains(t));
        }
        else
        {
            result = result.Where(t => !_exclusions.Contains(t));
        }

        if (_predicate != null)
        {
            result = result.Where(_predicate);
        }

        return result.ToList();
    }
```

**Returns:** `List<TileCoord>`

**Parameters:**
- `List<TileCoord> tiles`

