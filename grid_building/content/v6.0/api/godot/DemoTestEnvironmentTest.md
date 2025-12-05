---
title: "DemoTestEnvironmentTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/demotestenvironmenttest/"
---

# DemoTestEnvironmentTest

```csharp
GridBuilding.Godot.Tests.Demo
class DemoTestEnvironmentTest
{
    // Members...
}
```

C# tests for demo test environment utilities
Mirrors GDScript tests in demo_test_environment.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/DemoTestEnvironmentTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Demo`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### DemoTestEnvironment_WithValidScene_ShouldInitializeCorrectly

```csharp
[Fact]
    public void DemoTestEnvironment_WithValidScene_ShouldInitializeCorrectly()
    {
        // Arrange
        var demoScene = new PackedScene();
        
        // Act
        var env = new DemoTestEnvironment(demoScene);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### Setup_WithValidDemoScene_ShouldInitializeComponents

```csharp
[Fact]
    public async Task Setup_WithValidDemoScene_ShouldInitializeComponents()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);

        // Act
        await env.Setup();

        // Assert
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `Task`

### Setup_WithNullScene_ShouldThrowException

```csharp
[Fact]
    public async Task Setup_WithNullScene_ShouldThrowException()
    {
        // Arrange
        var env = new DemoTestEnvironment(null);

        // Act & Assert
        await Assert.ThrowsAsync<ArgumentNullException>(async () => await env.Setup());
    }
```

**Returns:** `Task`

### GetWorld_AfterSetup_ShouldReturnValidWorld

```csharp
[Fact]
    public async Task GetWorld_AfterSetup_ShouldReturnValidWorld()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        var world = env.GetWorld();

        // Assert
        ;
        Assert.IsType<World>(world);
    }
```

**Returns:** `Task`

### GetLevel_AfterSetup_ShouldReturnValidLevel

```csharp
[Fact]
    public async Task GetLevel_AfterSetup_ShouldReturnValidLevel()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        var level = env.GetLevel();

        // Assert
        ;
        Assert.IsType<Level>(level);
    }
```

**Returns:** `Task`

### GetTileMapLayers_AfterSetup_ShouldReturnValidLayers

```csharp
[Fact]
    public async Task GetTileMapLayers_AfterSetup_ShouldReturnValidLayers()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        var layers = env.GetTileMapLayers();

        // Assert
        ;
        ;
    }
```

**Returns:** `Task`

### GetGridPositioner_AfterSetup_ShouldReturnValidPositioner

```csharp
[Fact]
    public async Task GetGridPositioner_AfterSetup_ShouldReturnValidPositioner()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        var positioner = env.GetGridPositioner();

        // Assert
        ;
        Assert.IsType<Node2D>(positioner);
    }
```

**Returns:** `Task`

### GetInjectorSystem_AfterSetup_ShouldReturnValidInjector

```csharp
[Fact]
    public async Task GetInjectorSystem_AfterSetup_ShouldReturnValidInjector()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        var injector = env.GetInjectorSystem();

        // Assert
        ;
        Assert.IsType<InjectorSystem>(injector);
    }
```

**Returns:** `Task`

### GetGridTargetingState_AfterSetup_ShouldReturnValidState

```csharp
[Fact]
    public async Task GetGridTargetingState_AfterSetup_ShouldReturnValidState()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        var targetingState = env.GetGridTargetingState();

        // Assert
        ;
        Assert.IsType<GridTargetingState>(targetingState);
    }
```

**Returns:** `Task`

### GetIndicatorManager_AfterSetup_ShouldReturnValidManager

```csharp
[Fact]
    public async Task GetIndicatorManager_AfterSetup_ShouldReturnValidManager()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        var indicatorManager = env.GetIndicatorManager();

        // Assert
        ;
        Assert.IsType<IndicatorManager>(indicatorManager);
    }
```

**Returns:** `Task`

### GetTileCenterGlobal_AfterSetup_ShouldReturnValidPosition

```csharp
[Fact]
    public async Task GetTileCenterGlobal_AfterSetup_ShouldReturnValidPosition()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        var tileCenter = env.GetTileCenterGlobal();

        // Assert
        ;
    }
```

**Returns:** `Task`

### SimulateFrames_WithValidCount_ShouldSimulateCorrectly

```csharp
[Fact]
    public async Task SimulateFrames_WithValidCount_ShouldSimulateCorrectly()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        env.SimulateFrames(5);

        // Assert - Should not throw
        ;
    }
```

**Returns:** `Task`

### Teardown_AfterSetup_ShouldCleanupCorrectly

```csharp
[Fact]
    public async Task Teardown_AfterSetup_ShouldCleanupCorrectly()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        env.Teardown();

        // Assert
        ;
    }
```

**Returns:** `Task`

### Setup_WithMultipleCalls_ShouldNotDuplicateComponents

```csharp
[Fact]
    public async Task Setup_WithMultipleCalls_ShouldNotDuplicateComponents()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);

        // Act
        await env.Setup();
        var firstWorld = env.GetWorld();
        await env.Setup(); // Second call
        var secondWorld = env.GetWorld();

        // Assert
        ; // Should be same instance
        ;
    }
```

**Returns:** `Task`

### SimulateFrames_WithVariousCounts_ShouldWorkCorrectly

```csharp
[Theory]
    [InlineData(1)]
    [InlineData(5)]
    [InlineData(10)]
    public async Task SimulateFrames_WithVariousCounts_ShouldWorkCorrectly(int frameCount)
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act & Assert - Should not throw for any valid frame count
        env.SimulateFrames(frameCount);
        ;
    }
```

**Returns:** `Task`

**Parameters:**
- `int frameCount`

### DemoScenePaths_ShouldContainExpectedValues

```csharp
[Fact]
    public void DemoScenePaths_ShouldContainExpectedValues()
    {
        // Assert
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### GetObjectsLayer_AfterSetup_ShouldReturnValidLayer

```csharp
[Fact]
    public async Task GetObjectsLayer_AfterSetup_ShouldReturnValidLayer()
    {
        // Arrange
        var demoScene = CreateTestDemoScene();
        var env = new DemoTestEnvironment(demoScene);
        await env.Setup();

        // Act
        var objectsLayer = env.GetObjectsLayer();

        // Assert
        ;
        Assert.IsType<Node2D>(objectsLayer);
    }
```

**Returns:** `Task`

