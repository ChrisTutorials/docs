---
title: "NodeSearchLogicTest"
description: "Unit tests for NodeSearchLogic."
weight: 20
url: "/gridbuilding/v6-0/api/godot/nodesearchlogictest/"
---

# NodeSearchLogicTest

```csharp
GridBuilding.Godot.Tests.Shared
class NodeSearchLogicTest
{
    // Members...
}
```

Unit tests for NodeSearchLogic.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/NodeSearchLogicTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Shared`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "NodeSearchLogic Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests node search logic functionality";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _rootNode = new Node();
        _targetNode1 = new Node();
        _targetNode2 = new Node();
        _groupNode = new Node();
        
        _targetNode1.Name = "Target1";
        _targetNode2.Name = "Target2";
        _groupNode.Name = "GroupTarget";
        
        _groupNode.AddToGroup("test_group");
        
        _rootNode.AddChild(_targetNode1);
        _rootNode.AddChild(_targetNode2);
        _rootNode.AddChild(_groupNode);
    }
```

**Returns:** `void`

### TearDown

```csharp
[TearDown]
    public void TearDown()
    {
        _rootNode?.QueueFree();
        _rootNode = null;
        _targetNode1 = null;
        _targetNode2 = null;
        _groupNode = null;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByName_WithMatchingNodes_ShouldReturnCorrectNodes

```csharp
#endregion

    #region Tests

    [Test]
    public void NodeSearchLogic_FindNodesByName_WithMatchingNodes_ShouldReturnCorrectNodes()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2!, _groupNode! };
        var searchName = "Target1";

        // When
        var results = NodeSearchLogic.FindNodesByName(nodes, searchName);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByName_WithNoMatchingNodes_ShouldReturnEmpty

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByName_WithNoMatchingNodes_ShouldReturnEmpty()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2!, _groupNode! };
        var searchName = "NonExistent";

        // When
        var results = NodeSearchLogic.FindNodesByName(nodes, searchName);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByName_WithNullNodes_ShouldSkipNulls

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByName_WithNullNodes_ShouldSkipNulls()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, null!, _targetNode2! };
        var searchName = "Target1";

        // When
        var results = NodeSearchLogic.FindNodesByName(nodes, searchName);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByScript_WithEmptyScriptName_ShouldReturnEmpty

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByScript_WithEmptyScriptName_ShouldReturnEmpty()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2! };

        // When
        var results = NodeSearchLogic.FindNodesByScript(nodes, "");

        // Then
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByScript_WithNullScriptName_ShouldReturnEmpty

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByScript_WithNullScriptName_ShouldReturnEmpty()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2! };

        // When
        var results = NodeSearchLogic.FindNodesByScript(nodes, null!);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByGroup_WithMatchingNodes_ShouldReturnCorrectNodes

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByGroup_WithMatchingNodes_ShouldReturnCorrectNodes()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2!, _groupNode! };
        var groupName = "test_group";

        // When
        var results = NodeSearchLogic.FindNodesByGroup(nodes, groupName);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByGroup_WithNoMatchingNodes_ShouldReturnEmpty

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByGroup_WithNoMatchingNodes_ShouldReturnEmpty()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2! };
        var groupName = "non_existent_group";

        // When
        var results = NodeSearchLogic.FindNodesByGroup(nodes, groupName);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByClass_WithMatchingNodes_ShouldReturnCorrectNodes

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByClass_WithMatchingNodes_ShouldReturnCorrectNodes()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2!, _groupNode! };
        var className = "Node";

        // When
        var results = NodeSearchLogic.FindNodesByClass(nodes, className);

        // Then
        ; // All nodes are of class "Node"
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByClass_WithNoMatchingNodes_ShouldReturnEmpty

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByClass_WithNoMatchingNodes_ShouldReturnEmpty()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2! };
        var className = "NonExistentClass";

        // When
        var results = NodeSearchLogic.FindNodesByClass(nodes, className);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByProperty_WithMatchingNodes_ShouldReturnCorrectNodes

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByProperty_WithMatchingNodes_ShouldReturnCorrectNodes()
    {
        // Given
        _targetNode1!.Set("test_property", "test_value");
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2! };
        var propertyName = "test_property";
        var propertyValue = new Variant("test_value");

        // When
        var results = NodeSearchLogic.FindNodesByProperty(nodes, propertyName, propertyValue);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByProperty_WithNoMatchingNodes_ShouldReturnEmpty

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByProperty_WithNoMatchingNodes_ShouldReturnEmpty()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2! };
        var propertyName = "non_existent_property";
        var propertyValue = new Variant("test_value");

        // When
        var results = NodeSearchLogic.FindNodesByProperty(nodes, propertyName, propertyValue);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByMethodResult_WithMatchingNodes_ShouldReturnCorrectNodes

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByMethodResult_WithMatchingNodes_ShouldReturnCorrectNodes()
    {
        // Given
        // This test is limited since we can't easily add custom methods to Node
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2! };
        var methodName = "get_name"; // Built-in method
        var expectedResult = new Variant("Target1");

        // When
        var results = NodeSearchLogic.FindNodesByMethodResult(nodes, methodName, expectedResult);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FindNodesByMethodResult_WithNoMatchingNodes_ShouldReturnEmpty

