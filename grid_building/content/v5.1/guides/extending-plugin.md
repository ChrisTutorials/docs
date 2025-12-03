---
title: Extending the Plugin
description: Guide for implementing game-specific features that build upon the Grid Building plugin's foundation without modifying the core plugin.
---


---

The Grid Building plugin provides **foundational building mechanics** - placement, validation, collision detection, and visual feedback. This guide explains how to extend the plugin with game-specific features while maintaining clear boundaries between core plugin functionality and custom game logic.

## Plugin Scope vs Game-Specific Features

### ✅ What the Plugin Provides (Core Features)

**Core Building Mechanics:**
- Grid-based placement system
- Collision detection and validation
- Visual indicators (valid/invalid placement)
- Rule-based placement validation
- Mouse and keyboard input handling
- Scene tree management for building objects

**Architecture Components:**
- [BuildingSystem](../api/BuildingSystem/) - Core placement logic
- [GridPositioner2D](../api/GridPositioner2D/) - Input handling and positioning
- [PlacementValidator](../api/PlacementValidator/) - Rule validation system
- [CollisionMapper](../api/CollisionMapper/) - Collision detection
- [IndicatorManager](../api/IndicatorManager/) - Visual feedback
- [ManipulationSystem](../api/ManipulationSystem/) - Object selection and manipulation

**UI Templates (Advanced):**
- [PlaceableSelectionUI](../api/PlaceableSelectionUI/) - Unified selection interface supporting both individual placeables and sequences
- [PlaceableSequence](../api/PlaceableSequence/) - Groups building variants for selection (Basic Tower → Heavy Tower → Rapid Tower)
- [PlaceableList](../api/PlaceableList/) - Manages collections of placeables with variant cycling support

### ❌ What the Plugin Does NOT Provide (Game-Specific)

**Visual Representation & Rendering:**
- Sprite management and directional artwork
- 3D model rotation and orientation
- Animation systems (idle, building, destruction)
- Visual effects (particles, lighting, shaders)
- Sprite swapping for directional buildings (e.g., isometric 4/8-directional sprites)

**Economy & Progression:**
- Resource management and costs
- Building upgrade systems
- Tech trees and unlock progression
- Economy balancing (gold, wood, stone costs)

**Game Systems:**
- Combat stats and damage systems
- Unit production queues
- Defensive bonuses and area effects
- Building health and destruction

**Persistence & State:**
- Save/load system for game progress
- Cloud saves and data persistence
- Achievement tracking
- Statistics and analytics

**UI Styling & Custom Layouts:**
- Custom themed UI components
- Radial menus or non-grid selection
- HUD integration and minimap systems
- Game-specific input handling (RTS controls, mobile touch patterns)

**Why?**
- **Scope Management**: Keeps plugin focused and maintainable
- **Game Flexibility**: Each game needs different implementations
- **Performance**: Games optimize differently based on their needs
- **Design Freedom**: Doesn't impose visual or gameplay constraints

## 🏧 Architectural Boundaries

### Core Plugin Scope

The Grid Building plugin provides **foundational systems and UI templates** for building placement:

**Always in Core:**
- Grid positioning and movement
- Collision detection and validation
- Placement rules and constraints
- Basic visual feedback (indicators)
- Scene management and object manipulation

**UI Templates (Use or Customize):**
- Unified selection interface ([PlaceableSelectionUI](../api/PlaceableSelectionUI/)) - handles both individual placeables and sequences
- Building variant grouping ([PlaceableSequence](../api/PlaceableSequence/)) - organize related building variants
- Collection management ([PlaceableList](../api/PlaceableList/)) - manage available placeables with cycling support

**Game-Specific Extensions (Always Custom):**
- Building upgrade systems and progression trees
- Resource costs and economy mechanics
- Combat stats and game balance
- Save/load systems for game progress
- Themed UI styling and custom layouts

### Template vs Custom Decision

**Use Plugin Templates When:**
- Standard building selection patterns fit your game
- You want rapid prototyping with working UI
- Your design aligns with template assumptions
- You need keyboard/controller navigation

**Build Custom Implementation When:**
- Your UI patterns differ significantly from templates
- You need integration with complex game systems
- Performance requirements demand specialized solutions
- Your artistic vision requires completely custom styling

## 🏷️ Placement Persistence with Metadata

The plugin uses **metadata keys** to track object state and enable save/load systems. Two metadata flags are automatically managed by the plugin:

### Metadata Keys

