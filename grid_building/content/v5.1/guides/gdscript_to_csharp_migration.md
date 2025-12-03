---
title: "GDScript to C# Migration Guide"
description: "Comprehensive patterns and best practices for migrating Godot projects from GDScript to C#"
weight: 90
menu:
  v5_1_main:
    parent: "guides"
    weight: 90
---


This guide provides comprehensive patterns and best practices for migrating GDScript code to C#. It's based on real-world migration experience and covers common scenarios, type mappings, and architectural considerations.

## Quick Reference

### Basic Type Mappings

| GDScript | C# | Notes |
|----------|----|-------|
| `String` | `string` | Direct mapping |
| `int` | `int` | Direct mapping |
| `float` | `float` | Direct mapping |
| `bool` | `bool` | Direct mapping |
| `Vector2` | `Vector2` | Godot type |
| `Vector3` | `Vector3` | Godot type |
| `Array` | `T[]` or `List<T>` | Use specific type |
| `Dictionary` | `Dictionary<TKey, TValue>` | Specify key/value types |
| `PackedVector2Array` | `Vector2[]` | Convert to array |
| `PackedStringArray` | `string[]` | Convert to array |
| `Node` | `Node` | Godot type |
| `RefCounted` | `RefCounted` | Godot type |

### Class Declaration Mappings

#### GDScript
```gdscript
class_name MyClass
extends RefCounted

var my_property: String = "value"

func my_method(param: int) -> bool:
    return param > 0
```

#### C#
```csharp
public partial class MyClass : RefCounted
{
    public string MyProperty { get; set; } = "value";

    public bool MyMethod(int param)
    {
        return param > 0;
    }
}
```

## Migration Patterns

### 1. Static Utility Classes

#### GDScript
```gdscript
class_name GeometryUtils
extends RefCounted

static func get_tile_polygon(tile_pos: Vector2, tile_size: Vector2) -> PackedVector2Array:
    return PackedVector2Array([
        tile_pos,
        tile_pos + Vector2(tile_size.x, 0),
        tile_pos + Vector2(tile_size.x, tile_size.y),
        tile_pos + Vector2(0, tile_size.y)
    ])
```

#### C#
```csharp
public static class GeometryUtils
{
    public static Vector2[] GetTilePolygon(Vector2 tilePos, Vector2 tileSize)
    {
        return new[]
        {
            tilePos,
            tilePos + new Vector2(tileSize.X, 0),
            tilePos + new Vector2(tileSize.X, tileSize.Y),
            tilePos + new Vector2(0, tileSize.Y)
        };
    }
}
```

### 2. Signal to Event Conversion

#### GDScript
```gdscript
class_name EventEmitter
extends RefCounted

signal data_changed(new_value: int)
signal action_completed(success: bool, message: String)

func trigger_change(value: int):
    data_changed.emit(value)
```

#### C# (Godot Signals - Recommended)
```csharp
public partial class EventEmitter : RefCounted
{
    [Signal]
    public delegate void DataChangedEventHandler(int newValue);
    
    [Signal]
    public delegate void ActionCompletedEventHandler(bool success, string message);

    public void TriggerChange(int value)
    {
        EmitSignal(SignalName.DataChanged, value);
    }
}
```

### 3. Properties vs. Variables

#### GDScript
```gdscript
var health: int = 100
setget health_set, health_get

func health_set(value: int):
    health = clamp(value, 0, max_health)

func health_get() -> int:
    return health
```

#### C#
```csharp
private int _health = 100;

public int Health
{
    get => _health;
    set => _health = Mathf.Clamp(value, 0, MaxHealth);
}
```

## Architectural Considerations

### State Management
- **GDScript**: Often uses `Resource` classes for shared state
- **C#**: Consider pure C# classes for better testability

### Error Handling
- **GDScript**: Uses `assert()` and returns `null` on failure
- **C#**: Use exceptions and `Result<T>` patterns for better error management

### Performance
- **GDScript**: Dynamic typing, interpreted
- **C#**: Static typing, compiled - generally faster for computation-heavy code

## Common Pitfalls to Avoid

1.  **Forgetting `partial` keyword** for Godot-derived classes
2.  **Using `null` instead of `null`** (C# is case-sensitive)
3.  **Not specifying array types** - use `T[]` or `List<T>`
4.  **Mixing GDScript and C# signals** - stick to one pattern per class
5.  **Ignoring Godot's `[Export]` attribute** for editor-exposed properties

## Testing Your Migration

1.  **Start with small, isolated classes** (utility classes are perfect)
2.  **Test each converted class individually**
3.  **Pay special attention to signal connections**
4.  **Verify editor-exposed properties work correctly**
5.  **Run performance tests for critical code paths**

This guide will evolve as we encounter more migration scenarios. Check back for updates and additional patterns.
