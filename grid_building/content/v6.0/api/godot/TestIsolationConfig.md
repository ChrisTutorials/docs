---
title: "TestIsolationConfig"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/testisolationconfig/"
---

# TestIsolationConfig

```csharp
GridBuilding.Godot.Tests.Isolation
class TestIsolationConfig
{
    // Members...
}
```

Configuration for test isolation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/DemoTestIsolation.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Isolation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### DefaultIsolationLevel

```csharp
public IsolationLevel DefaultIsolationLevel { get; set; } = IsolationLevel.EnvironmentOnly;
```

### AddToSceneTree

```csharp
public bool AddToSceneTree { get; set; } = true;
```

### BackupGlobalContexts

```csharp
public bool BackupGlobalContexts { get; set; } = false;
```

### BackupSceneTree

```csharp
public bool BackupSceneTree { get; set; } = false;
```

### BackupSignalConnections

```csharp
public bool BackupSignalConnections { get; set; } = false;
```

### MaxSessionDuration

```csharp
public double MaxSessionDuration { get; set; } = 300.0; // 5 minutes
```

### MonitorMemoryUsage

```csharp
public bool MonitorMemoryUsage { get; set; } = false;
```

### MaxMemoryUsage

```csharp
public long MaxMemoryUsage { get; set; } = 1024; // 1GB
```

