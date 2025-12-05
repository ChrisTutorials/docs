---
title: "TargetHighlighterTest"
description: "Unit tests for TargetHighlighter preview object detection
Tests metadata-based detection instead of script-based detection"
weight: 20
url: "/gridbuilding/v6-0/api/godot/targethighlightertest/"
---

# TargetHighlighterTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class TargetHighlighterTest
{
    // Members...
}
```

Unit tests for TargetHighlighter preview object detection
Tests metadata-based detection instead of script-based detection

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/TargetHighlighterTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### IsPreviewObject_DetectsMetadataOnTarget_ReturnsTrue

```csharp
/// <summary>
    /// Test: Target with gb_is_preview_build metadata should be detected as preview
    /// </summary>
    [Test]
    public void IsPreviewObject_DetectsMetadataOnTarget_ReturnsTrue()
    {
        var highlighter = new TargetHighlighter();
        TestScene.AddChild(highlighter);
        
        var target = new Node2D();
        TestScene.AddChild(target);
        target.SetMeta("gb_is_preview_build", true);

        // Act
        var result = highlighter.IsPreviewObject(target);

        // Assert
        result.ShouldBeTrue("Target with gb_is_preview_build metadata should be detected as preview");
        
        // Cleanup
        target.QueueFree();
        highlighter.QueueFree();
    }
```

Test: Target with gb_is_preview_build metadata should be detected as preview

**Returns:** `void`

### IsPreviewObject_DetectsMetadataOnChild_ReturnsTrue

```csharp
/// <summary>
    /// Test: Child with gb_is_preview_build metadata should mark parent as preview
    /// </summary>
    [Test]
    public void IsPreviewObject_DetectsMetadataOnChild_ReturnsTrue()
    {
        var highlighter = new TargetHighlighter();
        TestScene.AddChild(highlighter);
        
        var target = new Node2D();
        TestScene.AddChild(target);
        
        var child = new Node2D();
        target.AddChild(child);

        // Mark child as preview
        child.SetMeta("gb_is_preview_build", true);

        // Act
        var result = highlighter.IsPreviewObject(target);

        // Assert
        result.ShouldBeTrue("Target child with gb_is_preview_build should be detected as preview");
        
        // Cleanup
        target.QueueFree();
        highlighter.QueueFree();
    }
```

Test: Child with gb_is_preview_build metadata should mark parent as preview

**Returns:** `void`

### IsPreviewObject_NoMetadata_ReturnsFalse

```csharp
/// <summary>
    /// Test: Target without gb_is_preview_build metadata should not be detected as preview
    /// </summary>
    [Test]
    public void IsPreviewObject_NoMetadata_ReturnsFalse()
    {
        var highlighter = new TargetHighlighter();
        TestScene.AddChild(highlighter);
        
        var target = new Node2D();
        TestScene.AddChild(target);

        // Act
        var result = highlighter.IsPreviewObject(target);

        // Assert
        result.ShouldBeFalse("Target without gb_is_preview_build metadata should not be detected as preview");
        
        // Cleanup
        target.QueueFree();
        highlighter.QueueFree();
    }
```

Test: Target without gb_is_preview_build metadata should not be detected as preview

**Returns:** `void`

### IsPreviewObject_FalseMetadata_ReturnsFalse

```csharp
/// <summary>
    /// Test: Metadata set to false should not be detected as preview
    /// </summary>
    [Test]
    public void IsPreviewObject_FalseMetadata_ReturnsFalse()
    {
        var highlighter = new TargetHighlighter();
        TestScene.AddChild(highlighter);
        
        var target = new Node2D();
        TestScene.AddChild(target);
        target.SetMeta("gb_is_preview_build", false);

        // Act
        var result = highlighter.IsPreviewObject(target);

        // Assert
        result.ShouldBeFalse("Target with gb_is_preview_build=false should not be detected as preview");
        
        // Cleanup
        target.QueueFree();
        highlighter.QueueFree();
    }
```

Test: Metadata set to false should not be detected as preview

**Returns:** `void`

### IsPreviewObject_NullTarget_ReturnsFalse

```csharp
/// <summary>
    /// Test: Null target should return false safely
    /// </summary>
    [Test]
    public void IsPreviewObject_NullTarget_ReturnsFalse()
    {
        var highlighter = new TargetHighlighter();
        TestScene.AddChild(highlighter);

        // Act
        var result = highlighter.IsPreviewObject(null);

        // Assert
        result.ShouldBeFalse("Null target should safely return false");
        
        // Cleanup
        highlighter.QueueFree();
    }
```

Test: Null target should return false safely

**Returns:** `void`

### IsPreviewObject_DetectsMultipleChildren_ReturnsTrue

```csharp
/// <summary>
    /// Test: Target should be detected as preview when any child has metadata
    /// </summary>
    [Test]
    public void IsPreviewObject_DetectsMultipleChildren_ReturnsTrue()
    {
        var highlighter = new TargetHighlighter();
        TestScene.AddChild(highlighter);
        
        var target = new Node2D();
        TestScene.AddChild(target);

        var child1 = new Node2D();
        target.AddChild(child1);

        var child2 = new Node2D();
        target.AddChild(child2);

        // Mark only the second child
        child2.SetMeta("gb_is_preview_build", true);

        // Act
        var result = highlighter.IsPreviewObject(target);

        // Assert
        result.ShouldBeTrue("Target should detect preview metadata on any child");
        
        // Cleanup
        target.QueueFree();
        highlighter.QueueFree();
    }
```

Test: Target should be detected as preview when any child has metadata

**Returns:** `void`

### IsPreviewObject_IgnoresOtherMetadata_ReturnsFalse

```csharp
/// <summary>
    /// Test: Other metadata should not interfere with detection
    /// </summary>
    [Test]
    public void IsPreviewObject_IgnoresOtherMetadata_ReturnsFalse()
    {
        var highlighter = new TargetHighlighter();
        TestScene.AddChild(highlighter);
        
        var target = new Node2D();
        TestScene.AddChild(target);
        target.SetMeta("gb_preview", true); // Different metadata
        target.SetMeta("custom_data", "value");

        // Act
        var result = highlighter.IsPreviewObject(target);

        // Assert
        result.ShouldBeFalse("Other metadata should not affect preview detection");
        
        // Cleanup
        target.QueueFree();
        highlighter.QueueFree();
    }
```

Test: Other metadata should not interfere with detection

**Returns:** `void`

### IsPreviewObject_TrueAndFalseChildren_ReturnsTrue

```csharp
/// <summary>
    /// Test: Should detect preview if any child has metadata=true
    /// </summary>
    [Test]
    public void IsPreviewObject_TrueAndFalseChildren_ReturnsTrue()
    {
        var highlighter = new TargetHighlighter();
        TestScene.AddChild(highlighter);
        
        var target = new Node2D();
        TestScene.AddChild(target);

        var childFalse = new Node2D();
        target.AddChild(childFalse);
        childFalse.SetMeta("gb_is_preview_build", false);

        var childTrue = new Node2D();
        target.AddChild(childTrue);
        childTrue.SetMeta("gb_is_preview_build", true);

        // Act
        var result = highlighter.IsPreviewObject(target);

        // Assert
        result.ShouldBeTrue("Should detect preview=true on any child, even if other children have preview=false");
        
        // Cleanup
        target.QueueFree();
        highlighter.QueueFree();
    }
```

Test: Should detect preview if any child has metadata=true

**Returns:** `void`

