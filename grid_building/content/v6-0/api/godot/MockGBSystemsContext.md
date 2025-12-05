---
title: "MockGBSystemsContext"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockgbsystemscontext/"
---

# MockGBSystemsContext

```csharp
GridBuilding.Godot.Tests.Systems.UI.Placeable
class MockGBSystemsContext
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

### SetBuildingSystem

```csharp
public void SetBuildingSystem(MockBuildingSystem system) => _buildingSystem = system;
```

**Returns:** `void`

**Parameters:**
- `MockBuildingSystem system`

### SetModeState

```csharp
public void SetModeState(MockModeState modeState) => _modeState = modeState;
```

**Returns:** `void`

**Parameters:**
- `MockModeState modeState`

### SetIndicatorContext

```csharp
public void SetIndicatorContext(MockIndicatorContext indicatorContext) => _indicatorContext = indicatorContext;
```

**Returns:** `void`

**Parameters:**
- `MockIndicatorContext indicatorContext`

### GetBuildingSystem

```csharp
public MockBuildingSystem? GetBuildingSystem() => _buildingSystem;
```

**Returns:** `MockBuildingSystem?`

### GetModeState

```csharp
public MockModeState? GetModeState() => _modeState;
```

**Returns:** `MockModeState?`

### GetIndicatorContext

```csharp
public MockIndicatorContext? GetIndicatorContext() => _indicatorContext;
```

**Returns:** `MockIndicatorContext?`

