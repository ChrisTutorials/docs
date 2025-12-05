---
title: "GridCoordinateTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gridcoordinatetest/"
---

# GridCoordinateTest

```csharp
GridBuilding.Godot.Tests.Validation
class GridCoordinateTest
{
    // Members...
}
```

Unit tests for grid coordinate conversion and operations.
Tests how coordinates are converted between world space, grid space, and tile indices.
Ported from: godot/addons/grid_building/test/grid_building/systems/building/unit/grid_coordinate_test.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/GridCoordinateTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### WorldToGrid_Origin_ReturnsZero

```csharp
#region WorldToGrid Conversion Tests

    [Fact]
    public void WorldToGrid_Origin_ReturnsZero()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var result = settings.WorldToGrid(0, 0);
        
        result.X.ShouldBe(0);
        result.Y.ShouldBe(0);
    }
```

**Returns:** `void`

### WorldToGrid_ExactCell_ReturnsCorrectIndex

```csharp
[Fact]
    public void WorldToGrid_ExactCell_ReturnsCorrectIndex()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var result = settings.WorldToGrid(32, 48);
        
        result.X.ShouldBe(2);
        result.Y.ShouldBe(3);
    }
```

**Returns:** `void`

### WorldToGrid_MidCell_RoundsDown

```csharp
[Fact]
    public void WorldToGrid_MidCell_RoundsDown()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        // Position at center of cell (0,0)
        var result = settings.WorldToGrid(8, 8);
        
        result.X.ShouldBe(0);
        result.Y.ShouldBe(0);
    }
```

**Returns:** `void`

### WorldToGrid_NearBoundary_RoundsCorrectly

```csharp
[Fact]
    public void WorldToGrid_NearBoundary_RoundsCorrectly()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        // Just before cell boundary
        var result1 = settings.WorldToGrid(15.9f, 15.9f);
        result1.X.ShouldBe(0);
        result1.Y.ShouldBe(0);
        
        // Just after cell boundary
        var result2 = settings.WorldToGrid(16.1f, 16.1f);
        result2.X.ShouldBe(1);
        result2.Y.ShouldBe(1);
    }
```

**Returns:** `void`

### WorldToGrid_NegativeCoords_HandlesCorrectly

```csharp
[Fact]
    public void WorldToGrid_NegativeCoords_HandlesCorrectly()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var result = settings.WorldToGrid(-32, -48);
        
        result.X.ShouldBe(-2);
        result.Y.ShouldBe(-3);
    }
```

**Returns:** `void`

### WorldToGrid_LargeValues_HandlesCorrectly

```csharp
[Fact]
    public void WorldToGrid_LargeValues_HandlesCorrectly()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var result = settings.WorldToGrid(10000, 20000);
        
        result.X.ShouldBe(625);
        result.Y.ShouldBe(1250);
    }
```

**Returns:** `void`

### GridToWorld_Origin_ReturnsCellCenter

```csharp
#endregion

    #region GridToWorld Conversion Tests

    [Fact]
    public void GridToWorld_Origin_ReturnsCellCenter()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var result = settings.GridToWorld(0, 0);
        
        result.X.ShouldBe(DefaultHalfCell);
        result.Y.ShouldBe(DefaultHalfCell);
    }
```

**Returns:** `void`

### GridToWorld_PositiveCell_ReturnsCellCenter

```csharp
[Fact]
    public void GridToWorld_PositiveCell_ReturnsCellCenter()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var result = settings.GridToWorld(2, 3);
        
        result.X.ShouldBe(2 * DefaultCellSize + DefaultHalfCell);
        result.Y.ShouldBe(3 * DefaultCellSize + DefaultHalfCell);
    }
```

**Returns:** `void`

### GridToWorld_NegativeCell_ReturnsCellCenter

```csharp
[Fact]
    public void GridToWorld_NegativeCell_ReturnsCellCenter()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var result = settings.GridToWorld(-1, -1);
        
        result.X.ShouldBe(-DefaultCellSize + DefaultHalfCell);
        result.Y.ShouldBe(-DefaultCellSize + DefaultHalfCell);
    }
```

