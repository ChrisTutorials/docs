---
title: "EnvironmentConfiguration"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/environmentconfiguration/"
---

# EnvironmentConfiguration

```csharp
GridBuilding.Godot.Tests.Factories
class EnvironmentConfiguration
{
    // Members...
}
```

Environment configuration for batch creation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/EnvironmentTestFactory.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Factories`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "";
```

### Type

```csharp
public EnvironmentType Type { get; set; }
```

### AllSystemsConfig

```csharp
public AllSystemsTestEnvironment.TestEnvironmentConfig? AllSystemsConfig { get; set; }
```

### BuildingConfig

```csharp
public BuildingTestEnvironment.BuildingTestConfig? BuildingConfig { get; set; }
```

### CollisionConfig

```csharp
public CollisionTestEnvironment.CollisionTestConfig? CollisionConfig { get; set; }
```

