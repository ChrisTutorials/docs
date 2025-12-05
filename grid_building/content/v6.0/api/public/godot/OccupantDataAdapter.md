---
title: "OccupantDataAdapter"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/occupantdataadapter/"
---

# OccupantDataAdapter

```csharp
GridBuilding.Godot.Systems.Placement.Adapters
class OccupantDataAdapter
{
    // Members...
}
```

Adapter for Godot occupant data to Core IOccupantData interface.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Adapters/GridOccupancyAdapter.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Adapters`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id => _occupant?.GetInstanceId().ToString() ?? "unknown";
```

### Type

```csharp
public string Type => _occupant?.GetType().Name ?? "unknown";
```

### BlocksPlacement

```csharp
public bool BlocksPlacement => true; // Default assumption
```

### Properties

```csharp
public Dictionary<string, object> Properties => new()
    {
        { "godot_type", Type },
        { "instance_id", Id }
    };
```

