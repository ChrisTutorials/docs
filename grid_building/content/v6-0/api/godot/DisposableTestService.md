---
title: "DisposableTestService"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/disposabletestservice/"
---

# DisposableTestService

```csharp
GridBuilding.Godot.Tests.Services.DI
class DisposableTestService
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Services/DI/ServiceRegistryTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsDisposed

```csharp
public bool IsDisposed { get; private set; }
```


## Methods

### Dispose

```csharp
public void Dispose()
        {
            IsDisposed = true;
        }
```

**Returns:** `void`

