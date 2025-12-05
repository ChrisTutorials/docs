---
title: "MockModeState"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockmodestate/"
---

# MockModeState

```csharp
GridBuilding.Godot.Tests.Systems.UI.Placeable
class MockModeState
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


## Properties

### Current

```csharp
public BuildingMode Current { get; set; } = BuildingMode.OFF;
```


## Methods

### SetMode

```csharp
public void SetMode(BuildingMode mode)
    {
        if (Current != mode)
        {
            Current = mode;
            ModeChanged?.Invoke(mode);
        }
    }
```

**Returns:** `void`

**Parameters:**
- `BuildingMode mode`

