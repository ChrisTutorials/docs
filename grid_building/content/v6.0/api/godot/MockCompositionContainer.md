---
title: "MockCompositionContainer"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mockcompositioncontainer/"
---

# MockCompositionContainer

```csharp
GridBuilding.Godot.Tests.Systems.UI.Placeable
class MockCompositionContainer
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Systems/UI/Placeable/PlaceableSelectionUITest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetSystemsContext

```csharp
public void SetSystemsContext(MockGBSystemsContext context) => _systemsContext = context;
```

**Returns:** `void`

**Parameters:**
- `MockGBSystemsContext context`

### SetModeState

```csharp
public void SetModeState(MockModeState modeState) => _modeState = modeState;
```

**Returns:** `void`

**Parameters:**
- `MockModeState modeState`

### GetSystemsContext

```csharp
public MockGBSystemsContext GetSystemsContext() => _systemsContext ?? throw new InvalidOperationException();
```

**Returns:** `MockGBSystemsContext`

### GetModeState

```csharp
public MockModeState GetModeState() => _modeState ?? throw new InvalidOperationException();
```

**Returns:** `MockModeState`

