---
title: "GridTargetingCoordinatorTests"
description: "Unit tests for GridTargetingCoordinator.
Tests the lightweight coordinator that replaces GridTargetingSystem."
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridtargetingcoordinatortests/"
---

# GridTargetingCoordinatorTests

```csharp
GridBuilding.Godot.Tests.Unit.Systems
class GridTargetingCoordinatorTests
{
    // Members...
}
```

Unit tests for GridTargetingCoordinator.
Tests the lightweight coordinator that replaces GridTargetingSystem.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Systems/GridTargetingCoordinatorTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Unit.Systems`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Dispose

```csharp
public void Dispose()
        {
            _coordinator?.QueueFree();
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
            mockServiceRegistry.Setup(x => x.GetService<ILogger>()).Returns(_mockLogger.Object);

            // Act
            _coordinator._Ready();

            // Assert
            _coordinator.IsInitialized.ShouldBeTrue();
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
            _coordinator._Ready();

            // Assert
            _coordinator.IsInitialized.ShouldBeFalse();
        }
```

**Returns:** `void`

### RegisterTargetingComponent_WithValidComponent_RegistersComponent

```csharp
#endregion

        #region Component Management Tests

        [Fact]
        public void RegisterTargetingComponent_WithValidComponent_RegistersComponent()
        {
            // Arrange
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();

            // Act
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            // Assert
            _coordinator.ComponentCount.ShouldBe(1);
            var registeredComponents = _coordinator.GetRegisteredComponents();
            registeredComponents.ShouldContain(mockComponent.Object);
        }
```

**Returns:** `void`

### RegisterTargetingComponent_WithNullComponent_DoesNotThrow

```csharp
[Fact]
        public void RegisterTargetingComponent_WithNullComponent_DoesNotThrow()
        {
            // Act & Assert
            Should.NotThrow(() => _coordinator.RegisterTargetingComponent(null));
            _coordinator.ComponentCount.ShouldBe(0);
        }
```

**Returns:** `void`

### RegisterTargetingComponent_WithDuplicateComponent_DoesNotRegisterTwice

```csharp
[Fact]
        public void RegisterTargetingComponent_WithDuplicateComponent_DoesNotRegisterTwice()
        {
            // Arrange
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            // Act
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            // Assert
            _coordinator.ComponentCount.ShouldBe(1);
        }
```

**Returns:** `void`

### UnregisterTargetingComponent_WithRegisteredComponent_UnregistersComponent

```csharp
[Fact]
        public void UnregisterTargetingComponent_WithRegisteredComponent_UnregistersComponent()
        {
            // Arrange
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            // Act
            _coordinator.UnregisterTargetingComponent(mockComponent.Object);

            // Assert
            _coordinator.ComponentCount.ShouldBe(0);
            var registeredComponents = _coordinator.GetRegisteredComponents();
            registeredComponents.ShouldNotContain(mockComponent.Object);
        }
```

**Returns:** `void`

### UnregisterTargetingComponent_WithNullComponent_DoesNotThrow

```csharp
[Fact]
        public void UnregisterTargetingComponent_WithNullComponent_DoesNotThrow()
        {
            // Act & Assert
            Should.NotThrow(() => _coordinator.UnregisterTargetingComponent(null));
        }
```

**Returns:** `void`

### UnregisterTargetingComponent_WithUnregisteredComponent_DoesNotThrow

```csharp
[Fact]
        public void UnregisterTargetingComponent_WithUnregisteredComponent_DoesNotThrow()
        {
            // Arrange
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();

            // Act & Assert
            Should.NotThrow(() => _coordinator.UnregisterTargetingComponent(mockComponent.Object));
        }
```

**Returns:** `void`

### FindComponentByName_WithExistingComponent_ReturnsComponent

```csharp
[Fact]
        public void FindComponentByName_WithExistingComponent_ReturnsComponent()
        {
            // Arrange
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();
            mockComponent.Setup(x => x.Name).Returns("TestComponent");
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            // Act
            var foundComponent = _coordinator.FindComponentByName("TestComponent");

            // Assert
            foundComponent.ShouldBe(mockComponent.Object);
        }
