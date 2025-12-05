---
title: "ResourceIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/resourceintegrationtests/"
---

# ResourceIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class ResourceIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for Resource and PackedScene handling.
Tests resource loading, instancing, and scene management.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ResourceIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Resource Integration Tests");
    }
```

**Returns:** `void`

### Resource_CanBeCreated

```csharp
#region Resource Creation Tests

    [Test]
    public void Resource_CanBeCreated()
    {
        // Act
        var resource = new Resource();

        // Assert
        resource.ShouldNotBeNull();

        // Cleanup
        resource.Dispose();
    }
```

**Returns:** `void`

### Resource_ResourcePath_EmptyByDefault

```csharp
[Test]
    public void Resource_ResourcePath_EmptyByDefault()
    {
        // Arrange
        var resource = new Resource();

        // Assert
        resource.ResourcePath.ShouldBeEmpty();

        // Cleanup
        resource.Dispose();
    }
```

**Returns:** `void`

### Resource_ResourceName_CanBeSet

```csharp
[Test]
    public void Resource_ResourceName_CanBeSet()
    {
        // Arrange
        var resource = new Resource();

        // Act
        resource.ResourceName = "TestResource";

        // Assert
        resource.ResourceName.ShouldBe("TestResource");

        // Cleanup
        resource.Dispose();
    }
```

**Returns:** `void`

### RectangleShape2D_IsResource

```csharp
#endregion

    #region Shape2D Resource Tests

    [Test]
    public void RectangleShape2D_IsResource()
    {
        // Arrange
        var shape = new RectangleShape2D();

        // Assert
        shape.ShouldBeOfType<Resource>();

        // Cleanup
        shape.Dispose();
    }
```

**Returns:** `void`

### CircleShape2D_IsResource

```csharp
[Test]
    public void CircleShape2D_IsResource()
    {
        // Arrange
        var shape = new CircleShape2D();

        // Assert
        shape.ShouldBeOfType<Resource>();

        // Cleanup
        shape.Dispose();
    }
```

**Returns:** `void`

### ConvexPolygonShape2D_IsResource

```csharp
[Test]
    public void ConvexPolygonShape2D_IsResource()
    {
        // Arrange
        var shape = new ConvexPolygonShape2D();

        // Assert
        shape.ShouldBeOfType<Resource>();

        // Cleanup
        shape.Dispose();
    }
```

**Returns:** `void`

### TileSet_CanBeCreated

```csharp
#endregion

    #region TileSet Resource Tests

    [Test]
    public void TileSet_CanBeCreated()
    {
        // Act
        var tileSet = new TileSet();

        // Assert
        tileSet.ShouldNotBeNull();

        // Cleanup
        tileSet.Dispose();
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

        // Cleanup
        tileSet.Dispose();
    }
```

**Returns:** `void`

### TileSet_TileShape_DefaultsToSquare

```csharp
[Test]
    public void TileSet_TileShape_DefaultsToSquare()
    {
        // Arrange
        var tileSet = new TileSet();

        // Assert
        tileSet.TileShape.ShouldBe(TileSet.TileShapeEnum.Square);

        // Cleanup
        tileSet.Dispose();
    }
```

**Returns:** `void`

### TileSet_TileShape_CanBeIsometric

```csharp
[Test]
    public void TileSet_TileShape_CanBeIsometric()
    {
        // Arrange
        var tileSet = new TileSet();

        // Act
        tileSet.TileShape = TileSet.TileShapeEnum.Isometric;

        // Assert
        tileSet.TileShape.ShouldBe(TileSet.TileShapeEnum.Isometric);

        // Cleanup
        tileSet.Dispose();
    }
```

**Returns:** `void`

### ShaderMaterial_CanBeCreated

```csharp
#endregion

    #region Material Resource Tests

    [Test]
    public void ShaderMaterial_CanBeCreated()
    {
        // Act
        var material = new ShaderMaterial();

        // Assert
        material.ShouldNotBeNull();

        // Cleanup
        material.Dispose();
    }
```

**Returns:** `void`

### CanvasItemMaterial_CanBeCreated

```csharp
[Test]
    public void CanvasItemMaterial_CanBeCreated()
    {
        // Act
        var material = new CanvasItemMaterial();

        // Assert
        material.ShouldNotBeNull();

        // Cleanup
        material.Dispose();
    }
