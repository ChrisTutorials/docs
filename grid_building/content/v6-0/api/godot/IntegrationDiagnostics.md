---
title: "IntegrationDiagnostics"
description: "Integration diagnostics"
weight: 20
url: "/gridbuilding/v6-0/api/godot/integrationdiagnostics/"
---

# IntegrationDiagnostics

```csharp
GridBuilding.Godot.Test.Helpers
class IntegrationDiagnostics
{
    // Members...
}
```

Integration diagnostics

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

### CoreGodotIntegration

```csharp
public Dictionary<string, object> CoreGodotIntegration { get; set; } = new();
```

### SignalConnections

```csharp
public Dictionary<string, object> SignalConnections { get; set; } = new();
```

### DependencyInjection

```csharp
public Dictionary<string, object> DependencyInjection { get; set; } = new();
```

