---
title: "Camera2DIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/camera2dintegrationtests/"
---

# Camera2DIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class Camera2DIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for Camera2D functionality.
Tests camera positioning, zoom, limits, and smoothing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Camera2DIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Camera2D Integration Tests");
    }
```

**Returns:** `void`

### Camera2D_CanBeCreated

```csharp
#region Camera2D Creation Tests

    [Test]
    public void Camera2D_CanBeCreated()
    {
        // Act
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Assert
        camera.ShouldNotBeNull();

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_DefaultEnabled_IsTrue

```csharp
[Test]
    public void Camera2D_DefaultEnabled_IsTrue()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Assert
        camera.Enabled.ShouldBeTrue();

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_Zoom_DefaultIsOne

```csharp
#endregion

    #region Zoom Tests

    [Test]
    public void Camera2D_Zoom_DefaultIsOne()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Assert
        camera.Zoom.ShouldBe(Vector2.One);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_Zoom_CanBeSet

```csharp
[Test]
    public void Camera2D_Zoom_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.Zoom = new Vector2(2.0f, 2.0f);

        // Assert
        camera.Zoom.ShouldBe(new Vector2(2.0f, 2.0f));

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_Zoom_CanBeZoomedOut

```csharp
[Test]
    public void Camera2D_Zoom_CanBeZoomedOut()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.Zoom = new Vector2(0.5f, 0.5f);

        // Assert
        camera.Zoom.ShouldBe(new Vector2(0.5f, 0.5f));

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_Offset_DefaultIsZero

```csharp
#endregion

    #region Offset Tests

    [Test]
    public void Camera2D_Offset_DefaultIsZero()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Assert
        camera.Offset.ShouldBe(Vector2.Zero);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_Offset_CanBeSet

```csharp
[Test]
    public void Camera2D_Offset_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.Offset = new Vector2(100, 50);

        // Assert
        camera.Offset.ShouldBe(new Vector2(100, 50));

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_LimitLeft_CanBeSet

```csharp
#endregion

    #region Limit Tests

    [Test]
    public void Camera2D_LimitLeft_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.LimitLeft = -500;

        // Assert
        camera.LimitLeft.ShouldBe(-500);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_LimitRight_CanBeSet

```csharp
[Test]
    public void Camera2D_LimitRight_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.LimitRight = 1000;

        // Assert
        camera.LimitRight.ShouldBe(1000);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_LimitTop_CanBeSet

```csharp
[Test]
    public void Camera2D_LimitTop_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.LimitTop = -200;

        // Assert
        camera.LimitTop.ShouldBe(-200);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_LimitBottom_CanBeSet

```csharp
[Test]
    public void Camera2D_LimitBottom_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.LimitBottom = 800;

        // Assert
        camera.LimitBottom.ShouldBe(800);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_LimitSmoothed_CanBeEnabled

```csharp
[Test]
    public void Camera2D_LimitSmoothed_CanBeEnabled()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.LimitSmoothed = true;

        // Assert
        camera.LimitSmoothed.ShouldBeTrue();

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_PositionSmoothingEnabled_CanBeSet

```csharp
#endregion

    #region Smoothing Tests

    [Test]
    public void Camera2D_PositionSmoothingEnabled_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.PositionSmoothingEnabled = true;

        // Assert
        camera.PositionSmoothingEnabled.ShouldBeTrue();

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_PositionSmoothingSpeed_CanBeSet

```csharp
[Test]
    public void Camera2D_PositionSmoothingSpeed_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.PositionSmoothingSpeed = 10.0f;

        // Assert
        camera.PositionSmoothingSpeed.ShouldBe(10.0f);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_RotationSmoothingEnabled_CanBeSet

```csharp
[Test]
    public void Camera2D_RotationSmoothingEnabled_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.RotationSmoothingEnabled = true;

        // Assert
        camera.RotationSmoothingEnabled.ShouldBeTrue();

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_RotationSmoothingSpeed_CanBeSet

```csharp
[Test]
    public void Camera2D_RotationSmoothingSpeed_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.RotationSmoothingSpeed = 5.0f;

        // Assert
        camera.RotationSmoothingSpeed.ShouldBe(5.0f);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_DragHorizontalEnabled_CanBeSet

```csharp
#endregion

    #region Drag Tests

    [Test]
    public void Camera2D_DragHorizontalEnabled_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.DragHorizontalEnabled = true;

        // Assert
        camera.DragHorizontalEnabled.ShouldBeTrue();

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_DragVerticalEnabled_CanBeSet

```csharp
[Test]
    public void Camera2D_DragVerticalEnabled_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.DragVerticalEnabled = true;

        // Assert
        camera.DragVerticalEnabled.ShouldBeTrue();

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_DragLeftMargin_CanBeSet

```csharp
[Test]
    public void Camera2D_DragLeftMargin_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.DragLeftMargin = 0.3f;

        // Assert
        camera.DragLeftMargin.ShouldBe(0.3f);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_DragRightMargin_CanBeSet

```csharp
[Test]
    public void Camera2D_DragRightMargin_CanBeSet()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.DragRightMargin = 0.3f;

        // Assert
        camera.DragRightMargin.ShouldBe(0.3f);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_AnchorMode_CanBeSetToDragCenter

```csharp
#endregion

    #region Anchor Mode Tests

    [Test]
    public void Camera2D_AnchorMode_CanBeSetToDragCenter()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.AnchorMode = Camera2D.AnchorModeEnum.DragCenter;

        // Assert
        camera.AnchorMode.ShouldBe(Camera2D.AnchorModeEnum.DragCenter);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_AnchorMode_CanBeSetToFixedTopLeft

```csharp
[Test]
    public void Camera2D_AnchorMode_CanBeSetToFixedTopLeft()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.AnchorMode = Camera2D.AnchorModeEnum.FixedTopLeft;

        // Assert
        camera.AnchorMode.ShouldBe(Camera2D.AnchorModeEnum.FixedTopLeft);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_ProcessCallback_CanBeSetToIdle

```csharp
#endregion

    #region Process Mode Tests

    [Test]
    public void Camera2D_ProcessCallback_CanBeSetToIdle()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.ProcessCallback = Camera2D.Camera2DProcessCallback.Idle;

        // Assert
        camera.ProcessCallback.ShouldBe(Camera2D.Camera2DProcessCallback.Idle);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_ProcessCallback_CanBeSetToPhysics

```csharp
[Test]
    public void Camera2D_ProcessCallback_CanBeSetToPhysics()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);

        // Act
        camera.ProcessCallback = Camera2D.Camera2DProcessCallback.Physics;

        // Assert
        camera.ProcessCallback.ShouldBe(Camera2D.Camera2DProcessCallback.Physics);

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

### Camera2D_GetScreenCenterPosition_ReturnsPosition

```csharp
#endregion

    #region Screen Position Tests

    [Test]
    public void Camera2D_GetScreenCenterPosition_ReturnsPosition()
    {
        // Arrange
        var camera = new Camera2D();
        _testScene.AddChild(camera);
        camera.MakeCurrent();

        // Act
        var screenCenter = camera.GetScreenCenterPosition();

        // Assert: Should return some position (exact value depends on viewport)
        screenCenter.ShouldBeOfType<Vector2>();

        // Cleanup
        camera.QueueFree();
    }
```

**Returns:** `void`

