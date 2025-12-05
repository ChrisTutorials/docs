---
title: "NodeInfo"
description: "Node information for backup"
weight: 20
url: "/gridbuilding/v6-0/api/godot/nodeinfo/"
---

# NodeInfo

```csharp
GridBuilding.Godot.Tests.Isolation
class NodeInfo
{
    // Members...
}
```

Node information for backup

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/DemoTestIsolation.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Isolation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "";
```

### Type

```csharp
public string Type { get; set; } = "";
```

### Position

```csharp
public Vector2 Position { get; set; }
```

### Visible

```csharp
public bool Visible { get; set; }
```

### Children

```csharp
public List<NodeInfo> Children { get; set; } = new();
```

