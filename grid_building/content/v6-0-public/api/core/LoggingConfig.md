---
title: "LoggingConfig"
description: "Configuration for logging behavior"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/loggingconfig/"
---

# LoggingConfig

```csharp
GridBuilding.Core.Logging
class LoggingConfig
{
    // Members...
}
```

Configuration for logging behavior

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Logging/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### WarningThreshold

```csharp
public int WarningThreshold { get; set; } = 100;
```

### CriticalThreshold

```csharp
public int CriticalThreshold { get; set; } = 1000;
```

### TrackIndividualInstances

```csharp
public bool TrackIndividualInstances { get; set; } = false;
```

### AutoRegister

```csharp
public bool AutoRegister { get; set; } = true;
```

### LogOnRegistration

```csharp
public bool LogOnRegistration { get; set; } = false;
```

