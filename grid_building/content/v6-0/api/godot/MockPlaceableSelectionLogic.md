---
title: "MockPlaceableSelectionLogic"
description: "Mock implementations for testing PlaceableSelectionUI functionality."
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockplaceableselectionlogic/"
---

# MockPlaceableSelectionLogic

```csharp
GridBuilding.Godot.Tests.Mocks
class MockPlaceableSelectionLogic
{
    // Members...
}
```

Mock implementations for testing PlaceableSelectionUI functionality.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Mocks/PlaceableSelectionMocks.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Mocks`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### HandleModeChangedCalled

```csharp
public bool HandleModeChangedCalled { get; private set; }
```

### HandleUIHiddenCalled

```csharp
public bool HandleUIHiddenCalled { get; private set; }
```


## Methods

### HandleModeChanged

```csharp
public void HandleModeChanged(BuildingMode mode, Control uiRoot)
    {
        HandleModeChangedCalled = true;
        base.HandleModeChanged(mode, uiRoot);
    }
```

**Returns:** `void`

**Parameters:**
- `BuildingMode mode`
- `Control uiRoot`

### HandleUIHidden

```csharp
public void HandleUIHidden(Control uiRoot)
    {
        HandleUIHiddenCalled = true;
        base.HandleUIHidden(uiRoot);
    }
```

**Returns:** `void`

**Parameters:**
- `Control uiRoot`

