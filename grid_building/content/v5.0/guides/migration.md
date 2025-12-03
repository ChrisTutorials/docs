---
title: Migration Guide
description: Complete migration guide for upgrading from Grid Building v4.x to v5.0.0
---


## Prerequisites

- **Godot 4.4.x or later** (4.5 compatible)
- **Backup your project** before upgrading
- **Export current settings** to .tres files (see Step 1 below)

---

## Step-by-Step Migration

### Step 1: Export Existing Configuration

Before upgrading, save your current configuration as .tres resources:

**Save These Resources:**
```gdscript
# Visual and UI templates
@export var indicator_templates: Array[PackedScene] 
@export var ui_templates: Array[PackedScene]

# Settings resources  
@export var targeting_settings: GridTargetingSettings
@export var building_settings: BuildingSettings
@export var manipulation_settings: ManipulationSettings
@export var action_log_settings: ActionLogSettings

# Actions and input configuration
@export var actions: GBActions
@export var messages: GBMessages
```

**How to Save:**
1. Select nodes with these exported properties in the editor
2. Click the dropdown next to each resource property
3. Choose "Save As..." and save to `res://config/` or `res://data/`
4. Name files descriptively: `targeting_settings.tres`, `building_settings.tres`, etc.

### Step 2: Upgrade Plugin

1. **Install Grid Building v5.0.0** through your usual plugin update method
2. **Restart Godot Editor** to ensure proper loading
3. **Verify compatibility** - check console for any immediate errors

### Step 3: Set Up Dependency Injection

#### Add GBInjectorSystem to Your Scene

Add a [GBInjectorSystem](../api/GBInjectorSystem/) node to your **gameplay scene** (where building actually happens):

```gdscript
# Scene structure example:
GameplayScene (Node)
├── Player (Node2D)
├── World (Node2D)
├── UI (Control)
└── GBInjectorSystem (GBInjectorSystem)  # ← Add this
```

#### Create Composition Container

1. **Create new resource**: Right-click in FileSystem → New Resource → [GBCompositionContainer](../api/GBCompositionContainer/)
2. **Save as**: `res://config/gb_container.tres`
3. **Assign to injector**: Set the `composition_container` property on your [GBInjectorSystem](../api/GBInjectorSystem/)

#### Configure GBConfig

Inside your [GBCompositionContainer](../api/GBCompositionContainer/):

1. **Create GBConfig**: Set the `config` property to a new [GBConfig](../api/GBConfig/) resource
2. **Assign saved settings**: Restore your .tres files from Step 1:

```gdscript
# In GBConfig resource:
├── settings (GBSettings)
│   ├── targeting: your_targeting_settings.tres
│   ├── building: your_building_settings.tres  
│   ├── manipulation: your_manipulation_settings.tres
│   ├── action_log: your_action_log_settings.tres
│   └── ... (other settings)
├── templates (GBTemplates)
│   ├── rule_check_indicator: your_indicator_template.tscn
│   └── ... (other templates)
└── actions: your_actions.tres
```

### Step 4: Update Owner Context

The owner context API changed. You must now set a [GBOwner](../api/GBOwner/):

```gdscript
# Old way (v4.x) - no longer works
# Systems automatically knew about ownership

# New way (v5.0.0) - explicit owner setup
extends Node

@export var player_character: Node2D
@export var injector: GBInjectorSystem

func _ready():
    # Create and register owner
    var owner := GBOwner.new()
    owner.owner_name = "Player"
    owner.owner_node = player_character
    
    # Set in context (available to all systems)
    GBOwnerContext.set_owner(owner)
```

### Step 5: Verify and Validate

Add validation to catch migration issues:

```gdscript
extends Node

@export var injector: GBInjectorSystem

func _ready():
    if injector:
        # Automatic validation in v5.0.0
        var validation_passed := injector.run_validation()
        
        if not validation_passed:
            # Check detailed issues
            var issues := injector.get_runtime_issues()
            for issue in issues:
                print("Migration Issue: ", issue)
    else:
        push_warning("GBInjectorSystem not assigned")
```

---

## Breaking Changes Reference

### Major API Changes

