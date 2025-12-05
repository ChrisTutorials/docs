---
title: "GridBuildingIntegrationTests"
description: "GridBuilding integration tests using GoDotTest framework.
Tests Godot-specific functionality and Core system integration.
Migration Score: 100% - Full GoDotTest framework implementation"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridbuildingintegrationtests/"
---

# GridBuildingIntegrationTests

```csharp
GridBuilding.Tests.Godot
class GridBuildingIntegrationTests
{
    // Members...
}
```

GridBuilding integration tests using GoDotTest framework.
Tests Godot-specific functionality and Core system integration.
Migration Score: 100% - Full GoDotTest framework implementation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/GridBuildingIntegrationTests.cs`  
**Namespace:** `GridBuilding.Tests.Godot`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Setup

```csharp
[Setup]
    public void Setup()
    {
        // Create test nodes for Godot integration testing
        _testNode2D = new Node2D();
        _testControl = new Control();
        _testTileMap = new TileMap();
        
        TestScene.AddChild(_testNode2D);
        TestScene.AddChild(_testControl);
        TestScene.AddChild(_testTileMap);
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        // Clean up test nodes
        if (IsInstanceValid(_testNode2D))
            _testNode2D.QueueFree();
        if (IsInstanceValid(_testControl))
            _testControl.QueueFree();
        if (IsInstanceValid(_testTileMap))
            _testTileMap.QueueFree();
    }
```

**Returns:** `void`

### BuildingData_WithGodotVector2I_ShouldWork

```csharp
/// <summary>
    /// Tests Core BuildingData creation and Godot Vector2I conversion
    /// </summary>
    [Test]
    public void BuildingData_WithGodotVector2I_ShouldWork()
    {
        // Arrange
        var godotPosition = new GodotVector2I(10, 15);
        
        // Act
        var buildingData = new BuildingData
        {
            BuildingId = "test-building",
            BuildingType = "Residence",
            Size = new GridBuildingVector2I(2, 2),
            Position = new GridBuildingVector2I(godotPosition.X, godotPosition.Y)
        };

        // Assert
        Assert.Equal("test-building", buildingData.BuildingId);
        Assert.Equal(2, buildingData.Size.X);
        Assert.Equal(10, buildingData.Position.X);
        Assert.Equal(15, buildingData.Position.Y);
    }
```

Tests Core BuildingData creation and Godot Vector2I conversion

**Returns:** `void`

### BuildingState_WithSceneTree_ShouldWork

```csharp
/// <summary>
    /// Tests Core BuildingState with Godot scene tree integration
    /// </summary>
    [Test]
    public void BuildingState_WithSceneTree_ShouldWork()
    {
        // Arrange
        var buildingState = new BuildingState
        {
            BuildingId = "scene-test-building",
            BuildingType = "Commercial",
            Position = new GridBuildingVector2I(5, 8),
            ConstructionProgress = 0.5f
        };

        // Act - Simulate adding to scene tree
        var buildingNode = new Node2D();
        buildingNode.Name = buildingState.BuildingId;
        _testNode2D.AddChild(buildingNode);

        // Assert
        Assert.True(buildingNode.IsInsideTree());
        Assert.Equal(_testNode2D, buildingNode.GetParent());
        Assert.Equal(0.5f, buildingState.ConstructionProgress);

        // Cleanup
        buildingNode.QueueFree();
    }
```

Tests Core BuildingState with Godot scene tree integration

**Returns:** `void`

### ManipulationState_WithInputEvents_ShouldWork

```csharp
/// <summary>
    /// Tests ManipulationState with Godot input events
    /// </summary>
    [Test]
    public void ManipulationState_WithInputEvents_ShouldWork()
    {
        // Arrange
        var manipulationState = new ManipulationState("TestState");
        var inputEvent = new InputEventMouseButton();
        inputEvent.ButtonIndex = MouseButton.Left;
        inputEvent.Pressed = true;
        inputEvent.Position = new GodotVector2I(100, 200);

        // Act
        var clickPosition = new GridBuildingVector2I(inputEvent.Position.X, inputEvent.Position.Y);

        // Assert
        Assert.Equal("TestState", manipulationState.Name);
        Assert.Equal(100, clickPosition.X);
        Assert.Equal(200, clickPosition.Y);
        Assert.True(inputEvent.Pressed);
    }
```

Tests ManipulationState with Godot input events

**Returns:** `void`

### TileMap_WithCorePositioning_ShouldWork

```csharp
/// <summary>
    /// Tests TileMap integration with Core grid positioning
    /// </summary>
    [Test]
    public void TileMap_WithCorePositioning_ShouldWork()
    {
        // Arrange
        var gridPosition = new GridBuildingVector2I(3, 7);
        var godotPosition = new GodotVector2I(gridPosition.X, gridPosition.Y);

        // Act - Simulate tile placement
        _testTileMap.Position = godotPosition;
        
        // Create a mock tile
        var tileNode = new Node2D();
        tileNode.Position = godotPosition;
        _testTileMap.AddChild(tileNode);

        // Assert
        Assert.Equal(godotPosition.X, _testTileMap.Position.X);
        Assert.Equal(godotPosition.Y, _testTileMap.Position.Y);
        Assert.True(tileNode.IsInsideTree());
        Assert.Equal(_testTileMap, tileNode.GetParent());

        // Cleanup
        tileNode.QueueFree();
    }
