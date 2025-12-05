---
title: "PlaceableDefinition"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placeabledefinition/"
---

# PlaceableDefinition

```csharp
GridBuilding.Godot.Systems.Placement.Data
class PlaceableDefinition
{
    // Members...
}
```

Godot-specific wrapper around a core Placeable implementation.
<para>
Implements IPlaceable by delegating to a core Placeable instance while
adding Godot-specific functionality like scene instantiation and resource handling.
This maintains the POCS (Plain Old C# Separation) principle:
- Core logic stays engine-agnostic
- Engine-specific code wraps core functionality
- Both implementations share the same interface
</para>
<para>
Usage pattern:
1. Create core Placeable (POCS) with configuration
2. Wrap with GodotPlaceableWrapper for Godot operations
3. Use IPlaceable interface for interchangeability
</para>

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Data/PlaceableDefinition.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
#region IPlaceable Implementation (delegated to core)

        /// <summary>
        /// Unique identifier for the placeable
        /// </summary>
        public string Id => _core.Id;
```

Unique identifier for the placeable

### Name

```csharp
/// <summary>
        /// Human-readable display name
        /// </summary>
        public string Name => _core.Name;
```

Human-readable display name

### Description

```csharp
/// <summary>
        /// Detailed description of the placeable
        /// </summary>
        public string Description => _core.Description;
```

Detailed description of the placeable

### Size

```csharp
/// <summary>
        /// Size dimensions in grid units
        /// </summary>
        public Vector2I Size => _core.Size;
```

Size dimensions in grid units

### Category

```csharp
/// <summary>
        /// Category identifier for grouping and filtering
        /// </summary>
        public string Category => _core.Category;
```

Category identifier for grouping and filtering

### CanRotate

```csharp
/// <summary>
        /// Whether this placeable can be rotated during placement
        /// </summary>
        public bool CanRotate => _core.CanRotate;
```

Whether this placeable can be rotated during placement

### CanMirror

```csharp
/// <summary>
        /// Whether this placeable can be mirrored/flipped during placement
        /// </summary>
        public bool CanMirror => _core.CanMirror;
```

Whether this placeable can be mirrored/flipped during placement

### ResourceCost

```csharp
/// <summary>
        /// Resource cost required to place this object
        /// </summary>
        public Dictionary<string, int> ResourceCost => _core.ResourceCost;
```

Resource cost required to place this object

### Properties

```csharp
/// <summary>
        /// Custom properties for extensibility
        /// </summary>
        public Dictionary<string, object> Properties => _core.Properties;
```

Custom properties for extensibility

### Variants

```csharp
/// <summary>
        /// Visual variants available for this placeable
        /// </summary>
        public IEnumerable<PlaceableVariant> Variants => _core.Variants;
```

Visual variants available for this placeable

### IsValid

```csharp
/// <summary>
        /// Whether this placeable is currently valid/available
        /// </summary>
        public bool IsValid => _core.IsValid;
```

Whether this placeable is currently valid/available

### PackedScene

```csharp
#endregion

        #region Godot-specific Properties

        /// <summary>
        /// Godot scene to instance when placed
        /// </summary>
        [Export]
        public PackedScene? PackedScene { get; set; }
```

Godot scene to instance when placed

### Icon

```csharp
/// <summary>
        /// Texture icon for UI elements
        /// </summary>
        [Export]
        public Texture2D? Icon { get; set; }
```

Texture icon for UI elements

### PlacementRules

```csharp
/// <summary>
        /// Placement rules specific to this placeable
        /// </summary>
        public Godot.Collections.Array<PlacementRule> PlacementRules { get; set; } = new();
```

Placement rules specific to this placeable

### IgnoreBaseRules

```csharp
/// <summary>
        /// When true, skips base placement rules and uses only specific rules
        /// </summary>
        [Export]
        public bool IgnoreBaseRules { get; set; } = false;
```

When true, skips base placement rules and uses only specific rules


## Methods

### Instantiate

```csharp
#endregion

        #region Godot-specific Methods

        /// <summary>
        /// Instantiates the placeable in the Godot scene tree
        /// </summary>
        /// <param name="parent">Parent node to attach the instance to</param>
        /// <returns>The instantiated node, or null if failed</returns>
        public Node? Instantiate(Node? parent = null)
        {
            if (PackedScene == null)
            {
                GD.PrintErr($"Cannot instantiate placeable '{Id}': No PackedScene assigned");
                return null;
            }

            var instance = PackedScene.Instantiate();
            if (instance == null)
            {
                GD.PrintErr($"Failed to instantiate scene for placeable '{Id}'");
                return null;
            }

            if (parent != null)
            {
                parent.AddChild(instance);
            }

            return instance;
        }
```

Instantiates the placeable in the Godot scene tree

**Returns:** `Node?`

**Parameters:**
- `Node? parent`

### GetEditorIssues

```csharp
/// <summary>
        /// Validates the Godot-specific configuration
        /// </summary>
        /// <returns>Array of validation issues</returns>
        public Godot.Collections.Array<string> GetEditorIssues()
        {
            var issues = new Godot.Collections.Array<string>();

            if (PackedScene == null)
            {
                issues.Add("PackedScene is null but should be set to the scene to instance");
            }

            for (int i = 0; i < PlacementRules.Count; i++)
            {
                if (PlacementRules[i] == null)
                {
                    issues.Add($"Placement rule [{i}] is null");
                }
            }

            return issues;
        }
```

Validates the Godot-specific configuration

**Returns:** `Godot.Collections.Array<string>`

### GetPackedRootName

```csharp
/// <summary>
        /// Gets the root node name from the packed scene
        /// </summary>
        /// <returns>Root node name or error indicator</returns>
        public string GetPackedRootName()
        {
            if (PackedScene != null)
            {
                var bundled = PackedScene.GetBundledScene();
                if (bundled.ContainsKey("names"))
                {
                    var names = bundled["names"].AsGodotArray();
                    if (names.Count > 0)
                    {
                        return names[0].AsString();
                    }
                }
            }

            return "NO_PACKED_SCENE";
        }
```

Gets the root node name from the packed scene

**Returns:** `string`

### _ValidateProperty

```csharp
#endregion

        #region GBResource Overrides

        /// <summary>
        /// Validates the Godot-specific properties
        /// </summary>
        /// <param name="property">Property being validated</param>
        public override void _ValidateProperty(Godot.Collections.Dictionary property)
        {
            if (property.ContainsKey("name"))
            {
                var propertyName = property["name"].AsString();

                if (propertyName == "packed_scene" && PackedScene == null)
                {
                    GD.PrintErr("PackedScene is null but should be set to the scene to instance");
                }
            }
        }
```

Validates the Godot-specific properties

**Returns:** `void`

**Parameters:**
- `Godot.Collections.Dictionary property`

