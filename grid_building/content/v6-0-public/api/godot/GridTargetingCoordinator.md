---
title: "GridTargetingCoordinator"
description: "Lightweight coordinator for grid targeting components.
This system has been simplified from the original GridTargetingSystem
to focus only on multi-component coordination and Service Registry
integration. All heavy business logic has been moved to the
IGridTargetingService Core service.
Use TargetingShapeCast2DRefactored components for individual targeting,
and this coordinator only when you need to manage multiple components."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/gridtargetingcoordinator/"
---

# GridTargetingCoordinator

```csharp
GridBuilding.Godot.Systems.GridTargeting
class GridTargetingCoordinator
{
    // Members...
}
```

Lightweight coordinator for grid targeting components.
This system has been simplified from the original GridTargetingSystem
to focus only on multi-component coordination and Service Registry
integration. All heavy business logic has been moved to the
IGridTargetingService Core service.
Use TargetingShapeCast2DRefactored components for individual targeting,
and this coordinator only when you need to manage multiple components.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridTargeting/GridTargetingCoordinator.cs`  
**Namespace:** `GridBuilding.Godot.Systems.GridTargeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### AstarGrid

```csharp
#endregion

        #region Public Properties

        /// <summary>
        /// The AStar grid for pathfinding
        /// </summary>
        public AStarGrid2D? AstarGrid
        {
            get => _astarGrid;
            set => SetAstarGrid(value);
        }
```

The AStar grid for pathfinding

### IsInitialized

```csharp
/// <summary>
        /// Whether the coordinator is initialized
        /// </summary>
        public bool IsInitialized => _isInitialized;
```

Whether the coordinator is initialized

### ComponentCount

```csharp
/// <summary>
        /// Number of registered components
        /// </summary>
        public int ComponentCount => _registeredComponents.Count;
```

Number of registered components


## Methods

### _Ready

```csharp
#endregion

        #region Godot Lifecycle

        public override void _Ready()
        {
            InitializeCoordinator();
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            CleanupCoordinator();
        }
```

**Returns:** `void`

### CreateWithInjection

```csharp
/// <summary>
        /// Creates a GridTargetingCoordinator with dependency injection from container.
        /// </summary>
        /// <param name="parent">Parent node to attach the coordinator to</param>
        /// <param name="container">Dependency injection container</param>
        /// <returns>Configured GridTargetingCoordinator instance</returns>
        public static GridTargetingCoordinator CreateWithInjection(Node parent, GBCompositionContainer container)
        {
            var coordinator = new GridTargetingCoordinator();
            coordinator.Name = "GridTargetingCoordinator";
            parent.AddChild(coordinator);

            // Validate dependencies were properly injected
            var issues = coordinator.GetRuntimeIssues();
            if (issues.Count > 0)
            {
                var logger = container.GetLogger();
                logger?.LogWarnings(issues);
            }

            return coordinator;
        }
```

Creates a GridTargetingCoordinator with dependency injection from container.

**Returns:** `GridTargetingCoordinator`

**Parameters:**
- `Node parent`
- `GBCompositionContainer container`

### RegisterTargetingComponent

```csharp
#endregion

        #region Component Management

        /// <summary>
        /// Registers a targeting component with this coordinator
        /// </summary>
        /// <param name="component">The component to register</param>
        public void RegisterTargetingComponent(TargetingShapeCast2DRefactored component)
        {
            if (component == null || _registeredComponents.Contains(component))
                return;

            _registeredComponents.Add(component);
            
            // Subscribe to component signals
            component.TargetDetected += OnComponentTargetDetected;
            component.ValidationChanged += OnComponentValidationChanged;
            component.GridPositionChanged += OnComponentGridPositionChanged;

            EmitSignal(SignalName.ComponentRegistered, component);
            
            _logger?.LogDebug($"Registered targeting component: {component.Name}");
        }
```

Registers a targeting component with this coordinator

**Returns:** `void`

**Parameters:**
- `TargetingShapeCast2DRefactored component`

### UnregisterTargetingComponent

```csharp
/// <summary>
        /// Unregisters a targeting component from this coordinator
        /// </summary>
        /// <param name="component">The component to unregister</param>
        public void UnregisterTargetingComponent(TargetingShapeCast2DRefactored component)
        {
            if (component == null || !_registeredComponents.Contains(component))
                return;

            _registeredComponents.Remove(component);

            // Unsubscribe from component signals
            component.TargetDetected -= OnComponentTargetDetected;
            component.ValidationChanged -= OnComponentValidationChanged;
            component.GridPositionChanged -= OnComponentGridPositionChanged;

            EmitSignal(SignalName.ComponentUnregistered, component);
            
            _logger?.LogDebug($"Unregistered targeting component: {component.Name}");
        }
```

Unregisters a targeting component from this coordinator

**Returns:** `void`

**Parameters:**
- `TargetingShapeCast2DRefactored component`