**Returns:** `void`

### GridToWorld_RoundTrip_ReturnsOriginalCell

```csharp
[Fact]
    public void GridToWorld_RoundTrip_ReturnsOriginalCell()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        // Start with grid coordinates
        int originalX = 5;
        int originalY = 7;
        
        // Convert to world, then back to grid
        var worldPos = settings.GridToWorld(originalX, originalY);
        var gridPos = settings.WorldToGrid(worldPos.X, worldPos.Y);
        
        gridPos.X.ShouldBe(originalX);
        gridPos.Y.ShouldBe(originalY);
    }
```

**Returns:** `void`

### WorldToGrid_VariousCellSizes_ConvertsCorrectly

```csharp
#endregion

    #region Cell Size Variations

    [Theory]
    [InlineData(8.0f)]
    [InlineData(16.0f)]
    [InlineData(32.0f)]
    [InlineData(64.0f)]
    public void WorldToGrid_VariousCellSizes_ConvertsCorrectly(float cellSize)
    {
        var settings = new GridSettings(cellSize);
        
        // Test at 2 cells distance
        var result = settings.WorldToGrid(2 * cellSize, 3 * cellSize);
        
        result.X.ShouldBe(2);
        result.Y.ShouldBe(3);
    }
```

**Returns:** `void`

**Parameters:**
- `float cellSize`

### GridToWorld_VariousCellSizes_ConvertsCorrectly

```csharp
[Theory]
    [InlineData(8.0f)]
    [InlineData(16.0f)]
    [InlineData(32.0f)]
    [InlineData(64.0f)]
    public void GridToWorld_VariousCellSizes_ConvertsCorrectly(float cellSize)
    {
        var settings = new GridSettings(cellSize);
        
        var result = settings.GridToWorld(2, 3);
        
        result.X.ShouldBe(2 * cellSize + cellSize / 2);
        result.Y.ShouldBe(3 * cellSize + cellSize / 2);
    }
```

**Returns:** `void`

**Parameters:**
- `float cellSize`

### WorldToGrid_WithOffset_AppliesCorrectly

```csharp
#endregion

    #region Grid Offset Tests

    [Fact]
    public void WorldToGrid_WithOffset_AppliesCorrectly()
    {
        var settings = new GridSettings(DefaultCellSize, offsetX: 4, offsetY: 4);
        
        // Position that would be cell (0,0) with offset
        var result = settings.WorldToGrid(4, 4);
        
        result.X.ShouldBe(0);
        result.Y.ShouldBe(0);
    }
```

**Returns:** `void`

### GridToWorld_WithOffset_AppliesCorrectly

```csharp
[Fact]
    public void GridToWorld_WithOffset_AppliesCorrectly()
    {
        var settings = new GridSettings(DefaultCellSize, offsetX: 4, offsetY: 4);
        
        var result = settings.GridToWorld(0, 0);
        
        // Cell center should be at offset + half cell
        result.X.ShouldBe(4 + DefaultHalfCell);
        result.Y.ShouldBe(4 + DefaultHalfCell);
    }
```

**Returns:** `void`

### GetCellBounds_Origin_ReturnsCorrectRect

```csharp
#endregion

    #region Cell Bounds Tests

    [Fact]
    public void GetCellBounds_Origin_ReturnsCorrectRect()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var bounds = settings.GetCellBounds(0, 0);
        
        bounds.X.ShouldBe(0);
        bounds.Y.ShouldBe(0);
        bounds.Width.ShouldBe(DefaultCellSize);
        bounds.Height.ShouldBe(DefaultCellSize);
    }
```

**Returns:** `void`

### GetCellBounds_PositiveCell_ReturnsCorrectRect

```csharp
[Fact]
    public void GetCellBounds_PositiveCell_ReturnsCorrectRect()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var bounds = settings.GetCellBounds(3, 2);
        
        bounds.X.ShouldBe(3 * DefaultCellSize);
        bounds.Y.ShouldBe(2 * DefaultCellSize);
        bounds.Width.ShouldBe(DefaultCellSize);
        bounds.Height.ShouldBe(DefaultCellSize);
    }
```

