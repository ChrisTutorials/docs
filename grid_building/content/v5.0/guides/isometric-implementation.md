---
title: Isometric Implementation
description: Implementing Grid Building in isometric games, including coordinate systems, indicator shapes, and rotation handling
---


This guide covers the essential considerations and best practices for implementing the Grid Building plugin in isometric games. It addresses coordinate transformations, visual perspective, indicator shapes, and manipulation behaviors specific to isometric projection.

## Overview

Isometric games present unique challenges when integrating grid-based building systems:

1. **Coordinate Transform**: 2D world coordinates must be mapped to isometric tile coordinates
2. **Visual Perspective**: Sprites and indicators need proper skew/rotation for isometric appearance  
3. **Rotation Behavior**: Manipulation and rotation must handle compound transforms correctly
4. **Collision Shapes**: Indicator shapes must work correctly with parent transformations

This guide addresses each of these areas with practical solutions and recommended patterns.

## Isometric Coordinate System

### Transform Configuration

Isometric games typically use a 30° skew angle to create the diamond perspective. The Grid Building plugin handles this through the `GridTargeter` node configuration:

```gdscript
[node name="GridTargeter" parent="."]
rotation = 0.523599  # 30° in radians (π/6)
scale = Vector2(3, 3)
skew = 0.523599      # 30° skew for isometric perspective
```

**Key points:**
- `rotation = 0.523599` (30°) establishes the isometric angle
- `skew = 0.523599` creates the diamond tile appearance
- `scale = Vector2(3, 3)` adjusts visual size (project-specific)

### Scene Hierarchy

The isometric demo implementation maintains separation between coordinate transformation and game logic:

```text
GridPositioner2D (ShapeCast2D)
├── GridTargeter (visual transform: rotation + skew)
├── ManipulationParent (manipulation transforms)
│   ├── IndicatorManager (indicator container - child of ManipulationParent)
│   │   ├── RuleCheckIndicator (collision shapes)
│   │   └── RuleCheckIndicator
│   └── PreviewObject (object being placed/manipulated)
└── Other components...
```

**Current Implementation:**
- `GridTargeter`: Provides isometric visual transform
- [ManipulationParent](../api/ManipulationParent/): Handles rotation/flip operations
- [IndicatorManager](../api/IndicatorManager/): **Child** of ManipulationParent - inherits rotation transforms
- Indicators: Rotate together with preview object for visual consistency

## TileMapLayer Configuration

### Isometric Tileset Setup

Your `TileMapLayer` should be configured with the appropriate tile size and physics layers:

```gdscript
# Example: 50x50 pixel isometric tiles
tile_set.tile_size = Vector2i(50, 50)

# Physics layers for collision detection
# Layer 0: Ground tiles (for bounds checking)
# Layer 9: Buildings/objects (for collision checking)
```

### Tile Coordinate Conversion

The plugin automatically handles conversion between world coordinates and tile coordinates using the `TileMapLayer` API:

```gdscript
# World position to tile coordinates
var tile_coords: Vector2i = tile_map.local_to_map(world_position)

# Tile coordinates to world position
var world_pos: Vector2 = tile_map.map_to_local(tile_coords)
```

**Important:** The isometric skew is applied at the visual layer (`GridTargeter`), but tile coordinate calculations work in the logical grid space. The plugin's collision mapper and positioning systems handle this transformation automatically.

## Positioning and Targeting

### GridPositioner2D Configuration

The [GridPositioner2D](../api/GridPositioner2D/) manages cursor positioning and input handling. For isometric scenes:

```gdscript
[node name="GridPositioner2D" type="ShapeCast2D"]
z_index = 1000  # Ensure visibility above game objects
shape = ExtResource("isometric_indicator_shape")  # Polygon shape
target_position = Vector2(0, 0)
collision_mask = 2560  # Configure for your collision layers
collide_with_areas = true
```

### Mouse Input Handling

