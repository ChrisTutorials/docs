---
title: "TestConfig"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/testconfig/"
---

# TestConfig

```csharp
GridBuilding.Godot.Tests.Data
class TestConfig
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Data/DataUtilitiesTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Settings

```csharp
public TestSettings Settings { get; }
```

### Templates

```csharp
public TestTemplates Templates { get; }
```

### Actions

```csharp
public TestActions Actions { get; }
```


## Methods

### IsValid

```csharp
public bool IsValid() => Settings != null && Templates != null && Actions != null;
```

**Returns:** `bool`

