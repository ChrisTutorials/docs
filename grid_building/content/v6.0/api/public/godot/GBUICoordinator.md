---
title: "GBUICoordinator"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/gbuicoordinator/"
---

# GBUICoordinator

```csharp
GridBuilding.Godot.UI
class GBUICoordinator
{
    // Members...
}
```

Coordinates multiple UI managers and components across the GridBuilding system
Provides high-level UI orchestration, event routing, and component lifecycle management

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/UICoordinator.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CoordinationInterval

```csharp
#endregion

        #region Exported Properties

        /// <summary>
        /// Coordination update interval in seconds
        /// </summary>
        [Export]
        public float CoordinationInterval { get; set; } = 0.05f;
```

Coordination update interval in seconds

### EnableAutoDiscovery

```csharp
/// <summary>
        /// Whether to enable automatic manager discovery
        /// </summary>
        [Export]
        public bool EnableAutoDiscovery { get; set; } = true;
```

Whether to enable automatic manager discovery

### EnableCrossManagerCommunication

```csharp
/// <summary>
        /// Whether to enable cross-manager communication
        /// </summary>
        [Export]
        public bool EnableCrossManagerCommunication { get; set; } = true;
```

Whether to enable cross-manager communication

### ShowDebugInfo

```csharp
/// <summary>
        /// Whether to show debug information
        /// </summary>
        [Export]
        public bool ShowDebugInfo { get; set; } = false;
```

Whether to show debug information

### DefaultManager

```csharp
/// <summary>
        /// Default manager to activate on startup
        /// </summary>
        [Export]
        public string DefaultManager { get; set; } = "MainUI";
```

Default manager to activate on startup

### CurrentState

```csharp
#endregion

        #region Public Properties

        /// <summary>
        /// Current coordinator state
        /// </summary>
        public CoordinatorState CurrentState => _currentState;
```

Current coordinator state

### IsInitialized

```csharp
/// <summary>
        /// Whether the coordinator is initialized
        /// </summary>
        public bool IsInitialized => _isInitialized;
```

Whether the coordinator is initialized

### ActiveManager

```csharp
/// <summary>
        /// Currently active UI manager
        /// </summary>
        public string ActiveManager => _activeManager;
```

Currently active UI manager

### ManagerCount

```csharp
/// <summary>
        /// Number of registered UI managers
        /// </summary>
        public int ManagerCount => _uiManagers.Count;
```

Number of registered UI managers


## Methods

### _Ready

```csharp
#endregion

        #region Godot Methods

        public override void _Ready()
        {
            InitializeCoordinator();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            if (!_isInitialized)
                return;

            UpdateCoordination((float)delta);
            HandleGlobalInput();
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### _Notification

```csharp
public override void _Notification(int what)
        {
            base._Notification(what);

            switch ((long)what)
            {
                case NotificationWMSizeChanged:
                    HandleScreenSizeChanged();
                    break;
                case NotificationTranslationChanged:
                    HandleTranslationChanged();
                    break;
            }
        }
```

**Returns:** `void`

**Parameters:**
- `int what`

### RegisterUIManager

```csharp
#endregion

        #region UI Manager Management

        /// <summary>
        /// Registers a UI manager
        /// </summary>
        public void RegisterUIManager(string name, UIManager manager)
        {
            if (string.IsNullOrWhiteSpace(name))
            {
                GD.PrintErr("Cannot register UI manager with null or empty name");
                return;
            }

            if (manager == null)
            {
                GD.PrintErr($"Cannot register UI manager '{name}': manager is null");
                return;
            }

            if (_uiManagers.ContainsKey(name))
            {
                GD.PrintErr($"UI manager '{name}' is already registered");
                return;
            }

            _uiManagers[name] = manager;

            // Connect to manager events
            ConnectManagerEvents(name, manager);

            // Emit signal
            EmitSignal(SignalName.UIManagerRegistered, name);

            GD.Print($"Registered UI manager: {name}");
        }
