---
title: "TargetingShapeCast2D"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/targetingshapecast2d/"
---

# TargetingShapeCast2D

```csharp
GridBuilding.Godot.Targeting
class TargetingShapeCast2D
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Targeting/TargetingShapeCast2D.cs`  
**Namespace:** `GridBuilding.Godot.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CastShape

```csharp
[Export] public Shape2D CastShape 
        { 
            get => _castShape; 
            set => SetCastShape(value);
        }
```

### CastDistance

```csharp
[Export] public float CastDistance 
        { 
            get => _castDistance; 
            set => SetCastDistance(value);
        }
```

### AutoUpdate

```csharp
[Export] public bool AutoUpdate 
        { 
            get => _autoUpdate; 
            set => SetAutoUpdate(value);
        }
```

### ExcludeParent

```csharp
[Export] public bool ExcludeParent 
        { 
            get => _excludeParent; 
            set => SetExcludeParent(value);
        }
```

### CollisionMask

```csharp
[ExportGroup("Collision Settings")]
        [Export] public int[] CollisionMask 
        { 
            get => _collisionMask; 
            set => SetCollisionMask(value);
        }
```

### CollideWithAreas

```csharp
[Export] public bool CollideWithAreas { get; set; } = true;
```

### CollideWithBodies

```csharp
[Export] public bool CollideWithBodies { get; set; } = true;
```

### MaxResults

```csharp
[Export] public int MaxResults { get; set; } = 32;
```

### LastHitTargets

```csharp
public List<Node2D> LastHitTargets { get; private set; }
```

### LastHitPositions

```csharp
public Dictionary<Node2D, Vector2> LastHitPositions { get; private set; }
```

### IsCasting

```csharp
public bool IsCasting { get; private set; }
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            _spaceState = GetWorld2D().DirectSpaceState;
            LastHitTargets = new List<Node2D>();
            LastHitPositions = new Dictionary<Node2D, Vector2>();
            
            // Initialize with default shape if none set
            if (_castShape == null)
            {
                _castShape = new CircleShape2D();
                _castShape.Radius = 50.0f;
            }
            
            SetupQueryParameters();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            base._Process(delta);
            
            if (_autoUpdate)
            {
                PerformShapeCast(GlobalPosition, GlobalPosition + Vector2.Up * _castDistance);
            }
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### PerformShapeCast

```csharp
/// <summary>
        /// Performs a shape cast from start to end position
        /// </summary>
        /// <param name="startPosition">Start position</param>
        /// <param name="endPosition">End position</param>
        /// <returns>True if cast was successful</returns>
        public bool PerformShapeCast(Vector2 startPosition, Vector2 endPosition)
        {
            if (_castShape == null || _spaceState == null)
            {
                EmitSignal(SignalName.ShapeCastFailed, "Shape or space state not initialized");
                return false;
            }
            
            IsCasting = true;
            
            // Update query parameters
            _queryParameters.Shape = _castShape;
            _queryParameters.Transform = new Transform2D(0.0f, startPosition);
            _queryParameters.CollisionMask = GetCollisionMaskValue();
            
            // Perform the shape cast
            var results = _spaceState.IntersectShape(_queryParameters);
            
            // Process results
            var hitTargets = new List<Node2D>();
            var hitPositions = new Dictionary<Node2D, Vector2>();
            
            foreach (var result in results)
            {
                var collider = result["collider"].AsGodotObject() as Node2D;
                var position = result["position"].AsVector2();
                
                if (collider != null)
                {
                    hitTargets.Add(collider);
                    hitPositions[collider] = position;
                }
            }
            
            // Filter results by distance
            var filteredTargets = new List<Node2D>();
            var filteredPositions = new Dictionary<Node2D, Vector2>();
            
            foreach (var target in hitTargets)
            {
                var distance = startPosition.DistanceTo(hitPositions[target]);
                if (distance <= _castDistance)
                {
                    filteredTargets.Add(target);
                    filteredPositions[target] = hitPositions[target];
                }
            }
            
            // Update last results
            LastHitTargets = filteredTargets;
            LastHitPositions = filteredPositions;
            
            IsCasting = false;
            
            if (filteredTargets.Count > 0)
            {
                EmitSignal(SignalName.ShapeCastCompleted, filteredTargets, filteredPositions);
                return true;
            }
            else
            {
                EmitSignal(SignalName.ShapeCastFailed, "No targets hit");
                return false;
            }
        }
```

Performs a shape cast from start to end position

**Returns:** `bool`

**Parameters:**
- `Vector2 startPosition`
- `Vector2 endPosition`

### PerformShapeCastDirection

```csharp
/// <summary>
        /// Performs a shape cast in a direction
        /// </summary>
        /// <param name="startPosition">Start position</param>
        /// <param name="direction">Direction to cast</param>
        /// <returns>True if cast was successful</returns>
        public bool PerformShapeCastDirection(Vector2 startPosition, Vector2 direction)
        {
            var endPosition = startPosition + direction.Normalized() * _castDistance;
            return PerformShapeCast(startPosition, endPosition);
        }
```

