---
title: "PlaceableTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placeabletest/"
---

# PlaceableTest

```csharp
GridBuilding.Godot.Tests.Placement
class PlaceableTest
{
    // Members...
}
```

Unit tests for Placeable data structure.
Updated to use GoDotTest framework for proper test discovery.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/PlaceableTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "Placeable Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests placeable data structure functionality and validation";
```


## Methods

### Placeable_Constructor_WithNoParameters_ShouldCreateValidInstance

```csharp
#endregion

    #region Tests

    [Test]
    public void Placeable_Constructor_WithNoParameters_ShouldCreateValidInstance()
    {
        // When
        var placeable = new Placeable();

        // Then
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

### Placeable_Constructor_WithParameters_ShouldSetProperties

```csharp
[Test]
    public void Placeable_Constructor_WithParameters_ShouldSetProperties()
    {
        // Given
        var packedScene = new PackedScene();
        var rules = new Godot.Collections.Array<PlacementRule>
        {
            new PlacementRule()
        };

        // When
        var placeable = new Placeable(packedScene, rules);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### Placeable_GetLoadData_WithoutUid_ShouldReturnFilePathOnly

```csharp
[Test]
    public void Placeable_GetLoadData_WithoutUid_ShouldReturnFilePathOnly()
    {
        // Given
        var placeable = new Placeable();
        // Mock the resource path
        placeable.ResourcePath = "res://test/placeable.tres";

        // When
        var loadData = placeable.GetLoadData(false);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

### Placeable_GetLoadData_WithUid_ShouldReturnFilePathAndUid

```csharp
[Test]
    public void Placeable_GetLoadData_WithUid_ShouldReturnFilePathAndUid()
    {
        // Given
        var placeable = new Placeable();
        // Mock the resource path
        placeable.ResourcePath = "res://test/placeable.tres";

        // When
        var loadData = placeable.GetLoadData(true);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### Placeable_LoadResource_WithValidData_ShouldReturnPlaceable

```csharp
[Test]
    public void Placeable_LoadResource_WithValidData_ShouldReturnPlaceable()
    {
        // Given
        var loadData = new Godot.Collections.Dictionary<string, Variant>
        {
            [Placeable.Names.FILE_PATH] = "res://test/placeable.tres"
        };

        // When
        var placeable = Placeable.LoadResource(loadData);

        // Then
        // Note: This will return null unless the file actually exists
        // In a real test, you'd create a temporary resource file
        ; // Expected since file doesn't exist
    }
```

**Returns:** `void`

### Placeable_GetPackedRootName_WithNoScene_ShouldReturnNoScene

```csharp
[Test]
    public void Placeable_GetPackedRootName_WithNoScene_ShouldReturnNoScene()
    {
        // Given
        var placeable = new Placeable();

        // When
        var rootName = placeable.GetPackedRootName();

        // Then
        ;
    }
```

**Returns:** `void`

### Placeable_GetEditorIssues_WithNoScene_ShouldReportIssue

```csharp
[Test]
    public void Placeable_GetEditorIssues_WithNoScene_ShouldReportIssue()
    {
        // Given
        var placeable = new Placeable();

        // When
        var issues = placeable.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### Placeable_GetEditorIssues_WithValidScene_ShouldReturnEmpty

```csharp
[Test]
    public void Placeable_GetEditorIssues_WithValidScene_ShouldReturnEmpty()
    {
        // Given
        var placeable = new Placeable(new PackedScene(), new());

        // When
        var issues = placeable.GetEditorIssues();

        // Then
        ;
    }
```

**Returns:** `void`

### Placeable_GetEditorIssues_WithNullRule_ShouldReportIssue

```csharp
[Test]
    public void Placeable_GetEditorIssues_WithNullRule_ShouldReportIssue()
    {
        // Given
        var placeable = new Placeable();
        placeable.PackedScene = new PackedScene();
        placeable.PlacementRules.Add(null!);

        // When
        var issues = placeable.GetEditorIssues();

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### Placeable_GetRuntimeIssues_ShouldIncludeEditorIssues

```csharp
[Test]
    public void Placeable_GetRuntimeIssues_ShouldIncludeEditorIssues()
    {
        // Given
        var placeable = new Placeable();

        // When
        var runtimeIssues = placeable.GetRuntimeIssues();
        var editorIssues = placeable.GetEditorIssues();

        // Then
        ;
    }
```

**Returns:** `void`

### Placeable_ValidateProperty_ShouldNotThrow

```csharp
[Test]
    public void Placeable_ValidateProperty_ShouldNotThrow()
    {
        // Given
        var placeable = new Placeable();
        var property = new Godot.Collections.Dictionary<string, Variant>
        {
            ["name"] = "test_property"
        };

        // When/Then
        Assert.DoesNotThrow(() => placeable._ValidateProperty(property));
    }
```

**Returns:** `void`

### Placeable_Names_ShouldHaveCorrectConstants

```csharp
[Test]
    public void Placeable_Names_ShouldHaveCorrectConstants()
    {
        // When/Then
        ;
        ;
    }
```

**Returns:** `void`

