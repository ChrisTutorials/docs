---
title: "CollisionExclusionTestHelpers"
description: "C# implementation of collision exclusion utilities to match GDScript functionality"
weight: 20
url: "/gridbuilding/v6-0/api/godot/collisionexclusiontesthelpers/"
---

# CollisionExclusionTestHelpers

```csharp
GridBuilding.Godot.Tests.GoDotTest
class CollisionExclusionTestHelpers
{
    // Members...
}
```

C# implementation of collision exclusion utilities to match GDScript functionality

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/CollisionExclusionTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateCollisionBody

```csharp
public static CharacterBody2D CreateCollisionBody(
        Vector2 position, Vector2 size, int collisionLayer)
    {
        var body = new CharacterBody2D();
        body.Position = position;
        body.CollisionLayer = collisionLayer;
        body.CollisionMask = collisionLayer;

        var shape = new CollisionShape2D();
        var rectangleShape = new RectangleShape2D();
        rectangleShape.Size = size;
        shape.Shape = rectangleShape;
        
        body.AddChild(shape);
        return body;
    }
```

**Returns:** `CharacterBody2D`

**Parameters:**
- `Vector2 position`
- `Vector2 size`
- `int collisionLayer`

### SetupCollisionExclusionTest

```csharp
public static void SetupCollisionExclusionTest(
        CollisionTestEnvironment env,
        CollisionsCheckRule rule,
        int collisionMask = 1,
        int collisionLayer = 1,
        bool passOnCollision = false)
    {
        if (env == null)
            throw new ArgumentNullException(nameof(env));
        
        if (rule == null)
            throw new ArgumentNullException(nameof(rule));

        rule.CollisionMask = collisionMask;
        rule.PassOnCollision = passOnCollision;
        
        var setupIssues = rule.Setup(env.TargetingState);
        if (setupIssues.Count > 0)
        {
            throw new InvalidOperationException(
                $"Collision rule setup failed: {string.Join(", ", setupIssues)}");
        }
    }
```

**Returns:** `void`

**Parameters:**
- `CollisionTestEnvironment env`
- `CollisionsCheckRule rule`
- `int collisionMask`
- `int collisionLayer`
- `bool passOnCollision`