Performs a shape cast in a direction

**Returns:** `bool`

**Parameters:**
- `Vector2 startPosition`
- `Vector2 direction`

### PerformShapeCastArc

```csharp
/// <summary>
        /// Performs a shape cast in an arc
        /// </summary>
        /// <param name="startPosition">Start position</param>
        /// <param name="centerDirection">Center direction of arc</param>
        /// <param name="arcAngle">Arc angle in radians</param>
        /// <param name="numRays">Number of rays to cast</param>
        /// <returns>List of all hit targets</returns>
        public List<Node2D> PerformShapeCastArc(Vector2 startPosition, Vector2 centerDirection, float arcAngle, int numRays = 8)
        {
            var allTargets = new List<Node2D>();
            var allPositions = new Dictionary<Node2D, Vector2>();
            
            var startAngle = centerDirection.Angle() - arcAngle / 2.0f;
            var angleStep = arcAngle / (numRays - 1);
            
            for (int i = 0; i < numRays; i++)
            {
                var angle = startAngle + angleStep * i;
                var direction = new Vector2(Mathf.Cos(angle), Mathf.Sin(angle));
                
                PerformShapeCastDirection(startPosition, direction);
                
                // Add results to combined list
                foreach (var target in LastHitTargets)
                {
                    if (!allTargets.Contains(target))
                    {
                        allTargets.Add(target);
                        allPositions[target] = LastHitPositions[target];
                    }
                }
            }
            
            // Update last results with combined results
            LastHitTargets = allTargets;
            LastHitPositions = allPositions;
            
            return allTargets;
        }
```

Performs a shape cast in an arc

**Returns:** `List<Node2D>`

**Parameters:**
- `Vector2 startPosition`
- `Vector2 centerDirection`
- `float arcAngle`
- `int numRays`

### PerformShapeCastCircle

```csharp
/// <summary>
        /// Performs a shape cast in a circle
        /// </summary>
        /// <param name="centerPosition">Center position</param>
        /// <param name="radius">Radius of circle</param>
        /// <param name="numRays">Number of rays to cast</param>
        /// <returns>List of all hit targets</returns>
        public List<Node2D> PerformShapeCastCircle(Vector2 centerPosition, float radius, int numRays = 16)
        {
            var allTargets = new List<Node2D>();
            var allPositions = new Dictionary<Node2D, Vector2>();
            
            for (int i = 0; i < numRays; i++)
            {
                var angle = (float)i / numRays * 2.0f * Mathf.Pi;
                var direction = new Vector2(Mathf.Cos(angle), Mathf.Sin(angle));
                
                PerformShapeCastDirection(centerPosition, direction);
                
                // Add results to combined list
                foreach (var target in LastHitTargets)
                {
                    if (!allTargets.Contains(target))
                    {
                        allTargets.Add(target);
                        allPositions[target] = LastHitPositions[target];
                    }
                }
            }
            
            // Update last results with combined results
            LastHitTargets = allTargets;
            LastHitPositions = allPositions;
            
            return allTargets;
        }
```

Performs a shape cast in a circle

**Returns:** `List<Node2D>`

**Parameters:**
- `Vector2 centerPosition`
- `float radius`
- `int numRays`

### GetClosestTarget

```csharp
/// <summary>
        /// Gets the closest target from the last cast
        /// </summary>
        /// <returns>Closest target or null</returns>
        public Node2D GetClosestTarget()
        {
            if (LastHitTargets.Count == 0)
                return null;
                
            Node2D closest = null;
            var closestDistance = float.MaxValue;
            
            foreach (var target in LastHitTargets)
            {
                var distance = GlobalPosition.DistanceTo(LastHitPositions[target]);
                if (distance < closestDistance)
                {
                    closest = target;
                    closestDistance = distance;
                }
            }
            
            return closest;
        }
```

Gets the closest target from the last cast

**Returns:** `Node2D`

### GetTargetsByDistance

```csharp
/// <summary>
        /// Gets targets sorted by distance
        /// </summary>
        /// <returns>Targets sorted by distance (closest first)</returns>
        public List<Node2D> GetTargetsByDistance()
        {
            var sortedTargets = new List<Node2D>(LastHitTargets);
            sortedTargets.Sort((a, b) => 
                GlobalPosition.DistanceTo(LastHitPositions[a]).CompareTo(
                GlobalPosition.DistanceTo(LastHitPositions[b])));
            
            return sortedTargets;
        }
```

Gets targets sorted by distance

**Returns:** `List<Node2D>`

### GetTargetsInRange

