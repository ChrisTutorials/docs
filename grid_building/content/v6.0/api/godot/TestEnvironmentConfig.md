---
title: "TestEnvironmentConfig"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/testenvironmentconfig/"
---

# TestEnvironmentConfig

```csharp
GridBuilding.Godot.Tests.Environments
class TestEnvironmentConfig
{
    // Members...
}
```

Configuration for the test environment

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/AllSystemsTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GridSize

```csharp
public Vector2I GridSize { get; set; } = new Vector2I(10, 10);
```

### TileSize

```csharp
public Vector2 TileSize { get; set; } = new Vector2(16, 16);
```

### MaxLogEntries

```csharp
public int MaxLogEntries { get; set; } = 100;
```

### AutoScroll

```csharp
public bool AutoScroll { get; set; } = true;
```

