---
title: "PlacementValidationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/placementvalidationresult/"
---

# PlacementValidationResult

```csharp
GridBuilding.Core.Services.Manipulation
class PlacementValidationResult
{
    // Members...
}
```

Placement validation result

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/PlacementManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; set; }
```

### Position

```csharp
public Vector2I Position { get; set; }
```

### ValidationErrors

```csharp
public List<string> ValidationErrors { get; set; } = new();
```


## Methods

### Failed

```csharp
public static PlacementValidationResult Failed(string error)
            {
                return new PlacementValidationResult
                {
                    IsValid = false,
                    ValidationErrors = { error }
                };
            }
```

**Returns:** `PlacementValidationResult`

**Parameters:**
- `string error`

