---
title: "PlacementRuleData"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/placementruledata/"
---

# PlacementRuleData

```csharp
GridBuilding.Core.Data.Placement
class PlacementRuleData
{
    // Members...
}
```

Data structure for placement validation rules
Pure C# implementation without Godot dependencies

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/Placement/PlacementTypes.cs`  
**Namespace:** `GridBuilding.Core.Data.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RuleId

```csharp
public string RuleId { get; set; } = string.Empty;
```

### Name

```csharp
public string Name { get; set; } = string.Empty;
```

### IsActive

```csharp
public bool IsActive { get; set; } = true;
```

### Parameters

```csharp
public Dictionary<string, object> Parameters { get; set; } = new();
```

### IsValid

```csharp
public bool IsValid { get; set; } = true;
```


## Methods

### Validate

```csharp
public bool Validate(FootprintData footprint, Vector2I position)
        {
            // Default implementation - override in derived classes
            return IsValid;
        }
```

**Returns:** `bool`

**Parameters:**
- `FootprintData footprint`
- `Vector2I position`

