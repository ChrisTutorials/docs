---
title: "EnvironmentValidationResult"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/environmentvalidationresult/"
---

# EnvironmentValidationResult

```csharp
GridBuilding.Godot.Tests.Utils
class EnvironmentValidationResult
{
    // Members...
}
```

Result of environment validation

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

### ComponentStatus

```csharp
public Dictionary<string, bool> ComponentStatus { get; set; } = new();
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

### GetAllMessages

```csharp
/// <summary>
        /// Gets all issues and warnings combined
        /// </summary>
        public List<string> GetAllMessages()
        {
            var allMessages = new List<string>();
            allMessages.AddRange(Issues);
            allMessages.AddRange(Warnings);
            return allMessages;
        }
```

Gets all issues and warnings combined

**Returns:** `List<string>`

