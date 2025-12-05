---
title: "C# State Integration with Godot Frontend"
date: 2025-12-01T17:11:00-05:00
draft: false
weight: 15
aliases: ["/latest/guides/csharp-state-integration/", "/gridbuilding/latest/guides/csharp-state-integration/"]
---


This guide explains how the C# backend states connect to the Godot frontend, maintaining GDScript compatibility while exposing necessary state information to Godot objects.

---

## 🏗️ Architecture Overview

### **Three-Layer State Architecture**

```
┌─────────────────────────────────────────────────────────────┐
│                    Godot Frontend                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │   UI Nodes  │  │   Systems   │  │   Scripts   │         │
│  └─────────────┘  └─────────────┘  └─────────────┘         │
└─────────────────────────────────────────────────────────────┘
                           │
                    ┌─────────────┐
                    │ State Bridge │  ← Godot-C# Interface Layer
                    └─────────────┘
                           │
┌─────────────────────────────────────────────────────────────┐
│                    C# Backend                                │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │   Services  │  │   Managers  │  │   States    │         │
│  └─────────────┘  └─────────────┘  └─────────────┘         │
└─────────────────────────────────────────────────────────────┘
```

### **Key Components**

1. **C# States** - Pure data containers (ModeState, BuildingState, UserState)
2. **State Services** - Business logic and state management
3. **State Bridge** - Godot-C# interface layer
4. **Godot Nodes** - Frontend consumers of state data

---

## 🎯 State Bridge Pattern

### **Purpose**
The State Bridge acts as a **translation layer** between C# states and Godot, providing:
- **GDScript compatibility** through familiar interfaces
- **State exposure** only where necessary
- **Performance optimization** through selective updates
- **Event-driven updates** to avoid polling

### **Implementation Architecture**

```csharp
// State Bridge - Godot Node that exposes C# states
public partial class StateBridge : Node
{
    // C# Backend References
    private ModeService _modeService;
    private BuildingService _buildingService;
    private UserService _userService;
    
    // Godot Frontend Interface
    public Godot.Collections.Dictionary CurrentState { get; private set; }
    public event Action<string, Variant> StateChanged;
    
    // GDScript-friendly methods
    public string GetApplicationMode() => _modeService.State.CurrentApplicationMode.ToString();
    public bool IsBuildingMode() => _modeService.State.CurrentApplicationMode == ApplicationMode.Building;
    public Godot.Collections.Array GetAvailableBuildings() => ConvertToGodotArray(_buildingService.GetAvailableBuildings());
}
```

---

## 🔄 State Flow Architecture

### **Data Flow Diagram**

```
C# State (ModeState) ──► ModeService ──► StateBridge ──► Godot Nodes
       │                        │              │              │
       │                        │              │              │
       ▼                        ▼              ▼              ▼
   Pure Data              Business Logic   Interface    UI Updates
```

### **Update Mechanisms**

#### **1. Event-Driven Updates (Preferred)**
```csharp
// In C# ModeService
public event Action<ApplicationMode> ApplicationModeChanged;

// In StateBridge
private void SubscribeToStateChanges()
{
    _modeService.ApplicationModeChanged += OnApplicationModeChanged;
}

private void OnApplicationModeChanged(ApplicationMode newMode)
{
    EmitSignal("ApplicationModeChanged", newMode.ToString());
    UpdateStateDictionary();
}
```

#### **2. Polling-Based Updates (GDScript Compatible)**
```csharp
// GDScript-friendly polling method
public Godot.Collections.Dictionary GetCurrentState()
{
    return new Godot.Collections.Dictionary
    {
        ["application_mode"] = _modeService.State.CurrentApplicationMode.ToString(),
        ["ui_mode"] = _modeService.State.CurrentUIMode.ToString(),
        ["edit_mode"] = _modeService.State.CurrentEditMode.ToString(),
        ["view_mode"] = _modeService.State.CurrentViewMode.ToString(),
        ["game_mode"] = _modeService.State.CurrentGameMode.ToString(),
        ["is_transitioning"] = _modeService.Transitions.IsTransitioning
    };
}
```

---

## 🎮 GDScript Integration Examples

### **Basic State Access**

