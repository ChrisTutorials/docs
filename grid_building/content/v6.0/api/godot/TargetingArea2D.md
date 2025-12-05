---
title: "TargetingArea2D"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/targetingarea2d/"
---

# TargetingArea2D

```csharp
GridBuilding.Godot.Targeting
class TargetingArea2D
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Targeting/TargetingArea2D.cs`  
**Namespace:** `GridBuilding.Godot.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Mode

```csharp
[Export] public TargetingMode Mode 
        { 
            get => _mode; 
            set => SetTargetingMode(value);
        }
```

### Filter

```csharp
[Export] public TargetFilter Filter 
        { 
            get => _filter; 
            set => SetTargetFilter(value);
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

### UpdateInterval

```csharp
[Export] public float UpdateInterval 
        { 
            get => _updateInterval; 
            set => SetUpdateInterval(value);
        }
```

### AreaRadius

```csharp
[ExportGroup("Area Settings")]
        [Export] public float AreaRadius { get; set; } = 100.0f;
```

### AreaSize

```csharp
[Export] public Vector2 AreaSize { get; set; } = new Vector2(200.0f, 200.0f);
```

### LineLength

```csharp
[Export] public float LineLength { get; set; } = 300.0f;
```

### LineWidth

```csharp
[Export] public float LineWidth { get; set; } = 20.0f;
```

### ConeLength

```csharp
[Export] public float ConeLength { get; set; } = 200.0f;
```

### ConeAngle

```csharp
[Export] public float ConeAngle { get; set; } = 45.0f;
```

### TargetGroups

```csharp
[ExportGroup("Filter Settings")]
        [Export] public string[] TargetGroups { get; set; } = new string[0];
```

### ExcludedGroups

```csharp
[Export] public string[] ExcludedGroups { get; set; } = new string[0];
```

### RequireLineOfSight

```csharp
[Export] public bool RequireLineOfSight { get; set; } = true;
```

### MaxTargetDistance

```csharp
[Export] public float MaxTargetDistance { get; set; } = 500.0f;
```

### CurrentTargets

```csharp
public List<Node2D> CurrentTargets => new List<Node2D>(_currentTargets);
```

### TargetCount

```csharp
public int TargetCount => _currentTargets.Count;
```

### HasTargets

```csharp
public bool HasTargets => _currentTargets.Count > 0;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            _currentTargets = new List<Node2D>();
            _previousTargets = new List<Node2D>();
            
            SetupAreaShape();
            SetupCollisionLayers();
            
            // Connect signals
            BodyEntered += OnTargetEntered;
            BodyExited += OnTargetExited;
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
                _lastUpdateTime += delta;
                if (_lastUpdateTime >= _updateInterval)
                {
                    UpdateTargets();
                    _lastUpdateTime = 0.0;
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### UpdateTargets

```csharp
/// <summary>
        /// Updates the current targets list
        /// </summary>
        public void UpdateTargets()
        {
            _previousTargets = new List<Node2D>(_currentTargets);
            _currentTargets.Clear();
            
            // Get all overlapping bodies
            var overlappingBodies = GetOverlappingBodies();
            
            foreach (var body in overlappingBodies)
            {
                if (body is Node2D target && IsValidTarget(target))
                {
                    _currentTargets.Add(target);
                }
            }
            
            // Check for changes
            CheckTargetChanges();
            
            if (_previousTargets.Count != _currentTargets.Count)
            {
                EmitSignal(SignalName.TargetsUpdated, new List<Node2D>(_currentTargets));
            }
        }
```

Updates the current targets list

**Returns:** `void`

### SetTargetingMode

```csharp
/// <summary>
        /// Sets the targeting mode
        /// </summary>
        /// <param name="mode">New targeting mode</param>
        public void SetTargetingMode(TargetingMode mode)
        {
            if (_mode == mode)
                return;
                
            _mode = mode;
            UpdateAreaShape();
            UpdateTargets();
            
            EmitSignal(SignalName.TargetingModeChanged, mode);
        }
```

Sets the targeting mode

**Returns:** `void`

**Parameters:**
- `TargetingMode mode`

### SetTargetFilter

```csharp
/// <summary>
        /// Sets the target filter
        /// </summary>
        /// <param name="filter">New target filter</param>
        public void SetTargetFilter(TargetFilter filter)
        {
            if (_filter == filter)
                return;
                
            _filter = filter;
            UpdateTargets();
        }
```

Sets the target filter

**Returns:** `void`

**Parameters:**
- `TargetFilter filter`

### SetAutoUpdate

```csharp
/// <summary>
        /// Sets whether to auto-update targets
        /// </summary>
        /// <param name="autoUpdate">Whether to auto-update</param>
        public void SetAutoUpdate(bool autoUpdate)
        {
            _autoUpdate = autoUpdate;
        }
```

Sets whether to auto-update targets

**Returns:** `void`

**Parameters:**
- `bool autoUpdate`

### SetUpdateInterval

```csharp
/// <summary>
        /// Sets the update interval
        /// </summary>
        /// <param name="interval">New update interval</param>
        public void SetUpdateInterval(float interval)
        {
            _updateInterval = Mathf.Max(0.01f, interval);
        }
```

Sets the update interval

**Returns:** `void`

**Parameters:**
- `float interval`

### GetClosestTarget

```csharp
/// <summary>
        /// Gets the closest target
        /// </summary>
        /// <returns>Closest target or null</returns>
        public Node2D GetClosestTarget()
        {
            Node2D closest = null;
            var closestDistance = float.MaxValue;
            
            foreach (var target in _currentTargets)
            {
                var distance = GlobalPosition.DistanceTo(target.GlobalPosition);
                if (distance < closestDistance)
                {
                    closest = target;
                    closestDistance = distance;
                }
            }
            
            return closest;
        }
```

Gets the closest target

**Returns:** `Node2D`

### GetTargetsByDistance

```csharp
/// <summary>
        /// Gets targets sorted by distance
        /// </summary>
        /// <returns>Targets sorted by distance (closest first)</returns>
        public List<Node2D> GetTargetsByDistance()
        {
            var sortedTargets = new List<Node2D>(_currentTargets);
            sortedTargets.Sort((a, b) => 
                GlobalPosition.DistanceTo(a.GlobalPosition).CompareTo(
                    GlobalPosition.DistanceTo(b.GlobalPosition)));
            
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
            
            foreach (var target in _currentTargets)
            {
                var distance = GlobalPosition.DistanceTo(target.GlobalPosition);
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

### ClearTargets

```csharp
/// <summary>
        /// Clears all current targets
        /// </summary>
        public void ClearTargets()
        {
            var clearedTargets = new List<Node2D>(_currentTargets);
            _currentTargets.Clear();
            
            foreach (var target in clearedTargets)
            {
                EmitSignal(SignalName.TargetAreaExited, target);
            }
            
            EmitSignal(SignalName.TargetsUpdated, new List<Node2D>());
        }
```

Clears all current targets

**Returns:** `void`

### GetTargetingInfo

```csharp
/// <summary>
        /// Gets targeting information
        /// </summary>
        /// <returns>Targeting information dictionary</returns>
        public Dictionary<string, Variant> GetTargetingInfo()
        {
            var info = new Dictionary<string, Variant>
            {
                ["mode"] = (int)_mode,
                ["filter"] = (int)_filter,
                ["target_count"] = _currentTargets.Count,
                ["has_targets"] = HasTargets,
                ["position"] = GlobalPosition,
                ["area_radius"] = AreaRadius,
                ["max_target_distance"] = MaxTargetDistance,
                ["auto_update"] = _autoUpdate,
                ["update_interval"] = _updateInterval
            };
            
            if (HasTargets)
            {
                info["closest_target_distance"] = GlobalPosition.DistanceTo(GetClosestTarget().GlobalPosition);
            }
            
            return info;
        }
```

Gets targeting information

**Returns:** `Dictionary<string, Variant>`

