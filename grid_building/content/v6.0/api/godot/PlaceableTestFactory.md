---
title: "PlaceableTestFactory"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placeabletestfactory/"
---

# PlaceableTestFactory

```csharp
GridBuilding.Godot.Test.Factories
class PlaceableTestFactory
{
    // Members...
}
```

C# implementation of PlaceableTestFactory for creating placeable test objects
Provides centralized factory methods for creating test placeables with various configurations
Ported from: godot/addons/grid_building/test/grid_building/helpers/factories/placeable_test_factory.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/PlaceableTestFactory.cs`  
**Namespace:** `GridBuilding.Godot.Test.Factories`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateBasicPlaceable

```csharp
#region Factory Methods

    /// <summary>
    /// Creates a basic placeable test object
    /// </summary>
    /// <param name="id">Unique identifier for the placeable</param>
    /// <param name="size">Size of the placeable in tiles</param>
    /// <param name="position">Position in world coordinates</param>
    /// <returns>Configured placeable test object</returns>
    public static PlaceableTestObject CreateBasicPlaceable(
        string id, 
        Vector2I size = default, 
        Vector2 position = default)
    {
        var placeable = new PlaceableTestObject
        {
            Id = id,
            Name = $"Test Placeable {id}",
            Size = size == default ? Vector2I.One : size,
            Position = position,
            IsPlaceable = true,
            BuildTime = 5.0f,
            Cost = 100
        };

        return placeable;
    }
```

Creates a basic placeable test object

**Returns:** `PlaceableTestObject`

**Parameters:**
- `string id`
- `Vector2I size`
- `Vector2 position`

### CreateLargePlaceable

```csharp
/// <summary>
    /// Creates a large placeable test object
    /// </summary>
    /// <param name="id">Unique identifier for the placeable</param>
    /// <param name="size">Size of the placeable in tiles</param>
    /// <param name="position">Position in world coordinates</param>
    /// <returns>Configured large placeable test object</returns>
    public static PlaceableTestObject CreateLargePlaceable(
        string id, 
        Vector2I size = default, 
        Vector2 position = default)
    {
        var placeable = new PlaceableTestObject
        {
            Id = id,
            Name = $"Large Test Placeable {id}",
            Size = size == default ? new Vector2I(2, 2) : size,
            Position = position,
            IsPlaceable = true,
            BuildTime = 10.0f,
            Cost = 200
        };

        return placeable;
    }
```

Creates a large placeable test object

**Returns:** `PlaceableTestObject`

**Parameters:**
- `string id`
- `Vector2I size`
- `Vector2 position`

### CreateNonPlaceableObject

```csharp
/// <summary>
    /// Creates a non-placeable test object (for testing placement failures)
    /// </summary>
    /// <param name="id">Unique identifier for the object</param>
    /// <param name="position">Position in world coordinates</param>
    /// <returns>Configured non-placeable test object</returns>
    public static PlaceableTestObject CreateNonPlaceableObject(string id, Vector2 position = default)
    {
        var placeable = new PlaceableTestObject
        {
            Id = id,
            Name = $"Non-Placeable Object {id}",
            Size = Vector2I.One,
            Position = position,
            IsPlaceable = false,
            BuildTime = 0.0f,
            Cost = 0,
            ErrorMessage = "This object cannot be placed"
        };

        return placeable;
    }
```

Creates a non-placeable test object (for testing placement failures)

**Returns:** `PlaceableTestObject`

**Parameters:**
- `string id`
- `Vector2 position`

### CreateCustomPlaceable

```csharp
/// <summary>
    /// Creates a placeable with custom properties
    /// </summary>
    /// <param name="id">Unique identifier for the placeable</param>
    /// <param name="properties">Custom properties dictionary</param>
    /// <returns>Configured placeable with custom properties</returns>
    public static PlaceableTestObject CreateCustomPlaceable(string id, Dictionary<string, Variant> properties)
    {
        var placeable = new PlaceableTestObject
        {
            Id = id,
            Name = $"Custom Placeable {id}",
            Size = Vector2I.One,
            Position = Vector2.Zero,
            IsPlaceable = true,
            BuildTime = 5.0f,
            Cost = 100,
            CustomProperties = properties ?? new Dictionary<string, Variant>()
        };

        return placeable;
    }
```

Creates a placeable with custom properties

**Returns:** `PlaceableTestObject`

**Parameters:**
- `string id`
- `Dictionary<string, Variant> properties`

### CreateTestCollection

```csharp
/// <summary>
    /// Creates a collection of test placeables for comprehensive testing
    /// </summary>
    /// <param name="basePosition">Base position for the collection</param>
    /// <returns>Dictionary of test placeables</returns>
    public static Dictionary<string, PlaceableTestObject> CreateTestCollection(Vector2 basePosition = default)
    {
        var collection = new Dictionary<string, PlaceableTestObject>();

        // Basic placeables
        collection["basic_1"] = CreateBasicPlaceable("basic_1", Vector2I.One, basePosition);
        collection["basic_2"] = CreateBasicPlaceable("basic_2", Vector2I.One, basePosition + new Vector2(64, 0));

        // Large placeables
        collection["large_1"] = CreateLargePlaceable("large_1", new Vector2I(2, 2), basePosition + new Vector2(128, 0));
        collection["large_2"] = CreateLargePlaceable("large_2", new Vector2I(3, 3), basePosition + new Vector2(256, 0));

        // Non-placeable objects
        collection["invalid_1"] = CreateNonPlaceableObject("invalid_1", basePosition + new Vector2(0, 128));

        // Custom placeables
        var customProps = new Dictionary<string, Variant>
        {
            ["category"] = "special",
            ["rarity"] = "rare",
            ["description"] = "A special custom placeable"
        };
        collection["custom_1"] = CreateCustomPlaceable("custom_1", customProps);

        return collection;
    }
