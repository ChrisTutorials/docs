---
title: "TestFactory"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/testfactory/"
---

# TestFactory

```csharp
GridBuilding.Godot.Tests.Data
class TestFactory
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


## Methods

### CreateValidConfig

```csharp
public TestConfig CreateValidConfig() => new TestConfig(new TestSettings(), new TestTemplates(), new TestActions());
```

**Returns:** `TestConfig`

### CreateValidContainer

```csharp
public TestContainer CreateValidContainer() => new TestContainer(CreateValidConfig());
```

**Returns:** `TestContainer`

### CreateLogger

```csharp
public TestLogger CreateLogger() => new TestLogger(new TestDebugSettings());
```

**Returns:** `TestLogger`

### CreateValidator

```csharp
public TestValidator CreateValidator() => new TestValidator();
```

**Returns:** `TestValidator`

