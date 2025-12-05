---
title: "MoveWorkflowState"
description: "Represents the state of a move workflow"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/moveworkflowstate/"
---

# MoveWorkflowState

```csharp
GridBuilding.Core.Services.Manipulation
class MoveWorkflowState
{
    // Members...
}
```

Represents the state of a move workflow

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/MoveWorkflowManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### WorkflowId

```csharp
public string WorkflowId { get; set; } = string.Empty;
```

### ManipulationId

```csharp
public string ManipulationId { get; set; } = string.Empty;
```

### TargetObjectId

```csharp
public string TargetObjectId { get; set; } = string.Empty;
```

### OriginalPosition

```csharp
public Vector2I OriginalPosition { get; set; }
```

### CurrentPosition

```csharp
public Vector2I CurrentPosition { get; set; }
```

### StartTime

```csharp
public DateTime StartTime { get; set; }
```

### LastUpdateTime

```csharp
public DateTime LastUpdateTime { get; set; }
```

### EndTime

```csharp
public DateTime? EndTime { get; set; }
```

### IsActive

```csharp
public bool IsActive { get; set; }
```

### Duration

```csharp
public TimeSpan Duration => EndTime.HasValue ? EndTime.Value - StartTime : DateTime.UtcNow - StartTime;
```

### MoveDelta

```csharp
public Vector2I MoveDelta => CurrentPosition - OriginalPosition;
```


## Methods

### ToString

```csharp
public override string ToString()
            {
                return $"MoveWorkflow({WorkflowId}: {TargetObjectId} from {OriginalPosition} to {CurrentPosition}, Active: {IsActive})";
            }
```

**Returns:** `string`