```

Creates a collection of test placeables for comprehensive testing

**Returns:** `Dictionary<string, PlaceableTestObject>`

**Parameters:**
- `Vector2 basePosition`

### CreatePlaceableWithCollision

```csharp
/// <summary>
    /// Creates a placeable with collision shape
    /// </summary>
    /// <param name="id">Unique identifier for the placeable</param>
    /// <param name="collisionShape">Collision shape definition</param>
    /// <param name="position">Position in world coordinates</param>
    /// <returns>Configured placeable with collision</returns>
    public static PlaceableTestObject CreatePlaceableWithCollision(
        string id, 
        CollisionShapeDefinition collisionShape, 
        Vector2 position = default)
    {
        var placeable = new PlaceableTestObject
        {
            Id = id,
            Name = $"Placeable with Collision {id}",
            Size = Vector2I.One,
            Position = position,
            IsPlaceable = true,
            BuildTime = 5.0f,
            Cost = 100,
            CollisionShape = collisionShape
        };

        return placeable;
    }
```

Creates a placeable with collision shape

**Returns:** `PlaceableTestObject`

**Parameters:**
- `string id`
- `CollisionShapeDefinition collisionShape`
- `Vector2 position`

### CreateRectangleCollision

```csharp
#endregion

    #region Collision Shape Factory Methods

    /// <summary>
    /// Creates a rectangular collision shape
    /// </summary>
    /// <param name="size">Size of the rectangle</param>
    /// <param name="offset">Offset from center</param>
    /// <returns>Rectangle collision shape definition</returns>
    public static CollisionShapeDefinition CreateRectangleCollision(Vector2 size, Vector2 offset = default)
    {
        return new CollisionShapeDefinition
        {
            Type = CollisionShapeType.Rectangle,
            Size = size,
            Offset = offset,
            Radius = 0f
        };
    }
```

Creates a rectangular collision shape

**Returns:** `CollisionShapeDefinition`

**Parameters:**
- `Vector2 size`
- `Vector2 offset`

### CreateCircleCollision

```csharp
/// <summary>
    /// Creates a circular collision shape
    /// </summary>
    /// <param name="radius">Radius of the circle</param>
    /// <param name="offset">Offset from center</param>
    /// <returns>Circle collision shape definition</returns>
    public static CollisionShapeDefinition CreateCircleCollision(float radius, Vector2 offset = default)
    {
        return new CollisionShapeDefinition
        {
            Type = CollisionShapeType.Circle,
            Size = Vector2.Zero,
            Offset = offset,
            Radius = radius
        };
    }
```

Creates a circular collision shape

**Returns:** `CollisionShapeDefinition`

**Parameters:**
- `float radius`
- `Vector2 offset`

### CreatePolygonCollision

```csharp
/// <summary>
    /// Creates a polygon collision shape
    /// </summary>
    /// <param name="points">Array of points defining the polygon</param>
    /// <param name="offset">Offset from center</param>
    /// <returns>Polygon collision shape definition</returns>
    public static CollisionShapeDefinition CreatePolygonCollision(Vector2[] points, Vector2 offset = default)
    {
        return new CollisionShapeDefinition
        {
            Type = CollisionShapeType.Polygon,
            Size = Vector2.Zero,
            Offset = offset,
            Radius = 0f,
            Points = points ?? new Vector2[0]
        };
    }
```

Creates a polygon collision shape

**Returns:** `CollisionShapeDefinition`

**Parameters:**
- `Vector2[] points`
- `Vector2 offset`

### CreateScenario

```csharp
#endregion

    #region Test Scenarios

    /// <summary>
    /// Creates placeables for testing basic placement scenarios
    /// </summary>
    /// <param name="scenarioType">Type of scenario to create</param>
    /// <returns>List of placeables for the scenario</returns>
    public static List<PlaceableTestObject> CreateScenario(PlaceableTestScenario scenarioType)
    {
        return scenarioType switch
        {
            PlaceableTestScenario.BasicPlacement => CreateBasicPlacementScenario(),
            PlaceableTestScenario.LargePlacement => CreateLargePlacementScenario(),
            PlaceableTestScenario.CollisionTesting => CreateCollisionTestingScenario(),
            PlaceableTestScenario.FailureTesting => CreateFailureTestingScenario(),
            PlaceableTestScenario.CustomProperties => CreateCustomPropertiesScenario(),
            _ => throw new ArgumentException($"Unknown scenario type: {scenarioType}")
        };
    }
```

Creates placeables for testing basic placement scenarios

**Returns:** `List<PlaceableTestObject>`

**Parameters:**
- `PlaceableTestScenario scenarioType`