**`gb_preview`** - Marks temporary objects (previews, manipulation copies)
- Automatically set during build mode and manipulation
- Use to exclude temporary objects from saves and gameplay systems

**`gb_placement`** - Marks permanently placed objects with source reference
- Automatically set when objects are placed via BuildingSystem
- Stores the Placeable resource path for save/load operations

### Quick Reference

```gdscript
# Check if object is a temporary preview
if node.has_meta("gb_preview"):
    # Skip - temporary object, don't save or target

# Check if object is a placed building
if node.has_meta("gb_placement"):
    # This is a permanent placed object - include in saves
    var placeable_path = node.get_meta("gb_placement")["placeable_path"]
```

### Save/Load Implementation

The plugin provides [GBPlacementPersistence](../api/GBPlacementPersistence/) utility for save/load operations:

```gdscript
func save_level() -> Dictionary:
    # Get all placed objects (automatically excludes gb_preview objects)
    var placements = GBPlacementPersistence.save_all_placements(objects_parent)
    return {"placements": placements}

func load_level(save_data: Dictionary) -> void:
    # Clear existing placed objects
    var placed = GBPlacementPersistence.get_placed_objects(objects_parent)
    for node in placed:
        node.queue_free()
    await get_tree().process_frame
    
    # Load placements from save data
    GBPlacementPersistence.load_all_placements(save_data["placements"], objects_parent)
```

### Gameplay Systems Integration

Filter objects by metadata for AI, pathfinding, and game logic:

```gdscript
func find_enemy_targets() -> Array[Node]:
    var targets: Array[Node] = []
    for building in get_tree().get_nodes_in_group("Building"):
        # Skip previews, only target placed buildings
        if building.has_meta("gb_preview"):
            continue
        targets.append(building)
    return targets
```

### Key Points

- ✅ **Automatic Management**: Plugin handles metadata lifecycle
- ✅ **No Manual Tracking**: Just check metadata presence when filtering
- ✅ **Built-in Save/Load**: Use [GBPlacementPersistence](../api/GBPlacementPersistence/) for basic persistence
- ⚠️ **Custom Systems**: Extend for resource costs, unlocks, and game-specific data

For comprehensive save/load guidance, see the [Placement Persistence Guide](/v5-1/guides/placement-persistence/).

## UI Templates vs Game-Specific Implementation

### 🎨 What UI Templates Provide

The plugin includes **advanced UI templates** for common building game patterns:

**Unified Selection System:**
- [PlaceableSelectionUI](../api/PlaceableSelectionUI/) - Grid-based selection interface that automatically handles both individual placeables and sequences
- [PlaceableSequence](../api/PlaceableSequence/) - Groups multiple building variants (Basic Tower → Heavy Tower → Rapid Tower)
- [PlaceableList](../api/PlaceableList/) - Collection management with variant cycling through sequences

**When to Use Templates:**
- Your game has building variants that players select before placement
- You prefer list-based UI over grid-based selection
- You need keyboard navigation and variant cycling
- You want to group related buildings together

**When to Build Custom:**
- Your game uses fundamentally different UI patterns (radial menus, drag-drop, etc.)
- You need variant selection during placement rather than before
- Your upgrade system works differently than variant selection
- You prefer complete control over UI styling and behavior

### 🔄 Template vs Custom Decision Matrix

| Feature | Use Template | Build Custom |
|---------|-------------|---------------|
| Grid-based selection (individual or sequences) | ✅ | ❌ |
| Building variants with left/right cycling | ✅ | ❌ |
| Automatic handling of placeables vs sequences | ✅ | ❌ |
| Radial menus or drag-drop interfaces | ❌ | ✅ |
| In-placement variant switching | ❌ | ✅ |
| Heavily themed/styled UI | ❌ | ✅ |
| Complex upgrade trees | ❌ | ✅ |

## Implementation Guidelines

### 🎯 Core Principle: Composition Over Extension

**✅ Recommended Approach:**
Create wrapper classes that compose with plugin systems rather than extending them. Build game-specific managers that delegate core functionality to plugin components while adding custom validation, resource checks, and game logic on top.

**Pattern**: Composition wrapper that:
- Maintains references to plugin systems
- Implements game-specific state (quantities, unlocks, resources)
- Validates game conditions before delegating to plugin
- Adds custom checks and business logic around plugin calls

**❌ Avoid Direct Plugin Modification:**
```gdscript
# Don't modify plugin classes directly
class_name CustomBuildingSystem extends BuildingSystem:
    # This creates maintenance burden and update conflicts
```

