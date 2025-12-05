---
title: "MockBuildingSystem"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockbuildingsystem/"
---

# MockBuildingSystem

```csharp
GridBuilding.Godot.Tests.Systems.UI.Placeable
class MockBuildingSystem
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

### EnterBuildModeCalled

```csharp
public bool EnterBuildModeCalled { get; private set; }
```

### LastEnteredPlaceable

```csharp
public Resource LastEnteredPlaceable { get; private set; }
```


## Methods

### EnterBuildMode

```csharp
public PlacementResult? EnterBuildMode(Resource placeable)
    {
        EnterBuildModeCalled = true;
        LastEnteredPlaceable = placeable;
        
        // Return a mock success report
        return PlacementResult.Successful(
            new Types.Vector2I(0, 0),
            new Types.Vector2(0, 0)
        );
    }
```

**Returns:** `PlacementResult?`

**Parameters:**
- `Resource placeable`

