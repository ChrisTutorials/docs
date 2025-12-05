---
title: "CollisionMapperTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionmappertest/"
---

# CollisionMapperTest

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class CollisionMapperTest
{
    // Members...
}
```

Unit tests for CollisionMapper to catch guard behaviors and setup issues
that can cause integration test failures at higher levels.
DO NOT use a full environment here - this is a unit test to isolate issues.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CollisionMapperTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        // Load test indicator template
        _indicatorTemplate = GD.Load<PackedScene>(ResourcePaths.TestFixtures.IndicatorTdPlatformer);
    }
```

**Returns:** `void`

### Setup

```csharp
[Setup]
    public void Setup()
    {
        _logger = new Logger(new DebugSettings());
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        // Ensure proper cleanup of any remaining nodes
        _logger = null;
    }
```

**Returns:** `void`

### Guard_ReturnsEmptyWithoutSetup

```csharp
#endregion

    #region Test Functions

    /// <summary>
    /// Tests that CollisionMapper guard returns empty results when setup() is not called.
    /// Verifies mapper prevents collision mapping without proper initialization.
    /// </summary>
    [Test]
    public void Guard_ReturnsEmptyWithoutSetup()
    {
        var targetingState = CreateMinimalTargetingState();
        var mapper = new CollisionMapper(targetingState, _logger!);
        
        // Create a polygon owner but do not call setup(); guard should prevent mapping
        var body = new StaticBody2D();
        TestScene.AddChild(body);
        
        var poly = new CollisionPolygon2D();
        body.AddChild(poly);
        
        var rule = new TileCheckRule();
        rule.ApplyToObjectsMask = 1; // Match collision layer 1
        
        var collisionPositions = new Dictionary<Vector2I, List<Node2D>>();
        
        // This should return empty due to guard (setup not called)
        var result = mapper.MapCollisions(rule, collisionPositions);
        
        result.ShouldBeEmpty("Guard should prevent mapping without setup");
        
        body.QueueFree();
    }
```

Tests that CollisionMapper guard returns empty results when setup() is not called.
Verifies mapper prevents collision mapping without proper initialization.

**Returns:** `void`

### BasicCollisionDetection

```csharp
/// <summary>
    /// Tests basic collision detection functionality
    /// </summary>
    [Test]
    public void BasicCollisionDetection()
    {
        var targetingState = CreateMinimalTargetingState();
        var mapper = new CollisionMapper(targetingState, _logger!);

        // Create test collision body
        var body = new StaticBody2D();
        TestScene.AddChild(body);
        body.CollisionLayer = 1;

        var polygon = new CollisionPolygon2D();
        body.AddChild(polygon);
        polygon.Polygon = new Vector2[] 
        {
            new(0, 0), new(32, 0), new(32, 32), new(0, 32)
        };

        // Create rule
        var rule = new TileCheckRule();
        rule.ApplyToObjectsMask = 1;

        var collisionPositions = new Dictionary<Vector2I, List<Node2D>>();

        // Setup mapper
        mapper.Setup(body, rule, collisionPositions);

        // Test mapping
        var result = mapper.MapCollisions(rule, collisionPositions);

        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0, "Should detect collision positions");

        body.QueueFree();
    }
```

Tests basic collision detection functionality

**Returns:** `void`

### CollisionLayerMatchingForTileCheckRules

```csharp
/// <summary>
    /// Tests collision layer matching for tile check rules
    /// </summary>
    [Test]
    public void CollisionLayerMatchingForTileCheckRules()
    {
        var targetingState = CreateMinimalTargetingState();
        var mapper = new CollisionMapper(targetingState, _logger!);

        // Create test collision body with specific layer
        var body = new StaticBody2D();
        TestScene.AddChild(body);
        body.CollisionLayer = 2; // Layer 2

        var polygon = new CollisionPolygon2D();
        body.AddChild(polygon);
        polygon.Polygon = new Vector2[] 
        {
            new(0, 0), new(16, 0), new(16, 16), new(0, 16)
        };

        // Create rule with matching mask
        var rule = new TileCheckRule();
        rule.ApplyToObjectsMask = 2; // Should match layer 2

        var collisionPositions = new Dictionary<Vector2I, List<Node2D>>();

        // Setup mapper
        mapper.Setup(body, rule, collisionPositions);

        // Test mapping
        var result = mapper.MapCollisions(rule, collisionPositions);

        result.ShouldNotBeNull();
        
        // Test with non-matching mask
        rule.ApplyToObjectsMask = 1; // Should not match layer 2
        var nonMatchingResult = mapper.MapCollisions(rule, collisionPositions);
        
        nonMatchingResult.Count.ShouldBeLessThanOrEqualTo(result.Count, 
            "Non-matching mask should detect fewer or equal collisions");

        body.QueueFree();
    }
```

Tests collision layer matching for tile check rules

**Returns:** `void`

### PositionRulesMappingProducesResults

