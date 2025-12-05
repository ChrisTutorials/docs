---
title: "ObsoleteGBInjectorAttribute"
description: "Attribute to mark GB injector system components as obsolete.
Provides migration guidance and deprecation warnings."
weight: 10
url: "/gridbuilding/v6-0/api/core/obsoletegbinjectorattribute/"
---

# ObsoleteGBInjectorAttribute

```csharp
GridBuilding.Core.Attributes
class ObsoleteGBInjectorAttribute
{
    // Members...
}
```

Attribute to mark GB injector system components as obsolete.
Provides migration guidance and deprecation warnings.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Attributes/ObsoleteGBInjector.cs`  
**Namespace:** `GridBuilding.Core.Attributes`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### MigrationPath

```csharp
public string MigrationPath { get; }
```

### NewPattern

```csharp
public string NewPattern { get; }
```

### AdditionalGuidance

```csharp
public string? AdditionalGuidance { get; }
```


## Methods

### ForGBInjectable

```csharp
/// <summary>
    /// Creates a deprecation attribute for Injectable classes.
    /// </summary>
    public static ObsoleteGBInjectorAttribute ForGBInjectable()
    {
        return new ObsoleteGBInjectorAttribute(
            "Injectable is deprecated. Use IInjectable interface from GridBuilding.Core.Interfaces instead.",
            "GridBuilding.Core.Interfaces.IInjectable",
            "public class MyClass : IInjectable",
            "See migration guide: /docs/architecture/GB_INJECTOR_DEPRECATION_MIGRATION_PLAN.md"
        );
    }
```

Creates a deprecation attribute for Injectable classes.

**Returns:** `ObsoleteGBInjectorAttribute`

### ForGBCompositionContainer

```csharp
/// <summary>
    /// Creates a deprecation attribute for GBCompositionContainer.
    /// </summary>
    public static ObsoleteGBInjectorAttribute ForGBCompositionContainer()
    {
        return new ObsoleteGBInjectorAttribute(
            "GBCompositionContainer is deprecated. Use ICompositionContainer from GridBuilding.Core.Interfaces instead.",
            "GridBuilding.Core.Interfaces.ICompositionContainer",
            "ICompositionContainer container = CompositionContainer.Instance",
            "Access via CompositionContainer.Instance static property"
        );
    }
```

Creates a deprecation attribute for GBCompositionContainer.

**Returns:** `ObsoleteGBInjectorAttribute`

### ForCreateWithInjection

```csharp
/// <summary>
    /// Creates a deprecation attribute for CreateWithInjection methods.
    /// </summary>
    public static ObsoleteGBInjectorAttribute ForCreateWithInjection()
    {
        return new ObsoleteGBInjectorAttribute(
            "CreateWithInjection pattern is deprecated. Use constructor + InjectDependencies pattern instead.",
            "Constructor + InjectDependencies",
            "var service = new MyService(); service.InjectDependencies(container);",
            "This provides better separation of concerns and testability"
        );
    }
```

Creates a deprecation attribute for CreateWithInjection methods.

**Returns:** `ObsoleteGBInjectorAttribute`

### ForResolveGbDependencies

```csharp
/// <summary>
    /// Creates a deprecation attribute for ResolveGbDependencies methods.
    /// </summary>
    public static ObsoleteGBInjectorAttribute ForResolveGbDependencies()
    {
        return new ObsoleteGBInjectorAttribute(
            "ResolveGbDependencies is deprecated. Use InjectDependencies method from IInjectable instead.",
            "IInjectable.InjectDependencies",
            "public void InjectDependencies(ICompositionContainer container)",
            "Note the signature change: void return type and ICompositionContainer parameter"
        );
    }
```

Creates a deprecation attribute for ResolveGbDependencies methods.

**Returns:** `ObsoleteGBInjectorAttribute`

### ForGetRuntimeIssues

```csharp
/// <summary>
    /// Creates a deprecation attribute for GetRuntimeIssues methods.
    /// </summary>
    public static ObsoleteGBInjectorAttribute ForGetRuntimeIssues()
    {
        return new ObsoleteGBInjectorAttribute(
            "GetRuntimeIssues is deprecated. Use ValidateDependencies method from IInjectable instead.",
            "IInjectable.ValidateDependencies",
            "public ValidationResult ValidateDependencies(ICompositionContainer container)",
            "Returns ValidationResult object with structured error information"
        );
    }
```

Creates a deprecation attribute for GetRuntimeIssues methods.

**Returns:** `ObsoleteGBInjectorAttribute`

