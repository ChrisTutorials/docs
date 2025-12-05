---
title: "DiscoveryEnumExtensions"
description: "Extension methods for discovery enums."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/discoveryenumextensions/"
---

# DiscoveryEnumExtensions

```csharp
GridBuilding.Core.Types
class DiscoveryEnumExtensions
{
    // Members...
}
```

Extension methods for discovery enums.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/DiscoveryEnums.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ToDisplayString

```csharp
/// <summary>
    /// Converts NodeSearchMethod to display string.
    /// </summary>
    public static string ToDisplayString(this NodeSearchMethod method) => method switch
    {
        NodeSearchMethod.NodeName => "node_name",
        NodeSearchMethod.ScriptNameWithExtension => "script_name_with_extension",
        NodeSearchMethod.IsInGroup => "is_in_group",
        _ => "unknown"
    };
```

Converts NodeSearchMethod to display string.

**Returns:** `string`

**Parameters:**
- `NodeSearchMethod method`