Mouse input automatically accounts for the isometric perspective through the viewport transform. The [GridPositioner2D](../api/GridPositioner2D/) tracks the mouse in world space, and the `TileMapLayer` converts to tile coordinates.

**No special mouse handling required** - the plugin's positioning system handles coordinate conversion automatically.

## Collision Detection

### Physics Layer Configuration

Isometric demos typically use this layer configuration:

- **Layer 0**: Ground tiles (tilemap physics layer)
- **Layer 9**: Buildings and objects

### Collision Mask Setup

```gdscript
# CollisionsCheckRule configuration
collision_mask = 513  # Binary: 1000000001 (layers 0 + 9)

# Breakdown:
# Bit 0 (value 1):   Layer 0 - ground tiles
# Bit 9 (value 512): Layer 9 - buildings
```

**Common pattern:** Include ground layer (0) for bounds checking, buildings layer (9) for collision detection.

### Indicator Collision Shapes

See the "Indicator Shapes: Polygon vs Skewed Rectangles" section below for critical shape configuration guidance.

## Indicator Shapes: Critical Parenting Architecture

### ⚠️ The Real Problem: Parent Transform Inheritance

When working with isometric games, **rotation of preview objects may cause indicators to rotate as well**. This behavior depends on **where indicators are parented in the scene hierarchy**.

**Current Isometric Demo Implementation:**

In the included isometric demo, [IndicatorManager](../api/IndicatorManager/) is a **child** of [ManipulationParent](../api/ManipulationParent/):

```text
GridPositioner2D
└── ManipulationParent (rotates 90°)
    ├── IndicatorManager (inherits rotation from parent)
    │   └── RuleCheckIndicators (rotate with preview)
    └── PreviewObject (rotates 90°)
```

**Result:** Indicators rotate together with the preview object, maintaining visual consistency during manipulation.

**Alternative: Fixed Indicators (Sibling Parenting)**

If you want indicators to remain fixed while the preview rotates, make [IndicatorManager](../api/IndicatorManager/) a **sibling** of [ManipulationParent](../api/ManipulationParent/):

```text
GridPositioner2D
├── IndicatorManager (no rotation inheritance)
│   └── RuleCheckIndicators (maintain fixed orientation)
└── ManipulationParent (rotates 90°)
    └── PreviewObject (rotates 90°)
```

**Result:** Indicators maintain their diamond orientation regardless of preview object rotation.

### ✅ Choosing the Right Hierarchy

**Option 1: Child Parenting (Current Demo Implementation)**

Make [IndicatorManager](../api/IndicatorManager/) a child of [ManipulationParent](../api/ManipulationParent/):

```gdscript
[node name="GridPositioner2D" type="ShapeCast2D"]
# ... GridPositioner2D configuration ...

[node name="ManipulationParent" type="Node2D" parent="."]
script = ExtResource("manipulation_parent_script")

[node name="IndicatorManager" type="Node2D" parent="ManipulationParent"]
# Child of ManipulationParent - will rotate with preview
script = ExtResource("indicator_manager_script")
```

**When to use:**
- You want indicators to rotate with the building preview
- Visual consistency is more important than fixed orientation
- Your indicator shapes maintain readability when rotated

**Option 2: Sibling Parenting (Alternative)**

Make [IndicatorManager](../api/IndicatorManager/) a sibling of [ManipulationParent](../api/ManipulationParent/):

```gdscript
[node name="GridPositioner2D" type="ShapeCast2D"]
# ... GridPositioner2D configuration ...

[node name="IndicatorManager" type="Node2D" parent="."]
# Sibling of ManipulationParent - won't inherit rotation
script = ExtResource("indicator_manager_script")

[node name="ManipulationParent" type="Node2D" parent="."]
# Sibling of IndicatorManager - rotates independently
script = ExtResource("manipulation_parent_script")
```

**When to use:**
- You want indicators to stay fixed while preview rotates
- Diamond shapes should maintain consistent orientation
- Visual "flipping" of indicators is undesirable

**Why this works:**

