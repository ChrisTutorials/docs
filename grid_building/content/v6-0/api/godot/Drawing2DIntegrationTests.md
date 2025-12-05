---
title: "Drawing2DIntegrationTests"
description: "GoDotTest integration tests for drawing and 2D rendering.
Tests Line2D, Polygon2D, and custom drawing operations."
weight: 20
url: "/gridbuilding/v6-0/api/godot/drawing2dintegrationtests/"
---

# Drawing2DIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class Drawing2DIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for drawing and 2D rendering.
Tests Line2D, Polygon2D, and custom drawing operations.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Drawing2DIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Drawing2D Integration Tests");
    }
```

**Returns:** `void`

### Line2D_CanBeCreated

```csharp
#region Line2D Tests

    [Test]
    public void Line2D_CanBeCreated()
    {
        // Act
        var line = new Line2D();
        _testScene.AddChild(line);

        // Assert
        line.ShouldNotBeNull();

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_AddPoint_IncreasesPointCount

```csharp
[Test]
    public void Line2D_AddPoint_IncreasesPointCount()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);

        // Act
        line.AddPoint(new Vector2(0, 0));
        line.AddPoint(new Vector2(100, 100));

        // Assert
        line.GetPointCount().ShouldBe(2);

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_GetPointPosition_ReturnsCorrectPosition

```csharp
[Test]
    public void Line2D_GetPointPosition_ReturnsCorrectPosition()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);
        line.AddPoint(new Vector2(50, 75));

        // Act
        var position = line.GetPointPosition(0);

        // Assert
        position.ShouldBe(new Vector2(50, 75));

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_SetPointPosition_UpdatesPosition

```csharp
[Test]
    public void Line2D_SetPointPosition_UpdatesPosition()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);
        line.AddPoint(new Vector2(0, 0));

        // Act
        line.SetPointPosition(0, new Vector2(100, 200));

        // Assert
        line.GetPointPosition(0).ShouldBe(new Vector2(100, 200));

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_Width_CanBeSet

```csharp
[Test]
    public void Line2D_Width_CanBeSet()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);

        // Act
        line.Width = 5.0f;

        // Assert
        line.Width.ShouldBe(5.0f);

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_DefaultColor_CanBeSet

```csharp
[Test]
    public void Line2D_DefaultColor_CanBeSet()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);

        // Act
        line.DefaultColor = Colors.Red;

        // Assert
        line.DefaultColor.ShouldBe(Colors.Red);

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_ClearPoints_RemovesAllPoints

```csharp
[Test]
    public void Line2D_ClearPoints_RemovesAllPoints()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);
        line.AddPoint(new Vector2(0, 0));
        line.AddPoint(new Vector2(100, 100));
        line.AddPoint(new Vector2(200, 0));

        // Act
        line.ClearPoints();

        // Assert
        line.GetPointCount().ShouldBe(0);

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_RemovePoint_DecreasesPointCount

```csharp
[Test]
    public void Line2D_RemovePoint_DecreasesPointCount()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);
        line.AddPoint(new Vector2(0, 0));
        line.AddPoint(new Vector2(100, 100));

        // Act
        line.RemovePoint(0);

        // Assert
        line.GetPointCount().ShouldBe(1);

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_BeginCapMode_CanBeSet

```csharp
[Test]
    public void Line2D_BeginCapMode_CanBeSet()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);

        // Act
        line.BeginCapMode = Line2D.LineCapMode.Round;

        // Assert
        line.BeginCapMode.ShouldBe(Line2D.LineCapMode.Round);

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_EndCapMode_CanBeSet

```csharp
[Test]
    public void Line2D_EndCapMode_CanBeSet()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);

        // Act
        line.EndCapMode = Line2D.LineCapMode.Box;

        // Assert
        line.EndCapMode.ShouldBe(Line2D.LineCapMode.Box);

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Line2D_JointMode_CanBeSet

```csharp
[Test]
    public void Line2D_JointMode_CanBeSet()
    {
        // Arrange
        var line = new Line2D();
        _testScene.AddChild(line);

        // Act
        line.JointMode = Line2D.LineJointMode.Bevel;

        // Assert
        line.JointMode.ShouldBe(Line2D.LineJointMode.Bevel);

        // Cleanup
        line.QueueFree();
    }
