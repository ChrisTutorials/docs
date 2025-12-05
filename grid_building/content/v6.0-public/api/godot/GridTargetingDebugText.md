---
title: "GridTargetingDebugText"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/gridtargetingdebugtext/"
---

# GridTargetingDebugText

```csharp
GridBuilding.Godot.Systems.UI.Debug
class GridTargetingDebugText
{
    // Members...
}
```

GridTargetingDebugText class in the Grid Building system.
Provides real-time debugging information about mouse position, indicator state,
collision counts, and blocking entities in both vertical and horizontal layouts.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/UI/Debug/GridTargetingDebugText.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI.Debug`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CollisionsCountPrefix

```csharp
#endregion

    #region Exported Properties

    /// <summary>
    /// Descriptive collision count prefix
    /// </summary>
    [Export] public string CollisionsCountPrefix { get; set; } = "Collisions:";
```

Descriptive collision count prefix

### DebugOutput

```csharp
/// <summary>
    /// Debug output rich text label
    /// </summary>
    [Export] public RichTextLabel DebugOutput { get; set; }
```

Debug output rich text label

### DisplayMode

```csharp
/// <summary>
    /// Display mode: VERTICAL = labels + value lines; HORIZONTAL = single line per category
    /// </summary>
    [Export(PropertyHint.Enum, "VERTICAL,HORIZONTAL")]
    public string DisplayMode { get; set; } = "VERTICAL";
```

Display mode: VERTICAL = labels + value lines; HORIZONTAL = single line per category


## Methods

### _Ready

```csharp
#endregion

    #region Godot Lifecycle

    /// <summary>
    /// Called when the node enters the scene tree.
    /// </summary>
    public override void _Ready()
    {
        base._Ready();
        
        if (DebugOutput == null)
        {
            GD.PushError("Must set a RichTextLabel as debug_output to render output text");
            return;
        }

        // Ensure BBCode parsing is enabled so header styling renders
        DebugOutput.BbcodeEnabled = true;
    }
```

Called when the node enters the scene tree.

**Returns:** `void`

### _Process

```csharp
/// <summary>
    /// Called every frame.
    /// </summary>
    /// <param name="delta">Time since last frame</param>
    public override void _Process(double delta)
    {
        base._Process(delta);

        // Always update mouse line; cheaper than relying on input events only
        var viewport = GetViewport();
        if (viewport != null)
        {
            var mousePos = viewport.GetMousePosition();
            _lines["mouse"] = $"({mousePos.X:F1},{mousePos.Y:F1})";
        }
        else
        {
            _lines["mouse"] = "(N/A,N/A)";
        }

        // Refresh collision + indicator lines if manager present
        if (_indicatorContext != null && _indicatorContext.HasManager())
        {
            var manager = _indicatorContext.GetManager();
            UpdateCollisionLabels(manager);
            UpdateIndicatorLine(manager);
        }

        RenderDebug();
    }
```

Called every frame.

**Returns:** `void`

**Parameters:**
- `double delta`

### ResolveGBDependencies

```csharp
#endregion

    #region Dependency Injection

    /// <summary>
    /// Resolve dependencies from the composition container.
    /// </summary>
    /// <param name="container">The composition container</param>
    public void ResolveGBDependencies(GBCompositionContainer container)
    {
        if (container == null)
        {
            GD.PushError("Must pass a Grid Building composition root into resolve dependencies to source any needed dependencies.");
            return;
        }

        var contexts = container.GetContexts();
        _indicatorContext = contexts.Indicator;
        _targetingState = container.GetStates().Targeting;
        _debugSettings = container.GetDebugSettings();

        _lines["status"] = (_indicatorContext.HasManager() ? "OK" : "Missing Manager");

        // Listen for manager assignment changes so UI can reflect availability
        if (_indicatorContext != null)
        {
            _indicatorContext.ManagerChanged += OnManagerChanged;
        }

        // Listen for map change to update map name line
        if (_targetingState != null)
        {
            _targetingState.TargetMapChanged += OnTargetMapChanged;
        }

        UpdateMapLine();
        RenderDebug();

        // Force an immediate collision update if manager already exists
        if (_indicatorContext.HasManager())
        {
            var manager = _indicatorContext.GetManager();
            UpdateCollisionLabels(manager);
            UpdateIndicatorLine(manager);
            RenderDebug();
        }
        else
        {
            _lines["collision_count"] = "(no manager yet)";
            _lines["blocking"] = "";
            RenderDebug();
        }
    }
```

Resolve dependencies from the composition container.

**Returns:** `void`

**Parameters:**
- `GBCompositionContainer container`

### SetIndicatorPosition

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Set the indicator position display.
    /// </summary>
    /// <param name="position">Position to display</param>
    public void SetIndicatorPosition(Vector2 position)
    {
        _lines["indicator"] = position.ToString();
        RenderDebug();
    }
```

Set the indicator position display.

**Returns:** `void`

**Parameters:**
- `Vector2 position`

### ClearIndicatorPosition

```csharp
/// <summary>
    /// Clear the indicator position display.
    /// </summary>
    public void ClearIndicatorPosition()
    {
        _lines["indicator"] = "";
        RenderDebug();
    }
```

Clear the indicator position display.

**Returns:** `void`

### UpdateCollisionLabels

```csharp
/// <summary>
    /// Update collision labels based on indicator manager state.
    /// </summary>
    /// <param name="indicatorManager">The indicator manager</param>
    public void UpdateCollisionLabels(IndicatorManager indicatorManager)
    {
        if (!GodotObject.IsInstanceValid(indicatorManager))
        {
            _lines["collision_count"] = "Collisions: (no manager)";
            _lines["blocking"] = "Blocking: (no manager)";
            return;
        }

        var collisionCount = indicatorManager.GetCollidingIndicators().Count;
        _lines["collision_count"] = collisionCount.ToString();

        var bodies = indicatorManager.GetCollidingNodes();
        if (bodies.Count == 0)
        {
            _lines["blocking"] = "0";
        }
        else
        {
            var names = new List<string>();
            foreach (Node2D body in bodies)
            {
                if (body != null)
                {
                    var name = !string.IsNullOrEmpty(body.Name) ? body.Name : body.GetClass();
                    names.Add(name);
                    if (names.Count >= MaxBlockingNames)
                        break;
                }
            }

            var total = bodies.Count;
            var omitted = total - names.Count;
            var parts = new List<string>();

            // First line: total count
            parts.Add(total.ToString());

            // Each blocking name on its own line for readability
            parts.AddRange(names);

            if (omitted > 0)
            {
                parts.Add($"+{omitted} more");
            }

            _lines["blocking"] = string.Join("\n", parts);
        }
    }
```

Update collision labels based on indicator manager state.

**Returns:** `void`

**Parameters:**
- `IndicatorManager indicatorManager`

