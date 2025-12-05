---
title: "GridTargetingSystem"
description: "Orchestrates grid targeting dependencies (state, settings, path manager, position mover).
Provides a single injection point for GridTargeting/Settings/PathManager, owns the shared
AStar grid manager, and exposes runtime APIs for other systems (placement,
manipulation) to validate targeting readiness or request tile movements.
Migrated to Service Registry pattern with Core service delegation for optimal performance.
Ported from: godot/addons/grid_building/systems/grid_targeting/grid_targeting_system.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/gridtargetingsystem/"
---

# GridTargetingSystem

```csharp
GridBuilding.Godot.Systems.GridTargeting
class GridTargetingSystem
{
    // Members...
}
```

Orchestrates grid targeting dependencies (state, settings, path manager, position mover).
Provides a single injection point for GridTargeting/Settings/PathManager, owns the shared
AStar grid manager, and exposes runtime APIs for other systems (placement,
manipulation) to validate targeting readiness or request tile movements.
Migrated to Service Registry pattern with Core service delegation for optimal performance.
Ported from: godot/addons/grid_building/systems/grid_targeting/grid_targeting_system.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridTargeting/GridTargetingSystem.cs`  
**Namespace:** `GridBuilding.Godot.Systems.GridTargeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TargetTile

```csharp
#endregion
    #region Properties
    /// The tile location where the mouse is currently hovering over represented as X / Y values of the _targeting_state.target_map.
    public Vector2 TargetTile { get; set; }
```

### UiMouseHandled

```csharp
/// Whether the mouse input was consumed by GUI already or not (renamed from mouse_handled).
    public bool UiMouseHandled { get; set; } = false;
```

### AstarGrid

```csharp
/// The AStar grid for pathfinding.
    public AStarGrid2D? AstarGrid { get; set; }
```


## Methods

### _Ready

```csharp
#endregion
    #region Godot Lifecycle
    public override void _Ready()
    {
        // Add to group for positioner to find utility methods
        AddToGroup("grid_targeting_systems");
    }
```

**Returns:** `void`

### _Input

```csharp
public override void _Input(InputEvent @event)
    {
        if (!AreDependenciesResolved())
            return;
        
        // Mouse movement: only update astar grid if mouse input is enabled
        if (@event is InputEventMouseMotion && 
            _targetingSettings?.EnableMouseInput == true)
        {
            _pathManager?.UpdateIfDirty();
        }
    }
```

**Returns:** `void`

**Parameters:**
- `InputEvent event`

### CreateWithInjection

```csharp
#endregion
    #region Public API
    /// Creates a GridTargetingSystem with dependency injection from container.
    /// <param name="parent">Parent node to attach the system to</param>
    /// <param name="container">Dependency injection container</param>
    /// <returns>Configured GridTargetingSystem instance</returns>
    public static GridTargetingSystem CreateWithInjection(Node parent, GBCompositionContainer container)
    {
        var system = new GridTargetingSystem();
        system.Name = "GridTargetingSystem";
        parent.AddChild(system);
        // Inject dependencies using Service Registry pattern
        system.ResolveGbDependencies(container);
        // Validate dependencies were properly injected
        var issues = system.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            var logger = container.GetLogger();
            logger?.LogWarnings(issues);
        }
        return system;
    }
```

**Returns:** `GridTargetingSystem`

**Parameters:**
- `Node parent`
- `GBCompositionContainer container`

### GetRuntimeIssues

```csharp
/// Validates that all required dependencies are properly set.
    /// Returns list of validation issues (empty if valid).
    public global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();
        if (_systemsContext == null)
            issues.Add("SystemsContext is not set");
        if (_targetingState == null)
            issues.Add("GridTargetingState is not set");
        if (_targetingSettings == null)
            issues.Add("GridTargetingSettings is not set");
        else
        {
            var editorIssues = _targetingSettings.GetEditorIssues();
            if (editorIssues.Count > 0)
            {
                issues.AddRange(editorIssues);
                issues.Add("GridTargetingSettings are not valid yet");
            }
        }
        if (_modeState == null)
            issues.Add("ModeState is not set");
        // Validate AStar grid
        var activeGrid = _pathManager?.GetGrid();
        // Fallback: if an external astar was explicitly adopted, prefer that reference
        if (activeGrid == null)
            activeGrid = AstarGrid;
        if (!GodotObject.IsInstanceValid(activeGrid))
            issues.Add("AStarGrid2D must be set for system to run. Has GridTargetingState.target_map been set yet?");
        else
        {
            if (activeGrid.Region.Size.X == 0 || activeGrid.Region.Size.Y == 0)
                issues.Add($"AStarGrid2D region size is unusable {activeGrid.Region.Size}");
            if (_targetingSettings != null && 
                activeGrid.DefaultComputeHeuristic != _targetingSettings.DefaultComputeHeuristic)
                issues.Add("AStarGrid2D heuristic mismatch with settings");
        }
        return issues;
    }
```