```

**Returns:** `void`

### FindComponentByName_WithNonExistentComponent_ReturnsNull

```csharp
[Fact]
        public void FindComponentByName_WithNonExistentComponent_ReturnsNull()
        {
            // Act
            var foundComponent = _coordinator.FindComponentByName("NonExistent");

            // Assert
            foundComponent.ShouldBeNull();
        }
```

**Returns:** `void`

### GetComponentsWithValidTargets_WithValidComponents_ReturnsOnlyValidOnes

```csharp
[Fact]
        public void GetComponentsWithValidTargets_WithValidComponents_ReturnsOnlyValidOnes()
        {
            // Arrange
            var validComponent = new Mock<TargetingShapeCast2DRefactored>();
            var invalidComponent = new Mock<TargetingShapeCast2DRefactored>();
            
            validComponent.Setup(x => x.HasValidTarget).Returns(true);
            invalidComponent.Setup(x => x.HasValidTarget).Returns(false);
            
            _coordinator.RegisterTargetingComponent(validComponent.Object);
            _coordinator.RegisterTargetingComponent(invalidComponent.Object);

            // Act
            var validComponents = _coordinator.GetComponentsWithValidTargets();

            // Assert
            validComponents.Count.ShouldBe(1);
            validComponents.ShouldContain(validComponent.Object);
            validComponents.ShouldNotContain(invalidComponent.Object);
        }
```

**Returns:** `void`

### SetAstarGrid_WithValidGrid_UpdatesCoreService

```csharp
#endregion

        #region AStar Grid Management Tests

        [Fact]
        public void SetAstarGrid_WithValidGrid_UpdatesCoreService()
        {
            // Arrange
            var mockAstarGrid = new Mock<AStarGrid2D>();
            mockAstarGrid.Setup(x => x.Region).Returns(new Rect2I(0, 0, 10, 10));
            mockAstarGrid.Setup(x => x.IsPointSolid(It.IsAny<Vector2I>())).Returns(false);

            // Act
            _coordinator.SetAstarGrid(mockAstarGrid.Object);

            // Assert
            _coordinator.AstarGrid.ShouldBe(mockAstarGrid.Object);
            _mockTargetingService.Verify(x => x.UpdateGridNavigation(It.IsAny<GridNavigationData>()), Times.Once);
        }
```

**Returns:** `void`

### SetAstarGrid_WithNullGrid_ClearsGrid

```csharp
[Fact]
        public void SetAstarGrid_WithNullGrid_ClearsGrid()
        {
            // Act
            _coordinator.SetAstarGrid(null);

            // Assert
            _coordinator.AstarGrid.ShouldBeNull();
        }
```

**Returns:** `void`

### SetAstarGrid_WithSameGrid_DoesNotUpdateCoreService

```csharp
[Fact]
        public void SetAstarGrid_WithSameGrid_DoesNotUpdateCoreService()
        {
            // Arrange
            var mockAstarGrid = new Mock<AStarGrid2D>();
            _coordinator.SetAstarGrid(mockAstarGrid.Object);

            // Act
            _coordinator.SetAstarGrid(mockAstarGrid.Object);

            // Assert
            _mockTargetingService.Verify(x => x.UpdateGridNavigation(It.IsAny<GridNavigationData>()), Times.Once);
        }
```

**Returns:** `void`

### EnableAllTargeting_EnablesCoreServiceAndComponents

```csharp
#endregion

        #region Global Operations Tests

        [Fact]
        public void EnableAllTargeting_EnablesCoreServiceAndComponents()
        {
            // Arrange
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            // Act
            _coordinator.EnableAllTargeting();

            // Assert
            _mockTargetingService.Verify(x => x.SetTargetingEnabled(true), Times.Once);
            mockComponent.VerifySet(x => x.AutoUpdate = true, Times.Once);
        }
```

**Returns:** `void`

### DisableAllTargeting_DisablesCoreServiceAndComponents

```csharp
[Fact]
        public void DisableAllTargeting_DisablesCoreServiceAndComponents()
        {
            // Arrange
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            // Act
            _coordinator.DisableAllTargeting();

            // Assert
            _mockTargetingService.Verify(x => x.SetTargetingEnabled(false), Times.Once);
            mockComponent.VerifySet(x => x.AutoUpdate = false, Times.Once);
        }
