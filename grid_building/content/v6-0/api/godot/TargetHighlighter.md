---
title: "TargetHighlighter"
description: "Mock implementation of TargetHighlighter for testing"
weight: 20
url: "/gridbuilding/v6-0/api/godot/targethighlighter/"
---

# TargetHighlighter

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class TargetHighlighter
{
    // Members...
}
```

Mock implementation of TargetHighlighter for testing

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/TargetHighlighterTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### IsPreviewObject

```csharp
/// <summary>
    /// Checks if the target is a preview object based on metadata
    /// </summary>
    public bool IsPreviewObject(Node2D? target)
    {
        if (target == null)
            return false;

        // Check if the target itself has the preview metadata
        if (HasPreviewMetadata(target))
            return true;

        // Check all children recursively for preview metadata
        return CheckChildrenForPreviewMetadata(target);
    }
```

Checks if the target is a preview object based on metadata

**Returns:** `bool`

**Parameters:**
- `Node2D? target`