**Returns:** `global::Godot.Collections.Array<string>`

### GetState

```csharp
/// Compatibility accessor for older tests expecting get_state().
    /// Returns the underlying GridTargetingState used by this system.
    public GridTargetingState? GetState()
    {
        return _targetingState;
    }
```

**Returns:** `GridTargetingState?`

### MoveNodeToClosestValidTile

```csharp
/// Move the positioner to adjust the shown position of any visual _targeting_settings elements.
    /// If limit_to_adjacent setting is on, the closest valid target will be limited by the source position and the max_tiles_distance.
    /// Delegates business logic to Core targeting service for optimal performance.
    /// <param name="targetTile">Desired tile location to move to</param>
    /// <param name="positioner">Node to move to the target position</param>
    /// <param name="source">Source node for distance calculations when limit_to_adjacent is enabled</param>
    /// <returns>Error code indicating success or failure</returns>
    public Error MoveNodeToClosestValidTile(Vector2I targetTile, Node2D positioner, Node2D source)
    {
        if (!AreDependenciesResolved())
            return Error.ErrUnconfigured;
        
        var map = GetTargetMap();
        if (map == null)
            return Error.ErrUnconfigured;
        
        // Delegate to Core service for business logic
        var sourcePosition = source.Position.ToVector2I();
        var resolvedTile = _targetingService?.GetClosestValidTile(targetTile, sourcePosition, _targetingSettings?.MaxTilesDistance ?? 10) ?? targetTile;
        
        Positioning2DUtils.MoveToTileCenter(positioner, resolvedTile, map);
        return Error.Ok;
    }
```

**Returns:** `Error`

**Parameters:**
- `Vector2I targetTile`
- `Node2D positioner`
- `Node2D source`

### MoveToTile

```csharp
/// Moves a target node to the center snapped position of a tile on the _targeting_state.target_map.
    /// <param name="node">Node to move to the tile position</param>
    /// <param name="tile">Tile coordinates to move to</param>
    public Error MoveToTile(Node2D node, Vector2 tile)
    {
        var map = GetTargetMap();
        if (map == null)
            return Error.ErrUnconfigured;
        
        var tileCoords = new Vector2I((int)Mathf.Round(tile.X), (int)Mathf.Round(tile.Y));
        Positioning2DUtils.MoveToTileCenter(node, tileCoords, map);
        return Error.Ok;
    }
```

**Returns:** `Error`

**Parameters:**
- `Node2D node`
- `Vector2 tile`

### GetTileFromGlobalPosition

```csharp
/// Returns the tile on the tile_map where the mouse is currently hovering over.
    /// <param name="globalPosition">Global position to convert to tile coordinates</param>
    /// <param name="map">TileMap or TileMapLayer to use for coordinate conversion</param>
    /// <returns>Tile coordinates at the global position</returns>
    public Vector2I GetTileFromGlobalPosition(Vector2 globalPosition, Node2D map)
    {
        var mapPosition = map.ToLocal(globalPosition);
        return map.LocalToMap(mapPosition);
    }
```

**Returns:** `Vector2I`

**Parameters:**
- `Vector2 globalPosition`
- `Node2D map`

### UpdateAstarGrid2D

```csharp
/// Updates an AStarGrid2D according to a set of GridTargetingSettings.
    /// <param name="astar">AStar grid to configure</param>
    /// <param name="targetingSettings">Settings to apply to the AStar grid</param>
    public void UpdateAstarGrid2D(AStarGrid2D? astar, GridTargetingSettings? targetingSettings)
    {
        if (targetingSettings == null)
        {
            GD.PrintWarn("targetingSettings is null. Unable to configure AStarGrid2D.");
            return;
        }
        
        AstarGrid = astar;
        // Adopt the provided astar instance if present
        if (AstarGrid != null)
        {
            _pathManager?.SetGrid(AstarGrid);
        }
        // Refresh the manager's cached region for the active map, then apply settings
        _pathManager?.UpdateRegion(GetTargetMap());
        _pathManager?.Configure(targetingSettings);
        EmitSignal(SignalName.AstarGridChanged, _pathManager?.GetGrid());
    }
```

