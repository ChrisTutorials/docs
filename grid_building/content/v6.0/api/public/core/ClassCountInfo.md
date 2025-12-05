---
title: "ClassCountInfo"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/classcountinfo/"
---

# ClassCountInfo

```csharp
GridBuilding.Core.Logging
class ClassCountInfo
{
    // Members...
}
```

Information about a class's instance count

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Logging/ClassCountLogger.cs`  
**Namespace:** `GridBuilding.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ClassName

```csharp
public string ClassName { get; set; } = "";
```

### FullName

```csharp
public string FullName { get; set; } = "";
```

### Category

```csharp
public string Category { get; set; } = "";
```

### InstanceCount

```csharp
public int InstanceCount { get; set; }
```

### FirstCreated

```csharp
public double FirstCreated { get; set; }
```

### LastCreated

```csharp
public double LastCreated { get; set; }
```

### LastDestroyed

```csharp
public double LastDestroyed { get; set; }
```

### IsAbstract

```csharp
public bool IsAbstract { get; set; }
```

### IsInterface

```csharp
public bool IsInterface { get; set; }
```

### IsEnum

```csharp
public bool IsEnum { get; set; }
```

