---
title: "TileMapIntegrationTests"
description: "GoDotTest integration tests for TileMap and TileMapLayer functionality.
Tests tile operations, cell queries, and tileset configuration."
weight: 20
url: "/gridbuilding/v6-0/api/godot/tilemapintegrationtests/"
---

# TileMapIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class TileMapIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for TileMap and TileMapLayer functionality.
Tests tile operations, cell queries, and tileset configuration.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/TileMapIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up TileMap Integration Tests");
    }
```

**Returns:** `void`

### TileMapLayer_CanBeCreated

```csharp
#region TileMapLayer Creation Tests

    [Test]
    public void TileMapLayer_CanBeCreated()
    {
        // Act
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Assert
        layer.ShouldNotBeNull();

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_DefaultEnabled_IsTrue

```csharp
[Test]
    public void TileMapLayer_DefaultEnabled_IsTrue()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Assert
        layer.Enabled.ShouldBeTrue();

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_TileSet_CanBeAssigned

```csharp
#endregion

    #region TileMapLayer Configuration Tests

    [Test]
    public void TileMapLayer_TileSet_CanBeAssigned()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);
        var tileSet = new TileSet();

        // Act
        layer.TileSet = tileSet;

        // Assert
        layer.TileSet.ShouldNotBeNull();

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_YSortEnabled_CanBeSet

```csharp
[Test]
    public void TileMapLayer_YSortEnabled_CanBeSet()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Act
        layer.YSortEnabled = true;

        // Assert
        layer.YSortEnabled.ShouldBeTrue();

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_YSortOrigin_CanBeSet

```csharp
[Test]
    public void TileMapLayer_YSortOrigin_CanBeSet()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Act
        layer.YSortOrigin = 16;

        // Assert
        layer.YSortOrigin.ShouldBe(16);

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_Enabled_CanBeDisabled

```csharp
[Test]
    public void TileMapLayer_Enabled_CanBeDisabled()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Act
        layer.Enabled = false;

        // Assert
        layer.Enabled.ShouldBeFalse();

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileSet_CanBeCreated

```csharp
#endregion

    #region TileSet Creation Tests

    [Test]
    public void TileSet_CanBeCreated()
    {
        // Act
        var tileSet = new TileSet();

        // Assert
        tileSet.ShouldNotBeNull();
    }
```

**Returns:** `void`

### TileSet_TileSize_CanBeSet

```csharp
[Test]
    public void TileSet_TileSize_CanBeSet()
    {
        // Arrange
        var tileSet = new TileSet();

        // Act
        tileSet.TileSize = new Vector2I(32, 32);

        // Assert
        tileSet.TileSize.ShouldBe(new Vector2I(32, 32));
    }
```

**Returns:** `void`

### TileSet_TileShape_DefaultIsSquare

```csharp
[Test]
    public void TileSet_TileShape_DefaultIsSquare()
    {
        // Arrange
        var tileSet = new TileSet();

        // Assert
        tileSet.TileShape.ShouldBe(TileSet.TileShapeEnum.Square);
    }
```

**Returns:** `void`

### TileSet_TileShape_CanBeSetToIsometric

```csharp
[Test]
    public void TileSet_TileShape_CanBeSetToIsometric()
    {
        // Arrange
        var tileSet = new TileSet();

        // Act
        tileSet.TileShape = TileSet.TileShapeEnum.Isometric;

        // Assert
        tileSet.TileShape.ShouldBe(TileSet.TileShapeEnum.Isometric);
    }
```

**Returns:** `void`

### TileSet_TileShape_CanBeSetToHalfOffsetSquare

```csharp
[Test]
    public void TileSet_TileShape_CanBeSetToHalfOffsetSquare()
    {
        // Arrange
        var tileSet = new TileSet();

        // Act
        tileSet.TileShape = TileSet.TileShapeEnum.HalfOffsetSquare;

        // Assert
        tileSet.TileShape.ShouldBe(TileSet.TileShapeEnum.HalfOffsetSquare);
    }
