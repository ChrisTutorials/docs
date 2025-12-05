---
title: "PreviewFactoryIntegrated"
description: "Integrated PreviewFactory that uses Core business logic through interfaces.
This updated version delegates all calculation logic to the Core PreviewCalculationService
while maintaining the same Godot-specific responsibilities for node management,
visual presentation, and user interaction.
## Architecture
- Core Layer: Pure business logic via IPreviewCalculationService
- Adapter Layer: Converts between Godot and Core data structures
- Godot Layer: Node lifecycle, visual rendering, user interaction"
weight: 20
url: "/gridbuilding/v6-0/api/godot/previewfactoryintegrated/"
---

# PreviewFactoryIntegrated

```csharp
GridBuilding.Godot.UI
class PreviewFactoryIntegrated
{
    // Members...
}
```

Integrated PreviewFactory that uses Core business logic through interfaces.
This updated version delegates all calculation logic to the Core PreviewCalculationService
while maintaining the same Godot-specific responsibilities for node management,
visual presentation, and user interaction.
## Architecture
- Core Layer: Pure business logic via IPreviewCalculationService
- Adapter Layer: Converts between Godot and Core data structures
- Godot Layer: Node lifecycle, visual rendering, user interaction

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/PreviewFactoryIntegrated.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PreviewTransparency

```csharp
[Export] public float PreviewTransparency { get; set; } = 0.5f;
```

### ValidColor

```csharp
[Export] public GodotColor ValidColor { get; set; } = Colors.Green;
```

### InvalidColor

```csharp
[Export] public GodotColor InvalidColor { get; set; } = Colors.Red;
```

### ShowGridSnapping

```csharp
[Export] public bool ShowGridSnapping { get; set; } = true;
```

### CurrentBuilding

```csharp
#endregion

    #region Properties

    public BuildingDataGodot CurrentBuilding => _currentBuilding;
```

### CurrentGridPosition

```csharp
public GodotVector2I CurrentGridPosition => _currentGridPosition;
```

### HasActivePreview

```csharp
public bool HasActivePreview => _currentPreview != null && _currentBuilding != null;
```

### IsValidPlacement

```csharp
public bool IsValidPlacement => _isValidPlacement;
```


## Methods

### _Ready

```csharp
#endregion

    #region Godot Lifecycle

    public override void _Ready()
    {
        base._Ready();
        
        // Set up default values
        ValidColor = new GodotColor(0.0f, 1.0f, 0.0f, PreviewTransparency);
        InvalidColor = new GodotColor(1.0f, 0.0f, 0.0f, PreviewTransparency * 0.7f);
    }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
    {
        DestroyPreview();
        base._ExitTree();
    }
```

**Returns:** `void`

### CreatePreview

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Creates a new preview indicator using Core calculation service.
    /// </summary>
    /// <param name="building">Building data to create preview for</param>
    /// <param name="gridPosition">Initial grid position</param>
    /// <returns>The created preview indicator</returns>
    public IndicatorFactory CreatePreview(BuildingDataGodot building, GodotVector2I gridPosition)
    {
        // Clean up existing preview
        if (_currentPreview != null)
        {
            DestroyPreview();
        }
        
        _currentBuilding = building;
        _currentGridPosition = gridPosition;
        
        if (building == null)
        {
            _logger?.LogErr("Cannot create preview: building data is null");
            return null;
        }
        
        // Use Core service to calculate preview data
        var previewData = _coreService.CalculatePreview(
            ConvertBuildingDataToCore(building),
            gridPosition.ToCore(),
            _occupancyAdapter,
            validityCheck: true);
        
        // Handle calculation issues
        if (previewData.HasIssues)
        {
            foreach (var issue in previewData.Issues)
            {
                _logger?.LogWarning($"Core Preview Calculation Issue: {issue}");
            }
        }
        
        // Create new preview indicator
        _currentPreview = new IndicatorFactory();
        _currentPreview.Name = "PreviewIndicator";
        
        // Set position based on Core calculation
        UpdatePreviewPosition(gridPosition);
        
        // Set appearance based on Core calculation result
        UpdatePreviewAppearanceFromCoreResult(previewData);
        
        // Add to scene tree
        AddChild(_currentPreview);
        
        // Configure preview based on Core shape data
        ConfigurePreviewFromCoreShapeData(previewData.ShapeData);
        
        // Update validity state
        _isValidPlacement = previewData.IsValidPlacement;
        
        EmitSignal(SignalName.PreviewCreated, building);
        
        _logger?.LogDebug($"Created preview for {building.Name} at {gridPosition}, valid: {_isValidPlacement}");
        
        return _currentPreview;
    }