| Category | Old (v4.x) | New (v5.0.0) | Migration Notes |
|----------|------------|--------------|-----------------|
| **Dependency Injection** | Direct instantiation | [GBCompositionContainer](../api/GBCompositionContainer/) + [GBInjectorSystem](../api/GBInjectorSystem/) | Use injection pattern for all systems |
| **Configuration** | Scattered exports | [GBConfig](../api/GBConfig/) resource | Consolidate all settings into config |
| **Owner Context** | Automatic | `GBOwnerContext.set_owner()` | Explicit owner registration required |
| **Validation** | Manual `validate()` calls | Automatic via injector | Remove manual validation code |
| **Drag Manager** | `DragBuildManager` | [DragManager](../api/DragManager/) | Rename class, add `is_dragging()` check |
| **Tile API** | `TileMap` | `TileMapLayer` | Update for Godot 4.4+ compatibility |

### Common Migration Patterns

#### System Instantiation
```gdscript
# Old (v4.x)
var building_system = BuildingSystem.new()
building_system.settings = my_settings
add_child(building_system)

# New (v5.0.0) 
# Systems are automatically instantiated and configured via injector
# Just ensure your GBInjectorSystem is set up properly
```

#### Validation Workflow
```gdscript
# Old (v4.x)
func _ready():
    building_system.validate()
    targeting_system.validate()
    if not systems_valid:
        handle_validation_errors()

# New (v5.0.0)
func _ready():
    # Validation happens automatically
    var all_valid := injector.run_validation()
    if not all_valid:
        var issues := injector.get_runtime_issues()
        handle_issues(issues)
```

#### Configuration Access
```gdscript
# Old (v4.x)
@export var targeting_settings: GridTargetingSettings

func _ready():
    if targeting_settings:
        configure_targeting(targeting_settings)

# New (v5.0.0)
# Settings are automatically injected via resolve_gb_dependencies()
# No manual configuration needed
```

---

## Troubleshooting

### Common Issues

**"No GBOwner found" errors:**
- Ensure you call `GBOwnerContext.set_owner()` in `_ready()`
- Verify the owner object is created before systems initialize

**"Missing configuration" warnings:**
- Check that all .tres resources are properly assigned in [GBConfig](../api/GBConfig/)
- Verify [GBCompositionContainer](../api/GBCompositionContainer/) is assigned to [GBInjectorSystem](../api/GBInjectorSystem/)

**Systems not responding to input:**
- Ensure [GBInjectorSystem](../api/GBInjectorSystem/) is added to the correct scene
- Verify `injection_roots` property covers your game objects
- Check that systems are in the scene tree under injection roots

**Placeable objects not working:**
- Placeable resources should work unchanged
- Verify [Placeable](../api/Placeable/) resources are properly loaded
- Check UI components are correctly wired to selection systems

### Validation Commands

Test your migration with these validation helpers:

```gdscript
# Check injector status
print("Injector valid: ", injector.run_validation())

# Get detailed issues
var issues := injector.get_runtime_issues()
for issue in issues:
    print("Issue: ", issue)

# Check specific systems
var building_system = injector.get_building_system()
if building_system:
    print("Building system issues: ", building_system.get_runtime_issues())
```

---

## Migration Checklist

- [ ] **Backup project** and export current settings to .tres files
- [ ] **Install Grid Building v5.0.0** and restart editor  
- [ ] **Add GBInjectorSystem** to gameplay scene
- [ ] **Create GBCompositionContainer** resource and assign to injector
- [ ] **Create GBConfig** and restore saved settings
- [ ] **Update owner context** with `GBOwnerContext.set_owner()`
- [ ] **Remove manual validation** calls (now automatic)
- [ ] **Test building workflow** - place, move, rotate objects
- [ ] **Verify UI interactions** - menus, buttons, selection
- [ ] **Check console logs** for validation issues
- [ ] **Test in different modes** - build, select, targeting

---

## Additional Resources

- **[Breaking Changes](./breaking-changes/)** - Detailed API changes
- **[Dependency Injection Guide](./dependency-injection/)** - DI system deep dive
- **[Configuration Guide](./configuration-and-settings/)** - GBConfig structure
- **[Project Architecture](./project-architecture/)** - System relationships
- **[API Reference](../api/)** - Complete API documentation

---

## Getting Help

If you encounter issues during migration:

1. **Check validation output** using the commands above
2. **Review breaking changes** for specific API updates
3. **Compare with demo scenes** in the plugin examples
4. **Ask for help** in the project repository discussions

The migration introduces powerful new features while maintaining the core building experience. Once complete, you'll have better organized, more maintainable code with automatic validation and dependency management.