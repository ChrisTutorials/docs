---
title: "ClassPerformanceTracker"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/classperformancetracker/"
---

# ClassPerformanceTracker

```csharp
GridBuilding.Godot.Core.Logging
class ClassPerformanceTracker
{
    // Members...
}
```

Performance tracker for class operations

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Godot.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Enabled

```csharp
public bool Enabled { get; set; }
```

### Operation

```csharp
public string Operation { get; set; }
```

### ClassName

```csharp
public string ClassName { get; set; }
```

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


## Methods

### Stop

```csharp
public void Stop()
    {
        if (Enabled)
        {
            EndTime = DateTime.Now;
            Duration = EndTime - StartTime;
            
            GD.PrintRich($"[color=yellow]{Operation} {ClassName}: {Duration.TotalMilliseconds:F2}ms[/color]");
        }
    }
```

**Returns:** `void`

