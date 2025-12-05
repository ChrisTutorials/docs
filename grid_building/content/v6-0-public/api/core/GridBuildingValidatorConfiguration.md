---
title: "GridBuildingValidatorConfiguration"
description: "Configuration for GridBuilding validator"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/gridbuildingvalidatorconfiguration/"
---

# GridBuildingValidatorConfiguration

```csharp
GridBuilding.Core.Systems.Validation
class GridBuildingValidatorConfiguration
{
    // Members...
}
```

Configuration for GridBuilding validator

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/UnifiedGridBuildingValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name => "GridBuildingValidatorConfiguration";
```

### Version

```csharp
public Version Version => new Version(1, 0, 0);
```

### EnableCollisionValidation

```csharp
public bool EnableCollisionValidation { get; set; } = true;
```

### EnablePlacementValidation

```csharp
public bool EnablePlacementValidation { get; set; } = true;
```

### EnableGridValidation

```csharp
public bool EnableGridValidation { get; set; } = true;
```

### EnableManipulationValidation

```csharp
public bool EnableManipulationValidation { get; set; } = true;
```

### MaxErrorPenalty

```csharp
public float MaxErrorPenalty { get; set; } = 20.0f;
```

### MaxWarningPenalty

```csharp
public float MaxWarningPenalty { get; set; } = 5.0f;
```


## Methods

### Validate

```csharp
public ValidatorValidationResult Validate()
        {
            var errors = new List<string>();

            if (MaxErrorPenalty < 0)
                errors.Add("MaxErrorPenalty must be non-negative");

            if (MaxWarningPenalty < 0)
                errors.Add("MaxWarningPenalty must be non-negative");

            return errors.Count > 0 ? ValidatorValidationResult.Failure(errors.ToArray()) : ValidatorValidationResult.Success();
        }
```

**Returns:** `ValidatorValidationResult`

