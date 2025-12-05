---
title: "CollisionObjectTestFactory"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionobjecttestfactory/"
---

# CollisionObjectTestFactory

```csharp
GridBuilding.Godot.Tests.Factories
class CollisionObjectTestFactory
{
    // Members...
}
```

Factory for creating test collision objects with various shapes and configurations
Provides standardized collision objects for testing collision detection systems
Implements unified factory interface for consistency

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/CollisionObjectTestFactory.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Factories`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CreatedObjects

```csharp
#region Properties
    
    /// <summary>
    /// Registry of created collision objects
    /// </summary>
    public Dictionary<string, CollisionObject2D> CreatedObjects { get; private set; } = new();
```

Registry of created collision objects

### Config

```csharp
/// <summary>
    /// Configuration for collision object creation
    /// </summary>
    public CollisionObjectFactoryConfig Config { get; set; } = new();
```

Configuration for collision object creation


## Methods

### Create

```csharp
#endregion
    
    #region IFactory Implementation
    
    public T Create<T>() where T : class
    {
        if (typeof(T) == typeof(CollisionObject2D))
        {
            return CreateRectangle() as T;
        }
        
        return Activator.CreateInstance<T>();
    }
```

**Returns:** `T`

### Create

```csharp
public T Create<T>(params object[] parameters) where T : class
    {
        if (typeof(T) == typeof(CollisionObject2D))
        {
            return CreateRectangle() as T;
        }
        
        return (T)Activator.CreateInstance(typeof(T), parameters);
    }
```

**Returns:** `T`

**Parameters:**
- `object[] parameters`

### Create

```csharp
public T Create<T>(Func<T> factory) where T : class
    {
        return factory();
    }
```

**Returns:** `T`

**Parameters:**
- `Func<T> factory`

### CreateTest

```csharp
#endregion
    
    #region ITestFactory Implementation
    
    public T CreateTest<T>(string name) where T : class
    {
        if (typeof(T) == typeof(CollisionObject2D))
        {
            var obj = CreateRectangle();
            obj.Name = name;
            CreatedObjects[name] = obj;
            return obj as T;
        }
        
        var instance = Activator.CreateInstance<T>();
        
        // Try to set a Name property if it exists
        var nameProperty = typeof(T).GetProperty("Name");
        if (nameProperty != null && nameProperty.CanWrite)
        {
            nameProperty.SetValue(instance, name);
        }
        
        return instance;
    }
```

**Returns:** `T`

**Parameters:**
- `string name`

### CreateMock

```csharp
public T CreateMock<T>() where T : class
    {
        // For testing, return a simple stub implementation
        return CreateStub<T>();
    }
```

**Returns:** `T`

### CreateStub

```csharp
public T CreateStub<T>() where T : class
    {
        if (typeof(T) == typeof(CollisionObject2D))
        {
            var obj = new CollisionObject2D();
            obj.Name = "stub_collision";
            return obj as T;
        }
        
        return Activator.CreateInstance<T>();
    }
```

**Returns:** `T`

### CreateTestCollection

```csharp
public IEnumerable<T> CreateTestCollection<T>(int count, string namePrefix = "test") where T : class
    {
        if (count <= 0)
            yield break;

        for (int i = 0; i < count; i++)
        {
            yield return CreateTest<T>($"{namePrefix}_{i}");
        }
    }
```

**Returns:** `IEnumerable<T>`

**Parameters:**
- `int count`
- `string namePrefix`

### CreateRectangleCollisionObject

```csharp
#endregion
    
    #region Collision Object Creation Methods
    
    /// <summary>
    /// Creates a rectangular collision object
    /// </summary>
    /// <param name="name">Name of the collision object</param>
    /// <param name="size">Size of the rectangle</param>
    /// <param name="position">Position of the object</param>
    /// <param name="collisionLayer">Collision layer</param>
    /// <param name="collisionMask">Collision mask</param>
    /// <returns>Created rectangular collision object</returns>
    public CollisionObject2D CreateRectangleCollisionObject(
        string name, 
        Vector2 size, 
        Vector2 position = default,
        uint collisionLayer = 1,
        uint collisionMask = 1)
    {
        var area = new Area2D();
        area.Name = name;
        area.Position = position;
        area.CollisionLayer = collisionLayer;
        area.CollisionMask = collisionMask;
        
        var collisionShape = new CollisionShape2D();
        collisionShape.Name = "CollisionShape";
        
        var rectangleShape = new RectangleShape2D();
        rectangleShape.Size = size;
        collisionShape.Shape = rectangleShape;
        
        area.AddChild(collisionShape);
        
        // Register object
        CreatedObjects[name] = area;
        
        return area;
    }
