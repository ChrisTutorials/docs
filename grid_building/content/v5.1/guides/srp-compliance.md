---
title: "Clean Code Principles"
description: "How to write clean, maintainable code with GridBuilding"
weight: 30
---

# Clean Code Principles

## Overview

GridBuilding is built with clean code principles to make your development easier. This guide shows you how to write clean, maintainable code when using the building system.

## What This Means for You

### Simple Godot Scripts
Your code stays focused on game logic, not building system complexity:

```gdscript
# ✅ GOOD: Clean, focused code
extends Node

func place_building(building_type, position):
    var result = $PlacementSystem.place_building(building_type, position, "player")
    
    if result.success:
        show_success_effect(position)
        update_resources(-get_building_cost(building_type))
    else:
        show_error(result.error)

# ❌ AVOID: Complex mixed concerns
extends Node

func place_building(building_type, position):
    # Don't mix building logic with game logic
    if not validate_grid_position(position):
        return false
    
    if not check_player_resources(get_building_cost(building_type)):
        return false
    
    if not check_building_unlocked(building_type):
        return false
    
    # 20+ lines of building system logic...
```

## Key Principles

### 1. Single Responsibility
Each function does one thing well:

```gdscript
# ✅ GOOD: Single purpose functions
func handle_building_placement(building_type, position):
    var result = attempt_placement(building_type, position)
    handle_placement_result(result)

func attempt_placement(building_type, position):
    return $PlacementSystem.place_building(building_type, position, "player")

func handle_placement_result(result):
    if result.success:
        celebrate_placement()
    else:
        show_placement_error(result.error)

# ❌ AVOID: Functions doing too much
func handle_building_placement(building_type, position):
    # Validation, placement, UI updates, resource management...
    if not validate_grid_position(position):
        show_error("Invalid position")
        return
    
    if not check_resources(building_type):
        show_error("Not enough resources")
        return
    
    var result = $PlacementSystem.place_building(building_type, position, "player")
    if result.success:
        update_ui()
        play_sound()
        show_particles()
        save_game()
        unlock_achievements()
        # ... more mixed concerns
```

### 2. Clear Naming
Use descriptive names that explain what code does:

```gdscript
# ✅ GOOD: Clear, descriptive names
func can_player_afford_building(building_type):
    return resource_manager.get_resources() >= get_building_cost(building_type)

func is_position_valid_for_building(building_type, grid_position):
    return $PlacementSystem.can_place_building(building_type, grid_position)

func handle_successful_placement(building_data):
    spawn_placement_effects(building_data.position)
    deduct_building_cost(building_data.type)
    update_building_statistics(building_data.type)

# ❌ AVOID: Unclear names
func check(type, pos):
    return resource_manager.gold >= costs[type] and $PlacementSystem.validate(pos)

func do_stuff(result):
    if result.ok:
        make_effects()
        take_money()
        update_stats()
```

### 3. Small Functions
Keep functions short and focused:

```gdscript
# ✅ GOOD: Small, focused functions
func place_building_at_cursor(building_type):
    var grid_pos = get_cursor_grid_position()
    
    if not can_place_building_here(building_type, grid_pos):
        show_invalid_placement_feedback()
        return
    
    place_building(building_type, grid_pos)

func can_place_building_here(building_type, grid_pos):
    return is_within_grid_bounds(grid_pos) and 
           $PlacementSystem.can_place_building(building_type, grid_pos) and
           player_has_required_resources(building_type)

func show_invalid_placement_feedback():
    play_error_sound()
    shake_camera()
    show_tooltip("Cannot build here")

# ❌ AVOID: Large functions
func place_building_at_cursor(building_type):
    var grid_pos = get_cursor_grid_position()
    
    # Too much logic in one function
    if grid_pos.x < 0 or grid_pos.y < 0 or grid_pos.x >= GRID_WIDTH or grid_pos.y >= GRID_HEIGHT:
        play_error_sound()
        shake_camera()
        show_tooltip("Out of bounds")
        return
    
    if not $PlacementSystem.can_place_building(building_type, grid_pos):
        play_error_sound()
        shake_camera()
        show_tooltip("Position occupied")
        return
    
    if resource_manager.gold < building_costs[building_type]:
        play_error_sound()
        shake_camera()
        show_tooltip("Not enough gold")
        return
    
    # ... more logic
```

