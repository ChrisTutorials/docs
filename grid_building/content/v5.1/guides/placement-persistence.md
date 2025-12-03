---
title: 'Placement Persistence'
description: 'Complete guide to saving and loading placed objects using metadata-based persistence'
---


---


## Overview

**Placement Persistence** allows you to save and reload all objects placed by the building system, recreating the exact state of your game world even if those objects don't exist in the base starting scene. This enables complete save/load systems, level editors, and persistent world states.

**Purpose:** When players build structures in your game, those placements need to persist across game sessions. The placement persistence system tracks which objects were placed, stores their configuration, and recreates them identically when loading a saved game.

<Aside type="note" title="New in v5.1">
The placement persistence system was completely rewritten in **v5.1** to use lightweight **metadata** instead of component nodes. This makes it faster, more transparent, and easier to use.

**Previous approach (v5.0):** Hidden [PlaceableInstance](../api/PlaceableInstance/) component nodes  
**New approach (v5.1+):** Lightweight metadata with [GBPlacementPersistence](../api/GBPlacementPersistence/) utility
</Aside>

## What is Placement Persistence?

When players place objects using the building system, those objects need to be:
1. **Tracked** - Identified as "placed by player" vs "part of original scene"
2. **Saved** - Serialized with enough data to recreate them later
3. **Loaded** - Recreated from save data when loading a level

The **metadata-based approach** stores placement information directly on each placed node using Godot's metadata system.

## How It Works

### Automatic Marking

When you place an object through [BuildingSystem](../api/BuildingSystem/), it's **automatically marked** with metadata:

```gdscript
# This happens automatically when you place an object
var placed_node = building_system.place_buildable(placeable)
# placed_node now has metadata: { "gb_placement": { "placeable_path": "res://..." } }
```

### The Metadata Key

Every placed object gets a metadata entry:

```gdscript
# Metadata key
"gb_placement"

# Metadata value (Dictionary)
{
    "placeable_path": "res://placeables/tower.tres"
}
```

This tells the system:
- ✅ This object was placed by the building system
- ✅ It can be recreated from this placeable resource
- ✅ It should be included in save/load operations

## Viewing Placement Metadata

### In Godot Editor

You can view placement metadata using Godot's inspector:

1. **Install a metadata viewer plugin** (search Asset Library for "metadata inspector")
2. **Select a placed object** in the scene tree
3. **View the Inspector** - look for "Metadata" section
4. **Find `gb_placement` key** with the placeable path

### In Code

```gdscript
# Check if object is marked as placed
if node.has_meta("gb_placement"):
    var placement_data = node.get_meta("gb_placement")
    print("Placed from: ", placement_data["placeable_path"])
```

## Using the GBPlacementPersistence API

The [GBPlacementPersistence](../api/GBPlacementPersistence/) class provides all placement persistence functionality through static methods.

### Checking Placement Status

```gdscript
# Check if a node was placed by the building system
if GBPlacementPersistence.is_placed(node):
    print("This was placed by the player")
else:
    print("This is part of the original scene")

# Check if a node is a preview (not a real placement)
if GBPlacementPersistence.is_preview(node):
    print("This is just a preview, don't save it")
```

### Manual Marking (Advanced)

You can manually mark objects as placed:

```gdscript
# Mark an object as placed
var placeable = load("res://placeables/tower.tres") as Placeable
GBPlacementPersistence.mark_as_placed(my_node, placeable)

# Mark as preview (temporary, don't save)
GBPlacementPersistence.mark_as_preview(preview_node)

# Unmark a node
GBPlacementPersistence.unmark(node)
```

### Getting Placeable from Node

```gdscript
# Get the original placeable resource
var placeable: Placeable = GBPlacementPersistence.get_placeable(placed_node)
if placeable:
    print("This was placed from: ", placeable.display_name)
```

## Saving Placed Objects

### Save Single Object

