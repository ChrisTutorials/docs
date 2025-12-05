---
title: "StateBridge"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/statebridge/"
---

# StateBridge

```csharp
GridBuilding.Godot.Core
class StateBridge
{
    // Members...
}
```

State Bridge - Connects C# backend states to Godot frontend
Provides GDScript-compatible interface for state access
Maintains backward compatibility while enabling C# backend adoption

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Core/StateBridge.cs`  
**Namespace:** `GridBuilding.Godot.Core`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CurrentState

```csharp
#endregion
        
        #region Public Properties
        
        /// <summary>
        /// Current state dictionary (GDScript compatible)
        /// </summary>
        public global::Godot.Collections.Dictionary CurrentState => new global::Godot.Collections.Dictionary(_currentState);
```

Current state dictionary (GDScript compatible)

### IsInitialized

```csharp
/// <summary>
        /// Whether state bridge is initialized
        /// </summary>
        public bool IsInitialized { get; private set; }
```

Whether state bridge is initialized


## Methods

### _Ready

```csharp
#endregion
        
        #region Lifecycle
        
        public override void _Ready()
        {
            GD.Print("[StateBridge] Initializing...");
            
            try
            {
                InitializeServices();
                SubscribeToStateChanges();
                UpdateStateDictionary();
                IsInitialized = true;
                
                GD.Print("[StateBridge] Initialization complete");
            }
            catch (System.Exception ex)
            {
                GD.PrintErr($"[StateBridge] Initialization failed: {ex.Message}");
            }
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            GD.Print("[StateBridge] Cleaning up...");
            UnsubscribeFromStateChanges();
        }
```

**Returns:** `void`

### GetApplicationMode

```csharp
#endregion
        
        #region GDScript-Friendly Methods - Mode State
        
        /// <summary>
        /// Gets the current application mode as string (GDScript compatible)
        /// </summary>
        public string GetApplicationMode()
        {
            return _modeService?.State?.CurrentApplicationMode.ToString() ?? "Unknown";
        }
```

Gets the current application mode as string (GDScript compatible)

**Returns:** `string`

### GetUIMode

```csharp
/// <summary>
        /// Gets the current UI mode as string (GDScript compatible)
        /// </summary>
        public string GetUIMode()
        {
            return _modeService?.State?.CurrentUIMode.ToString() ?? "Unknown";
        }
```

Gets the current UI mode as string (GDScript compatible)

**Returns:** `string`

### GetEditMode

```csharp
/// <summary>
        /// Gets the current edit mode as string (GDScript compatible)
        /// </summary>
        public string GetEditMode()
        {
            return _modeService?.State?.CurrentEditMode.ToString() ?? "Unknown";
        }
```

Gets the current edit mode as string (GDScript compatible)

**Returns:** `string`

### GetViewMode

```csharp
/// <summary>
        /// Gets the current view mode as string (GDScript compatible)
        /// </summary>
        public string GetViewMode()
        {
            return _modeService?.State?.CurrentViewMode.ToString() ?? "Unknown";
        }
```

Gets the current view mode as string (GDScript compatible)

**Returns:** `string`

### GetGameMode

```csharp
/// <summary>
        /// Gets the current game mode as string (GDScript compatible)
        /// </summary>
        public string GetGameMode()
        {
            return _modeService?.State?.CurrentGameMode.ToString() ?? "Unknown";
        }
```

Gets the current game mode as string (GDScript compatible)

**Returns:** `string`

### GetCombinedModeString

```csharp
/// <summary>
        /// Gets combined mode string (GDScript compatible)
        /// </summary>
        public string GetCombinedModeString()
        {
            return _modeService?.State?.CombinedModeString ?? "Unknown|Unknown|Unknown|Unknown|Unknown";
        }
```

Gets combined mode string (GDScript compatible)

**Returns:** `string`

### IsBuildingMode

```csharp
/// <summary>
        /// Checks if currently in building mode (GDScript compatible)
        /// </summary>
        public bool IsBuildingMode()
        {
            return _modeService?.State?.CurrentApplicationMode == ApplicationMode.Building;
        }