- **Child parenting**: [IndicatorManager](../api/IndicatorManager/) inherits all transforms from [ManipulationParent](../api/ManipulationParent/), so indicators rotate with the preview
- **Sibling parenting**: [IndicatorManager](../api/IndicatorManager/) is directly parented to [GridPositioner2D](../api/GridPositioner2D/), so when [ManipulationParent](../api/ManipulationParent/) rotates, [IndicatorManager](../api/IndicatorManager/) remains unaffected

### Shape Choice: Polygon Recommended (But Not Required)

While the parenting fix solves the rotation issue, using `ConvexPolygonShape2D` is still **recommended** for clarity:

```gdscript
# ✅ RECOMMENDED: Explicit diamond points
[gd_resource type="ConvexPolygonShape2D"]
[resource]
points = PackedVector2Array(0, -24, 42, 0, 0, 24, -42, 0)
```

**Benefits of polygon shapes:**
- Explicit geometry (clear what the collision shape looks like)
- No transform ambiguity (shape is defined in absolute coordinates)
- Easier to customize for different tile sizes

**You can still use rectangles if properly parented:**
```gdscript
# ✅ ALSO WORKS: Rectangle with correct parenting
[gd_resource type="RectangleShape2D"]
[resource]
size = Vector2(50, 50)
```

The key is the **parenting hierarchy**, not the shape type.

```gdscript
# ✅ CORRECT: ConvexPolygonShape2D with explicit diamond points
[gd_resource type="ConvexPolygonShape2D" format=3]

[resource]
resource_name = "Isometric Tile Indicator Shape"
points = PackedVector2Array(0, -24, 42, 0, 0, 24, -42, 0)
```

**Why this works:**

- The polygon shape is defined in absolute coordinates
- No skew transformation needed on the shape itself
- Rotation affects the entire shape uniformly
- The diamond shape is preserved during all manipulations

## Template Configuration

### Isometric Indicator Shape Resource

Grid Building provides pre-configured polygon shapes for isometric tiles:

**File:** `res://templates/grid_building_templates/indicator/indicator_isometric_shape_50px.tres`

```gdscript
[gd_resource type="ConvexPolygonShape2D" format=3 uid="uid://doksii8b4abd"]

[resource]
resource_name = "Indicator Shape for 50px Tile Isometric"
# Diamond shape for isometric tile (50px × 50px projected)
points = PackedVector2Array(0, -24, 42, 0, 0, 24, -42, 0)
```

### Isometric Indicator Scene Template

**File:** `res://templates/grid_building_templates/indicator/rule_check_indicator_isometric.tscn`

```gdscript
[node name="RuleCheckIndicatorIsometric" type="ShapeCast2D"]
top_level = true
shape = ExtResource("indicator_isometric_shape.tres")  # Polygon shape
target_position = Vector2(0, 0)
collision_mask = 0
script = "res://addons/grid_building/placement/rule_check_indicator/rule_check_indicator.gd"

[node name="Sprite2D" type="Sprite2D" parent="."]
rotation = 0.523599  # Visual rotation for isometric appearance
scale = Vector2(3, 3)
skew = 0.523599      # Visual skew for sprite only (not shape)
```

**Key points:**
- The `ShapeCast2D.shape` uses the polygon resource (no skew)
- The `Sprite2D` child can still use skew for visual appearance
- Visual sprite transformations don't affect collision shape behavior

## Creating Custom Isometric Shapes

If you need a custom tile size, calculate the polygon points based on your tile dimensions:

```gdscript
# For a tile with size W × H in isometric projection
# Diamond points (top, right, bottom, left):
var half_width = W / 2.0
var half_height = H / 2.0

points = PackedVector2Array(
    Vector2(0, -half_height),        # Top
    Vector2(half_width, 0),          # Right
    Vector2(0, half_height),         # Bottom
    Vector2(-half_width, 0)          # Left
)
```

**Example for 64×64 tile:**

