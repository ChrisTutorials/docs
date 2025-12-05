---
title: "SystemsContext"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/systemscontext/"
---

# SystemsContext

```csharp
GridBuilding.Core.Contexts
class SystemsContext
{
    // Members...
}
```

Holds references to the systems used in grid building operations.
This context allows for easy access to the systems without needing to
pass them around manually.
Ported from: godot/addons/grid_building/core/contexts/gb_systems_context.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Common/SystemsContext.cs`  
**Namespace:** `GridBuilding.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetBuildingSystem

```csharp
#region System Getters

    public IBuildingSystem? GetBuildingSystem() => _buildingSystem;
```

**Returns:** `IBuildingSystem?`

### GetGridTargetingSystem

```csharp
public IGridTargetingSystem? GetGridTargetingSystem() => _gridTargetingSystem;
```

**Returns:** `IGridTargetingSystem?`

### GetManipulationSystem

```csharp
public IManipulationSystem? GetManipulationSystem() => _manipulationSystem;
```

**Returns:** `IManipulationSystem?`

### SetSystem

```csharp
#endregion

    #region System Setters

    /// <summary>
    /// Sets the passed system as an active system within the context's scope.
    /// Automatically detects the system type and assigns appropriately.
    /// </summary>
    public void SetSystem(ISystem system)
    {
        switch (system)
        {
            case IBuildingSystem buildingSystem:
                if (_buildingSystem != buildingSystem)
                {
                    _buildingSystem = buildingSystem;
                    BuildingSystemChanged?.Invoke(buildingSystem);
                }
                break;

            case IGridTargetingSystem gridTargetingSystem:
                if (_gridTargetingSystem != gridTargetingSystem)
                {
                    _gridTargetingSystem = gridTargetingSystem;
                    GridTargetingSystemChanged?.Invoke(gridTargetingSystem);
                }
                break;

            case IManipulationSystem manipulationSystem:
                if (_manipulationSystem != manipulationSystem)
                {
                    _manipulationSystem = manipulationSystem;
                    ManipulationSystemChanged?.Invoke(manipulationSystem);
                }
                break;

            default:
                _logger?.LogWarning($"Attempted to set unknown system type: {system.GetType().Name}");
                break;
        }
    }
```

Sets the passed system as an active system within the context's scope.
Automatically detects the system type and assigns appropriately.

**Returns:** `void`

**Parameters:**
- `ISystem system`

### SetBuildingSystem

```csharp
/// <summary>
    /// Directly sets the building system
    /// </summary>
    public void SetBuildingSystem(IBuildingSystem? system)
    {
        if (_buildingSystem != system)
        {
            _buildingSystem = system;
            BuildingSystemChanged?.Invoke(system);
        }
    }
```

Directly sets the building system

**Returns:** `void`

**Parameters:**
- `IBuildingSystem? system`

### SetGridTargetingSystem

```csharp
/// <summary>
    /// Directly sets the grid targeting system
    /// </summary>
    public void SetGridTargetingSystem(IGridTargetingSystem? system)
    {
        if (_gridTargetingSystem != system)
        {
            _gridTargetingSystem = system;
            GridTargetingSystemChanged?.Invoke(system);
        }
    }
```

Directly sets the grid targeting system

**Returns:** `void`

**Parameters:**
- `IGridTargetingSystem? system`

### SetManipulationSystem

```csharp
/// <summary>
    /// Directly sets the manipulation system
    /// </summary>
    public void SetManipulationSystem(IManipulationSystem? system)
    {
        if (_manipulationSystem != system)
        {
            _manipulationSystem = system;
            ManipulationSystemChanged?.Invoke(system);
        }
    }
```

Directly sets the manipulation system

**Returns:** `void`

**Parameters:**
- `IManipulationSystem? system`

### GetEditorIssues

```csharp
#endregion

    #region Issue Detection

    public List<string> GetEditorIssues()
    {
        return new List<string>();
    }
```

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
public List<string> GetRuntimeIssues(IRuntimeChecks? checks = null)
    {
        var issues = new List<string>();

        issues.AddRange(GetEditorIssues());

        if (checks == null)
        {
            issues.Add("RuntimeChecks is null, skipping all extra runtime checks");
            return issues;
        }

        if (checks.BuildingSystem && _buildingSystem == null)
        {
            issues.Add("Building system is not set");
        }

        if (checks.GridTargetingSystem && _gridTargetingSystem == null)
        {
            issues.Add("Grid targeting system is not set");
        }

        if (checks.ManipulationSystem && _manipulationSystem == null)
        {
            issues.Add("Manipulation system is not set");
        }

        return issues;
    }
```

**Returns:** `List<string>`

**Parameters:**
- `IRuntimeChecks? checks`

