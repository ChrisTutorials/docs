---
title: "TargetingShapeCast2DRefactoredTests"
description: "Unit tests for TargetingShapeCast2DRefactored.
Tests the new component that delegates to Core service."
weight: 20
url: "/gridbuilding/v6-0/api/godot/targetingshapecast2drefactoredtests/"
---

# TargetingShapeCast2DRefactoredTests

```csharp
GridBuilding.Godot.Tests.Unit.Systems
class TargetingShapeCast2DRefactoredTests
{
    // Members...
}
```

Unit tests for TargetingShapeCast2DRefactored.
Tests the new component that delegates to Core service.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Systems/TargetingShapeCast2DRefactoredTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Unit.Systems`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Dispose

```csharp
public void Dispose()
        {
            _component?.QueueFree();
            _sceneTree?.Quit();
        }
```

**Returns:** `void`

### _Ready_WithValidServiceRegistry_InitializesSuccessfully

```csharp
#endregion

        #region Initialization Tests

        [Fact]
        public void _Ready_WithValidServiceRegistry_InitializesSuccessfully()
        {
            // Arrange - Mock ServiceRegistry
            var mockServiceRegistry = new Mock<IServiceRegistry>();
            mockServiceRegistry.Setup(x => x.GetService<IGridTargetingService>()).Returns(_mockTargetingService.Object);
            mockServiceRegistry.Setup(x => x.GetService<GridTargetingConfiguration>()).Returns(_mockConfig.Object);

            // Act
            _component._Ready();

            // Assert
            _component.IsInitialized.ShouldBeTrue();
        }
```

**Returns:** `void`

### _Ready_WithoutServiceRegistry_FailsInitialization

```csharp
[Fact]
        public void _Ready_WithoutServiceRegistry_FailsInitialization()
        {
            // Arrange - Mock ServiceRegistry returning null
            var mockServiceRegistry = new Mock<IServiceRegistry>();
            mockServiceRegistry.Setup(x => x.GetService<IGridTargetingService>()).Returns((IGridTargetingService)null);

            // Act
            _component._Ready();

            // Assert
            _component.IsInitialized.ShouldBeFalse();
        }
```

**Returns:** `void`

### IsGridSnapping_SetValue_UpdatesGridSnapping

```csharp
#endregion

        #region Property Tests

        [Fact]
        public void IsGridSnapping_SetValue_UpdatesGridSnapping()
        {
            // Act
            _component.IsGridSnapping = false;

            // Assert
            _component.IsGridSnapping.ShouldBeFalse();
        }
```

**Returns:** `void`

### AutoUpdate_SetValue_UpdatesAutoUpdate

```csharp
[Fact]
        public void AutoUpdate_SetValue_UpdatesAutoUpdate()
        {
            // Act
            _component.AutoUpdate = false;

            // Assert
            _component.AutoUpdate.ShouldBeFalse();
        }
```

**Returns:** `void`

### UpdateInterval_SetValue_UpdatesInterval

```csharp
[Fact]
        public void UpdateInterval_SetValue_UpdatesInterval()
        {
            // Arrange
            var newInterval = 0.2f;

            // Act
            _component.UpdateInterval = newInterval;

            // Assert
            _component.UpdateInterval.ShouldBe(newInterval);
        }
```

**Returns:** `void`

### GridCellSize_SetValue_UpdatesCellSize

```csharp
[Fact]
        public void GridCellSize_SetValue_UpdatesCellSize()
        {
            // Arrange
            var newCellSize = new Vector2(64.0f, 64.0f);

            // Act
            _component.GridCellSize = newCellSize;

            // Assert
            _component.GridCellSize.ShouldBe(newCellSize);
        }
```

**Returns:** `void`

### GridOrigin_SetValue_UpdatesOrigin

```csharp
[Fact]
        public void GridOrigin_SetValue_UpdatesOrigin()
        {
            // Arrange
            var newOrigin = new Vector2(100.0f, 50.0f);

            // Act
            _component.GridOrigin = newOrigin;

            // Assert
            _component.GridOrigin.ShouldBe(newOrigin);
        }
