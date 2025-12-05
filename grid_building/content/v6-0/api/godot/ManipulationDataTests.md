---
title: "ManipulationDataTests"
description: "Tests for the Godot ManipulationData wrapper
Ensures proper delegation to Core components and Godot compatibility"
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationdatatests/"
---

# ManipulationDataTests

```csharp
GridBuilding.Godot.Tests.Systems
class ManipulationDataTests
{
    // Members...
}
```

Tests for the Godot ManipulationData wrapper
Ensures proper delegation to Core components and Godot compatibility

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Systems/ManipulationDataTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Systems`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_InitializesWithCoreService

```csharp
#region Constructor Tests

        [Fact]
        public void Constructor_InitializesWithCoreService()
        {
            // Assert
            ;
            // The wrapper should have initialized its Core service
        }
```

**Returns:** `void`

### ManipulatorId_DelegatesToCoreContext

```csharp
#endregion

        #region Property Delegation Tests

        [Fact]
        public void ManipulatorId_DelegatesToCoreContext()
        {
            // Arrange
            var testId = "test-manipulator";

            // Act
            _manipulationData.ManipulatorId = testId;

            // Assert
            ;
        }
```

**Returns:** `void`

### TargetObjectId_DelegatesToCoreContext

```csharp
[Fact]
        public void TargetObjectId_DelegatesToCoreContext()
        {
            // Arrange
            var testId = "test-target";

            // Act
            _manipulationData.TargetObjectId = testId;

            // Assert
            ;
        }
```

**Returns:** `void`

### Action_DelegatesToCoreContext

```csharp
[Fact]
        public void Action_DelegatesToCoreContext()
        {
            // Arrange
            var action = ManipulationAction.Move;

            // Act
            _manipulationData.Action = action;

            // Assert
            ;
        }
```

**Returns:** `void`

### Status_DelegatesToCoreContext

```csharp
[Fact]
        public void Status_DelegatesToCoreContext()
        {
            // Arrange
            var status = ManipulationStatus.Started;

            // Act
            _manipulationData.Status = status;

            // Assert
            ;
        }
```

**Returns:** `void`

### Message_DelegatesToCoreContext

```csharp
[Fact]
        public void Message_DelegatesToCoreContext()
        {
            // Arrange
            var testMessage = "Test message";

            // Act
            _manipulationData.Message = testMessage;

            // Assert
            ;
        }
```

**Returns:** `void`

### SetManipulator_DelegatesToCoreContext

```csharp
#endregion

        #region Method Delegation Tests

        [Fact]
        public void SetManipulator_DelegatesToCoreContext()
        {
            // Arrange
            var manipulatorId = "test-manipulator";

            // Act
            _manipulationData.SetManipulator(manipulatorId);

            // Assert
            ;
        }
```

**Returns:** `void`

### SetTarget_DelegatesToCoreContext

```csharp
[Fact]
        public void SetTarget_DelegatesToCoreContext()
        {
            // Arrange
            var targetObjectId = "test-target";

            // Act
            _manipulationData.SetTarget(targetObjectId);

            // Assert
            ;
        }
```

**Returns:** `void`

### SetAction_DelegatesToCoreContext

```csharp
[Fact]
        public void SetAction_DelegatesToCoreContext()
        {
            // Arrange
            var action = ManipulationAction.Build;

            // Act
            _manipulationData.SetAction(action);

            // Assert
            ;
        }
```

**Returns:** `void`

### UpdateStatus_DelegatesToCoreContext

```csharp
[Fact]
        public void UpdateStatus_DelegatesToCoreContext()
        {
            // Arrange
            var status = ManipulationStatus.Finished;

            // Act
            _manipulationData.UpdateStatus(status);

            // Assert
            ;
        }
```

**Returns:** `void`

### UpdateMessage_DelegatesToCoreContext

```csharp
[Fact]
        public void UpdateMessage_DelegatesToCoreContext()
        {
            // Arrange
            var message = "Updated message";

            // Act
            _manipulationData.UpdateMessage(message);

            // Assert
            ;
        }
```

**Returns:** `void`

### IsMoveAction_DelegatesToCoreContext

```csharp
#endregion

        #region Query Method Tests

        [Fact]
        public void IsMoveAction_DelegatesToCoreContext()
        {
            // Arrange
            _manipulationData.Action = ManipulationAction.Move;

            // Act & Assert
            ;

            // Arrange
            _manipulationData.Action = ManipulationAction.Build;

            // Act & Assert
            ;
        }
