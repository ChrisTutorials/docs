---
title: "ClassCountDiffReport"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/classcountdiffreport/"
---

# ClassCountDiffReport

```csharp
GridBuilding.Godot.Test.GridBuilding.Helpers.Utils.Diagnostics
class ClassCountDiffReport
{
    // Members...
}
```

Comprehensive diff report for class count changes.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Godot.Test.GridBuilding.Helpers.Utils.Diagnostics`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Increases

```csharp
public Dictionary<string, int> Increases { get; set; } = new();
```

### Decreases

```csharp
public Dictionary<string, int> Decreases { get; set; } = new();
```

### Unchanged

```csharp
public Dictionary<string, int> Unchanged { get; set; } = new();
```

### Added

```csharp
public List<string> Added { get; set; } = new();
```

### Removed

```csharp
public List<string> Removed { get; set; } = new();
```

### TotalIncrease

```csharp
public int TotalIncrease { get; set; }
```

### TotalDecrease

```csharp
public int TotalDecrease { get; set; }
```

### NetChange

```csharp
public int NetChange { get; set; }
```

