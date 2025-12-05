---
title: "IndicatorContext"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/indicatorcontext/"
---

# IndicatorContext

```csharp
GridBuilding.Core.Contexts
class IndicatorContext
{
    // Members...
}
```

Wrapper for accessing the active IndicatorManager at runtime.
The indicator manager creates and manages RuleCheckIndicators for the given context scope.
Ported from: godot/addons/grid_building/core/contexts/indicator_context.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Building/IndicatorContext.cs`  
**Namespace:** `GridBuilding.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetManager

```csharp
/// <summary>
    /// Gets the current indicator manager
    /// </summary>
    /// <returns>The indicator manager, or null if not set</returns>
    /// <exception cref="InvalidOperationException">Thrown if manager is not set</exception>
    public IIndicatorManager GetManager()
    {
        if (_indicatorManager == null)
        {
            throw new InvalidOperationException("IndicatorManager has not been set in IndicatorContext.");
        }
        return _indicatorManager;
    }
```

Gets the current indicator manager

**Returns:** `IIndicatorManager`

### GetManagerOrNull

```csharp
/// <summary>
    /// Gets the indicator manager, or null if not set (does not throw)
    /// </summary>
    public IIndicatorManager? GetManagerOrNull() => _indicatorManager;
```

Gets the indicator manager, or null if not set (does not throw)

**Returns:** `IIndicatorManager?`

### SetManager

```csharp
/// <summary>
    /// Sets the indicator manager
    /// </summary>
    /// <param name="manager">The new indicator manager</param>
    public void SetManager(IIndicatorManager? manager)
    {
        if (_indicatorManager == manager)
        {
            return;
        }

        _indicatorManager = manager;
        ManagerChanged?.Invoke(_indicatorManager);
    }
```

Sets the indicator manager

**Returns:** `void`

**Parameters:**
- `IIndicatorManager? manager`

### HasManager

```csharp
/// <summary>
    /// Checks if a manager has been set
    /// </summary>
    public bool HasManager() => _indicatorManager != null;
```

Checks if a manager has been set

**Returns:** `bool`

### ValidatePlacement

```csharp
/// <summary>
    /// Delegates to the indicator manager to validate placement
    /// </summary>
    /// <returns>Validation results from the manager</returns>
    public IndicatorValidationResults ValidatePlacement()
    {
        if (_indicatorManager == null)
        {
            return IndicatorValidationResults.Failure("IndicatorManager not set");
        }
        return _indicatorManager.ValidatePlacement();
    }
```

Delegates to the indicator manager to validate placement

**Returns:** `IndicatorValidationResults`

### GetEditorIssues

```csharp
/// <summary>
    /// Gets issues found during editor validation
    /// </summary>
    public List<string> GetEditorIssues()
    {
        // NOTE: IndicatorManager assignment is a runtime-only check
        return new List<string>();
    }
```

Gets issues found during editor validation

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Gets issues found during runtime validation
    /// </summary>
    public List<string> GetRuntimeIssues()
    {
        var issues = new List<string>();

        if (_indicatorManager == null)
        {
            issues.Add("IndicatorManager is not assigned in IndicatorContext");
        }

        return issues;
    }
```

Gets issues found during runtime validation

**Returns:** `List<string>`