```

**Returns:** `void`

### SetGridPosition_WithValidPosition_UpdatesGlobalPosition

```csharp
#endregion

        #region Grid Operations Tests

        [Fact]
        public void SetGridPosition_WithValidPosition_UpdatesGlobalPosition()
        {
            // Arrange
            var gridPosition = new Vector2I(3, 4);
            _component.GridCellSize = new Vector2(32.0f, 32.0f);
            _component.GridOrigin = Vector2.Zero;

            // Act
            _component.SetGridPosition(gridPosition);

            // Assert
            var expectedWorldPos = new Vector2(96.0f, 128.0f); // (3+0.5)*32, (4+0.5)*32
            _component.GlobalPosition.ShouldBe(expectedWorldPos);
        }
```

**Returns:** `void`

### GridToWorld_WithGridPosition_ReturnsWorldPosition

```csharp
[Fact]
        public void GridToWorld_WithGridPosition_ReturnsWorldPosition()
        {
            // Arrange
            var gridPosition = new Vector2I(2, 3);
            _component.GridCellSize = new Vector2(32.0f, 32.0f);
            _component.GridOrigin = new Vector2(10.0f, 20.0f);

            // Act
            var worldPos = _component.GridToWorld(gridPosition);

            // Assert
            var expectedPos = new Vector2(74.0f, 116.0f); // 10 + (2+0.5)*32, 20 + (3+0.5)*32
            worldPos.ShouldBe(expectedPos);
        }
```

**Returns:** `void`

### WorldToGrid_WithWorldPosition_ReturnsGridPosition

```csharp
[Fact]
        public void WorldToGrid_WithWorldPosition_ReturnsGridPosition()
        {
            // Arrange
            var worldPos = new Vector2(74.0f, 116.0f);
            _component.GridCellSize = new Vector2(32.0f, 32.0f);
            _component.GridOrigin = new Vector2(10.0f, 20.0f);

            // Act
            var gridPos = _component.WorldToGrid(worldPos);

            // Assert
            gridPos.ShouldBe(new Vector2I(2, 3));
        }
```

**Returns:** `void`

### GetCoveredGridCells_WithRectangleShape_ReturnsCorrectCells

```csharp
[Fact]
        public void GetCoveredGridCells_WithRectangleShape_ReturnsCorrectCells()
        {
            // Arrange
            var rectShape = new RectangleShape2D { Size = new Vector2(64.0f, 64.0f) };
            _component.Shape = rectShape;
            _component.GridCellSize = new Vector2(32.0f, 32.0f);
            _component.GlobalPosition = new Vector2(32.0f, 32.0f);

            // Act
            var coveredCells = _component.GetCoveredGridCells();

            // Assert
            coveredCells.ShouldNotBeEmpty();
            coveredCells.ShouldContain(new Vector2I(0, 0));
            coveredCells.ShouldContain(new Vector2I(0, 1));
            coveredCells.ShouldContain(new Vector2I(1, 0));
            coveredCells.ShouldContain(new Vector2I(1, 1));
        }
```

**Returns:** `void`

### AddFilter_WithValidFilter_AddsToFilters

```csharp
#endregion

        #region Filter and Validator Tests

        [Fact]
        public void AddFilter_WithValidFilter_AddsToFilters()
        {
            // Arrange
            var mockFilter = new Mock<ITargetingFilter>();
            mockFilter.Setup(x => x.IsTargetValid(It.IsAny<Node>(), It.IsAny<Vector2I>())).Returns(true);

            // Act
            _component.AddFilter(mockFilter.Object);

            // Assert
            _component.TargetData.ShouldNotBeNull();
        }
```

**Returns:** `void`

### RemoveFilter_WithExistingFilter_RemovesFromFilters

```csharp
[Fact]
        public void RemoveFilter_WithExistingFilter_RemovesFromFilters()
        {
            // Arrange
            var mockFilter = new Mock<ITargetingFilter>();
            _component.AddFilter(mockFilter.Object);

            // Act
            _component.RemoveFilter(mockFilter.Object);

            // Assert
            // Filter should be removed (verified through behavior)
        }
```

**Returns:** `void`

### ClearFilters_RemovesAllFilters

```csharp
[Fact]
        public void ClearFilters_RemovesAllFilters()
        {
            // Arrange
            var mockFilter1 = new Mock<ITargetingFilter>();
            var mockFilter2 = new Mock<ITargetingFilter>();
            _component.AddFilter(mockFilter1.Object);
            _component.AddFilter(mockFilter2.Object);

            // Act
            _component.ClearFilters();

            // Assert
            // All filters should be removed
        }
