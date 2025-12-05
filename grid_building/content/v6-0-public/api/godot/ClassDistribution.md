---
title: "ClassDistribution"
description: "Class distribution analysis"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/classdistribution/"
---

# ClassDistribution

```csharp
GridBuilding.Godot.Core.Logging
class ClassDistribution
{
    // Members...
}
```

Class distribution analysis

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Godot.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TotalCoreClasses

```csharp
public int TotalCoreClasses { get; set; }
```

### TotalGodotClasses

```csharp
public int TotalGodotClasses { get; set; }
```

### TotalTestClasses

```csharp
public int TotalTestClasses { get; set; }
```

### TotalSystemClasses

```csharp
public int TotalSystemClasses { get; set; }
```

### TotalClasses

```csharp
public int TotalClasses { get; set; }
```

### CorePercentage

```csharp
public float CorePercentage { get; set; }
```

### GodotPercentage

```csharp
public float GodotPercentage { get; set; }
```

### TestPercentage

```csharp
public float TestPercentage { get; set; }
```

### MostCommonCoreClass

```csharp
public string MostCommonCoreClass { get; set; }
```

### MostCommonGodotClass

```csharp
public string MostCommonGodotClass { get; set; }
```

