---
title: "MouseButtonExtensions"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/mousebuttonextensions/"
---

# MouseButtonExtensions

```csharp
GridBuilding.Core.Types
class MouseButtonExtensions
{
    // Members...
}
```

Extension methods for MouseButton enum

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/MouseButton.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### IsPrimaryButton

```csharp
/// <summary>
    /// Returns true if this is a primary action button
    /// </summary>
    public static bool IsPrimaryButton(this MouseButton button) =>
        button == MouseButton.Left;
```

Returns true if this is a primary action button

**Returns:** `bool`

**Parameters:**
- `MouseButton button`

### IsSecondaryButton

```csharp
/// <summary>
    /// Returns true if this is a secondary action button
    /// </summary>
    public static bool IsSecondaryButton(this MouseButton button) =>
        button == MouseButton.Right;
```

Returns true if this is a secondary action button

**Returns:** `bool`

**Parameters:**
- `MouseButton button`

### IsScrollWheel

```csharp
/// <summary>
    /// Returns true if this is a scroll wheel button
    /// </summary>
    public static bool IsScrollWheel(this MouseButton button) =>
        button == MouseButton.WheelUp || button == MouseButton.WheelDown ||
        button == MouseButton.WheelLeft || button == MouseButton.WheelRight;
```

Returns true if this is a scroll wheel button

**Returns:** `bool`

**Parameters:**
- `MouseButton button`

### IsExtraButton

```csharp
/// <summary>
    /// Returns true if this is an extra button
    /// </summary>
    public static bool IsExtraButton(this MouseButton button) =>
        button == MouseButton.Extra1 || button == MouseButton.Extra2;
```

Returns true if this is an extra button

**Returns:** `bool`

**Parameters:**
- `MouseButton button`

