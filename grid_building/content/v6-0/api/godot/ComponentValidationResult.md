---
title: "ComponentValidationResult"
description: "Result of component validation"
weight: 20
url: "/gridbuilding/v6-0/api/godot/componentvalidationresult/"
---

# ComponentValidationResult

```csharp
GridBuilding.Godot.Tests.Utils
class ComponentValidationResult
{
    // Members...
}
```

Result of component validation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/EnvironmentValidationUtils.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; set; }
```

### Issues

```csharp
public List<string> Issues { get; set; } = new();
```

### Warnings

```csharp
public List<string> Warnings { get; set; } = new();
```


## Methods

### GetSummary

```csharp
/// <summary>
        /// Gets a summary of the validation result
        /// </summary>
        public string GetSummary()
        {
            var summary = $"Valid: {IsValid}";
            if (Issues.Count > 0)
                summary += $", Issues: {Issues.Count}";
            if (Warnings.Count > 0)
                summary += $", Warnings: {Warnings.Count}";
            return summary;
        }
```

Gets a summary of the validation result

**Returns:** `string`

