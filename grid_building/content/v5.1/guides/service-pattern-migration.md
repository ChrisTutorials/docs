---
title: "Service Pattern Migration Guide"
description: "How to upgrade your GridBuilding projects to use the new service architecture"
weight: 20
---

## Overview

This guide helps you migrate your existing GridBuilding projects to use the new service architecture. The new system provides better performance, cleaner code, and easier maintenance.

## What's Changing

### Before (Old Architecture)
- BuildingSystem handled everything in one large class
- Mixed Godot and C# code
- Difficult to test and maintain
- Performance issues with complex GDScript logic

### After (New Architecture)
- Separate services for each responsibility
- Pure C# core with thin Godot wrappers
- Easy to test and extend
- Optimized performance with C# business logic

## Migration Steps

### Step 1: Update Your Scene Setup

#### Old Way
```gdscript
# Old: Single building system
extends Node

@onready var building_system = $BuildingSystem

func _ready():
    building_system.connect("building_placed", _on_building_placed)
```

#### New Way
```gdscript
# New: Separate service systems
extends Node

@onready var placement_system = $PlacementSystem
@onready var manipulation_system = $ManipulationSystem
@onready var grid_targeting_system = $GridTargetingSystem

func _ready():
    placement_system.building_placed.connect(_on_building_placed)
    manipulation_system.building_removed.connect(_on_building_removed)
    grid_targeting_system.target_changed.connect(_on_target_changed)
```

### Step 2: Update Building Placement

#### Old Code
```gdscript
# Old: Direct building system calls
func place_building(building_type, position):
    var result = building_system.place_building(building_type, position, "player")
    
    if result.success:
        print("Building placed at ", position)
    else:
        print("Placement failed: ", result.error)
```

#### New Code
```gdscript
# New: Use placement service
func place_building(building_type, position):
    var result = placement_system.place_building(building_type, position, "player")
    
    if result.success:
        print("Building placed at ", position)
        # Building automatically added to scene tree
    else:
        print("Placement failed: ", result.error)
```

### Step 3: Update Building Removal

#### Old Code
```gdscript
# Old: Building system handled removal
func remove_building(building_node):
    var result = building_system.remove_building(building_node)
    
    if result.success:
        print("Building removed")
    else:
        print("Removal failed: ", result.error)
```

#### New Code
```gdscript
# New: Use manipulation service
func remove_building(building_node):
    var result = manipulation_system.remove_building(building_node)
    
    if result.success:
        print("Building removed")
        # Building automatically removed from scene tree
    else:
        print("Removal failed: ", result.error)
```

### Step 4: Update Grid Targeting

#### Old Code
```gdscript
# Old: Manual grid calculations
func get_grid_position(world_position):
    var tile_map = $TileMap
    return tile_map.local_to_map(world_position)

func is_valid_grid_position(grid_pos):
    return grid_pos.x >= 0 and grid_pos.y >= 0
```

#### New Code
```gdscript
# New: Use targeting system
func get_grid_position(world_position):
    return grid_targeting_system.get_grid_position(world_position)

func is_valid_grid_position(grid_pos):
    return grid_targeting_system.is_valid_position(grid_pos)
```

## Specific Migration Examples

### Building Manager Migration

#### Old BuildingManager
```gdscript
# Old: Complex building manager
extends Node

class_name BuildingManager

var buildings = {}
var building_types = {}

func _ready():
    load_building_types()
    setup_grid()

func place_building(type, position):
    # Complex validation logic
    if not validate_placement(type, position):
        return false
    
    # Manual scene instantiation
    var scene = load(building_types[type].scene_path)
    var building = scene.instantiate()
    building.position = position
    add_child(building)
    
    # Manual state management
    var building_id = generate_building_id()
    buildings[building_id] = {
        "node": building,
        "type": type,
        "position": position,
        "health": 100
    }
    
    return true

func validate_placement(type, position):
    # 20+ lines of validation logic
    if not building_types.has(type):
        return false
    
    var grid_pos = position_to_grid(position)
    if grid_pos.x < 0 or grid_pos.y < 0:
        return false
    
    # More validation...
    return true
```