**Returns:** `void`

### GetCellBounds_NegativeCell_ReturnsCorrectRect

```csharp
[Fact]
    public void GetCellBounds_NegativeCell_ReturnsCorrectRect()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var bounds = settings.GetCellBounds(-1, -1);
        
        bounds.X.ShouldBe(-DefaultCellSize);
        bounds.Y.ShouldBe(-DefaultCellSize);
        bounds.Width.ShouldBe(DefaultCellSize);
        bounds.Height.ShouldBe(DefaultCellSize);
    }
```

**Returns:** `void`

### GetCellCorners_ReturnsAllFour

```csharp
[Fact]
    public void GetCellCorners_ReturnsAllFour()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var corners = settings.GetCellCorners(1, 1);
        
        corners.Length.ShouldBe(4);
        corners.ShouldContain(new WorldPos(16, 16)); // Top-left
        corners.ShouldContain(new WorldPos(32, 16)); // Top-right
        corners.ShouldContain(new WorldPos(32, 32)); // Bottom-right
        corners.ShouldContain(new WorldPos(16, 32)); // Bottom-left
    }
```

**Returns:** `void`

### GetCellsInRegion_SingleCell_ReturnsOne

```csharp
#endregion

    #region Multi-Cell Region Tests

    [Fact]
    public void GetCellsInRegion_SingleCell_ReturnsOne()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var cells = settings.GetCellsInRegion(new GridPos(0, 0), new GridPos(0, 0));
        
        cells.Count.ShouldBe(1);
        cells.ShouldContain(new GridPos(0, 0));
    }
```

**Returns:** `void`

### GetCellsInRegion_3x3Region_ReturnsNine

```csharp
[Fact]
    public void GetCellsInRegion_3x3Region_ReturnsNine()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        var cells = settings.GetCellsInRegion(new GridPos(0, 0), new GridPos(2, 2));
        
        cells.Count.ShouldBe(9);
    }
```

**Returns:** `void`

### GetCellsInRegion_ReversedBounds_StillWorks

```csharp
[Fact]
    public void GetCellsInRegion_ReversedBounds_StillWorks()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        // Provide bottom-right first, top-left second
        var cells = settings.GetCellsInRegion(new GridPos(2, 2), new GridPos(0, 0));
        
        cells.Count.ShouldBe(9);
    }
```

**Returns:** `void`

### GetCellsInWorldRegion_ConvertsAndEnumerates

```csharp
[Fact]
    public void GetCellsInWorldRegion_ConvertsAndEnumerates()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        // 2x2 cell region in world space (32x32 pixels)
        var cells = settings.GetCellsInWorldRegion(0, 0, 32, 32);
        
        cells.Count.ShouldBe(4);
    }
```

**Returns:** `void`

### GridSettings_ZeroCellSize_ThrowsException

```csharp
#endregion

    #region Edge Cases

    [Fact]
    public void GridSettings_ZeroCellSize_ThrowsException()
    {
        Should.Throw<ArgumentException>(() => new GridSettings(0));
    }
```

**Returns:** `void`

### GridSettings_NegativeCellSize_ThrowsException

```csharp
[Fact]
    public void GridSettings_NegativeCellSize_ThrowsException()
    {
        Should.Throw<ArgumentException>(() => new GridSettings(-16));
    }
```

**Returns:** `void`

### WorldToGrid_ExactBoundary_ConsistentResult

```csharp
[Fact]
    public void WorldToGrid_ExactBoundary_ConsistentResult()
    {
        var settings = new GridSettings(DefaultCellSize);
        
        // Exact boundary should be in next cell
        var result = settings.WorldToGrid(DefaultCellSize, DefaultCellSize);
        
        result.X.ShouldBe(1);
        result.Y.ShouldBe(1);
    }
```

**Returns:** `void`

