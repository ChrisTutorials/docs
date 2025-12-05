---
title: "ManipulationStatusExtensions"
description: "Extension methods for ManipulationStatus enum."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/manipulationstatusextensions/"
---

# ManipulationStatusExtensions

```csharp
GridBuilding.Core.Types
class ManipulationStatusExtensions
{
    // Members...
}
```

Extension methods for ManipulationStatus enum.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ManipulationStatus.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToDisplayString

```csharp
/// <summary>
    /// Converts ManipulationStatus to display string.
    /// </summary>
    public static string ToDisplayString(this ManipulationStatus status) => status switch
    {
        ManipulationStatus.Created => "CREATED",
        ManipulationStatus.Started => "STARTED",
        ManipulationStatus.Failed => "FAILED",
        ManipulationStatus.Finished => "FINISHED",
        ManipulationStatus.Canceled => "CANCELED",
        _ => status.ToString()
    };
```

Converts ManipulationStatus to display string.

**Returns:** `string`

**Parameters:**
- `ManipulationStatus status`

### IsTerminal

```csharp
/// <summary>
    /// Returns true if this is a terminal state (no more transitions expected).
    /// </summary>
    public static bool IsTerminal(this ManipulationStatus status) =>
        status == ManipulationStatus.Failed ||
        status == ManipulationStatus.Finished ||
        status == ManipulationStatus.Canceled;
```

Returns true if this is a terminal state (no more transitions expected).

**Returns:** `bool`

**Parameters:**
- `ManipulationStatus status`

### IsSuccess

```csharp
/// <summary>
    /// Returns true if this indicates a successful outcome.
    /// </summary>
    public static bool IsSuccess(this ManipulationStatus status) =>
        status == ManipulationStatus.Finished;
```

Returns true if this indicates a successful outcome.

**Returns:** `bool`

**Parameters:**
- `ManipulationStatus status`

### IsActive

```csharp
/// <summary>
    /// Returns true if this is an active/in-progress state.
    /// </summary>
    public static bool IsActive(this ManipulationStatus status) =>
        status == ManipulationStatus.Started;
```

Returns true if this is an active/in-progress state.

**Returns:** `bool`

**Parameters:**
- `ManipulationStatus status`

