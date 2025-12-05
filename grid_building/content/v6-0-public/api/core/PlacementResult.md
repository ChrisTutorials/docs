---
title: "PlacementResult"
description: "Result of a building placement operation
Contains success status, position, and any relevant metadata"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placementresult/"
---

# PlacementResult

```csharp
GridBuilding.Core.Results
class PlacementResult
{
    // Members...
}
```

Result of a building placement operation
Contains success status, position, and any relevant metadata

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Placement/PlacementResult.cs`  
**Namespace:** `GridBuilding.Core.Results`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Success

```csharp
#region Properties
    
    /// <summary>
    /// Whether the placement was successful
    /// </summary>
    public bool Success { get; set; }
```

Whether the placement was successful

### GridPosition

```csharp
/// <summary>
    /// The grid position where placement was attempted
    /// </summary>
    public Types.Vector2I GridPosition { get; set; }
```

The grid position where placement was attempted

### WorldPosition

```csharp
/// <summary>
    /// World position of the placement
    /// </summary>
    public Types.Vector2 WorldPosition { get; set; }
```

World position of the placement

### Messages

```csharp
/// <summary>
    /// Any messages or errors related to the placement
    /// </summary>
    public List<string> Messages { get; set; } = new();
```

Any messages or errors related to the placement

### Metadata

```csharp
/// <summary>
    /// Additional metadata about the placement
    /// </summary>
    public Dictionary<string, object> Metadata { get; set; } = new();
```

Additional metadata about the placement


## Methods

### Successful

```csharp
#endregion
    
    #region Factory Methods
    
    /// <summary>
    /// Creates a successful placement result
    /// </summary>
    public static PlacementResult Successful(Types.Vector2I gridPosition, Types.Vector2 worldPosition)
    {
        return new PlacementResult(true, gridPosition, worldPosition);
    }
```

Creates a successful placement result

**Returns:** `PlacementResult`

**Parameters:**
- `Types.Vector2I gridPosition`
- `Types.Vector2 worldPosition`

### Failed

```csharp
/// <summary>
    /// Creates a failed placement result with a message
    /// </summary>
    public static PlacementResult Failed(Types.Vector2I gridPosition, Types.Vector2 worldPosition, string message)
    {
        var result = new PlacementResult(false, gridPosition, worldPosition);
        result.Messages.Add(message);
        return result;
    }
```

Creates a failed placement result with a message

**Returns:** `PlacementResult`

**Parameters:**
- `Types.Vector2I gridPosition`
- `Types.Vector2 worldPosition`
- `string message`

### Failed

```csharp
/// <summary>
    /// Creates a failed placement result with multiple messages
    /// </summary>
    public static PlacementResult Failed(Types.Vector2I gridPosition, Types.Vector2 worldPosition, IEnumerable<string> messages)
    {
        var result = new PlacementResult(false, gridPosition, worldPosition);
        result.Messages.AddRange(messages);
        return result;
    }
```

Creates a failed placement result with multiple messages

**Returns:** `PlacementResult`

**Parameters:**
- `Types.Vector2I gridPosition`
- `Types.Vector2 worldPosition`
- `IEnumerable<string> messages`