```

Checks if currently in building mode (GDScript compatible)

**Returns:** `bool`

### IsEditingMode

```csharp
/// <summary>
        /// Checks if currently in editing mode (GDScript compatible)
        /// </summary>
        public bool IsEditingMode()
        {
            return _modeService?.State?.CurrentApplicationMode == ApplicationMode.Editing;
        }
```

Checks if currently in editing mode (GDScript compatible)

**Returns:** `bool`

### IsPlayMode

```csharp
/// <summary>
        /// Checks if currently in play mode (GDScript compatible)
        /// </summary>
        public bool IsPlayMode()
        {
            return _modeService?.State?.CurrentGameMode == GameMode.Play;
        }
```

Checks if currently in play mode (GDScript compatible)

**Returns:** `bool`

### IsTransitioning

```csharp
/// <summary>
        /// Checks if currently transitioning between modes (GDScript compatible)
        /// </summary>
        public bool IsTransitioning()
        {
            return _modeService?.Transitions?.IsTransitioning ?? false;
        }
```

Checks if currently transitioning between modes (GDScript compatible)

**Returns:** `bool`

### GetTransitionProgress

```csharp
/// <summary>
        /// Gets transition progress (0.0 to 1.0) (GDScript compatible)
        /// </summary>
        public float GetTransitionProgress()
        {
            // This would be implemented in ModeService
            return 0.0f; // Placeholder
        }
```

Gets transition progress (0.0 to 1.0) (GDScript compatible)

**Returns:** `float`

### GetAvailableBuildings

```csharp
#endregion
        
        #region GDScript-Friendly Methods - Building State
        
        /// <summary>
        /// Gets available buildings as Godot array (GDScript compatible)
        /// </summary>
        public global::Godot.Collections.Array GetAvailableBuildings()
        {
            var buildings = new List<string> { "basic", "advanced", "special" }; // Placeholder
            var godotArray = new global::Godot.Collections.Array();
            foreach (var building in buildings)
            {
                godotArray.Add(building);
            }
            return godotArray;
        }
```

Gets available buildings as Godot array (GDScript compatible)

**Returns:** `global::Godot.Collections.Array`

### GetTotalBuildingsPlaced

```csharp
/// <summary>
        /// Gets total buildings placed (GDScript compatible)
        /// </summary>
        public int GetTotalBuildingsPlaced()
        {
            return _userService?.State?.TotalBuildingsPlaced ?? 0;
        }
```

Gets total buildings placed (GDScript compatible)

**Returns:** `int`

### GetTotalBuildingsRemoved

```csharp
/// <summary>
        /// Gets total buildings removed (GDScript compatible)
        /// </summary>
        public int GetTotalBuildingsRemoved()
        {
            return _userService?.State?.TotalBuildingsRemoved ?? 0;
        }
```

Gets total buildings removed (GDScript compatible)

**Returns:** `int`

### GetUserLevel

```csharp
#endregion
        
        #region GDScript-Friendly Methods - User State
        
        /// <summary>
        /// Gets user level as string (GDScript compatible)
        /// </summary>
        public string GetUserLevel()
        {
            return _userService?.State?.Level.ToString() ?? "Beginner";
        }
```

Gets user level as string (GDScript compatible)

**Returns:** `string`

### GetUserExperience

```csharp
/// <summary>
        /// Gets user experience points (GDScript compatible)
        /// </summary>
        public int GetUserExperience()
        {
            return _userService?.State?.Experience ?? 0;
        }
```

Gets user experience points (GDScript compatible)

**Returns:** `int`

### GetExperienceToNextLevel

```csharp
/// <summary>
        /// Gets experience needed for next level (GDScript compatible)
        /// </summary>
        public int GetExperienceToNextLevel()
        {
            return 100; // Placeholder - would calculate from UserService
        }
