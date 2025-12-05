---
title: "ManipulationResult"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/manipulationresult/"
---

# ManipulationResult

```csharp
GridBuilding.Core.Types
class ManipulationResult
{
    // Members...
}
```

Result of a manipulation operation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ManipulationResult.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsSuccess

```csharp
/// <summary>
    /// Whether the operation was successful
    /// </summary>
    public bool IsSuccess 
    { 
        get => _isSuccess; 
        set => _isSuccess = value; 
    }
```

Whether the operation was successful

### IsValid

```csharp
/// <summary>
    /// Whether the operation was valid (alias for IsSuccess, for compatibility)
    /// </summary>
    public bool IsValid
    {
        get => _isSuccess;
        set => _isSuccess = value;
    }
```

Whether the operation was valid (alias for IsSuccess, for compatibility)

### ErrorMessage

```csharp
/// <summary>
    /// Error message if operation failed
    /// </summary>
    public string ErrorMessage { get; set; } = string.Empty;
```

Error message if operation failed

### Message

```csharp
/// <summary>
    /// Message (alias for ErrorMessage, for compatibility)
    /// </summary>
    public string Message
    {
        get => ErrorMessage;
        set => ErrorMessage = value;
    }
```

Message (alias for ErrorMessage, for compatibility)

### ManipulationType

```csharp
/// <summary>
    /// Type of manipulation that was performed
    /// </summary>
    public ManipulationAction ManipulationType { get; set; }
```

Type of manipulation that was performed

### OriginalPosition

```csharp
/// <summary>
    /// Original position before manipulation
    /// </summary>
    public Vector2I OriginalPosition { get; set; }
```

Original position before manipulation

### NewPosition

```csharp
/// <summary>
    /// New position after manipulation
    /// </summary>
    public Vector2I NewPosition { get; set; }
```

New position after manipulation

### AffectedPositions

```csharp
/// <summary>
    /// Affected positions
    /// </summary>
    public List<Vector2I> AffectedPositions { get; set; } = new();
```

Affected positions

### Metadata

```csharp
/// <summary>
    /// Operation metadata
    /// </summary>
    public Dictionary<string, object> Metadata { get; set; } = new();
```

Operation metadata

### Data

```csharp
/// <summary>
    /// Additional data (alias for Metadata, for compatibility)
    /// </summary>
    public Dictionary<string, object> Data
    {
        get => Metadata;
        set => Metadata = value;
    }
```

Additional data (alias for Metadata, for compatibility)

### Timestamp

```csharp
/// <summary>
    /// Timestamp of the operation
    /// </summary>
    public System.DateTime Timestamp { get; set; } = System.DateTime.UtcNow;
```

Timestamp of the operation

### ValidationErrors

```csharp
/// <summary>
    /// Validation errors (for compatibility)
    /// </summary>
    public List<string> ValidationErrors { get; set; } = new();
```

Validation errors (for compatibility)


## Methods

### Successful

```csharp
/// <summary>
    /// Creates a successful result
    /// </summary>
    public static ManipulationResult Successful()
    {
        return new ManipulationResult(true);
    }
```

Creates a successful result

**Returns:** `ManipulationResult`

### Successful

```csharp
/// <summary>
    /// Creates a successful result with message
    /// </summary>
    public static ManipulationResult Successful(string message)
    {
        return new ManipulationResult(true, message);
    }
```

Creates a successful result with message

**Returns:** `ManipulationResult`

**Parameters:**
- `string message`

### Success

```csharp
/// <summary>
    /// Creates a successful result with message (compatibility alias for Successful)
    /// </summary>
    public static ManipulationResult Success(string message) => Successful(message);
```

Creates a successful result with message (compatibility alias for Successful)

**Returns:** `ManipulationResult`

**Parameters:**
- `string message`

### Success

```csharp
/// <summary>
    /// Creates a successful result with position data
    /// </summary>
    public static ManipulationResult Success(ManipulationAction type, Vector2I originalPos, Vector2I newPos)
    {
        return new ManipulationResult
        {
            IsSuccess = true,
            ManipulationType = type,
            OriginalPosition = originalPos,
            NewPosition = newPos
        };
    }
```

Creates a successful result with position data

**Returns:** `ManipulationResult`

**Parameters:**
- `ManipulationAction type`
- `Vector2I originalPos`
- `Vector2I newPos`

### Failed

```csharp
/// <summary>
    /// Creates a failed result
    /// </summary>
    public static ManipulationResult Failed(string errorMessage)
    {
        return new ManipulationResult(false, errorMessage);
    }
```

Creates a failed result

**Returns:** `ManipulationResult`

**Parameters:**
- `string errorMessage`

### Failure

```csharp
/// <summary>
    /// Creates a failed result (alias for Failed)
    /// </summary>
    public static ManipulationResult Failure(string errorMessage, ManipulationAction type = default)
    {
        return new ManipulationResult
        {
            IsSuccess = false,
            ErrorMessage = errorMessage,
            ManipulationType = type
        };
    }
```

Creates a failed result (alias for Failed)

**Returns:** `ManipulationResult`

**Parameters:**
- `string errorMessage`
- `ManipulationAction type`

### AddAffectedPosition

```csharp
/// <summary>
    /// Adds an affected position
    /// </summary>
    public void AddAffectedPosition(Vector2I position)
    {
        AffectedPositions.Add(position);
    }
```

Adds an affected position

**Returns:** `void`

**Parameters:**
- `Vector2I position`

### AddMetadata

```csharp
/// <summary>
    /// Adds metadata
    /// </summary>
    public void AddMetadata(string key, object value)
    {
        Metadata[key] = value;
    }
```

Adds metadata

**Returns:** `void`

**Parameters:**
- `string key`
- `object value`