```

**Returns:** `void`

### UpdateAllComponents_UpdatesAllRegisteredComponents

```csharp
[Fact]
        public void UpdateAllComponents_UpdatesAllRegisteredComponents()
        {
            // Arrange
            var mockComponent1 = new Mock<TargetingShapeCast2DRefactored>();
            var mockComponent2 = new Mock<TargetingShapeCast2DRefactored>();
            _coordinator.RegisterTargetingComponent(mockComponent1.Object);
            _coordinator.RegisterTargetingComponent(mockComponent2.Object);

            // Act
            _coordinator.UpdateAllComponents();

            // Assert
            mockComponent1.Verify(x => x.UpdateTargeting(), Times.Once);
            mockComponent2.Verify(x => x.UpdateTargeting(), Times.Once);
        }
```

**Returns:** `void`

### ClearAllTargets_ClearsCoreServiceTarget

```csharp
[Fact]
        public void ClearAllTargets_ClearsCoreServiceTarget()
        {
            // Act
            _coordinator.ClearAllTargets();

            // Assert
            _mockTargetingService.Verify(x => x.ClearTarget(), Times.Once);
        }
```

**Returns:** `void`

### GetRuntimeIssues_WithValidSetup_ReturnsEmptyIssues

```csharp
#endregion

        #region Validation Tests

        [Fact]
        public void GetRuntimeIssues_WithValidSetup_ReturnsEmptyIssues()
        {
            // Arrange
            _mockTargetingService.Setup(x => x.ValidateSetup()).Returns(new List<string>());

            // Act
            var issues = _coordinator.GetRuntimeIssues();

            // Assert
            issues.ShouldBeEmpty();
        }
```

**Returns:** `void`

### GetRuntimeIssues_WithoutService_ReturnsIssues

```csharp
[Fact]
        public void GetRuntimeIssues_WithoutService_ReturnsIssues()
        {
            // Arrange
            var mockServiceRegistry = new Mock<IServiceRegistry>();
            mockServiceRegistry.Setup(x => x.GetService<IGridTargetingService>()).Returns((IGridTargetingService)null);

            // Act
            var issues = _coordinator.GetRuntimeIssues();

            // Assert
            issues.ShouldNotBeEmpty();
            issues.ShouldContain("IGridTargetingService is not set");
        }
```

**Returns:** `void`

### GetRuntimeIssues_WithoutLogger_ReturnsIssues

```csharp
[Fact]
        public void GetRuntimeIssues_WithoutLogger_ReturnsIssues()
        {
            // Arrange
            var mockServiceRegistry = new Mock<IServiceRegistry>();
            mockServiceRegistry.Setup(x => x.GetService<IGridTargetingService>()).Returns(_mockTargetingService.Object);
            mockServiceRegistry.Setup(x => x.GetService<ILogger>()).Returns((ILogger)null);

            // Act
            var issues = _coordinator.GetRuntimeIssues();

            // Assert
            issues.ShouldNotBeEmpty();
            issues.ShouldContain("ILogger is not set");
        }
```

**Returns:** `void`

### GetRuntimeIssues_WithCoreServiceIssues_ReturnsCombinedIssues

```csharp
[Fact]
        public void GetRuntimeIssues_WithCoreServiceIssues_ReturnsCombinedIssues()
        {
            // Arrange
            var coreIssues = new List<string> { "Core issue 1", "Core issue 2" };
            _mockTargetingService.Setup(x => x.ValidateSetup()).Returns(coreIssues);

            // Act
            var issues = _coordinator.GetRuntimeIssues();

            // Assert
            issues.Count.ShouldBeGreaterThanOrEqualTo(2);
            issues.ShouldContain("Core Service: Core issue 1");
            issues.ShouldContain("Core Service: Core issue 2");
        }
```

**Returns:** `void`

### ValidateReady_WithValidSetup_ReturnsTrue

```csharp
[Fact]
        public void ValidateReady_WithValidSetup_ReturnsTrue()
        {
            // Arrange
            _mockTargetingService.Setup(x => x.ValidateSetup()).Returns(new List<string>());

            // Act
            var isReady = _coordinator.ValidateReady();

            // Assert
            isReady.ShouldBeTrue();
        }
```

**Returns:** `void`

### ValidateReady_WithIssues_ReturnsFalse

```csharp
[Fact]
        public void ValidateReady_WithIssues_ReturnsFalse()
        {
            // Arrange
            var mockServiceRegistry = new Mock<IServiceRegistry>();
            mockServiceRegistry.Setup(x => x.GetService<IGridTargetingService>()).Returns((IGridTargetingService)null);

            // Act
            var isReady = _coordinator.ValidateReady();

            // Assert
            isReady.ShouldBeFalse();
        }