```

**Returns:** `void`

### Polygon2D_CanBeCreated

```csharp
#endregion

    #region Polygon2D Tests

    [Test]
    public void Polygon2D_CanBeCreated()
    {
        // Act
        var polygon = new Polygon2D();
        _testScene.AddChild(polygon);

        // Assert
        polygon.ShouldNotBeNull();

        // Cleanup
        polygon.QueueFree();
    }
```

**Returns:** `void`

### Polygon2D_Polygon_CanBeSet

```csharp
[Test]
    public void Polygon2D_Polygon_CanBeSet()
    {
        // Arrange
        var polygon = new Polygon2D();
        _testScene.AddChild(polygon);
        var points = new Vector2[]
        {
            new Vector2(0, 0),
            new Vector2(100, 0),
            new Vector2(50, 100)
        };

        // Act
        polygon.Polygon = points;

        // Assert
        polygon.Polygon.Length.ShouldBe(3);
        polygon.Polygon[0].ShouldBe(new Vector2(0, 0));
        polygon.Polygon[1].ShouldBe(new Vector2(100, 0));
        polygon.Polygon[2].ShouldBe(new Vector2(50, 100));

        // Cleanup
        polygon.QueueFree();
    }
```

**Returns:** `void`

### Polygon2D_Color_CanBeSet

```csharp
[Test]
    public void Polygon2D_Color_CanBeSet()
    {
        // Arrange
        var polygon = new Polygon2D();
        _testScene.AddChild(polygon);

        // Act
        polygon.Color = Colors.Blue;

        // Assert
        polygon.Color.ShouldBe(Colors.Blue);

        // Cleanup
        polygon.QueueFree();
    }
```

**Returns:** `void`

### Polygon2D_VertexColors_CanBeSet

```csharp
[Test]
    public void Polygon2D_VertexColors_CanBeSet()
    {
        // Arrange
        var polygon = new Polygon2D();
        _testScene.AddChild(polygon);
        polygon.Polygon = new Vector2[]
        {
            new Vector2(0, 0),
            new Vector2(100, 0),
            new Vector2(50, 100)
        };
        var colors = new Color[] { Colors.Red, Colors.Green, Colors.Blue };

        // Act
        polygon.VertexColors = colors;

        // Assert
        polygon.VertexColors.Length.ShouldBe(3);

        // Cleanup
        polygon.QueueFree();
    }
```

**Returns:** `void`

### Polygon2D_Offset_CanBeSet

```csharp
[Test]
    public void Polygon2D_Offset_CanBeSet()
    {
        // Arrange
        var polygon = new Polygon2D();
        _testScene.AddChild(polygon);

        // Act
        polygon.Offset = new Vector2(25, 50);

        // Assert
        polygon.Offset.ShouldBe(new Vector2(25, 50));

        // Cleanup
        polygon.QueueFree();
    }
```

**Returns:** `void`

### Polygon2D_Antialiased_CanBeSet

```csharp
[Test]
    public void Polygon2D_Antialiased_CanBeSet()
    {
        // Arrange
        var polygon = new Polygon2D();
        _testScene.AddChild(polygon);

        // Act
        polygon.Antialiased = true;

        // Assert
        polygon.Antialiased.ShouldBeTrue();

        // Cleanup
        polygon.QueueFree();
    }
```

**Returns:** `void`

### Path2D_CanBeCreated

```csharp
#endregion

    #region Path2D Tests

    [Test]
    public void Path2D_CanBeCreated()
    {
        // Act
        var path = new Path2D();
        _testScene.AddChild(path);

        // Assert
        path.ShouldNotBeNull();

        // Cleanup
        path.QueueFree();
    }
```

**Returns:** `void`

### Path2D_Curve_CanBeAssigned

```csharp
[Test]
    public void Path2D_Curve_CanBeAssigned()
    {
        // Arrange
        var path = new Path2D();
        _testScene.AddChild(path);
        var curve = new Curve2D();

        // Act
        path.Curve = curve;

        // Assert
        path.Curve.ShouldNotBeNull();

        // Cleanup
        path.QueueFree();
    }
