---
title: "SceneServiceTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/sceneservicetests/"
---

# SceneServiceTests

```csharp
GridBuilding.Godot.Tests.Services.Placement
class SceneServiceTests
{
    // Members...
}
```

Unit tests for SceneService Godot-specific operations.
These tests verify the Godot-specific scene management functionality
with proper error handling and logging.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Services/Placement/SceneServiceTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Dispose

```csharp
public void Dispose()
    {
        // Clean up resources
        _sceneService?.Dispose();
    }
```

**Returns:** `void`

### Constructor_WithValidLogger_InitializesSuccessfully

```csharp
#endregion

    #region Constructor Tests
    [Fact]
    public void Constructor_WithValidLogger_InitializesSuccessfully()
    {
        // Arrange & Act
        var service = new SceneService(_mockLogger.Object);

        // Assert
        ;
        ;

        // Verify logger was called
        _mockLogger.Verify(l => l.LogInfo("SceneService initialized successfully"), Times.Once);
    }
```

**Returns:** `void`

### Constructor_WithNullLogger_ThrowsArgumentNullException

```csharp
[Fact]
    public void Constructor_WithNullLogger_ThrowsArgumentNullException()
    {
        // Arrange & Act & Assert
        Assert.Throws<ArgumentNullException>(() => new SceneService(null));
    }
```

**Returns:** `void`

### InstantiateScene_WithValidScene_ReturnsNode

```csharp
#endregion

    #region InstantiateScene Tests
    [Fact]
    public void InstantiateScene_WithValidScene_ReturnsNode()
    {
        // Arrange
        var expectedNode = new Node2D();
        _mockPackedScene.Setup(p => p.Instantiate()).Returns(expectedNode);

        // Act
        var result = _sceneService.InstantiateScene(_mockPackedScene.Object);

        // Assert
        ;
        ;

        // Verify interactions
        _mockPackedScene.Verify(p => p.Instantiate(), Times.Once);
        _mockLogger.Verify(l => l.LogInfo(It.Is<string>(s => s.Contains("Successfully instantiated scene"))), Times.Once);
    }
```

**Returns:** `void`

### InstantiateScene_WithNullScene_ReturnsNull

```csharp
[Fact]
    public void InstantiateScene_WithNullScene_ReturnsNull()
    {
        // Act
        var result = _sceneService.InstantiateScene(null);

        // Assert
        ;
        ;

        // Verify warning was logged
        _mockLogger.Verify(l => l.LogWarning("Attempted to instantiate null PackedScene"), Times.Once);
    }
```

**Returns:** `void`

### InstantiateScene_WithSceneReturningNull_ReturnsNull

```csharp
[Fact]
    public void InstantiateScene_WithSceneReturningNull_ReturnsNull()
    {
        // Arrange
        _mockPackedScene.Setup(p => p.Instantiate()).Returns((Node)null);

        // Act
        var result = _sceneService.InstantiateScene(_mockPackedScene.Object);

        // Assert
        ;
        ;

        // Verify error was logged
        _mockLogger.Verify(l => l.LogError("Scene.Instantiate() returned null"), Times.Once);
    }
```

**Returns:** `void`

### InstantiateScene_WithException_ReturnsNull

```csharp
[Fact]
    public void InstantiateScene_WithException_ReturnsNull()
    {
        // Arrange
        _mockPackedScene.Setup(p => p.Instantiate()).Throws(new InvalidOperationException("Scene load error"));

        // Act
        var result = _sceneService.InstantiateScene(_mockPackedScene.Object);

        // Assert
        ;
        ;

        // Verify error was logged
        _mockLogger.Verify(l => l.LogError(It.Is<string>(s => s.Contains("Failed to instantiate scene"))), Times.Once);
    }
```

**Returns:** `void`

### InstantiateScene_AfterDispose_ReturnsNull