### GetRegisteredComponents

```csharp
/// <summary>
        /// Gets all registered targeting components
        /// </summary>
        /// <returns>List of registered components</returns>
        public List<TargetingShapeCast2DRefactored> GetRegisteredComponents()
        {
            return new List<TargetingShapeCast2DRefactored>(_registeredComponents);
        }
```

Gets all registered targeting components

**Returns:** `List<TargetingShapeCast2DRefactored>`

### FindComponentByName

```csharp
/// <summary>
        /// Finds a targeting component by name
        /// </summary>
        /// <param name="name">Component name</param>
        /// <returns>Found component or null</returns>
        public TargetingShapeCast2DRefactored? FindComponentByName(string name)
        {
            return _registeredComponents.Find(c => c.Name == name);
        }
```

Finds a targeting component by name

**Returns:** `TargetingShapeCast2DRefactored?`

**Parameters:**
- `string name`

### GetComponentsWithValidTargets

```csharp
/// <summary>
        /// Gets all components that currently have valid targets
        /// </summary>
        /// <returns>List of components with valid targets</returns>
        public List<TargetingShapeCast2DRefactored> GetComponentsWithValidTargets()
        {
            var result = new List<TargetingShapeCast2DRefactored>();
            foreach (var component in _registeredComponents)
            {
                if (component.HasValidTarget)
                {
                    result.Add(component);
                }
            }
            return result;
        }
```

Gets all components that currently have valid targets

**Returns:** `List<TargetingShapeCast2DRefactored>`

### SetAstarGrid

```csharp
#endregion

        #region AStar Grid Management

        /// <summary>
        /// Sets the AStar grid and updates Core service
        /// </summary>
        /// <param name="astarGrid">AStar grid to set</param>
        public void SetAstarGrid(AStarGrid2D? astarGrid)
        {
            if (_astarGrid == astarGrid)
                return;

            _astarGrid = astarGrid;

            // Update Core service navigation data
            if (_targetingService != null && _astarGrid != null)
            {
                var navigationData = ExtractNavigationDataFromAStar(_astarGrid);
                _targetingService.UpdateGridNavigation(navigationData);
            }

            EmitSignal(SignalName.AstarGridChanged, _astarGrid);
            
            _logger?.LogDebug($"AStar grid updated: {_astarGrid != null}");
        }
```

Sets the AStar grid and updates Core service

**Returns:** `void`

**Parameters:**
- `AStarGrid2D? astarGrid`

### EnableAllTargeting

```csharp
#endregion

        #region Global Operations

        /// <summary>
        /// Enables targeting for all registered components
        /// </summary>
        public void EnableAllTargeting()
        {
            if (_targetingService != null)
            {
                _targetingService.SetTargetingEnabled(true);
            }

            foreach (var component in _registeredComponents)
            {
                component.AutoUpdate = true;
            }
            
            _logger?.LogDebug("Enabled targeting for all components");
        }
```

Enables targeting for all registered components

**Returns:** `void`

### DisableAllTargeting

```csharp
/// <summary>
        /// Disables targeting for all registered components
        /// </summary>
        public void DisableAllTargeting()
        {
            if (_targetingService != null)
            {
                _targetingService.SetTargetingEnabled(false);
            }

            foreach (var component in _registeredComponents)
            {
                component.AutoUpdate = false;
            }
            
            _logger?.LogDebug("Disabled targeting for all components");
        }
```

Disables targeting for all registered components

**Returns:** `void`

### UpdateAllComponents

```csharp
/// <summary>
        /// Updates all registered components
        /// </summary>
        public void UpdateAllComponents()
        {
            foreach (var component in _registeredComponents)
            {
                component.UpdateTargeting();
            }
        }
```

Updates all registered components

**Returns:** `void`

### ClearAllTargets

```csharp
/// <summary>
        /// Clears all targets in all components and Core service
        /// </summary>
        public void ClearAllTargets()
        {
            if (_targetingService != null)
            {
                _targetingService.ClearTarget();
            }

            foreach (var component in _registeredComponents)
            {
                // Components will clear automatically when Core service is cleared
                component.UpdateTargeting();
            }
            
            _logger?.LogDebug("Cleared all targets");
        }
```

Clears all targets in all components and Core service

**Returns:** `void`

### GetRuntimeIssues

```csharp
#endregion

        #region Validation and Diagnostics

        /// <summary>
        /// Validates that all required dependencies are properly set
        /// </summary>
        /// <returns>List of validation issues (empty if valid)</returns>
        public global::Godot.Collections.Array<string> GetRuntimeIssues()
        {
            var issues = new global::Godot.Collections.Array<string>();

            if (_targetingService == null)
                issues.Add("IGridTargetingService is not set");

            if (_logger == null)
                issues.Add("ILogger is not set");

            // Validate Core service setup
            if (_targetingService != null)
            {
                var serviceIssues = _targetingService.ValidateSetup();
                foreach (var issue in serviceIssues)
                {
                    issues.Add($"Core Service: {issue}");
                }
            }

            return issues;
        }
```

