---
title: "TestResult"
description: "Individual test result data"
weight: 20
url: "/gridbuilding/v6-0/api/godot/testresult/"
---

# TestResult

```csharp
GridBuilding.Godot.Tests.Inventory
class TestResult
{
    // Members...
}
```

Individual test result data

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/InventoryTestRunner.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Inventory`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Category

```csharp
public string Category { get; set; } = "";
```

### TestName

```csharp
public string TestName { get; set; } = "";
```

### Status

```csharp
public TestStatus Status { get; set; } = TestStatus.Failed;
```

### ErrorMessage

```csharp
public string ErrorMessage { get; set; } = "";
```

### ExecutionTime

```csharp
public long ExecutionTime { get; set; } = 0;
```

### Timestamp

```csharp
public double Timestamp { get; set; } = 0;
```

