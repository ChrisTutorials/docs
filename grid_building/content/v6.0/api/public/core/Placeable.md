---
title: "Placeable"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/placeable/"
---

# Placeable

```csharp
GridBuilding.Core.Types
class Placeable
{
    // Members...
}
```

Core placeable type for placement operations
Pure C# implementation without Engine dependencies
This is the primary data structure used by UI components for displaying placeable information.
UI components work directly with Core Placeables without needing Engine Resource wrappers,
maintaining clean separation between engine-agnostic logic and engine-specific implementation.
UI Usage:
- Display properties: Id, Name, Description for UI labels and tooltips
- Visual properties: Size, Position for grid placement and preview rendering
- Custom data: Properties dictionary for category, cost, tags, and other UI-specific data
- Validation: IsValid flag to enable/disable UI interactions
For Engine-specific operations (scene instantiation, resource loading), use PlaceableResourceHandler.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/Placeable.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
/// <summary>
        /// Unique identifier for the placeable
        /// Used by UI for lookup and as a key in data structures
        /// </summary>
        public string Id { get; set; } = string.Empty;
```

Unique identifier for the placeable
Used by UI for lookup and as a key in data structures

### Name

```csharp
/// <summary>
        /// Display name shown in UI
        /// Primary label for UI components (menus, tooltips, etc.)
        /// </summary>
        public string Name { get; set; } = string.Empty;
```

Display name shown in UI
Primary label for UI components (menus, tooltips, etc.)

### Description

```csharp
/// <summary>
        /// Detailed description for UI tooltips and help text
        /// Provides additional context about the placeable in the UI
        /// </summary>
        public string Description { get; set; } = string.Empty;
```

Detailed description for UI tooltips and help text
Provides additional context about the placeable in the UI

### Position

```csharp
/// <summary>
        /// Grid position for placement
        /// Used by UI for grid positioning and preview rendering
        /// </summary>
        public Vector2I Position { get; set; } = new Vector2I(0, 0);
```

Grid position for placement
Used by UI for grid positioning and preview rendering

### Category

```csharp
/// <summary>
        /// Category identifier for grouping and filtering
        /// String-based to allow game-specific categories and runtime customization
        /// </summary>
        public string Category { get; set; } = PlaceableCategory.Unknown;
```

Category identifier for grouping and filtering
String-based to allow game-specific categories and runtime customization

### CanRotate

```csharp
/// <summary>
        /// Whether this placeable can be rotated during placement
        /// Affects UI controls and placement validation
        /// </summary>
        public bool CanRotate { get; set; } = true;
```

Whether this placeable can be rotated during placement
Affects UI controls and placement validation

### CanMirror

```csharp
/// <summary>
        /// Whether this placeable can be mirrored/flipped during placement
        /// Affects UI controls and available placement options
        /// </summary>
        public bool CanMirror { get; set; } = false;
```

Whether this placeable can be mirrored/flipped during placement
Affects UI controls and available placement options

### ResourceCost

```csharp
/// <summary>
        /// Resource cost required to place this object
        /// Used by UI for cost display and placement validation
        /// </summary>
        public Dictionary<string, int> ResourceCost { get; set; } = new();
```

Resource cost required to place this object
Used by UI for cost display and placement validation

### VariantsList

```csharp
/// <summary>
        /// Visual variants available for this placeable
        /// Multiple visual representations while sharing core gameplay logic
        /// </summary>
        public List<PlaceableVariant> VariantsList { get; set; } = new();
```

Visual variants available for this placeable
Multiple visual representations while sharing core gameplay logic

### Variants

```csharp
/// <summary>
        /// Visual variants available for this placeable (interface implementation)
        /// </summary>
        public IEnumerable<PlaceableVariant> Variants => VariantsList;
```

Visual variants available for this placeable (interface implementation)

### Size

```csharp
/// <summary>
        /// Size dimensions for UI layout and collision detection
        /// Used by UI for grid overlay, placement preview, and space calculation
        /// </summary>
        public Vector2I Size { get; set; } = new Vector2I(1, 1);
```

Size dimensions for UI layout and collision detection
Used by UI for grid overlay, placement preview, and space calculation

### IsValid

```csharp
/// <summary>
        /// Validation flag for UI state management
        /// UI components should check this to enable/disable interactions
        /// </summary>
        public bool IsValid { get; set; } = true;
```

Validation flag for UI state management
UI components should check this to enable/disable interactions

### FilePath

```csharp
/// <summary>
        /// File path to the scene or resource file this placeable represents
        /// Engine-agnostic path (e.g., "buildings/house.tscn")
        /// Should always be an instantiatable .tscn file. Must be validated before attempting to use.
        /// Godot layer will convert this to res:// paths as needed.
        /// 
        /// UI Note: Generally not used directly by UI, but available for debugging or advanced features
        /// </summary>
        public string FilePath { get; set; } = string.Empty;
```

File path to the scene or resource file this placeable represents
Engine-agnostic path (e.g., "buildings/house.tscn")
Should always be an instantiatable .tscn file. Must be validated before attempting to use.
Godot layer will convert this to res:// paths as needed.
/// UI Note: Generally not used directly by UI, but available for debugging or advanced features

### ResourceUid

```csharp
/// <summary>
        /// Godot resource UID for the file (alternative to FilePath)
        /// Used when files are referenced by UID instead of path
        /// 
        /// UI Note: Generally not used directly by UI, but available for debugging or advanced features
        /// </summary>
        public string? ResourceUid { get; set; }
```

Godot resource UID for the file (alternative to FilePath)
Used when files are referenced by UID instead of path
/// UI Note: Generally not used directly by UI, but available for debugging or advanced features

### Properties

```csharp
/// <summary>
        /// Flexible property storage for UI-specific data
        /// Common UI properties include:
        /// - "category": String for grouping/filtering in UI
        /// - "cost": String or numeric value for resource display
        /// - "tags": Array of strings for search/filter functionality
        /// - "requires_power": Boolean for conditional UI display
        /// - Any custom properties needed by specific UI components
        /// 
        /// UI components should use GetValueOrDefault() with sensible defaults for robustness
        /// </summary>
        public Dictionary<string, object> Properties { get; set; } = new();
```

Flexible property storage for UI-specific data
Common UI properties include:
- "category": String for grouping/filtering in UI
- "cost": String or numeric value for resource display
- "tags": Array of strings for search/filter functionality
- "requires_power": Boolean for conditional UI display
- Any custom properties needed by specific UI components
/// UI components should use GetValueOrDefault() with sensible defaults for robustness

