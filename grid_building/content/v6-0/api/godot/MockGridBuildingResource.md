---
title: "MockGridBuildingResource"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockgridbuildingresource/"
---

# MockGridBuildingResource

```csharp
GridBuilding.Godot.Tests.Services.DI
class MockGridBuildingResource
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Services/DI/CompositionContainerTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### GodotResource

```csharp
public Godot.Resource GodotResource => new Godot.Resource();
```


## Methods

### GetDebugIdentifier

```csharp
public string GetDebugIdentifier() => "MockResource";
```

**Returns:** `string`

### ValidateForEditor

```csharp
public Core.Validation.ValidationResult ValidateForEditor() => new();
```

**Returns:** `Core.Validation.ValidationResult`

