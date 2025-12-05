---
title: "TileFilterTest"
description: "Unit tests for tile filter and exclusion logic.
Tests how tiles are filtered, excluded, and selected for placement operations.
Ported from: godot/addons/grid_building/test/grid_building/systems/building/unit/filters/tile_filter_unit_test.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/tilefiltertest/"
---

# TileFilterTest

```csharp
GridBuilding.Godot.Tests.Validation
class TileFilterTest
{
    // Members...
}
```

Unit tests for tile filter and exclusion logic.
Tests how tiles are filtered, excluded, and selected for placement operations.
Ported from: godot/addons/grid_building/test/grid_building/systems/building/unit/filters/tile_filter_unit_test.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/TileFilterTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### TileFilter_NoExclusions_ReturnsAllTiles

```csharp
#region Basic Filtering Tests

    [Fact]
    public void TileFilter_NoExclusions_ReturnsAllTiles()
    {
        var allTiles = CreateTileGrid(0, 0, 3, 3);
        var filter = new TileFilter();
        
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(9);
    }
```

**Returns:** `void`

### TileFilter_ExcludeCorner_RemovesOne

```csharp
[Fact]
    public void TileFilter_ExcludeCorner_RemovesOne()
    {
        var allTiles = CreateTileGrid(0, 0, 3, 3);
        var filter = new TileFilter();
        filter.AddExclusion(new TileCoord(0, 0));
        
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(8);
        result.ShouldNotContain(new TileCoord(0, 0));
    }
```

**Returns:** `void`

### TileFilter_ExcludeMultiple_RemovesAll

```csharp
[Fact]
    public void TileFilter_ExcludeMultiple_RemovesAll()
    {
        var allTiles = CreateTileGrid(0, 0, 3, 3);
        var filter = new TileFilter();
        filter.AddExclusions(new List<TileCoord> 
        {
            new(0, 0),
            new(1, 1),
            new(2, 2)
        });
        
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(6);
        result.ShouldNotContain(new TileCoord(0, 0));
        result.ShouldNotContain(new TileCoord(1, 1));
        result.ShouldNotContain(new TileCoord(2, 2));
    }
```

**Returns:** `void`

### TileFilter_ExcludeNonexistent_NoEffect

```csharp
[Fact]
    public void TileFilter_ExcludeNonexistent_NoEffect()
    {
        var allTiles = CreateTileGrid(0, 0, 3, 3);
        var filter = new TileFilter();
        filter.AddExclusion(new TileCoord(999, 999));
        
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(9);
    }
```

**Returns:** `void`

### TileFilter_ClearExclusions_RestoresAll

```csharp
[Fact]
    public void TileFilter_ClearExclusions_RestoresAll()
    {
        var allTiles = CreateTileGrid(0, 0, 3, 3);
        var filter = new TileFilter();
        filter.AddExclusion(new TileCoord(1, 1));
        
        filter.ClearExclusions();
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(9);
    }
```

**Returns:** `void`

### TileFilter_ExcludeRegion_RemovesAllInRegion

```csharp
#endregion

    #region Region-Based Filtering Tests

    [Fact]
    public void TileFilter_ExcludeRegion_RemovesAllInRegion()
    {
        var allTiles = CreateTileGrid(0, 0, 5, 5);
        var filter = new TileFilter();
        
        // Exclude 2x2 region at (1,1)
        filter.AddExclusionRegion(new TileCoord(1, 1), new TileCoord(2, 2));
        
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(21); // 25 - 4
        result.ShouldNotContain(new TileCoord(1, 1));
        result.ShouldNotContain(new TileCoord(1, 2));
        result.ShouldNotContain(new TileCoord(2, 1));
        result.ShouldNotContain(new TileCoord(2, 2));
    }
```

**Returns:** `void`

### TileFilter_OverlappingRegions_MergesCorrectly

```csharp
[Fact]
    public void TileFilter_OverlappingRegions_MergesCorrectly()
    {
        var allTiles = CreateTileGrid(0, 0, 4, 4);
        var filter = new TileFilter();
        
        // Two overlapping 2x2 regions
        filter.AddExclusionRegion(new TileCoord(0, 0), new TileCoord(1, 1));
        filter.AddExclusionRegion(new TileCoord(1, 1), new TileCoord(2, 2));
        
        var result = filter.Filter(allTiles);
        
        // Should exclude 7 unique tiles (4 + 4 - 1 overlap)
        result.Count.ShouldBe(16 - 7);
    }
```

**Returns:** `void`

### TileFilter_IncludeOnlyMode_ReturnsOnlyIncluded

