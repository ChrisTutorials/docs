---
title: "Architecture Evolution: GDScript to POCS"
description: "How GridBuilding evolved from pure GDScript to clean POCS architecture"
weight: 50
---

## The Transformation

GridBuilding has undergone a major architectural evolution from GDScript-heavy, Godot-dependent code to a clean POCS (Pure C# Core Services) architecture with thin Godot wrappers.

## Before: Pure GDScript Architecture

### What It Looked Like
```gdscript
# Old: Everything in GDScript, Godot-dependent
extends Node
class_name BuildingSystem

var buildings = {}
var grid_data = {}
var collision_map = {}

func _ready():
    setup_grid()
    load_buildings()

func place_building(building_type, position):
    # All logic in GDScript - 50+ lines
    if not validate_placement(building_type, position):
        return false
    
    # Manual scene management
    var scene = load("res://buildings/" + building_type + ".tscn")
    var building = scene.instantiate()
    building.position = position
    add_child(building)
    
    # Manual state tracking
    var building_id = generate_id()
    buildings[building_id] = {
        "node": building,
        "type": building_type,
        "position": position,
        "health": 100
    }
    
    # Manual grid updates
    update_grid_data(position, building_type)
    update_collision_map(position, building_type)
    
    return true

func validate_placement(building_type, position):
    # Complex validation logic in GDScript
    if not grid_data.has(position):
        return false
    
    if collision_map.has(position):
        return false
    
    # 20+ lines of validation...
    return true
```

### Problems with Old Architecture

**Note:** The GDScript version performed fine for typical use cases. Performance wasn't noticeably problematic, but the architecture had other challenges:

#### 1. Testing Challenges
```gdscript
# Old: Hard to test GDScript code
func test_building_placement():
    # Need full Godot environment
    var scene = preload("res://tests/test_scene.tscn").instantiate()
    add_child(scene)
    
    var building_system = scene.get_node("BuildingSystem")
    var result = building_system.place_building("house", Vector2(5, 5))
    
    # Complex setup and teardown
    scene.queue_free()
```

#### 2. Code Maintenance
- **Mixed Concerns**: Building logic, UI, and state all mixed together
- **Godot Dependencies**: Everything tied to Godot Node system
- **Hard to Extend**: Adding new features required touching many files

#### 3. Limited Reusability
- **Godot Lock-in**: Code only worked in Godot
- **No Engine Portability**: Couldn't reuse for Unity or other engines
- **Monolithic Design**: Large, interconnected classes

## After: POCS Architecture

### What It Looks Like Now

#### Core Services (Pure C# - No Godot Dependencies)
```csharp
// New: Pure C# business logic
public class PlacementService : IPlacementService
{
    private readonly IPlacementValidator _validator;
    private readonly ICollisionCalculator _collisionCalculator;
    
    public PlacementResult ExecutePlacement(Placeable placeable, Vector2 position, GBOwner placer)
    {
        // Fast C# validation
        var validationResult = _validator.ValidatePlacement(placeable, position, placer);
        if (!validationResult.IsValid)
        {
            return PlacementResult.Failed(validationResult.ErrorMessage);
        }
        
        // Optimized collision detection
        var collisionResult = _collisionCalculator.CheckCollisions(placeable, position);
        if (collisionResult.HasCollision)
        {
            return PlacementResult.Failed("Position occupied");
        }
        
        return PlacementResult.Success(position, placeable.Type);
    }
}
```

#### State Objects (Pure Data)
```csharp
// New: Clean data objects
public class BuildingState : IRuntimeState
{
    public string BuildingId { get; set; }
    public string BuildingType { get; set; }
    public Vector2I GridPosition { get; set; }
    public BuildingStatus Status { get; set; }
    public int Health { get; set; }
    
    // No business logic - just data
    public void UpdateTimestamp() { }
    public void SetCustomData(string key, object value) { }
}
```

#### Godot Wrappers (Thin Adapters)
```gdscript
# New: Thin Godot wrapper
extends Node
class_name PlacementSystem

# Just forwards to C# service
@onready var placement_service = ServiceRegistry.get_placement_service()

func place_building(building_type, position):
    var result = placement_service.execute_placement(
        Placeable.new(building_type), 
        position, 
        GBOwner.new("player")
    )
    
    if result.success:
        # Handle Godot-specific stuff
        spawn_building_visual(result)
    
    return result.success
```

## Key Improvements

### 1. Better Architecture & Testing

#### Before (GDScript)
```gdscript
# GDScript validation
func validate_placement(building_type, position):
    for x in range(building_size.x):
        for y in range(building_size.y):
            var check_pos = position + Vector2i(x, y)
            if collision_map.has(check_pos):
                return false
    return true
```

#### After (C#)
```csharp
// C# validation with clean architecture
public ValidationResult ValidatePlacement(Placeable placeable, Vector2 position, GBOwner placer)
{
    // Clean separation of concerns
    var occupiedTiles = _collisionCalculator.GetOccupiedTiles(position, placeable.Size);
    
    if (occupiedTiles.Count > 0)
    {
        return ValidationResult.Failed($"Position occupied: {string.Join(", ", occupiedTiles)}");
    }
    
    return ValidationResult.Success();
}
```

**Architecture Improvements:**
- **Clean separation** of concerns with dedicated services
- **Better testability** with pure C# unit tests
- **Improved maintainability** with focused, single-purpose classes

### 2. Testing Revolution

#### Before (Complex GDScript Tests)
```gdscript
# Old: Required full Godot environment
extends "res://addons/gdunit/test.gd"

func test_building_placement():
    # Complex setup
    var test_scene = preload("res://tests/test_scenes/building_test.tscn").instantiate()
    add_child(test_scene)
    
    var building_system = test_scene.get_node("BuildingSystem")
    var result = building_system.place_building("house", Vector2(5, 5))
    
    # Manual assertions
    assert(result == true, "Building should place")
    
    # Complex teardown
    test_scene.queue_free()
    await get_tree().process_frame
```

#### After (Simple C# Tests)
```csharp
// New: Pure C# unit tests
[Fact]
public void PlacementService_ValidPlaceable_ReturnsSuccess()
{
    // Simple setup - no Godot needed
    var validator = new Mock<IPlacementValidator>();
    validator.Setup(v => v.ValidatePlacement(It.IsAny<Placeable>(), It.IsAny<Vector2>(), It.IsAny<GBOwner>()))
        .Returns(ValidationResult.Success());
    
    var service = new PlacementService(validator.Object, ...);
    
    // Act
    var result = service.ExecutePlacement(placeable, position, placer);
    
    // Assert
    Assert.True(result.IsSuccess);
}
```

**Testing Benefits:**
- **Faster test execution** without Godot dependencies
- **Simple setup** - no complex scene preparation
- **Easy mocking** of dependencies
- **CI/CD compatible** - can run on any system

### 3. Code Organization

#### Before (Mixed Concerns)
```gdscript
# Old: Everything mixed together
extends Node
class_name BuildingManager

# Building logic
func place_building(type, pos): # ...

# UI logic  
func update_building_ui(): # ...

# Save/load logic
func save_buildings(): # ...

# Network logic
func sync_buildings(): # ...

# Sound effects
func play_building_sound(): # ...
```

#### After (Clean Separation)
```csharp
// New: Single responsibility services
public class PlacementService     // Building placement only
public class ManipulationService  // Building removal only  
public class SaveService          // Save/load only
public class NetworkService       // Network sync only
public class AudioService         // Sound effects only
```

### 4. Engine Portability

#### Before (Godot Lock-in)
```gdscript
# Old: Only works in Godot
extends Node

func place_building(type, pos):
    var scene = load("res://buildings/" + type + ".tscn")  # Godot-specific
    var building = scene.instantiate()                     # Godot-specific
    add_child(building)                                     # Godot-specific
```

#### After (Engine Agnostic)
```csharp
// New: Works with any engine
public class PlacementService
{
    public PlacementResult ExecutePlacement(Placeable placeable, Vector2 position, GBOwner placer)
    {
        // Pure C# - works in Godot, Unity, or any engine
        return ValidateAndPlace(placeable, position, placer);
    }
}

// Engine-specific adapters
public class GodotPlacementAdapter : Node
{
    public void HandlePlacementResult(PlacementResult result)
    {
        // Godot-specific implementation
        var scene = GD.Load<PackedScene>(result.ScenePath);
        var node = scene.Instantiate();
        AddChild(node);
    }
}

public class UnityPlacementAdapter : MonoBehaviour
{
    public void HandlePlacementResult(PlacementResult result)
    {
        // Unity-specific implementation
        var prefab = Resources.Load<GameObject>(result.ScenePath);
        var instance = Instantiate(prefab);
        instance.transform.position = result.Position.ToUnity();
    }
}
```

## Migration Benefits for Developers

### 1. Simpler GDScript Code
Your game code becomes much cleaner:

```gdscript
# Before: Complex GDScript
extends Node

func place_building(type, pos):
    # 50+ lines of complex logic
    if not validate_grid(pos):
        return false
    if not check_resources(type):
        return false
    if not check_collision(pos):
        return false
    # ... more logic
    var scene = load("res://buildings/" + type + ".tscn")
    var building = scene.instantiate()
    add_child(building)

# After: Clean service calls
extends Node

func place_building(type, pos):
    var result = $PlacementSystem.place_building(type, pos)
    if result.success:
        show_success_effect()
```

### 2. Better Error Handling
```gdscript
# Before: Manual error checking
func place_building(type, pos):
    var result = complex_placement_logic(type, pos)
    if result == null:
        print("Something went wrong")  # Vague error
    elif not result.success:
        print("Failed")  # Still vague

# After: Clear error messages
func place_building(type, pos):
    var result = $PlacementSystem.place_building(type, pos)
    if not result.success:
        match result.error_type:
            "POSITION_OCCUPIED":
                show_error("This position is already occupied!")
            "INSUFFICIENT_RESOURCES":
                show_error("Need " + str(result.required_resources) " more resources")
            "INVALID_POSITION":
                show_error("Cannot build outside the grid!")
```

### 3. Easier Debugging
```gdscript
# Before: Hard to debug GDScript
func place_building(type, pos):
    # Which part failed? Who knows!
    var complex_result = do_complex_stuff(type, pos)
    return complex_result

# After: Clear debugging info
func place_building(type, pos):
    var result = $PlacementSystem.place_building(type, pos)
    
    # Rich debugging information
    print("Placement attempt: ", result.debug_info)
    print("Validation time: ", result.performance.validation_time_ms, "ms")
    print("Collision checks: ", result.performance.collision_checks_count)
```

## Real-World Performance Comparison

### Building 100 Buildings

#### Before (GDScript)
```
Performance: Generally fine for normal use cases
Code Organization: Complex mixed concerns in single classes
Testing: Difficult to test without full Godot environment
```

#### After (POCS)
```
Performance: Maintains good performance with cleaner code
Code Organization: Clean separation of services and responsibilities
Testing: Easy unit testing without Godot dependencies
```

### Startup Time

#### Before (GDScript)
```
Initialization: Standard Godot node setup
Code Organization: Everything in large monolithic classes
Development: Complex debugging in mixed-concern code
```

#### After (POCS)
```
Initialization: Service registration and setup
Code Organization: Clean, focused service classes
Development: Easier debugging with separated concerns
```

## Future Benefits

### 1. Easy Feature Addition
Adding new building features is now simple:

```csharp
// Add new service for new feature
public class BuildingUpgradeService : IBuildingUpgradeService
{
    public UpgradeResult UpgradeBuilding(string buildingId, UpgradeType upgrade)
    {
        // Clean, isolated logic
    }
}
```

### 2. Multi-Engine Support
Same core services can power different engines:

```csharp
// Core logic shared
var placementService = new PlacementService(...);

// Godot adapter
var godotAdapter = new GodotPlacementAdapter(placementService);

// Unity adapter  
var unityAdapter = new UnityPlacementAdapter(placementService);
```

### 3. Advanced Testing
Complex scenarios are easy to test:

```csharp
[Fact]
public void StressTest_1000Placements_CompletesUnder1Second()
{
    var service = new PlacementService(...);
    var stopwatch = Stopwatch.StartNew();
    
    for (int i = 0; i < 1000; i++)
    {
        var result = service.ExecutePlacement(placeable, position, placer);
        Assert.True(result.IsSuccess);
    }
    
    stopwatch.Stop();
    Assert.True(stopwatch.ElapsedMilliseconds < 1000);
}
```

## Migration Summary

| Aspect | Before (GDScript) | After (POCS) | Improvement |
|--------|------------------|--------------|-------------|
| **Performance** | GDScript execution speed | Optimized C# services | Improved performance with better algorithms |
| **Testing** | Complex GDUnit setup | Simple C# unit tests | Easier and faster testing |
| **Code Quality** | Mixed concerns in large classes | Clean service separation | Better maintainability |
| **Engine Support** | Godot-only implementation | Engine-agnostic core | Multi-engine compatibility |
| **Error Handling** | Manual error checking | Rich error information | Better debugging experience |
| **Memory Usage** | GDScript memory management | Optimized C# collections | More efficient memory usage |
| **Development Speed** | Complex GDScript debugging | Simplified service calls | Faster development workflow |

## What This Means for You

### Immediate Benefits
- **Faster Development**: Your GDScript code is simpler and cleaner
- **Better Performance**: Improved algorithms and optimized data structures
- **Easier Debugging**: Clear error messages and better error information
- **Reliable Building**: Cleaner architecture reduces bugs and edge cases

### Long-term Benefits
- **Future-Proof**: Easy to add new features and engines
- **Professional Quality**: Industry-standard architecture
- **Team Ready**: Easy for other developers to understand
- **Scalable**: Handles large projects without performance issues

The evolution from GDScript-heavy to POCS architecture represents a fundamental improvement in how building systems are developed. You get the power and performance of C# while keeping your Godot code simple and focused on game logic.

This isn't just an architectural change - it's a complete transformation in development experience and code quality!

## State Management Migration: Owner Context to Service Instance

### The Problem with Owner Context Pattern

#### Before: Owner Context Dependencies
```csharp
// Old: State with problematic owner context
public class GridTargetingState : IGridTargetingState
{
    private IOwnerContext? _ownerContext;  // ❌ Non-existent interface
    private object? _collider;
    private object? _target;
    
    // Constructor required owner context
    public GridTargetingState(IOwnerContext ownerContext)
    {
        _ownerContext = ownerContext;  // ❌ Creates tight coupling
    }
    
    // Methods depended on owner context
    public bool ValidateState()
    {
        return _ownerContext != null && _targetMap != null;  // ❌ brittle
    }
}
```

**Problems with Owner Context:**
- **Tight Coupling**: State objects bound to specific owner implementations
- **Testing Complexity**: Need to mock or create owner contexts for tests
- **Engine Dependencies**: Owner contexts often contain engine-specific data
- **Scope Confusion**: Unclear which "owner" applies in complex scenarios

### The Solution: Service Instance Scoping

#### After: Service Instance Pattern
```csharp
// New: Clean state without owner dependencies
public class GridTargetingState : IGridTargetingState
{
    // ✅ Pure data - no owner context needed
    private object? _collider;
    private object? _target;
    private Vector2I _currentTargetTile = Vector2I.Zero;
    private bool _isManualTargetingActive = false;
    
    // ✅ Simple constructor
    public GridTargetingState()
    {
        _lastUpdated = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
    }
    
    // ✅ Clean validation without owner dependencies
    public bool ValidateState()
    {
        return _targetMap != null;  // Simple, testable
    }
}

// Service manages scope through instance isolation
public class GridTargetingService : IGridTargetingService
{
    // ✅ Service instance = scope boundary
    private readonly Dictionary<object, Vector2I> _componentStates = new();
    private Vector2I _currentTargetTile = Vector2I.Zero;
    
    // ✅ Component-based tracking instead of owner context
    public void SetTargetTile(Vector2I position)
    {
        var oldTarget = _currentTargetTile;
        _currentTargetTile = position;
        
        // ✅ Event-driven state changes
        TargetingStateChanged?.Invoke(this, new TargetingStateChangedEventArgs(...));
    }
}
```

### Migration Benefits

#### 1. **Cleaner Architecture**
```csharp
// Before: Complex owner relationships
var state = new GridTargetingState(someComplexOwnerContext);
state.SetTarget(someTarget); // Owner context affects behavior

// After: Simple service scoping
var targetingService = new GridTargetingService(); // Service = scope
targetingService.SetTargetTile(position); // Clear, predictable behavior
```

#### 2. **Better Testing**
```csharp
// Before: Complex test setup
[Fact]
public void TestTargetingState()
{
    var mockOwner = new Mock<IOwnerContext>(); // Complex mocking
    mockOwner.Setup(o => o.IsValid).Returns(true);
    var state = new GridTargetingState(mockOwner.Object);
    // ... complex setup continues
}

// After: Simple test setup
[Fact]
public void TestTargetingState()
{
    var state = new GridTargetingState(); // ✅ Simple construction
    var result = state.SetTarget(target);  // ✅ Direct testing
    Assert.Equal(target, result);
}
```

#### 3. **Engine Agnostic Design**
```csharp
// Before: Owner context tied to engine
public interface IOwnerContext
{
    Godot.Node GetGodotNode();  // ❌ Engine-specific
    Unity.MonoBehaviour GetUnityComponent(); // ❌ Engine-specific
}

// After: Service pattern works with any engine
public class GridTargetingService
{
    private readonly Dictionary<object, Vector2I> _componentStates;
    
    // ✅ Works with Godot, Unity, or any engine
    public void RegisterComponent(object component, Vector2I position)
    {
        _componentStates[component] = position;
    }
}
```

#### 4. **Clear Scope Management**
```csharp
// Before: Unclear scope boundaries
var owner1 = new PlayerOwnerContext();
var owner2 = new AIOwnerContext();
var state = new GridTargetingState(owner1); // Which scope applies?

// After: Clear service instance boundaries
var playerTargeting = new GridTargetingService(); // Player scope
var aiTargeting = new GridTargetingService();     // AI scope
// Each service manages its own state independently
```

### Implementation Patterns

#### 1. **Service Instance = Scope**
```csharp
// Each service instance provides natural isolation
public class GridTargetingService
{
    // Service-level state management
    private readonly Dictionary<object, Vector2I> _componentStates = new();
    
    // Multiple services = multiple scopes
    public static GridTargetingService CreatePlayerScope() => new();
    public static GridTargetingService CreateAIScope() => new();
}
```

#### 2. **Component-Based Tracking**
```csharp
// Track components by object reference, not owner hierarchy
private readonly Dictionary<object, Vector2I> _componentStates = new();

// Works with any component type
public void RegisterComponent(object component, Vector2I position)
{
    _componentStates[component] = position;
}

// Engine-agnostic component identification
public Vector2I GetComponentPosition(object component)
{
    return _componentStates.TryGetValue(component, out var pos) ? pos : Vector2I.Zero;
}
```

#### 3. **Event-Driven Updates**
```csharp
// State changes communicated through events
public event EventHandler<TargetingStateChangedEventArgs>? TargetingStateChanged;

public void SetTargetTile(Vector2I position)
{
    var oldTarget = _currentTargetTile;
    _currentTargetTile = position;
    
    // Notify interested parties without owner coupling
    TargetingStateChanged?.Invoke(this, new TargetingStateChangedEventArgs(oldTarget, _currentTargetTile));
}
```

### Migration Checklist

#### ✅ **What We Fixed**
- Removed `IOwnerContext` dependency from `GridTargetingState`
- Implemented explicit interface methods for property conflicts
- Added proper event implementations
- Simplified validation logic

#### ✅ **Architecture Consistency**
- All Core states now follow same pattern: pure data containers
- Service instances provide scope boundaries
- Component-based tracking replaces owner hierarchies
- Event-driven communication replaces direct owner calls

#### ✅ **Testing Improvements**
- Simple construction without complex dependencies
- Direct method testing without mocking
- Clear isolation between test scenarios
- Engine-agnostic test setup

### Real-World Impact

#### Before Migration
```csharp
// Complex, tightly coupled code
var ownerContext = new ComplexOwnerContext(player, grid, ui, network);
var state = new GridTargetingState(ownerContext);
var result = state.ValidateState(); // Depends on multiple systems
```

#### After Migration
```csharp
// Simple, decoupled code
var targetingService = new GridTargetingService(); // Service = scope
targetingService.UpdateGridNavigation(gridData);   // Clear dependencies
var result = targetingService.ValidatePosition(position); // Predictable behavior
```

**Key Insight**: **Service instance boundaries provide cleaner scope management than owner context hierarchies.**

This migration represents a fundamental improvement in state management architecture - moving from complex owner relationships to simple, predictable service instance scoping that works across any engine or framework.
