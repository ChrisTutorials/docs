---
title: "LoggingConfig"
description: "Configuration for class counting logger"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/loggingconfig/"
---

# LoggingConfig

```csharp
GridBuilding.Godot.Core.Logging
class LoggingConfig
{
    // Members...
}
```

Configuration for class counting logger

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Godot.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnableClassCounting

```csharp
public static bool EnableClassCounting { get; set; } = true;
```

### EnableDetailedAnalysis

```csharp
public static bool EnableDetailedAnalysis { get; set; } = true;
```

### EnablePerformanceTracking

```csharp
public static bool EnablePerformanceTracking { get; set; } = true;
```

### MaxEntriesToLog

```csharp
public static int MaxEntriesToLog { get; set; } = 100;
```

### MinimumLogLevel

```csharp
public static LogLevel MinimumLogLevel { get; set; } = LogLevel.Debug;
```

