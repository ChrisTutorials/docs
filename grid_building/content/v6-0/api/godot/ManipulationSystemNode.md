---
title: "ManipulationSystemNode"
description: "Godot Node wrapper for ManipulationSystem that bridges Core logic with Godot engine.
Follows Enhanced Service Registry pattern with proper dependency injection.
This wrapper provides:
- Godot Node inheritance and lifecycle management
- Signal emission/reception for Godot integration
- Service Registry dependency resolution
- Engine integration (physics, rendering, input systems)
- Event bridging between Core service and Godot signals
Core business logic is delegated to IManipulationService from GridBuilding.Core.Services.Manipulation."
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationsystemnode/"
---

# ManipulationSystemNode

```csharp
GridBuilding.Godot.Systems.Manipulation
class ManipulationSystemNode
{
    // Members...
}
```

Godot Node wrapper for ManipulationSystem that bridges Core logic with Godot engine.
Follows Enhanced Service Registry pattern with proper dependency injection.
This wrapper provides:
- Godot Node inheritance and lifecycle management
- Signal emission/reception for Godot integration
- Service Registry dependency resolution
- Engine integration (physics, rendering, input systems)
- Event bridging between Core service and Godot signals
Core business logic is delegated to IManipulationService from GridBuilding.Core.Services.Manipulation.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/ManipulationSystemNode.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### SystemsContext

```csharp
#endregion
    #region Dependencies
    /// Systems context for plugin integration.
    public GBSystemsContext? SystemsContext { get; private set; }
```

### IndicatorContext

```csharp
/// Placement context for validation and rules.
    public IndicatorContext? IndicatorContext { get; private set; }
```

### States

```csharp
/// Game state management.
    public States? States { get; private set; }
```

### ManipulationSettings

```csharp
/// Manipulation settings configuration.
    public ManipulationSettings? ManipulationSettings { get; private set; }
```

### Actions

```csharp
/// Action definitions and validation.
    public Actions? Actions { get; private set; }
```

### Logger

```csharp
/// Logger for system operations.
    public Logger? Logger { get; private set; }
```


## Methods

### _Ready

```csharp
#endregion
    #region Godot Lifecycle
    public override void _Ready()
    {
        try
        {
            GD.Print("Initializing ManipulationSystemNode with Enhanced Service Registry...");
            
            // Get services from ServiceRegistry
            _serviceRegistry = ServiceCompositionRoot.GetGlobalRegistry();
            if (_serviceRegistry == null)
            {
                GD.PrintErr("ServiceRegistry not found. Ensure ServiceCompositionRoot is in scene tree.");
                return;
            }
            
            // Resolve Core manipulation service
            _manipulationService = _serviceRegistry.GetService<IManipulationService>();
            if (_manipulationService == null)
            {
                GD.PrintErr("IManipulationService not found in ServiceRegistry.");
                return;
            }
            
            // Subscribe to Core service events and forward to Godot signals
            SubscribeToCoreEvents();
            
            // Initialize Godot-specific components
            InitializeGodotComponents();
            
            GD.Print("ManipulationSystemNode initialized successfully with Enhanced Service Registry");
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"Failed to initialize ManipulationSystemNode: {ex.Message}");
        }
    }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
    {
        try
        {
            GD.Print("Cleaning up ManipulationSystemNode...");
            
            // Unsubscribe from Core events
            UnsubscribeFromCoreEvents();
            
            // Restore physics layers for any disabled objects
            RestorePhysicsLayers();
            
            // Clear service references
            _manipulationService = null;
            _serviceRegistry = null;
            _physicsManager = null;
            _transformHandler = null;
            
            GD.Print("ManipulationSystemNode cleaned up successfully");
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"Error during ManipulationSystemNode cleanup: {ex.Message}");
        }
    }
```

**Returns:** `void`

### StartManipulation

```csharp
#endregion

    #region Public API
    /// <summary>
    /// Starts a manipulation operation using the Core service.
    /// </summary>
    /// <param name="mode">Manipulation mode to start</param>
    /// <param name="origin">Origin position in grid coordinates</param>
    /// <returns>True if manipulation started successfully</returns>
    public bool StartManipulation(ManipulationMode mode, Vector2I origin)
    {
        if (_manipulationService == null)
        {
            GD.PrintErr("ManipulationService not available");
            return false;
        }
        
        try
        {
            var manipulationState = _manipulationService.StartManipulation(mode, origin);
            return manipulationState != null;
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"Failed to start manipulation: {ex.Message}");
            return false;
        }
    }
```

Starts a manipulation operation using the Core service.

**Returns:** `bool`

**Parameters:**
- `ManipulationMode mode`
- `Vector2I origin`