```

**Returns:** `void`

### GetDebugInfo_WithInitializedCoordinator_ReturnsDebugInformation

```csharp
#endregion

        #region Debug Tests

        [Fact]
        public void GetDebugInfo_WithInitializedCoordinator_ReturnsDebugInformation()
        {
            // Arrange
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();
            mockComponent.Setup(x => x.Name).Returns("TestComponent");
            mockComponent.Setup(x => x.HasValidTarget).Returns(true);
            mockComponent.Setup(x => x.CurrentGridPosition).Returns(new Vector2I(2, 3));
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            _mockTargetingService.Setup(x => x.CurrentTargetTile).Returns(new Vector2I(5, 6));
            _mockTargetingService.Setup(x => x.IsTargetingActive).Returns(true);

            // Act
            var debugInfo = _coordinator.GetDebugInfo();

            // Assert
            debugInfo.ShouldContain("GridTargetingCoordinator Debug Info");
            debugInfo.ShouldContain("Initialized: True");
            debugInfo.ShouldContain("Registered Components: 1");
            debugInfo.ShouldContain("Core Service Available: True");
            debugInfo.ShouldContain("TestComponent: Valid=True, Pos=(2, 3)");
            debugInfo.ShouldContain("Core Service Target: (5, 6)");
            debugInfo.ShouldContain("Core Service Active: True");
        }
```

**Returns:** `void`

### PrintDebugInfo_DoesNotThrow

```csharp
[Fact]
        public void PrintDebugInfo_DoesNotThrow()
        {
            // Act & Assert
            Should.NotThrow(() => _coordinator.PrintDebugInfo());
        }
```

**Returns:** `void`

### CoreServiceTargetingStateChanged_UpdatesComponents

```csharp
#endregion

        #region Event Tests

        [Fact]
        public void CoreServiceTargetingStateChanged_UpdatesComponents()
        {
            // Arrange
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            var eventArgs = new TargetingStateChangedEventArgs(Vector2I.Zero, new Vector2I(3, 4), true);

            // Act
            _mockTargetingService.Raise(x => x.TargetingStateChanged += null, eventArgs);

            // Assert
            mockComponent.Verify(x => x.UpdateTargeting(), Times.Once);
        }
```

**Returns:** `void`

### CoreServicePathCalculated_LogsDebugInfo

```csharp
[Fact]
        public void CoreServicePathCalculated_LogsDebugInfo()
        {
            // Arrange
            var eventArgs = new PathCalculatedEventArgs(new List<Vector2I> { Vector2I.Zero, new Vector2I(1, 1) }, 2.0f, Vector2I.Zero, new Vector2I(1, 1));

            // Act
            _mockTargetingService.Raise(x => x.PathCalculated += null, eventArgs);

            // Assert
            _mockLogger.Verify(x => x.LogDebug(It.Is<string>(s => s.Contains("Path calculated") && s.Contains("2 tiles") && s.Contains("2.0"))), Times.Once);
        }
```

**Returns:** `void`

### CoreServicePathCalculationFailed_LogsError

```csharp
[Fact]
        public void CoreServicePathCalculationFailed_LogsError()
        {
            // Arrange
            var eventArgs = new PathCalculationFailedEventArgs("Test failure", Vector2I.Zero, new Vector2I(1, 1));

            // Act
            _mockTargetingService.Raise(x => x.PathCalculationFailed += null, eventArgs);

            // Assert
            _mockLogger.Verify(x => x.LogError(It.Is<string>(s => s.Contains("Path calculation failed") && s.Contains("Test failure"))), Times.Once);
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
            _coordinator._Ready();
            var mockComponent = new Mock<TargetingShapeCast2DRefactored>();
            _coordinator.RegisterTargetingComponent(mockComponent.Object);

            // Act
            _coordinator._ExitTree();

            // Assert
            _coordinator.IsInitialized.ShouldBeFalse();
            _coordinator.ComponentCount.ShouldBe(0);
        }