```gdscript
[gd_resource type="ConvexPolygonShape2D" format=3]

[resource]
resource_name = "Isometric Tile Indicator 64px"
# For 64px isometric tile
points = PackedVector2Array(0, -32, 54, 0, 0, 32, -54, 0)
```

## Integration with ManipulationParent

The polygon shape approach works seamlessly with the manipulation system:

### Grid-Aware Rotation Behavior (v5.0.0)

Grid Building 5.0.0 includes enhanced grid-aware rotation utilities ([GBGridRotationUtils](../api/GBGridRotationUtils/)) that maintain proper grid alignment during rotation:

```gdscript
# Grid-aware rotation with configurable increments
GBGridRotationUtils.rotate_node_clockwise(node, tile_map, 90.0)  # 4-direction (RTS-style)
GBGridRotationUtils.rotate_node_clockwise(node, tile_map, 45.0)  # 8-direction (isometric with diagonals)
GBGridRotationUtils.rotate_node_clockwise(node, tile_map, 60.0)  # 6-direction (hex-style)

# Traditional rotation (for comparison)
manipulation_parent.apply_rotation(90.0)

# Grid-aware rotation benefits:
# ✅ Maintains proper grid tile alignment
# ✅ Supports configurable rotation increments (4, 6, 8, 12 directions)
# ✅ Automatic snap-to-grid positioning
# ✅ Cardinal direction support for backward compatibility
```

**Key advantages of grid-aware rotation:**
- Objects stay properly aligned to grid tiles after rotation
- Configurable rotation increments support different game styles
- Integration with GridPositioner2D and tile map systems
- Consistent behavior across square, isometric, and hex grids

### Shape Behavior During Rotation

```gdscript
# With grid-aware rotation:
# ✅ Polygon shape: Rotates uniformly, diamond stays diamond, stays on grid
# ❌ Skewed rectangle: Changes perspective, looks distorted, may drift off grid
```

### Scene Hierarchy

```text
GridPositioner2D
├── GridTargeter (skew = 0.523599 for visual isometric effect)
└── ManipulationParent
    ├── IndicatorManager
    │   ├── RuleCheckIndicator (polygon shape - no skew!)
    │   │   └── Sprite2D (skew for visual only)
    │   └── RuleCheckIndicator
    └── PreviewObject
```

**Critical architecture:**
- `GridTargeter` has skew for the visual coordinate system
- [RuleCheckIndicator](../api/RuleCheckIndicator/) shape is a polygon (not affected by parent skew)
- `Sprite2D` child can use skew for visual appearance without affecting collision

## Best Practices

### ✅ DO:
- Use `ConvexPolygonShape2D` for indicator shapes in isometric scenes
- Define explicit polygon points matching your tile dimensions
- Keep shape definitions transform-free (no rotation/skew in the shape resource)
- Apply visual transformations to sprites, not collision shapes

### ❌ DON'T:
- Use `RectangleShape2D` with skew transformation for isometric indicators
- Rely on parent node skew for shape definition
- Apply rotation or skew to the shape resource itself
- Mix collision shape transformations with visual transformations

## Troubleshooting

### Indicators look distorted when rotating buildings

**Problem:** Diamond indicators appear to "flip" or change perspective during rotation.

**Cause:** Using `RectangleShape2D` with skew instead of polygon shape.

**Solution:**
1. Replace `RectangleShape2D` with `ConvexPolygonShape2D`
2. Define explicit polygon points for diamond shape
3. Remove skew from shape, keep only on visual sprites

### Indicators don't align with tiles

**Problem:** Polygon indicators don't match tile positions.

**Cause:** Incorrect polygon points or wrong tile size calculation.

**Solution:**
1. Measure your actual tile dimensions
2. Calculate proper diamond points (see "Creating Custom Isometric Shapes" above)
3. Test with a single tile first before generating full indicator sets

### Performance concerns with polygon shapes

**Answer:** Polygon shapes with 4 points (diamond) have virtually identical performance to rectangles. The physics engine handles simple convex polygons very efficiently.

