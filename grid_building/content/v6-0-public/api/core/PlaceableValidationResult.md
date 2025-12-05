---
title: "PlaceableValidationResult"
description: "Validation result containing errors and warnings"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placeablevalidationresult/"
---

# PlaceableValidationResult

```csharp
GridBuilding.Core.Systems.Validation
class PlaceableValidationResult
{
    // Members...
}
```

Validation result containing errors and warnings

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/PlaceableValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Errors

```csharp
public IReadOnlyList<ValidationIssue> Errors => _errors.AsReadOnly();
```

### Warnings

```csharp
public IReadOnlyList<ValidationIssue> Warnings => _warnings.AsReadOnly();
```

### IsValid

```csharp
public bool IsValid => !_errors.Any();
```

### HasWarnings

```csharp
public bool HasWarnings => _warnings.Any();
```


## Methods

### AddError

```csharp
public void AddError(string message, string context = null)
        {
            _errors.Add(new ValidationIssue(message, ValidationSeverity.Error, context));
        }
```

**Returns:** `void`

**Parameters:**
- `string message`
- `string context`

### AddWarning

```csharp
public void AddWarning(string message, string context = null)
        {
            _warnings.Add(new ValidationIssue(message, ValidationSeverity.Warning, context));
        }
```

**Returns:** `void`

**Parameters:**
- `string message`
- `string context`

### Merge

```csharp
public void Merge(PlaceableValidationResult other, string context = null)
        {
            if (other == null) return;

            foreach (var error in other.Errors)
            {
                AddError(error.Message, string.IsNullOrEmpty(context) ? error.Context : $"{context}: {error.Context}");
            }

            foreach (var warning in other.Warnings)
            {
                AddWarning(warning.Message, string.IsNullOrEmpty(context) ? warning.Context : $"{context}: {warning.Context}");
            }
        }
```

**Returns:** `void`

**Parameters:**
- `PlaceableValidationResult other`
- `string context`

### GetSummary

```csharp
public string GetSummary()
        {
            var summary = $"Validation {(IsValid ? "passed" : "failed")}";
            
            if (_errors.Any())
            {
                summary += $", {_errors.Count} error{(_errors.Count == 1 ? "" : "s")}";
            }

            if (_warnings.Any())
            {
                summary += $", {_warnings.Count} warning{(_warnings.Count == 1 ? "" : "s")}";
            }

            return summary;
        }
```

**Returns:** `string`

### GetAllMessages

```csharp
public List<string> GetAllMessages()
        {
            var messages = new List<string>();

            foreach (var error in _errors)
            {
                messages.Add($"[ERROR] {error.GetFormattedMessage()}");
            }

            foreach (var warning in _warnings)
            {
                messages.Add($"[WARNING] {warning.GetFormattedMessage()}");
            }

            return messages;
        }
```

**Returns:** `List<string>`