```gdscript
# GDScript example - accessing state from any node
extends Node

func _ready():
    var state_bridge = get_node("/root/StateBridge")
    
    # Connect to state changes
    state_bridge.connect("ApplicationModeChanged", _on_application_mode_changed)
    
    # Get current state
    var current_mode = state_bridge.get_application_mode()
    print("Current mode: ", current_mode)

func _on_application_mode_changed(new_mode: String):
    print("Application mode changed to: ", new_mode)
    update_ui_for_mode(new_mode)

func update_ui_for_mode(mode: String):
    match mode:
        "Building":
            show_building_ui()
        "Editing":
            show_editing_ui()
        "Playing":
            show_gameplay_ui()
```

### **Advanced State Queries**

```gdscript
# GDScript - checking multiple state conditions
func can_place_building(building_type: String) -> bool:
    var state_bridge = get_node("/root/StateBridge")
    
    # Check if we're in the right mode
    if not state_bridge.is_building_mode():
        return false
    
    # Check if we're transitioning
    if state_bridge.is_transitioning():
        return false
    
    # Check if edit mode allows placing
    var edit_mode = state_bridge.get_edit_mode()
    if edit_mode != "Place":
        return false
    
    # Check if building is available
    var available_buildings = state_bridge.get_available_buildings()
    return building_type in available_buildings
```

---

## 🔧 State Bridge Implementation

### **Complete State Bridge Example**

