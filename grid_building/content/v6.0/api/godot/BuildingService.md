---
title: "BuildingService"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/buildingservice/"
---

# BuildingService

```csharp
GridBuilding.Godot.Services
class BuildingService
{
    // Members...
}
```

Service-based implementation of building operations.
Uses composition instead of inheritance for better flexibility.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Services/BuildingService.cs`  
**Namespace:** `GridBuilding.Godot.Services`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### State

```csharp
#endregion

    #region Properties
    public BuildingState State => _coreSystem.GetState();
```


## Methods

### PlaceBuilding

```csharp
#endregion

    #region IBuildingService Implementation
    public BuildActionData? PlaceBuilding(Vector2I position, object placeable)
    {
        try
        {
            // Delegate to core system for business logic
            var result = _coreSystem.PlaceBuilding(position, placeable);
            
            // Emit Godot-specific events if needed
            EmitBuildingEvents(result);
            
            return result;
        }
        catch (Exception ex)
        {
            GD.PrintErr($"BuildingService: Failed to place building at {position}: {ex.Message}");
            return null;
        }
    }
```

**Returns:** `BuildActionData?`

**Parameters:**
- `Vector2I position`
- `object placeable`

### CreatePreview

```csharp
public Node? CreatePreview(object placeable)
    {
        try
        {
            // Use core system to create preview data
            var previewData = _coreSystem.CreatePreviewData(placeable);
            
            // Convert to Godot Node
            return CreateGodotPreview(previewData);
        }
        catch (Exception ex)
        {
            GD.PrintErr($"BuildingService: Failed to create preview: {ex.Message}");
            return null;
        }
    }
```

**Returns:** `Node?`

**Parameters:**
- `object placeable`

### ValidatePlacement

```csharp
public bool ValidatePlacement(Vector2I position, object placeable)
    {
        try
        {
            return _coreSystem.ValidatePlacement(position, placeable);
        }
        catch (Exception ex)
        {
            GD.PrintErr($"BuildingService: Failed to validate placement: {ex.Message}");
            return false;
        }
    }
```

**Returns:** `bool`

**Parameters:**
- `Vector2I position`
- `object placeable`

