---
title: "ValidationIssue"
description: "Validation issue information"
weight: 10
url: "/gridbuilding/v6-0/api/core/validationissue/"
---

# ValidationIssue

```csharp
GridBuilding.Core.Systems.Validation
class ValidationIssue
{
    // Members...
}
```

Validation issue information

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/PlaceableValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Message

```csharp
public string Message { get; }
```

### Severity

```csharp
public ValidationSeverity Severity { get; }
```

### Context

```csharp
public string Context { get; }
```


## Methods

### GetFormattedMessage

```csharp
public string GetFormattedMessage()
        {
            return string.IsNullOrEmpty(Context) ? Message : $"{Context}: {Message}";
        }
```

**Returns:** `string`

