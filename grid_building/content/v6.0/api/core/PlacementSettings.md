---
title: "PlacementSettings"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placementsettings/"
---

# PlacementSettings

```csharp
GridBuilding.Core.Systems.Configuration
class PlacementSettings
{
    // Members...
}
```

Placement settings for the GridBuilding plugin.
Provides configuration for object placement behaviors,
validation rules, and placement constraints. This is a pure C# implementation for Core use.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Configuration/PlacementSettings.cs`  
**Namespace:** `GridBuilding.Core.Systems.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnablePlacementValidation

```csharp
/// <summary>
    /// Whether to enable placement validation
    /// </summary>
    public bool EnablePlacementValidation { get; set; } = true;
```

Whether to enable placement validation

### EnableGridSnapping

```csharp
/// <summary>
    /// Whether to enable grid snapping during placement
    /// </summary>
    public bool EnableGridSnapping { get; set; } = true;
```

Whether to enable grid snapping during placement

### GridSnapSize

```csharp
/// <summary>
    /// Grid snap size for placement
    /// </summary>
    public float GridSnapSize { get; set; } = 1.0f;
```

Grid snap size for placement

### EnableCollisionChecking

```csharp
/// <summary>
    /// Whether to enable collision checking during placement
    /// </summary>
    public bool EnableCollisionChecking { get; set; } = true;
```

Whether to enable collision checking during placement

### AllowPlacementOnOccupiedTiles

```csharp
/// <summary>
    /// Whether to allow placement on occupied tiles
    /// </summary>
    public bool AllowPlacementOnOccupiedTiles { get; set; } = false;
```

Whether to allow placement on occupied tiles

### ShowPlacementPreview

```csharp
/// <summary>
    /// Whether to show placement preview
    /// </summary>
    public bool ShowPlacementPreview { get; set; } = true;
```

Whether to show placement preview

### PlacementPreviewOpacity

```csharp
/// <summary>
    /// Placement preview opacity (0.0 to 1.0)
    /// </summary>
    public float PlacementPreviewOpacity { get; set; } = 0.7f;
```

Placement preview opacity (0.0 to 1.0)

### EnablePlacementSounds

```csharp
/// <summary>
    /// Whether to enable placement sounds
    /// </summary>
    public bool EnablePlacementSounds { get; set; } = true;
```

Whether to enable placement sounds

### PlacementSoundVolume

```csharp
/// <summary>
    /// Volume for placement sounds (0.0 to 1.0)
    /// </summary>
    public float PlacementSoundVolume { get; set; } = 0.8f;
```

Volume for placement sounds (0.0 to 1.0)

### EnablePlacementAnimations

```csharp
/// <summary>
    /// Whether to enable placement animations
    /// </summary>
    public bool EnablePlacementAnimations { get; set; } = true;
```

Whether to enable placement animations

### PlacementAnimationDuration

```csharp
/// <summary>
    /// Placement animation duration in seconds
    /// </summary>
    public float PlacementAnimationDuration { get; set; } = 0.3f;
```

Placement animation duration in seconds

### AllowPlacementWhileDragging

```csharp
/// <summary>
    /// Whether to allow placement while dragging
    /// </summary>
    public bool AllowPlacementWhileDragging { get; set; } = false;
```

Whether to allow placement while dragging

### MinimumPlacementDistance

```csharp
/// <summary>
    /// Minimum distance between placed objects
    /// </summary>
    public float MinimumPlacementDistance { get; set; } = 0.0f;
```

Minimum distance between placed objects

### EnableAutoRotation

```csharp
/// <summary>
    /// Whether to enable auto-rotation for placement
    /// </summary>
    public bool EnableAutoRotation { get; set; } = false;
```

Whether to enable auto-rotation for placement

### AutoRotationSnapAngle

```csharp
/// <summary>
    /// Auto-rotation snap angle in degrees
    /// </summary>
    public float AutoRotationSnapAngle { get; set; } = 90.0f;
```

Auto-rotation snap angle in degrees