```csharp
[Test]
    public void NodeSearchLogic_FindNodesByMethodResult_WithNoMatchingNodes_ShouldReturnEmpty()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2! };
        var methodName = "get_name";
        var expectedResult = new Variant("NonExistent");

        // When
        var results = NodeSearchLogic.FindNodesByMethodResult(nodes, methodName, expectedResult);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_CombineSearchResults_WithDuplicateNodes_ShouldReturnUnique

```csharp
[Test]
    public void NodeSearchLogic_CombineSearchResults_WithDuplicateNodes_ShouldReturnUnique()
    {
        // Given
        var results1 = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2! };
        var results2 = new Godot.Collections.Array<Node> { _targetNode1!, _groupNode! }; // _targetNode1 is duplicate
        var searchResults = new Godot.Collections.Array<Godot.Collections.Array<Node>> { results1, results2 };

        // When
        var combined = NodeSearchLogic.CombineSearchResults(searchResults);

        // Then
        ; // Should be unique: target1, target2, groupNode
        ;
        ;
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_FilterSearchResults_WithFilterFunc_ShouldReturnFiltered

```csharp
[Test]
    public void NodeSearchLogic_FilterSearchResults_WithFilterFunc_ShouldReturnFiltered()
    {
        // Given
        var nodes = new Godot.Collections.Array<Node> { _targetNode1!, _targetNode2!, _groupNode! };
        System.Func<Node, bool> filterFunc = (node) => node.Name.StartsWith("Target");

        // When
        var filtered = NodeSearchLogic.FilterSearchResults(nodes, filterFunc);

        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_SortSearchResults_ShouldSortByName

```csharp
[Test]
    public void NodeSearchLogic_SortSearchResults_ShouldSortByName()
    {
        // Given
        var nodeA = new Node(); nodeA.Name = "Z";
        var nodeB = new Node(); nodeB.Name = "A";
        var nodeC = new Node(); nodeC.Name = "M";
        var nodes = new Godot.Collections.Array<Node> { nodeA, nodeB, nodeC };

        // When
        var sorted = NodeSearchLogic.SortSearchResults(nodes);

        // Then
        ;
        ;
        ;
        ;

        // Cleanup
        nodeA.QueueFree();
        nodeB.QueueFree();
        nodeC.QueueFree();
    }
```

**Returns:** `void`

### NodeSearchLogic_GetScriptName_WithNode_ShouldReturnName

```csharp
[Test]
    public void NodeSearchLogic_GetScriptName_WithNode_ShouldReturnName()
    {
        // Given
        var node = new Node();
        node.Name = "TestNode";

        // When
        var scriptName = NodeSearchLogic.GetScriptName(node);

        // Then
        // Should return fallback name since no script is attached
        ;

        // Cleanup
        node.QueueFree();
    }
```

**Returns:** `void`

### NodeSearchLogic_GetScriptName_WithNullNode_ShouldReturnEmpty

```csharp
[Test]
    public void NodeSearchLogic_GetScriptName_WithNullNode_ShouldReturnEmpty()
    {
        // When
        var scriptName = NodeSearchLogic.GetScriptName(null!);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_ValidateSearchParams_WithValidParams_ShouldReturnEmpty

```csharp
[Test]
    public void NodeSearchLogic_ValidateSearchParams_WithValidParams_ShouldReturnEmpty()
    {
        // Given
        var searchMethod = 0;
        var searchString = "valid_search";

        // When
        var issues = NodeSearchLogic.ValidateSearchParams(searchMethod, searchString);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_ValidateSearchParams_WithEmptyString_ShouldReturnIssue

```csharp
[Test]
    public void NodeSearchLogic_ValidateSearchParams_WithEmptyString_ShouldReturnIssue()
    {
        // Given
        var searchMethod = 0;
        var searchString = "";

        // When
        var issues = NodeSearchLogic.ValidateSearchParams(searchMethod, searchString);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_ValidateSearchParams_WithNegativeMethod_ShouldReturnIssue

```csharp
[Test]
    public void NodeSearchLogic_ValidateSearchParams_WithNegativeMethod_ShouldReturnIssue()
    {
        // Given
        var searchMethod = -1;
        var searchString = "valid_search";

        // When
        var issues = NodeSearchLogic.ValidateSearchParams(searchMethod, searchString);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeSearchLogic_ValidateSearchParams_WithMultipleIssues_ShouldReturnAllIssues

```csharp
[Test]
    public void NodeSearchLogic_ValidateSearchParams_WithMultipleIssues_ShouldReturnAllIssues()
    {
        // Given
        var searchMethod = -1;
        var searchString = "";

        // When
        var issues = NodeSearchLogic.ValidateSearchParams(searchMethod, searchString);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

