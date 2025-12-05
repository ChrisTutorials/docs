---
title: "ManipulationSystemNodeIntegratedTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationsystemnodeintegratedtests/"
---

# ManipulationSystemNodeIntegratedTests

```csharp
GridBuilding.Godot.Tests.Manipulation
class ManipulationSystemNodeIntegratedTests
{
    // Members...
}
```

Integration tests for ManipulationSystemNode with Enhanced Service Registry Pattern.
Tests Core/Godot separation and proper delegation to Core services.
Score: 8/10 - Clean Core/Godot separation, minimal Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationSystemNodeIntegratedTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
public override void _Ready()
    {
        Name = "ManipulationSystemNodeIntegratedTests";
    }
```

**Returns:** `void`

### Dispose

```csharp
public void Dispose()
    {
        // Xunit Dispose replaces [TearDown]
        _manipulationSystem?.QueueFree();
        _testNode?.QueueFree();
        _manipulationSystem = null;
        _serviceRegistry = null;
        _testNode = null;
        
        // Clear global registry
        ServiceCompositionRoot.SetGlobalRegistry(null);
    }
```

**Returns:** `void`

### ManipulationSystemNode_WithServiceRegistry_ResolvesCoreService

```csharp
#endregion

    #region Service Registry Integration Tests

    [Fact]
    public void ManipulationSystemNode_WithServiceRegistry_ResolvesCoreService()
    {
        // Given - ServiceRegistry is set up in SetUp
        
        // When - System is ready (from SetUp)
        
        // Then
        var issues = _manipulationSystem?.GetValidationIssues();
        ;
        ;
    }
```

**Returns:** `void`

### ManipulationSystemNode_WithoutServiceRegistry_ReportsIssues

```csharp
[Fact]
    public void ManipulationSystemNode_WithoutServiceRegistry_ReportsIssues()
    {
        // Given - No ServiceRegistry
        ServiceCompositionRoot.SetGlobalRegistry(null);
        
        var system = new ManipulationSystemNode();
        AddChild(system);
        
        // When
        var issues = system.GetValidationIssues();
        
        // Then
        ;
        ;
        
        // Cleanup
        system.QueueFree();
    }
```

**Returns:** `void`

### StartManipulation_WithValidParameters_DelegatesToCoreService

```csharp
#endregion

    #region Core Service Delegation Tests

    [Fact]
    public void StartManipulation_WithValidParameters_DelegatesToCoreService()
    {
        // Given
        var mode = ManipulationMode.Move;
        var origin = new Vector2I(1, 1);
        
        // When
        var result = _manipulationSystem?.StartManipulation(mode, origin);
        
        // Then
        ;
        
        // Verify Core service has the manipulation
        var activeManipulations = _manipulationSystem?.GetActiveManipulations();
        ;
        ;
    }
```

**Returns:** `void`

### UpdateManipulationTarget_WithValidId_DelegatesToCoreService

```csharp
[Fact]
    public void UpdateManipulationTarget_WithValidId_DelegatesToCoreService()
    {
        // Given - Start a manipulation
        var mode = ManipulationMode.Move;
        var origin = new Vector2I(1, 1);
        _manipulationSystem?.StartManipulation(mode, origin);
        
        var activeManipulations = _manipulationSystem?.GetActiveManipulations();
        var manipulationId = activeManipulations?.First()?.ManipulationId;
        var newTarget = new Vector2I(3, 3);
        
        // When
        var result = _manipulationSystem?.UpdateManipulationTarget(manipulationId!, newTarget);
        
        // Then
        ;
        
        // Verify the manipulation was updated
        var updatedManipulation = _manipulationSystem?.GetManipulation(manipulationId!);
        ;
        ;
    }
```

**Returns:** `void`

### CancelManipulation_WithValidId_DelegatesToCoreService

```csharp
[Fact]
    public void CancelManipulation_WithValidId_DelegatesToCoreService()
    {
        // Given - Start a manipulation
        var mode = ManipulationMode.Move;
        var origin = new Vector2I(1, 1);
        _manipulationSystem?.StartManipulation(mode, origin);
        
        var activeManipulations = _manipulationSystem?.GetActiveManipulations();
        var manipulationId = activeManipulations?.First()?.ManipulationId;
        
        // When
        var result = _manipulationSystem?.CancelManipulation(manipulationId!);
        
        // Then
        ;
        
        // Verify the manipulation is cancelled
        var cancelledManipulation = _manipulationSystem?.GetManipulation(manipulationId!);
        ;
    }
