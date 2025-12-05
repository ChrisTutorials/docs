---
title: "BuildingSystem"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/buildingsystem/"
---

# BuildingSystem

```csharp
GridBuilding.Core.Systems.Building
class BuildingSystem
{
    // Members...
}
```

Core building system that handles placement of objects in the game world.
Pure C# implementation without Godot dependencies for unit testing.
Responsibilities:
- Manages preview creation and placement validation
- Handles build actions and generates BuildActionData
- Coordinates with placement validation system
- Emits events for build success/failure
Ported from: godot/addons/grid_building/systems/building/building_system.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Placement/Building.cs/BuildingSystem.cs`  
**Namespace:** `GridBuilding.Core.Systems.Building`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PlacedParent

```csharp
#endregion

    #region Properties

    /// <summary>
    /// The parent node where placed objects will be added.
    /// </summary>
    public object? PlacedParent { get; private set; }
```

The parent node where placed objects will be added.

### Preview

```csharp
/// <summary>
    /// The current preview instance.
    /// </summary>
    public object? Preview { get; private set; }
```

The current preview instance.

### BuildingState

```csharp
/// <summary>
    /// The building state for tracking building operations.
    /// </summary>
    public IBuildingState BuildingState { get; private set; }
```

The building state for tracking building operations.

### PlacementContext

```csharp
/// <summary>
    /// The placement context for validation.
    /// </summary>
    public IPlacementContext? PlacementContext { get; private set; }
```

The placement context for validation.


## Methods

### SetPlacementContext

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Sets the placement context for validation.
    /// </summary>
    /// <param name="context">The placement context</param>
    public void SetPlacementContext(IPlacementContext context)
    {
        PlacementContext = context;
    }
```

Sets the placement context for validation.

**Returns:** `void`

**Parameters:**
- `IPlacementContext context`

### SetPlacedParent

```csharp
/// <summary>
    /// Sets the parent node for placed objects.
    /// </summary>
    /// <param name="parent">The parent node</param>
    public void SetPlacedParent(object parent)
    {
        PlacedParent = parent;
        PlacedParentChanged?.Invoke(parent);
    }
```

Sets the parent node for placed objects.

**Returns:** `void`

**Parameters:**
- `object parent`

### SetPreview

```csharp
/// <summary>
    /// Sets the preview instance.
    /// </summary>
    /// <param name="preview">The preview instance</param>
    public void SetPreview(object preview)
    {
        Preview = preview;
        PreviewChanged?.Invoke(preview);
    }
```

Sets the preview instance.

**Returns:** `void`

**Parameters:**
- `object preview`

### ExecutePlacement

```csharp
/// <summary>
    /// Attempts to place the current preview object.
    /// </summary>
    /// <param name="placeable">The placeable resource being built</param>
    /// <param name="buildType">The type of build operation</param>
    /// <returns>BuildActionData with the result</returns>
    public BuildActionData ExecutePlacement(object? placeable, BuildType buildType)
    {
        if (placeable == null)
        {
            var failureReport = CreateFailurePlacementReport("Invalid placeable resource");
            var actionData = new BuildActionData(null, failureReport, buildType);
            BuildFailed?.Invoke(actionData);
            return actionData;
        }

        if (PlacementContext == null)
        {
            var failureReport = CreateFailurePlacementReport("Placement context not set");
            var actionData = new BuildActionData(placeable, failureReport, buildType);
            BuildFailed?.Invoke(actionData);
            return actionData;
        }

        // Validate placement
        var validationIssues = ValidatePlacement();
        if (validationIssues.Count > 0)
        {
            var failureReport = CreateFailurePlacementReport(string.Join("; ", validationIssues));
            var actionData = new BuildActionData(placeable, failureReport, buildType);
            BuildFailed?.Invoke(actionData);
            return actionData;
        }

        // Execute placement
        var placedObject = CreatePlacedObject(placeable);
        if (placedObject == null)
        {
            var failureReport = CreateFailurePlacementReport("Failed to create placed object");
            var actionData = new BuildActionData(placeable, failureReport, buildType);
            BuildFailed?.Invoke(actionData);
            return actionData;
        }

        // Create success report
        var successReport = CreateSuccessPlacementReport(placedObject);
        var successActionData = new BuildActionData(placeable, successReport, buildType);
        
        BuildSucceeded?.Invoke(successActionData);
        return successActionData;
    }
```

Attempts to place the current preview object.

**Returns:** `BuildActionData`

**Parameters:**
- `object? placeable`
- `BuildType buildType`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Validates the current placement setup.
    /// </summary>
    /// <returns>List of validation issues</returns>
    public List<string> GetRuntimeIssues()
    {
        var issues = new List<string>();

        if (BuildingState == null)
            issues.Add("BuildingState is not set");

        if (PlacementContext == null)
            issues.Add("PlacementContext is not set");

        if (PlacedParent == null)
            issues.Add("PlacedParent is not set");

        return issues;
    }
```

Validates the current placement setup.

**Returns:** `List<string>`