```gdscript
func save_object(node: Node) -> Dictionary:
    if not GBPlacementPersistence.is_placed(node):
        return {}  # Not a placed object, skip
    
    # Get save data for this object
    var save_data: Dictionary = GBPlacementPersistence.save_placement_data(node)
    
    # save_data contains:
    # {
    #     "instance_name": "Tower_001",
    #     "transform": "Transform2D(...)",
    #     "placeable": "res://placeables/tower.tres"
    # }
    
    return save_data
```

### Save All Placed Objects

```gdscript
func save_level() -> Dictionary:
    # Get all placed objects under a root node
    var placed_objects: Array[Dictionary] = GBPlacementPersistence.save_all_placements(level_root)
    
    # placed_objects is an array of save data dictionaries
    # Preview objects are automatically excluded
    
    var level_save = {
        "version": "1.0",
        "placed_objects": placed_objects
    }
    
    return level_save
```

### Complete Save Example

```gdscript
class_name Level
extends Node2D

@export var objects_parent: Node2D  # Where placed objects live

func save_to_file(filepath: String) -> void:
    # Get all placement data
    var placements: Array[Dictionary] = GBPlacementPersistence.save_all_placements(objects_parent)
    
    # Create save data structure
    var save_data = {
        "version": "1.0",
        "level_name": name,
        "placements": placements
    }
    
    # Write to file
    var file = FileAccess.open(filepath, FileAccess.WRITE)
    if file:
        file.store_var(save_data)
        file.close()
        print("Level saved with %d placed objects" % placements.size())
```

## Loading Placed Objects

### Load Single Object

```gdscript
func load_object(save_data: Dictionary, parent: Node) -> Node:
    # Instantiate from save data
    var instance: Node = GBPlacementPersistence.instance_from_save(save_data, parent)
    
    if instance:
        print("Loaded: ", instance.name)
        return instance
    else:
        push_error("Failed to load object from save data")
        return null
```

### Load All Placed Objects

```gdscript
func load_level(save_data_array: Array[Dictionary], parent: Node) -> void:
    # Load all placements at once
    GBPlacementPersistence.load_all_placements(save_data_array, parent)
    
    print("Loaded %d placed objects" % save_data_array.size())
```

### Complete Load Example

```gdscript
class_name Level
extends Node2D

@export var objects_parent: Node2D  # Where to spawn loaded objects

func load_from_file(filepath: String) -> void:
    # Read save file
    var file = FileAccess.open(filepath, FileAccess.READ)
    if not file:
        push_error("Could not open save file: " + filepath)
        return
    
    var save_data = file.get_var()
    file.close()
    
    # Clear existing placed objects
    _clear_placed_objects()
    
    # Load placements
    var placements: Array[Dictionary] = save_data.get("placements", [])
    GBPlacementPersistence.load_all_placements(placements, objects_parent)
    
    print("Level loaded: %d objects restored" % placements.size())

func _clear_placed_objects() -> void:
    # Remove all placed objects (but not original scene objects)
    var placed = GBPlacementPersistence.get_placed_objects(objects_parent)
    for node in placed:
        node.queue_free()
```

## Advanced Usage

### Filtering Placed Objects

```gdscript
# Get all placed objects under a root
var all_placed: Array[Node] = GBPlacementPersistence.get_placed_objects(root_node)

# Exclude preview objects (happens automatically in save_all_placements)
var real_placed: Array[Node] = []
for node in all_placed:
    if not GBPlacementPersistence.is_preview(node):
        real_placed.append(node)

# Filter by placeable type
var towers: Array[Node] = []
for node in all_placed:
    var placeable = GBPlacementPersistence.get_placeable(node)
    if placeable and placeable.display_name == "Tower":
        towers.append(node)
```

### Custom Save Data

You can extend the save data with custom fields:

