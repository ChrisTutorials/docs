---
title: "StringExtensions"
description: "Extension methods for string operations"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/stringextensions/"
---

# StringExtensions

```csharp
GridBuilding.Godot.Security
class StringExtensions
{
    // Members...
}
```

Extension methods for string operations

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/SecurePreloader.cs`  
**Namespace:** `GridBuilding.Godot.Security`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Truncate

```csharp
/// <summary>
    /// Truncates a string to the specified length
    /// </summary>
    /// <param name="value">String to truncate</param>
    /// <param name="maxLength">Maximum length</param>
    /// <returns>Truncated string</returns>
    public static string Truncate(this string value, int maxLength)
    {
        if (string.IsNullOrEmpty(value) || value.Length <= maxLength)
        {
            return value;
        }

        return value.Substring(0, maxLength);
    }
```

Truncates a string to the specified length

**Returns:** `string`

**Parameters:**
- `string value`
- `int maxLength`

