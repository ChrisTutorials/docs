---
title: "ResourceStackTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/resourcestacktest/"
---

# ResourceStackTest

```csharp
GridBuilding.Godot.Tests.Placement
class ResourceStackTest
{
    // Members...
}
```

Unit tests for ResourceStack.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/ResourceStackTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "ResourceStack Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests resource stack functionality";
```


## Methods

### ResourceStack_Constructor_WithParameters_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void ResourceStack_Constructor_WithParameters_ShouldCreateValidInstance()
    {
        // Given
        var resource = new Resource();
        var count = 5;

        // When
        var stack = new ResourceStack(resource, count);

        // Then
        ;
        ;
        ;

        // Cleanup
        resource.QueueFree();
    }
```

**Returns:** `void`

### ResourceStack_Constructor_WithDefaults_ShouldCreateValidInstance

```csharp
[Test]
    public void ResourceStack_Constructor_WithDefaults_ShouldCreateValidInstance()
    {
        // When
        var stack = new ResourceStack();

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### ResourceStack_GetEditorIssues_WithNullType_ShouldReportIssue

```csharp
[Test]
    public void ResourceStack_GetEditorIssues_WithNullType_ShouldReportIssue()
    {
        // Given
        var stack = new ResourceStack();
        stack.Type = null;

        // When
        var issues = stack.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### ResourceStack_GetEditorIssues_WithNegativeCount_ShouldReportIssue

```csharp
[Test]
    public void ResourceStack_GetEditorIssues_WithNegativeCount_ShouldReportIssue()
    {
        // Given
        var stack = new ResourceStack();
        stack.Type = new Resource();
        stack.Count = -5;

        // When
        var issues = stack.GetEditorIssues();

        // Then
        ;
        ;

        // Cleanup
        stack.Type.QueueFree();
    }
```

**Returns:** `void`

### ResourceStack_GetEditorIssues_WithValidData_ShouldReturnEmpty

```csharp
[Test]
    public void ResourceStack_GetEditorIssues_WithValidData_ShouldReturnEmpty()
    {
        // Given
        var stack = new ResourceStack();
        stack.Type = new Resource();
        stack.Count = 10;

        // When
        var issues = stack.GetEditorIssues();

        // Then
        ;

        // Cleanup
        stack.Type.QueueFree();
    }
```

**Returns:** `void`

### ResourceStack_GetRuntimeIssues_ShouldIncludeEditorIssues

```csharp
[Test]
    public void ResourceStack_GetRuntimeIssues_ShouldIncludeEditorIssues()
    {
        // Given
        var stack = new ResourceStack();
        stack.Type = null;

        // When
        var runtimeIssues = stack.GetRuntimeIssues();
        var editorIssues = stack.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### ResourceStack_Properties_ShouldBeSettable

```csharp
[Test]
    public void ResourceStack_Properties_ShouldBeSettable()
    {
        // Given
        var stack = new ResourceStack();
        var resource = new Resource();
        var count = 7;

        // When
        stack.Type = resource;
        stack.Count = count;

        // Then
        ;
        ;

        // Cleanup
        resource.QueueFree();
    }
```

**Returns:** `void`

### ResourceStack_Equality_ShouldWorkCorrectly

```csharp
[Test]
    public void ResourceStack_Equality_ShouldWorkCorrectly()
    {
        // Given
        var resource = new Resource();
        var stack1 = new ResourceStack(resource, 5);
        var stack2 = new ResourceStack(resource, 5);
        var stack3 = new ResourceStack(resource, 10);

        // When/Then
        ;
        ;
        ;
        ;

        // Cleanup
        resource.QueueFree();
    }
```

**Returns:** `void`

### ResourceStack_ZeroCount_ShouldBeValid

```csharp
[Test]
    public void ResourceStack_ZeroCount_ShouldBeValid()
    {
        // Given
        var resource = new Resource();
        var stack = new ResourceStack(resource, 0);

        // When
        var issues = stack.GetEditorIssues();

        // Then
        ;
        ;

        // Cleanup
        resource.QueueFree();
    }
```

**Returns:** `void`