## Game-Specific Feature Implementation

### 1. Building Variants

**Use Case**: Tower types with multiple functional variants (Basic → Heavy → Rapid-Fire)

**Solution Options:**
- **Plugin Template**: Use [PlaceableSequence](../api/PlaceableSequence/) + [PlaceableSelectionUI](../api/PlaceableSelectionUI/) for ready-made variant selection
- **Custom**: Build variant manager that cycles through options and updates Placeable resources dynamically

**Key Integration**: Modify [Placeable](../api/Placeable/) resources at runtime, use existing placement validation

### 2. Quantity Limits

**Use Case**: Restrict building counts (max 3 towers, 5 farms)

**Solution**: Create quota manager that tracks counts and validates before placement

**Implementation**:
```gdscript
class_name BuildingQuota:
    var limits := {"tower": 3, "farm": 5}
    var counts := {"tower": 0, "farm": 0}
    
    func can_place(type: String) -> bool:
        return counts.get(type, 0) < limits.get(type, 999)
    
    func on_placed(type: String) -> void:
        counts[type] = counts.get(type, 0) + 1
```

**Key Integration**: Check quotas before calling BuildingSystem placement methods

### 3. Building Upgrades

**Use Case**: Upgrade buildings to more powerful versions (Small Barracks → Large Barracks)

**Solution**: Use [ManipulationSystem](../api/ManipulationSystem/) to remove + [BuildingSystem](../api/BuildingSystem/) to place upgraded version

**Implementation Pattern**:
```gdscript
func upgrade_building(building: Node, upgrade_path: String) -> bool:
    var old_pos = building.global_position
    
    # Remove old building
    manipulation_system.select_object(building)
    manipulation_system.delete_selected()
    
    # Place upgraded version
    var upgraded_placeable = load(upgrade_path) as Placeable
    building_system.enter_build_mode(upgraded_placeable)
    return building_system.try_place_at(old_pos)
```

### 4. Unlockable Recipes

**Use Case**: Dynamic building availability based on progression (unlock after wave 10)

**Solution**: Filter available buildings before passing to plugin systems

**Implementation**:
```gdscript
class_name UnlockManager:
    var unlocked_buildings: Array[String] = ["basic_tower"]
    
    func get_available_placeables() -> Array[Placeable]:
        var available: Array[Placeable] = []
        for path in unlocked_buildings:
            available.append(load(path))
        return available
    
    func unlock(building_path: String) -> void:
        if building_path not in unlocked_buildings:
            unlocked_buildings.append(building_path)
```

**Key Integration**: Pass filtered list to BuildingSystem or PlaceableSelectionUI

## Custom Integration Patterns

**Resource Management**: Wrap BuildingSystem with cost validation and resource deduction
```gdscript
func try_place_with_cost(placeable: Placeable, cost: int) -> bool:
    if resources < cost:
        return false
    if building_system.try_place_current():
        resources -= cost
        return true
    return false
```

**Custom Validation Rules**: Extend PlacementRule base class for game-specific checks
```gdscript
class_name ResourceProximityRule extends PlacementRule:
    func validate(context: RuleValidationContext) -> RuleValidationResult:
        var nearby_resources = find_resources_near(context.position)
        return RuleValidationResult.new(nearby_resources.size() > 0, ["Needs nearby resources"])
```

**Event Integration**: Connect to plugin signals for placement events
```gdscript
func _ready():
    building_system.placed.connect(_on_building_placed)
    manipulation_system.object_selected.connect(_on_object_selected)
```

## Best Practices

✅ **Compose, Don't Modify**: Build wrapper classes around plugin systems, never modify plugin source  
✅ **Use Extension Points**: Connect to signals, extend PlacementRule, wrap systems with game logic  
✅ **Separate Concerns**: Keep game-specific code (resources, upgrades, economy) separate from core mechanics  
✅ **Check Metadata**: Always filter `gb_preview` objects from saves and gameplay systems  
✅ **Maintain Upgrade Path**: Avoid changes that prevent plugin updates

## Conclusion

The Grid Building plugin provides core building mechanics with metadata-based persistence. Extend it using:
- **Composition patterns** for game-specific features
- **Metadata keys** for save/load and object filtering
- **Plugin signals** for event-driven integration
- **Custom rules** for game-specific validation

For detailed save/load implementation, see [Placement Persistence Guide](/v5-1/guides/placement-persistence/).