```

**Returns:** `void`

### TileMapLayer_SetCell_DoesNotThrow

```csharp
#endregion

    #region TileMapLayer Cell Operations Tests

    [Test]
    public void TileMapLayer_SetCell_DoesNotThrow()
    {
        // Arrange
        var layer = new TileMapLayer();
        var tileSet = new TileSet();
        tileSet.TileSize = new Vector2I(16, 16);
        layer.TileSet = tileSet;
        _testScene.AddChild(layer);

        // Act & Assert: Should not throw even without valid source
        Should.NotThrow(() => layer.SetCell(new Vector2I(0, 0), -1));

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_GetCellSourceId_ReturnsNegativeForEmptyCell

```csharp
[Test]
    public void TileMapLayer_GetCellSourceId_ReturnsNegativeForEmptyCell()
    {
        // Arrange
        var layer = new TileMapLayer();
        var tileSet = new TileSet();
        layer.TileSet = tileSet;
        _testScene.AddChild(layer);

        // Act
        var sourceId = layer.GetCellSourceId(new Vector2I(5, 5));

        // Assert: Empty cell returns -1
        sourceId.ShouldBe(-1);

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_GetUsedCells_ReturnsEmptyArrayForEmptyLayer

```csharp
[Test]
    public void TileMapLayer_GetUsedCells_ReturnsEmptyArrayForEmptyLayer()
    {
        // Arrange
        var layer = new TileMapLayer();
        var tileSet = new TileSet();
        layer.TileSet = tileSet;
        _testScene.AddChild(layer);

        // Act
        var usedCells = layer.GetUsedCells();

        // Assert
        usedCells.Count.ShouldBe(0);

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_GetUsedRect_ReturnsZeroRectForEmptyLayer

```csharp
[Test]
    public void TileMapLayer_GetUsedRect_ReturnsZeroRectForEmptyLayer()
    {
        // Arrange
        var layer = new TileMapLayer();
        var tileSet = new TileSet();
        layer.TileSet = tileSet;
        _testScene.AddChild(layer);

        // Act
        var usedRect = layer.GetUsedRect();

        // Assert
        usedRect.Size.ShouldBe(Vector2I.Zero);

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_EraseCell_DoesNotThrow

```csharp
[Test]
    public void TileMapLayer_EraseCell_DoesNotThrow()
    {
        // Arrange
        var layer = new TileMapLayer();
        var tileSet = new TileSet();
        layer.TileSet = tileSet;
        _testScene.AddChild(layer);

        // Act & Assert
        Should.NotThrow(() => layer.EraseCell(new Vector2I(0, 0)));

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_Clear_DoesNotThrow

```csharp
[Test]
    public void TileMapLayer_Clear_DoesNotThrow()
    {
        // Arrange
        var layer = new TileMapLayer();
        var tileSet = new TileSet();
        layer.TileSet = tileSet;
        _testScene.AddChild(layer);

        // Act & Assert
        Should.NotThrow(() => layer.Clear());

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_MapToLocal_ConvertsCellToPosition

```csharp
#endregion

    #region Coordinate Conversion Tests

    [Test]
    public void TileMapLayer_MapToLocal_ConvertsCellToPosition()
    {
        // Arrange
        var layer = new TileMapLayer();
        var tileSet = new TileSet();
        tileSet.TileSize = new Vector2I(16, 16);
        layer.TileSet = tileSet;
        _testScene.AddChild(layer);

        // Act
        var localPos = layer.MapToLocal(new Vector2I(1, 1));

        // Assert: Should return center of tile
        localPos.X.ShouldBeGreaterThan(0);
        localPos.Y.ShouldBeGreaterThan(0);

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_LocalToMap_ConvertsPositionToCell

```csharp
[Test]
    public void TileMapLayer_LocalToMap_ConvertsPositionToCell()
    {
        // Arrange
        var layer = new TileMapLayer();
        var tileSet = new TileSet();
        tileSet.TileSize = new Vector2I(16, 16);
        layer.TileSet = tileSet;
        _testScene.AddChild(layer);

        // Act
        var cellCoord = layer.LocalToMap(new Vector2(24, 24));

        // Assert
        cellCoord.ShouldBe(new Vector2I(1, 1));

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_MapToLocal_AndBack_RoundTrips

```csharp
[Test]
    public void TileMapLayer_MapToLocal_AndBack_RoundTrips()
    {
        // Arrange
        var layer = new TileMapLayer();
        var tileSet = new TileSet();
        tileSet.TileSize = new Vector2I(32, 32);
        layer.TileSet = tileSet;
        _testScene.AddChild(layer);
        var originalCell = new Vector2I(3, 5);

        // Act
        var localPos = layer.MapToLocal(originalCell);
        var resultCell = layer.LocalToMap(localPos);

        // Assert
        resultCell.ShouldBe(originalCell);

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_CollisionEnabled_CanBeDisabled

```csharp
#endregion

    #region Collision Layer Tests

    [Test]
    public void TileMapLayer_CollisionEnabled_CanBeDisabled()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Act
        layer.CollisionEnabled = false;

        // Assert
        layer.CollisionEnabled.ShouldBeFalse();

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_CollisionVisibilityMode_CanBeSet

```csharp
[Test]
    public void TileMapLayer_CollisionVisibilityMode_CanBeSet()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Act
        layer.CollisionVisibilityMode = TileMapLayer.DebugVisibilityMode.ForceShow;

        // Assert
        layer.CollisionVisibilityMode.ShouldBe(TileMapLayer.DebugVisibilityMode.ForceShow);

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_NavigationEnabled_CanBeDisabled

```csharp
#endregion

    #region Navigation Tests

    [Test]
    public void TileMapLayer_NavigationEnabled_CanBeDisabled()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Act
        layer.NavigationEnabled = false;

        // Assert
        layer.NavigationEnabled.ShouldBeFalse();

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_NavigationVisibilityMode_CanBeSet

```csharp
[Test]
    public void TileMapLayer_NavigationVisibilityMode_CanBeSet()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Act
        layer.NavigationVisibilityMode = TileMapLayer.DebugVisibilityMode.ForceHide;

        // Assert
        layer.NavigationVisibilityMode.ShouldBe(TileMapLayer.DebugVisibilityMode.ForceHide);

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

### TileMapLayer_RenderingQuadrantSize_CanBeSet

```csharp
#endregion

    #region Rendering Order Tests

    [Test]
    public void TileMapLayer_RenderingQuadrantSize_CanBeSet()
    {
        // Arrange
        var layer = new TileMapLayer();
        _testScene.AddChild(layer);

        // Act
        layer.RenderingQuadrantSize = 32;

        // Assert
        layer.RenderingQuadrantSize.ShouldBe(32);

        // Cleanup
        layer.QueueFree();
    }
```

**Returns:** `void`

