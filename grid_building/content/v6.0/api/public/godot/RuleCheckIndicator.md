---
title: "RuleCheckIndicator"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/rulecheckindicator/"
---

# RuleCheckIndicator

```csharp
GridBuilding.Godot.Systems.Placement.Utilities
class RuleCheckIndicator
{
    // Members...
}
```

Tile indicator showing placement validity based on rules and collisions.
Ported from: godot/addons/grid_building/systems/placement/utilities/rule_check_indicator/rule_check_indicator.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Utilities/RuleCheckIndicator.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Utilities`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ValiditySprite

```csharp
[Export]
    public Sprite2D? ValiditySprite { get; set; }
```

### ShowIndicators

```csharp
[Export]
    public bool ShowIndicators
    {
        get => _showIndicators;
        set
        {
            if (_showIndicators == value) return;
            _showIndicators = value;
            if (_showIndicators)
                PropagateCall("show");
            else
                PropagateCall("hide");
        }
    }
```

### ValidSettings

```csharp
[Export]
    public IndicatorVisualSettings? ValidSettings { get; set; }
```

### InvalidSettings

```csharp
[Export]
    public IndicatorVisualSettings? InvalidSettings { get; set; }
```

### Rules

```csharp
public Array<TileCheckRule> Rules
    {
        get => _rules;
        set
        {
            if (_rules == value) return;
            _rules = value;
        }
    }
```

### Valid

```csharp
[Export]
    public bool Valid
    {
        get => _valid;
        set
        {
            if (_valid == value) return;
            _valid = value;
            EmitSignal(SignalName.ValidChanged, _valid);
        }
    }
```

### CurrentDisplaySettings

```csharp
public IndicatorVisualSettings? CurrentDisplaySettings { get; private set; }
```


## Methods

### _Init

```csharp
public void _Init()
    {
        TargetPosition = Vector2.Zero;
    }
```

**Returns:** `void`

### _Ready

```csharp
public override void _Ready()
    {
        if (Shape == null)
        {
            GD.PushError($"RuleCheckIndicator {Name} requires a valid Shape2D assigned to its shape property.");
        }

        // Ensure default visual settings
        // Note: IndicatorVisualSettings.GetValidDefault() usage would require porting that logic too
        // For now assuming they are set or handled elsewhere or added later

        UpdateValidityState();
    }
```

**Returns:** `void`

### _PhysicsProcess

```csharp
public override void _PhysicsProcess(double delta)
    {
        UpdateValidityState();
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### AddRule

```csharp
public void AddRule(TileCheckRule rule)
    {
        Rules.Add(rule);
        // In GDScript: rule.indicators.append(self)
        // Requires TileCheckRule to have Indicators list exposed
        
        if (IsInsideTree())
        {
            UpdateValidityState();
        }
        else
        {
            if (!IsConnected(Node.SignalName.TreeEntered, Callable.From(_on_tree_entered_validate)))
            {
                Connect(Node.SignalName.TreeEntered, Callable.From(_on_tree_entered_validate));
            }
        }
    }
```

**Returns:** `void`

**Parameters:**
- `TileCheckRule rule`

### GetTilePosition

```csharp
public Vector2I GetTilePosition(TileMapLayer map)
    {
        if (map == null)
        {
            GD.PushError("TileMapLayer is null. Cannot get tile position.");
            return Vector2I.Zero;
        }

        Vector2 mapLocalPos = map.ToLocal(GlobalPosition);
        Vector2I mapTile = map.LocalToMap(mapLocalPos);
        return mapTile;
    }
```

**Returns:** `Vector2I`

**Parameters:**
- `TileMapLayer map`

### Clear

```csharp
public void Clear()
    {
        Rules.Clear();
        Valid = true;
    }
```

**Returns:** `void`

### UpdateValidityState

```csharp
public bool UpdateValidityState()
    {
        if (Rules.Count == 0)
        {
            Valid = true;
            return Valid;
        }

        // Basic validation: checking if any rule fails
        // This logic might need to be more complex based on original GDScript calling ValidateRules
        // For now, we assume we iterate rules
        
        bool allPassed = true;
        // Note: This requires TileCheckRule to have GetFailingIndicators ported/exposed
        // For now leaving simplified or placeholder logic if TileCheckRule isn't fully ported
        
        Valid = allPassed;
        return Valid;
    }
```

**Returns:** `bool`