```

Gets experience needed for next level (GDScript compatible)

**Returns:** `int`

### GetLevelProgress

```csharp
/// <summary>
        /// Gets level progress (0.0 to 1.0) (GDScript compatible)
        /// </summary>
        public float GetLevelProgress()
        {
            return 0.5f; // Placeholder - would calculate from UserService
        }
```

Gets level progress (0.0 to 1.0) (GDScript compatible)

**Returns:** `float`

### GetUsername

```csharp
/// <summary>
        /// Gets username (GDScript compatible)
        /// </summary>
        public string GetUsername()
        {
            return _userService?.State?.Username ?? "Unknown";
        }
```

Gets username (GDScript compatible)

**Returns:** `string`

### SetApplicationMode

```csharp
#endregion
        
        #region GDScript-Friendly Methods - State Control
        
        /// <summary>
        /// Attempts to change application mode (GDScript compatible)
        /// </summary>
        public bool SetApplicationMode(string mode)
        {
            if (!IsInitialized)
            {
                GD.PrintErr("[StateBridge] Not initialized - cannot set mode");
                return false;
            }
            
            if (System.Enum.TryParse<ApplicationMode>(mode, out var appMode))
            {
                var result = _modeService?.SetApplicationMode(appMode) ?? false;
                if (result)
                {
                    GD.Print($"[StateBridge] Application mode changed to: {mode}");
                }
                return result;
            }
            else
            {
                GD.PrintErr($"[StateBridge] Invalid application mode: {mode}");
                return false;
            }
        }
```

Attempts to change application mode (GDScript compatible)

**Returns:** `bool`

**Parameters:**
- `string mode`

### SetUIMode

```csharp
/// <summary>
        /// Attempts to change UI mode (GDScript compatible)
        /// </summary>
        public bool SetUIMode(string mode)
        {
            if (!IsInitialized) return false;
            
            if (System.Enum.TryParse<UIMode>(mode, out var uiMode))
            {
                var result = _modeService?.SetUIMode(uiMode) ?? false;
                if (result)
                {
                    GD.Print($"[StateBridge] UI mode changed to: {mode}");
                }
                return result;
            }
            return false;
        }
```

Attempts to change UI mode (GDScript compatible)

**Returns:** `bool`

**Parameters:**
- `string mode`

### SetEditMode

```csharp
/// <summary>
        /// Attempts to change edit mode (GDScript compatible)
        /// </summary>
        public bool SetEditMode(string mode)
        {
            if (!IsInitialized) return false;
            
            if (System.Enum.TryParse<EditMode>(mode, out var editMode))
            {
                var result = _modeService?.SetEditMode(editMode) ?? false;
                if (result)
                {
                    GD.Print($"[StateBridge] Edit mode changed to: {mode}");
                }
                return result;
            }
            return false;
        }
```

Attempts to change edit mode (GDScript compatible)

**Returns:** `bool`

**Parameters:**
- `string mode`

### SetViewMode

```csharp
/// <summary>
        /// Attempts to change view mode (GDScript compatible)
        /// </summary>
        public bool SetViewMode(string mode)
        {
            if (!IsInitialized) return false;
            
            if (System.Enum.TryParse<ViewMode>(mode, out var viewMode))
            {
                var result = _modeService?.SetViewMode(viewMode) ?? false;
                if (result)
                {
                    GD.Print($"[StateBridge] View mode changed to: {mode}");
                }
                return result;
            }
            return false;
        }
```

Attempts to change view mode (GDScript compatible)

**Returns:** `bool`

**Parameters:**
- `string mode`

### SetGameMode

```csharp
/// <summary>
        /// Attempts to change game mode (GDScript compatible)
        /// </summary>
        public bool SetGameMode(string mode)
        {
            if (!IsInitialized) return false;
            
            if (System.Enum.TryParse<GameMode>(mode, out var gameMode))
            {
                var result = _modeService?.SetGameMode(gameMode) ?? false;
                if (result)
                {
                    GD.Print($"[StateBridge] Game mode changed to: {mode}");
                }
                return result;
            }
            return false;
        }
