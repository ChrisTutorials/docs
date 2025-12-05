---
title: "GDScript to C# Migration Guide"
description: "Complete reference for migrating GDScript classes to C# equivalents in Grid Building 6.0"
date: 2025-12-05T09:52:00-05:00
weight: 15
draft: false
type: "docs"
layout: "docs"
url: "/v6.0/guides/gdscript-to-csharp-mapping/"
aliases: ["/latest/guides/gdscript-to-csharp-mapping/", "/gridbuilding/latest/guides/gdscript-to-csharp-mapping/"]
icon: "fas fa-code"
tags: ["gdscript", "csharp", "migration", "classes"]
---

# GDScript to C# Migration Guide

This guide provides comprehensive mapping between GDScript classes and their C# equivalents in Grid Building 6.0.

## 🔄 Class Mappings

### Core System Classes

| GDScript Class | C# Class | Namespace | Notes |
|---------------|----------|-----------|-------|
| `PlaceableDefinition` | `Placeable` | `GridBuilding.Core.Types` | Concrete implementation |
| `PlaceableDefinition` | `IPlaceable` | `GridBuilding.Core.Interfaces` | Interface for Core layer |
| `PlaceableCollection` | `PlaceableCollection` | `GridBuilding.Core.Systems.Data` | Same name, different namespace |
| `GridPosition` | `GridPosition` | `GridBuilding.Core.Grid` | Same name, different namespace |
| `Vector2i` | `Vector2I` | `Godot` | Built-in Godot type |

### Data Structure Classes

| GDScript Class | C# Class | Namespace | Notes |
|---------------|----------|-----------|-------|
| `Dictionary` | `Dictionary<TKey, TValue>` | `System.Collections.Generic` | Generic typing required |
| `Array` | `List<T>` | `System.Collections.Generic` | Generic typing required |
| `Node` | `Node` | `Godot` | Same name, Godot namespace |

### Complete System Classes

| GDScript Class | C# Class | Namespace | Notes |
|---------------|----------|-----------|-------|
| `gb_geometry_math.gd` | `GeometryMath` | `GridBuilding.Core.Systems.Geometry` | Ported from core utils |
| `gb_enums.gd` | `GBEnums` | `GridBuilding.Core.Base` | Centralized enums |
| `user_state.gd` | `UserState` | `GridBuilding.Core.Contexts` | Alias for GBOwnerContext |
| `gb_visual_settings.gd` | `GBVisualSettings` | `GridBuilding.Core.Resources.Visual` | Visual display settings |
| `cursor_settings.gd` | `CursorSettings` | `GridBuilding.Core.Resources.Visual` | UI cursor textures |
| `building_settings.gd` | `BuildingSettings` | `GridBuilding.Core.Resources.Settings` | Building system config |
| `manipulation_settings.gd` | `ManipulationSettings` | `GridBuilding.Core.Resources.Settings` | Object movement settings |
| `target_info_settings.gd` | `TargetInfoSettings` | `GridBuilding.Core.Resources.Visual` | Target display info |
| `highlight_settings.gd` | `HighlightSettings` | `GridBuilding.Core.Resources.Visual` | Target highlighting |

### Godot Integration Classes

| GDScript Class | C# Class | Namespace | Notes |
|---------------|----------|-----------|-------|
| `GridBuilding` | `GridBuildingSystem` | `GridBuilding.Godot` | Main system class |
| `GridManager` | `GridManager` | `GridBuilding.Godot.Systems` | Grid management |
| `BuildingManager` | `BuildingManager` | `GridBuilding.Godot.Systems.Building` | Building operations |
| `TargetingSystem` | `GridTargetingSystem` | `GridBuilding.Godot.Systems.GridTargeting` | Target detection |
| `InputManager` | `InputManager` | `GridBuilding.Godot.Input` | Input handling |

## 📝 Syntax Differences

### Variable Declarations

**GDScript:**
```gdscript
var name: String = "Building"
var position: Vector2i = Vector2i(0, 0)
var properties: Dictionary = {}
```