```csharp
using Godot;
using GridBuilding.Core.State.Mode;
using GridBuilding.Core.Services;
using System.Collections.Generic;

public partial class StateBridge : Node
{
    #region Private Fields
    private ModeService _modeService;
    private BuildingService _buildingService;
    private UserService _userService;
    private Godot.Collections.Dictionary _currentState = new();
    #endregion
    
    #region Godot Signals (GDScript Compatible)
    [Signal]
    public delegate void ApplicationModeChangedEventHandler(string newMode);
    
    [Signal]
    public delegate void UIModeChangedEventHandler(string newMode);
    
    [Signal]
    public delegate void EditModeChangedEventHandler(string newMode);
    
    [Signal]
    public delegate void ViewModeChangedEventHandler(string newMode);
    
    [Signal]
    public delegate void GameModeChangedEventHandler(string newMode);
    
    [Signal]
    public delegate void StateTransitionStartedEventHandler();
    
    [Signal]
    public delegate void StateTransitionCompletedEventHandler();
    #endregion
    
    #region Public Properties
    public Godot.Collections.Dictionary CurrentState => new Godot.Collections.Dictionary(_currentState);
    #endregion
    
    #region Lifecycle
    public override void _Ready()
    {
        InitializeServices();
        SubscribeToStateChanges();
        UpdateStateDictionary();
    }
    
    public override void _ExitTree()
    {
        UnsubscribeFromStateChanges();
    }
    #endregion
    
    #region GDScript-Friendly Methods
    /// <summary>
    /// Gets the current application mode as string (GDScript compatible)
    /// </summary>
    public string GetApplicationMode()
    {
        return _modeService?.State?.CurrentApplicationMode.ToString() ?? "Unknown";
    }
    
    /// <summary>
    /// Gets the current UI mode as string (GDScript compatible)
    /// </summary>
    public string GetUIMode()
    {
        return _modeService?.State?.CurrentUIMode.ToString() ?? "Unknown";
    }
    
    /// <summary>
    /// Gets the current edit mode as string (GDScript compatible)
    /// </summary>
    public string GetEditMode()
    {
        return _modeService?.State?.CurrentEditMode.ToString() ?? "Unknown";
    }
    
    /// <summary>
    /// Gets the current view mode as string (GDScript compatible)
    /// </summary>
    public string GetViewMode()
    {
        return _modeService?.State?.CurrentViewMode.ToString() ?? "Unknown";
    }
    
    /// <summary>
    /// Gets the current game mode as string (GDScript compatible)
    /// </summary>
    public string GetGameMode()
    {
        return _modeService?.State?.CurrentGameMode.ToString() ?? "Unknown";
    }
    
    /// <summary>
    /// Checks if currently in building mode (GDScript compatible)
    /// </summary>
    public bool IsBuildingMode()
    {
        return _modeService?.State?.CurrentApplicationMode == ApplicationMode.Building;
    }
    
    /// <summary>
    /// Checks if currently in editing mode (GDScript compatible)
    /// </summary>
    public bool IsEditingMode()
    {
        return _modeService?.State?.CurrentApplicationMode == ApplicationMode.Editing;
    }
    
    /// <summary>
    /// Checks if currently in play mode (GDScript compatible)
    /// </summary>
    public bool IsPlayMode()
    {
        return _modeService?.State?.CurrentGameMode == GameMode.Play;
    }
    
    /// <summary>
    /// Checks if currently transitioning between modes (GDScript compatible)
    /// </summary>
    public bool IsTransitioning()
    {
        return _modeService?.Transitions?.IsTransitioning ?? false;
    }
    
    /// <summary>
    /// Gets available buildings as Godot array (GDScript compatible)
    /// </summary>
    public Godot.Collections.Array GetAvailableBuildings()
    {
        var buildings = _buildingService?.GetAvailableBuildings() ?? new List<string>();
        var godotArray = new Godot.Collections.Array();
        foreach (var building in buildings)
        {
            godotArray.Add(building);
        }
        return godotArray;
    }
    
    /// <summary>
    /// Attempts to change application mode (GDScript compatible)
    /// </summary>
    public bool SetApplicationMode(string mode)
    {
        if (System.Enum.TryParse<ApplicationMode>(mode, out var appMode))
        {
            return _modeService?.SetApplicationMode(appMode) ?? false;
        }
        return false;
    }
    
    /// <summary>
    /// Gets current state as dictionary (GDScript compatible)
    /// </summary>
    public Godot.Collections.Dictionary GetCurrentState()
    {
        UpdateStateDictionary();
        return new Godot.Collections.Dictionary(_currentState);
    }
    
    /// <summary>
    /// Gets user level as string (GDScript compatible)
    /// </summary>
    public string GetUserLevel()
    {
        return _userService?.State?.Level.ToString() ?? "Beginner";
    }
    
    /// <summary>
    /// Gets user experience points (GDScript compatible)
    /// </summary>
    public int GetUserExperience()
    {
        return _userService?.State?.Experience ?? 0;
    }
    #endregion
    
    #region Private Methods
    private void InitializeServices()
    {
        // Initialize services (these would be injected or created)
        _modeService = new ModeService();
        _buildingService = new BuildingService();
        _userService = new UserService();
    }
    
    private void SubscribeToStateChanges()
    {
        if (_modeService != null)
        {
            // Subscribe to mode changes
            // This would require implementing events in ModeService
            // For now, we'll use polling in _process
        }
    }
    
    private void UnsubscribeFromStateChanges()
    {
        // Unsubscribe from events
    }
    
    private void UpdateStateDictionary()
    {
        if (_modeService?.State != null)
        {
            _currentState["application_mode"] = _modeService.State.CurrentApplicationMode.ToString();
            _currentState["ui_mode"] = _modeService.State.CurrentUIMode.ToString();
            _currentState["edit_mode"] = _modeService.State.CurrentEditMode.ToString();
            _currentState["view_mode"] = _modeService.State.CurrentViewMode.ToString();
            _currentState["game_mode"] = _modeService.State.CurrentGameMode.ToString();
            _currentState["is_transitioning"] = _modeService.Transitions.IsTransitioning;
            _currentState["combined_mode_string"] = _modeService.State.CombinedModeString;
        }
        
        if (_userService?.State != null)
        {
            _currentState["user_level"] = _userService.State.Level.ToString();
            _currentState["user_experience"] = _userService.State.Experience;
            _currentState["user_buildings_placed"] = _userService.State.TotalBuildingsPlaced;
        }
    }
    #endregion
    
    #region Godot Updates
    public override void _Process(double delta)
    {
        // Poll for state changes (for GDScript compatibility)
        var oldState = new Godot.Collections.Dictionary(_currentState);
        UpdateStateDictionary();
        
        // Check for changes and emit signals
        if (oldState["application_mode"]?.ToString() != _currentState["application_mode"]?.ToString())
        {
            EmitSignal(nameof(ApplicationModeChanged), _currentState["application_mode"]);
        }
        
        if (oldState["ui_mode"]?.ToString() != _currentState["ui_mode"]?.ToString())
        {
            EmitSignal(nameof(UIModeChanged), _currentState["ui_mode"]);
        }
        
        if (oldState["edit_mode"]?.ToString() != _currentState["edit_mode"]?.ToString())
        {
            EmitSignal(nameof(EditModeChanged), _currentState["edit_mode"]);
        }
        
        if (oldState["view_mode"]?.ToString() != _currentState["view_mode"]?.ToString())
        {
            EmitSignal(nameof(ViewModeChanged), _currentState["view_mode"]);
        }
        
        if (oldState["game_mode"]?.ToString() != _currentState["game_mode"]?.ToString())
        {
            EmitSignal(nameof(GameModeChanged), _currentState["game_mode"]);
        }
    }
    #endregion
}
```

