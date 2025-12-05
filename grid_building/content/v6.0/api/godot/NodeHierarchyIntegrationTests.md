---
title: "NodeHierarchyIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/nodehierarchyintegrationtests/"
---

# NodeHierarchyIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class NodeHierarchyIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for Node hierarchy and scene tree operations.
Ported from: helpers/utils/node_search/node_search_logic_test.gd
Tests node traversal, searching, and hierarchy manipulation that require
actual Godot scene tree operations.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/NodeHierarchyIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Node Hierarchy Integration Tests");
    }
```

**Returns:** `void`

### Setup

```csharp
[Setup]
    public void Setup()
    {
        _testNodes.Clear();
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        foreach (var node in _testNodes)
        {
            node.QueueFree();
        }
        _testNodes.Clear();
    }
```

**Returns:** `void`

### AddChild_AddsNodeToParent

```csharp
#region Node Creation and Hierarchy Tests

    [Test]
    public void AddChild_AddsNodeToParent()
    {
        // Arrange
        var parent = CreateTestNode("Parent");
        var child = CreateTestNode("Child");

        // Act
        parent.AddChild(child);

        // Assert
        parent.GetChildCount().ShouldBe(1);
        parent.GetChild(0).ShouldBe(child);
        child.GetParent().ShouldBe(parent);
    }
```

**Returns:** `void`

### RemoveChild_RemovesNodeFromParent

```csharp
[Test]
    public void RemoveChild_RemovesNodeFromParent()
    {
        // Arrange
        var parent = CreateTestNode("Parent");
        var child = CreateTestNode("Child");
        parent.AddChild(child);

        // Act
        parent.RemoveChild(child);

        // Assert
        parent.GetChildCount().ShouldBe(0);
        child.GetParent().ShouldBeNull();
    }
```

**Returns:** `void`

### GetChildren_ReturnsAllDirectChildren

```csharp
[Test]
    public void GetChildren_ReturnsAllDirectChildren()
    {
        // Arrange
        var parent = CreateTestNode("Parent");
        var child1 = CreateTestNode("Child1");
        var child2 = CreateTestNode("Child2");
        var child3 = CreateTestNode("Child3");
        parent.AddChild(child1);
        parent.AddChild(child2);
        parent.AddChild(child3);

        // Act
        var children = parent.GetChildren();

        // Assert
        children.Count.ShouldBe(3);
        children.ShouldContain(child1);
        children.ShouldContain(child2);
        children.ShouldContain(child3);
    }
```

**Returns:** `void`

### GetChildren_DoesNotIncludeGrandchildren

```csharp
[Test]
    public void GetChildren_DoesNotIncludeGrandchildren()
    {
        // Arrange
        var parent = CreateTestNode("Parent");
        var child = CreateTestNode("Child");
        var grandchild = CreateTestNode("Grandchild");
        parent.AddChild(child);
        child.AddChild(grandchild);

        // Act
        var children = parent.GetChildren();

        // Assert
        children.Count.ShouldBe(1);
        children.ShouldContain(child);
        children.ShouldNotContain(grandchild);
    }
```

**Returns:** `void`

### FindNodesByName_FindsExactMatch

```csharp
#endregion

    #region Node Name Search Tests

    [Test]
    public void FindNodesByName_FindsExactMatch()
    {
        // Arrange
        var parent = CreateTestNode("Parent");
        var target = CreateTestNode("TargetNode");
        var other = CreateTestNode("OtherNode");
        parent.AddChild(target);
        parent.AddChild(other);

        // Act
        var found = FindNodesByName(parent, "TargetNode");

        // Assert
        found.Count.ShouldBe(1);
        found[0].ShouldBe(target);
    }
```

**Returns:** `void`

### FindNodesByName_ReturnsEmptyForNoMatch

```csharp
[Test]
    public void FindNodesByName_ReturnsEmptyForNoMatch()
    {
        // Arrange
        var parent = CreateTestNode("Parent");
        var child = CreateTestNode("Child");
        parent.AddChild(child);

        // Act
        var found = FindNodesByName(parent, "NonExistent");

        // Assert
        found.Count.ShouldBe(0);
    }
```

**Returns:** `void`

### FindNodesByName_FindsMultipleMatches

```csharp
[Test]
    public void FindNodesByName_FindsMultipleMatches()
    {
        // Arrange
        var parent = CreateTestNode("Parent");
        var match1 = CreateTestNode("Target");
        var match2 = CreateTestNode("Target");
        parent.AddChild(match1);
        parent.AddChild(match2);

        // Act
        var found = FindNodesByName(parent, "Target");

        // Assert
        found.Count.ShouldBe(2);
    }
```

**Returns:** `void`

### AddToGroup_AddsNodeToGroup

```csharp
#endregion

    #region Group Search Tests

    [Test]
    public void AddToGroup_AddsNodeToGroup()
    {
        // Arrange
        var node = CreateTestNode("GroupedNode");
        _testScene.AddChild(node);

        // Act
        node.AddToGroup(GroupA);

        // Assert
        node.IsInGroup(GroupA).ShouldBeTrue();
        node.IsInGroup(GroupB).ShouldBeFalse();
    }