### UpdateManipulationTarget

```csharp
/// <summary>
    /// Updates the target of an active manipulation.
    /// </summary>
    /// <param name="manipulationId">ID of the manipulation to update</param>
    /// <param name="target">New target position</param>
    /// <returns>True if update successful</returns>
    public bool UpdateManipulationTarget(string manipulationId, Vector2I target)
    {
        if (_manipulationService == null)
        {
            GD.PrintErr("ManipulationService not available");
            return false;
        }
        
        try
        {
            return _manipulationService.UpdateManipulationTarget(manipulationId, target);
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"Failed to update manipulation target: {ex.Message}");
            return false;
        }
    }
```

Updates the target of an active manipulation.

**Returns:** `bool`

**Parameters:**
- `string manipulationId`
- `Vector2I target`

### CancelManipulation

```csharp
/// <summary>
    /// Cancels an active manipulation.
    /// </summary>
    /// <param name="manipulationId">ID of the manipulation to cancel</param>
    /// <returns>True if cancellation successful</returns>
    public bool CancelManipulation(string manipulationId)
    {
        if (_manipulationService == null)
        {
            GD.PrintErr("ManipulationService not available");
            return false;
        }
        
        try
        {
            return _manipulationService.CancelManipulation(manipulationId);
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"Failed to cancel manipulation: {ex.Message}");
            return false;
        }
    }
```

Cancels an active manipulation.

**Returns:** `bool`

**Parameters:**
- `string manipulationId`

### CompleteManipulation

```csharp
/// <summary>
    /// Completes an active manipulation.
    /// </summary>
    /// <param name="manipulationId">ID of the manipulation to complete</param>
    /// <returns>True if completion successful</returns>
    public bool CompleteManipulation(string manipulationId)
    {
        if (_manipulationService == null)
        {
            GD.PrintErr("ManipulationService not available");
            return false;
        }
        
        try
        {
            return _manipulationService.CompleteManipulation(manipulationId);
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"Failed to complete manipulation: {ex.Message}");
            return false;
        }
    }
```

Completes an active manipulation.

**Returns:** `bool`

**Parameters:**
- `string manipulationId`

### GetManipulation

```csharp
/// <summary>
    /// Gets an active manipulation by ID.
    /// </summary>
    /// <param name="manipulationId">ID of the manipulation</param>
    /// <returns>Manipulation state or null if not found</returns>
    public ManipulationState? GetManipulation(string manipulationId)
    {
        return _manipulationService?.GetManipulation(manipulationId);
    }
```

Gets an active manipulation by ID.

**Returns:** `ManipulationState?`

**Parameters:**
- `string manipulationId`

### GetActiveManipulations

```csharp
/// <summary>
    /// Gets all active manipulations.
    /// </summary>
    /// <returns>Collection of active manipulation states</returns>
    public System.Collections.Generic.IEnumerable<ManipulationState> GetActiveManipulations()
    {
        return _manipulationService?.GetActiveManipulations() ?? System.Linq.Enumerable.Empty<ManipulationState>();
    }
```

Gets all active manipulations.

**Returns:** `System.Collections.Generic.IEnumerable<ManipulationState>`

### CanStartManipulation

```csharp
/// <summary>
    /// Checks if a manipulation can be started at the specified position.
    /// </summary>
    /// <param name="mode">Manipulation mode to check</param>
    /// <param name="origin">Origin position to check</param>
    /// <returns>True if manipulation can be started</returns>
    public bool CanStartManipulation(ManipulationMode mode, Vector2I origin)
    {
        return _manipulationService?.CanStartManipulation(mode, origin) ?? false;
    }
```

Checks if a manipulation can be started at the specified position.

**Returns:** `bool`

**Parameters:**
- `ManipulationMode mode`
- `Vector2I origin`

### ValidateManipulation

```csharp
/// <summary>
    /// Validates a manipulation state.
    /// </summary>
    /// <param name="manipulationId">ID of manipulation to validate</param>
    /// <returns>True if manipulation is valid</returns>
    public bool ValidateManipulation(string manipulationId)
    {
        return _manipulationService?.ValidateManipulation(manipulationId) ?? false;
    }
```

Validates a manipulation state.

**Returns:** `bool`

**Parameters:**
- `string manipulationId`

### GetValidationIssues

```csharp
/// <summary>
    /// Gets validation issues for a manipulation state.
    /// </summary>
    /// <param name="manipulation">Manipulation state to validate</param>
    /// <returns>List of validation issues</returns>
    public System.Collections.Generic.List<string> GetValidationIssues(ManipulationState manipulation)
    {
        return _manipulationService?.ValidateManipulationState(manipulation) ?? new System.Collections.Generic.List<string>();
    }
```