```

Registers a UI manager

**Returns:** `void`

**Parameters:**
- `string name`
- `UIManager manager`

### UnregisterUIManager

```csharp
/// <summary>
        /// Unregisters a UI manager
        /// </summary>
        public void UnregisterUIManager(string name)
        {
            if (!_uiManagers.ContainsKey(name))
            {
                GD.PrintErr($"UI manager '{name}' is not registered");
                return;
            }

            var manager = _uiManagers[name];

            // Disconnect from manager events
            DisconnectManagerEvents(name, manager);

            _uiManagers.Remove(name);

            // Clear active manager if this was the active one
            if (_activeManager == name)
            {
                _activeManager = string.Empty;
            }

            // Emit signal
            EmitSignal(SignalName.UIManagerUnregistered, name);

            GD.Print($"Unregistered UI manager: {name}");
        }
```

Unregisters a UI manager

**Returns:** `void`

**Parameters:**
- `string name`

### GetUIManager

```csharp
/// <summary>
        /// Gets a UI manager by name
        /// </summary>
        public UIManager GetUIManager(string name)
        {
            return _uiManagers.TryGetValue(name, out var manager) ? manager : null;
        }
```

Gets a UI manager by name

**Returns:** `UIManager`

**Parameters:**
- `string name`

### ActivateManager

```csharp
/// <summary>
        /// Activates a specific UI manager
        /// </summary>
        public void ActivateManager(string name)
        {
            var manager = GetUIManager(name);
            if (manager == null)
            {
                GD.PrintErr($"Cannot activate UI manager '{name}': manager not found");
                return;
            }

            // Deactivate current manager
            if (!string.IsNullOrWhiteSpace(_activeManager) && _activeManager != name)
            {
                DeactivateManager(_activeManager);
            }

            _activeManager = name;
            manager.Visible = true;

            GD.Print($"Activated UI manager: {name}");
        }
```

Activates a specific UI manager

**Returns:** `void`

**Parameters:**
- `string name`

### DeactivateManager

```csharp
/// <summary>
        /// Deactivates a specific UI manager
        /// </summary>
        public void DeactivateManager(string name)
        {
            var manager = GetUIManager(name);
            if (manager == null)
            {
                GD.PrintErr($"Cannot deactivate UI manager '{name}': manager not found");
                return;
            }

            manager.Visible = false;

            if (_activeManager == name)
            {
                _activeManager = string.Empty;
            }

            GD.Print($"Deactivated UI manager: {name}");
        }
```

Deactivates a specific UI manager

**Returns:** `void`

**Parameters:**
- `string name`

### GetManagerNames

```csharp
/// <summary>
        /// Gets all registered manager names
        /// </summary>
        public string[] GetManagerNames()
        {
            return _uiManagers.Keys.ToArray();
        }
```

Gets all registered manager names

**Returns:** `string[]`

### RegisterGlobalComponent

```csharp
#endregion

        #region Global Component Management

        /// <summary>
        /// Registers a global UI component
        /// </summary>
        public void RegisterGlobalComponent(string name, IUIComponent component)
        {
            if (string.IsNullOrWhiteSpace(name))
            {
                GD.PrintErr("Cannot register global component with null or empty name");
                return;
            }

            if (component == null)
            {
                GD.PrintErr($"Cannot register global component '{name}': component is null");
                return;
            }

            _globalComponents[name] = component;

            GD.Print($"Registered global component: {name}");
        }
```

Registers a global UI component

**Returns:** `void`

**Parameters:**
- `string name`
- `IUIComponent component`

### UnregisterGlobalComponent

```csharp
/// <summary>
        /// Unregisters a global UI component
        /// </summary>
        public void UnregisterGlobalComponent(string name)
        {
            if (_globalComponents.ContainsKey(name))
            {
                _globalComponents.Remove(name);
                GD.Print($"Unregistered global component: {name}");
            }
        }
