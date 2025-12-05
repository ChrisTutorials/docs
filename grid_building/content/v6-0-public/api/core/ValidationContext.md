---
title: "ValidationContext"
description: "Validation context for rule-based validation"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/validationcontext/"
---

# ValidationContext

```csharp
GridBuilding.Core.Systems.Validation
class ValidationContext
{
    // Members...
}
```

Validation context for rule-based validation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/IValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Data

```csharp
/// <summary>
        /// Additional context data
        /// </summary>
        public Dictionary<string, object> Data { get; set; } = new();
```

Additional context data

### Options

```csharp
/// <summary>
        /// Validation options
        /// </summary>
        public ValidationOptions Options { get; set; } = new();
```

Validation options

### Parent

```csharp
/// <summary>
        /// Parent validation context (for nested validations)
        /// </summary>
        public ValidationContext Parent { get; set; }
```

Parent validation context (for nested validations)


## Methods

### GetValue

```csharp
/// <summary>
        /// Gets a value from the context data
        /// </summary>
        public T GetValue<T>(string key, T defaultValue = default)
        {
            if (Data.TryGetValue(key, out var value) && value is T typedValue)
                return typedValue;
            return defaultValue;
        }
```

Gets a value from the context data

**Returns:** `T`

**Parameters:**
- `string key`
- `T defaultValue`

### SetValue

```csharp
/// <summary>
        /// Sets a value in the context data
        /// </summary>
        public void SetValue<T>(string key, T value)
        {
            Data[key] = value;
        }
```

Sets a value in the context data

**Returns:** `void`

**Parameters:**
- `string key`
- `T value`