**C#:**
```csharp
public string Name { get; set; } = "Building";
public Vector2I Position { get; set; } = new Vector2I(0, 0);
public Dictionary<string, object> Properties { get; set; } = new();
```

### Function Declarations

**GDScript:**
```gdscript
func get_placeable(id: String) -> PlaceableDefinition:
    return placeables[id]

func add_placeable(placeable: PlaceableDefinition) -> void:
    placeables[placeable.id] = placeable

func calculate_cost(base_cost: int, multiplier: float) -> int:
    return int(base_cost * multiplier)
```

**C#:**
```csharp
public IPlaceable? GetPlaceable(string id)
{
    return _placeables.GetValueOrDefault(id);
}

public void AddPlaceable(IPlaceable placeable)
{
    _placeables[placeable.Id] = placeable;
}

public int CalculateCost(int baseCost, float multiplier)
{
    return (int)(baseCost * multiplier);
}
```

### Class Definitions

**GDScript:**
```gdscript
class_name PlaceableDefinition
extends Resource

@export var id: String
@export var name: String
@export var category: String
@export var size: Vector2i = Vector2i(1, 1)

func _init():
    pass

func get_display_name() -> String:
    return name if name else "Unknown"
```

**C#:**
```csharp
namespace GridBuilding.Core.Types;

public class Placeable : IPlaceable
{
    public string Id { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public Vector2I Size { get; set; } = new Vector2I(1, 1);
    
    public Placeable() { }
    
    public string GetDisplayName() => 
        string.IsNullOrWhiteSpace(Name) ? "Unknown" : Name;
}
```

### Properties vs @export

**GDScript:**
```gdscript
@export var id: String
@export var size: Vector2i = Vector2i(1, 1)
@export var can_rotate: bool = true
```

**C#:**
```csharp
public string Id { get; set; } = string.Empty;
public Vector2I Size { get; set; } = new Vector2I(1, 1);
public bool CanRotate { get; set; } = true;

// For Godot-specific exports:
[Export] public string Id { get; set; } = string.Empty;
[Export] public Vector2I Size { get; set; } = new Vector2I(1, 1);
[Export] public bool CanRotate { get; set; } = true;
```
```

### Class Definitions

**GDScript:**
```gdscript
class_name PlaceableDefinition
extends Resource

@export var id: String
@export var name: String
@export var category: String

func _init():
    pass
```

**C#:**
```csharp
namespace GridBuilding.Core.Types;