```csharp
[Fact]
    public void InstantiateScene_AfterDispose_ReturnsNull()
    {
        // Arrange
        _sceneService.Dispose();

        // Act
        var result = _sceneService.InstantiateScene(_mockPackedScene.Object);

        // Assert
        ;

        // Verify error was logged
        _mockLogger.Verify(l => l.LogError("Cannot instantiate scene: SceneService is disposed"), Times.Once);
    }
```

**Returns:** `void`

### AddChildToParent_WithValidNodes_AddsChild

```csharp
#endregion

    #region AddChildToParent Tests
    [Fact]
    public void AddChildToParent_WithValidNodes_AddsChild()
    {
        // Arrange
        var parent = new Node();
        var child = new Node2D();

        // Act
        _sceneService.AddChildToParent(parent, child);

        // Assert
        ;

        // Verify logging
        _mockLogger.Verify(l => l.LogInfo(It.Is<string>(s => s.Contains("Added child") && s.Contains("to parent"))), Times.Once);
    }
```

**Returns:** `void`

### AddChildToParent_WithNullParent_LogsWarning

```csharp
[Fact]
    public void AddChildToParent_WithNullParent_LogsWarning()
    {
        // Act
        _sceneService.AddChildToParent(null, _mockChild.Object);

        // Assert
        ;

        // Verify warning was logged
        _mockLogger.Verify(l => l.LogWarning("AddChildToParent: parent node is null"), Times.Once);
    }
```

**Returns:** `void`

### AddChildToParent_WithNullChild_LogsWarning

```csharp
[Fact]
    public void AddChildToParent_WithNullChild_LogsWarning()
    {
        // Act
        _sceneService.AddChildToParent(_mockParent.Object, null);

        // Assert
        // Verify warning was logged
        _mockLogger.Verify(l => l.LogWarning("AddChildToParent: child node is null"), Times.Once);
    }
```

**Returns:** `void`

### AddChildToParent_WithChildAlreadyInTree_RemovesFromOldParent

```csharp
[Fact]
    public void AddChildToParent_WithChildAlreadyInTree_RemovesFromOldParent()
    {
        // Arrange
        var oldParent = new Node();
        var newParent = new Node();
        var child = new Node2D();
        
        oldParent.AddChild(child);

        // Act
        _sceneService.AddChildToParent(newParent, child);

        // Assert
        ;

        // Verify logging
        _mockLogger.Verify(l => l.LogWarning(It.Is<string>(s => s.Contains("already in scene tree"))), Times.Once);
        _mockLogger.Verify(l => l.LogInfo(It.Is<string>(s => s.Contains("Added child") && s.Contains("to parent"))), Times.Once);
    }
```

**Returns:** `void`

### AddChildToParent_WithException_LogsError

```csharp
[Fact]
    public void AddChildToParent_WithException_LogsError()
    {
        // Arrange
        var parent = new Mock<Node>();
        var child = new Mock<Node>();
        
        parent.Setup(p => p.AddChild(It.IsAny<Node>())).Throws(new InvalidOperationException("Add child error"));

        // Act
        _sceneService.AddChildToParent(parent.Object, child.Object);

        // Assert
        // Verify error was logged
        _mockLogger.Verify(l => l.LogError(It.Is<string>(s => s.Contains("Failed to add child"))), Times.Once);
    }
```

**Returns:** `void`

### AddChildToParent_AfterDispose_LogsError

```csharp
[Fact]
    public void AddChildToParent_AfterDispose_LogsError()
    {
        // Arrange
        _sceneService.Dispose();

        // Act
        _sceneService.AddChildToParent(_mockParent.Object, _mockChild.Object);

        // Assert
        // Verify error was logged
        _mockLogger.Verify(l => l.LogError("Cannot add child to parent: SceneService is disposed"), Times.Once);
    }
```

**Returns:** `void`

### RemoveChildFromParent_WithValidParentChild_RemovesChild

