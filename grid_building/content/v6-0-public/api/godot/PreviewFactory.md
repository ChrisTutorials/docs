---
title: "PreviewFactory"
description: ""
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/previewfactory/"
---

# PreviewFactory

```csharp
GridBuilding.Godot.UI
class PreviewFactory
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/PreviewFactory.cs`  
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
[Export] public Color ValidColor { get; set; } = Colors.Green;
```

### InvalidColor

```csharp
[Export] public Color InvalidColor { get; set; } = Colors.Red;
```

### ShowGridSnapping

```csharp
[Export] public bool ShowGridSnapping { get; set; } = true;
```

### CurrentBuilding

```csharp
public BuildingState CurrentBuilding => _currentBuilding;
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
public override void _Ready()
        {
            base._Ready();
            
            // Set up default values
            ValidColor = new Color(0.0f, 1.0f, 0.0f, PreviewTransparency);
            InvalidColor = new Color(1.0f, 0.0f, 0.0f, PreviewTransparency * 0.7f);
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
/// <summary>
        /// Creates a new preview indicator for the specified building
        /// </summary>
        /// <param name="building">Building data to create preview for</param>
        /// <param name="gridPosition">Initial grid position</param>
        /// <returns>The created preview indicator</returns>
        public IndicatorFactory CreatePreview(BuildingData building, GodotVector2I gridPosition)
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
                GD.PrintErr("Cannot create preview: building data is null");
                return null;
            }
            
            // Create new preview indicator
            _currentPreview = new IndicatorFactory();
            _currentPreview.Name = "PreviewIndicator";
            
            // Set initial position
            UpdatePreviewPosition(gridPosition);
            
            // Set initial appearance based on validity
            UpdatePreviewAppearance(gridPosition);
            
            // Add to scene tree
            AddChild(_currentPreview);
            
            // Configure preview based on building footprint
            ConfigurePreviewForBuilding(building);
            
            EmitSignal(SignalName.PreviewCreated, building);
            
            return _currentPreview;
        }
```

Creates a new preview indicator for the specified building

**Returns:** `IndicatorFactory`

**Parameters:**
- `BuildingData building`
- `GodotVector2I gridPosition`

### UpdatePreview

```csharp
/// <summary>
        /// Updates the preview to a new grid position
        /// </summary>
        /// <param name="newGridPosition">New grid position</param>
        public void UpdatePreview(GodotVector2I newGridPosition)
        {
            if (_currentPreview == null || _currentBuilding == null)
                return;
                
            _currentGridPosition = newGridPosition;
            
            // Update position
            UpdatePreviewPosition(newGridPosition);
            
            // Update appearance based on placement validity
            UpdatePreviewAppearance(newGridPosition);
            
            EmitSignal(SignalName.PreviewUpdated, newGridPosition, _isValidPlacement);
        }
```

Updates the preview to a new grid position

**Returns:** `void`

**Parameters:**
- `GodotVector2I newGridPosition`

### DestroyPreview

```csharp
/// <summary>
        /// Destroys the current preview indicator
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
        }
```

Destroys the current preview indicator

**Returns:** `void`

### SetPreviewColors

```csharp
/// <summary>
        /// Sets the preview colors
        /// </summary>
        /// <param name="validColor">Color for valid placement</param>
        /// <param name="invalidColor">Color for invalid placement</param>
        public void SetPreviewColors(Color validColor, Color invalidColor)
        {
            ValidColor = new Color(validColor.R, validColor.G, validColor.B, PreviewTransparency);
            InvalidColor = new Color(invalidColor.R, invalidColor.G, invalidColor.B, PreviewTransparency * 0.7f);
            
            // Update current preview if active
            if (HasActivePreview)
            {
                UpdatePreviewAppearance(_currentGridPosition);
            }
        }
```

Sets the preview colors

**Returns:** `void`

**Parameters:**
- `Color validColor`
- `Color invalidColor`

### SetPreviewTransparency

```csharp
/// <summary>
        /// Sets the preview transparency
        /// </summary>
        /// <param name="transparency">Transparency value (0-1)</param>
        public void SetPreviewTransparency(float transparency)
        {
            PreviewTransparency = Mathf.Clamp(transparency, 0.0f, 1.0f);
            
            // Update colors with new transparency
            ValidColor = new Color(ValidColor.R, ValidColor.G, ValidColor.B, PreviewTransparency);
            InvalidColor = new Color(InvalidColor.R, InvalidColor.G, InvalidColor.B, PreviewTransparency * 0.7f);
            
            // Update current preview if active
            if (HasActivePreview)
            {
                UpdatePreviewAppearance(_currentGridPosition);
            }
        }
```

Sets the preview transparency

**Returns:** `void`

**Parameters:**
- `float transparency`