```

Unregisters a global UI component

**Returns:** `void`

**Parameters:**
- `string name`

### GetGlobalComponent

```csharp
/// <summary>
        /// Gets a global UI component
        /// </summary>
        public T GetGlobalComponent<T>(string name) where T : class
        {
            if (_globalComponents.TryGetValue(name, out var component))
            {
                return component as T;
            }
            return null;
        }
```

Gets a global UI component

**Returns:** `T`

**Parameters:**
- `string name`

### RegisterUINode

```csharp
#endregion

        #region UI Node Management

        /// <summary>
        /// Registers a UI node for global access
        /// </summary>
        public void RegisterUINode(string name, Node node)
        {
            if (string.IsNullOrWhiteSpace(name))
            {
                GD.PrintErr("Cannot register UI node with null or empty name");
                return;
            }

            if (node == null)
            {
                GD.PrintErr($"Cannot register UI node '{name}': node is null");
                return;
            }

            _uiNodes[name] = node;

            GD.Print($"Registered UI node: {name}");
        }
```

Registers a UI node for global access

**Returns:** `void`

**Parameters:**
- `string name`
- `Node node`

### GetUINode

```csharp
/// <summary>
        /// Gets a UI node by name
        /// </summary>
        public T GetUINode<T>(string name) where T : class
        {
            if (_uiNodes.TryGetValue(name, out var node))
            {
                return node as T;
            }
            return null;
        }
```

Gets a UI node by name

**Returns:** `T`

**Parameters:**
- `string name`

### TriggerGlobalAction

```csharp
#endregion

        #region Global Actions

        /// <summary>
        /// Triggers a global UI action
        /// </summary>
        public void TriggerGlobalAction(string actionId, Variant data = default)
        {
            if (string.IsNullOrWhiteSpace(actionId))
            {
                GD.PrintErr("Cannot trigger global action: ID is null or empty");
                return;
            }

            // Handle built-in global actions
            HandleBuiltInGlobalAction(actionId, data);

            // Route to active manager
            if (!string.IsNullOrWhiteSpace(_activeManager))
            {
                var activeManager = GetUIManager(_activeManager);
                activeManager?.TriggerUIAction(actionId, data);
            }

            // Route to all managers if cross-manager communication is enabled
            if (EnableCrossManagerCommunication)
            {
                foreach (var manager in _uiManagers.Values)
                {
                    if (manager.Name != _activeManager)
                    {
                        manager.TriggerUIAction(actionId, data);
                    }
                }
            }

            // Emit signal for external handling
            EmitSignal(SignalName.GlobalUIAction, actionId, data);

            GD.Print($"Triggered global action: {actionId}");
        }
```

Triggers a global UI action

**Returns:** `void`

**Parameters:**
- `string actionId`
- `Variant data`

### SwitchToManager

```csharp
/// <summary>
        /// Switches to a specific manager
        /// </summary>
        public void SwitchToManager(string managerName)
        {
            if (string.IsNullOrWhiteSpace(managerName))
            {
                GD.PrintErr("Cannot switch to manager: name is null or empty");
                return;
            }

            ActivateManager(managerName);
        }
```

Switches to a specific manager

**Returns:** `void`

**Parameters:**
- `string managerName`

### ToggleAllUI

```csharp
/// <summary>
        /// Toggles all UI visibility
        /// </summary>
        public void ToggleAllUI()
        {
            var anyVisible = _uiManagers.Values.Any(m => m.Visible);
            
            if (anyVisible)
            {
                HideAllUI();
            }
            else
            {
                ShowAllUI();
            }
        }
```

Toggles all UI visibility

**Returns:** `void`

### ShowAllUI

```csharp
/// <summary>
        /// Shows all UI managers
        /// </summary>
        public void ShowAllUI()
        {
            foreach (var manager in _uiManagers.Values)
            {
                manager.Visible = true;
            }
        }
```

Shows all UI managers

**Returns:** `void`

### HideAllUI

```csharp
/// <summary>
        /// Hides all UI managers
        /// </summary>
        public void HideAllUI()
        {
            foreach (var manager in _uiManagers.Values)
            {
                manager.Visible = false;
            }
        }