```

**Returns:** `void`

### RemoveFromGroup_RemovesNodeFromGroup

```csharp
[Test]
    public void RemoveFromGroup_RemovesNodeFromGroup()
    {
        // Arrange
        var node = CreateTestNode("GroupedNode");
        _testScene.AddChild(node);
        node.AddToGroup(GroupA);

        // Act
        node.RemoveFromGroup(GroupA);

        // Assert
        node.IsInGroup(GroupA).ShouldBeFalse();
    }
```

**Returns:** `void`

### GetNodesInGroup_ReturnsAllGroupMembers

```csharp
[Test]
    public void GetNodesInGroup_ReturnsAllGroupMembers()
    {
        // Arrange
        var node1 = CreateTestNode("Node1");
        var node2 = CreateTestNode("Node2");
        var node3 = CreateTestNode("Node3");
        _testScene.AddChild(node1);
        _testScene.AddChild(node2);
        _testScene.AddChild(node3);
        node1.AddToGroup(GroupA);
        node2.AddToGroup(GroupA);
        // node3 not in group

        // Act
        var groupMembers = _testScene.GetTree().GetNodesInGroup(GroupA);

        // Assert
        groupMembers.Count.ShouldBeGreaterThanOrEqualTo(2);
        // Check our specific nodes are in the group
        var foundNode1 = false;
        var foundNode2 = false;
        foreach (var member in groupMembers)
        {
            if (member == node1) foundNode1 = true;
            if (member == node2) foundNode2 = true;
        }
        foundNode1.ShouldBeTrue("Node1 should be in group");
        foundNode2.ShouldBeTrue("Node2 should be in group");
    }
```

**Returns:** `void`

### SetMeta_StoresValue

```csharp
#endregion

    #region Metadata Tests

    [Test]
    public void SetMeta_StoresValue()
    {
        // Arrange
        var node = CreateTestNode("MetaNode");

        // Act
        node.SetMeta(CustomMetaKey, 42);

        // Assert
        node.HasMeta(CustomMetaKey).ShouldBeTrue();
        node.GetMeta(CustomMetaKey).AsInt32().ShouldBe(42);
    }
```

**Returns:** `void`

### GetMeta_ReturnsDefaultForMissingKey

```csharp
[Test]
    public void GetMeta_ReturnsDefaultForMissingKey()
    {
        // Arrange
        var node = CreateTestNode("MetaNode");

        // Act
        var value = node.GetMeta("nonexistent", "default");

        // Assert
        value.AsString().ShouldBe("default");
    }
```

**Returns:** `void`

### RemoveMeta_RemovesValue

```csharp
[Test]
    public void RemoveMeta_RemovesValue()
    {
        // Arrange
        var node = CreateTestNode("MetaNode");
        node.SetMeta(CustomMetaKey, "value");

        // Act
        node.RemoveMeta(CustomMetaKey);

        // Assert
        node.HasMeta(CustomMetaKey).ShouldBeFalse();
    }
```

**Returns:** `void`

### GetMetaList_ReturnsAllMetaKeys

```csharp
[Test]
    public void GetMetaList_ReturnsAllMetaKeys()
    {
        // Arrange
        var node = CreateTestNode("MetaNode");
        node.SetMeta("key1", 1);
        node.SetMeta("key2", 2);
        node.SetMeta("key3", 3);

        // Act
        var metaList = node.GetMetaList();

        // Assert
        metaList.Count.ShouldBeGreaterThanOrEqualTo(3);
    }
```

**Returns:** `void`

### Node2D_Position_IsSet

```csharp
#endregion

    #region Node2D Transform Tests

    [Test]
    public void Node2D_Position_IsSet()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        _testNodes.Add(node);

        // Act
        node.Position = new Vector2(100, 200);

        // Assert
        node.Position.ShouldBe(new Vector2(100, 200));
    }
```

**Returns:** `void`

### Node2D_GlobalPosition_ReflectsParentTransform

```csharp
[Test]
    public void Node2D_GlobalPosition_ReflectsParentTransform()
    {
        // Arrange
        var parent = new Node2D();
        var child = new Node2D();
        _testScene.AddChild(parent);
        parent.AddChild(child);
        _testNodes.Add(parent);

        parent.Position = new Vector2(50, 50);
        child.Position = new Vector2(25, 25);

        // Assert
        child.GlobalPosition.ShouldBe(new Vector2(75, 75));
    }
```

**Returns:** `void`

### Node2D_Rotation_IsSetInRadians

```csharp
[Test]
    public void Node2D_Rotation_IsSetInRadians()
    {
        // Arrange
        var node = new Node2D();
        _testScene.AddChild(node);
        _testNodes.Add(node);

        // Act
        node.Rotation = Mathf.Pi / 4; // 45 degrees

        // Assert
        node.Rotation.ShouldBe(Mathf.Pi / 4, 0.001f);
        node.RotationDegrees.ShouldBe(45f, 0.1f);
    }
```

**Returns:** `void`

### Node2D_Scale_AffectsChildren

```csharp
[Test]
    public void Node2D_Scale_AffectsChildren()
    {
        // Arrange
        var parent = new Node2D();
        var child = new Node2D();
        _testScene.AddChild(parent);
        parent.AddChild(child);
        _testNodes.Add(parent);

        parent.Scale = new Vector2(2, 2);
        child.Position = new Vector2(10, 10);

        // Assert: Child's global position is scaled
        child.GlobalPosition.ShouldBe(new Vector2(20, 20));
    }
```

**Returns:** `void`

