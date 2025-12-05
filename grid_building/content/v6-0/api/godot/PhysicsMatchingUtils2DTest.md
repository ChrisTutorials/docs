---
title: "PhysicsMatchingUtils2DTest"
description: "Unit tests for PhysicsMatchingUtils2D."
weight: 20
url: "/gridbuilding/v6-0/api/godot/physicsmatchingutils2dtest/"
---

# PhysicsMatchingUtils2DTest

```csharp
GridBuilding.Godot.Tests.Shared
class PhysicsMatchingUtils2DTest
{
    // Members...
}
```

Unit tests for PhysicsMatchingUtils2D.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/PhysicsMatchingUtils2DTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Shared`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TestName

```csharp
#region Test Metadata

    [Test]
    public string TestName => "PhysicsMatchingUtils2D Tests";
```

### TestDescription

```csharp
[Test]
    public string TestDescription => "Tests physics matching utilities functionality";
```


## Methods

### PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithNullContainer_ShouldReturnEmpty

```csharp
#endregion

    #region Tests

    [Test]
    public void PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithNullContainer_ShouldReturnEmpty()
    {
        // Given
        Node2D? container = null;
        var shapeCast = new ShapeCast2D();

        // When
        var result = PhysicsMatchingUtils2D.GetMatchingCollisionObjects(container, shapeCast);

        // Then
        ;
        ;

        // Cleanup
        shapeCast.QueueFree();
    }
```

**Returns:** `void`

### PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithNoCollisionObjects_ShouldReturnEmpty

```csharp
[Test]
    public void PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithNoCollisionObjects_ShouldReturnEmpty()
    {
        // Given
        var container = new Node2D();
        var shapeCast = new ShapeCast2D();

        // When
        var result = PhysicsMatchingUtils2D.GetMatchingCollisionObjects(container, shapeCast);

        // Then
        ;
        ;

        // Cleanup
        container.QueueFree();
        shapeCast.QueueFree();
    }
```

**Returns:** `void`

### PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithMatchingCollisionObject_ShouldReturnIt

```csharp
[Test]
    public void PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithMatchingCollisionObject_ShouldReturnIt()
    {
        // Given
        var container = new CollisionObject2D();
        var shapeCast = new ShapeCast2D();
        shapeCast.CollisionMask = 1; // Layer 1
        container.CollisionLayer = 1; // Layer 1

        // When
        var result = PhysicsMatchingUtils2D.GetMatchingCollisionObjects(container, shapeCast);

        // Then
        ;
        ;
        ;

        // Cleanup
        container.QueueFree();
        shapeCast.QueueFree();
    }
```

**Returns:** `void`

### PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithNonMatchingCollisionObject_ShouldReturnEmpty

```csharp
[Test]
    public void PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithNonMatchingCollisionObject_ShouldReturnEmpty()
    {
        // Given
        var container = new CollisionObject2D();
        var shapeCast = new ShapeCast2D();
        shapeCast.CollisionMask = 1; // Layer 1
        container.CollisionLayer = 2; // Layer 2 (different)

        // When
        var result = PhysicsMatchingUtils2D.GetMatchingCollisionObjects(container, shapeCast);

        // Then
        ;
        ;

        // Cleanup
        container.QueueFree();
        shapeCast.QueueFree();
    }
```

**Returns:** `void`

### PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithChildCollisionObjects_ShouldReturnMatchingOnes

```csharp
[Test]
    public void PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithChildCollisionObjects_ShouldReturnMatchingOnes()
    {
        // Given
        var container = new Node2D();
        var matchingChild = new CollisionObject2D();
        var nonMatchingChild = new CollisionObject2D();
        var shapeCast = new ShapeCast2D();
        
        shapeCast.CollisionMask = 1; // Layer 1
        matchingChild.CollisionLayer = 1; // Layer 1 (matches)
        nonMatchingChild.CollisionLayer = 2; // Layer 2 (doesn't match)

        container.AddChild(matchingChild);
        container.AddChild(nonMatchingChild);

        // When
        var result = PhysicsMatchingUtils2D.GetMatchingCollisionObjects(container, shapeCast);

        // Then
        ;
        ;
        ;

        // Cleanup
        container.QueueFree();
        shapeCast.QueueFree();
    }
```

**Returns:** `void`

### PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithRequireAllMaskLayers_ShouldWorkCorrectly

```csharp
[Test]
    public void PhysicsMatchingUtils2D_GetMatchingCollisionObjects_WithRequireAllMaskLayers_ShouldWorkCorrectly()
    {
        // Given
        var container = new Node2D();
        var partialMatch = new CollisionObject2D();
        var fullMatch = new CollisionObject2D();
        var shapeCast = new ShapeCast2D();
        
        shapeCast.CollisionMask = 3; // Layers 1 and 2
        partialMatch.CollisionLayer = 1; // Only layer 1 (partial match)
        fullMatch.CollisionLayer = 3; // Layers 1 and 2 (full match)

        container.AddChild(partialMatch);
        container.AddChild(fullMatch);

        // When - Require all mask layers
        var resultAll = PhysicsMatchingUtils2D.GetMatchingCollisionObjects(container, shapeCast, true);

        // Then - Should only return full match
        ;
        ;
        ;

        // Cleanup
        container.QueueFree();
        shapeCast.QueueFree();
    }
```

**Returns:** `void`

### PhysicsMatchingUtils2D_GetPhysicsLayerNamesFromMask_WithMaskZero_ShouldReturnEmpty

```csharp
[Test]
    public void PhysicsMatchingUtils2D_GetPhysicsLayerNamesFromMask_WithMaskZero_ShouldReturnEmpty()
    {
        // Given
        uint mask = 0;

        // When
        var result = PhysicsMatchingUtils2D.GetPhysicsLayerNamesFromMask(mask);

        // Then
        ;
        ;
    }
```

**Returns:** `void`

### PhysicsMatchingUtils2D_GetPhysicsLayerNamesFromMask_WithSingleLayer_ShouldReturnCorrectName

```csharp
[Test]
    public void PhysicsMatchingUtils2D_GetPhysicsLayerNamesFromMask_WithSingleLayer_ShouldReturnCorrectName()
    {
        // Given
        uint mask = 1; // Layer 1

        // When
        var result = PhysicsMatchingUtils2D.GetPhysicsLayerNamesFromMask(mask);

        // Then
        ;
        ;
        // Note: This will return the actual layer name from project settings or "Layer 1" as fallback
        ;
    }
```

**Returns:** `void`

### PhysicsMatchingUtils2D_GetPhysicsLayerNamesFromMask_WithMultipleLayers_ShouldReturnAllNames

```csharp
[Test]
    public void PhysicsMatchingUtils2D_GetPhysicsLayerNamesFromMask_WithMultipleLayers_ShouldReturnAllNames()
    {
        // Given
        uint mask = 3; // Layers 1 and 2 (bits 0 and 1)

        // When
        var result = PhysicsMatchingUtils2D.GetPhysicsLayerNamesFromMask(mask);

        // Then
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### PhysicsMatchingUtils2D_GetPhysicsLayerNamesFromMask_WithHighLayer_ShouldReturnCorrectName

```csharp
[Test]
    public void PhysicsMatchingUtils2D_GetPhysicsLayerNamesFromMask_WithHighLayer_ShouldReturnCorrectName()
    {
        // Given
        uint mask = 1U << 10; // Layer 11 (bit 10)

        // When
        var result = PhysicsMatchingUtils2D.GetPhysicsLayerNamesFromMask(mask);

        // Then
        ;
        ;
        ;
    }
```

**Returns:** `void`

