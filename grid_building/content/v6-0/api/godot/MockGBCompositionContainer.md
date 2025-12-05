---
title: "MockGBCompositionContainer"
description: "Mock implementation of GBCompositionContainer for testing."
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockgbcompositioncontainer/"
---

# MockGBCompositionContainer

```csharp
GridBuilding.Godot.Tests.Helpers
class MockGBCompositionContainer
{
    // Members...
}
```

Mock implementation of GBCompositionContainer for testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/MockGBCompositionContainer.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### SystemsContext

```csharp
public GBSystemsContext? SystemsContext { get; set; }
```

### IndicatorContext

```csharp
public IndicatorContext? IndicatorContext { get; set; }
```

### States

```csharp
public string? States { get; set; }
```

### ManipulationSettings

```csharp
public ManipulationSettings? ManipulationSettings { get; set; }
```

### Actions

```csharp
public object? Actions { get; set; }
```

### Logger

```csharp
public Logger? Logger { get; set; }
```


## Methods

### GetSystemsContext

```csharp
public GBSystemsContext? GetSystemsContext() => SystemsContext;
```

**Returns:** `GBSystemsContext?`

### GetIndicatorContext

```csharp
public IndicatorContext? GetIndicatorContext() => IndicatorContext;
```

**Returns:** `IndicatorContext?`

### GetStates

```csharp
public string? GetStates() => States;
```

**Returns:** `string?`

### GetManipulationSettings

```csharp
public ManipulationSettings? GetManipulationSettings() => ManipulationSettings;
```

**Returns:** `ManipulationSettings?`

### GetActions

```csharp
public object? GetActions() => Actions;
```

**Returns:** `object?`

### GetLogger

```csharp
public Logger? GetLogger() => Logger;
```

**Returns:** `Logger?`

