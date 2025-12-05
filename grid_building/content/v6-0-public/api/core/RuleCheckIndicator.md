---
title: "RuleCheckIndicator"
description: "Rule check indicator for validation"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/rulecheckindicator/"
---

# RuleCheckIndicator

```csharp
GridBuilding.Core.Results
class RuleCheckIndicator
{
    // Members...
}
```

Rule check indicator for validation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/ValidationResults.cs`  
**Namespace:** `GridBuilding.Core.Results`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RuleName

```csharp
#region Properties

    /// <summary>
    /// Name of the rule
    /// </summary>
    public string RuleName { get; set; } = string.Empty;
```

Name of the rule

### IsValid

```csharp
/// <summary>
    /// Whether the rule passed validation
    /// </summary>
    public bool IsValid { get; set; }
```

Whether the rule passed validation

### Message

```csharp
/// <summary>
    /// Message describing the rule result
    /// </summary>
    public string Message { get; set; } = string.Empty;
```

Message describing the rule result

### ExtraInfo

```csharp
/// <summary>
    /// Extra info for the indicator
    /// </summary>
    public string ExtraInfo { get; set; } = string.Empty;
```

Extra info for the indicator

