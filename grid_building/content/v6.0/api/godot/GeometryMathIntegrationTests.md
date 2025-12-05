---
title: "GeometryMathIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/geometrymathintegrationtests/"
---

# GeometryMathIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class GeometryMathIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for geometry math utilities
These will be backported to GDUnit GDScript tests

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ManipulationIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### TestVector2TypeSafeOperations

```csharp
[Test]
    public void TestVector2TypeSafeOperations()
    {
        // Arrange: Create test vectors
        var vec1 = new Vector2(10.0f, 20.0f);
        var vec2 = new Vector2(5.0f, 15.0f);
        
        // Act: Perform operations
        var sum = vec1 + vec2;
        var difference = vec1 - vec2;
        var scaled = vec1 * 2.0f;
        
        // Assert: Results should be correct
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestRect2TypeSafeOperations

```csharp
[Test]
    public void TestRect2TypeSafeOperations()
    {
        // Arrange: Create test rectangles
        var rect1 = new Rect2(new Vector2(0, 0), new Vector2(100, 100));
        var rect2 = new Rect2(new Vector2(50, 50), new Vector2(100, 100));
        
        // Act: Test operations
        var intersects = rect1.Intersects(rect2);
        var intersection = rect1.Intersection(rect2);
        var union = rect1.Merge(rect2);
        
        // Assert: Results should be correct
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestTilePolygonGeneration

```csharp
[Test]
    public void TestTilePolygonGeneration()
    {
        // Arrange: Test tile parameters
        var tilePos = new Vector2(0, 0);
        var tileSize = new Vector2(32, 32);
        
        // Act: Generate square tile polygon
        var polygon = new Vector2[]
        {
            tilePos,
            tilePos + new Vector2(tileSize.X, 0),
            tilePos + tileSize,
            tilePos + new Vector2(0, tileSize.Y)
        };
        
        // Assert: Polygon should have correct vertices
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### TestPointInPolygon

```csharp
[Test]
    public void TestPointInPolygon()
    {
        // Arrange: Create square polygon
        var polygon = new Vector2[]
        {
            new Vector2(0, 0),
            new Vector2(100, 0),
            new Vector2(100, 100),
            new Vector2(0, 100)
        };
        
        // Act: Test point inclusion
        var insidePoint = new Vector2(50, 50);
        var outsidePoint = new Vector2(150, 150);
        
        // Assert: Point-in-polygon should work correctly
        ;
        ;
    }
```

**Returns:** `void`