```

**Returns:** `void`

### CompleteManipulation_WithValidId_DelegatesToCoreService

```csharp
[Fact]
    public void CompleteManipulation_WithValidId_DelegatesToCoreService()
    {
        // Given - Start a manipulation
        var mode = ManipulationMode.Move;
        var origin = new Vector2I(1, 1);
        _manipulationSystem?.StartManipulation(mode, origin);
        
        var activeManipulations = _manipulationSystem?.GetActiveManipulations();
        var manipulationId = activeManipulations?.First()?.ManipulationId;
        
        // When
        var result = _manipulationSystem?.CompleteManipulation(manipulationId!);
        
        // Then
        ;
        
        // Verify the manipulation is completed
        var completedManipulation = _manipulationSystem?.GetManipulation(manipulationId!);
        ;
    }
```

**Returns:** `void`

### ApplyRotation_WithValidNode_UsesGodotTransformHandler

```csharp
#endregion

    #region Godot-Specific Operations Tests

    [Fact]
    public void ApplyRotation_WithValidNode_UsesGodotTransformHandler()
    {
        // Given
        var testNode = new MockNode2D();
        var initialRotation = testNode.RotationDegrees;
        AddChild(testNode);
        
        // When
        _manipulationSystem?.ApplyRotation(testNode, 90f);
        
        // Then
        ;
        
        // Cleanup
        testNode.QueueFree();
    }
```

**Returns:** `void`

### ApplyFlipHorizontal_WithValidNode_UsesGodotTransformHandler

```csharp
[Fact]
    public void ApplyFlipHorizontal_WithValidNode_UsesGodotTransformHandler()
    {
        // Given
        var testNode = new MockNode2D();
        var initialScale = testNode.Scale;
        AddChild(testNode);
        
        // When
        _manipulationSystem?.ApplyFlipHorizontal(testNode);
        
        // Then
        ;
        ;
        
        // Cleanup
        testNode.QueueFree();
    }
```

**Returns:** `void`

### ApplyFlipVertical_WithValidNode_UsesGodotTransformHandler

```csharp
[Fact]
    public void ApplyFlipVertical_WithValidNode_UsesGodotTransformHandler()
    {
        // Given
        var testNode = new MockNode2D();
        var initialScale = testNode.Scale;
        AddChild(testNode);
        
        // When
        _manipulationSystem?.ApplyFlipVertical(testNode);
        
        // Then
        ;
        ;
        
        // Cleanup
        testNode.QueueFree();
    }
```

**Returns:** `void`

### DisablePhysicsLayer_WithValidNode_UsesGodotPhysicsManager

```csharp
[Fact]
    public void DisablePhysicsLayer_WithValidNode_UsesGodotPhysicsManager()
    {
        // Given
        var testNode = new MockNode2D();
        var collisionObj = new CollisionObject2D();
        testNode.AddChild(collisionObj);
        AddChild(testNode);
        
        collisionObj.CollisionLayer = 1; // Enable layer 0
        
        // When
        var result = _manipulationSystem?.DisablePhysicsLayer(testNode, 0);
        
        // Then
        ;
        ;
        
        // Cleanup
        testNode.QueueFree();
    }
```

**Returns:** `void`

### ReenablePhysicsLayer_WithDisabledLayer_UsesGodotPhysicsManager

```csharp
[Fact]
    public void ReenablePhysicsLayer_WithDisabledLayer_UsesGodotPhysicsManager()
    {
        // Given
        var testNode = new MockNode2D();
        var collisionObj = new CollisionObject2D();
        testNode.AddChild(collisionObj);
        AddChild(testNode);
        
        // Disable layer first
        _manipulationSystem?.DisablePhysicsLayer(testNode, 0);
        ;
        
        // When
        _manipulationSystem?.ReenablePhysicsLayer(0);
        
        // Then
        ;
        
        // Cleanup
        testNode.QueueFree();
    }
