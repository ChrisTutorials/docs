---
title: "POCS Architecture Guide"
description: "How to use GridBuilding's clean architecture in your Godot projects"
weight: 10
---

# POCS Architecture Guide

## Overview

GridBuilding uses POCS (Pure C# Core Services) architecture to provide you with a clean, powerful building system that separates complex logic from your Godot game code. This means you get:

- **Faster Development** - Complex building logic handled for you
- **Clean Code** - Your Godot scripts stay simple and focused
- **Better Performance** - Optimized core services handle the heavy lifting
- **Easy Testing** - Core logic can be tested without running Godot

## What This Means for You

### In Your Godot Project
You work with simple Godot Nodes and familiar patterns:

```gdscript
# Simple Godot script - just call the service
extends Node

@onready var placement_system = $PlacementSystem

func place_building(building_type, position):
    var result = placement_system.place_building(building_type, position)
    if result.success:
        print("Building placed!")
    else:
        print("Placement failed: ", result.error)
```

### Behind the Scenes
The complex logic happens in pure C# services that:
- Validate building placement
- Handle collision detection
- Manage building state
- Process removal operations

## Key Components You'll Use

### 1. Godot Nodes (Your Interface)
These are the Godot Nodes you add to your scene tree:

- **PlacementSystem** - Handle building placement
- **ManipulationSystem** - Handle building movement/removal
- **GridTargetingSystem** - Handle grid targeting and selection

### 2. Services (The Brains)
These run in the background - you don't interact with them directly:
- **PlacementService** - Validates and executes placement
- **ManipulationService** - Handles building operations
- **GridTargetingEventService** - Manages targeting events

### 3. State Objects (Data Storage)
These hold building data - you might read from them but don't modify directly:
- **BuildingState** - Contains building information
- **GridTargetingState** - Contains targeting information

## Benefits for Your Game Development

### 1. Simpler Godot Code
Your Godot scripts focus on game logic, not building system complexity:

```gdscript
# Before: Complex building logic in GDScript
extends Node
func place_building(building_type, position):
    # 50+ lines of validation, collision checking, state management...
    pass

# After: Clean, simple calls
extends Node
func place_building(building_type, position):
    var result = $PlacementSystem.place_building(building_type, position)
    handle_placement_result(result)
```

### 2. Better Performance
Core services are optimized C# code that runs much faster than GDScript:
- Collision detection is handled in efficient C#
- Grid calculations use optimized algorithms
- State management is memory-efficient

### 3. Reliable Building Logic
The core services handle edge cases you might not think of:
- Building overlaps and collisions
- Grid boundary validation
- State consistency
- Error handling and recovery

### 4. Easy Debugging
When something goes wrong, you get clear error messages:
- "Building placement failed: Position occupied"
- "Invalid building type: 'tower' not found"
- "Grid boundary exceeded: position (20, 30) outside grid"

## How to Use the System

### Step 1: Add Systems to Your Scene
```gdscript
# In your main scene or building manager
var placement_system = preload("res://addons/grid_building/godot/systems/placement/placement_system.gd").new()
var manipulation_system = preload("res://addons/grid_building/godot/systems/manipulation/manipulation_system.gd").new()

add_child(placement_system)
add_child(manipulation_system)
```

### Step 2: Configure Your Buildings
```gdscript
# Define what buildings can be placed
var building_config = {
    "house": {
        "size": Vector2i(2, 2),
        "scene": "res://buildings/house.tscn",
        "cost": 100
    },
    "tower": {
        "size": Vector2i(1, 1), 
        "scene": "res://buildings/tower.tscn",
        "cost": 50
    }
}
```

### Step 3: Use the Building Systems
```gdscript
# Place a building
func on_place_building_requested(building_type, grid_position):
    var result = placement_system.place_building(building_type, grid_position, "player")
    
    if result.success:
        # Building automatically added to scene tree
        spawn_building_effects(result.building_node)
        update_player_resources(-building_config[building_type].cost)
    else:
        show_error_message(result.error)

# Remove a building
func on_remove_building_requested(building_node):
    var result = manipulation_system.remove_building(building_node)
    
    if result.success:
        despawn_building_effects(building_node)
        refund_building_cost(building_node.building_type)
    else:
        show_error_message(result.error)
```

## Common Usage Patterns

### Building Placement with Validation
```gdscript
func try_place_building_at_cursor(building_type):
    var grid_pos = grid_targeting_system.get_grid_position(get_global_mouse_position())
    
    # Check if placement is valid before attempting
    if not placement_system.can_place_building(building_type, grid_pos):
        show_invalid_placement_preview()
        return
    
    # Show valid placement preview
    show_valid_placement_preview(building_type, grid_pos)
    
    # Actually place when player confirms
    if Input.is_action_just_pressed("confirm_placement"):
        place_building(building_type, grid_pos)
```

### Building Selection and Manipulation
```gdscript
func on_building_clicked(building_node):
    if selected_building == building_node:
        # If already selected, start moving
        start_building_movement(building_node)
    else:
        # Select the building
        select_building(building_node)

func start_building_movement(building_node):
    # Enter manipulation mode
    manipulation_system.start_move_operation(building_node)
    
    # Show movement preview
    show_movement_preview(building_node)
```

### Grid-Based Targeting
```gdscript
func _process(_delta):
    # Update grid targeting based on mouse position
    var mouse_pos = get_global_mouse_position()
    grid_targeting_system.update_target_position(mouse_pos)
    
    # Get current grid position for UI
    var current_grid_pos = grid_targeting_system.get_current_grid_position()
    update_grid_coordinates_display(current_grid_pos)
```

## Error Handling Best Practices

### Always Check Results
```gdscript
# ✅ GOOD: Always check operation results
func place_building(building_type, position):
    var result = placement_system.place_building(building_type, position, "player")
    
    if not result.success:
        # Handle specific error types
        match result.error_type:
            "POSITION_OCCUPIED":
                show_message("This position is already occupied!")
            "INVALID_POSITION":
                show_message("Can't build here!")
            "INSUFFICIENT_RESOURCES":
                show_message("Not enough resources!")
            _:
                show_message("Placement failed: " + result.error)
        
        return false
    
    # Success case
    return true

# ❌ AVOID: Ignoring results
func place_building(building_type, position):
    placement_system.place_building(building_type, position, "player")
    # No error checking - building might fail silently!
```

### Provide User Feedback
```gdscript
func handle_placement_result(result):
    if result.success:
        # Positive feedback
        play_sound("building_placed")
        show_particles("placement_success", result.position)
        update_ui_resources()
    else:
        # Clear error feedback
        play_sound("error")
        shake_camera()
        show_error_tooltip(result.error)
```

## Performance Tips

### 1. Use Efficient Grid Updates
```gdscript
# ✅ GOOD: Batch updates when possible
func update_multiple_buildings(buildings):
    for building in buildings:
        building_system.queue_building_update(building)
    building_system.process_queued_updates()

# ❌ AVOID: Individual updates in loops
func update_multiple_buildings(buildings):
    for building in buildings:
        building_system.update_building_now(building)  # Expensive!
```

### 2. Optimize Targeting Updates
```gdscript
# ✅ GOOD: Throttle targeting updates
var _last_target_update = 0
const TARGET_UPDATE_RATE = 0.1  # 10 times per second

func _process(delta):
    _last_target_update += delta
    if _last_target_update >= TARGET_UPDATE_RATE:
        grid_targeting_system.update_target_position(get_global_mouse_position())
        _last_target_update = 0
```

## Integration with Your Game Systems

### Resource Management
```gdscript
# Connect building placement to your resource system
func _ready():
    placement_system.building_placed.connect(_on_building_placed)

func _on_building_placed(building_data):
    # Deduct resources based on building type
    var cost = get_building_cost(building_data.type)
    resource_system.deduct_resources(cost)
    
    # Update statistics
    stats_system.building_placed(building_data.type)
```

### Save/Load Integration
```gdscript
# Save building state
func save_game_state():
    var building_states = placement_system.get_all_building_states()
    save_data["buildings"] = building_states

# Load building state
func load_game_state(save_data):
    if save_data.has("buildings"):
        for building_state in save_data["buildings"]:
            placement_system.restore_building(building_state)
```

## Migration from Old Systems

If you're coming from older GridBuilding versions:

### From Direct Node Management
```gdscript
# OLD WAY: Manual node management
func place_building(building_type, position):
    var building_scene = preload("res://buildings/" + building_type + ".tscn")
    var building = building_scene.instantiate()
    building.position = position
    add_child(building)
    # Manual validation, collision checking, state tracking...

# NEW WAY: Use the service
func place_building(building_type, position):
    placement_system.place_building(building_type, position, "player")
    # Everything handled for you!
```

### From GDScript Building Logic
```gdscript
# OLD WAY: Complex GDScript logic
extends Node
func validate_placement(position, building_type):
    # 20+ lines of validation logic...
    if position.x < 0 or position.y < 0: return false
    if check_collisions(position, building_type): return false
    # More validation...

# NEW WAY: Let the service handle it
extends Node
func validate_placement(position, building_type):
    return placement_system.can_place_building(building_type, position)
```

## Next Steps

1. **Read the Service Pattern Migration Guide** - For detailed migration steps
2. **Check the Examples** - See real implementations in action
3. **Review API Reference** - Complete method documentation
4. **Try the Tutorial** - Step-by-step building system setup

The POCS architecture gives you the power of complex building systems while keeping your Godot code clean and simple. Focus on making your game great - let GridBuilding handle the building complexity!
