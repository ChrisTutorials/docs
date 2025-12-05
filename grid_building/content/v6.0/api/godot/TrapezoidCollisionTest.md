---
title: "TrapezoidCollisionTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/trapezoidcollisiontest/"
---

# TrapezoidCollisionTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class TrapezoidCollisionTest
{
    // Members...
}
```

Integration test for trapezoid shape collision detection in the runtime environment
This test specifically reproduces the issue where the trapezoid shape from the demo
is not generating rule check indicators at the bottom left and bottom right positions
despite the unit tests passing for the collision geometry calculations.
The goal is to isolate where in the indicator generation chain the collision
calculations are being lost or incorrectly filtered.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/TrapezoidCollisionTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### TrapezoidCollisionDetection_Integration_WorksCorrectly

```csharp
/// <summary>
    /// Test that focuses on the trapezoid collision detection integration
    /// </summary>
    [Test]
    public void TrapezoidCollisionDetection_Integration_WorksCorrectly()
    {
        GD.Print("[TRAPEZOID_TRACE] === STARTING INTEGRATION TEST ===");

        // 1) Create the exact trapezoid from runtime
        var trapezoidPolygon = CreateTrapezoidFromRuntime();
        GD.Print($"[TRAPEZOID_TRACE] Trapezoid polygon: {string.Join(", ", trapezoidPolygon)}");

        // 2) Create test object with collision shape (needs to be a physics body)
        var testObject = new StaticBody2D();
        testObject.Name = "TrapezoidTestObject";
        testObject.GlobalPosition = TRAPEZOID_POSITION;
        TestScene.AddChild(testObject);

        var collisionShape = new CollisionShape2D();
        var shape = new ConvexPolygonShape2D();
        shape.Points = trapezoidPolygon.ToArray();
        collisionShape.Shape = shape;
        collisionShape.Name = "TrapezoidCollision";

        testObject.AddChild(collisionShape);

        GD.Print($"[TRAPEZOID_TRACE] Test object position: {testObject.GlobalPosition}");
        GD.Print($"[TRAPEZOID_TRACE] Collision shape points: {shape.Points.Length}");

        // 3) Test basic collision shape properties
        shape.Points.ShouldNotBeNull("Trapezoid shape should have points");
        shape.Points.Length.ShouldBe(4, "Trapezoid should have 4 vertices");
        
        // Verify the trapezoid shape is properly formed
        var points = shape.Points;
        points[0].ShouldBe(new Vector2(-32, 12), "First vertex should match expected");
        points[1].ShouldBe(new Vector2(-16, -12), "Second vertex should match expected");
        points[2].ShouldBe(new Vector2(17, -12), "Third vertex should match expected");
        points[3].ShouldBe(new Vector2(32, 12), "Fourth vertex should match expected");

        // 4) Test collision detection at trapezoid position
        var testArea = new Area2D();
        testObject.AddChild(testArea);
        
        var detectionShape = new CollisionShape2D();
        detectionShape.Shape = new RectangleShape2D { Size = new Vector2(10, 10) };
        testArea.AddChild(detectionShape);

        // Position detection shape at bottom left of trapezoid
        detectionShape.Position = new Vector2(-20, 15);
        
        // Test collision detection
        var hasCollision = testArea.GetOverlappingAreas().Count > 0 || 
                          testArea.GetOverlappingBodies().Count > 0;

        GD.Print($"[TRAPEZOID_TRACE] Bottom left collision detected: {hasCollision}");

        // 5) Test collision detection at bottom right of trapezoid
        detectionShape.Position = new Vector2(25, 15);
        
        hasCollision = testArea.GetOverlappingAreas().Count > 0 || 
                     testArea.GetOverlappingBodies().Count > 0;

        GD.Print($"[TRAPEZOID_TRACE] Bottom right collision detected: {hasCollision}");

        // 6) Test collision detection at top (should not collide)
        detectionShape.Position = new Vector2(0, -15);
        
        hasCollision = testArea.GetOverlappingAreas().Count > 0 || 
                     testArea.GetOverlappingBodies().Count > 0;

        GD.Print($"[TRAPEZOID_TRACE] Top collision detected: {hasCollision}");

        // Cleanup
        testObject.QueueFree();
    }
