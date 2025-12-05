---
title: "Result"
description: "Result wrapper for external operations"
weight: 10
url: "/gridbuilding/v6-0/api/core/result/"
---

# Result

```csharp
GridBuilding.Core.Interfaces
class Result
{
    // Members...
}
```

Result wrapper for external operations

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Interfaces/IPlaceableDataProvider.cs`  
**Namespace:** `GridBuilding.Core.Interfaces`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Success

```csharp
public bool Success { get; set; }
```

### Value

```csharp
public T Value { get; set; }
```

### Error

```csharp
public string Error { get; set; }
```


## Methods

### CreateSuccess

```csharp
public static Result<T> CreateSuccess(T value) => new() { Success = true, Value = value };
```

**Returns:** `Result<T>`

**Parameters:**
- `T value`

### Failure

```csharp
public static Result<T> Failure(string error) => new() { Success = false, Error = error };
```

**Returns:** `Result<T>`

**Parameters:**
- `string error`