---

## 🎯 Practical Usage Examples

### **1. UI Controller Integration**

```gdscript
# UIController.gd - Controls UI based on state
extends Control

@onvar var state_bridge: StateBridge
@onvar var building_panel: Panel
@onvar var editing_panel: Panel
@onvar var gameplay_panel: Panel

func _ready():
    state_bridge = get_node("/root/StateBridge")
    
    # Connect to state changes
    state_bridge.connect("ApplicationModeChanged", _on_application_mode_changed)
    state_bridge.connect("EditModeChanged", _on_edit_mode_changed)
    
    # Initial UI setup
    _on_application_mode_changed(state_bridge.get_application_mode())

func _on_application_mode_changed(new_mode: String):
    # Hide all panels first
    building_panel.hide()
    editing_panel.hide()
    gameplay_panel.hide()
    
    # Show relevant panel
    match new_mode:
        "Building":
            building_panel.show()
        "Editing":
            editing_panel.show()
        "Playing":
            gameplay_panel.show()

func _on_edit_mode_changed(new_mode: String):
    # Update cursor and tools based on edit mode
    match new_mode:
        "Place":
            Input.set_custom_mouse_cursor(load("res://icons/cursor_place.png"))
        "Remove":
            Input.set_custom_mouse_cursor(load("res://icons/cursor_remove.png"))
        "Modify":
            Input.set_custom_mouse_cursor(load("res://icons/cursor_modify.png"))
```

### **2. Building System Integration**

```gdscript
# BuildingController.gd - Handles building placement
extends Node2D

@onvar var state_bridge: StateBridge
@onvar var building_preview: Sprite2D

func _ready():
    state_bridge = get_node("/root/StateBridge")
    state_bridge.connect("EditModeChanged", _on_edit_mode_changed)
    state_bridge.connect("ApplicationModeChanged", _on_application_mode_changed)

func _input(event):
    if event is InputEventMouseButton and event.pressed:
        if event.button_index == MOUSE_BUTTON_LEFT:
            try_place_building()

func try_place_building():
    # Check if we can place
    if not can_place_building():
        return
    
    var building_type = get_selected_building_type()
    var grid_pos = get_grid_position(event.position)
    
    # Place building through C# service
    place_building(building_type, grid_pos)

func can_place_building() -> bool:
    return (state_bridge.is_building_mode() and 
            not state_bridge.is_transitioning() and
            state_bridge.get_edit_mode() == "Place")

func _on_application_mode_changed(new_mode: String):
    if new_mode != "Building":
        building_preview.hide()
    else:
        building_preview.show()

func _on_edit_mode_changed(new_mode: String):
    update_building_preview(new_mode)
```

### **3. Camera Controller Integration**

```gdscript
# CameraController.gd - Controls camera based on state
extends Camera2D

@onvar var state_bridge: StateBridge

func _ready():
    state_bridge = get_node("/root/StateBridge")
    state_bridge.connect("ViewModeChanged", _on_view_mode_changed)
    state_bridge.connect("ApplicationModeChanged", _on_application_mode_changed)

func _on_view_mode_changed(new_mode: String):
    match new_mode:
        "Normal":
            zoom = Vector2(1.0, 1.0)
        "TopDown":
            zoom = Vector2(0.8, 0.8)
            rotation_degrees = 0
        "Isometric":
            zoom = Vector2(0.7, 0.7)
            rotation_degrees = 45

func _on_application_mode_changed(new_mode: String):
    match new_mode:
        "Building":
            enable_grid_snap()
        "Editing":
            enable_grid_snap()
        "Playing":
            disable_grid_snap()
```