```

Creates a rectangular collision object

**Returns:** `CollisionObject2D`

**Parameters:**
- `string name`
- `Vector2 size`
- `Vector2 position`
- `uint collisionLayer`
- `uint collisionMask`

### CreateCircleCollisionObject

```csharp
/// <summary>
    /// Creates a circular collision object
    /// </summary>
    /// <param name="name">Name of the collision object</param>
    /// <param name="radius">Radius of the circle</param>
    /// <param name="position">Position of the object</param>
    /// <param name="collisionLayer">Collision layer</param>
    /// <param name="collisionMask">Collision mask</param>
    /// <returns>Created circular collision object</returns>
    public CollisionObject2D CreateCircleCollisionObject(
        string name, 
        float radius, 
        Vector2 position = default,
        uint collisionLayer = 1,
        uint collisionMask = 1)
    {
        var area = new Area2D();
        area.Name = name;
        area.Position = position;
        area.CollisionLayer = collisionLayer;
        area.CollisionMask = collisionMask;
        
        var collisionShape = new CollisionShape2D();
        collisionShape.Name = "CollisionShape";
        
        var circleShape = new CircleShape2D();
        circleShape.Radius = radius;
        collisionShape.Shape = circleShape;
        
        area.AddChild(collisionShape);
        
        // Register object
        CreatedObjects[name] = area;
        
        return area;
    }
```

Creates a circular collision object

**Returns:** `CollisionObject2D`

**Parameters:**
- `string name`
- `float radius`
- `Vector2 position`
- `uint collisionLayer`
- `uint collisionMask`

### CreateCapsuleCollisionObject

```csharp
/// <summary>
    /// Creates a capsule collision object
    /// </summary>
    /// <param name="name">Name of the collision object</param>
    /// <param name="height">Height of the capsule</param>
    /// <param name="radius">Radius of the capsule ends</param>
    /// <param name="position">Position of the object</param>
    /// <param name="collisionLayer">Collision layer</param>
    /// <param name="collisionMask">Collision mask</param>
    /// <returns>Created capsule collision object</returns>
    public CollisionObject2D CreateCapsuleCollisionObject(
        string name, 
        float height, 
        float radius, 
        Vector2 position = default,
        uint collisionLayer = 1,
        uint collisionMask = 1)
    {
        var area = new Area2D();
        area.Name = name;
        area.Position = position;
        area.CollisionLayer = collisionLayer;
        area.CollisionMask = collisionMask;
        
        var collisionShape = new CollisionShape2D();
        collisionShape.Name = "CollisionShape";
        
        var capsuleShape = new CapsuleShape2D();
        capsuleShape.Height = height;
        capsuleShape.Radius = radius;
        collisionShape.Shape = capsuleShape;
        
        area.AddChild(collisionShape);
        
        // Register object
        CreatedObjects[name] = area;
        
        return area;
    }
```

Creates a capsule collision object

**Returns:** `CollisionObject2D`

**Parameters:**
- `string name`
- `float height`
- `float radius`
- `Vector2 position`
- `uint collisionLayer`
- `uint collisionMask`

### CreatePolygonCollisionObject

```csharp
/// <summary>
    /// Creates a polygon collision object
    /// </summary>
    /// <param name="name">Name of the collision object</param>
    /// <param name="points">Polygon points (relative to object center)</param>
    /// <param name="position">Position of the object</param>
    /// <param name="collisionLayer">Collision layer</param>
    /// <param name="collisionMask">Collision mask</param>
    /// <returns>Created polygon collision object</returns>
    public CollisionObject2D CreatePolygonCollisionObject(
        string name, 
        Vector2[] points, 
        Vector2 position = default,
        uint collisionLayer = 1,
        uint collisionMask = 1)
    {
        var area = new Area2D();
        area.Name = name;
        area.Position = position;
        area.CollisionLayer = collisionLayer;
        area.CollisionMask = collisionMask;
        
        var collisionShape = new CollisionShape2D();
        collisionShape.Name = "CollisionShape";
        
        var polygonShape = new ConvexPolygonShape2D();
        polygonShape.Points = points;
        collisionShape.Shape = polygonShape;
        
        area.AddChild(collisionShape);
        
        // Register object
        CreatedObjects[name] = area;
        
        return area;
    }
