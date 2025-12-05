---
title: "DiagnosticReport"
description: "Comprehensive diagnostic report"
weight: 20
url: "/gridbuilding/v6-0/api/godot/diagnosticreport/"
---

# DiagnosticReport

```csharp
GridBuilding.Godot.Test.Helpers
class DiagnosticReport
{
    // Members...
}
```

Comprehensive diagnostic report

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GBTestDiagnostics.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Environment

```csharp
public Node Environment { get; set; }
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

### Success

```csharp
public bool Success { get; set; }
```

### ErrorMessage

```csharp
public string ErrorMessage { get; set; } = string.Empty;
```

### HealthScore

```csharp
public int HealthScore { get; set; }
```

### EnvironmentDiagnostics

```csharp
public EnvironmentDiagnostics EnvironmentDiagnostics { get; set; }
```

### SystemsDiagnostics

```csharp
public SystemsDiagnostics SystemsDiagnostics { get; set; }
```

### PerformanceDiagnostics

```csharp
public PerformanceDiagnostics PerformanceDiagnostics { get; set; }
```

### MemoryDiagnostics

```csharp
public MemoryDiagnostics MemoryDiagnostics { get; set; }
```

### StateDiagnostics

```csharp
public StateDiagnostics StateDiagnostics { get; set; }
```

### ValidationDiagnostics

```csharp
public ValidationDiagnostics ValidationDiagnostics { get; set; }
```

### IntegrationDiagnostics

```csharp
public IntegrationDiagnostics IntegrationDiagnostics { get; set; }
```