---

## 🔄 Migration Path for GDScript Projects

### **Step 1: Add State Bridge**
1. Add `StateBridge.cs` to your Godot project
2. Add it to your main scene or autoload
3. Connect existing GDScript code to State Bridge

### **Step 2: Gradual Migration**
```gdscript
# Before: Direct GDScript state management
var current_mode = "Building"
var edit_mode = "Place"

# After: Bridge to C# state
var state_bridge = get_node("/root/StateBridge")
var current_mode = state_bridge.get_application_mode()
var edit_mode = state_bridge.get_edit_mode()
```

### **Step 3: Event Integration**
```gdscript
# Before: Manual state change detection
func _process(delta):
    if current_mode != previous_mode:
        on_mode_changed(current_mode)

# After: Event-driven updates
func _ready():
    state_bridge.connect("ApplicationModeChanged", _on_application_mode_changed)
```

---

## 📊 Performance Considerations

### **Optimization Strategies**

1. **Selective Updates**: Only update what changes
2. **Event-Driven**: Avoid polling where possible
3. **Batch Updates**: Group multiple state changes
4. **Caching**: Cache frequently accessed state

### **Performance Monitoring**

```csharp
// Add performance monitoring to State Bridge
private void UpdateStateDictionary()
{
    var stopwatch = System.Diagnostics.Stopwatch.StartNew();
    
    // Update state logic...
    
    stopwatch.Stop();
    if (stopwatch.ElapsedMilliseconds > 1) // Log if > 1ms
    {
        GD.Print($"State update took {stopwatch.ElapsedMilliseconds}ms");
    }
}
```

---

## 🎯 Best Practices

### **For GDScript Developers**
1. **Use State Bridge methods** instead of direct C# access
2. **Connect to signals** for reactive updates
3. **Cache state values** when used frequently
4. **Handle null cases** gracefully

### **For C# Developers**
1. **Keep State Bridge minimal** - only expose what's needed
2. **Use Godot types** in public interfaces
3. **Provide both sync and async** methods where appropriate
4. **Document GDScript compatibility** clearly

### **General Guidelines**
1. **Maintain backward compatibility** with existing GDScript
2. **Provide migration paths** for gradual adoption
3. **Test both C# and GDScript** integration points
4. **Monitor performance** of state bridge operations

---

## 🔍 Troubleshooting

### **Common Issues**

1. **State Bridge Not Found**
   ```gdscript
   # Ensure StateBridge is in autoload or scene tree
   var state_bridge = get_node("/root/StateBridge")
   if state_bridge == null:
       push_error("StateBridge not found!")
   ```

2. **State Changes Not Propagating**
   ```csharp
   // Ensure signals are connected properly
   state_bridge.connect("ApplicationModeChanged", _on_mode_changed)
   ```

3. **Performance Issues**
   ```csharp
   // Use event-driven updates instead of polling
   // Or reduce polling frequency
   ```

---

## 📚 Additional Resources

- [Service-Based Architecture](/gridbuilding/service-based-architecture/)
- [GDScript to C# Migration Guide](/gridbuilding/gdscript-to-csharp-migration/)
- [API Reference](/gridbuilding/api/)
- [Troubleshooting Guide](/gridbuilding/troubleshooting/)

---

## 🎉 Summary

The C# State Integration provides a **robust bridge** between the C# backend states and Godot frontend, offering:

✅ **GDScript Compatibility** - Familiar interfaces for GDScript developers  
✅ **Performance Optimization** - Event-driven updates and selective exposure  
✅ **Gradual Migration** - Step-by-step adoption path  
✅ **Maintainable Architecture** - Clean separation of concerns  
✅ **Extensible Design** - Easy to add new states and features  

This approach ensures that **existing GDScript projects can gradually adopt** the C# backend while maintaining **full compatibility** and **optimal performance**.