```

**Returns:** `void`

### FindPath_WithValidPositions_ReturnsPath

```csharp
#endregion

        #region Backward Compatibility Tests

        [Fact]
        public void FindPath_WithValidPositions_ReturnsPath()
        {
            // Arrange
            var expectedPath = new List<Vector2I> { Vector2I.Zero, new Vector2I(1, 1) };
            _mockTargetingService.Setup(x => x.FindPath(Vector2I.Zero, new Vector2I(1, 1))).Returns(expectedPath);

            // Act
            var path = _coordinator.FindPath(Vector2I.Zero, new Vector2I(1, 1));

            // Assert
            path.ShouldBe(expectedPath);
            _mockTargetingService.Verify(x => x.FindPath(Vector2I.Zero, new Vector2I(1, 1)), Times.Once);
        }
```

**Returns:** `void`

### IsPathClear_WithValidPositions_ReturnsTrue

```csharp
[Fact]
        public void IsPathClear_WithValidPositions_ReturnsTrue()
        {
            // Arrange
            _mockTargetingService.Setup(x => x.IsPathClear(Vector2I.Zero, new Vector2I(1, 1))).Returns(true);

            // Act
            var isClear = _coordinator.IsPathClear(Vector2I.Zero, new Vector2I(1, 1));

            // Assert
            isClear.ShouldBeTrue();
            _mockTargetingService.Verify(x => x.IsPathClear(Vector2I.Zero, new Vector2I(1, 1)), Times.Once);
        }
```

**Returns:** `void`

### GetClosestValidTile_WithValidParameters_ReturnsTile

```csharp
[Fact]
        public void GetClosestValidTile_WithValidParameters_ReturnsTile()
        {
            // Arrange
            var expectedTile = new Vector2I(2, 2);
            _mockTargetingService.Setup(x => x.GetClosestValidTile(new Vector2I(3, 3), new Vector2I(0, 0), 10)).Returns(expectedTile);

            // Act
            var tile = _coordinator.GetClosestValidTile(new Vector2I(3, 3), null, null);

            // Assert
            tile.ShouldBe(expectedTile);
        }
```

**Returns:** `void`

### CreateWithInjection_CreatesConfiguredCoordinator

```csharp
#endregion

        #region Static Factory Method Tests

        [Fact]
        public void CreateWithInjection_CreatesConfiguredCoordinator()
        {
            // Arrange
            var parent = new Node();
            var mockContainer = new Mock<GBCompositionContainer>();
            var mockLogger = new Mock<ILogger>();
            mockContainer.Setup(x => x.GetLogger()).Returns(mockLogger.Object);

            // Act
            var coordinator = GridTargetingCoordinator.CreateWithInjection(parent, mockContainer.Object);

            // Assert
            coordinator.ShouldNotBeNull();
            coordinator.GetParent().ShouldBe(parent);
            coordinator.Name.ShouldBe("GridTargetingCoordinator");

            // Cleanup
            coordinator.QueueFree();
            parent.QueueFree();
        }
```

**Returns:** `void`

### UpdateAllComponents_WithoutComponents_DoesNotThrow

```csharp
#endregion

        #region Edge Case Tests

        [Fact]
        public void UpdateAllComponents_WithoutComponents_DoesNotThrow()
        {
            // Act & Assert
            Should.NotThrow(() => _coordinator.UpdateAllComponents());
        }
```

**Returns:** `void`

### EnableAllTargeting_WithoutComponents_DoesNotThrow

```csharp
[Fact]
        public void EnableAllTargeting_WithoutComponents_DoesNotThrow()
        {
            // Act & Assert
            Should.NotThrow(() => _coordinator.EnableAllTargeting());
        }
```

**Returns:** `void`

### DisableAllTargeting_WithoutComponents_DoesNotThrow

```csharp
[Fact]
        public void DisableAllTargeting_WithoutComponents_DoesNotThrow()
        {
            // Act & Assert
            Should.NotThrow(() => _coordinator.DisableAllTargeting());
        }
```

**Returns:** `void`

### GetComponentsWithValidTargets_WithoutComponents_ReturnsEmptyList

```csharp
[Fact]
        public void GetComponentsWithValidTargets_WithoutComponents_ReturnsEmptyList()
        {
            // Act
            var validComponents = _coordinator.GetComponentsWithValidTargets();

            // Assert
            validComponents.ShouldBeEmpty();
        }
```

**Returns:** `void`

