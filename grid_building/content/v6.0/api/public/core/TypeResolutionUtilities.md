---
title: "TypeResolutionUtilities"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/typeresolutionutilities/"
---

# TypeResolutionUtilities

```csharp
GridBuilding.Core.Types
class TypeResolutionUtilities
{
    // Members...
}
```

Core type resolution utilities for POCS (Plain Old C# Types)
These are reusable types that don't depend on Godot

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/TypeResolutionUtilities.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SafeConvert

```csharp
/// <summary>
    /// Safely convert object to target type with fallback
    /// </summary>
    public static T? SafeConvert<T>(object? value, T? defaultValue = default)
    {
        if (value == null) return defaultValue;
        
        try
        {
            return value is T typedValue ? typedValue : defaultValue;
        }
        catch
        {
            return defaultValue;
        }
    }
```

Safely convert object to target type with fallback

**Returns:** `T?`

**Parameters:**
- `object? value`
- `T? defaultValue`

### CanConvert

```csharp
/// <summary>
    /// Check if object can be converted to target type
    /// </summary>
    public static bool CanConvert<T>(object? value)
    {
        if (value == null) return false;
        
        try
        {
            return value is T;
        }
        catch
        {
            return false;
        }
    }
```

Check if object can be converted to target type

**Returns:** `bool`

**Parameters:**
- `object? value`

### SafeString

```csharp
/// <summary>
    /// Get string representation safely
    /// </summary>
    public static string SafeString(object? value, string defaultValue = "")
    {
        return value?.ToString() ?? defaultValue;
    }
```

Get string representation safely

**Returns:** `string`

**Parameters:**
- `object? value`
- `string defaultValue`

### IsNullOrWhiteSpace

```csharp
/// <summary>
    /// Check if string is null or whitespace
    /// </summary>
    public static bool IsNullOrWhiteSpace(string? value)
    {
        return string.IsNullOrWhiteSpace(value);
    }
```

Check if string is null or whitespace

**Returns:** `bool`

**Parameters:**
- `string? value`

### GetValue

```csharp
/// <summary>
    /// Get value from dictionary safely
    /// </summary>
    public static TValue? GetValue<TKey, TValue>(Dictionary<TKey, TValue> dictionary, TKey key, TValue? defaultValue = default)
    {
        if (dictionary.TryGetValue(key, out var value) && value != null)
        {
            return value;
        }
        return defaultValue;
    }
```

Get value from dictionary safely

**Returns:** `TValue?`

**Parameters:**
- `Dictionary<TKey, TValue> dictionary`
- `TKey key`
- `TValue? defaultValue`