```

Creates a new preview indicator using Core calculation service.

**Returns:** `IndicatorFactory`

**Parameters:**
- `BuildingDataGodot building`
- `GodotVector2I gridPosition`

### UpdatePreview

```csharp
/// <summary>
    /// Updates the preview to a new grid position using Core service.
    /// </summary>
    /// <param name="newGridPosition">New grid position</param>
    public void UpdatePreview(GodotVector2I newGridPosition)
    {
        if (_currentPreview == null || _currentBuilding == null)
            return;
            
        _currentGridPosition = newGridPosition;
        
        // Convert current preview state to Core format for update
        var currentCoreResult = ConvertCurrentPreviewToCoreResult();
        
        // Use Core service to update position
        var updatedResult = _coreService.UpdatePreviewPosition(
            currentCoreResult,
            newGridPosition.ToCore(),
            _occupancyAdapter);
        
        // Update position
        UpdatePreviewPosition(newGridPosition);
        
        // Update appearance based on updated Core result
        UpdatePreviewAppearanceFromCoreResult(updatedResult);
        
        // Update validity state
        _isValidPlacement = updatedResult.IsValidPlacement;
        
        EmitSignal(SignalName.PreviewUpdated, newGridPosition, _isValidPlacement);
        
        _logger?.LogDebug($"Updated preview to {newGridPosition}, valid: {_isValidPlacement}");
    }
```

Updates the preview to a new grid position using Core service.

**Returns:** `void`

**Parameters:**
- `GodotVector2I newGridPosition`

### DestroyPreview

```csharp
/// <summary>
    /// Destroys the current preview indicator.
    /// </summary>
    public void DestroyPreview()
    {
        if (_currentPreview != null)
        {
            _currentPreview.QueueFree();
            _currentPreview = null;
        }
        
        _currentBuilding = null;
        _currentGridPosition = GodotVector2I.Zero;
        _isValidPlacement = true;
        
        EmitSignal(SignalName.PreviewDestroyed);
        
        _logger?.LogDebug("Destroyed preview");
    }
```

Destroys the current preview indicator.

**Returns:** `void`

### SetPreviewColors

```csharp
/// <summary>
    /// Sets the preview colors using Core service for visual appearance calculation.
    /// </summary>
    /// <param name="validColor">Color for valid placement</param>
    /// <param name="invalidColor">Color for invalid placement</param>
    public void SetPreviewColors(GodotColor validColor, GodotColor invalidColor)
    {
        ValidColor = validColor;
        InvalidColor = invalidColor;
        
        // Update current preview if active
        if (HasActivePreview)
        {
            var visualSettings = _coreService.CalculateVisualAppearance(
                _isValidPlacement,
                PreviewTransparency,
                validColor.ToCore(),
                invalidColor.ToCore());
            
            ApplyVisualSettingsToPreview(visualSettings);
        }
    }
```

Sets the preview colors using Core service for visual appearance calculation.

**Returns:** `void`

**Parameters:**
- `GodotColor validColor`
- `GodotColor invalidColor`

### SetPreviewTransparency

```csharp
/// <summary>
    /// Sets the preview transparency using Core service for visual appearance calculation.
    /// </summary>
    /// <param name="transparency">Transparency value (0-1)</param>
    public void SetPreviewTransparency(float transparency)
    {
        PreviewTransparency = Mathf.Clamp(transparency, 0.0f, 1.0f);
        
        // Update colors with new transparency using Core service
        var visualSettings = _coreService.CalculateVisualAppearance(
            _isValidPlacement,
            PreviewTransparency,
            ValidColor.ToCore(),
            InvalidColor.ToCore());
        
        ApplyVisualSettingsToPreview(visualSettings);
    }
```

Sets the preview transparency using Core service for visual appearance calculation.

**Returns:** `void`

**Parameters:**
- `float transparency`

### ValidateCurrentPlacement

```csharp
/// <summary>
    /// Validates placement at the current position using Core service.
    /// </summary>
    /// <returns>True if placement is valid</returns>
    public bool ValidateCurrentPlacement()
    {
        if (_currentBuilding == null)
            return false;
            
        var coreBuilding = ConvertBuildingDataToCore(_currentBuilding);
        return _coreService.CheckGridBounds(
            coreBuilding,
            _currentGridPosition.ToCore(),
            _occupancyAdapter.GetGridSize());
    }
```

Validates placement at the current position using Core service.

**Returns:** `bool`