```

**Returns:** `void`

### IsDemolishAction_DelegatesToCoreContext

```csharp
[Fact]
        public void IsDemolishAction_DelegatesToCoreContext()
        {
            // Arrange
            _manipulationData.Action = ManipulationAction.Demolish;

            // Act & Assert
            ;

            // Arrange
            _manipulationData.Action = ManipulationAction.Build;

            // Act & Assert
            ;
        }
```

**Returns:** `void`

### IsRotateAction_DelegatesToCoreContext

```csharp
[Fact]
        public void IsRotateAction_DelegatesToCoreContext()
        {
            // Arrange
            _manipulationData.Action = ManipulationAction.Rotate_LEFT;

            // Act & Assert
            ;

            // Arrange
            _manipulationData.Action = ManipulationAction.Rotate_RIGHT;

            // Act & Assert
            ;

            // Arrange
            _manipulationData.Action = ManipulationAction.Build;

            // Act & Assert
            ;
        }
```

**Returns:** `void`

### IsFlipAction_DelegatesToCoreContext

```csharp
[Fact]
        public void IsFlipAction_DelegatesToCoreContext()
        {
            // Arrange
            _manipulationData.Action = ManipulationAction.FLIP_HORIZONTAL;

            // Act & Assert
            ;

            // Arrange
            _manipulationData.Action = ManipulationAction.FLIP_VERTICAL;

            // Act & Assert
            ;

            // Arrange
            _manipulationData.Action = ManipulationAction.Build;

            // Act & Assert
            ;
        }
```

**Returns:** `void`

### IsActive_DelegatesToCoreContext

```csharp
[Fact]
        public void IsActive_DelegatesToCoreContext()
        {
            // Arrange
            _manipulationData.Status = ManipulationStatus.Started;

            // Act & Assert
            ;

            // Arrange
            _manipulationData.Status = ManipulationStatus.Finished;

            // Act & Assert
            ;
        }
```

**Returns:** `void`

### IsCompleted_DelegatesToCoreContext

```csharp
[Fact]
        public void IsCompleted_DelegatesToCoreContext()
        {
            // Arrange
            _manipulationData.Status = ManipulationStatus.Finished;

            // Act & Assert
            ;

            // Arrange
            _manipulationData.Status = ManipulationStatus.Started;

            // Act & Assert
            ;
        }
```

**Returns:** `void`

### SetContextData_DelegatesToCoreContext

```csharp
#endregion

        #region Context Data Tests

        [Fact]
        public void SetContextData_DelegatesToCoreContext()
        {
            // Arrange
            var key = "testKey";
            var value = "testValue";

            // Act
            _manipulationData.SetContextData(key, value);

            // Assert
            ;
            ;
        }
```

**Returns:** `void`

### GetContextData_DelegatesToCoreContext

```csharp
[Fact]
        public void GetContextData_DelegatesToCoreContext()
        {
            // Arrange
            var key = "testKey";
            var value = "testValue";
            _manipulationData.SetContextData(key, value);

            // Act
            var retrievedValue = _manipulationData.GetContextData<string>(key);

            // Assert
            ;
        }
```

**Returns:** `void`

### GetContextData_WithDefault_DelegatesToCoreContext

```csharp
[Fact]
        public void GetContextData_WithDefault_DelegatesToCoreContext()
        {
            // Arrange
            var key = "nonExistentKey";
            var defaultValue = "defaultValue";

            // Act
            var value = _manipulationData.GetContextData<string>(key, defaultValue);

            // Assert
            ;
        }
```

**Returns:** `void`

### HasContextData_DelegatesToCoreContext

```csharp
[Fact]
        public void HasContextData_DelegatesToCoreContext()
        {
            // Arrange
            var key = "testKey";

            // Act & Assert
            ;

            // Arrange
            _manipulationData.SetContextData(key, "value");

            // Act & Assert
            ;
        }
```

**Returns:** `void`

### RemoveContextData_DelegatesToCoreContext

```csharp
[Fact]
        public void RemoveContextData_DelegatesToCoreContext()
        {
            // Arrange
            var key = "testKey";
            _manipulationData.SetContextData(key, "value");

            // Act
            var removed = _manipulationData.RemoveContextData(key);

            // Assert
            ;
            ;
        }
```

**Returns:** `void`

### Validate_DelegatesToCoreContext

```csharp
#endregion

        #region Validation Tests

        [Fact]
        public void Validate_DelegatesToCoreContext()
        {
            // Arrange
            _manipulationData.ManipulatorId = "test";
            _manipulationData.Action = ManipulationAction.Build;

            // Act
            var errors = _manipulationData.Validate();

            // Assert
            ;
        }