```

**Returns:** `void`

### AddValidator_WithValidValidator_AddsToValidators

```csharp
[Fact]
        public void AddValidator_WithValidValidator_AddsToValidators()
        {
            // Arrange
            var mockValidator = new Mock<ITargetingValidator>();
            mockValidator.Setup(x => x.ValidateTarget(It.IsAny<Node>(), It.IsAny<Vector2I>())).Returns(true);

            // Act
            _component.AddValidator(mockValidator.Object);

            // Assert
            // Validator should be added
        }
```

**Returns:** `void`

### ValidateTarget_WithValidTarget_ReturnsTrue

```csharp
#endregion

        #region ITargetingValidator Tests

        [Fact]
        public void ValidateTarget_WithValidTarget_ReturnsTrue()
        {
            // Arrange
            var mockTarget = new Mock<Node>();
            var gridPosition = new Vector2I(2, 2);
            _mockTargetingService.Setup(x => x.ValidateTargetAtPosition(gridPosition, mockTarget.Object)).Returns(true);

            // Act
            var isValid = _component.ValidateTarget(mockTarget.Object, gridPosition);

            // Assert
            isValid.ShouldBeTrue();
            _mockTargetingService.Verify(x => x.ValidateTargetAtPosition(gridPosition, mockTarget.Object), Times.Once);
        }
```

**Returns:** `void`

### ValidateTarget_WithInvalidTarget_ReturnsFalse

```csharp
[Fact]
        public void ValidateTarget_WithInvalidTarget_ReturnsFalse()
        {
            // Arrange
            var mockTarget = new Mock<Node>();
            var gridPosition = new Vector2I(2, 2);
            _mockTargetingService.Setup(x => x.ValidateTargetAtPosition(gridPosition, mockTarget.Object)).Returns(false);

            // Act
            var isValid = _component.ValidateTarget(mockTarget.Object, gridPosition);

            // Assert
            isValid.ShouldBeFalse();
        }
```

**Returns:** `void`

### GetInvalidReason_WithNullTarget_ReturnsReason

```csharp
[Fact]
        public void GetInvalidReason_WithNullTarget_ReturnsReason()
        {
            // Act
            var reason = _component.GetInvalidReason(null, new Vector2I(1, 1));

            // Assert
            reason.ShouldContain("Target is null");
        }
```

**Returns:** `void`

### GetInvalidReason_WithInvalidTarget_ReturnsServiceReason

```csharp
[Fact]
        public void GetInvalidReason_WithInvalidTarget_ReturnsServiceReason()
        {
            // Arrange
            var mockTarget = new Mock<Node>();
            var gridPosition = new Vector2I(2, 2);
            _mockTargetingService.Setup(x => x.ValidateTargetAtPosition(gridPosition, mockTarget.Object)).Returns(false);

            // Act
            var reason = _component.GetInvalidReason(mockTarget.Object, gridPosition);

            // Assert
            reason.ShouldContain("Target position is not valid according to Core service");
        }
```

**Returns:** `void`

### UpdateTargeting_WithValidTarget_EmitsTargetDetectedSignal

```csharp
#endregion

        #region Event Tests

        [Fact]
        public void UpdateTargeting_WithValidTarget_EmitsTargetDetectedSignal()
        {
            // Arrange
            var signalReceived = false;
            Node? receivedTarget = null;
            Vector2I? receivedPosition = null;

            _component.Connect(TargetingShapeCast2DRefactored.SignalName.TargetDetected, Callable.From((Node target, Vector2I pos) =>
            {
                signalReceived = true;
                receivedTarget = target;
                receivedPosition = pos;
            }));

            var mockTarget = new Mock<Node>();
            _mockTargetingService.Setup(x => x.ValidateTargetAtPosition(It.IsAny<Vector2I>(), mockTarget.Object)).Returns(true);

            // Setup component to have a target
            _component.ForceShapecastUpdate();
            // Note: In a real test, you'd need to properly setup the collision detection

            // Act
            _component.UpdateTargeting();

            // Assert
            // Signal emission would be verified in a real Godot testing environment
        }
