---
title: "SceneTreeIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/scenetreeintegrationtests/"
---

# SceneTreeIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class SceneTreeIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for SceneTree and scene operations.
Tests tree queries, deferred operations, and scene lifecycle.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/SceneTreeIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up SceneTree Integration Tests");
    }
```

**Returns:** `void`

### GetTree_ReturnsSceneTree

```csharp
#region Tree Query Tests

    [Test]
    public void GetTree_ReturnsSceneTree()
    {
        // Act
        var tree = _testScene.GetTree();

        // Assert
        tree.ShouldNotBeNull();
        tree.ShouldBeOfType<SceneTree>();
    }
```

**Returns:** `void`

### GetNodesInGroup_ReturnsGroupMembers

```csharp
[Test]
    public void GetNodesInGroup_ReturnsGroupMembers()
    {
        // Arrange
        var node1 = new Node();
        var node2 = new Node();
        _testScene.AddChild(node1);
        _testScene.AddChild(node2);
        node1.AddToGroup("test_group");
        node2.AddToGroup("test_group");

        // Act
        var members = _testScene.GetTree().GetNodesInGroup("test_group");

        // Assert
        members.Count.ShouldBe(2);

        // Cleanup
        node1.QueueFree();
        node2.QueueFree();
    }
```

**Returns:** `void`

### GetNodesInGroup_ReturnsEmpty_WhenNoMembers

```csharp
[Test]
    public void GetNodesInGroup_ReturnsEmpty_WhenNoMembers()
    {
        // Act
        var members = _testScene.GetTree().GetNodesInGroup("nonexistent_group_xyz");

        // Assert
        members.Count.ShouldBe(0);
    }
```

**Returns:** `void`

### HasGroup_ReturnsTrue_WhenGroupExists

```csharp
[Test]
    public void HasGroup_ReturnsTrue_WhenGroupExists()
    {
        // Arrange
        var node = new Node();
        _testScene.AddChild(node);
        node.AddToGroup("existing_group");

        // Act
        var result = _testScene.GetTree().HasGroup("existing_group");

        // Assert
        result.ShouldBeTrue();

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### GetNode_WithValidPath_ReturnsNode

```csharp
#endregion

    #region Node Path Tests

    [Test]
    public void GetNode_WithValidPath_ReturnsNode()
    {
        // Arrange
        var child = new Node { Name = "TestChild" };
        _testScene.AddChild(child);

        // Act
        var found = _testScene.GetNode("TestChild");

        // Assert
        found.ShouldBe(child);

        // Cleanup
        child.QueueFree();
    }
```

**Returns:** `void`

### GetNodeOrNull_WithInvalidPath_ReturnsNull

```csharp
[Test]
    public void GetNodeOrNull_WithInvalidPath_ReturnsNull()
    {
        // Act
        var found = _testScene.GetNodeOrNull("NonexistentNode");

        // Assert
        found.ShouldBeNull();
    }
```

**Returns:** `void`

### GetPath_ReturnsAbsolutePath

```csharp
[Test]
    public void GetPath_ReturnsAbsolutePath()
    {
        // Arrange
        var child = new Node { Name = "PathTestChild" };
        _testScene.AddChild(child);

        // Act
        var path = child.GetPath();

        // Assert
        path.ToString().ShouldContain("PathTestChild");

        // Cleanup
        child.QueueFree();
    }
```

**Returns:** `void`

### GetPathTo_ReturnsRelativePath

```csharp
[Test]
    public void GetPathTo_ReturnsRelativePath()
    {
        // Arrange
        var parent = new Node { Name = "Parent" };
        var child = new Node { Name = "Child" };
        _testScene.AddChild(parent);
        parent.AddChild(child);

        // Act
        var path = parent.GetPathTo(child);

        // Assert
        path.ToString().ShouldBe("Child");

        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

### CallDeferred_QueuesOperation

```csharp
#endregion

    #region Deferred Operations Tests

    [Test]
    public void CallDeferred_QueuesOperation()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);

        // Act: Queue a deferred call (doesn't execute immediately)
        node.CallDeferred("set_position", new Vector2(100, 100));

        // Assert: Position not changed yet (deferred)
        // Note: In a real test, we'd wait for the next frame
        node.Position.ShouldBe(Vector2.Zero);

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### SetDeferred_QueuesPropertyChange

