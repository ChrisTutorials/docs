---
title: "EnvironmentFactoryConfig"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/environmentfactoryconfig/"
---

# EnvironmentFactoryConfig

```csharp
GridBuilding.Godot.Tests.Factories
class EnvironmentFactoryConfig
{
    // Members...
}
```

Configuration for environment factory

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/EnvironmentTestFactory.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Factories`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DefaultGridSize

```csharp
public Vector2I DefaultGridSize { get; set; } = new Vector2I(10, 10);
```

### DefaultTileSize

```csharp
public Vector2 DefaultTileSize { get; set; } = new Vector2(32, 32);
```

### DefaultMaxLogEntries

```csharp
public int DefaultMaxLogEntries { get; set; } = 100;
```

### DefaultAutoScroll

```csharp
public bool DefaultAutoScroll { get; set; } = true;
```

### DefaultCollisionChecking

```csharp
public bool DefaultCollisionChecking { get; set; } = true;
```

### DefaultMaxBuildings

```csharp
public int DefaultMaxBuildings { get; set; } = 50;
```

### DefaultPerformanceTesting

```csharp
public bool DefaultPerformanceTesting { get; set; } = true;
```

### DefaultPerformanceIterations

```csharp
public int DefaultPerformanceIterations { get; set; } = 1000;
```

