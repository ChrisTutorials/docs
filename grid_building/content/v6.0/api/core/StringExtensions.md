---
title: "StringExtensions"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/stringextensions/"
---

# StringExtensions

```csharp
GridBuilding.Core.Common.Extensions
class StringExtensions
{
    // Members...
}
```

String utilities for the Grid Building plugin.
Pure functions for string manipulation without Godot dependencies.
Ported from: godot/addons/grid_building/shared/utils/general/gb_string.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Common/Extensions/StringExtensions.cs`  
**Namespace:** `GridBuilding.Core.Common.Extensions`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetSeparatorString

```csharp
/// <summary>
    /// Gets the separator string for the given enum value.
    /// </summary>
    public static string GetSeparatorString(SeparatorType separatorType)
    {
        return separatorType switch
        {
            SeparatorType.None => "",
            SeparatorType.Space => " ",
            SeparatorType.Underscore => "_",
            SeparatorType.Dash => "-",
            _ => throw new ArgumentOutOfRangeException(nameof(separatorType),
                $"Non-existent enum Node Number Separator {(int)separatorType}")
        };
    }
```

Gets the separator string for the given enum value.

**Returns:** `string`

**Parameters:**
- `SeparatorType separatorType`

### GetSeparatorString

```csharp
/// <summary>
    /// Gets the separator string for the given enum value (int overload for compatibility).
    /// </summary>
    public static string GetSeparatorString(int separatorEnum)
    {
        if (!Enum.IsDefined(typeof(SeparatorType), separatorEnum))
        {
            throw new ArgumentOutOfRangeException(nameof(separatorEnum),
                $"Non-existent enum Node Number Separator {separatorEnum}");
        }
        return GetSeparatorString((SeparatorType)separatorEnum);
    }
```

Gets the separator string for the given enum value (int overload for compatibility).

**Returns:** `string`

**Parameters:**
- `int separatorEnum`

### MatchNumSeparator

```csharp
/// <summary>
    /// Checks if a character matches the given separator type.
    /// </summary>
    public static bool MatchNumSeparator(char character, SeparatorType separatorType)
    {
        return separatorType switch
        {
            SeparatorType.None => false,
            SeparatorType.Space => character == ' ',
            SeparatorType.Underscore => character == '_',
            SeparatorType.Dash => character == '-',
            _ => throw new ArgumentOutOfRangeException(nameof(separatorType),
                $"Non-existent enum Node Number Separator {(int)separatorType}")
        };
    }
```

Checks if a character matches the given separator type.

**Returns:** `bool`

**Parameters:**
- `char character`
- `SeparatorType separatorType`

### MatchNumSeparator

```csharp
/// <summary>
    /// Checks if a character matches the given separator type (int overload).
    /// </summary>
    public static bool MatchNumSeparator(char character, int separatorEnum)
    {
        if (!Enum.IsDefined(typeof(SeparatorType), separatorEnum))
        {
            throw new ArgumentOutOfRangeException(nameof(separatorEnum),
                $"Non-existent enum Node Number Separator {separatorEnum}");
        }
        return MatchNumSeparator(character, (SeparatorType)separatorEnum);
    }
```

Checks if a character matches the given separator type (int overload).

**Returns:** `bool`

**Parameters:**
- `char character`
- `int separatorEnum`

### ConvertNameToReadable

```csharp
/// <summary>
    /// Converts a node name to a human readable display name string.
    /// Stops processing when it encounters the separator.
    /// Adds spaces before uppercase letters (PascalCase to Title Case).
    /// </summary>
    public static string ConvertNameToReadable(string nodeName, SeparatorType separatorType = SeparatorType.None)
    {
        if (string.IsNullOrEmpty(nodeName))
        {
            return "";
        }

        var separatorString = GetSeparatorString(separatorType);
        var displayName = new StringBuilder();

        foreach (var c in nodeName)
        {
            // Stop at separator
            if (!string.IsNullOrEmpty(separatorString) && c.ToString() == separatorString)
            {
                break;
            }

            // Add space before uppercase letters (except at start)
            if (char.IsUpper(c) && displayName.Length > 0)
            {
                displayName.Append(' ');
            }

            displayName.Append(c);
        }

        return displayName.ToString();
    }