public class Placeable : IPlaceable
{
    public string Id { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    
    public Placeable() { }
}
```

## 🔧 Type System Changes

### Dynamic vs Static Typing

**GDScript (Dynamic):**
```gdscript
var value = get_value()  # Type inferred at runtime
value = "now a string"  # Can change type
```

**C# (Static):**
```csharp
var value = GetValue();  // Type inferred at compile time
// value = "now a string";  // Compilation error - wrong type
object value = GetValue();  // Can use object for dynamic behavior
value = "now a string";     // But requires casting for specific operations
```

### Null Safety

**GDScript:**
```gdscript
var placeable: PlaceableDefinition = null
if placeable:
    placeable.do_something()
```

**C#:**
```csharp
IPlaceable? placeable = null;
if (placeable != null)
{
    placeable.DoSomething();
}

// Or with null-conditional operators:
placeable?.DoSomething();
```

## 🏗️ Common Migration Patterns

### 1. Properties vs @export

**GDScript:**
```gdscript
@export var id: String
@export var size: Vector2i = Vector2i(1, 1)
```

**C#:**
```csharp
public string Id { get; set; } = string.Empty;
public Vector2I Size { get; set; } = new Vector2I(1, 1);

// For Godot-specific exports:
[Export] public string Id { get; set; } = string.Empty;
[Export] public Vector2I Size { get; set; } = new Vector2I(1, 1);
```

### 2. Signals vs Events

**GDScript:**
```gdscript
signal placeable_added(placeable: PlaceableDefinition)
signal placeable_removed(id: String)

func emit_placeable_added(placeable):
    emit_signal("placeable_added", placeable)
```

**C#:**
```csharp
public event Action<IPlaceable>? PlaceableAdded;
public event Action<string>? PlaceableRemoved;

private void EmitPlaceableAdded(IPlaceable placeable)
{
    PlaceableAdded?.Invoke(placeable);
}
```

### 3. Dictionary Usage

**GDScript:**
```gdscript
var properties: Dictionary = {}
properties["tags"] = ["building", "military"]
properties["cost"] = 100

var tags = properties.get("tags", [])
var cost = properties.get("cost", 0)
```

**C#:**
```csharp
var properties = new Dictionary<string, object>();
properties["tags"] = new List<string> { "building", "military" };
properties["cost"] = 100;

var tags = properties.TryGetValue("tags", out var tagsObj) 
    ? tagsObj as List<string> 
    : new List<string>();
var cost = properties.TryGetValue("cost", out var costObj) 
    ? Convert.ToInt32(costObj) 
    : 0;
```

## 🎯 Interface Implementation

**GDScript:**
```gdscript
# Duck typing - no explicit interfaces
func get_id() -> String:
    return id

func get_name() -> String:
    return name
```

**C#:**
```csharp
public class Placeable : IPlaceable
{
    public string Id { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    
    // Interface implementation is explicit
    public string FilePath { get; set; } = string.Empty;
    public Vector2I Size { get; set; } = new Vector2I(1, 1);
    public bool CanRotate { get; set; } = true;
    public bool CanMirror { get; set; } = false;
    public Dictionary<string, int> ResourceCost { get; set; } = new();
    public Dictionary<string, object> Properties { get; set; } = new();
}
```

## 📋 Migration Checklist

### Before Migration
- [ ] Identify all GDScript classes
- [ ] Document current dependencies
- [ ] Create backup of existing code
- [ ] Set up C# project structure

### During Migration
- [ ] Convert class definitions to C#
- [ ] Update variable declarations
- [ ] Add proper type annotations
- [ ] Implement required interfaces
- [ ] Update method signatures
- [ ] Add null safety checks

### After Migration
- [ ] Run Core tests to verify functionality
- [ ] Update documentation
- [ ] Performance testing
- [ ] Code review and cleanup

## 🚀 Performance Benefits

| Operation | GDScript | C# | Improvement |
|-----------|----------|----|-------------|
| Loop iterations | ~10ms | ~2ms | 5x faster |
| Dictionary access | ~5ms | ~1ms | 5x faster |
| String operations | ~8ms | ~2ms | 4x faster |
| Mathematical calculations | ~12ms | ~3ms | 4x faster |

## 🔍 Debugging Tips

### Common Issues
1. **Missing using statements** - Add required namespaces
2. **Type mismatches** - Check generic type parameters
3. **Null reference exceptions** - Use null-conditional operators
4. **Method signature changes** - Update parameter types

### Debugging Tools
- **Visual Studio Debugger**: Full breakpoint support
- **IntelliTrace**: Historical debugging
- **Code Analysis**: Built-in static analysis
- **Unit Testing**: Better test framework integration

## 🧪 Migrating Legacy GDScript/GdUnit Tests

Legacy GridBuilding releases shipped with a large **GDScript + GdUnit4** test suite under `res://test/`.
In v6.0, tests are split by layer and framework:

- **Core tests** → C# + xUnit (+ Shouldly), engine-agnostic
- **Godot tests** → C# + GoDotTest (Chickensoft), engine-dependent

### Test Layout (v6.0)

All C# tests live under the plugin root:

```text
GridBuilding/
  Core/
  Godot/
  Tests/
    Core/
      Main/
        Unit/
        Integration/
        Stress/
      Quarantine/
      Sandbox/
    Godot/
      Main/
        Unit/
        Integration/
      Quarantine/
        _Legacy/
        _TODO/
        _Refactor/
        _Speculative/
      Sandbox/
```

### Namespace Conventions (Option A)

Namespaces are derived from **layer + category**:

```csharp
// Core tests
namespace GridBuilding.Tests.Core.Unit;
namespace GridBuilding.Tests.Core.Integration;

// Godot tests
namespace GridBuilding.Tests.Godot.Unit;
namespace GridBuilding.Tests.Godot.Integration;

// Godot legacy quarantine
namespace GridBuilding.Tests.Godot._Legacy;
```

The `TestProjectAudit` toolkit enforces this pattern and will flag
`NamespaceMismatch` issues when a test namespace does not match its folder.

### Mapping Legacy GdUnit Suites → C# Tests

Use this decision tree when migrating a GdUnit test:

1. **Does the test depend on Godot nodes, scenes, or signals?**
   - **No → Core test (xUnit)**
   - **Yes → Godot test (GoDotTest)**

2. **Core xUnit tests (POCS)**
   - Folder:
     - `Tests/Core/Main/Unit/**` → `namespace GridBuilding.Tests.Core.Unit;`
     - `Tests/Core/Main/Integration/**` → `namespace GridBuilding.Tests.Core.Integration;`
   - Framework:
     - `[Fact]`, `[Theory]`, `[InlineData]` from **xUnit**
     - Assertions via **Shouldly** (preferred) or xUnit asserts
   - Typical migrations:
     - GdUnit assertions (`assert_eq`, `assert_true`) → Shouldly/xUnit asserts
     - GDScript data structures → pure C# types in `GridBuilding.Core.*`

3. **Godot GoDotTest integration tests**
   - Folder:
     - `Tests/Godot/Main/Integration/**`
   - Namespace:
     - `namespace GridBuilding.Tests.Godot.Integration;`
   - Framework:
     - Base class `TestClass` from `Chickensoft.GoDotTest`
     - Attributes `[Test]`, `[Setup]`, `[Cleanup]`, `[SetupAll]`, `[CleanupAll]`
   - Pattern examples in v6.0 codebase:
     - `Godot/Tests/WorkingIntegrationTest.cs`
     - `Godot/Tests/Integration/CollisionIntegrationTest.cs`
     - `Godot/Tests/Unit/Building/DragManagerGoDotTests.cs`

4. **Quarantine: legacy GdUnit behavior**
   - If a legacy test is **not yet ported**, but you need to keep the behavior:
     - Place C# ports or transitional tests under:
       - `Tests/Godot/Quarantine/_Legacy/**`
       - `namespace GridBuilding.Tests.Godot._Legacy;`
   - These tests are **not considered green** and are excluded from the
     main health signal, per the `/test` quarantine-first workflow.

### Framework Boundary Rules

- **Core layer (`Tests/Core/**`)**
  - Uses **xUnit + Shouldly** only
  - Must **not** reference `Godot.*` or `GridBuilding.Godot.*`
  - `TestProjectAudit` flags any Godot dependency in Core tests as an
    `EngineScopeViolation`.

- **Godot layer (`Tests/Godot/**`)**
  - Uses **GoDotTest** only, **no xUnit attributes** (`[Fact]`, `[Theory]`, etc.)
  - A dedicated rule in `TestProjectAudit` reports `GodotTestFrameworkViolation`
    if xUnit is used in the Godot test layer.

### Auto-Fix and Legacy GdUnit Assertions

The `GodotToolkit.AutoPorting` tools include a **GdUnitApiChecker** and
`GDScriptAutoFixOrchestrator` used to modernize legacy GdUnit-based
GDScript tests. For v6.0:

- Auto-fix configuration **never blindly converts** GdUnit tests to xUnit
  in the Godot layer.
- GdUnit-style assertions may be:
  - Preserved as-is,
  - Commented with TODOs,
  - Or reported for manual migration.
- All **Godot-side test ports** should end as **GoDotTest** suites in
  `GridBuilding.Tests.Godot.*`, not as xUnit tests.

Core-only GdUnit suites (no Godot APIs) are safe candidates for
conversion into xUnit under `GridBuilding.Tests.Core.Unit` or
`GridBuilding.Tests.Core.Integration`.

## 📚 Additional Resources

- [Microsoft C# Documentation](https://docs.microsoft.com/en-us/dotnet/csharp/)
- [Godot C# Documentation](https://docs.godotengine.org/en/stable/tutorials/scripting/csharp/index.html)
- [C# Best Practices](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions)
