---
title: "CollisionObjectResolver"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/collisionobjectresolver/"
---

# CollisionObjectResolver

```csharp
GridBuilding.Godot.Shared.Utils.Collision
class CollisionObjectResolver
{
    // Members...
}
```

Collision object resolver for determining collision object types and properties.
Provides utilities for:
- Determining collision object types (CollisionObject2D vs CollisionPolygon2D)
- Extracting collision shapes and properties
- Validating collision object configurations

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/CollisionObjectResolver.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Collision`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetCollisionObjectType

```csharp
/// <summary>
    /// Determines the type of collision object.
    /// </summary>
    /// <param name="node">Node to check</param>
    /// <returns>Collision object type</returns>
    public static CollisionObjectType GetCollisionObjectType(Node node)
    {
        if (node is CollisionPolygon2D)
            return CollisionObjectType.CollisionPolygon2D;
        else if (node is CollisionObject2D)
            return CollisionObjectType.CollisionObject2D;
        else
            return CollisionObjectType.None;
    }
```

Determines the type of collision object.

**Returns:** `CollisionObjectType`

**Parameters:**
- `Node node`

### GetCollisionShapes

```csharp
/// <summary>
    /// Gets all collision shapes from a CollisionObject2D.
    /// </summary>
    /// <param name="collisionObject">The collision object to examine</param>
    /// <returns>List of collision shape owners</returns>
    public static List<CollisionShapeOwner> GetCollisionShapes(CollisionObject2D collisionObject)
    {
        var shapes = new List<CollisionShapeOwner>();
        
        if (collisionObject == null)
            return shapes;

        // Get all shape owners
        for (int i = 0; i < collisionObject.GetShapeOwnerCount(); i++)
        {
            var ownerId = collisionObject.GetShapeOwnerId(i);
            var shapeOwner = new CollisionShapeOwner
            {
                OwnerId = ownerId,
                OwnerNode = collisionObject.ShapeOwnerGetOwner(ownerId),
                Transform = collisionObject.ShapeOwnerGetTransform(ownerId),
                Shapes = new List<CollisionShapeInfo>()
            };

            // Get all shapes for this owner
            for (int j = 0; j < collisionObject.ShapeOwnerGetShapeCount(ownerId); j++)
            {
                var shapeId = collisionObject.ShapeOwnerGetShapeId(ownerId, j);
                var shape = collisionObject.ShapeOwnerGetShape(ownerId, j);
                var shapeTransform = collisionObject.ShapeOwnerGetShapeTransform(ownerId, j);

                shapeOwner.Shapes.Add(new CollisionShapeInfo
                {
                    ShapeId = shapeId,
                    Shape = shape,
                    Transform = shapeTransform,
                    Disabled = collisionObject.ShapeOwnerIsShapeDisabled(ownerId, j)
                });
            }

            shapes.Add(shapeOwner);
        }

        return shapes;
    }
```

Gets all collision shapes from a CollisionObject2D.

**Returns:** `List<CollisionShapeOwner>`

**Parameters:**
- `CollisionObject2D collisionObject`

### GetCollisionPolygon

```csharp
/// <summary>
    /// Gets the polygon from a CollisionPolygon2D.
    /// </summary>
    /// <param name="collisionPolygon">The collision polygon</param>
    /// <returns>Polygon vertices in world coordinates</returns>
    public static Vector2[] GetCollisionPolygon(CollisionPolygon2D collisionPolygon)
    {
        if (collisionPolygon == null)
            return Array.Empty<Vector2>();

        var localPolygon = collisionPolygon.Polygon;
        var worldPolygon = new Vector2[localPolygon.Length];
        var transform = collisionPolygon.GlobalTransform;

        for (int i = 0; i < localPolygon.Length; i++)
        {
            worldPolygon[i] = transform * localPolygon[i];
        }

        return worldPolygon;
    }
```

Gets the polygon from a CollisionPolygon2D.

**Returns:** `Vector2[]`

**Parameters:**
- `CollisionPolygon2D collisionPolygon`

### ValidateCollisionObject

```csharp
/// <summary>
    /// Validates a collision object for placement operations.
    /// </summary>
    /// <param name="node">Node to validate</param>
    /// <returns>List of validation issues</returns>
    public static List<string> ValidateCollisionObject(Node node)
    {
        var issues = new List<string>();

        if (node == null)
        {
            issues.Add("Collision object is null");
            return issues;
        }

        var collisionType = GetCollisionObjectType(node);
        
        switch (collisionType)
        {
            case CollisionObjectType.None:
                issues.Add($"Node {node.Name} is not a collision object");
                break;
                
            case CollisionObjectType.CollisionObject2D:
                var collisionObj = node as CollisionObject2D;
                if (collisionObj.GetShapeOwnerCount() == 0)
                {
                    issues.Add($"CollisionObject2D {node.Name} has no shape owners");
                }
                break;
                
            case CollisionObjectType.CollisionPolygon2D:
                var collisionPoly = node as CollisionPolygon2D;
                if (collisionPoly.Polygon.Length < 3)
                {
                    issues.Add($"CollisionPolygon2D {node.Name} has less than 3 vertices");
                }
                break;
        }

        return issues;
    }
```

Validates a collision object for placement operations.

**Returns:** `List<string>`

**Parameters:**
- `Node node`

### GetEffectiveCollisionShape

```csharp
/// <summary>
    /// Gets the effective collision shape for a node.
    /// For CollisionObject2D, returns the combined bounds of all shapes.
    /// For CollisionPolygon2D, returns the polygon itself.
    /// </summary>
    /// <param name="node">Collision node</param>
    /// <returns>Effective collision shape</returns>
    public static EffectiveCollisionShape GetEffectiveCollisionShape(Node node)
    {
        var collisionType = GetCollisionObjectType(node);
        
        switch (collisionType)
        {
            case CollisionObjectType.CollisionObject2D:
                return GetEffectiveShapeForCollisionObject(node as CollisionObject2D);
                
            case CollisionObjectType.CollisionPolygon2D:
                return GetEffectiveShapeForCollisionPolygon(node as CollisionPolygon2D);
                
            default:
                return new EffectiveCollisionShape { Type = EffectiveShapeType.None };
        }
    }
```

Gets the effective collision shape for a node.
For CollisionObject2D, returns the combined bounds of all shapes.
For CollisionPolygon2D, returns the polygon itself.

**Returns:** `EffectiveCollisionShape`

**Parameters:**
- `Node node`