```csharp
#endregion

    #region Include-Only Mode Tests

    [Fact]
    public void TileFilter_IncludeOnlyMode_ReturnsOnlyIncluded()
    {
        var allTiles = CreateTileGrid(0, 0, 5, 5);
        var filter = new TileFilter(FilterMode.IncludeOnly);
        
        filter.AddInclusion(new TileCoord(2, 2));
        filter.AddInclusion(new TileCoord(3, 3));
        
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(2);
        result.ShouldContain(new TileCoord(2, 2));
        result.ShouldContain(new TileCoord(3, 3));
    }
```

**Returns:** `void`

### TileFilter_IncludeNonexistent_ReturnsEmpty

```csharp
[Fact]
    public void TileFilter_IncludeNonexistent_ReturnsEmpty()
    {
        var allTiles = CreateTileGrid(0, 0, 3, 3);
        var filter = new TileFilter(FilterMode.IncludeOnly);
        
        filter.AddInclusion(new TileCoord(999, 999));
        
        var result = filter.Filter(allTiles);
        
        result.ShouldBeEmpty();
    }
```

**Returns:** `void`

### TileFilter_WithPredicate_AppliesLogic

```csharp
#endregion

    #region Predicate-Based Filtering

    [Fact]
    public void TileFilter_WithPredicate_AppliesLogic()
    {
        var allTiles = CreateTileGrid(0, 0, 4, 4);
        var filter = new TileFilter();
        
        // Only keep tiles where X + Y is even
        filter.SetPredicate(tile => (tile.X + tile.Y) % 2 == 0);
        
        var result = filter.Filter(allTiles);
        
        // Checkerboard pattern: half the tiles
        result.Count.ShouldBe(8);
        result.ShouldAllBe(t => (t.X + t.Y) % 2 == 0);
    }
```

**Returns:** `void`

### TileFilter_ClearPredicate_RestoresAll

```csharp
[Fact]
    public void TileFilter_ClearPredicate_RestoresAll()
    {
        var allTiles = CreateTileGrid(0, 0, 4, 4);
        var filter = new TileFilter();
        filter.SetPredicate(tile => tile.X == 0);
        
        filter.ClearPredicate();
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(16);
    }
```

**Returns:** `void`

### TileFilter_PredicatePlusExclusion_CombinesBoth

```csharp
[Fact]
    public void TileFilter_PredicatePlusExclusion_CombinesBoth()
    {
        var allTiles = CreateTileGrid(0, 0, 4, 4);
        var filter = new TileFilter();
        
        // Keep only first row
        filter.SetPredicate(tile => tile.Y == 0);
        // But exclude corner
        filter.AddExclusion(new TileCoord(0, 0));
        
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(3); // Row 0 has 4 tiles, minus 1
        result.ShouldNotContain(new TileCoord(0, 0));
    }
```

**Returns:** `void`

### TileFilter_EmptyInput_ReturnsEmpty

```csharp
#endregion

    #region Edge Cases

    [Fact]
    public void TileFilter_EmptyInput_ReturnsEmpty()
    {
        var filter = new TileFilter();
        
        var result = filter.Filter(new List<TileCoord>());
        
        result.ShouldBeEmpty();
    }
```

**Returns:** `void`

### TileFilter_NullInput_ThrowsException

```csharp
[Fact]
    public void TileFilter_NullInput_ThrowsException()
    {
        var filter = new TileFilter();
        
        Should.Throw<ArgumentNullException>(() => filter.Filter(null!));
    }
```

**Returns:** `void`

### TileFilter_DuplicateExclusions_NoDuplicateEffect

```csharp
[Fact]
    public void TileFilter_DuplicateExclusions_NoDuplicateEffect()
    {
        var allTiles = CreateTileGrid(0, 0, 3, 3);
        var filter = new TileFilter();
        
        // Add same exclusion multiple times
        filter.AddExclusion(new TileCoord(1, 1));
        filter.AddExclusion(new TileCoord(1, 1));
        filter.AddExclusion(new TileCoord(1, 1));
        
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(8); // Still only removes one tile
    }
```

**Returns:** `void`

### TileFilter_NegativeCoordinates_HandlesCorrectly

```csharp
[Fact]
    public void TileFilter_NegativeCoordinates_HandlesCorrectly()
    {
        // Grid from (-2,-2) to (-1,-1) inclusive = 2x2 = 4 tiles
        var allTiles = CreateTileGrid(-2, -2, 2, 2);
        var filter = new TileFilter();
        
        filter.AddExclusion(new TileCoord(-1, -1));
        
        var result = filter.Filter(allTiles);
        
        result.Count.ShouldBe(3); // 4 tiles minus 1 excluded
        result.ShouldNotContain(new TileCoord(-1, -1));
    }
```

**Returns:** `void`