```

Hides all UI managers

**Returns:** `void`

### ResetUI

```csharp
/// <summary>
        /// Resets all UI to default state
        /// </summary>
        public void ResetUI()
        {
            foreach (var manager in _uiManagers.Values)
            {
                manager.ClearPlaceableSelection();
                manager.SetUIState(UIState.Normal);
            }

            // Activate default manager
            if (!string.IsNullOrWhiteSpace(DefaultManager) && _uiManagers.ContainsKey(DefaultManager))
            {
                ActivateManager(DefaultManager);
            }

            GD.Print("Reset all UI to default state");
        }
```

Resets all UI to default state

**Returns:** `void`

### GetDebugInfo

```csharp
#endregion

        #region Debug and Diagnostics

        /// <summary>
        /// Gets debug information about the coordinator
        /// </summary>
        public string GetDebugInfo()
        {
            var info = $"GBUICoordinator Debug Info:\n";
            info += $"State: {_currentState}\n";
            info += $"Active Manager: {_activeManager}\n";
            info += $"UI Managers: {_uiManagers.Count}\n";
            info += $"Global Components: {_globalComponents.Count}\n";
            info += $"UI Nodes: {_uiNodes.Count}\n";
            info += $"Initialized: {_isInitialized}\n";
            info += $"Auto Discovery: {EnableAutoDiscovery}\n";
            info += $"Cross-Manager Comm: {EnableCrossManagerCommunication}\n";

            if (ShowDebugInfo)
            {
                info += "\nRegistered Managers:\n";
                foreach (var kvp in _uiManagers)
                {
                    info += $"  {kvp.Key}: Visible={kvp.Value.Visible}, State={kvp.Value.CurrentState}\n";
                }

                info += "\nGlobal Components:\n";
                foreach (var kvp in _globalComponents)
                {
                    info += $"  {kvp.Key}: {kvp.Value.GetType().Name}\n";
                }
            }

            return info;
        }
```

Gets debug information about the coordinator

**Returns:** `string`

### PrintDebugInfo

```csharp
/// <summary>
        /// Prints debug information to the console
        /// </summary>
        public void PrintDebugInfo()
        {
            GD.Print(GetDebugInfo());
        }
```

Prints debug information to the console

**Returns:** `void`

### GetStatistics

```csharp
/// <summary>
        /// Gets coordinator statistics
        /// </summary>
        public Dictionary<string, object> GetStatistics()
        {
            return new Dictionary<string, object>
            {
                ["state"] = _currentState.ToString(),
                ["active_manager"] = _activeManager,
                ["manager_count"] = _uiManagers.Count,
                ["global_component_count"] = _globalComponents.Count,
                ["ui_node_count"] = _uiNodes.Count,
                ["initialized"] = _isInitialized,
                ["visible_managers"] = _uiManagers.Values.Count(m => m.Visible),
                ["active_placement_managers"] = _uiManagers.Values.Count(m => m.CurrentPlacementMode != PlacementMode.None)
            };
        }
```

Gets coordinator statistics

**Returns:** `Dictionary<string, object>`

### _ExitTree

```csharp
#endregion

        #region Cleanup

        /// <summary>
        /// Cleanup when the coordinator is destroyed
        /// </summary>
        public override void _ExitTree()
        {
            // Clean up timer
            if (_coordinationTimer != null)
            {
                _coordinationTimer.Timeout -= OnCoordinationTimer;
                _coordinationTimer.QueueFree();
            }

            // Disconnect from all managers
            foreach (var kvp in _uiManagers)
            {
                DisconnectManagerEvents(kvp.Key, kvp.Value);
            }

            // Clear references
            _uiManagers.Clear();
            _globalComponents.Clear();
            _uiNodes.Clear();

            _isInitialized = false;
        }
```

Cleanup when the coordinator is destroyed

**Returns:** `void`

