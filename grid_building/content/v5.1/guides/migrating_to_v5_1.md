---
title: "v5.0 to v5.1 Migration Guide"
description: "Upgrading your GridBuilding plugin from GDScript-based v5.0 to the new C#-based v5.1 architecture"
weight: 85
menu:
  v5_1_main:
    parent: "guides"
    weight: 85
---

# Migrating to GridBuilding v5.1 (C#)

This guide helps you upgrade your project from GridBuilding v5.0 (GDScript-based) to v5.1 (pure C# architecture). The new architecture provides significant performance and reliability improvements.

## 🎯 What's Changing?

GridBuilding v5.1 introduces a **Service-Based Architecture** written in pure C#. This change affects how you interact with the plugin's core systems, but the Godot-facing API (nodes, resources, signals) remains familiar.

| Component | v5.0 (GDScript) | v5.1 (C#) | Benefit |
|-----------|----------------|-----------|---------|
| **State Objects** | Godot Resources | Pure C# Classes | Significantly faster test execution [internal testing] |
| **Core Systems** | Godot Nodes | Service Classes | Compile-time type safety |
| **Data Objects** | Godot Resources | C# Classes | Better encapsulation |
| **UI Components** | Godot Nodes | Godot Nodes | No change |

## 🔄 Key Architectural Changes

### State Management
State objects are no longer Godot Resources. They are now pure C# classes, which means:
- **Faster Access**: No Godot overhead for state operations
- **Better Testing**: States can be tested without Godot
- **Type Safety**: Compile-time error checking

### Service Layer
Business logic is now handled by dedicated Service classes:
- **BuildingService**: Manages build operations
- **ManipulationService**: Handles object transformations
- **InputService**: Processes user input

### Communication Pattern
The new architecture uses a strict unidirectional flow:
1.  **Godot Layer** calls **Service** methods
2.  **Service** updates **State**
3.  **Service** fires **Events**
4.  **Godot Layer** listens to **Events** and updates visuals

## 📋 Migration Checklist

### Before You Start
- [ ] **Backup your project**
- [ ] **Note any custom modifications** to GridBuilding scripts
- [ ] **Disable GridBuilding plugin** temporarily

### Migration Steps

#### 1. Update Plugin
1.  Remove the old GridBuilding plugin folder
2.  Install the new GridBuilding v5.1 plugin
3.  Re-enable the plugin in Godot settings

#### 2. Update Your Code
**Most of your code will work without changes**, but check these areas:

**State Access (If Directly Accessed)**
```gdscript
# Old v5.0 way (if you accessed state directly)
var state = $GridBuilding.get_state()
state.set_current_placeable(my_placeable)

# New v5.1 way (use the service API)
$GridBuilding.enter_build_mode(my_placeable)
```

**Custom Signals**
```gdscript
# Old v5.0 way
$GridBuilding.connect("building_placed", self, "_on_building_placed")

# New v5.1 way (signals remain the same)
$GridBuilding.building_placed.connect(_on_building_placed)
```

#### 3. Verify Functionality
- [ ] Test basic building placement
- [ ] Test manipulation (move/rotate/delete)
- [ ] Check custom UI integration
- [ ] Verify save/load functionality

## 🚀 Performance Benefits You'll See

- **Faster Build Mode**: Entering build mode is significantly faster [internal testing]
- **Smoother UI**: State updates no longer block the main thread
- **Better Error Messages**: Compile-time errors catch issues early
- **Improved Stability**: Strong typing prevents many runtime errors

## 🛠️ Common Migration Issues

### Issue: "Can't find state property"
**Cause**: Direct state access is no longer supported.
**Solution**: Use the service API methods instead.

### Issue: Custom scripts don't compile
**Cause**: API changes in core systems.
**Solution**: Check the [API Reference](/v5.1/api/) for updated method signatures.

### Issue: Performance seems slower
**Cause**: First-time C# compilation overhead.
**Solution**: This is normal. Performance improves after the initial run.

## 📞 Getting Help

If you encounter issues during migration:
1.  **Check the API Reference** for updated methods
2.  **Review the Service Architecture** guide
3.  **Ask in the community** for help from other developers

## 🎉 You're Done!

After migration, you'll have a more robust, faster, and maintainable GridBuilding system. The new C# foundation enables future features and better performance.

---

**For detailed technical changes**, see the [Class Mapping Documentation](../../../../plugins/GridBuilding/docs/CLASS_MAPPING_DOCUMENTATION.md) in the plugin repository.
