---
title: "ConfigurationFormatExtensions"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/configurationformatextensions/"
---

# ConfigurationFormatExtensions

```csharp
GridBuilding.Core.Types
class ConfigurationFormatExtensions
{
    // Members...
}
```

Extension helpers for working with <see cref="ConfigurationFormat"/> values
across the runtime codebase.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ConfigurationFormatExtensions.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToFileExtension

```csharp
/// <summary>
    /// Gets the canonical lowercase file extension (without leading dot)
    /// for the given configuration format, e.g. <c>"json"</c>.
    /// </summary>
    /// <param name="format">The configuration format value.</param>
    /// <returns>The lowercase file extension string corresponding to <paramref name="format"/>.</returns>
    public static string ToFileExtension(this ConfigurationFormat format) =>
        format.ToString().ToLowerInvariant();
```

Gets the canonical lowercase file extension (without leading dot)
for the given configuration format, e.g. <c>"json"</c>.

**Returns:** `string`

**Parameters:**
- `ConfigurationFormat format`

