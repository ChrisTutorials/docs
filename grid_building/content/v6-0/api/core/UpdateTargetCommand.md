---
title: "UpdateTargetCommand"
description: "Command to update target position"
weight: 10
url: "/gridbuilding/v6-0/api/core/updatetargetcommand/"
---

# UpdateTargetCommand

```csharp
GridBuilding.Core.State.Manipulation
class UpdateTargetCommand
{
    // Members...
}
```

Command to update target position

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationCommands.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CommandType

```csharp
public string CommandType => "UpdateTarget";
```

### Data

```csharp
public ManipulationState? Data { get; }
```

### NewTarget

```csharp
/// <summary>
        /// New target position
        /// </summary>
        public Vector2I NewTarget => Data?.GridTarget ?? Vector2I.Zero;
```

New target position

### IsValidPlacement

```csharp
/// <summary>
        /// Whether placement is valid at current position
        /// </summary>
        public bool IsValidPlacement => Data?.IsValid == true;
```

Whether placement is valid at current position

### AffectedTiles

```csharp
/// <summary>
        /// Affected tiles at current position
        /// </summary>
        public List<Vector2I> AffectedTiles => Data?.AffectedTiles ?? new List<Vector2I>();
```

Affected tiles at current position