Validates that all required dependencies are properly set

**Returns:** `global::Godot.Collections.Array<string>`

### ValidateReady

```csharp
/// <summary>
        /// Validates that the coordinator is ready for operation
        /// </summary>
        /// <returns>True if ready, false otherwise</returns>
        public bool ValidateReady()
        {
            var issues = GetRuntimeIssues();
            _logger?.LogIssues(issues);
            return issues.Count == 0;
        }
```

Validates that the coordinator is ready for operation

**Returns:** `bool`

### GetDebugInfo

```csharp
/// <summary>
        /// Gets comprehensive debug information
        /// </summary>
        /// <returns>Debug information string</returns>
        public string GetDebugInfo()
        {
            var info = $"GridTargetingCoordinator Debug Info:\n";
            info += $"Initialized: {_isInitialized}\n";
            info += $"Registered Components: {_registeredComponents.Count}\n";
            info += $"Core Service Available: {_targetingService != null}\n";
            info += $"Logger Available: {_logger != null}\n";
            info += $"AStar Grid Available: {_astarGrid != null}\n";

            if (_targetingService != null)
            {
                info += $"Core Service Target: {_targetingService.CurrentTargetTile}\n";
                info += $"Core Service Active: {_targetingService.IsTargetingActive}\n";
            }

            if (_astarGrid != null)
            {
                info += $"AStar Region: {_astarGrid.Region}\n";
                info += $"AStar Cell Size: {_astarGrid.CellSize}\n";
            }

            // Component details
            info += "\nComponents:\n";
            foreach (var component in _registeredComponents)
            {
                info += $"  - {component.Name}: Valid={component.HasValidTarget}, Pos={component.CurrentGridPosition}\n";
            }

            return info;
        }
```

Gets comprehensive debug information

**Returns:** `string`

### PrintDebugInfo

```csharp
/// <summary>
        /// Prints debug information
        /// </summary>
        public void PrintDebugInfo()
        {
            GD.Print(GetDebugInfo());
        }
```

Prints debug information

**Returns:** `void`

### FindPath

```csharp
#endregion

        #region Backward Compatibility Methods

        // These methods provide backward compatibility with the original GridTargetingSystem
        // They delegate to the Core service or provide simplified implementations

        /// <summary>
        /// [Obsolete] Use IGridTargetingService.FindPath instead
        /// </summary>
        [Obsolete("Use IGridTargetingService.FindPath instead")]
        public List<Vector2I> FindPath(Vector2I startPosition, Vector2I endPosition)
        {
            return _targetingService?.FindPath(startPosition, endPosition) ?? new List<Vector2I>();
        }
```

[Obsolete] Use IGridTargetingService.FindPath instead

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I startPosition`
- `Vector2I endPosition`

### IsPathClear

```csharp
/// <summary>
        /// [Obsolete] Use IGridTargetingService.IsPathClear instead
        /// </summary>
        [Obsolete("Use IGridTargetingService.IsPathClear instead")]
        public bool IsPathClear(Vector2I startPosition, Vector2I endPosition)
        {
            return _targetingService?.IsPathClear(startPosition, endPosition) ?? false;
        }
```

[Obsolete] Use IGridTargetingService.IsPathClear instead

**Returns:** `bool`

**Parameters:**
- `Vector2I startPosition`
- `Vector2I endPosition`

### GetClosestValidTile

```csharp
/// <summary>
        /// [Obsolete] Use IGridTargetingService.GetClosestValidTile instead
        /// </summary>
        [Obsolete("Use IGridTargetingService.GetClosestValidTile instead")]
        public Vector2I GetClosestValidTile(Vector2I targetTile, Node2D source, Node2D map, object? settings)
        {
            var sourcePos = WorldToGrid(source.GlobalPosition);
            return _targetingService?.GetClosestValidTile(targetTile, sourcePos, 10) ?? targetTile;
        }
```

[Obsolete] Use IGridTargetingService.GetClosestValidTile instead

**Returns:** `Vector2I`

**Parameters:**
- `Vector2I targetTile`
- `Node2D source`
- `Node2D map`
- `object? settings`

### MoveNodeToClosestValidTile

```csharp
/// <summary>
        /// [Obsolete] Components now handle their own movement
        /// </summary>
        [Obsolete("Components now handle their own movement")]
        public Error MoveNodeToClosestValidTile(Vector2I targetTile, Node2D positioner, Node2D source)
        {
            // This is now handled by individual components
            GD.PrintWarn("MoveNodeToClosestValidTile is obsolete. Use TargetingShapeCast2DRefactored components instead.");
            return Error.Ok;
        }
```

[Obsolete] Components now handle their own movement

**Returns:** `Error`

**Parameters:**
- `Vector2I targetTile`
- `Node2D positioner`
- `Node2D source`