## Practical Examples

### Building Manager Pattern

#### Clean Building Manager
```gdscript
extends Node
class_name BuildingManager

# Service references
@onready var placement_service = $PlacementService
@onready var manipulation_service = $ManipulationService
@onready var resource_manager = $ResourceManager

# Public interface - simple and clear
func can_place_building(building_type, position):
    return is_position_valid(position) and 
           player_can_afford(building_type) and
           building_is_unlocked(building_type)

func place_building(building_type, position):
    var result = placement_service.place_building(building_type, position, "player")
    
    if result.success:
        handle_successful_placement(building_type, result)
    else:
        handle_placement_failure(result)
    
    return result.success

func remove_building(building_node):
    var result = manipulation_service.remove_building(building_node)
    
    if result.success:
        handle_successful_removal(building_node, result)
    else:
        handle_removal_failure(result)
    
    return result.success

# Private helpers - focused on single tasks
func is_position_valid(position):
    return placement_service.can_place_building("", position)  # Type-agnostic check

func player_can_afford(building_type):
    return resource_manager.has_resources(get_building_cost(building_type))

func building_is_unlocked(building_type):
    return unlock_manager.is_building_unlocked(building_type)

func handle_successful_placement(building_type, result):
    deduct_resources(building_type)
    play_success_sound()
    show_placement_effect(result.position)
    update_statistics(building_type)

func handle_placement_failure(result):
    play_error_sound()
    show_error_message(result.error)

func handle_successful_removal(building_node, result):
    refund_building_cost(building_node.building_type)
    play_removal_sound()
    show_removal_effect(result.position)
```

### UI Controller Pattern

#### Clean UI Controller
```gdscript
extends Control
class_name BuildingUIController

# UI Elements
@onready var building_grid = $BuildingGrid
@onready var resource_display = $ResourceDisplay
@onready var placement_preview = $PlacementPreview

# Game Systems
@onready var building_manager = $"../BuildingManager"
@onready var grid_targeting = $"../GridTargetingSystem"

func _ready():
    setup_ui_connections()
    update_ui_state()

func _process(_delta):
    update_placement_preview()

func setup_ui_connections():
    building_grid.building_selected.connect(_on_building_selected)
    building_grid.building_deselected.connect(_on_building_deselected)

func update_ui_state():
    resource_display.update_resources()
    update_building_grid_availability()

func update_placement_preview():
    if not has_selected_building():
        placement_preview.hide()
        return
    
    var grid_pos = grid_targeting.get_current_grid_position()
    var can_place = building_manager.can_place_building(selected_building, grid_pos)
    
    placement_preview.show_at(grid_pos, can_place)

func has_selected_building():
    return selected_building != ""

# Event handlers - single responsibility each
func _on_building_selected(building_type):
    selected_building = building_type
    update_placement_preview()

func _on_building_deselected():
    selected_building = ""
    placement_preview.hide()

func _on_placement_requested(position):
    if has_selected_building():
        building_manager.place_building(selected_building, position)
```

### Input Handler Pattern

#### Clean Input Handler
```gdscript
extends Node
class_name BuildingInputHandler

# Dependencies
@onready var building_manager = $"../BuildingManager"
@onready var ui_controller = $"../BuildingUIController"

# Input state
var selected_building = ""
var is_placement_mode = false

func _ready():
    setup_input_actions()

func _input(event):
    handle_building_input(event)

func setup_input_actions():
    InputMap.add_action("place_building")
    InputMap.add_action("cancel_placement")
    InputMap.add_action("remove_building")

func handle_building_input(event):
    if is_placement_mode:
        handle_placement_input(event)
    else:
        handle_selection_input(event)

func handle_placement_input(event):
    if event.is_action_pressed("place_building"):
        attempt_placement_at_cursor()
    elif event.is_action_pressed("cancel_placement"):
        exit_placement_mode()

func handle_selection_input(event):
    if event.is_action_pressed("remove_building"):
        start_removal_mode()

func attempt_placement_at_cursor():
    var grid_pos = get_cursor_grid_position()
    
    if building_manager.place_building(selected_building, grid_pos):
        exit_placement_mode()  # Success - exit placement mode
    else:
        shake_ui()  # Failure - show feedback

func exit_placement_mode():
    is_placement_mode = false
    ui_controller.hide_placement_preview()

func start_removal_mode():
    ui_controller.show_removal_cursor()
```