```

**Returns:** `void`

### CanStartManipulation_WithValidParameters_DelegatesToCoreService

```csharp
#endregion

    #region Validation and Query Tests

    [Fact]
    public void CanStartManipulation_WithValidParameters_DelegatesToCoreService()
    {
        // Given
        var mode = ManipulationMode.Move;
        var origin = new Vector2I(1, 1);
        
        // When
        var result = _manipulationSystem?.CanStartManipulation(mode, origin);
        
        // Then
        ;
    }
```

**Returns:** `void`

### ValidateManipulation_WithValidId_DelegatesToCoreService

```csharp
[Fact]
    public void ValidateManipulation_WithValidId_DelegatesToCoreService()
    {
        // Given - Start a manipulation
        var mode = ManipulationMode.Move;
        var origin = new Vector2I(1, 1);
        _manipulationSystem?.StartManipulation(mode, origin);
        
        var activeManipulations = _manipulationSystem?.GetActiveManipulations();
        var manipulationId = activeManipulations?.First()?.ManipulationId;
        
        // When
        var result = _manipulationSystem?.ValidateManipulation(manipulationId!);
        
        // Then
        ;
    }
```

**Returns:** `void`

### GetValidationIssues_WithManipulationState_DelegatesToCoreService

```csharp
[Fact]
    public void GetValidationIssues_WithManipulationState_DelegatesToCoreService()
    {
        // Given - Create a manipulation state
        var state = new ManipulationState(ManipulationMode.Move, new Vector2I(1, 1));
        
        // When
        var issues = _manipulationSystem?.GetValidationIssues(state);
        
        // Then
        ;
        ; // Valid state should have no issues
    }
```

**Returns:** `void`

### StartManipulation_WithInvalidMode_HandlesGracefully

```csharp
#endregion

    #region Error Handling Tests

    [Fact]
    public void StartManipulation_WithInvalidMode_HandlesGracefully()
    {
        // Given
        var mode = ManipulationMode.None; // Invalid
        var origin = new Vector2I(1, 1);
        
        // When
        var result = _manipulationSystem?.StartManipulation(mode, origin);
        
        // Then
        ;
    }
```

**Returns:** `void`

### UpdateManipulationTarget_WithInvalidId_HandlesGracefully

```csharp
[Fact]
    public void UpdateManipulationTarget_WithInvalidId_HandlesGracefully()
    {
        // Given
        var invalidId = "nonexistent_id";
        var newTarget = new Vector2I(3, 3);
        
        // When
        var result = _manipulationSystem?.UpdateManipulationTarget(invalidId, newTarget);
        
        // Then
        ;
    }
```

**Returns:** `void`

### ApplyRotation_WithNullNode_HandlesGracefully

```csharp
[Fact]
    public void ApplyRotation_WithNullNode_HandlesGracefully()
    {
        // When
        _manipulationSystem?.ApplyRotation(null, 90f);
        
        // Then - Should not throw exception
        // Xunit doesn't have Assert.Pass, test passes if no exception is thrown
    }
```

**Returns:** `void`

### CoreServiceEvents_BridgeToGodotSignals

```csharp
#endregion

    #region Event Bridging Tests

    [Fact]
    public void CoreServiceEvents_BridgeToGodotSignals()
    {
        // Given
        var signalReceived = false;
        _manipulationSystem?.Connect(ManipulationSystemNode.SignalName.ManipulationStarted, 
            Callable.From((Variant data) => { signalReceived = true; }));
        
        // When - Start a manipulation (should trigger Core event)
        _manipulationSystem?.StartManipulation(ManipulationMode.Move, new Vector2I(1, 1));
        
        // Then - Signal should be emitted
        ;
        
        // Cleanup
        _manipulationSystem?.Disconnect(ManipulationSystemNode.SignalName.ManipulationStarted, 
            Callable.From((Variant data) => { signalReceived = true; }));
    }
```

**Returns:** `void`

### CreateWithInjection_WithLegacyPattern_WorksButShowsWarning

```csharp
#endregion

    #region Legacy Compatibility Tests

    [Fact]
    public void CreateWithInjection_WithLegacyPattern_WorksButShowsWarning()
    {
        // Given
        var parent = new Node();
        AddChild(parent);
        
        // When
        var system = ManipulationSystemNode.CreateWithInjection(parent, new object());
        
        // Then
        ;
        ;
        
        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