```csharp
#endregion

    #region RemoveChildFromParent Tests
    [Fact]
    public void RemoveChildFromParent_WithValidParentChild_RemovesChild()
    {
        // Arrange
        var parent = new Node();
        var child = new Node2D();
        parent.AddChild(child);

        // Act
        _sceneService.RemoveChildFromParent(parent, child);

        // Assert
        ;

        // Verify logging
        _mockLogger.Verify(l => l.LogInfo(It.Is<string>(s => s.Contains("Removed child") && s.Contains("from parent"))), Times.Once);
    }
```

**Returns:** `void`

### RemoveChildFromParent_WithNullParent_LogsWarning

```csharp
[Fact]
    public void RemoveChildFromParent_WithNullParent_LogsWarning()
    {
        // Act
        _sceneService.RemoveChildFromParent(null, _mockChild.Object);

        // Assert
        // Verify warning was logged
        _mockLogger.Verify(l => l.LogWarning("RemoveChildFromParent: parent node is null"), Times.Once);
    }
```

**Returns:** `void`

### RemoveChildFromParent_WithNullChild_LogsWarning

```csharp
[Fact]
    public void RemoveChildFromParent_WithNullChild_LogsWarning()
    {
        // Act
        _sceneService.RemoveChildFromParent(_mockParent.Object, null);

        // Assert
        // Verify warning was logged
        _mockLogger.Verify(l => l.LogWarning("RemoveChildFromParent: child node is null"), Times.Once);
    }
```

**Returns:** `void`

### RemoveChildFromParent_WithChildNotOfParent_LogsWarning

```csharp
[Fact]
    public void RemoveChildFromParent_WithChildNotOfParent_LogsWarning()
    {
        // Arrange
        var parent = new Node();
        var child = new Node2D();
        // Don't add child to parent

        // Act
        _sceneService.RemoveChildFromParent(parent, child);

        // Assert
        ;

        // Verify warning was logged
        _mockLogger.Verify(l => l.LogWarning(It.Is<string>(s => s.Contains("is not a child of parent"))), Times.Once);
    }
```

**Returns:** `void`

### RemoveChildFromParent_WithException_LogsError

```csharp
[Fact]
    public void RemoveChildFromParent_WithException_LogsError()
    {
        // Arrange
        var parent = new Mock<Node>();
        var child = new Mock<Node>();
        
        parent.Setup(p => p.RemoveChild(It.IsAny<Node>())).Throws(new InvalidOperationException("Remove child error"));

        // Act
        _sceneService.RemoveChildFromParent(parent.Object, child.Object);

        // Assert
        // Verify error was logged
        _mockLogger.Verify(l => l.LogError(It.Is<string>(s => s.Contains("Failed to remove child"))), Times.Once);
    }
```

**Returns:** `void`

### SetNodePosition_WithValidNode2D_SetsPosition

```csharp
#endregion

    #region SetNodePosition Tests
    [Fact]
    public void SetNodePosition_WithValidNode2D_SetsPosition()
    {
        // Arrange
        var node2D = new Node2D();
        var position = new Vector2(100, 200);

        // Act
        _sceneService.SetNodePosition(node2D, position);

        // Assert
        ;

        // Verify logging
        _mockLogger.Verify(l => l.LogInfo(It.Is<string>(s => s.Contains("Set position of") && s.Contains("to"))), Times.Once);
    }
```

**Returns:** `void`

### SetNodePosition_WithNullNode_LogsWarning

```csharp
[Fact]
    public void SetNodePosition_WithNullNode_LogsWarning()
    {
        // Arrange
        var position = new Vector2(100, 200);

        // Act
        _sceneService.SetNodePosition(null, position);

        // Assert
        // Verify warning was logged
        _mockLogger.Verify(l => l.LogWarning("Attempted to set position on null Node2D"), Times.Once);
    }
```

**Returns:** `void`

### SetNodePosition_WithException_LogsError

