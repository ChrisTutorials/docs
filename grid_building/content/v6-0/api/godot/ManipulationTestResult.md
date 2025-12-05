---
title: "ManipulationTestResult"
description: "Result of a manipulation test scenario execution"
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationtestresult/"
---

# ManipulationTestResult

```csharp
GridBuilding.Godot.Test.Helpers
class ManipulationTestResult
{
    // Members...
}
```

Result of a manipulation test scenario execution

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/ManipulationTestHelpers.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Scenario

```csharp
public ManipulationTestScenario Scenario { get; set; }
```

### Success

```csharp
public bool Success { get; set; }
```

### FailureReasons

```csharp
public List<string> FailureReasons { get; set; } = new();
```

### OperationResults

```csharp
public List<ManipulationOperationResult> OperationResults { get; set; } = new();
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

