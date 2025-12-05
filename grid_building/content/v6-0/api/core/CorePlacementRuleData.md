---
title: "CorePlacementRuleData"
description: "Core placement rule data without Godot dependencies."
weight: 10
url: "/gridbuilding/v6-0/api/core/coreplacementruledata/"
---

# CorePlacementRuleData

```csharp
GridBuilding.Core.Data.Placement
class CorePlacementRuleData
{
    // Members...
}
```

Core placement rule data without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/Placement/PlacementRuleData.cs`  
**Namespace:** `GridBuilding.Core.Data.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
/// <summary>
    /// Unique identifier for the rule.
    /// </summary>
    public string Id { get; set; } = string.Empty;
```

Unique identifier for the rule.

### Name

```csharp
/// <summary>
    /// Human-readable name of the rule.
    /// </summary>
    public string Name { get; set; } = string.Empty;
```

Human-readable name of the rule.

### Description

```csharp
/// <summary>
    /// Description of what the rule checks.
    /// </summary>
    public string Description { get; set; } = string.Empty;
```

Description of what the rule checks.

### RuleType

```csharp
/// <summary>
    /// Type of placement rule.
    /// </summary>
    public PlacementRuleType RuleType { get; set; }
```

Type of placement rule.

### IsEnabled

```csharp
/// <summary>
    /// Whether the rule is enabled.
    /// </summary>
    public bool IsEnabled { get; set; } = true;
```

Whether the rule is enabled.

### Priority

```csharp
/// <summary>
    /// Priority of the rule (higher numbers = higher priority).
    /// </summary>
    public int Priority { get; set; } = 0;
```

Priority of the rule (higher numbers = higher priority).

### Parameters

```csharp
/// <summary>
    /// Rule-specific parameters.
    /// </summary>
    public Dictionary<string, object> Parameters { get; set; } = new();
```

Rule-specific parameters.

### Tags

```csharp
/// <summary>
    /// Tags for categorizing rules.
    /// </summary>
    public List<string> Tags { get; set; } = new();
```

Tags for categorizing rules.