## Error Handling Best Practices

### Clear Error Messages
```gdscript
# ✅ GOOD: Specific, actionable errors
func handle_placement_result(result):
    if not result.success:
        match result.error_type:
            "POSITION_OCCUPIED":
                show_error("This position is already occupied!")
            "INSUFFICIENT_RESOURCES":
                show_error("Not enough resources! Need " + str(result.required_resources))
            "INVALID_POSITION":
                show_error("Cannot build at this location!")
            "BUILDING_LOCKED":
                show_error("This building is not unlocked yet!")
            _:
                show_error("Placement failed: " + result.error)

# ❌ AVOID: Generic, unhelpful errors
func handle_placement_result(result):
    if not result.success:
        show_error("Building placement failed")
```

### Graceful Error Recovery
```gdscript
# ✅ GOOD: Graceful error handling
func place_building_with_fallback(building_type, position):
    var result = building_manager.place_building(building_type, position)
    
    if not result.success:
        # Try to help the user
        if result.error_type == "POSITION_OCCUPIED":
            # Find nearest valid position
            var nearest_valid = find_nearest_valid_position(position)
            if nearest_valid:
                show_suggestion("Try placing at " + str(nearest_valid))
        
        # Show helpful feedback
        show_error_with_suggestion(result.error, get_suggestion_for_error(result.error_type))
    
    return result.success

func get_suggestion_for_error(error_type):
    match error_type:
        "POSITION_OCCUPIED":
            return "Try clearing the area first"
        "INSUFFICIENT_RESOURCES":
            return "Gather more resources or choose a cheaper building"
        "INVALID_POSITION":
            return "Build within the highlighted grid area"
        _:
            return "Check building requirements"
```

## Performance Tips

### Efficient UI Updates
```gdscript
# ✅ GOOD: Throttled UI updates
var _last_ui_update = 0
const UI_UPDATE_RATE = 0.1  # 10 times per second

func _process(delta):
    _last_ui_update += delta
    if _last_ui_update >= UI_UPDATE_RATE:
        update_ui_if_needed()
        _last_ui_update = 0

func update_ui_if_needed():
    if has_ui_changed():
        resource_display.update_resources()
        update_building_buttons()

# ❌ AVOID: Update every frame
func _process(_delta):
    resource_display.update_resources()  # Expensive!
    update_building_buttons()  # Expensive!
```

### Batch Operations
```gdscript
# ✅ GOOD: Batch multiple operations
func place_multiple_buildings(buildings_data):
    # Validate all first
    for building_data in buildings_data:
        if not building_manager.can_place_building(building_data.type, building_data.position):
            show_error("Cannot place " + building_data.type + " at " + str(building_data.position))
            return false
    
    # Then place all at once
    for building_data in buildings_data:
        building_manager.place_building(building_data.type, building_data.position, "player")
    
    return true

# ❌ AVOID: Individual operations in loops
func place_multiple_buildings(buildings_data):
    for building_data in buildings_data:
        # Each call does validation, UI updates, etc.
        building_manager.place_building(building_data.type, building_data.position, "player")
```

## Testing Your Code

### Unit Testing Patterns
```gdscript
# Test individual functions
func test_can_place_building():
    # Arrange
    var building_type = "house"
    var valid_position = Vector2i(5, 5)
    var invalid_position = Vector2i(-1, -1)
    
    # Act & Assert
    assert(building_manager.can_place_building(building_type, valid_position))
    assert(not building_manager.can_place_building(building_type, invalid_position))

# Test error handling
func test_error_messages():
    var result = building_manager.place_building("invalid_type", Vector2i(-1, -1))
    
    assert(not result.success)
    assert(result.error != "")
    assert(result.error_type in ["UNKNOWN_BUILDING_TYPE", "INVALID_POSITION"])
```

