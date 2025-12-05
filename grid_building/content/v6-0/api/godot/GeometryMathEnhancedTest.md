---
title: "GeometryMathEnhancedTest"
description: "Unit tests for enhanced GDScript geometry math utilities
Tests the fixes made to resolve class name conflicts and type safety issues"
weight: 20
url: "/gridbuilding/v6-0/api/godot/geometrymathenhancedtest/"
---

# GeometryMathEnhancedTest

```csharp
GridBuilding.Godot.Tests.Geometry
class GeometryMathEnhancedTest
{
    // Members...
}
```

Unit tests for enhanced GDScript geometry math utilities
Tests the fixes made to resolve class name conflicts and type safety issues

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Geometry/GeometryMathEnhancedTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Vector2TypeSafeEnhancedCS_ShouldWork

```csharp
[Fact]
    public void Vector2TypeSafeEnhancedCS_ShouldWork()
    {
        // Test the enhanced type-safe Vector2 wrapper
        var vector = new Vector2TypeSafeEnhancedCS(1.0f, 2.0f);
        
        ;
        ;
        
        // Test static constructors
        var zero = Vector2TypeSafeEnhancedCS.Zero();
        ;
        ;
        
        var one = Vector2TypeSafeEnhancedCS.One();
        ;
        ;
        
        // Test operations
        var v1 = new Vector2TypeSafeEnhancedCS(1.0f, 2.0f);
        var v2 = new Vector2TypeSafeEnhancedCS(3.0f, 4.0f);
        var sum = v1.Add(v2);
        
        ;
        ;
        
        // Test equality with tolerance
        ;
        ;
        ;
    }
```

**Returns:** `void`

### Rect2TypeSafeEnhancedCS_ShouldWork

```csharp
[Fact]
    public void Rect2TypeSafeEnhancedCS_ShouldWork()
    {
        // Test the enhanced type-safe Rect2 wrapper
        var position = new Vector2TypeSafeEnhancedCS(10.0f, 20.0f);
        var size = new Vector2TypeSafeEnhancedCS(100.0f, 200.0f);
        var rect = new Rect2TypeSafeEnhancedCS(position, size);
        
        ;
        ;
        ;
        
        // Test area calculation
        ;
        
        // Test invalid rect
        var invalidSize = new Vector2TypeSafeEnhancedCS(-1.0f, 200.0f);
        var invalidRect = new Rect2TypeSafeEnhancedCS(position, invalidSize);
        ;
    }
```

**Returns:** `void`

### GBGeometryMathEnhancedCS_ShouldWork

```csharp
[Fact]
    public void GBGeometryMathEnhancedCS_ShouldWork()
    {
        // Test the enhanced geometry math functions
        var tilePos = new Vector2TypeSafeEnhancedCS(0.0f, 0.0f);
        var tileSize = new Vector2TypeSafeEnhancedCS(32.0f, 32.0f);
        
        // Test tile polygon generation (square)
        var polygon = GBGeometryMathEnhancedCS.GetTilePolygon(tilePos, tileSize, TileShape.Square);
        ;
        ;
        
        // Test polygon bounds calculation
        var bounds = GBGeometryMathEnhancedCS.GetPolygonBounds(polygon);
        ;
        ;
        
        // Test point in polygon
        var point = new Vector2TypeSafeEnhancedCS(16.0f, 16.0f); // Center of tile
        ;
        
        var outsidePoint = new Vector2TypeSafeEnhancedCS(100.0f, 100.0f);
        ;
        
        // Test distance to polygon
        var distance = GBGeometryMathEnhancedCS.GetDistanceToPolygon(outsidePoint, polygon);
        ;
    }
```

**Returns:** `void`

### EnhancedClasses_ShouldNotConflictWithOriginals

```csharp
[Fact]
    public void EnhancedClasses_ShouldNotConflictWithOriginals()
    {
        // Test that the CS suffix resolves class name conflicts
        var enhancedVector = new Vector2TypeSafeEnhancedCS(1.0f, 2.0f);
        var enhancedRect = new Rect2TypeSafeEnhancedCS(enhancedVector, new Vector2TypeSafeEnhancedCS(10.0f, 10.0f));
        
        // These should work without conflicts (the main issue we were solving)
        ;
        ;
        ;
    }
```

**Returns:** `void`

