---
title: "CompositionContainerDefinitionTests"
description: "Unit tests for CompositionContainerDefinition Godot Resource wrapper.
Tests the Godot integration layer without requiring Godot runtime."
weight: 20
url: "/gridbuilding/v6-0/api/godot/compositioncontainerdefinitiontests/"
---

# CompositionContainerDefinitionTests

```csharp
GridBuilding.Godot.Tests.Resources
class CompositionContainerDefinitionTests
{
    // Members...
}
```

Unit tests for CompositionContainerDefinition Godot Resource wrapper.
Tests the Godot integration layer without requiring Godot runtime.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Resources/CompositionContainerDefinitionTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Resources`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Container_ShouldCreateContainerOnFirstAccess

```csharp
#endregion

    #region Container Access Tests

    [Fact]
    public void Container_ShouldCreateContainerOnFirstAccess()
    {
        // Act
        var container = _definition.Container;

        // Assert
        ;
        Assert.IsType<CompositionContainer>(container);
    }
```

**Returns:** `void`

### Container_ShouldReturnSameInstance

```csharp
[Fact]
    public void Container_ShouldReturnSameInstance()
    {
        // Act
        var container1 = _definition.Container;
        var container2 = _definition.Container;

        // Assert
        ;
    }
```

**Returns:** `void`

### Container_ShouldBeInitialized

```csharp
[Fact]
    public void Container_ShouldBeInitialized()
    {
        // Act
        var container = _definition.Container;

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### ConfigurationPath_ShouldBeSettable

```csharp
#endregion

    #region Editor Properties Tests

    [Fact]
    public void ConfigurationPath_ShouldBeSettable()
    {
        // Arrange
        var expectedPath = "res://test_config.tres";

        // Act
        _definition.ConfigurationPath = expectedPath;

        // Assert
        ;
    }
```

**Returns:** `void`

### EnablePerformanceProfiling_ShouldBeSettable

```csharp
[Fact]
    public void EnablePerformanceProfiling_ShouldBeSettable()
    {
        // Arrange
        var expectedValue = false;

        // Act
        _definition.EnablePerformanceProfiling = expectedValue;

        // Assert
        ;
    }
```

**Returns:** `void`

### LogLevel_ShouldBeSettable

```csharp
[Fact]
    public void LogLevel_ShouldBeSettable()
    {
        // Arrange
        var expectedLevel = LogLevel.Error;

        // Act
        _definition.LogLevel = expectedLevel;

        // Assert
        ;
    }
```

**Returns:** `void`

### MaxPlayers_ShouldBeSettable

```csharp
[Fact]
    public void MaxPlayers_ShouldBeSettable()
    {
        // Arrange
        var expectedValue = 8;

        // Act
        _definition.MaxPlayers = expectedValue;

        // Assert
        ;
    }
```

**Returns:** `void`

### GridSize_ShouldBeSettable

```csharp
[Fact]
    public void GridSize_ShouldBeSettable()
    {
        // Arrange
        var expectedSize = new Vector2I(2, 2);

        // Act
        _definition.GridSize = expectedSize;

        // Assert
        ;
    }
```

**Returns:** `void`

### CustomProperties_ShouldBeSettable

```csharp
[Fact]
    public void CustomProperties_ShouldBeSettable()
    {
        // Arrange
        var expectedProperties = new Godot.Collections.Dictionary<string, Variant>
        {
            ["test_key"] = "test_value",
            ["number_key"] = 42
        };

        // Act
        _definition.CustomProperties = expectedProperties;

        // Assert
        ;
    }
```

**Returns:** `void`

### ValidateForEditor_ShouldReturnValidResult

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void ValidateForEditor_ShouldReturnValidResult()
    {
        // Act
        var result = _definition.ValidateForEditor();

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### GetEditorIssues_ShouldReturnEmptyArrayForValidDefinition

```csharp
[Fact]
    public void GetEditorIssues_ShouldReturnEmptyArrayForValidDefinition()
    {
        // Act
        var issues = _definition.GetEditorIssues();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### GetRuntimeIssues_ShouldReturnEmptyArrayForValidDefinition

```csharp
[Fact]
    public void GetRuntimeIssues_ShouldReturnEmptyArrayForValidDefinition()
    {
        // Act
        var issues = _definition.GetRuntimeIssues();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### GetEditorIssues_ShouldDetectInvalidMaxPlayers

```csharp
[Fact]
    public void GetEditorIssues_ShouldDetectInvalidMaxPlayers()
    {
        // Arrange
        _definition.MaxPlayers = -1;

        // Act
        var issues = _definition.GetEditorIssues();

        // Assert
        ;
    }
```

**Returns:** `void`

### GetEditorIssues_ShouldDetectInvalidGridSize

```csharp
[Fact]
    public void GetEditorIssues_ShouldDetectInvalidGridSize()
    {
        // Arrange
        _definition.GridSize = new Vector2I(0, 0);

        // Act
        var issues = _definition.GetEditorIssues();

        // Assert
        ;
    }
```

**Returns:** `void`

### EditorSettings_ShouldBeAppliedToContainer

```csharp
#endregion

    #region Configuration Application Tests

    [Fact]
    public void EditorSettings_ShouldBeAppliedToContainer()
    {
        // Arrange
        _definition.EnablePerformanceProfiling = false;
        _definition.LogLevel = LogLevel.Error;
        _definition.MaxPlayers = 6;
        _definition.GridSize = new Vector2I(3, 3);

        // Act - Access container to trigger initialization
        var container = _definition.Container;

        // Assert
        var config = container.GetCurrentConfiguration();
        ;
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### LoadConfigurationFromFile_ShouldHandleEmptyPath

```csharp
#endregion

    #region File Operations Tests

    [Fact]
    public void LoadConfigurationFromFile_ShouldHandleEmptyPath()
    {
        // Arrange
        _definition.ConfigurationPath = "";

        // Act & Assert - Should not throw
        _definition.LoadConfigurationFromFile();
    }
```

**Returns:** `void`

### SaveConfigurationToFile_ShouldHandleNullContainer

```csharp
[Fact]
    public void SaveConfigurationToFile_ShouldHandleNullContainer()
    {
        // Arrange
        var definition = new CompositionContainerDefinition();
        // Don't access Container property so it remains null

        // Act & Assert - Should not throw
        definition.SaveConfigurationToFile("res://test_save.tres");
    }
```

**Returns:** `void`

### GetDebugIdentifier_ShouldReturnValidString

```csharp
#endregion

    #region Debug and Utility Tests

    [Fact]
    public void GetDebugIdentifier_ShouldReturnValidString()
    {
        // Act
        var identifier = _definition.GetDebugIdentifier();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### _Validate_ShouldNotThrow

```csharp
[Fact]
    public void _Validate_ShouldNotThrow()
    {
        // Act & Assert - Should not throw
        _definition._Validate();
    }
```

**Returns:** `void`

### _ExitTree_ShouldNotThrow

```csharp
[Fact]
    public void _ExitTree_ShouldNotThrow()
    {
        // Act & Assert - Should not throw
        _definition._ExitTree();
    }
```

**Returns:** `void`

### _ExitTree_ShouldDisposeContainer

```csharp
#endregion

    #region Cleanup Tests

    [Fact]
    public void _ExitTree_ShouldDisposeContainer()
    {
        // Arrange
        var container = _definition.Container;
        ;

        // Act
        _definition._ExitTree();

        // Assert
        ;
    }
```

**Returns:** `void`

### ShouldBeGodotResource

```csharp
#endregion

    #region Resource Tests

    [Fact]
    public void ShouldBeGodotResource()
    {
        // Assert
        ;
    }
```

**Returns:** `void`

### ShouldHaveDefaultProperties

```csharp
[Fact]
    public void ShouldHaveDefaultProperties()
    {
        // Assert
        ;
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

