---
title: "GridTargetingStateTest"
description: "Unit tests for GridTargetingState Core POCS implementation.
Tests state management without Godot dependencies."
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridtargetingstatetest/"
---

# GridTargetingStateTest

```csharp
GridBuilding.Godot.Tests.Contexts
class GridTargetingStateTest
{
    // Members...
}
```

Unit tests for GridTargetingState Core POCS implementation.
Tests state management without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GridTargetingStateTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_WithOwnerContext_SetsOwnerContext

```csharp
#endregion

    #region Constructor Tests

    [Fact]
    public void Constructor_WithOwnerContext_SetsOwnerContext()
    {
        // Arrange
        var ownerContext = new MockGBOwnerContext();

        // Act
        var state = new GridTargetingState(ownerContext);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### Constructor_Default_CreatesValidState

```csharp
[Fact]
    public void Constructor_Default_CreatesValidState()
    {
        // Act
        var state = new GridTargetingState();

        // Assert
        ;
        ; // No owner context set
        ;
    }
```

**Returns:** `void`

### IsReady_WithValidSetup_ReturnsTrue

```csharp
#endregion

    #region Readiness Tests

    [Fact]
    public void IsReady_WithValidSetup_ReturnsTrue()
    {
        // Arrange
        _state.TargetMap = new MockTileMap();
        _state.Positioner = new MockNode2D();
        _state.Maps = new List<object> { new MockTileMap() };

        // Act
        var isReady = _state.IsReady();

        // Assert
        ;
    }
```

**Returns:** `void`

### IsReady_MissingTargetMap_ReturnsFalse

```csharp
[Fact]
    public void IsReady_MissingTargetMap_ReturnsFalse()
    {
        // Arrange
        _state.Positioner = new MockNode2D();
        _state.Maps = new List<object> { new MockTileMap() };

        // Act
        var isReady = _state.IsReady();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### IsReady_MissingPositioner_ReturnsFalse

```csharp
[Fact]
    public void IsReady_MissingPositioner_ReturnsFalse()
    {
        // Arrange
        _state.TargetMap = new MockTileMap();
        _state.Maps = new List<object> { new MockTileMap() };

        // Act
        var isReady = _state.IsReady();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### IsReady_EmptyMaps_ReturnsFalse

```csharp
[Fact]
    public void IsReady_EmptyMaps_ReturnsFalse()
    {
        // Arrange
        _state.TargetMap = new MockTileMap();
        _state.Positioner = new MockNode2D();
        _state.Maps = new List<object>();

        // Act
        var isReady = _state.IsReady();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### SetCollider_WithValidCollider_SetsTarget

```csharp
#endregion

    #region Target Management Tests

    [Fact]
    public void SetCollider_WithValidCollider_SetsTarget()
    {
        // Arrange
        var collider = new MockNode2D();

        // Act
        _state.SetCollider(collider);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### SetCollider_WithNull_SetsNullTarget

```csharp
[Fact]
    public void SetCollider_WithNull_SetsNullTarget()
    {
        // Act
        _state.SetCollider(null);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### SetManualTarget_SetsTargetAndEnablesManualMode

```csharp
[Fact]
    public void SetManualTarget_SetsTargetAndEnablesManualMode()
    {
        // Arrange
        var target = new MockNode2D();

        // Act
        _state.SetManualTarget(target);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### Clear_DisablesManualModeAndClearsTarget

```csharp
[Fact]
    public void Clear_DisablesManualModeAndClearsTarget()
    {
        // Arrange
        var target = new MockNode2D();
        _state.SetManualTarget(target);

        // Act
        _state.Clear();

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### Positioner_SetValue_RaisesEvent

```csharp
#endregion

    #region Property Tests

    [Fact]
    public void Positioner_SetValue_RaisesEvent()
    {
        // Arrange
        object? receivedPositioner = null;
        _state.PositionerChanged += (positioner) => receivedPositioner = positioner;
        var newPositioner = new MockNode2D();

        // Act
        _state.Positioner = newPositioner;

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### TargetMap_SetValue_RaisesEvent

```csharp
[Fact]
    public void TargetMap_SetValue_RaisesEvent()
    {
        // Arrange
        object? receivedTargetMap = null;
        _state.TargetMapChanged += (targetMap) => receivedTargetMap = targetMap;
        var newTargetMap = new MockTileMap();

        // Act
        _state.TargetMap = newTargetMap;

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### Maps_SetValue_RaisesEvent

```csharp
[Fact]
    public void Maps_SetValue_RaisesEvent()
    {
        // Arrange
        IList<object>? receivedMaps = null;
        _state.MapsChanged += (maps) => receivedMaps = maps;
        var newMaps = new List<object> { new MockTileMap(), new MockTileMap() };

        // Act
        _state.Maps = newMaps;

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### TileSize_GetValue_ReturnsDefaultOrMetadata

```csharp
[Fact]
    public void TileSize_GetValue_ReturnsDefaultOrMetadata()
    {
        // Act
        var tileSize = _state.TileSize;

        // Assert
        ; // Default fallback
    }
```

**Returns:** `void`

### CollisionExclusions_SetValue_SetsCollection

```csharp
[Fact]
    public void CollisionExclusions_SetValue_SetsCollection()
    {
        // Arrange
        var exclusions = new List<object> { new MockNode2D(), new MockNode2D() };

        // Act
        _state.CollisionExclusions = exclusions;

        // Assert
        ;
    }
```

**Returns:** `void`

### ClearCollisionExclusions_ClearsCollection

```csharp
[Fact]
    public void ClearCollisionExclusions_ClearsCollection()
    {
        // Arrange
        _state.CollisionExclusions = new List<object> { new MockNode2D() };

        // Act
        _state.ClearCollisionExclusions();

        // Assert
        ;
    }
```

**Returns:** `void`

### ReadyChanged_WhenReadinessChanges_RaisesEvent

```csharp
#endregion

    #region Event Tests

    [Fact]
    public void ReadyChanged_WhenReadinessChanges_RaisesEvent()
    {
        // Arrange
        bool? readyReceived = null;
        _state.ReadyChanged += (ready) => readyReceived = ready;

        // Act - Make state ready
        _state.TargetMap = new MockTileMap();
        _state.Positioner = new MockNode2D();
        _state.Maps = new List<object> { new MockTileMap() };

        // Assert
        ;
    }
```

**Returns:** `void`

### TargetChanged_WhenTargetChanges_RaisesEvent

```csharp
[Fact]
    public void TargetChanged_WhenTargetChanges_RaisesEvent()
    {
        // Arrange
        object? oldTarget = null;
        object? newTarget = null;
        _state.TargetChanged += (old, @new) =>
        {
            oldTarget = old;
            newTarget = @new;
        };
        var target = new MockNode2D();

        // Act
        _state.SetManualTarget(target);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### SetMapObjects_SetsProperties

```csharp
#endregion

    #region Helper Methods Tests

    [Fact]
    public void SetMapObjects_SetsProperties()
    {
        // Arrange
        var targetMap = new MockTileMap();
        var maps = new List<object> { new MockTileMap(), new MockTileMap() };

        // Act
        _state.SetMapObjects(targetMap, maps);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### GetTargetMapTileSet_WithoutTargetMap_ReturnsNull

```csharp
[Fact]
    public void GetTargetMapTileSet_WithoutTargetMap_ReturnsNull()
    {
        // Act
        var tileSet = _state.GetTargetMapTileSet();

        // Assert
        ;
    }
```

**Returns:** `void`