```

Creates a polygon collision object

**Returns:** `CollisionObject2D`

**Parameters:**
- `string name`
- `Vector2[] points`
- `Vector2 position`
- `uint collisionLayer`
- `uint collisionMask`

### CreateWorldBoundaryCollisionObject

```csharp
/// <summary>
    /// Creates a world boundary collision object (static body)
    /// </summary>
    /// <param name="name">Name of the collision object</param>
    /// <param name="size">Size of the boundary</param>
    /// <param name="position">Position of the object</param>
    /// <param name="collisionLayer">Collision layer</param>
    /// <param name="collisionMask">Collision mask</param>
    /// <returns>Created world boundary collision object</returns>
    public CollisionObject2D CreateWorldBoundaryCollisionObject(
        string name, 
        Vector2 size, 
        Vector2 position = default,
        uint collisionLayer = 2,
        uint collisionMask = 1)
    {
        var staticBody = new StaticBody2D();
        staticBody.Name = name;
        staticBody.Position = position;
        staticBody.CollisionLayer = collisionLayer;
        staticBody.CollisionMask = collisionMask;
        
        var collisionShape = new CollisionShape2D();
        collisionShape.Name = "CollisionShape";
        
        var rectangleShape = new RectangleShape2D();
        rectangleShape.Size = size;
        collisionShape.Shape = rectangleShape;
        
        staticBody.AddChild(collisionShape);
        
        // Register object
        CreatedObjects[name] = staticBody;
        
        return staticBody;
    }
```

Creates a world boundary collision object (static body)

**Returns:** `CollisionObject2D`

**Parameters:**
- `string name`
- `Vector2 size`
- `Vector2 position`
- `uint collisionLayer`
- `uint collisionMask`

### CreateStandardTestSet

```csharp
#endregion
    
    #region Preset Creation Methods
    
    /// <summary>
    /// Creates a standard set of test collision objects
    /// </summary>
    /// <param name="prefix">Prefix for object names</param>
    /// <param name="basePosition">Base position for objects</param>
    /// <returns>List of created collision objects</returns>
    public List<CollisionObject2D> CreateStandardTestSet(string prefix = "Test", Vector2 basePosition = default)
    {
        var objects = new List<CollisionObject2D>();
        
        // Small rectangle
        var smallRect = CreateRectangleCollisionObject(
            $"{prefix}_SmallRect", 
            new Vector2(16, 16), 
            basePosition + new Vector2(0, 0));
        objects.Add(smallRect);
        
        // Medium rectangle
        var mediumRect = CreateRectangleCollisionObject(
            $"{prefix}_MediumRect", 
            new Vector2(32, 32), 
            basePosition + new Vector2(50, 0));
        objects.Add(mediumRect);
        
        // Large rectangle
        var largeRect = CreateRectangleCollisionObject(
            $"{prefix}_LargeRect", 
            new Vector2(64, 64), 
            basePosition + new Vector2(120, 0));
        objects.Add(largeRect);
        
        // Small circle
        var smallCircle = CreateCircleCollisionObject(
            $"{prefix}_SmallCircle", 
            8.0f, 
            basePosition + new Vector2(0, 80));
        objects.Add(smallCircle);
        
        // Medium circle
        var mediumCircle = CreateCircleCollisionObject(
            $"{prefix}_MediumCircle", 
            16.0f, 
            basePosition + new Vector2(50, 80));
        objects.Add(mediumCircle);
        
        // Large circle
        var largeCircle = CreateCircleCollisionObject(
            $"{prefix}_LargeCircle", 
            32.0f, 
            basePosition + new Vector2(120, 80));
        objects.Add(largeCircle);
        
        // Capsule
        var capsule = CreateCapsuleCollisionObject(
            $"{prefix}_Capsule", 
            40.0f, 
            12.0f, 
            basePosition + new Vector2(200, 40));
        objects.Add(capsule);
        
        // Triangle polygon
        var trianglePoints = new Vector2[]
        {
            new Vector2(0, -20),
            new Vector2(20, 20),
            new Vector2(-20, 20)
        };
        var triangle = CreatePolygonCollisionObject(
            $"{prefix}_Triangle", 
            trianglePoints, 
            basePosition + new Vector2(250, 40));
        objects.Add(triangle);
        
        // Pentagon polygon
        var pentagonPoints = CreateRegularPolygonPoints(5, 20.0f);
        var pentagon = CreatePolygonCollisionObject(
            $"{prefix}_Pentagon", 
            pentagonPoints, 
            basePosition + new Vector2(300, 40));
        objects.Add(pentagon);
        
        return objects;
    }
```

Creates a standard set of test collision objects

**Returns:** `List<CollisionObject2D>`

**Parameters:**
- `string prefix`
- `Vector2 basePosition`

### CreateCollisionTestGrid

```csharp
/// <summary>
    /// Creates a collision test grid
    /// </summary>
    /// <param name="gridSize">Size of the grid (number of objects)</param>
    /// <param name="spacing">Spacing between objects</param>
    /// <param name="objectSize">Size of each object</param>
    /// <param name="basePosition">Base position for the grid</param>
    /// <returns>List of created collision objects</returns>
    public List<CollisionObject2D> CreateCollisionTestGrid(
        Vector2I gridSize, 
        float spacing = 50.0f, 
        float objectSize = 20.0f, 
        Vector2 basePosition = default)
    {
        var objects = new List<CollisionObject2D>();
        
        for (int x = 0; x < gridSize.X; x++)
        {
            for (int y = 0; y < gridSize.Y; y++)
            {
                var position = basePosition + new Vector2(x * spacing, y * spacing);
                var name = $"Grid_{x}_{y}";
                
                // Alternate between different shapes
                CollisionObject2D obj;
                if ((x + y) % 3 == 0)
                {
                    obj = CreateRectangleCollisionObject(name, new Vector2(objectSize, objectSize), position);
                }
                else if ((x + y) % 3 == 1)
                {
                    obj = CreateCircleCollisionObject(name, objectSize * 0.5f, position);
                }
                else
                {
                    obj = CreateCapsuleCollisionObject(name, objectSize, objectSize * 0.3f, position);
                }
                
                objects.Add(obj);
            }
        }
        
        return objects;
    }