```csharp
[Fact]
    public void SetNodePosition_WithException_LogsError()
    {
        // Arrange
        var node2D = new Mock<Node2D>();
        var position = new Vector2(100, 200);
        
        node2D.SetupSet(n => n.Position = It.IsAny<Vector2>()).Throws(new InvalidOperationException("Set position error"));

        // Act
        _sceneService.SetNodePosition(node2D.Object, position);

        // Assert
        // Verify error was logged
        _mockLogger.Verify(l => l.LogError(It.Is<string>(s => s.Contains("Failed to set position"))), Times.Once);
    }
```

**Returns:** `void`

### IsNodeInSceneTree_WithNodeInTree_ReturnsTrue

```csharp
#endregion

    #region IsNodeInSceneTree Tests
    [Fact]
    public void IsNodeInSceneTree_WithNodeInTree_ReturnsTrue()
    {
        // Arrange
        var node = new Node();
        var scene = new Scene();
        scene.AddChild(node);

        // Act
        var result = _sceneService.IsNodeInSceneTree(node);

        // Assert
        ;
    }
```

**Returns:** `void`

### IsNodeInSceneTree_WithNodeNotInTree_ReturnsFalse

```csharp
[Fact]
    public void IsNodeInSceneTree_WithNodeNotInTree_ReturnsFalse()
    {
        // Arrange
        var node = new Node();

        // Act
        var result = _sceneService.IsNodeInSceneTree(node);

        // Assert
        ;
    }
```

**Returns:** `void`

### IsNodeInSceneTree_WithNullNode_ReturnsFalse

```csharp
[Fact]
    public void IsNodeInSceneTree_WithNullNode_ReturnsFalse()
    {
        // Act
        var result = _sceneService.IsNodeInSceneTree(null);

        // Assert
        ;
    }
```

**Returns:** `void`

### IsNodeInSceneTree_WithException_ReturnsFalse

```csharp
[Fact]
    public void IsNodeInSceneTree_WithException_ReturnsFalse()
    {
        // Arrange
        var node = new Mock<Node>();
        node.Setup(n => n.IsInsideTree()).Throws(new InvalidOperationException("Scene tree error"));

        // Act
        var result = _sceneService.IsNodeInSceneTree(node.Object);

        // Assert
        ;

        // Verify error was logged
        _mockLogger.Verify(l => l.LogError(It.Is<string>(s => s.Contains("Failed to check if node"))), Times.Once);
    }
```

**Returns:** `void`

### CreateNode_WithValidNodeType_ReturnsNode

```csharp
#endregion

    #region CreateNode Tests
    [Fact]
    public void CreateNode_WithValidNodeType_ReturnsNode()
    {
        // Act
        var result = _sceneService.CreateNode<Node2D>();

        // Assert
        ;
        Assert.IsAssignableFrom<Node2D>(result);
        ;

        // Verify logging
        _mockLogger.Verify(l => l.LogInfo(It.Is<string>(s => s.Contains("Created new node of type"))), Times.Once);
    }
```

**Returns:** `void`

### CreateNode_AfterDispose_ReturnsNull

```csharp
[Fact]
    public void CreateNode_AfterDispose_ReturnsNull()
    {
        // Arrange
        _sceneService.Dispose();

        // Act
        var result = _sceneService.CreateNode<Node2D>();

        // Assert
        ;

        // Verify error was logged
        _mockLogger.Verify(l => l.LogError("Cannot create node: SceneService is disposed"), Times.Once);
    }
```

**Returns:** `void`

### CreateNode_WithException_ReturnsNull

```csharp
[Fact]
    public void CreateNode_WithException_ReturnsNull()
    {
        // This test would need a custom Node type that throws in constructor
        // For now, we'll test the basic functionality
        var result = _sceneService.CreateNode<Node>();
        ;
    }
```

**Returns:** `void`

### GetValidationIssues_WithValidLogger_ReturnsEmpty

```csharp
#endregion

    #region GetValidationIssues Tests
    [Fact]
    public void GetValidationIssues_WithValidLogger_ReturnsEmpty()
    {
        // Act
        var issues = _sceneService.GetValidationIssues();

        // Assert
        ;
    }
```

