---
title: "MoveResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/moveresult/"
---

# MoveResult

```csharp
GridBuilding.Core.Services.Manipulation
class MoveResult
{
    // Members...
}
```

Represents the result of a move operation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/MoveWorkflowManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsSuccess

```csharp
public bool IsSuccess { get; set; }
```

### ErrorMessage

```csharp
public string ErrorMessage { get; set; } = string.Empty;
```

### OriginalPosition

```csharp
public Vector2I OriginalPosition { get; set; }
```

### FinalPosition

```csharp
public Vector2I FinalPosition { get; set; }
```

### TargetObjectId

```csharp
public string TargetObjectId { get; set; } = string.Empty;
```

### Duration

```csharp
public TimeSpan Duration { get; set; }
```

### MoveDelta

```csharp
public Vector2I MoveDelta => FinalPosition - OriginalPosition;
```


## Methods

### Failed

```csharp
public static MoveResult Failed(string errorMessage)
            {
                return new MoveResult
                {
                    IsSuccess = false,
                    ErrorMessage = errorMessage
                };
            }
```

**Returns:** `MoveResult`

**Parameters:**
- `string errorMessage`

### ToString

```csharp
public override string ToString()
            {
                return IsSuccess 
                    ? $"MoveResult(Success: {TargetObjectId} moved {MoveDelta} in {Duration.TotalMilliseconds:F0}ms)"
                    : $"MoveResult(Failed: {ErrorMessage})";
            }
```

**Returns:** `string`