```

**Returns:** `void`

### Curve2D_AddPoint_IncreasesPointCount

```csharp
[Test]
    public void Curve2D_AddPoint_IncreasesPointCount()
    {
        // Arrange
        var curve = new Curve2D();

        // Act
        curve.AddPoint(new Vector2(0, 0));
        curve.AddPoint(new Vector2(100, 100));

        // Assert
        curve.PointCount.ShouldBe(2);
    }
```

**Returns:** `void`

### Curve2D_GetPointPosition_ReturnsCorrectPosition

```csharp
[Test]
    public void Curve2D_GetPointPosition_ReturnsCorrectPosition()
    {
        // Arrange
        var curve = new Curve2D();
        curve.AddPoint(new Vector2(50, 75));

        // Act
        var position = curve.GetPointPosition(0);

        // Assert
        position.ShouldBe(new Vector2(50, 75));
    }
```

**Returns:** `void`

### Curve2D_GetBakedLength_ReturnsLength

```csharp
[Test]
    public void Curve2D_GetBakedLength_ReturnsLength()
    {
        // Arrange
        var curve = new Curve2D();
        curve.AddPoint(new Vector2(0, 0));
        curve.AddPoint(new Vector2(100, 0));

        // Act
        var length = curve.GetBakedLength();

        // Assert
        length.ShouldBeGreaterThan(0);
    }
```

**Returns:** `void`

### Sprite2D_CanBeCreated

```csharp
#endregion

    #region Sprite2D Tests

    [Test]
    public void Sprite2D_CanBeCreated()
    {
        // Act
        var sprite = new Sprite2D();
        _testScene.AddChild(sprite);

        // Assert
        sprite.ShouldNotBeNull();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### Sprite2D_Centered_DefaultIsTrue

```csharp
[Test]
    public void Sprite2D_Centered_DefaultIsTrue()
    {
        // Arrange
        var sprite = new Sprite2D();
        _testScene.AddChild(sprite);

        // Assert
        sprite.Centered.ShouldBeTrue();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### Sprite2D_Offset_CanBeSet

```csharp
[Test]
    public void Sprite2D_Offset_CanBeSet()
    {
        // Arrange
        var sprite = new Sprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.Offset = new Vector2(10, 20);

        // Assert
        sprite.Offset.ShouldBe(new Vector2(10, 20));

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### Sprite2D_FlipH_CanBeToggled

```csharp
[Test]
    public void Sprite2D_FlipH_CanBeToggled()
    {
        // Arrange
        var sprite = new Sprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.FlipH = true;

        // Assert
        sprite.FlipH.ShouldBeTrue();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### Sprite2D_FlipV_CanBeToggled

```csharp
[Test]
    public void Sprite2D_FlipV_CanBeToggled()
    {
        // Arrange
        var sprite = new Sprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.FlipV = true;

        // Assert
        sprite.FlipV.ShouldBeTrue();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### Sprite2D_Hframes_CanBeSet

```csharp
[Test]
    public void Sprite2D_Hframes_CanBeSet()
    {
        // Arrange
        var sprite = new Sprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.Hframes = 4;

        // Assert
        sprite.Hframes.ShouldBe(4);

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### Sprite2D_Vframes_CanBeSet

```csharp
[Test]
    public void Sprite2D_Vframes_CanBeSet()
    {
        // Arrange
        var sprite = new Sprite2D();
        _testScene.AddChild(sprite);

        // Act
        sprite.Vframes = 3;

        // Assert
        sprite.Vframes.ShouldBe(3);

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### Sprite2D_Frame_CanBeSet

```csharp
[Test]
    public void Sprite2D_Frame_CanBeSet()
    {
        // Arrange
        var sprite = new Sprite2D();
        _testScene.AddChild(sprite);
        sprite.Hframes = 4;
        sprite.Vframes = 4;

        // Act
        sprite.Frame = 5;

        // Assert
        sprite.Frame.ShouldBe(5);

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

