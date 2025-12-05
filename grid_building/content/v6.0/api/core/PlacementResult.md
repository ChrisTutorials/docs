---
title: "PlacementResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placementresult/"
---

# PlacementResult

```csharp
GridBuilding.Core.Services.Placement
class PlacementResult
{
    // Members...
}
```

Result of a placement operation containing execution outcome and metadata.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Placement/PlacementResult.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsSuccess

```csharp
/// <summary>
    /// Gets whether the placement operation was successful.
    /// </summary>
    public bool IsSuccess { get; private set; }
```

Gets whether the placement operation was successful.

### PlacedInstance

```csharp
/// <summary>
    /// Gets the placed instance if successful, null otherwise.
    /// Note: This is set by the Godot layer after scene instantiation.
    /// </summary>
    public object? PlacedInstance { get; set; }
```

Gets the placed instance if successful, null otherwise.
Note: This is set by the Godot layer after scene instantiation.

### Placeable

```csharp
/// <summary>
    /// Gets the placeable that was attempted to be placed.
    /// </summary>
    public Placeable Placeable { get; private set; }
```

Gets the placeable that was attempted to be placed.

### Position

```csharp
/// <summary>
    /// Gets the target position where placement was attempted.
    /// </summary>
    public Vector2 Position { get; private set; }
```

Gets the target position where placement was attempted.

### Placer

```csharp
/// <summary>
    /// Gets the entity that performed the placement.
    /// </summary>
    public GBOwner Placer { get; private set; }
```

Gets the entity that performed the placement.

### Errors

```csharp
/// <summary>
    /// Gets collection of errors if placement failed.
    /// </summary>
    public IReadOnlyList<string> Errors => _errors;
```

Gets collection of errors if placement failed.


## Methods

### Success

```csharp
/// <summary>
    /// Creates a successful placement result.
    /// </summary>
    /// <param name="placeable">The placeable</param>
    /// <param name="position">Target position</param>
    /// <param name="placer">The placer</param>
    /// <returns>Successful placement result</returns>
    public static PlacementResult Success(Placeable placeable, Vector2 position, GBOwner placer)
    {
        return new PlacementResult(placeable, position, placer, true);
    }
```

Creates a successful placement result.

**Returns:** `PlacementResult`

**Parameters:**
- `Placeable placeable`
- `Vector2 position`
- `GBOwner placer`

### Failed

```csharp
/// <summary>
    /// Creates a failed placement result with errors.
    /// </summary>
    /// <param name="placeable">The placeable</param>
    /// <param name="position">Target position</param>
    /// <param name="placer">The placer</param>
    /// <param name="errors">Collection of error messages</param>
    /// <returns>Failed placement result</returns>
    public static PlacementResult Failed(Placeable placeable, Vector2 position, GBOwner placer, IEnumerable<string> errors)
    {
        var result = new PlacementResult(placeable, position, placer, false);
        result._errors.AddRange(errors);
        return result;
    }
```

Creates a failed placement result with errors.

**Returns:** `PlacementResult`

**Parameters:**
- `Placeable placeable`
- `Vector2 position`
- `GBOwner placer`
- `IEnumerable<string> errors`

### Failed

```csharp
/// <summary>
    /// Creates a failed placement result with a single error.
    /// </summary>
    /// <param name="placeable">The placeable</param>
    /// <param name="position">Target position</param>
    /// <param name="placer">The placer</param>
    /// <param name="error">Error message</param>
    /// <returns>Failed placement result</returns>
    public static PlacementResult Failed(Placeable placeable, Vector2 position, GBOwner placer, string error)
    {
        return Failed(placeable, position, placer, new[] { error });
    }
```

Creates a failed placement result with a single error.

**Returns:** `PlacementResult`

**Parameters:**
- `Placeable placeable`
- `Vector2 position`
- `GBOwner placer`
- `string error`

### AddError

```csharp
/// <summary>
    /// Adds an error to the result.
    /// </summary>
    /// <param name="error">Error message to add</param>
    public void AddError(string error)
    {
        if (!string.IsNullOrEmpty(error))
        {
            _errors.Add(error);
            IsSuccess = false;
        }
    }
```

Adds an error to the result.

**Returns:** `void`

**Parameters:**
- `string error`

### ToString

```csharp
/// <summary>
    /// Gets a string summary of the placement result.
    /// </summary>
    /// <returns>Summary string</returns>
    public override string ToString()
    {
        if (IsSuccess)
        {
            return $"Placement successful: {Placeable.DisplayName} at {Position}";
        }
        else
        {
            var errorSummary = string.Join(", ", _errors);
            return $"Placement failed: {Placeable.DisplayName} at {Position} - {errorSummary}";
        }
    }
```

Gets a string summary of the placement result.

**Returns:** `string`

