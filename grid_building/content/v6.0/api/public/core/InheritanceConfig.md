---
title: "InheritanceConfig"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/inheritanceconfig/"
---

# InheritanceConfig

```csharp
GridBuilding.Core.Config
class InheritanceConfig
{
    // Members...
}
```

Configuration for building inheritance and property propagation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Config/InheritanceConfig.cs`  
**Namespace:** `GridBuilding.Core.Config`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnableInheritance

```csharp
public bool EnableInheritance { get; set; } = true;
```

### InheritPosition

```csharp
public bool InheritPosition { get; set; } = true;
```

### InheritRotation

```csharp
public bool InheritRotation { get; set; } = true;
```

### InheritScale

```csharp
public bool InheritScale { get; set; } = false;
```

### InheritProperties

```csharp
public bool InheritProperties { get; set; } = true;
```

### InheritedPropertyNames

```csharp
public string[] InheritedPropertyNames { get; set; } = Array.Empty<string>();
```