### Integration Testing
```gdscript
# Test complete workflows
func test_complete_building_workflow():
    # Select building
    ui_controller.select_building("house")
    assert(ui_controller.has_selected_building())
    
    # Place building
    var position = Vector2i(5, 5)
    var success = building_manager.place_building("house", position)
    assert(success)
    
    # Verify building exists
    var building = find_building_at(position)
    assert(building != null)
    assert(building.building_type == "house")
```

## Code Review Checklist

### Function Quality
- [ ] Function has single, clear purpose
- [ ] Function name describes what it does
- [ ] Function is short (< 20 lines ideally)
- [ ] Function has minimal parameters (< 5 ideally)

### Error Handling
- [ ] All service results are checked
- [ ] Error messages are clear and actionable
- [ ] Graceful fallbacks where appropriate
- [ ] User gets helpful feedback

### Performance
- [ ] UI updates are throttled
- [ ] Expensive operations are batched
- [ ] No unnecessary calculations in loops
- [ ] Resource cleanup where needed

### Maintainability
- [ ] Code is easy to read and understand
- [ ] Dependencies are clear and minimal
- [ ] Comments explain why, not what
- [ ] Consistent naming and style

## Common Anti-Patterns to Avoid

### 1. God Complex Functions
```gdscript
# ❌ AVOID: Functions that do everything
func handle_everything():
    # Input handling
    if Input.is_action_just_pressed("click"):
        # Building placement
        if can_place_building():
            place_building()
            # UI updates
            update_ui()
            # Resource management
            deduct_resources()
            # Sound effects
            play_sound()
            # Save game
            save_game()
            # Statistics
            update_stats()
            # Achievements
            check_achievements()
```

### 2. Magic Numbers and Strings
```gdscript
# ❌ AVOID: Hard-coded values
func place_building():
    if player_gold >= 100:  # Magic number
        building_type = "house"  # Magic string
        position = Vector2i(5, 5)  # Magic position

# ✅ GOOD: Named constants
const HOUSE_COST = 100
const HOUSE_TYPE = "house"

func place_building():
    if player_gold >= HOUSE_COST:
        building_type = HOUSE_TYPE
        position = get_default_building_position()
```

### 3. Deep Nesting
```gdscript
# ❌ AVOID: Deep nesting
func complex_function():
    if condition1:
        if condition2:
            if condition3:
                if condition4:
                    # Do something
                else:
                    # Handle else
            else:
                # Handle else
        else:
            # Handle else
    else:
        # Handle else

# ✅ GOOD: Early returns
func complex_function():
    if not condition1:
        return handle_else1()
    
    if not condition2:
        return handle_else2()
    
    if not condition3:
        return handle_else3()
    
    if not condition4:
        return handle_else4()
    
    # Do something
```

## Benefits of Clean Code

### For You
- **Faster Development**: Code is easier to write and modify
- **Fewer Bugs**: Clear code is easier to get right
- **Better Performance**: Optimized structure and patterns
- **Easier Testing**: Small, focused functions are easy to test

### For Your Team
- **Better Collaboration**: Clean code is easy to understand
- **Faster Onboarding**: New developers can quickly understand the code
- **Consistent Style**: Everyone follows the same patterns
- **Better Documentation**: Self-documenting code needs less explanation

### For Your Project
- **Easier Maintenance**: Changes are localized and predictable
- **Better Performance**: Optimized patterns and structures
- **Future-Proof**: Clean code adapts well to new requirements
- **Professional Quality**: Code that meets industry standards

Clean code isn't just about making things work - it's about making things work well, be maintainable, and be enjoyable to work with. GridBuilding's architecture helps you write clean code by providing clear boundaries and responsibilities.

Start with these principles, and you'll see the benefits immediately in your development workflow!