Gets validation issues for a manipulation state.

**Returns:** `System.Collections.Generic.List<string>`

**Parameters:**
- `ManipulationState manipulation`

### ApplyRotation

```csharp
/// <summary>
    /// Applies rotation to a target node (Godot-specific operation).
    /// </summary>
    /// <param name="target">Node to rotate</param>
    /// <param name="degrees">Rotation amount in degrees</param>
    public void ApplyRotation(Node? target, float degrees)
    {
        _transformHandler?.ApplyRotation(target, degrees);
    }
```

Applies rotation to a target node (Godot-specific operation).

**Returns:** `void`

**Parameters:**
- `Node? target`
- `float degrees`

### ApplyFlipHorizontal

```csharp
/// <summary>
    /// Applies horizontal flip to a target node (Godot-specific operation).
    /// </summary>
    /// <param name="target">Node to flip</param>
    public void ApplyFlipHorizontal(Node? target)
    {
        _transformHandler?.ApplyFlipHorizontal(target);
    }
```

Applies horizontal flip to a target node (Godot-specific operation).

**Returns:** `void`

**Parameters:**
- `Node? target`

### ApplyFlipVertical

```csharp
/// <summary>
    /// Applies vertical flip to a target node (Godot-specific operation).
    /// </summary>
    /// <param name="target">Node to flip</param>
    public void ApplyFlipVertical(Node? target)
    {
        _transformHandler?.ApplyFlipVertical(target);
    }
```

Applies vertical flip to a target node (Godot-specific operation).

**Returns:** `void`

**Parameters:**
- `Node? target`

### DisablePhysicsLayer

```csharp
/// <summary>
    /// Disables physics layers for a target node (Godot-specific operation).
    /// </summary>
    /// <param name="target">Node to disable layers for</param>
    /// <param name="layer">Physics layer to disable</param>
    /// <returns>True if any objects were disabled</returns>
    public bool DisablePhysicsLayer(Node2D? target, int layer)
    {
        if (_physicsManager == null) return false;
        return _physicsManager.DisableLayer(target, layer, _physicsDisabledObjects);
    }
```

Disables physics layers for a target node (Godot-specific operation).

**Returns:** `bool`

**Parameters:**
- `Node2D? target`
- `int layer`

### ReenablePhysicsLayer

```csharp
/// <summary>
    /// Re-enables previously disabled physics layers (Godot-specific operation).
    /// </summary>
    /// <param name="layer">Physics layer to re-enable</param>
    public void ReenablePhysicsLayer(int layer)
    {
        if (_physicsManager != null)
        {
            _physicsManager.ReenableLayer(_physicsDisabledObjects, layer);
        }
    }
```

Re-enables previously disabled physics layers (Godot-specific operation).

**Returns:** `void`

**Parameters:**
- `int layer`

### GetValidationIssues

```csharp
/// <summary>
    /// Gets validation issues if any services are missing or misconfigured.
    /// </summary>
    /// <returns>Collection of validation issue descriptions</returns>
    public System.Collections.Generic.IEnumerable<string> GetValidationIssues()
    {
        var issues = new System.Collections.Generic.List<string>();
        
        if (_serviceRegistry == null)
            issues.Add("ServiceRegistry is not available");
        if (_manipulationService == null)
            issues.Add("IManipulationService is not available");
        if (_physicsManager == null)
            issues.Add("PhysicsLayerManager is not available");
        if (_transformHandler == null)
            issues.Add("ManipulationTransformHandler is not available");
            
        return issues;
    }
```

Gets validation issues if any services are missing or misconfigured.

**Returns:** `System.Collections.Generic.IEnumerable<string>`

### CreateWithInjection

```csharp
/// <summary>
    /// Legacy factory method for backward compatibility.
    /// OBSOLETE: Use Enhanced Service Registry Pattern instead.
    /// </summary>
    [System.Obsolete("Use Enhanced Service Registry Pattern instead. Add ServiceCompositionRoot to scene tree.")]
    public static ManipulationSystemNode CreateWithInjection(Node parent, object container)
    {
        GD.PrintWarn("Using deprecated CreateWithInjection method. Consider migrating to Enhanced Service Registry Pattern.");
        
        var system = new ManipulationSystemNode();
        system.Name = "ManipulationSystemNode";
        parent.AddChild(system);
        
        return system;
    }
```

Legacy factory method for backward compatibility.
OBSOLETE: Use Enhanced Service Registry Pattern instead.

**Returns:** `ManipulationSystemNode`

**Parameters:**
- `Node parent`
- `object container`