```csharp
/// <summary>
    /// Tests position rules mapping produces results
    /// </summary>
    [Test]
    public void PositionRulesMappingProducesResults()
    {
        var targetingState = CreateMinimalTargetingState();
        var mapper = new CollisionMapper(targetingState, _logger!);

        // Create test collision body
        var body = new StaticBody2D();
        TestScene.AddChild(body);
        body.Position = new Vector2(50, 50); // Non-zero position
        body.CollisionLayer = 1;

        var polygon = new CollisionPolygon2D();
        body.AddChild(polygon);
        polygon.Polygon = new Vector2[] 
        {
            new(0, 0), new(64, 0), new(64, 64), new(0, 64)
        };

        // Create position-based rule
        var rule = new TileCheckRule();
        rule.ApplyToObjectsMask = 1;

        var collisionPositions = new Dictionary<Vector2I, List<Node2D>>();

        // Setup mapper
        mapper.Setup(body, rule, collisionPositions);

        // Test mapping
        var result = mapper.MapCollisions(rule, collisionPositions);

        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0, "Should detect collision positions for positioned body");

        // Verify collision positions are reasonable
        foreach (var kvp in result)
        {
            kvp.Value.ShouldContain(body, "Collision body should be in collision positions");
        }

        body.QueueFree();
    }
```

Tests position rules mapping produces results

**Returns:** `void`

### TrapezoidCollisionMapperSetupDebug

```csharp
/// <summary>
    /// Tests trapezoid collision mapper setup with debug information
    /// </summary>
    [Test]
    public void TrapezoidCollisionMapperSetupDebug()
    {
        // Arrange: Create trapezoid shape matching simple_trapezoid.tscn
        var body = new StaticBody2D();
        TestScene.AddChild(body);
        body.CollisionLayer = 1;
        body.Position = new Vector2(100, 100);

        var polygon = new CollisionPolygon2D();
        body.AddChild(polygon);
        
        // Create trapezoid points
        polygon.Polygon = new Vector2[]
        {
            new(0, 32),   // Bottom left
            new(64, 32),  // Bottom right  
            new(48, 0),   // Top right
            new(16, 0)    // Top left
        };

        var targetingState = CreateMinimalTargetingState();
        var mapper = new CollisionMapper(targetingState, _logger!);

        var rule = new TileCheckRule();
        rule.ApplyToObjectsMask = 1;

        var collisionPositions = new Dictionary<Vector2I, List<Node2D>>();

        // Act: Setup mapper with trapezoid
        mapper.Setup(body, rule, collisionPositions);

        // Assert: Verify setup is complete
        mapper.TestIndicator.ShouldNotBeNull("Test indicator should be set up");
        mapper.TestSetups.ShouldNotBeNull("Test setups should be initialized");
        mapper.TestSetups.Count.ShouldBeGreaterThan(0, "Should have test setups");

        var bodySetup = GetTestSetupForBody(mapper, body);
        bodySetup.ShouldNotBeNull("Should have setup for collision body");

        // Generate diagnostics for debugging
        var diagnostics = GenerateMapperSetupDiagnostics(mapper, body);
        GD.Print(diagnostics);

        // Test collision mapping
        var result = mapper.MapCollisions(rule, collisionPositions);
        result.ShouldNotBeNull();

        body.QueueFree();
    }
```

Tests trapezoid collision mapper setup with debug information

**Returns:** `void`

### RectangleCollisionCoverage48x64Pixels

```csharp
/// <summary>
    /// Tests rectangle collision coverage for specific pixel dimensions (48x64)
    /// </summary>
    [Test]
    public void RectangleCollisionCoverage48x64Pixels()
    {
        var state = CreateMinimalTargetingState();
        var mapper = new CollisionMapper(state, _logger!);

        // Create the exact same rectangle from the failing integration test
        var rectWidth = 48.0f; // 3 tiles × 16 pixels/tile
        var rectHeight = 64.0f; // 4 tiles × 16 pixels/tile

        var body = new StaticBody2D();
        TestScene.AddChild(body);
        body.CollisionLayer = 1;

        var polygon = new CollisionPolygon2D();
        body.AddChild(polygon);
        
        // Create rectangle polygon
        polygon.Polygon = new Vector2[]
        {
            new(0, 0), new(rectWidth, 0), new(rectWidth, rectHeight), new(0, rectHeight)
        };

        var rule = new TileCheckRule();
        rule.ApplyToObjectsMask = 1;

        var collisionPositions = new Dictionary<Vector2I, List<Node2D>>();

        // Setup mapper
        mapper.Setup(body, rule, collisionPositions);

        // Test mapping
        var result = mapper.MapCollisions(rule, collisionPositions);

        result.ShouldNotBeNull();
        result.Count.ShouldBeGreaterThan(0, "Should detect collision positions for 48x64 rectangle");

        // Verify coverage - should span approximately 3x4 tiles
        var expectedTileCount = 3 * 4; // 12 tiles maximum coverage
        result.Count.ShouldBeLessThanOrEqualTo(expectedTileCount, 
            "Should not exceed expected tile coverage");

        body.QueueFree();
    }
```

Tests rectangle collision coverage for specific pixel dimensions (48x64)

**Returns:** `void`