#### New BuildingManager
```gdscript
# New: Clean building manager
extends Node

class_name BuildingManager

@onready var placement_system = $PlacementSystem
@onready var manipulation_system = $ManipulationSystem
@onready var grid_targeting_system = $GridTargetingSystem

func place_building(type, position):
    # Simple service call - all validation handled internally
    var result = placement_system.place_building(type, position, "player")
    
    if result.success:
        print("Building placed successfully")
        return true
    else:
        print("Placement failed: ", result.error)
        return false

func remove_building(building_node):
    var result = manipulation_system.remove_building(building_node)
    
    if result.success:
        print("Building removed successfully")
        return true
    else:
        print("Removal failed: ", result.error)
        return false

func can_place_building(type, position):
    # Quick validation check
    return placement_system.can_place_building(type, position)
```

### UI Integration Migration

#### Old UI Code
```gdscript
# Old: Manual UI updates
extends Control

@onready var building_manager = $"../BuildingManager"

func _on_place_button_pressed():
    var selected_type = get_selected_building_type()
    var grid_pos = get_mouse_grid_position()
    
    if building_manager.place_building(selected_type, grid_pos):
        update_ui()
        show_success_message()
    else:
        show_error_message()

func update_ui():
    # Manual UI state updates
    var building_count = building_manager.buildings.size()
    $BuildingCountLabel.text = "Buildings: " + str(building_count)
```

#### New UI Code
```gdscript
# New: Event-driven UI updates
extends Control

@onready var placement_system = $"../PlacementSystem"
@onready var manipulation_system = $"../ManipulationSystem"

func _ready():
    # Connect to service events
    placement_system.building_placed.connect(_on_building_placed)
    manipulation_system.building_removed.connect(_on_building_removed)

func _on_place_button_pressed():
    var selected_type = get_selected_building_type()
    var grid_pos = get_mouse_grid_position()
    
    # Service handles all the work
    placement_system.place_building(selected_type, grid_pos, "player")

func _on_building_placed(building_data):
    # Automatic UI updates via events
    update_ui()
    show_success_message()

func _on_building_removed(building_data):
    update_ui()
    show_removal_message()

func update_ui():
    # Get current state from services
    var building_count = placement_system.get_building_count()
    $BuildingCountLabel.text = "Buildings: " + str(building_count)
```

## Error Handling Migration

#### Old Error Handling
```gdscript
# Old: Manual error checking
func place_building(type, position):
    if not building_types.has(type):
        push_error("Unknown building type: " + type)
        return false
    
    if not is_valid_position(position):
        push_error("Invalid position: " + str(position))
        return false
    
    # Manual error handling throughout...
```

#### New Error Handling
```gdscript
# New: Service-provided error information
func place_building(type, position):
    var result = placement_system.place_building(type, position, "player")
    
    if not result.success:
        # Clear, actionable error messages
        match result.error_type:
            "UNKNOWN_BUILDING_TYPE":
                show_error("Unknown building type: " + type)
            "INVALID_POSITION":
                show_error("Cannot build at this position")
            "POSITION_OCCUPIED":
                show_error("This position is already occupied")
            "INSUFFICIENT_RESOURCES":
                show_error("Not enough resources to build this")
            _:
                show_error("Placement failed: " + result.error)
        
        return false
    
    return true
```

## Performance Improvements

### What Gets Faster

1. **Building Validation**: C# validation is 5-10x faster than GDScript
2. **Grid Calculations**: Optimized grid algorithms
3. **State Management**: Efficient C# data structures
4. **Collision Detection**: Fast spatial queries

### Measuring Performance

#### Old Performance Check
```gdscript
# Old: Manual performance tracking
var start_time = Time.get_ticks_msec()
place_building("house", position)
var end_time = Time.get_ticks_msec()
print("Placement took: ", end_time - start_time, "ms")
```

#### New Performance Check
```gdscript
# New: Built-in performance metrics
func place_building(type, position):
    var result = placement_system.place_building(type, position, "player")
    
    # Services provide timing information
    if result.performance_info:
        print("Placement took: ", result.performance_info.execution_time_ms, "ms")
        print("Validation took: ", result.performance_info.validation_time_ms, "ms")
```

## Testing Your Migration

### Step 1: Basic Functionality Test
```gdscript
# Test basic placement
func test_basic_placement():
    var result = placement_system.place_building("house", Vector2i(5, 5), "player")
    assert(result.success, "Basic placement should work")
    print("✅ Basic placement test passed")
```

