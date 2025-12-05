---
title: "ManipulationPhaseExtensions"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/manipulationphaseextensions/"
---

# ManipulationPhaseExtensions

```csharp
GridBuilding.Core.Types
class ManipulationPhaseExtensions
{
    // Members...
}
```

Extension methods for ManipulationPhase enum.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ManipulationPhase.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToDisplayString

```csharp
/// <summary>
    /// Converts ManipulationPhase to display string.
    /// </summary>
    public static string ToDisplayString(this ManipulationPhase phase) => phase switch
    {
        ManipulationPhase.None => "NONE",
        ManipulationPhase.Starting => "STARTING",
        ManipulationPhase.Active => "ACTIVE",
        ManipulationPhase.Finalizing => "FINALIZING",
        ManipulationPhase.Completed => "COMPLETED",
        ManipulationPhase.Cancelled => "CANCELLED",
        _ => phase.ToString()
    };
```

Converts ManipulationPhase to display string.

**Returns:** `string`

**Parameters:**
- `ManipulationPhase phase`

### IsActivePhase

```csharp
/// <summary>
    /// Returns true if the phase is an active manipulation phase.
    /// </summary>
    public static bool IsActivePhase(this ManipulationPhase phase) =>
        phase == ManipulationPhase.Starting || phase == ManipulationPhase.Active || phase == ManipulationPhase.Finalizing;
```

Returns true if the phase is an active manipulation phase.

**Returns:** `bool`

**Parameters:**
- `ManipulationPhase phase`

### IsTerminalPhase

```csharp
/// <summary>
    /// Returns true if the phase is a terminal phase (completed or cancelled).
    /// </summary>
    public static bool IsTerminalPhase(this ManipulationPhase phase) =>
        phase == ManipulationPhase.Completed || phase == ManipulationPhase.Cancelled;
```

Returns true if the phase is a terminal phase (completed or cancelled).

**Returns:** `bool`

**Parameters:**
- `ManipulationPhase phase`

### CanCancel

```csharp
/// <summary>
    /// Returns true if the phase can be cancelled.
    /// </summary>
    public static bool CanCancel(this ManipulationPhase phase) =>
        phase == ManipulationPhase.Starting || phase == ManipulationPhase.Active;
```

Returns true if the phase can be cancelled.

**Returns:** `bool`

**Parameters:**
- `ManipulationPhase phase`

