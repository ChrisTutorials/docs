---
title: "ComparisonResult"
description: "Result of transform comparison - mirrors GDScript comparison result pattern"
weight: 20
url: "/gridbuilding/v6-0/api/godot/comparisonresult/"
---

# ComparisonResult

```csharp
GridBuilding.Godot.Tests.Manipulation.Types
class ComparisonResult
{
    // Members...
}
```

Result of transform comparison - mirrors GDScript comparison result pattern

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Manipulation/Types/ValidationResult.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Manipulation.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### AreEqual

```csharp
public bool AreEqual { get; }
```

### Differences

```csharp
public IReadOnlyList<string> Differences { get; }
```


## Methods

### Equal

```csharp
/// <summary>
    /// Creates a result indicating transforms are equal
    /// </summary>
    public static ComparisonResult Equal() => new(true, Array.Empty<string>());
```

Creates a result indicating transforms are equal

**Returns:** `ComparisonResult`

### Different

```csharp
/// <summary>
    /// Creates a result indicating transforms are different with the specified differences
    /// </summary>
    public static ComparisonResult Different(params string[] differences) => new(false, differences);
```

Creates a result indicating transforms are different with the specified differences

**Returns:** `ComparisonResult`

**Parameters:**
- `string[] differences`

### Different

```csharp
/// <summary>
    /// Creates a result indicating transforms are different with the specified differences list
    /// </summary>
    public static ComparisonResult Different(IReadOnlyList<string> differences) => new(false, differences);
```

Creates a result indicating transforms are different with the specified differences list

**Returns:** `ComparisonResult`

**Parameters:**
- `IReadOnlyList<string> differences`

### ToString

```csharp
public override string ToString() =>
        AreEqual ? "Equal" : $"Different: {string.Join(", ", Differences)}";
```

**Returns:** `string`

