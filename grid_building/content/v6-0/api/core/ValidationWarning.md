---
title: "ValidationWarning"
description: "Represents a validation warning."
weight: 10
url: "/gridbuilding/v6-0/api/core/validationwarning/"
---

# ValidationWarning

```csharp
GridBuilding.Core.Results
class ValidationWarning
{
    // Members...
}
```

Represents a validation warning.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Results/ValidationResults.cs`  
**Namespace:** `GridBuilding.Core.Results`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Message

```csharp
public string Message { get; set; } = string.Empty;
```

### Code

```csharp
public string Code { get; set; } = string.Empty;
```

### Context

```csharp
public string? Context { get; set; }
```

### Timestamp

```csharp
public DateTime Timestamp { get; set; }
```

### Data

```csharp
public Dictionary<string, object> Data { get; set; } = new();
```


## Methods

### ToString

```csharp
public override string ToString()
        {
            return $"ValidationWarning: {Message} ({Code})";
        }
```

**Returns:** `string`