```

Converts a node name to a human readable display name string.
Stops processing when it encounters the separator.
Adds spaces before uppercase letters (PascalCase to Title Case).

**Returns:** `string`

**Parameters:**
- `string nodeName`
- `SeparatorType separatorType`

### ToSnakeCase

```csharp
/// <summary>
    /// Converts PascalCase or camelCase to snake_case.
    /// </summary>
    public static string ToSnakeCase(string input)
    {
        if (string.IsNullOrEmpty(input))
        {
            return "";
        }

        var result = new StringBuilder();

        for (int i = 0; i < input.Length; i++)
        {
            var c = input[i];

            if (char.IsUpper(c))
            {
                // Add underscore before uppercase (except at start)
                if (i > 0)
                {
                    result.Append('_');
                }
                result.Append(char.ToLower(c));
            }
            else
            {
                result.Append(c);
            }
        }

        return result.ToString();
    }
```

Converts PascalCase or camelCase to snake_case.

**Returns:** `string`

**Parameters:**
- `string input`

### ToPascalCase

```csharp
/// <summary>
    /// Converts snake_case to PascalCase.
    /// </summary>
    public static string ToPascalCase(string input)
    {
        if (string.IsNullOrEmpty(input))
        {
            return "";
        }

        var result = new StringBuilder();
        bool capitalizeNext = true;

        foreach (var c in input)
        {
            if (c == '_')
            {
                capitalizeNext = true;
            }
            else if (capitalizeNext)
            {
                result.Append(char.ToUpper(c));
                capitalizeNext = false;
            }
            else
            {
                result.Append(c);
            }
        }

        return result.ToString();
    }
```

Converts snake_case to PascalCase.

**Returns:** `string`

**Parameters:**
- `string input`

### ToCamelCase

```csharp
/// <summary>
    /// Converts snake_case to camelCase.
    /// </summary>
    public static string ToCamelCase(string input)
    {
        var pascal = ToPascalCase(input);
        if (string.IsNullOrEmpty(pascal))
        {
            return "";
        }
        return char.ToLower(pascal[0]) + pascal.Substring(1);
    }
```

Converts snake_case to camelCase.

**Returns:** `string`

**Parameters:**
- `string input`

### RemoveNumericSuffix

```csharp
/// <summary>
    /// Removes a numeric suffix from a name (e.g., "Node2" -> "Node", "Enemy_3" -> "Enemy").
    /// </summary>
    public static string RemoveNumericSuffix(string name, SeparatorType separatorType = SeparatorType.None)
    {
        if (string.IsNullOrEmpty(name))
        {
            return "";
        }

        var separator = GetSeparatorString(separatorType);

        // Find the last occurrence of separator (if any)
        int separatorIndex = string.IsNullOrEmpty(separator)
            ? -1
            : name.LastIndexOf(separator, StringComparison.Ordinal);

        if (separatorIndex >= 0)
        {
            // Check if everything after separator is numeric
            var suffix = name.Substring(separatorIndex + separator.Length);
            if (int.TryParse(suffix, out _))
            {
                return name.Substring(0, separatorIndex);
            }
        }
        else
        {
            // No separator - check for trailing digits
            int i = name.Length - 1;
            while (i >= 0 && char.IsDigit(name[i]))
            {
                i--;
            }

            // If we found non-digit characters before the digits
            if (i < name.Length - 1)
            {
                // Return everything up to and including the last non-digit
                // If i is -1 (all digits), return empty string
                return i >= 0 ? name.Substring(0, i + 1) : "";
            }
        }

        return name;
    }
```

Removes a numeric suffix from a name (e.g., "Node2" -> "Node", "Enemy_3" -> "Enemy").

**Returns:** `string`

**Parameters:**
- `string name`
- `SeparatorType separatorType`