```csharp
/// <summary>
        /// Gets targets within a specific range
        /// </summary>
        /// <param name="range">Maximum range</param>
        /// <returns>Targets within range</returns>
        public List<Node2D> GetTargetsInRange(float range)
        {
            var targetsInRange = new List<Node2D>();
            
            foreach (var target in LastHitTargets)
            {
                var distance = GlobalPosition.DistanceTo(LastHitPositions[target]);
                if (distance <= range)
                {
                    targetsInRange.Add(target);
                }
            }
            
            return targetsInRange;
        }
```

Gets targets within a specific range

**Returns:** `List<Node2D>`

**Parameters:**
- `float range`

### IsTargetHit

```csharp
/// <summary>
        /// Checks if a specific target was hit
        /// </summary>
        /// <param name="target">Target to check</param>
        /// <returns>True if target was hit</returns>
        public bool IsTargetHit(Node2D target)
        {
            return LastHitTargets.Contains(target);
        }
```

Checks if a specific target was hit

**Returns:** `bool`

**Parameters:**
- `Node2D target`

### GetTargetHitPosition

```csharp
/// <summary>
        /// Gets the hit position for a specific target
        /// </summary>
        /// <param name="target">Target to get position for</param>
        /// <returns>Hit position or zero if not found</returns>
        public Vector2 GetTargetHitPosition(Node2D target)
        {
            return LastHitPositions.TryGetValue(target, out var position) ? position : Vector2.Zero;
        }
```

Gets the hit position for a specific target

**Returns:** `Vector2`

**Parameters:**
- `Node2D target`

### SetCastShape

```csharp
/// <summary>
        /// Sets the cast shape
        /// </summary>
        /// <param name="shape">New shape to cast</param>
        public void SetCastShape(Shape2D shape)
        {
            _castShape = shape;
            SetupQueryParameters();
        }
```

Sets the cast shape

**Returns:** `void`

**Parameters:**
- `Shape2D shape`

### SetCastDistance

```csharp
/// <summary>
        /// Sets the cast distance
        /// </summary>
        /// <param name="distance">New cast distance</param>
        public void SetCastDistance(float distance)
        {
            _castDistance = Mathf.Max(0.0f, distance);
        }
```

Sets the cast distance

**Returns:** `void`

**Parameters:**
- `float distance`

### SetAutoUpdate

```csharp
/// <summary>
        /// Sets whether to auto-update
        /// </summary>
        /// <param name="autoUpdate">Whether to auto-update</param>
        public void SetAutoUpdate(bool autoUpdate)
        {
            _autoUpdate = autoUpdate;
        }
```

Sets whether to auto-update

**Returns:** `void`

**Parameters:**
- `bool autoUpdate`

### SetExcludeParent

```csharp
/// <summary>
        /// Sets whether to exclude parent
        /// </summary>
        /// <param name="excludeParent">Whether to exclude parent</param>
        public void SetExcludeParent(bool excludeParent)
        {
            _excludeParent = excludeParent;
            SetupQueryParameters();
        }
```

Sets whether to exclude parent

**Returns:** `void`

**Parameters:**
- `bool excludeParent`

### SetCollisionMask

```csharp
/// <summary>
        /// Sets the collision mask
        /// </summary>
        /// <param name="mask">New collision mask</param>
        public void SetCollisionMask(int[] mask)
        {
            _collisionMask = mask;
            SetupQueryParameters();
        }
```

Sets the collision mask

**Returns:** `void`

**Parameters:**
- `int[] mask`

### ClearResults

```csharp
/// <summary>
        /// Clears the last cast results
        /// </summary>
        public void ClearResults()
        {
            LastHitTargets.Clear();
            LastHitPositions.Clear();
        }
```

Clears the last cast results

**Returns:** `void`

### GetShapeCastInfo

```csharp
/// <summary>
        /// Gets shape cast information
        /// </summary>
        /// <returns>Shape cast information dictionary</returns>
        public Dictionary<string, Variant> GetShapeCastInfo()
        {
            var info = new Dictionary<string, Variant>
            {
                ["cast_shape"] = _castShape?.GetClass() ?? "None",
                ["cast_distance"] = _castDistance,
                ["auto_update"] = _autoUpdate,
                ["exclude_parent"] = _excludeParent,
                ["collision_mask"] = GetCollisionMaskValue(),
                ["collide_with_areas"] = CollideWithAreas,
                ["collide_with_bodies"] = CollideWithBodies,
                ["max_results"] = MaxResults,
                ["is_casting"] = IsCasting,
                ["last_hit_count"] = LastHitTargets.Count,
                ["position"] = GlobalPosition
            };
            
            if (LastHitTargets.Count > 0)
            {
                info["closest_target_distance"] = GlobalPosition.DistanceTo(GetTargetHitPosition(GetClosestTarget()));
            }
            
            return info;
        }
```

Gets shape cast information

**Returns:** `Dictionary<string, Variant>`

