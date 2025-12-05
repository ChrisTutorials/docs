---
title: "Enums"
description: "DEPRECATED: Legacy enum container for backward compatibility only.
Use the new domain-specific enums directly."
weight: 10
url: "/gridbuilding/v6-0/api/core/enums/"
---

# Enums

```csharp
GridBuilding.Core.Types
class Enums
{
    // Members...
}
```

DEPRECATED: Legacy enum container for backward compatibility only.
Use the new domain-specific enums directly.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Common/Types/Enums.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ModeToString

```csharp
// =========================================================================
    // DEPRECATED Helper Methods
    // =========================================================================

    /// <summary>DEPRECATED: Use BuildingModeExtensions.ToDisplayString()</summary>
    [System.Obsolete("Use BuildingModeExtensions.ToDisplayString()")]
    public static string ModeToString(Mode mode) => ((BuildingMode)(int)mode).ToDisplayString();
```

DEPRECATED: Use BuildingModeExtensions.ToDisplayString()

**Returns:** `string`

**Parameters:**
- `Mode mode`

### ProjectionMethodToString

```csharp
/// <summary>DEPRECATED: Use PositioningEnumExtensions.ToDisplayString()</summary>
    [System.Obsolete("Use PositioningEnumExtensions.ToDisplayString()")]
    public static string ProjectionMethodToString(ProjectionMethod method) => method.ToDisplayString();
```

DEPRECATED: Use PositioningEnumExtensions.ToDisplayString()

**Returns:** `string`

**Parameters:**
- `ProjectionMethod method`

### NodeSearchMethodToString

```csharp
/// <summary>DEPRECATED: Use DiscoveryEnumExtensions.ToDisplayString()</summary>
    [System.Obsolete("Use DiscoveryEnumExtensions.ToDisplayString()")]
    public static string NodeSearchMethodToString(NodeSearchMethod method) => method.ToDisplayString();
```

DEPRECATED: Use DiscoveryEnumExtensions.ToDisplayString()

**Returns:** `string`

**Parameters:**
- `NodeSearchMethod method`

### RecenterOnEnablePolicyToString

```csharp
/// <summary>DEPRECATED: Use PositioningEnumExtensions.ToDisplayString()</summary>
    [System.Obsolete("Use PositioningEnumExtensions.ToDisplayString()")]
    public static string RecenterOnEnablePolicyToString(RecenterPolicy policy) => policy.ToDisplayString();
```

DEPRECATED: Use PositioningEnumExtensions.ToDisplayString()

**Returns:** `string`

**Parameters:**
- `RecenterPolicy policy`

### GridPositionerLogModeToString

```csharp
/// <summary>DEPRECATED: Use PositioningEnumExtensions.ToDisplayString()</summary>
    [System.Obsolete("Use PositioningEnumExtensions.ToDisplayString()")]
    public static string GridPositionerLogModeToString(PositionerLogMode mode) => mode.ToDisplayString();
```

DEPRECATED: Use PositioningEnumExtensions.ToDisplayString()

**Returns:** `string`

**Parameters:**
- `PositionerLogMode mode`