```

Attempts to change game mode (GDScript compatible)

**Returns:** `bool`

**Parameters:**
- `string mode`

### GetCurrentState

```csharp
#endregion
        
        #region GDScript-Friendly Methods - Utilities
        
        /// <summary>
        /// Gets current state as dictionary (GDScript compatible)
        /// </summary>
        public global::Godot.Collections.Dictionary GetCurrentState()
        {
            UpdateStateDictionary();
            return new global::Godot.Collections.Dictionary(_currentState);
        }
```

Gets current state as dictionary (GDScript compatible)

**Returns:** `global::Godot.Collections.Dictionary`

### GetStateHistory

```csharp
/// <summary>
        /// Gets state history (GDScript compatible)
        /// </summary>
        public global::Godot.Collections.Array GetStateHistory()
        {
            var history = new global::Godot.Collections.Array();
            // This would be implemented with actual transition history
            return history;
        }
```

Gets state history (GDScript compatible)

**Returns:** `global::Godot.Collections.Array`

### IsModeAvailable

```csharp
/// <summary>
        /// Checks if a specific mode is available (GDScript compatible)
        /// </summary>
        public bool IsModeAvailable(string mode)
        {
            // This would check against available modes in ModeService
            return true; // Placeholder
        }
```

Checks if a specific mode is available (GDScript compatible)

**Returns:** `bool`

**Parameters:**
- `string mode`

### GetModeSettings

```csharp
/// <summary>
        /// Gets mode settings (GDScript compatible)
        /// </summary>
        public global::Godot.Collections.Dictionary GetModeSettings(string modeType, string mode)
        {
            var settings = new global::Godot.Collections.Dictionary();
            // This would get actual settings from ModeSettingsManager
            settings["name"] = mode;
            settings["description"] = $"{mode} mode";
            settings["icon_path"] = $"res://icons/{mode.ToLower()}.png";
            return settings;
        }
```

Gets mode settings (GDScript compatible)

**Returns:** `global::Godot.Collections.Dictionary`

**Parameters:**
- `string modeType`
- `string mode`

### _Process

```csharp
#endregion
        
        #region Godot Updates
        
        public override void _Process(double delta)
        {
            if (!IsInitialized)
                return;
            
            // No polling needed - events handle state changes
            // This method is kept for potential future polling needs
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### DebugPrintState

```csharp
#endregion
        
        #region Debug Methods
        
        /// <summary>
        /// Debug method to print current state (GDScript compatible)
        /// </summary>
        public void DebugPrintState()
        {
            GD.Print($"[StateBridge] Current State:");
            GD.Print($"  Application Mode: {GetApplicationMode()}");
            GD.Print($"  UI Mode: {GetUIMode()}");
            GD.Print($"  Edit Mode: {GetEditMode()}");
            GD.Print($"  View Mode: {GetViewMode()}");
            GD.Print($"  Game Mode: {GetGameMode()}");
            GD.Print($"  User Level: {GetUserLevel()}");
            GD.Print($"  User Experience: {GetUserExperience()}");
            GD.Print($"  Is Transitioning: {IsTransitioning()}");
        }
```

Debug method to print current state (GDScript compatible)

**Returns:** `void`

### DebugValidateStateBridge

```csharp
/// <summary>
        /// Debug method to validate state bridge (GDScript compatible)
        /// </summary>
        public bool DebugValidateStateBridge()
        {
            if (!IsInitialized)
            {
                GD.PrintErr("[StateBridge] Not initialized");
                return false;
            }
            
            if (_modeService == null)
            {
                GD.PrintErr("[StateBridge] ModeService is null");
                return false;
            }
            
            if (_userService == null)
            {
                GD.PrintErr("[StateBridge] UserService is null");
                return false;
            }
            
            GD.Print("[StateBridge] State bridge validation passed");
            return true;
        }
```

Debug method to validate state bridge (GDScript compatible)

**Returns:** `bool`