```

**Returns:** `void`

### Gradient_CanBeCreated

```csharp
#endregion

    #region Gradient Resource Tests

    [Test]
    public void Gradient_CanBeCreated()
    {
        // Act
        var gradient = new Gradient();

        // Assert
        gradient.ShouldNotBeNull();

        // Cleanup
        gradient.Dispose();
    }
```

**Returns:** `void`

### Gradient_Colors_CanBeSet

```csharp
[Test]
    public void Gradient_Colors_CanBeSet()
    {
        // Arrange
        var gradient = new Gradient();

        // Act
        gradient.SetColor(0, Colors.Red);
        gradient.SetColor(1, Colors.Blue);

        // Assert
        gradient.GetColor(0).ShouldBe(Colors.Red);
        gradient.GetColor(1).ShouldBe(Colors.Blue);

        // Cleanup
        gradient.Dispose();
    }
```

**Returns:** `void`

### Curve_CanBeCreated

```csharp
#endregion

    #region Curve Resource Tests

    [Test]
    public void Curve_CanBeCreated()
    {
        // Act
        var curve = new Curve();

        // Assert
        curve.ShouldNotBeNull();

        // Cleanup
        curve.Dispose();
    }
```

**Returns:** `void`

### Curve_Points_CanBeAdded

```csharp
[Test]
    public void Curve_Points_CanBeAdded()
    {
        // Arrange
        var curve = new Curve();

        // Act
        curve.AddPoint(new Vector2(0, 0));
        curve.AddPoint(new Vector2(1, 1));

        // Assert
        curve.PointCount.ShouldBe(2);

        // Cleanup
        curve.Dispose();
    }
```

**Returns:** `void`

### PackedScene_CanInstantiateNode

```csharp
#endregion

    #region PackedScene Tests

    [Test]
    public void PackedScene_CanInstantiateNode()
    {
        // Arrange: Create a simple scene programmatically
        var scene = new PackedScene();
        var rootNode = new Node2D();
        rootNode.Name = "TestRoot";
        _testScene.AddChild(rootNode);
        
        // Pack the scene
        scene.Pack(rootNode);

        // Act: Instantiate from packed scene
        var instance = scene.Instantiate<Node2D>();
        _testScene.AddChild(instance);

        // Assert
        instance.ShouldNotBeNull();
        instance.Name.ToString().ShouldBe("TestRoot");

        // Cleanup
        rootNode.QueueFree();
        instance.QueueFree();
        scene.Dispose();
    }
```

**Returns:** `void`

### PackedScene_InstantiatedNode_HasCorrectType

```csharp
[Test]
    public void PackedScene_InstantiatedNode_HasCorrectType()
    {
        // Arrange
        var scene = new PackedScene();
        var rootNode = new Sprite2D();
        rootNode.Name = "TestSprite";
        _testScene.AddChild(rootNode);
        scene.Pack(rootNode);

        // Act
        var instance = scene.Instantiate();
        _testScene.AddChild(instance);

        // Assert
        instance.ShouldBeOfType<Sprite2D>();

        // Cleanup
        rootNode.QueueFree();
        instance.QueueFree();
        scene.Dispose();
    }
```

**Returns:** `void`

### PackedScene_CanPackHierarchy

```csharp
[Test]
    public void PackedScene_CanPackHierarchy()
    {
        // Arrange
        var scene = new PackedScene();
        var root = new Node2D { Name = "Root" };
        var child1 = new Node2D { Name = "Child1" };
        var child2 = new Node2D { Name = "Child2" };
        root.AddChild(child1);
        root.AddChild(child2);
        _testScene.AddChild(root);
        scene.Pack(root);

        // Act
        var instance = scene.Instantiate<Node2D>();
        _testScene.AddChild(instance);

        // Assert
        instance.GetChildCount().ShouldBe(2);
        instance.GetChild(0).Name.ToString().ShouldBe("Child1");
        instance.GetChild(1).Name.ToString().ShouldBe("Child2");

        // Cleanup
        root.QueueFree();
        instance.QueueFree();
        scene.Dispose();
    }
```

**Returns:** `void`

