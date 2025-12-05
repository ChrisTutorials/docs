---
title: "TestPlaceableNode"
description: "Test fixture node for placeable loading tests
Represents a simple placeable that can be instantiated from Core Placeable definitions"
weight: 20
url: "/gridbuilding/v6-0/api/godot/testplaceablenode/"
---

# TestPlaceableNode

```csharp
GridBuilding.Godot.Tests.Fixtures
class TestPlaceableNode
{
    // Members...
}
```

Test fixture node for placeable loading tests
Represents a simple placeable that can be instantiated from Core Placeable definitions

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Fixtures/TestPlaceableNode.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Fixtures`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PlaceableId

```csharp
/// <summary>
    /// The placeable ID from Core definition
    /// </summary>
    [Export]
    public string PlaceableId { get; set; } = string.Empty;
```

The placeable ID from Core definition

### PlaceableName

```csharp
/// <summary>
    /// The placeable name from Core definition
    /// </summary>
    [Export]
    public string PlaceableName { get; set; } = string.Empty;
```

The placeable name from Core definition

### IsActive

```csharp
/// <summary>
    /// Whether this placeable is currently active
    /// </summary>
    [Export]
    public bool IsActive { get; set; } = true;
```

Whether this placeable is currently active


## Methods

### _Ready

```csharp
public override void _Ready()
    {
        GD.Print($"TestPlaceableNode ready: {PlaceableName} ({PlaceableId})");
    }
```

**Returns:** `void`

### InitializeFromCore

```csharp
/// <summary>
    /// Initialize the node with Core Placeable data
    /// </summary>
    /// <param name="placeableId">ID from Core Placeable</param>
    /// <param name="placeableName">Name from Core Placeable</param>
    public void InitializeFromCore(string placeableId, string placeableName)
    {
        PlaceableId = placeableId;
        PlaceableName = placeableName;
    }
```

Initialize the node with Core Placeable data

**Returns:** `void`

**Parameters:**
- `string placeableId`
- `string placeableName`

### IsProperlyInitialized

```csharp
/// <summary>
    /// Test method to verify the node was properly instantiated
    /// </summary>
    /// <returns>True if properly initialized</returns>
    public bool IsProperlyInitialized()
    {
        return !string.IsNullOrEmpty(PlaceableId) && !string.IsNullOrEmpty(PlaceableName);
    }
```

Test method to verify the node was properly instantiated

**Returns:** `bool`