```gdscript
func save_with_custom_data(node: Node) -> Dictionary:
    # Get base save data
    var save_data = GBPlacementPersistence.save_placement_data(node)
    
    # Add custom fields
    save_data["health"] = node.get("health") if node.has_method("get") else 100
    save_data["level"] = node.get("level") if node.has_method("get") else 1
    save_data["custom_data"] = {
        "color": Color.RED,
        "tags": ["enemy", "flying"]
    }
    
    return save_data

func load_with_custom_data(save_data: Dictionary, parent: Node) -> Node:
    # Load base object
    var instance = GBPlacementPersistence.instance_from_save(save_data, parent)
    
    if instance:
        # Apply custom data
        if save_data.has("health") and instance.has_method("set_health"):
            instance.set_health(save_data["health"])
        
        if save_data.has("level") and instance.has_method("set_level"):
            instance.set_level(save_data["level"])
        
        if save_data.has("custom_data"):
            instance.set_meta("custom_data", save_data["custom_data"])
    
    return instance
```

### Error Handling

```gdscript
func safe_save_placements(root: Node) -> Array[Dictionary]:
    var valid_saves: Array[Dictionary] = []
    
    var placed = GBPlacementPersistence.get_placed_objects(root)
    for node in placed:
        if GBPlacementPersistence.is_preview(node):
            continue  # Skip previews
        
        var save_data = GBPlacementPersistence.save_placement_data(node)
        
        # Validate save data
        if save_data.is_empty():
            push_warning("Skipping node with empty save data: " + node.name)
            continue
        
        if not save_data.has("placeable"):
            push_warning("Skipping node without placeable reference: " + node.name)
            continue
        
        valid_saves.append(save_data)
    
    return valid_saves

func safe_load_placements(save_data_array: Array[Dictionary], parent: Node) -> int:
    var loaded_count = 0
    
    for save_data in save_data_array:
        var instance = GBPlacementPersistence.instance_from_save(save_data, parent)
        if instance:
            loaded_count += 1
        else:
            push_warning("Failed to load placement: " + str(save_data.get("instance_name", "unknown")))
    
    return loaded_count
```

## Save Data Format

The save data format is intentionally simple for easy serialization:

```gdscript
{
    # The instance name in the scene tree
    "instance_name": "Tower_001",
    
    # Transform as string (for easy serialization)
    "transform": "Transform2D(1, 0, 0, 1, 100, 200)",
    
    # Resource path to the placeable (simple string, not dictionary)
    "placeable": "res://placeables/tower.tres"
}
```

### Why Simple Strings?

- ✅ **Easy to serialize** - Works with JSON, ConfigFile, or any text format
- ✅ **Human readable** - Can inspect and edit save files manually
- ✅ **Version safe** - Simple format is less likely to break between versions
- ✅ **Lightweight** - Minimal data overhead

## Best Practices

### 1. Always Exclude Previews

```gdscript
# ✅ Correct - Automatically excludes previews
var placements = GBPlacementPersistence.save_all_placements(root)

# ✅ Also correct - Manual filtering
var placed = GBPlacementPersistence.get_placed_objects(root)
for node in placed:
    if not GBPlacementPersistence.is_preview(node):
        var save_data = GBPlacementPersistence.save_placement_data(node)
```

### 2. Clear Before Loading

```gdscript
# ✅ Clear existing placements before loading new ones
func load_level(save_data: Array[Dictionary]) -> void:
    # Remove old placed objects
    var old_placed = GBPlacementPersistence.get_placed_objects(objects_parent)
    for node in old_placed:
        node.queue_free()
    
    # Wait for nodes to be removed
    await get_tree().process_frame
    
    # Load new placements
    GBPlacementPersistence.load_all_placements(save_data, objects_parent)
```

### 3. Validate Placeable Resources