## Building and Manipulation in Isometric Games

### ⚠️ Rotation Best Practices: Sprite Sequences, Not Transform Rotation

**For authentic isometric games, DO NOT use node rotation transforms on sprites.** Instead, implement directional sprite sequences and swap sprites based on facing direction.

#### Why Sprite Sequences?

Classic isometric games (Diablo, Baldur's Gate, Tactics Ogre, Final Fantasy Tactics) use **pre-rendered sprites from multiple angles** rather than rotating a single sprite:

**✅ RECOMMENDED: Directional Sprite Sequences**
- Create separate sprite images for each cardinal direction (North, East, South, West)
- Optionally add diagonal directions for 8-directional movement (NE, SE, SW, NW)
- Swap sprites based on object's facing direction
- Use horizontal flip for symmetrical objects (e.g., East sprite flipped = West sprite)

**❌ AVOID: Node Rotation Transforms**
- Do NOT use `rotation` property on isometric sprites
- Do NOT use [ManipulationParent](../api/ManipulationParent/) rotation for visual orientation changes
- Transform rotation distorts the isometric perspective and looks incorrect

#### Implementation Approach: Directional Sprite Systems

**This is game-specific functionality outside the plugin's scope.** The Grid Building plugin handles placement validation and collision detection, not visual representation of buildings.

**Your Implementation Responsibilities:**
- Create directional sprite controller systems for your buildings
- Store and manage sprite assets for each direction (N, E, S, W, and optionally diagonals)
- Implement sprite swapping logic based on building orientation
- Use horizontal flip optimization for symmetrical directions (East ↔ West)
- Handle sprite changes during building manipulation/rotation

**Architectural Pattern:**
- Attach sprite controller scripts to your building scene's root node
- Expose direction enum and sprite texture properties
- Implement `set_direction()` method that updates visual representation
- Connect direction changes to custom manipulation actions (see [Extending the Plugin](./extending-plugin) guide)

#### Rotation Modes for Isometric Buildings

**Mode 1: Static Buildings (Recommended)**
- Buildings face a fixed direction (typically South or Southeast)
- No rotation during placement or manipulation
- Disable rotation: `manipulation_settings.allow_rotation = false`
- Simplest approach - all buildings use the same directional sprites

**Mode 2: Directional Buildings (Advanced, Game-Specific)**
- Buildings have 4 directional sprite variants (N, E, S, W)
- **You implement** custom manipulation actions that swap sprites instead of rotating nodes
- **You update** collision shapes to match new orientation
- Plugin's rotation system provides cardinal directions for your sprite controller
- Disable visual rotation: `manipulation_settings.allow_rotation = false`
- Implement custom rotation handlers that update your sprite controller systems

**Important:** Sprite swapping and directional visual systems are **game-specific features** outside the plugin's scope. See [Extending the Plugin](./extending-plugin) guide for architectural patterns.

#### Grid-Aware Rotation (Built-In)

The plugin's rotation system automatically handles **logical rotation** for collision detection and tile coverage with **configurable direction increments**:

**Configurable Multi-Directional Support:**
- **4-direction (default)**: 90° increments (NORTH, EAST, SOUTH, WEST) - RTS-style rotation
- **8-direction**: 45° increments (includes diagonals: NE, SE, SW, NW) - isometric games with diagonal movement
- **6-direction**: 60° increments (hex-style) - hexagonal grid systems
- **12-direction**: 30° increments - fine-grained rotation control
- **Custom**: Any increment angle (e.g., 22.5° for 16-direction systems)

**Configuration:**
```gdscript
# ManipulationSettings resource
@export_range(0, 360, 0.1) var rotate_increment_degrees: float = 90.0

# 4-direction (default): 90°
manipulation_settings.rotate_increment_degrees = 90.0

# 8-direction (isometric with diagonals): 45°
manipulation_settings.rotate_increment_degrees = 45.0

# 6-direction (hex-style): 60°
manipulation_settings.rotate_increment_degrees = 60.0

# 12-direction: 30°
manipulation_settings.rotate_increment_degrees = 30.0
```

**Core Rotation Features:**
- Accounts for complex parent transforms (rotation, skew) using transform matrix calculations
- Automatically snaps rotated objects to grid tile centers after rotation
- Returns rotation angle in degrees (0-360 range) for game logic integration
- Works correctly with any increment value - transform math is angle-agnostic

**Use Cases by Direction Count:**
- **4-direction (90°)**: Top-down/platformer games, simple RTS-style building
- **8-direction (45°)**: Isometric games with diagonal movement, enhanced building placement variety
- **6-direction (60°)**: Hexagonal grid games requiring rotation alignment
- **12-direction (30°)**: Advanced placement systems with fine rotation control

**Plugin Responsibility:** Collision and placement validation logic with configurable grid-aligned rotation
**Your Responsibility:** Visual representation updates (sprite swapping, model rotation, etc.)

**Note:** This grid-aware rotation is always active when using the plugin's rotation features. It ensures correct behavior in isometric games with skewed parent transforms, regardless of the increment angle used.

### Horizontal Flip Optimization

For symmetrical buildings, horizontal flip can reduce sprite asset requirements:

- East-facing sprite + flip_h = West-facing appearance
- Reduces memory footprint by 50% for symmetrical buildings
- Only works for visually symmetrical structures

**Note:** North and South facing directions typically require unique sprites for proper isometric perspective.

**Implementation:** This optimization is game-specific. You implement sprite controllers that manage flip states based on building direction.

### Building Preview Consistency

**Plugin Behavior:** The [IndicatorManager](../api/IndicatorManager/) should be a **sibling** of [ManipulationParent](../api/ManipulationParent/), not a child. This prevents indicators from inheriting unwanted transform rotations.

**Scene Hierarchy (Plugin-Managed):**
```text
GridPositioner2D
├── IndicatorManager (sibling - no rotation inheritance)
│   ├── RuleCheckIndicator (maintains diamond orientation)
│   └── RuleCheckIndicator
└── ManipulationParent (handles collision/logic transforms)
    └── PreviewObject (your building with collision shapes)
```

**Your Visual Implementation:**
- Attach sprite controllers to `PreviewObject` for directional visuals
- Sprite appearance changes without rotating the node hierarchy
- Collision shapes rotate logically without affecting visual sprites
- Indicators stay correctly oriented regardless of preview direction

## Demo Scene Configuration

### Isometric Demo Structure

Reference the included isometric demo for a complete working example:

**Scene:** `res://demos/isometric/demo_isometric_2d.tscn`

Key configuration files:
- **Composition Container**: `res://demos/isometric/settings/isometric_demo_composition_container.tres`
- **Grid Positioner**: `res://templates/grid_building_templates/grid_positioner/grid_positioner_stack_isometric.tscn`
- **Indicator Shape**: `res://templates/grid_building_templates/indicator/indicator_isometric_shape_50px.tres`
- **Collision Rule**: `res://demos/isometric/rules/isometric_collisions_check.tres`

### Placeable Objects

Isometric buildings typically include:

```text
buildings/
├── blacksmith_blue_polygon.tscn    # Building with collision shape
├── house_wooden_red.tscn           # Building with collision shape
└── mill_big_green.tscn             # Building with collision shape

placeable resources:
├── placeable_blacksmith_blue.tres  # Placeable configuration
├── placeable_house_red.tres        # Placeable configuration  
└── placeable_mill_green.tres       # Placeable configuration
```

Each building scene includes:
- Visual sprites with isometric perspective (rotation + skew)
- Collision shapes (typically `ConvexPolygonShape2D` or `ConcavePolygonShape2D`)
- Proper parent/child hierarchy for manipulation

## Performance Considerations

### Indicator Generation

For large buildings with many tiles:

```gdscript
# Isometric buildings may cover more tiles due to perspective
# Example: 64x64 pixel building = ~12-16 tile positions

var performance_settings = container.get_performance_settings()
performance_settings.max_indicators = 100  # Adjust based on needs
```

### Collision Detection

Isometric collision detection is handled by Godot's 2D physics engine:

- **ShapeCast2D**: Used by indicators for efficient tile checking
- **Polygon shapes**: Negligible performance difference vs rectangles
- **Layer masking**: Reduces unnecessary collision checks

**Best practice:** Use collision masks to filter out irrelevant layers (e.g., don't check player collision layer for building placement).

## Related Documentation

- [ManipulationSystem](./manipulation_system.mdx) - Object rotation and manipulation
- [PlacementRules](./placement_rules.mdx) - Rule validation system
- [Grid Targeting](./grid_targeting.mdx) - Targeting and positioning system
- [Collision Mapping](./collision_mapping.mdx) - Collision detection and tile mapping
- [RuleCheckIndicator API](../api/RuleCheckIndicator/) - Indicator implementation details
- [Project Architecture](./project_architecture.mdx) - Scene hierarchy and component relationships

## Quick Start Checklist

Setting up Grid Building for isometric games:

- [ ] Configure `GridTargeter` with `rotation = 0.523599` and `skew = 0.523599`
- [ ] Use `ConvexPolygonShape2D` for indicator shapes (not skewed rectangles)
- [ ] Set up `TileMapLayer` with appropriate tile size (e.g., 50x50)
- [ ] Configure collision layers (typically layer 0 for ground, layer 9 for buildings)
- [ ] Set `collision_mask = 513` for [CollisionsCheckRule](../api/CollisionsCheckRule/) (layers 0 + 9)
- [ ] Parent indicators to [ManipulationParent](../api/ManipulationParent/) for coordinated transforms
- [ ] Configure visual sprites with rotation + skew for isometric perspective
- [ ] Test collision detection with various building sizes

**Visual Representation (Your Implementation):**
- [ ] **Static buildings:** Create single-direction sprites (typically South/Southeast facing)
- [ ] **Directional buildings (advanced):** Implement sprite controller systems for 4+ directions
- [ ] **Disable plugin rotation** if using sprite sequences: `manipulation_settings.allow_rotation = false`
- [ ] See [Extending the Plugin](./extending-plugin) guide for implementing custom visual systems

## Summary

Successfully implementing Grid Building in isometric games requires attention to:

### Core Configuration
1. **Coordinate System**: Use `GridTargeter` with 30° rotation + skew for isometric perspective
2. **Indicator Shapes**: Always use `ConvexPolygonShape2D` with explicit diamond points
3. **Transform Separation**: Keep collision shapes (no skew) separate from visual sprites (with skew)
4. **Scene Hierarchy**: Make [IndicatorManager](../api/IndicatorManager/) a sibling of [ManipulationParent](../api/ManipulationParent/) to prevent unwanted rotation inheritance

### Visual Representation (Game-Specific)
The plugin provides **placement logic and collision detection**. Visual implementation is your responsibility:

- **Static approach:** Buildings use single-direction sprites (South/Southeast facing typical)
- **Directional approach:** You implement sprite controller systems that swap textures based on orientation
- **Best practice:** Avoid node rotation on isometric sprites - use sprite sequences instead
- **Reference:** See [Extending the Plugin](./extending-plugin) for architectural patterns

### Key Plugin Integration Points
- **Plugin handles:** Tile coordinate conversion, collision detection, placement validation, indicator management
- **You handle:** Visual representation, sprite management, directional artwork, custom manipulation actions
- **Architecture:** Composition over extension - wrap plugin systems with your visual implementations

### Best Practices
- Reference the included isometric demo for working examples
- Use collision layer masking to optimize performance
- Keep visual and collision transforms separate for maintainability
- Test with simplified sprites first before adding directional complexity

This approach ensures your isometric building system maintains correct visual appearance, reliable collision detection, and authentic isometric aesthetics throughout all gameplay scenarios.