---
title: "PreviewBuilder"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/previewbuilder/"
---

# PreviewBuilder

```csharp
GridBuilding.Godot.Systems.Building.Internal
class PreviewBuilder
{
    // Members...
}
```

Manages preview instances for building operations.
Ported from: godot/addons/grid_building/systems/building/preview_builder.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Building/Internal/PreviewBuilder.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Building.Internal`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### FromContainer

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Creates a PreviewBuilder from a dependency injection container.
    /// </summary>
    /// <param name="container">The dependency injection container</param>
    /// <returns>Configured PreviewBuilder instance</returns>
    public static PreviewBuilder FromContainer(CompositionContainer? container)
    {
        if (container == null)
            return new PreviewBuilder(null, null, null);

        return new PreviewBuilder(
            container.GetStates(),
            container.GetBuildingSettings(),
            container.GetLogger()
        );
    }
```

Creates a PreviewBuilder from a dependency injection container.

**Returns:** `PreviewBuilder`

**Parameters:**
- `CompositionContainer? container`

### CreatePreview

```csharp
/// <summary>
    /// Creates a preview instance for the specified placeable.
    /// </summary>
    /// <param name="placeable">The placeable resource to create a preview for</param>
    /// <returns>The created preview instance, or null if failed</returns>
    public Node2D? CreatePreview(Resource placeable)
    {
        if (placeable == null)
            return null;

        // Clear existing preview
        ClearPreview();

        // TODO: Implement proper preview creation logic
        // This would involve:
        // 1. Loading the packed scene from the placeable
        // 2. Instantiating a preview version
        // 3. Setting up preview-specific properties (transparency, collision disabled)
        // 4. Adding to the preview parent
        
        _preview = null; // Placeholder until full implementation
        
        _logger?.LogInfo($"Created preview for {placeable.Get("name")?.AsString() ?? "Unknown"}");
        return _preview;
    }
```

Creates a preview instance for the specified placeable.

**Returns:** `Node2D?`

**Parameters:**
- `Resource placeable`

### GetPreview

```csharp
/// <summary>
    /// Gets the current preview instance.
    /// </summary>
    /// <returns>The current preview instance, or null if none exists</returns>
    public Node2D? GetPreview()
    {
        return _preview;
    }
```

Gets the current preview instance.

**Returns:** `Node2D?`

### ClearPreview

```csharp
/// <summary>
    /// Clears the current preview instance.
    /// </summary>
    public void ClearPreview()
    {
        if (_preview != null)
        {
            _preview.QueueFree();
            _preview = null;
        }

        _logger?.LogInfo("Preview cleared");
    }
```

Clears the current preview instance.

**Returns:** `void`

### AlignToGrid

```csharp
/// <summary>
    /// Aligns the preview to the grid at the specified position.
    /// </summary>
    /// <param name="globalPosition">The global position to align to</param>
    public void AlignToGrid(Vector2 globalPosition)
    {
        if (_preview == null)
            return;

        // TODO: Implement grid alignment logic
        // This would involve:
        // 1. Getting the grid cell size from settings
        // 2. Snapping the position to the nearest grid cell
        // 3. Updating the preview position
        
        _preview.GlobalPosition = globalPosition; // Placeholder
    }
```

Aligns the preview to the grid at the specified position.

**Returns:** `void`

**Parameters:**
- `Vector2 globalPosition`

### UpdatePreviewPosition

```csharp
/// <summary>
    /// Updates the preview position to follow the targeting system.
    /// </summary>
    public void UpdatePreviewPosition()
    {
        if (_preview == null || _states?.Targeting == null)
            return;

        var targetPosition = _states.Targeting.GetTargetPosition();
        if (targetPosition != Vector2.Zero)
        {
            AlignToGrid(targetPosition);
        }
    }
```

Updates the preview position to follow the targeting system.

**Returns:** `void`

### SetPreviewVisible

```csharp
/// <summary>
    /// Sets the visibility of the preview.
    /// </summary>
    /// <param name="visible">Whether the preview should be visible</param>
    public void SetPreviewVisible(bool visible)
    {
        if (_preview != null)
        {
            _preview.Visible = visible;
        }
    }
```

Sets the visibility of the preview.

**Returns:** `void`

**Parameters:**
- `bool visible`

### SetValidPlacement

```csharp
/// <summary>
    /// Sets the preview to show valid placement state.
    /// </summary>
    public void SetValidPlacement()
    {
        // TODO: Implement visual feedback for valid placement
        // This might involve changing color, opacity, or other visual properties
        _logger?.LogDebug("Preview set to valid placement state");
    }
```

Sets the preview to show valid placement state.

**Returns:** `void`

### SetInvalidPlacement

```csharp
/// <summary>
    /// Sets the preview to show invalid placement state.
    /// </summary>
    public void SetInvalidPlacement()
    {
        // TODO: Implement visual feedback for invalid placement
        // This might involve changing color, opacity, or other visual properties
        _logger?.LogDebug("Preview set to invalid placement state");
    }
```

Sets the preview to show invalid placement state.

**Returns:** `void`