**Returns:** `void`

**Parameters:**
- `AStarGrid2D? astar`
- `GridTargetingSettings? targetingSettings`

### ValidateAndLogIssues

```csharp
/// Public manual validation entry point for host projects.
    /// Runs GetRuntimeIssues() and logs issues without relying on timed warnings.
    /// Returns the list of issues (empty when valid).
    public global::Godot.Collections.Array<string> ValidateAndLogIssues()
    {
        var issues = GetRuntimeIssues();
        if (issues.Count > 0)
        {
            if (_logger != null)
                _logger.LogWarnings(issues);
            else
            {
                foreach (var issue in issues)
                {
                    GD.PrintWarn(issue);
                }
            }
        }
        return issues;
    }
```

**Returns:** `global::Godot.Collections.Array<string>`

### ValidateReady

```csharp
/// Validates that the targeting system is ready for operation.
    public bool ValidateReady()
    {
        var issues = GetTargetingIssues();
        _logger?.LogIssues(issues);
        return issues.Count == 0;
    }
```

**Returns:** `bool`

### GetTargetingIssues

```csharp
/// Gets issues that would prevent the targeting_system from being able to target.
    /// This should be called after grid targeting state properties have all been defined.
    public global::Godot.Collections.Array<string> GetTargetingIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();
        
        // Check the _targeting_state for any issues
        if (_targetingState != null)
        {
            var stateIssues = _targetingState.GetRuntimeIssues();
            issues.AddRange(stateIssues);
            if (stateIssues.Count > 0)
                issues.Add("GridTargetingState is not yet valid. Check above warnings for more information.");
        }
        
        return issues;
    }
```

**Returns:** `global::Godot.Collections.Array<string>`

### ResolveGbDependencies

```csharp
#endregion
    #region Private Methods
    /// Resolves and injects all required dependencies from the composition container.
    /// Uses Service Registry pattern for modern dependency injection.
    /// <param name="container">The composition container providing dependencies</param>
    public void ResolveGbDependencies(CompositionContainer container)
    {
        _systemsContext = container.GetSystemsContext();
        _systemsContext?.SetSystem(this);
        _targetingState = container.GetStates().Targeting;
        _targetingSettings = container.GetTargetingSettings();
        _modeState = container.GetStates().Mode;
        _logger = container.GetLogger();
        
        // Create and configure the core targeting service
        _targetingService = CreateTargetingService(container);
        
        _pathManager = new AStarPathManager(_targetingSettings, GetTargetMap());
        if (_modeState != null && !_modeState.IsModeChangeConnected(OnModeChanged))
        {
            _modeState.ModeChanged += OnModeChanged;
        }
        if (_targetingState == null) // Auto disable if _targeting_state is null
            ProcessMode = ProcessModeEnum.Disabled;
        UpdateAstarGrid2D(AstarGrid, _targetingSettings);
        SubscribeTargetingSettings();
    }
```

**Returns:** `void`

**Parameters:**
- `CompositionContainer container`

### Dispose

```csharp
#endregion
    
    #region IDisposable Implementation
    
    /// <summary>
    /// Disposes of system resources and unsubscribes from events.
    /// </summary>
    public void Dispose()
    {
        if (!_disposed)
        {
            // Unsubscribe from Core service events
            if (_targetingService != null)
            {
                _targetingService.PathCalculated -= OnPathCalculated;
                _targetingService.PathCalculationFailed -= OnPathCalculationFailed;
                _targetingService.TargetingStateChanged -= OnTargetingStateChanged;
                
                if (_targetingService is IDisposable disposableService)
                {
                    disposableService.Dispose();
                }
            }
            
            // Unsubscribe from other events
            UnsubscribeTargetingSettings();
            
            if (_modeState != null)
            {
                _modeState.ModeChanged -= OnModeChanged;
            }
            
            _disposed = true;
        }
    }
```

Disposes of system resources and unsubscribes from events.

**Returns:** `void`

### _ExitTree

```csharp
/// <summary>
    /// Godot-specific cleanup when node is removed from tree.
    /// </summary>
    public override void _ExitTree()
    {
        Dispose();
        base._ExitTree();
    }
```

Godot-specific cleanup when node is removed from tree.

**Returns:** `void`

