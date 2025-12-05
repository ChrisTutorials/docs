---
title: "NodeLocatorTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/nodelocatortest/"
---

# NodeLocatorTest

```csharp
GridBuilding.Godot.Tests.Placement
class NodeLocatorTest
{
    // Members...
}
```

Unit tests for NodeLocator.
Updated to use GoDotTest framework for proper test discovery.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/NodeLocatorTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "NodeLocator Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests node locator functionality";
```


## Methods

### SetUp

```csharp
[SetUp]
    public void SetUp()
    {
        _rootNode = new Node();
        _targetNode = new Node();
        _targetNode.Name = "Inventory";
        _rootNode.AddChild(_targetNode);
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
        _targetNode = null;
    }
```

**Returns:** `void`

### NodeLocator_Constructor_WithParameters_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void NodeLocator_Constructor_WithParameters_ShouldCreateValidInstance()
    {
        // Given
        var method = NodeLocator.SearchMethod.NodeName;
        var searchString = "Inventory";

        // When
        var locator = new NodeLocator(method, searchString);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### NodeLocator_Constructor_WithDefaults_ShouldCreateValidInstance

```csharp
[Test]
    public void NodeLocator_Constructor_WithDefaults_ShouldCreateValidInstance()
    {
        // When
        var locator = new NodeLocator();

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### NodeLocator_LocateContainer_WithNodeNameMethod_ShouldFindCorrectNode

```csharp
[Test]
    public void NodeLocator_LocateContainer_WithNodeNameMethod_ShouldFindCorrectNode()
    {
        // Given
        var locator = new NodeLocator(NodeLocator.SearchMethod.NodeName, "Inventory");

        // When
        var result = locator.LocateContainer(_rootNode!);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeLocator_LocateContainer_WithNonExistentNode_ShouldReturnNull

```csharp
[Test]
    public void NodeLocator_LocateContainer_WithNonExistentNode_ShouldReturnNull()
    {
        // Given
        var locator = new NodeLocator(NodeLocator.SearchMethod.NodeName, "NonExistent");

        // When
        var result = locator.LocateContainer(_rootNode!);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeLocator_LocateContainer_WithNullRoot_ShouldReturnNull

```csharp
[Test]
    public void NodeLocator_LocateContainer_WithNullRoot_ShouldReturnNull()
    {
        // Given
        var locator = new NodeLocator();

        // When
        var result = locator.LocateContainer(null!);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeLocator_LocateContainer_WithGroupMethod_ShouldFindCorrectNode

```csharp
[Test]
    public void NodeLocator_LocateContainer_WithGroupMethod_ShouldFindCorrectNode()
    {
        // Given
        _targetNode!.AddToGroup("inventory_group");
        var locator = new NodeLocator(NodeLocator.SearchMethod.IsInGroup, "inventory_group");

        // When
        var result = locator.LocateContainer(_rootNode!);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeLocator_LocateContainer_WithClassMethod_ShouldFindCorrectNode

```csharp
[Test]
    public void NodeLocator_LocateContainer_WithClassMethod_ShouldFindCorrectNode()
    {
        // Given
        var locator = new NodeLocator(NodeLocator.SearchMethod.ScriptNameWithExtension, "Node.gd");

        // When
        var result = locator.LocateContainer(_rootNode!);

        // Then
        ;
        // Note: This might not find anything since we don't have actual scripts attached
    }
```

**Returns:** `void`

### NodeLocator_GetScriptName_WithNode_ShouldReturnScriptName

```csharp
[Test]
    public void NodeLocator_GetScriptName_WithNode_ShouldReturnScriptName()
    {
        // Given
        var locator = new NodeLocator();

        // When
        var scriptName = locator.GetScriptName(_targetNode!);

        // Then
        // Should return either script filename or fallback name
        ;
    }
```

**Returns:** `void`

### NodeLocator_GetScriptName_WithNullNode_ShouldReturnEmpty

```csharp
[Test]
    public void NodeLocator_GetScriptName_WithNullNode_ShouldReturnEmpty()
    {
        // Given
        var locator = new NodeLocator();

        // When
        var scriptName = locator.GetScriptName(null!);

        // Then
        ;
    }
```

**Returns:** `void`

### NodeLocator_GetEditorIssues_WithUnsetSearchString_ShouldReportIssue

```csharp
[Test]
    public void NodeLocator_GetEditorIssues_WithUnsetSearchString_ShouldReportIssue()
    {
        // Given
        var locator = new NodeLocator();
        locator.SearchString = "<Set me>";

        // When
        var issues = locator.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeLocator_GetEditorIssues_WithEmptySearchString_ShouldReportIssue

```csharp
[Test]
    public void NodeLocator_GetEditorIssues_WithEmptySearchString_ShouldReportIssue()
    {
        // Given
        var locator = new NodeLocator();
        locator.SearchString = "";

        // When
        var issues = locator.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeLocator_GetEditorIssues_WithValidSearchString_ShouldReturnEmpty

```csharp
[Test]
    public void NodeLocator_GetEditorIssues_WithValidSearchString_ShouldReturnEmpty()
    {
        // Given
        var locator = new NodeLocator();
        locator.SearchString = "Inventory";

        // When
        var issues = locator.GetEditorIssues();

        // Then
        ;
    }
```

**Returns:** `void`

### NodeLocator_GetRuntimeIssues_ShouldIncludeEditorIssues

```csharp
[Test]
    public void NodeLocator_GetRuntimeIssues_ShouldIncludeEditorIssues()
    {
        // Given
        var locator = new NodeLocator();
        locator.SearchString = "";

        // When
        var runtimeIssues = locator.GetRuntimeIssues();
        var editorIssues = locator.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeLocator_Properties_ShouldBeSettable

```csharp
[Test]
    public void NodeLocator_Properties_ShouldBeSettable()
    {
        // Given
        var locator = new NodeLocator();
        var method = NodeLocator.SearchMethod.ScriptNameWithExtension;
        var searchString = "CustomInventory.gd";

        // When
        locator.Method = method;
        locator.SearchString = searchString;

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### NodeLocator_SearchMethod_Enum_ShouldHaveCorrectValues

```csharp
[Test]
    public void NodeLocator_SearchMethod_Enum_ShouldHaveCorrectValues()
    {
        // When/Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