```

**Returns:** `void`

### UpdateTargeting_WithInvalidTarget_EmitsValidationChangedSignal

```csharp
[Fact]
        public void UpdateTargeting_WithInvalidTarget_EmitsValidationChangedSignal()
        {
            // Arrange
            var signalReceived = false;
            bool? receivedIsValid = null;
            string? receivedReason = null;

            _component.Connect(TargetingShapeCast2DRefactored.SignalName.ValidationChanged, Callable.From((bool isValid, string reason) =>
            {
                signalReceived = true;
                receivedIsValid = isValid;
                receivedReason = reason;
            }));

            // Act
            _component.UpdateTargeting();

            // Assert
            // Signal emission would be verified in a real Godot testing environment
        }
```

**Returns:** `void`

### SetGridPosition_EmitsGridPositionChangedSignal

```csharp
[Fact]
        public void SetGridPosition_EmitsGridPositionChangedSignal()
        {
            // Arrange
            var signalReceived = false;
            Vector2I? receivedPosition = null;

            _component.Connect(TargetingShapeCast2DRefactored.SignalName.GridPositionChanged, Callable.From((Vector2I pos) =>
            {
                signalReceived = true;
                receivedPosition = pos;
            }));

            var newPosition = new Vector2I(3, 4);

            // Act
            _component.SetGridPosition(newPosition);

            // Assert
            // Signal emission would be verified in a real Godot testing environment
        }
```

**Returns:** `void`

### GetDebugInfo_WithInitializedComponent_ReturnsDebugInformation

```csharp
#endregion

        #region Debug Tests

        [Fact]
        public void GetDebugInfo_WithInitializedComponent_ReturnsDebugInformation()
        {
            // Arrange
            _component.IsGridSnapping = true;
            _component.AutoUpdate = false;
            _component.UpdateInterval = 0.2f;

            // Act
            var debugInfo = _component.GetDebugInfo();

            // Assert
            debugInfo.ShouldContain("TargetingShapeCast2DRefactored Debug Info");
            debugInfo.ShouldContain("Grid Snapping: True");
            debugInfo.ShouldContain("Auto Update: False");
            debugInfo.ShouldContain("Update Interval: 0.2");
        }
```

**Returns:** `void`

### PrintDebugInfo_DoesNotThrow

```csharp
[Fact]
        public void PrintDebugInfo_DoesNotThrow()
        {
            // Act & Assert
            Should.NotThrow(() => _component.PrintDebugInfo());
        }
```

**Returns:** `void`

### _ExitTree_CleansUpResources

```csharp
#endregion

        #region Cleanup Tests

        [Fact]
        public void _ExitTree_CleansUpResources()
        {
            // Arrange
            _component._Ready();

            // Act
            _component._ExitTree();

            // Assert
            _component.IsInitialized.ShouldBeFalse();
        }
```

**Returns:** `void`

### UpdateTargeting_WithoutInitialization_DoesNotThrow

```csharp
#endregion

        #region Edge Case Tests

        [Fact]
        public void UpdateTargeting_WithoutInitialization_DoesNotThrow()
        {
            // Arrange
            var uninitializedComponent = new TargetingShapeCast2DRefactored();

            // Act & Assert
            Should.NotThrow(() => uninitializedComponent.UpdateTargeting());
        }
```

**Returns:** `void`

### SetGridPosition_WithNegativePosition_WorksCorrectly

```csharp
[Fact]
        public void SetGridPosition_WithNegativePosition_WorksCorrectly()
        {
            // Arrange
            var negativePosition = new Vector2I(-1, -2);

            // Act
            _component.SetGridPosition(negativePosition);

            // Assert
            _component.CurrentGridPosition.ShouldBe(negativePosition);
        }
```

**Returns:** `void`

### WorldToGrid_WithLargeNumbers_WorksCorrectly

```csharp
[Fact]
        public void WorldToGrid_WithLargeNumbers_WorksCorrectly()
        {
            // Arrange
            var largeWorldPos = new Vector2(10000.0f, 10000.0f);
            _component.GridCellSize = new Vector2(32.0f, 32.0f);

            // Act
            var gridPos = _component.WorldToGrid(largeWorldPos);

            // Assert
            gridPos.X.ShouldBeGreaterThanOrEqualTo(0);
            gridPos.Y.ShouldBeGreaterThanOrEqualTo(0);
        }
```

**Returns:** `void`

