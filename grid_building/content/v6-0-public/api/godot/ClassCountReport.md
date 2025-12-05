---
title: "ClassCountReport"
description: "Report from class counting analysis"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/classcountreport/"
---

# ClassCountReport

```csharp
GridBuilding.Godot.Core.Logging
class ClassCountReport
{
    // Members...
}
```

Report from class counting analysis

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Godot.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### StartTime

```csharp
public DateTime StartTime { get; set; }
```

### EndTime

```csharp
public DateTime EndTime { get; set; }
```

### Duration

```csharp
public TimeSpan Duration { get; set; }
```

### Success

```csharp
public bool Success { get; set; }
```

### Message

```csharp
public string Message { get; set; } = string.Empty;
```

### RootNode

```csharp
public Node RootNode { get; set; }
```

### MinimumLogLevel

```csharp
public LogLevel MinimumLogLevel { get; set; } = LogLevel.Info;
```

### CoreClasses

```csharp
public Dictionary<string, int> CoreClasses { get; set; } = new();
```

### GodotClasses

```csharp
public Dictionary<string, int> GodotClasses { get; set; } = new();
```

### TestClasses

```csharp
public Dictionary<string, int> TestClasses { get; set; } = new();
```

### SystemClasses

```csharp
public Dictionary<string, int> SystemClasses { get; set; } = new();
```

### ClassDistribution

```csharp
public ClassDistribution ClassDistribution { get; set; }
```

### Insights

```csharp
public List<string> Insights { get; set; } = new();
```