```csharp
[Test]
    public void SetDeferred_QueuesPropertyChange()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        node.Visible = true;

        // Act
        node.SetDeferred("visible", false);

        // Assert: Still visible (deferred)
        node.Visible.ShouldBeTrue();

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### GetChildren_ReturnsDirectChildren

```csharp
#endregion

    #region Tree Traversal Tests

    [Test]
    public void GetChildren_ReturnsDirectChildren()
    {
        // Arrange
        var child1 = new Node { Name = "Child1" };
        var child2 = new Node { Name = "Child2" };
        var parent = new Node { Name = "Parent" };
        _testScene.AddChild(parent);
        parent.AddChild(child1);
        parent.AddChild(child2);

        // Act
        var children = parent.GetChildren();

        // Assert
        children.Count.ShouldBe(2);

        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

### GetChildCount_ReturnsCount

```csharp
[Test]
    public void GetChildCount_ReturnsCount()
    {
        // Arrange
        var parent = new Node { Name = "Parent" };
        _testScene.AddChild(parent);
        parent.AddChild(new Node());
        parent.AddChild(new Node());
        parent.AddChild(new Node());

        // Act
        var count = parent.GetChildCount();

        // Assert
        count.ShouldBe(3);

        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

### GetChild_WithIndex_ReturnsChild

```csharp
[Test]
    public void GetChild_WithIndex_ReturnsChild()
    {
        // Arrange
        var parent = new Node { Name = "Parent" };
        var child0 = new Node { Name = "Child0" };
        var child1 = new Node { Name = "Child1" };
        _testScene.AddChild(parent);
        parent.AddChild(child0);
        parent.AddChild(child1);

        // Act
        var found = parent.GetChild(1);

        // Assert
        found.Name.ToString().ShouldBe("Child1");

        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

### GetParent_ReturnsParentNode

```csharp
[Test]
    public void GetParent_ReturnsParentNode()
    {
        // Arrange
        var parent = new Node { Name = "Parent" };
        var child = new Node { Name = "Child" };
        _testScene.AddChild(parent);
        parent.AddChild(child);

        // Act
        var foundParent = child.GetParent();

        // Assert
        foundParent.ShouldBe(parent);

        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

### Owner_CanBeSet

```csharp
#endregion

    #region Owner and Scene Tests

    [Test]
    public void Owner_CanBeSet()
    {
        // Arrange
        var owner = new Node { Name = "Owner" };
        var child = new Node { Name = "Owned" };
        _testScene.AddChild(owner);
        owner.AddChild(child);

        // Act
        child.Owner = owner;

        // Assert
        child.Owner.ShouldBe(owner);

        // Cleanup
        owner.QueueFree();
    }
```

**Returns:** `void`

### SceneFilePath_IsEmpty_ForRuntimeNodes

```csharp
[Test]
    public void SceneFilePath_IsEmpty_ForRuntimeNodes()
    {
        // Arrange
        var node = new Node();
        _testScene.AddChild(node);

        // Act
        var path = node.SceneFilePath;

        // Assert
        path.ShouldBeEmpty();

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### ProcessMode_CanBeSet

```csharp
#endregion

    #region Process Mode Tests

    [Test]
    public void ProcessMode_CanBeSet()
    {
        // Arrange
        var node = new Node();
        _testScene.AddChild(node);

        // Act
        node.ProcessMode = Node.ProcessModeEnum.Pausable;

        // Assert
        node.ProcessMode.ShouldBe(Node.ProcessModeEnum.Pausable);

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### CanProcess_ReturnsTrue_WhenTreeNotPaused

```csharp
[Test]
    public void CanProcess_ReturnsTrue_WhenTreeNotPaused()
    {
        // Arrange
        var node = new Node();
        _testScene.AddChild(node);
        node.ProcessMode = Node.ProcessModeEnum.Inherit;

        // Act
        var canProcess = node.CanProcess();

        // Assert: Should be true when tree is not paused
        canProcess.ShouldBeTrue();

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### GetIndex_ReturnsChildIndex

```csharp
#endregion

    #region Node Ordering Tests

    [Test]
    public void GetIndex_ReturnsChildIndex()
    {
        // Arrange
        var parent = new Node { Name = "Parent" };
        var child0 = new Node { Name = "Child0" };
        var child1 = new Node { Name = "Child1" };
        _testScene.AddChild(parent);
        parent.AddChild(child0);
        parent.AddChild(child1);

        // Act
        var index = child1.GetIndex();

        // Assert
        index.ShouldBe(1);

        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

### MoveChild_ChangesChildOrder

```csharp
[Test]
    public void MoveChild_ChangesChildOrder()
    {
        // Arrange
        var parent = new Node { Name = "Parent" };
        var child0 = new Node { Name = "Child0" };
        var child1 = new Node { Name = "Child1" };
        _testScene.AddChild(parent);
        parent.AddChild(child0);
        parent.AddChild(child1);

        // Act
        parent.MoveChild(child1, 0);

        // Assert
        parent.GetChild(0).ShouldBe(child1);
        parent.GetChild(1).ShouldBe(child0);

        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

