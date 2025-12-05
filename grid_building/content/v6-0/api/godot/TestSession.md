---
title: "TestSession"
description: "Isolated test session"
weight: 20
url: "/gridbuilding/v6-0/api/godot/testsession/"
---

# TestSession

```csharp
GridBuilding.Godot.Tests.Isolation
class TestSession
{
    // Members...
}
```

Isolated test session

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/DemoTestIsolation.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Isolation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; set; } = "";
```

### TestType

```csharp
public TestType TestType { get; set; }
```

### StartTime

```csharp
public double StartTime { get; set; }
```

### IsolationLevel

```csharp
public IsolationLevel IsolationLevel { get; set; }
```

### IsolatedEnvironment

```csharp
public Node? IsolatedEnvironment { get; set; }
```

### SessionData

```csharp
public Dictionary<string, object> SessionData { get; set; } = new();
```

