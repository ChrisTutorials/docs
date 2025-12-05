---
title: "DemolishResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/demolishresult/"
---

# DemolishResult

```csharp
GridBuilding.Core.Services.Manipulation
class DemolishResult
{
    // Members...
}
```

Represents the result of a demolish operation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/DemolishManager.cs`  
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

### TargetObjectId

```csharp
public string TargetObjectId { get; set; } = string.Empty;
```

### TargetPosition

```csharp
public Vector2I TargetPosition { get; set; }
```

### AffectedTiles

```csharp
public List<Vector2I> AffectedTiles { get; set; } = new();
```

### Duration

```csharp
public TimeSpan Duration { get; set; }
```

### Timestamp

```csharp
public DateTime Timestamp { get; set; }
```

### RecoveredResources

```csharp
public Dictionary<string, object> RecoveredResources { get; set; } = new();
```


## Methods

### Failed

```csharp
public static DemolishResult Failed(string error)
            {
                return new DemolishResult
                {
                    IsSuccess = false,
                    ErrorMessage = error
                };
            }
```

**Returns:** `DemolishResult`

**Parameters:**
- `string error`

### ToString

```csharp
public override string ToString()
            {
                return IsSuccess 
                    ? $"DemolishResult(Success: {TargetObjectId} demolished in {Duration.TotalMilliseconds:F0}ms, Tiles: {AffectedTiles.Count})"
                    : $"DemolishResult(Failed: {ErrorMessage})";
            }
```

**Returns:** `string`