```

Test that focuses on the trapezoid collision detection integration

**Returns:** `void`

### TrapezoidGeometry_Properties_AreCorrect

```csharp
/// <summary>
    /// Test trapezoid polygon geometry properties
    /// </summary>
    [Test]
    public void TrapezoidGeometry_Properties_AreCorrect()
    {
        var trapezoidPolygon = CreateTrapezoidFromRuntime();

        // Verify trapezoid properties
        trapezoidPolygon.Count.ShouldBe(4, "Trapezoid should have 4 vertices");

        // Check that the top edge is shorter than the bottom edge (trapezoid property)
        var topLength = (trapezoidPolygon[1] - trapezoidPolygon[2]).Length();
        var bottomLength = (trapezoidPolygon[0] - trapezoidPolygon[3]).Length();

        bottomLength.ShouldBeGreaterThan(topLength, "Bottom edge should be longer than top edge");

        // Verify vertices are in correct order (clockwise or counter-clockwise)
        var center = CalculatePolygonCenter(trapezoidPolygon);
        center.X.ShouldBeApproximately(0, 1.0f, "Trapezoid should be roughly centered");
        center.Y.ShouldBeApproximately(0, 1.0f, "Trapezoid should be roughly centered");
    }
```

Test trapezoid polygon geometry properties

**Returns:** `void`

### TrapezoidCollisionShape_Creation_WorksCorrectly

```csharp
/// <summary>
    /// Test trapezoid collision shape creation
    /// </summary>
    [Test]
    public void TrapezoidCollisionShape_Creation_WorksCorrectly()
    {
        var trapezoidPolygon = CreateTrapezoidFromRuntime();

        var shape = new ConvexPolygonShape2D();
        shape.Points = trapezoidPolygon.ToArray();

        // Verify shape properties
        shape.Points.ShouldNotBeNull("Shape should have points");
        shape.Points.Length.ShouldBe(4, "Shape should have 4 points");

        // Test shape bounds
        var aabb = shape.GetAabb();
        aabb.Position.X.ShouldBeLessThanOrEqualTo(-32, "AABB should include leftmost point");
        aabb.Position.Y.ShouldBeLessThanOrEqualTo(-12, "AABB should include topmost point");
        aabb.Size.X.ShouldBeGreaterThanOrEqualTo(64, "AABB should span the width");
        aabb.Size.Y.ShouldBeGreaterThanOrEqualTo(24, "AABB should span the height");
    }
```

Test trapezoid collision shape creation

**Returns:** `void`

### TrapezoidCollision_WithDifferentShapes_WorksCorrectly

```csharp
/// <summary>
    /// Test trapezoid collision with different shapes
    /// </summary>
    [Test]
    public void TrapezoidCollision_WithDifferentShapes_WorksCorrectly()
    {
        var trapezoidPolygon = CreateTrapezoidFromRuntime();

        // Create trapezoid body
        var trapezoidBody = new StaticBody2D();
        trapezoidBody.GlobalPosition = Vector2.Zero;
        TestScene.AddChild(trapezoidBody);

        var trapezoidShape = new CollisionShape2D();
        var trapezoidConvexShape = new ConvexPolygonShape2D();
        trapezoidConvexShape.Points = trapezoidPolygon.ToArray();
        trapezoidShape.Shape = trapezoidConvexShape;
        trapezoidBody.AddChild(trapezoidShape);

        // Test collision with circle at various positions
        var circleBody = new RigidBody2D();
        circleBody.GlobalPosition = new Vector2(0, 20); // Below trapezoid
        TestScene.AddChild(circleBody);

        var circleShape = new CollisionShape2D();
        circleShape.Shape = new CircleShape2D { Radius = 5 };
        circleBody.AddChild(circleShape);

        // Force physics update
        TestScene.GetTree().Root.CallDeferred(SceneTree.MethodName.ProcessFrame);

        // Cleanup
        trapezoidBody.QueueFree();
        circleBody.QueueFree();
    }
```

Test trapezoid collision with different shapes

**Returns:** `void`