```

**Returns:** `void`

### Validate_InvalidData_DelegatesToCoreContext

```csharp
[Fact]
        public void Validate_InvalidData_DelegatesToCoreContext()
        {
            // Arrange
            _manipulationData.ManipulatorId = ""; // Invalid
            _manipulationData.Action = ManipulationAction.NONE; // Invalid

            // Act
            var errors = _manipulationData.Validate();

            // Assert
            Assert.NotEmpty(errors);
            ; // At least manipulator and action errors
        }
```

**Returns:** `void`

### Class_HasObsoleteAttribute

```csharp
#endregion

        #region Obsolete Attribute Tests

        [Fact]
        public void Class_HasObsoleteAttribute()
        {
            // Act
            var obsoleteAttribute = Attribute.GetCustomAttribute(
                typeof(ManipulationData), 
                typeof(ObsoleteAttribute)) as ObsoleteAttribute;

            // Assert
            ;
            ;
            ; // Should be marked as error to encourage migration
        }
```

**Returns:** `void`

### CompleteWorkflow_DemonstratesCoreIntegration

```csharp
#endregion

        #region Integration Tests

        [Fact]
        public void CompleteWorkflow_DemonstratesCoreIntegration()
        {
            // Arrange
            var manipulatorId = "player1";
            var targetObjectId = "building123";
            var action = ManipulationAction.Move;

            // Act - Simulate a complete manipulation workflow
            _manipulationData.SetManipulator(manipulatorId);
            _manipulationData.SetTarget(targetObjectId);
            _manipulationData.SetAction(action);
            _manipulationData.UpdateStatus(ManipulationStatus.Started);
            _manipulationData.SetContextData("startPosition", new Vector2I(1, 1));
            _manipulationData.SetContextData("endPosition", new Vector2I(3, 3));
            _manipulationData.UpdateStatus(ManipulationStatus.Finished);
            _manipulationData.UpdateMessage("Move completed successfully");

            // Assert - Verify all operations delegated correctly
            ;
            ;
            ;
            ;
            ;
            ;
            ;
            ;
            ;
        }
```

**Returns:** `void`

### NullManipulatorId_ThrowsException

```csharp
#endregion

        #region Error Handling Tests

        [Fact]
        public void NullManipulatorId_ThrowsException()
        {
            // Act & Assert
            Assert.Throws<ArgumentException>(() => 
                _manipulationData.SetManipulator(null));
        }
```

**Returns:** `void`

### EmptyManipulatorId_ThrowsException

```csharp
[Fact]
        public void EmptyManipulatorId_ThrowsException()
        {
            // Act & Assert
            Assert.Throws<ArgumentException>(() => 
                _manipulationData.SetManipulator(""));
        }
```

**Returns:** `void`

### NullTargetObjectId_ThrowsException

```csharp
[Fact]
        public void NullTargetObjectId_ThrowsException()
        {
            // Act & Assert
            Assert.Throws<ArgumentException>(() => 
                _manipulationData.SetTarget(null));
        }
```

**Returns:** `void`

### EmptyTargetObjectId_ForMoveAction_ThrowsException

```csharp
[Fact]
        public void EmptyTargetObjectId_ForMoveAction_ThrowsException()
        {
            // Arrange
            _manipulationData.Action = ManipulationAction.Move;

            // Act & Assert
            Assert.Throws<ArgumentException>(() => 
                _manipulationData.SetTarget(""));
        }
```

**Returns:** `void`

### NoneAction_ThrowsException

```csharp
[Fact]
        public void NoneAction_ThrowsException()
        {
            // Act & Assert
            Assert.Throws<ArgumentException>(() => 
                _manipulationData.SetAction(ManipulationAction.NONE));
        }
```

**Returns:** `void`

### InheritsFromRefCounted_MaintainsGodotCompatibility

```csharp
#endregion

        #region Godot Compatibility Tests

        [Fact]
        public void InheritsFromRefCounted_MaintainsGodotCompatibility()
        {
            // Assert
            ;
        }
```

**Returns:** `void`

### StringIdHandling_WorksCorrectly

```csharp
[Fact]
        public void StringIdHandling_WorksCorrectly()
        {
            // Arrange
            var nodeId = "node123";
            var playerId = "player456";

            // Act
            _manipulationData.SetManipulator(playerId);
            _manipulationData.SetTarget(nodeId);

            // Assert
            ;
            ;
            
            // Verify string-based ID system works (no Node references)
            Assert.IsType<string>(_manipulationData.ManipulatorId);
            Assert.IsType<string>(_manipulationData.TargetObjectId);
        }
```

**Returns:** `void`

