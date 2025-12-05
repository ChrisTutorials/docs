---
title: "DemolishWorkflowState"
description: "Represents the state of a demolish workflow"
weight: 10
url: "/gridbuilding/v6-0/api/core/demolishworkflowstate/"
---

# DemolishWorkflowState

```csharp
GridBuilding.Core.Services.Manipulation
class DemolishWorkflowState
{
    // Members...
}
```

Represents the state of a demolish workflow

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/DemolishManager.cs`  
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

### TargetPosition

```csharp
public Vector2I TargetPosition { get; set; }
```

### ObjectSize

```csharp
public Vector2I ObjectSize { get; set; } = Vector2I.One;
```

### StartTime

```csharp
public DateTime StartTime { get; set; }
```

### ConfirmationTime

```csharp
public DateTime? ConfirmationTime { get; set; }
```

### EndTime

```csharp
public DateTime? EndTime { get; set; }
```

### IsActive

```csharp
public bool IsActive { get; set; }
```

### RequiresConfirmation

```csharp
public bool RequiresConfirmation { get; set; }
```

### IsConfirmed

```csharp
public bool IsConfirmed { get; set; }
```

### Duration

```csharp
public TimeSpan Duration => EndTime.HasValue ? EndTime.Value - StartTime : DateTime.UtcNow - StartTime;
```


## Methods

### ToString

```csharp
public override string ToString()
            {
                return $"DemolishWorkflow({WorkflowId}: {TargetObjectId} at {TargetPosition}, Confirmed: {IsConfirmed}, Active: {IsActive})";
            }
```

**Returns:** `string`

