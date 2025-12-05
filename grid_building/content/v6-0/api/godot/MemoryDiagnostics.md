---
title: "MemoryDiagnostics"
description: "Memory diagnostics"
weight: 20
url: "/gridbuilding/v6-0/api/godot/memorydiagnostics/"
---

# MemoryDiagnostics

```csharp
GridBuilding.Godot.Test.Helpers
class MemoryDiagnostics
{
    // Members...
}
```

Memory diagnostics

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GBTestDiagnostics.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Issues

```csharp
public List<string> Issues { get; set; } = new();
```

### TotalMemoryUsage

```csharp
public long TotalMemoryUsage { get; set; }
```

### NodeMemoryUsage

```csharp
public Dictionary<string, long> NodeMemoryUsage { get; set; } = new();
```

### PotentialLeaks

```csharp
public List<string> PotentialLeaks { get; set; } = new();
```

### MemoryPatterns

```csharp
public Dictionary<string, object> MemoryPatterns { get; set; } = new();
```