### Step 2: Error Handling Test
```gdscript
# Test error handling
func test_error_handling():
    var result = placement_system.place_building("invalid_type", Vector2i(-1, -1), "player")
    assert(not result.success, "Invalid placement should fail")
    assert(result.error != "", "Should provide error message")
    print("✅ Error handling test passed")
```

### Step 3: Performance Test
```gdscript
# Test performance improvement
func test_performance():
    var start_time = Time.get_ticks_msec()
    
    # Place multiple buildings
    for i in range(100):
        placement_system.place_building("house", Vector2i(i, i), "player")
    
    var end_time = Time.get_ticks_msec()
    var total_time = end_time - start_time
    
    assert(total_time < 1000, "100 placements should take less than 1 second")
    print("✅ Performance test passed: ", total_time, "ms for 100 placements")
```

## Common Migration Issues

### Issue 1: Missing Service References
**Problem**: `placement_system` is null

**Solution**: Ensure services are added to scene tree
```gdscript
func _ready():
    # Make sure services exist
    if not has_node("PlacementSystem"):
        var placement_system = preload("res://addons/grid_building/godot/systems/placement/placement_system.gd").new()
        add_child(placement_system)
    
    placement_system = $PlacementSystem
```

### Issue 2: Event Connection Errors
**Problem**: Events not firing

**Solution**: Connect events after services are ready
```gdscript
func _ready():
    # Wait for services to be ready
    await placement_system.ready
    
    # Then connect events
    placement_system.building_placed.connect(_on_building_placed)
```

### Issue 3: Performance Regression
**Problem**: New system slower than old

**Solution**: Check for configuration issues
```gdscript
func _ready():
    # Optimize service configuration
    placement_system.configure({
        "enable_caching": true,
        "max_cache_size": 1000,
        "validation_mode": "fast"
    })
```

## Rollback Plan

If you need to rollback during migration:

### Step 1: Keep Old Systems
```gdscript
# Keep old systems as fallback
var old_building_system = preload("res://old_systems/building_system.gd").new()
var use_new_system = true

func place_building(type, position):
    if use_new_system:
        return placement_system.place_building(type, position, "player")
    else:
        return old_building_system.place_building(type, position, "player")
```

### Step 2: Gradual Migration
```gdscript
# Migrate feature by feature
func place_building(type, position):
    # Try new system first
    if placement_system != null:
        var result = placement_system.place_building(type, position, "player")
        if result.success:
            return result
    
    # Fallback to old system
    return old_building_system.place_building(type, position, "player")
```

### Step 3: Complete Switch
```gdscript
# Once confident, remove old systems
func place_building(type, position):
    # Only new system
    return placement_system.place_building(type, position, "player")
```

## Migration Checklist

### Pre-Migration
- [ ] Backup current project
- [ ] Document current building system usage
- [ ] Identify all building-related code
- [ ] Test current functionality

### Migration
- [ ] Add new service nodes to scenes
- [ ] Update building placement calls
- [ ] Update building removal calls
- [ ] Update grid targeting calls
- [ ] Connect to new service events
- [ ] Update error handling

### Post-Migration
- [ ] Test all building functionality
- [ ] Verify performance improvements
- [ ] Update documentation
- [ ] Remove old system code
- [ ] Test with save/load system

## Benefits You'll See

### Immediate Benefits
- **Cleaner Code**: Your GDScript becomes much simpler
- **Better Errors**: Clear, actionable error messages
- **Event System**: Automatic updates when buildings change

### Performance Benefits
- **5-10x Faster**: Building validation and placement
- **Less Memory**: Efficient C# data structures
- **Smoother UI**: Non-blocking building operations

### Maintenance Benefits
- **Easier Testing**: Services can be tested independently
- **Better Debugging**: Clear separation of concerns
- **Future-Proof**: Easy to extend and modify

## Need Help?

If you run into issues during migration:

1. **Check the Examples**: See working implementations
2. **Review API Reference**: Complete method documentation
3. **Test Incrementally**: Migrate one feature at a time
4. **Use Fallbacks**: Keep old systems during transition

The new service architecture is designed to make your building systems more powerful and your code cleaner. Take it step by step, and you'll see the benefits immediately!
