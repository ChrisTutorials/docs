---
title: "TestReadyNode"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/testreadynode/"
---

# TestReadyNode

```csharp
GridBuilding.Godot.Tests.GoDotTest
class TestReadyNode
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/SignalIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ReadyCalled

```csharp
public bool ReadyCalled { get; private set; }
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            ReadyCalled = true;
        }
```

**Returns:** `void`