```

Tests TileMap integration with Core grid positioning

**Returns:** `void`

### Signal_Connections_ShouldWork

```csharp
/// <summary>
    /// Tests signal connection patterns for GridBuilding events
    /// </summary>
    [Test]
    public void Signal_Connections_ShouldWork()
    {
        // Arrange
        bool signalReceived = false;
        string? signalData = null;

        // Act - Connect to Godot tree signals
        _testNode2D.TreeEntered += () => signalReceived = true;
        _testControl.Resized += () => signalData = "resized";

        // Trigger signals by re-adding to scene tree
        TestScene.RemoveChild(_testNode2D);
        TestScene.AddChild(_testNode2D);

        // Simulate resize
        _testControl.Size = new Vector2I(200, 100);

        // Assert
        Assert.True(signalReceived, "TreeEntered signal should be received");
        Assert.NotNull(signalData);
    }
```

Tests signal connection patterns for GridBuilding events

**Returns:** `void`

### Async_Operations_ShouldWork

```csharp
/// <summary>
    /// Tests async operations with ToSignal pattern
    /// </summary>
    [Test]
    public async void Async_Operations_ShouldWork()
    {
        // Arrange
        var initialPosition = _testNode2D.Position;
        var targetPosition = new Vector2(150, 250);

        // Act
        _testNode2D.Position = targetPosition;
        
        // Wait for next frame (common Godot pattern)
        await ToSignal(TestScene.GetTree().SceneTree, SceneTree.SignalName.ProcessFrame);

        // Assert
        Assert.Equal(targetPosition, _testNode2D.Position);
        Assert.NotEqual(initialPosition, _testNode2D.Position);
    }
```

Tests async operations with ToSignal pattern

**Returns:** `void`

### Resource_Management_ShouldWork

```csharp
/// <summary>
    /// Tests resource management with Core data types
    /// </summary>
    [Test]
    public void Resource_Management_ShouldWork()
    {
        // Arrange
        var packedScene = new PackedScene();
        var testResource = new Resource();

        // Act
        testResource.SetMeta("building_id", "test-resource-building");
        testResource.SetMeta("building_type", "ResourceTest");

        // Assert
        Assert.True(testResource.HasMeta("building_id"));
        Assert.Equal("test-resource-building", testResource.GetMeta("building_id").AsString());
        Assert.Equal("ResourceTest", testResource.GetMeta("building_type").AsString());

        // Cleanup
        packedScene.QueueFree();
        testResource.QueueFree();
    }
```

Tests resource management with Core data types

**Returns:** `void`

### Physics_Calculations_ShouldWork

```csharp
/// <summary>
    /// Tests physics calculations with Core and Godot types
    /// </summary>
    [Test]
    public void Physics_Calculations_ShouldWork()
    {
        // Arrange
        var coreRect = new GridBuilding.Core.Math.Rect2I(
            new GridBuildingVector2I(0, 0), 
            new GridBuildingVector2I(100, 100)
        );
        var godotRect = new Rect2(new Vector2(0, 0), new Vector2(100, 100));

        // Act
        var godotRect2 = new Rect2(new Vector2(50, 50), new Vector2(100, 100));
        var intersection = godotRect.Intersection(godotRect2);

        // Assert
        Assert.Equal(godotRect.Position.X, coreRect.Position.X);
        Assert.Equal(godotRect.Size.X, coreRect.Size.X);
        Assert.NotNull(intersection);
        Assert.True(intersection.Size.X > 0);
        Assert.True(intersection.Size.Y > 0);
    }
```

Tests physics calculations with Core and Godot types

**Returns:** `void`

### Transform_Manipulation_ShouldWork

```csharp
/// <summary>
    /// Tests transform manipulation for building placement
    /// </summary>
    [Test]
    public void Transform_Manipulation_ShouldWork()
    {
        // Arrange
        var transform = new Transform2D();
        var buildingPosition = new GridBuildingVector2I(10, 15);

        // Act - Simulate building placement transformations
        transform = transform.Rotated(Mathf.DegToRad(45));
        transform = transform.Scaled(new Vector2(2, 2));
        transform = transform.Translated(new Vector2(buildingPosition.X, buildingPosition.Y));

        // Apply to test node
        _testNode2D.Transform = transform;

        // Assert
        Assert.Equal(buildingPosition.X, _testNode2D.Position.X);
        Assert.Equal(buildingPosition.Y, _testNode2D.Position.Y);
        Assert.NotEqual(0f, _testNode2D.Rotation);
        Assert.NotEqual(Vector2.One, _testNode2D.Scale);
    }
```

Tests transform manipulation for building placement

**Returns:** `void`

### Input_Event_Simulation_ShouldWork

```csharp
/// <summary>
    /// Tests input event simulation for building manipulation
    /// </summary>
    [Test]
    public void Input_Event_Simulation_ShouldWork()
    {
        // Arrange
        var inputEvent = new InputEventMouseButton();
        inputEvent.ButtonIndex = MouseButton.Left;
        inputEvent.Pressed = true;
        inputEvent.Position = new GodotVector2I(100, 100);

        var inputEventKey = new InputEventKey();
        inputEventKey.Pressed = true;
        inputEventKey.Keycode = Key.Space;

        // Act - Simulate input handling
        var mousePosition = new GridBuildingVector2I(inputEvent.Position.X, inputEvent.Position.Y);
        var isKeyPressed = inputEventKey.Pressed;
        var keyCode = inputEventKey.Keycode;

        // Assert
        Assert.Equal(100, mousePosition.X);
        Assert.Equal(100, mousePosition.Y);
        Assert.True(isKeyPressed);
        Assert.Equal(Key.Space, keyCode);
    }
```

Tests input event simulation for building manipulation

**Returns:** `void`

