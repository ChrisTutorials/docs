---
title: "StepConditions"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/stepconditions/"
---

# StepConditions

```csharp
GridBuilding.Core.Data
class StepConditions
{
    // Members...
}
```

Conditions for individual sequence steps

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/SequenceStep.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### MinimumPlayerLevel

```csharp
/// <summary>
        /// Minimum player level
        /// </summary>
        public int MinimumPlayerLevel { get; set; } = 0;
```

Minimum player level

### RequiredTechnologies

```csharp
/// <summary>
        /// Required technologies
        /// </summary>
        public string[] RequiredTechnologies { get; set; } = Array.Empty<string>();
```

Required technologies

### RequiredItems

```csharp
/// <summary>
        /// Required items in inventory
        /// </summary>
        public Dictionary<string, int> RequiredItems { get; set; } = new();
```

Required items in inventory

### AllowedTimesOfDay

```csharp
/// <summary>
        /// Time of day requirements
        /// </summary>
        public string[] AllowedTimesOfDay { get; set; } = Array.Empty<string>();
```

Time of day requirements

### AllowedWeather

```csharp
/// <summary>
        /// Weather requirements
        /// </summary>
        public string[] AllowedWeather { get; set; } = Array.Empty<string>();
```

Weather requirements

### CustomConditions

```csharp
/// <summary>
        /// Custom condition scripts
        /// </summary>
        public List<string> CustomConditions { get; set; } = new();
```

Custom condition scripts

### ExternalConditions

```csharp
/// <summary>
        /// External system conditions
        /// </summary>
        public Dictionary<string, object> ExternalConditions { get; set; } = new();
```

External system conditions


## Methods

### ValidateConditions

```csharp
/// <summary>
        /// Validates conditions
        /// </summary>
        public ValidationResult ValidateConditions()
        {
            if (MinimumPlayerLevel < 0)
                return new ValidationResult(false, "Minimum player level cannot be negative");

            return new ValidationResult(true);
        }
```

Validates conditions

**Returns:** `ValidationResult`

### CheckSatisfied

```csharp
/// <summary>
        /// Checks if conditions are satisfied
        /// </summary>
        public ValidationResult CheckSatisfied(Func<string, bool> conditionChecker)
        {
            // Check player level
            if (MinimumPlayerLevel > 0)
            {
                if (!conditionChecker($"player_level_{MinimumPlayerLevel}"))
                    return ValidationResult.Failure($"Player level {MinimumPlayerLevel} required");
            }

            // Check technologies
            foreach (var tech in RequiredTechnologies)
            {
                if (!conditionChecker($"technology_{tech}"))
                    return ValidationResult.Failure($"Technology {tech} required");
            }

            // Check items
            foreach (var item in RequiredItems)
            {
                if (!conditionChecker($"item_{item.Key}_{item.Value}"))
                    return ValidationResult.Failure($"Item {item.Key} x{item.Value} required");
            }

            return new ValidationResult(true);
        }
```

Checks if conditions are satisfied

**Returns:** `ValidationResult`

**Parameters:**
- `Func<string, bool> conditionChecker`

