---
title: "TargetHighlighterIntegrationTests"
description: "GoDotTest integration tests for TargetHighlighter preview object detection.
Ported from: shared/components/unit/target_highlighter_unit_test.gd
Tests metadata-based detection for identifying preview objects in the scene tree.
Uses actual Godot Node2D instances to validate metadata handling."
weight: 20
url: "/gridbuilding/v6-0/api/godot/targethighlighterintegrationtests/"
---

# TargetHighlighterIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class TargetHighlighterIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for TargetHighlighter preview object detection.
Ported from: shared/components/unit/target_highlighter_unit_test.gd
Tests metadata-based detection for identifying preview objects in the scene tree.
Uses actual Godot Node2D instances to validate metadata handling.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/TargetHighlighterIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up TargetHighlighter Integration Tests");
    }
```

**Returns:** `void`

### IsPreviewObject_DetectsMetadataOnTarget

```csharp
#region Preview Object Detection Tests

    [Test]
    public void IsPreviewObject_DetectsMetadataOnTarget()
    {
        // Arrange: Target with gb_is_preview_build metadata
        var target = new Node2D();
        _testScene.AddChild(target);
        target.SetMeta(PREVIEW_META_KEY, true);

        // Act
        var result = IsPreviewObject(target);

        // Assert
        result.ShouldBeTrue("Target with gb_is_preview_build metadata should be detected as preview");

        // Cleanup
        target.QueueFree();
    }
```

**Returns:** `void`

### IsPreviewObject_DetectsMetadataOnChild

```csharp
[Test]
    public void IsPreviewObject_DetectsMetadataOnChild()
    {
        // Arrange: Child with gb_is_preview_build metadata
        var target = new Node2D();
        var child = new Node2D();
        _testScene.AddChild(target);
        target.AddChild(child);
        child.SetMeta(PREVIEW_META_KEY, true);

        // Act
        var result = IsPreviewObject(target);

        // Assert
        result.ShouldBeTrue("Target child with gb_is_preview_build should be detected as preview");

        // Cleanup
        target.QueueFree();
    }
```

**Returns:** `void`

### IsPreviewObject_ReturnsFalseWithoutMetadata

```csharp
[Test]
    public void IsPreviewObject_ReturnsFalseWithoutMetadata()
    {
        // Arrange: Target without gb_is_preview_build metadata
        var target = new Node2D();
        _testScene.AddChild(target);

        // Act
        var result = IsPreviewObject(target);

        // Assert
        result.ShouldBeFalse("Target without gb_is_preview_build metadata should not be detected as preview");

        // Cleanup
        target.QueueFree();
    }
```

**Returns:** `void`

### IsPreviewObject_ReturnsFalseForFalseMetadata

```csharp
[Test]
    public void IsPreviewObject_ReturnsFalseForFalseMetadata()
    {
        // Arrange: Metadata set to false
        var target = new Node2D();
        _testScene.AddChild(target);
        target.SetMeta(PREVIEW_META_KEY, false);

        // Act
        var result = IsPreviewObject(target);

        // Assert
        result.ShouldBeFalse("Target with gb_is_preview_build=false should not be detected as preview");

        // Cleanup
        target.QueueFree();
    }
```

**Returns:** `void`

### IsPreviewObject_ReturnsFalseForNullTarget

```csharp
[Test]
    public void IsPreviewObject_ReturnsFalseForNullTarget()
    {
        // Act
        var result = IsPreviewObject(null);

        // Assert
        result.ShouldBeFalse("Null target should safely return false");
    }
```

**Returns:** `void`

### IsPreviewObject_DetectsMultipleChildren

```csharp
[Test]
    public void IsPreviewObject_DetectsMultipleChildren()
    {
        // Arrange: Multiple children, only second has metadata
        var target = new Node2D();
        var child1 = new Node2D();
        var child2 = new Node2D();
        _testScene.AddChild(target);
        target.AddChild(child1);
        target.AddChild(child2);
        child2.SetMeta(PREVIEW_META_KEY, true);

        // Act
        var result = IsPreviewObject(target);

        // Assert
        result.ShouldBeTrue("Target should detect preview metadata on any child");

        // Cleanup
        target.QueueFree();
    }
```

**Returns:** `void`

### IsPreviewObject_DetectsNestedChild

```csharp
[Test]
    public void IsPreviewObject_DetectsNestedChild()
    {
        // Arrange: Deeply nested child with metadata
        var target = new Node2D();
        var child = new Node2D();
        var grandchild = new Node2D();
        _testScene.AddChild(target);
        target.AddChild(child);
        child.AddChild(grandchild);
        grandchild.SetMeta(PREVIEW_META_KEY, true);

        // Act
        var result = IsPreviewObject(target);

        // Assert
        result.ShouldBeTrue("Target should detect preview metadata on nested children");

        // Cleanup
        target.QueueFree();
    }
```

**Returns:** `void`

### IsPreviewObject_InvalidMetadataType_ReturnsFalse

```csharp
[Test]
    public void IsPreviewObject_InvalidMetadataType_ReturnsFalse()
    {
        // Arrange: Metadata set to non-boolean value
        var target = new Node2D();
        _testScene.AddChild(target);
        target.SetMeta(PREVIEW_META_KEY, "true"); // String instead of bool

        // Act
        var result = IsPreviewObject(target);

        // Assert: Should return false for non-boolean metadata
        result.ShouldBeFalse("Non-boolean metadata should not be detected as preview");

        // Cleanup
        target.QueueFree();
    }
```

**Returns:** `void`

