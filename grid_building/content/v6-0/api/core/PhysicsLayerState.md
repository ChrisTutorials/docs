---
title: "PhysicsLayerState"
description: "Represents the state of physics layers for an object"
weight: 10
url: "/gridbuilding/v6-0/api/core/physicslayerstate/"
---

# PhysicsLayerState

```csharp
GridBuilding.Core.Services.Manipulation
class PhysicsLayerState
{
    // Members...
}
```

Represents the state of physics layers for an object

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Manipulation/PhysicsLayerManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ObjectId

```csharp
public string ObjectId { get; set; } = string.Empty;
```

### DisabledLayers

```csharp
public List<int> DisabledLayers { get; set; } = new();
```

### OriginalLayers

```csharp
public List<int> OriginalLayers { get; set; } = new();
```

### Timestamp

```csharp
public DateTime Timestamp { get; set; }
```

### Duration

```csharp
public TimeSpan Duration => DateTime.UtcNow - Timestamp;
```


## Methods

### ToString

```csharp
public override string ToString()
            {
                return $"PhysicsLayerState({ObjectId}: Disabled[{string.Join(",", DisabledLayers)}] -> Original[{string.Join(",", OriginalLayers)}])";
            }
```

**Returns:** `string`