```gdscript
# ✅ Ensure placeable resources exist before saving
func validate_placements(root: Node) -> Array[String]:
    var issues: Array[String] = []
    
    var placed = GBPlacementPersistence.get_placed_objects(root)
    for node in placed:
        var placeable = GBPlacementPersistence.get_placeable(node)
        if not placeable:
            issues.append("Node '%s' has invalid placeable reference" % node.name)
        elif not ResourceLoader.exists(placeable.resource_path):
            issues.append("Placeable resource missing: " + placeable.resource_path)
    
    return issues
```

### 4. Version Your Save Format

```gdscript
const SAVE_VERSION = "1.0"

func save_level() -> Dictionary:
    return {
        "version": SAVE_VERSION,
        "placements": GBPlacementPersistence.save_all_placements(level_root)
    }

func load_level(save_data: Dictionary) -> void:
    var version = save_data.get("version", "unknown")
    if version != SAVE_VERSION:
        push_warning("Save format version mismatch: " + version)
        # Handle migration if needed
    
    var placements = save_data.get("placements", [])
    GBPlacementPersistence.load_all_placements(placements, level_root)
```

## Common Patterns

### Auto-Save on Placement

```gdscript
func _ready() -> void:
    building_system.placed.connect(_on_object_placed)

func _on_object_placed(placed_node: Node) -> void:
    # Auto-save when player places something
    save_level()
```

### Undo/Redo Support

```gdscript
var placement_history: Array[Dictionary] = []
var history_index: int = -1

func on_place_object(node: Node) -> void:
    var save_state = GBPlacementPersistence.save_all_placements(level_root)
    
    # Add to history
    history_index += 1
    placement_history.resize(history_index + 1)
    placement_history[history_index] = {"placements": save_state}

func undo() -> void:
    if history_index > 0:
        history_index -= 1
        _restore_state(placement_history[history_index])

func redo() -> void:
    if history_index < placement_history.size() - 1:
        history_index += 1
        _restore_state(placement_history[history_index])

func _restore_state(state: Dictionary) -> void:
    var placed = GBPlacementPersistence.get_placed_objects(level_root)
    for node in placed:
        node.queue_free()
    
    await get_tree().process_frame
    GBPlacementPersistence.load_all_placements(state["placements"], level_root)
```

### Network Sync

```gdscript
# Server: Send placement updates to clients
func on_player_place_object(placed_node: Node) -> void:
    var save_data = GBPlacementPersistence.save_placement_data(placed_node)
    rpc("sync_placement", save_data)

@rpc("authority", "call_remote", "reliable")
func sync_placement(save_data: Dictionary) -> void:
    # Client: Recreate the placed object
    GBPlacementPersistence.instance_from_save(save_data, objects_parent)
```

## Troubleshooting

### "Save data is empty"

Check if the node is actually marked as placed:
```gdscript
if not GBPlacementPersistence.is_placed(node):
    push_error("Node is not marked as placed")
```

### "Failed to load placement"

Verify the placeable resource path exists:
```gdscript
var placeable_path = save_data["placeable"]
if not ResourceLoader.exists(placeable_path):
    push_error("Placeable resource not found: " + placeable_path)
```

### "Objects not saving"

Ensure you're calling save on the correct root node:
```gdscript
# ✅ Correct - Pass the parent that contains placed objects
var placements = GBPlacementPersistence.save_all_placements(objects_parent)

# ❌ Wrong - Passing the wrong node won't find placed objects
var placements = GBPlacementPersistence.save_all_placements(self)
```

### "Preview objects being saved"

The API automatically excludes previews, but verify:
```gdscript
var placed = GBPlacementPersistence.get_placed_objects(root)
for node in placed:
    if GBPlacementPersistence.is_preview(node):
        push_error("Preview leaked into placed objects list")
```

## Limitations and Advanced Considerations

### Resource Path Dependencies

The placement persistence system uses **resource paths** (`res://placeables/tower.tres`) to reference Placeable resources. This is standard Godot practice, but has implications:

**What happens if a Placeable is moved or renamed:**
- ❌ Save files with old paths will fail to load
- ❌ `ResourceLoader.exists()` returns false
- ❌ Placed objects cannot be recreated

**What happens if a Placeable is deleted:**
- ❌ Save files become invalid
- ❌ Load operations fail silently or with errors
- ❌ No automatic recovery mechanism

### Industry-Standard Recovery Strategies

**1. Resource Mapping/Migration System**
```gdscript
# Map old paths to new paths
const RESOURCE_MIGRATIONS = {
    "res://old/tower.tres": "res://new/tower.tres",
    "res://deleted/wall.tres": "res://replacement/wall.tres"
}

func load_with_migration(save_data: Dictionary) -> Node:
    var path = save_data["placeable"]
    if path in RESOURCE_MIGRATIONS:
        save_data["placeable"] = RESOURCE_MIGRATIONS[path]
    return GBPlacementPersistence.instance_from_save(save_data, parent)
```

**2. Custom UUID System (Beyond Plugin Scope)**

For production games requiring robust asset tracking:
- Assign custom UUIDs to each Placeable (separate from Godot's editor UIDs)
- Maintain a UUID → resource path registry
- Store UUIDs in save files instead of paths
- Rebuild registry on startup to handle moved files

```gdscript
# Example pattern (implement separately)
class_name PlaceableRegistry extends Node

var _uuid_to_path: Dictionary = {}

func register_placeable(uuid: String, path: String) -> void:
    _uuid_to_path[uuid] = path

func load_by_uuid(uuid: String) -> Placeable:
    var path = _uuid_to_path.get(uuid)
    return load(path) if path else null
```

**3. Validation on Save**

Check resource validity before saving:
```gdscript
func validate_before_save(root: Node) -> Array[String]:
    var warnings: Array[String] = []
    var placed = GBPlacementPersistence.get_placed_objects(root)
    
    for node in placed:
        var placeable = GBPlacementPersistence.get_placeable(node)
        if not placeable:
            warnings.append("Invalid placeable reference: " + node.name)
        elif not ResourceLoader.exists(placeable.resource_path):
            warnings.append("Missing resource: " + placeable.resource_path)
    
    return warnings
```

**4. Graceful Degradation**

Handle missing resources gracefully:
```gdscript
func load_with_fallback(save_data: Dictionary, parent: Node) -> Node:
    var instance = GBPlacementPersistence.instance_from_save(save_data, parent)
    
    if not instance:
        # Option A: Skip and log
        push_warning("Failed to load: " + str(save_data.get("instance_name")))
        
        # Option B: Spawn placeholder
        var placeholder = PlaceholderNode.new()
        placeholder.name = save_data.get("instance_name", "Missing")
        parent.add_child(placeholder)
        return placeholder
    
    return instance
```

### Why This Is Outside Plugin Scope

The Grid Building plugin provides **placement mechanics and basic persistence**. Full save/load systems require:
- Game-specific asset management strategies
- Custom serialization formats (JSON, binary, etc.)
- Version migration systems
- Error recovery policies
- Performance optimization for large worlds

These are **architectural decisions** that vary by project and should be implemented at the game level using the persistence API as a foundation.

### Recommendations for Production

- ✅ **Use version numbers** in save files for migration support
- ✅ **Validate Placeable existence** before saving
- ✅ **Log errors gracefully** when resources are missing
- ✅ **Consider asset bundling** (export only used Placeables)
- ✅ **Document resource dependencies** for your project
- ⚠️ **Don't rely on Godot Editor UIDs** - they're editor-only and don't export

## API Reference

See the [GBPlacementPersistence](../api/GBPlacementPersistence/) class documentation (to be generated) for complete method signatures and parameter details.

## Migration from PlaceableInstance

If you're migrating from v5.0 where you used the old [PlaceableInstance](../api/PlaceableInstance/) component, see the [Breaking Changes Guide](../migration/breaking-changes/) for step-by-step migration instructions.
