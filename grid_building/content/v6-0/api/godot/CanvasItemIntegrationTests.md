---
title: "CanvasItemIntegrationTests"
description: "GoDotTest integration tests for CanvasItem and visual properties.
Tests Sprite2D, modulation, visibility, and z-ordering."
weight: 20
url: "/gridbuilding/v6-0/api/godot/canvasitemintegrationtests/"
---

# CanvasItemIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class CanvasItemIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for CanvasItem and visual properties.
Tests Sprite2D, modulation, visibility, and z-ordering.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CanvasItemIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up CanvasItem Integration Tests");
    }
```

**Returns:** `void`

### Node2D_Visible_DefaultsToTrue

```csharp
#region Visibility Tests

    [Test]
    public void Node2D_Visible_DefaultsToTrue()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Assert
        node.Visible.ShouldBeTrue();

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### Node2D_Hide_SetsVisibleFalse

```csharp
[Test]
    public void Node2D_Hide_SetsVisibleFalse()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Act
        node.Hide();

        // Assert
        node.Visible.ShouldBeFalse();

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### Node2D_Show_SetsVisibleTrue

```csharp
[Test]
    public void Node2D_Show_SetsVisibleTrue()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        node.Visible = false;

        // Act
        node.Show();

        // Assert
        node.Visible.ShouldBeTrue();

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### Node2D_ChildInheritsParentVisibility

```csharp
[Test]
    public void Node2D_ChildInheritsParentVisibility()
    {
        // Arrange
        var parent = new Node2D();
        var child = new Node2D();
        parent.AddChild(child);
        _testScene.AddChild(parent);

        // Act
        parent.Visible = false;

        // Assert: Child's own visible is still true, but it won't render
        child.Visible.ShouldBeTrue(); // Local visibility unchanged
        child.IsVisibleInTree().ShouldBeFalse(); // But not visible in tree

        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

### CanvasItem_Modulate_DefaultsToWhite

```csharp
#endregion

    #region Modulation Tests

    [Test]
    public void CanvasItem_Modulate_DefaultsToWhite()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Assert
        node.Modulate.ShouldBe(Colors.White);

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### CanvasItem_Modulate_CanBeChanged

```csharp
[Test]
    public void CanvasItem_Modulate_CanBeChanged()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Act
        node.Modulate = new Color(1, 0, 0, 0.5f); // Red with 50% alpha

        // Assert
        node.Modulate.R.ShouldBe(1f);
        node.Modulate.G.ShouldBe(0f);
        node.Modulate.B.ShouldBe(0f);
        node.Modulate.A.ShouldBe(0.5f, 0.01f);

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### CanvasItem_SelfModulate_IndependentOfModulate

```csharp
[Test]
    public void CanvasItem_SelfModulate_IndependentOfModulate()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Act
        node.Modulate = Colors.Red;
        node.SelfModulate = Colors.Blue;

        // Assert
        node.Modulate.ShouldBe(Colors.Red);
        node.SelfModulate.ShouldBe(Colors.Blue);

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### Node2D_ZIndex_DefaultsToZero

```csharp
#endregion

    #region Z-Index Tests

    [Test]
    public void Node2D_ZIndex_DefaultsToZero()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Assert
        node.ZIndex.ShouldBe(0);

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### Node2D_ZIndex_CanBeNegative

```csharp
[Test]
    public void Node2D_ZIndex_CanBeNegative()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Act
        node.ZIndex = -10;

        // Assert
        node.ZIndex.ShouldBe(-10);

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### Node2D_ZIndex_CanBePositive

```csharp
[Test]
    public void Node2D_ZIndex_CanBePositive()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Act
        node.ZIndex = 100;

        // Assert
        node.ZIndex.ShouldBe(100);

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### Node2D_ZAsRelative_DefaultsToTrue

```csharp
[Test]
    public void Node2D_ZAsRelative_DefaultsToTrue()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Assert
        node.ZAsRelative.ShouldBeTrue();

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### Node2D_ZAsRelative_False_UsesAbsoluteZ

```csharp
[Test]
    public void Node2D_ZAsRelative_False_UsesAbsoluteZ()
    {
        // Arrange
        var parent = new Node2D();
        var child = new Node2D();
        parent.AddChild(child);
        _testScene.AddChild(parent);

        parent.ZIndex = 5;
        child.ZIndex = 10;

        // Act
        child.ZAsRelative = false;

        // Assert: When ZAsRelative is false, child uses its own ZIndex absolutely
        child.ZAsRelative.ShouldBeFalse();
        child.ZIndex.ShouldBe(10);

        // Cleanup
        parent.QueueFree();
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
        // Arrange & Act
        var sprite = new Sprite2D();
        _testScene.AddChild(sprite);

        // Assert
        sprite.ShouldNotBeNull();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### Sprite2D_Centered_DefaultsToTrue

```csharp
[Test]
    public void Sprite2D_Centered_DefaultsToTrue()
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

        // Act & Assert
        sprite.FlipH = true;
        sprite.FlipH.ShouldBeTrue();

        sprite.FlipH = false;
        sprite.FlipH.ShouldBeFalse();

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

        // Act & Assert
        sprite.FlipV = true;
        sprite.FlipV.ShouldBeTrue();

        sprite.FlipV = false;
        sprite.FlipV.ShouldBeFalse();

        // Cleanup
        sprite.QueueFree();
    }
```

**Returns:** `void`

### Node2D_YSortEnabled_CanBeSet

```csharp
#endregion

    #region Draw Order Tests

    [Test]
    public void Node2D_YSortEnabled_CanBeSet()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Act
        node.YSortEnabled = true;

        // Assert
        node.YSortEnabled.ShouldBeTrue();

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