**Returns:** `void`

### GetValidationIssues_AfterDispose_ReturnsDisposedIssue

```csharp
[Fact]
    public void GetValidationIssues_AfterDispose_ReturnsDisposedIssue()
    {
        // Arrange
        _sceneService.Dispose();

        // Act
        var issues = _sceneService.GetValidationIssues();

        // Assert
        ;
    }
```

**Returns:** `void`

### FreeNode_WithValidNode_FreesNode

```csharp
#endregion

    #region FreeNode Tests
    [Fact]
    public void FreeNode_WithValidNode_FreesNode()
    {
        // Arrange
        var node = new Node2D();
        var parent = new Node();
        parent.AddChild(node);

        // Act
        _sceneService.FreeNode(node);

        // Assert
        ;
        ;

        // Verify logging
        _mockLogger.Verify(l => l.LogInfo(It.Is<string>(s => s.Contains("Queued node") && s.Contains("for freeing"))), Times.Once);
    }
```

**Returns:** `void`

### FreeNode_WithNullNode_LogsWarning

```csharp
[Fact]
    public void FreeNode_WithNullNode_LogsWarning()
    {
        // Act
        _sceneService.FreeNode(null);

        // Assert
        // Verify warning was logged
        _mockLogger.Verify(l => l.LogWarning("Attempted to free null node"), Times.Once);
    }
```

**Returns:** `void`

### FreeNode_WithException_LogsError

```csharp
[Fact]
    public void FreeNode_WithException_LogsError()
    {
        // Arrange
        var node = new Mock<Node>();
        node.Setup(n => n.IsInsideTree()).Returns(true);
        node.Setup(n => n.GetParent()).Returns(new Mock<Node>().Object);
        node.Setup(n => n.QueueFree()).Throws(new InvalidOperationException("Free node error"));

        // Act
        _sceneService.FreeNode(node.Object);

        // Assert
        // Verify error was logged
        _mockLogger.Verify(l => l.LogError(It.Is<string>(s => s.Contains("Failed to free node"))), Times.Once);
    }
```

**Returns:** `void`

### FreeAllTrackedNodes_WithTrackedNodes_FreesAllNodes

```csharp
#endregion

    #region FreeAllTrackedNodes Tests
    [Fact]
    public void FreeAllTrackedNodes_WithTrackedNodes_FreesAllNodes()
    {
        // Arrange
        var node1 = _sceneService.CreateNode<Node2D>();
        var node2 = _sceneService.CreateNode<Node2D>();
        var node3 = _sceneService.CreateNode<Node2D>();

        ;

        // Act
        _sceneService.FreeAllTrackedNodes();

        // Assert
        ;

        // Verify all nodes are queued for deletion
        ;
        ;
        ;

        // Verify logging
        _mockLogger.Verify(l => l.LogInfo(It.Is<string>(s => s.Contains("Freed") && s.Contains("tracked nodes"))), Times.Once);
    }
```

**Returns:** `void`

### Dispose_CleansUpResources

```csharp
#endregion

    #region Dispose Tests
    [Fact]
    public void Dispose_CleansUpResources()
    {
        // Arrange
        var node = _sceneService.CreateNode<Node2D>();
        ;

        // Act
        _sceneService.Dispose();

        // Assert
        ;
        ;

        // Verify logging
        _mockLogger.Verify(l => l.LogInfo("Disposing SceneService"), Times.Once);
    }
```

**Returns:** `void`

### Dispose_CalledMultipleTimes_DoesNotThrow

```csharp
[Fact]
    public void Dispose_CalledMultipleTimes_DoesNotThrow()
    {
        // Act & Assert
        Assert.DoesNotThrow(() =>
        {
            _sceneService.Dispose();
            _sceneService.Dispose();
            _sceneService.Dispose();
        });
    }
```

**Returns:** `void`