```

Creates a collision test grid

**Returns:** `List<CollisionObject2D>`

**Parameters:**
- `Vector2I gridSize`
- `float spacing`
- `float objectSize`
- `Vector2 basePosition`

### CreateComplexScenario

```csharp
/// <summary>
    /// Creates a complex collision scenario
    /// </summary>
    /// <param name="scenarioType">Type of scenario to create</param>
    /// <param name="basePosition">Base position for the scenario</param>
    /// <returns>List of created collision objects</returns>
    public List<CollisionObject2D> CreateComplexScenario(ComplexScenarioType scenarioType, Vector2 basePosition = default)
    {
        var objects = new List<CollisionObject2D>();
        
        switch (scenarioType)
        {
            case ComplexScenarioType.Maze:
                objects.AddRange(CreateMazeScenario(basePosition));
                break;
            case ComplexScenarioType.ObstacleCourse:
                objects.AddRange(CreateObstacleCourseScenario(basePosition));
                break;
            case ComplexScenarioType.DensePacking:
                objects.AddRange(CreateDensePackingScenario(basePosition));
                break;
            case ComplexScenarioType.MixedShapes:
                objects.AddRange(CreateMixedShapesScenario(basePosition));
                break;
        }
        
        return objects;
    }
```

Creates a complex collision scenario

**Returns:** `List<CollisionObject2D>`

**Parameters:**
- `ComplexScenarioType scenarioType`
- `Vector2 basePosition`

### GetCollisionObject

```csharp
/// <summary>
    /// Gets a collision object by name
    /// </summary>
    /// <param name="name">Name of the object</param>
    /// <returns>Collision object if found, null otherwise</returns>
    public CollisionObject2D? GetCollisionObject(string name)
    {
        return CreatedObjects.TryGetValue(name, out var obj) ? obj : null;
    }
```

Gets a collision object by name

**Returns:** `CollisionObject2D?`

**Parameters:**
- `string name`

### RemoveCollisionObject

```csharp
/// <summary>
    /// Removes a collision object
    /// </summary>
    /// <param name="name">Name of the object to remove</param>
    /// <returns>True if object was removed</returns>
    public bool RemoveCollisionObject(string name)
    {
        if (CreatedObjects.TryGetValue(name, out var obj))
        {
            obj.QueueFree();
            CreatedObjects.Remove(name);
            return true;
        }
        return false;
    }
```

Removes a collision object

**Returns:** `bool`

**Parameters:**
- `string name`

### ClearAllCollisionObjects

```csharp
/// <summary>
    /// Clears all created collision objects
    /// </summary>
    public void ClearAllCollisionObjects()
    {
        var objectNames = new List<string>(CreatedObjects.Keys);
        foreach (var name in objectNames)
        {
            RemoveCollisionObject(name);
        }
    }
```

Clears all created collision objects

**Returns:** `void`

### GetStatistics

```csharp
/// <summary>
    /// Gets statistics about created objects
    /// </summary>
    /// <returns>Collision object statistics</returns>
    public CollisionObjectStatistics GetStatistics()
    {
        var stats = new CollisionObjectStatistics();
        
        foreach (var obj in CreatedObjects.Values)
        {
            stats.TotalObjects++;
            
            if (obj is Area2D)
                stats.AreaObjects++;
            else if (obj is StaticBody2D)
                stats.StaticBodyObjects++;
            
            var shapes = obj.GetChildren();
            foreach (var child in shapes)
            {
                if (child is CollisionShape2D collisionShape)
                {
                    stats.TotalShapes++;
                    
                    if (collisionShape.Shape is RectangleShape2D)
                        stats.RectangleShapes++;
                    else if (collisionShape.Shape is CircleShape2D)
                        stats.CircleShapes++;
                    else if (collisionShape.Shape is CapsuleShape2D)
                        stats.CapsuleShapes++;
                    else if (collisionShape.Shape is ConvexPolygonShape2D)
                        stats.PolygonShapes++;
                }
            }
        }
        
        return stats;
    }
```

Gets statistics about created objects

**Returns:** `CollisionObjectStatistics`

