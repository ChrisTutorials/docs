---
title: "DemolishManager"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/demolishmanager/"
---

# DemolishManager

```csharp
GridBuilding.Godot.Systems.Manipulation.Managers
class DemolishManager
{
    // Members...
}
```

Manages building demolition operations
Handles building removal, cleanup, and resource recovery
Ported from: godot/addons/grid_building/manipulation/demolish_manager.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Managers/DemolishManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RequireConfirmation

```csharp
#endregion
    
    #region Exported Properties
    
    /// <summary>
    /// Whether to show demolition confirmation dialog
    /// </summary>
    [Export] public bool RequireConfirmation { get; set; } = true;
```

Whether to show demolition confirmation dialog

### PlayEffects

```csharp
/// <summary>
    /// Whether to play demolition effects
    /// </summary>
    [Export] public bool PlayEffects { get; set; } = true;
```

Whether to play demolition effects

### RecoverResources

```csharp
/// <summary>
    /// Whether to recover resources from demolished buildings
    /// </summary>
    [Export] public bool RecoverResources { get; set; } = true;
```

Whether to recover resources from demolished buildings

### RecoveryPercentage

```csharp
/// <summary>
    /// Resource recovery percentage (0.0 to 1.0)
    /// </summary>
    [Export] public float RecoveryPercentage { get; set; } = 0.5f;
```

Resource recovery percentage (0.0 to 1.0)

### DemolitionEffectScene

```csharp
/// <summary>
    /// Demolition effect scene
    /// </summary>
    [Export] public PackedScene? DemolitionEffectScene { get; set; }
```

Demolition effect scene

### ConfirmationDialogScene

```csharp
/// <summary>
    /// Confirmation dialog scene
    /// </summary>
    [Export] public PackedScene? ConfirmationDialogScene { get; set; }
```

Confirmation dialog scene

### TargetBuilding

```csharp
#endregion
    
    #region Public Properties
    
    /// <summary>
    /// Currently targeted building for demolition
    /// </summary>
    public BuildingState? TargetBuilding
    {
        get => _targetBuilding;
        set => _targetBuilding = value;
    }
```

Currently targeted building for demolition

### ManipulationState

```csharp
/// <summary>
    /// Current manipulation state
    /// </summary>
    public ManipulationState? ManipulationState
    {
        get => _manipulationState;
        set => _manipulationState = value;
    }
```

Current manipulation state

### IsDemolitionActive

```csharp
/// <summary>
    /// Whether a demolition operation is currently active
    /// </summary>
    public bool IsDemolitionActive => _activeOperations.Count > 0;
```

Whether a demolition operation is currently active

### ActiveOperation

```csharp
/// <summary>
    /// Currently active demolition operation
    /// </summary>
    public DemolitionOperation? ActiveOperation => _activeOperations.Values.FirstOrDefault();
```

Currently active demolition operation


## Methods

### StartDemolition

```csharp
#endregion
    
    #region Public Methods
    
    /// <summary>
    /// Starts demolition of the target building
    /// </summary>
    /// <param name="building">Building to demolish</param>
    /// <returns>True if demolition started successfully</returns>
    public bool StartDemolition(BuildingState building)
    {
        if (!CanDemolishBuilding(building))
            return false;
            
        if (RequireConfirmation)
        {
            ShowConfirmationDialog(building);
            return true; // Started, waiting for confirmation
        }
        
        return ExecuteDemolition(building);
    }
```

Starts demolition of the target building

**Returns:** `bool`

**Parameters:**
- `BuildingState building`

### CancelDemolition

```csharp
/// <summary>
    /// Cancels the current demolition operation
    /// </summary>
    /// <param name="buildingId">ID of building to cancel demolition for</param>
    public void CancelDemolition(string buildingId)
    {
        if (_activeOperations.TryGetValue(buildingId, out var operation))
        {
            _activeOperations.Remove(buildingId);
            
            // Cancel any ongoing effects
            if (operation.EffectInstance != null)
            {
                operation.EffectInstance.QueueFree();
            }
            
            GD.Print($"Demolition cancelled for building: {buildingId}");
        }
        
        // Hide confirmation dialog if showing
        if (_currentDialog != null)
        {
            _currentDialog.QueueFree();
            _currentDialog = null;
        }
    }
```

Cancels the current demolition operation

**Returns:** `void`

**Parameters:**
- `string buildingId`

### UpdateDemolitions

```csharp
/// <summary>
    /// Updates demolition operations (called each frame)
    /// </summary>
    /// <param name="delta">Time since last frame</param>
    public void UpdateDemolitions(double delta)
    {
        var completedOperations = new List<string>();
        
        foreach (var kvp in _activeOperations)
        {
            var operation = kvp.Value;
            operation.ElapsedTime += (float)delta;
            
            if (operation.EffectInstance != null)
            {
                // Update effect if needed
                UpdateDemolitionEffect(operation);
            }
            
            // Check if demolition is complete
            if (operation.ElapsedTime >= operation.Duration)
            {
                CompleteDemolition(operation);
                completedOperations.Add(kvp.Key);
            }
        }
        
        // Remove completed operations
        foreach (var buildingId in completedOperations)
        {
            _activeOperations.Remove(buildingId);
        }
    }
```

Updates demolition operations (called each frame)

**Returns:** `void`

**Parameters:**
- `double delta`

### CalculateResourceRecovery

```csharp
/// <summary>
    /// Gets the resource recovery amount for a building
    /// </summary>
    /// <param name="building">Building to calculate recovery for</param>
    /// <returns>Dictionary of recovered resources</returns>
    public global::Godot.Collections.Dictionary CalculateResourceRecovery(BuildingState building)
    {
        var resources = new global::Godot.Collections.Dictionary();
        
        if (!RecoverResources || building == null)
            return resources;
            
        // Calculate recovered resources based on building type and cost
        // This would typically use a resource system or building data
        var baseCost = GetBuildingCost(building);
        var recoveredValue = baseCost * RecoveryPercentage;
        
        // Convert recovered value to specific resources
        // This is simplified - would use actual resource definitions
        resources["wood"] = Mathf.RoundToInt(recoveredValue * 0.4f);
        resources["stone"] = Mathf.RoundToInt(recoveredValue * 0.3f);
        resources["metal"] = Mathf.RoundToInt(recoveredValue * 0.2f);
        resources["gold"] = Mathf.RoundToInt(recoveredValue * 0.1f);
        
        return resources;
    }
```

Gets the resource recovery amount for a building

**Returns:** `global::Godot.Collections.Dictionary`

**Parameters:**
- `BuildingState building`

### _Ready

```csharp
#endregion
    
    #region Godot Lifecycle
    
    public override void _Ready()
    {
        // Initialize systems
    }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
    {
        UpdateDemolitions(delta);
    }
```

**Returns:** `void`

**Parameters:**
- `double delta`

