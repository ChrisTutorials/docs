---
title: "ModeService"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/modeservice/"
---

# ModeService

```csharp
GridBuilding.Core.State.Mode
class ModeService
{
    // Members...
}
```

High-level mode management service
Coordinates mode state, settings, and transitions
Contains the business logic that was removed from ModeState

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Mode/ModeService.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### State

```csharp
#region Public Properties
        
        /// <summary>
        /// Current mode state (read-only)
        /// </summary>
        public ModeState State => _modeState;
```

Current mode state (read-only)

### Settings

```csharp
/// <summary>
        /// Settings manager
        /// </summary>
        public ModeMetadataManager Settings => _settingsManager;
```

Settings manager

### Transitions

```csharp
/// <summary>
        /// Transition manager
        /// </summary>
        public ModeTransitionManager Transitions => _transitionManager;
```

Transition manager


## Methods

### SetApplicationMode

```csharp
#endregion
        
        #region Mode Management
        
        /// <summary>
        /// Sets application mode with validation and transition logic
        /// </summary>
        public bool SetApplicationMode(ApplicationMode mode)
        {
            if (!_transitionManager.CanTransitionTo(mode))
                return false;
                
            var oldMode = _modeState.CurrentApplicationMode;
            if (oldMode == mode)
                return true;
                
            _transitionManager.StartTransition();
            _transitionManager.RecordTransition("ApplicationMode", oldMode.ToString(), mode.ToString());
            
            // Publish transition started event
            _eventDispatcher.Publish(this, new ModeTransitionStartedEvent("ApplicationMode", oldMode.ToString(), mode.ToString()));
            
            _modeState.CurrentApplicationMode = mode;
            
            // Update mode context
            _transitionManager.UpdateModeContext($"App:{mode}");
            
            // Apply mode-specific settings
            var settings = _settingsManager.GetModeSettings(mode);
            ApplyModeSettings(settings);
            
            // Publish mode changed event
            _eventDispatcher.Publish(this, new ApplicationModeChangedEvent(oldMode, mode));
            
            OnApplicationModeChanged(oldMode, mode);
            
            _transitionManager.EndTransition();
            
            // Publish transition completed event
            _eventDispatcher.Publish(this, new ModeTransitionCompletedEvent("ApplicationMode", oldMode.ToString(), mode.ToString()));
            
            return true;
        }
```

Sets application mode with validation and transition logic

**Returns:** `bool`

**Parameters:**
- `ApplicationMode mode`

### SetUIMode

```csharp
/// <summary>
        /// Sets UI mode with validation and transition logic
        /// </summary>
        public bool SetUIMode(UIMode mode)
        {
            if (!_transitionManager.CanTransitionTo(mode))
                return false;
                
            var oldMode = _modeState.CurrentUIMode;
            if (oldMode == mode)
                return true;
                
            _transitionManager.StartTransition();
            _transitionManager.RecordTransition("UIMode", oldMode.ToString(), mode.ToString());
            
            // Publish transition started event
            _eventDispatcher.Publish(this, new ModeTransitionStartedEvent("UIMode", oldMode.ToString(), mode.ToString()));
            
            _modeState.CurrentUIMode = mode;
            
            // Update mode context
            _transitionManager.UpdateModeContext($"UI:{mode}");
            
            // Apply mode-specific settings
            var settings = _settingsManager.GetModeSettings(mode);
            ApplyModeSettings(settings);
            
            // Publish mode changed event
            _eventDispatcher.Publish(this, new UIModeChangedEvent(oldMode, mode));
            
            OnUIModeChanged(oldMode, mode);
            
            _transitionManager.EndTransition();
            
            // Publish transition completed event
            _eventDispatcher.Publish(this, new ModeTransitionCompletedEvent("UIMode", oldMode.ToString(), mode.ToString()));
            
            return true;
        }
```

Sets UI mode with validation and transition logic

**Returns:** `bool`

**Parameters:**
- `UIMode mode`

### SetEditMode

```csharp
/// <summary>
        /// Sets edit mode with validation and transition logic
        /// </summary>
        public bool SetEditMode(EditMode mode)
        {
            if (!_transitionManager.CanTransitionTo(mode))
                return false;
                
            var oldMode = _modeState.CurrentEditMode;
            if (oldMode == mode)
                return true;
                
            _transitionManager.StartTransition();
            _transitionManager.RecordTransition("EditMode", oldMode.ToString(), mode.ToString());
            
            // Publish transition started event
            _eventDispatcher.Publish(this, new ModeTransitionStartedEvent("EditMode", oldMode.ToString(), mode.ToString()));
            
            _modeState.CurrentEditMode = mode;
            
            // Update mode context
            _transitionManager.UpdateModeContext($"Edit:{mode}");
            
            // Apply mode-specific settings
            var settings = _settingsManager.GetModeSettings(mode);
            ApplyModeSettings(settings);
            
            // Publish mode changed event
            _eventDispatcher.Publish(this, new EditModeChangedEvent(oldMode, mode));
            
            OnEditModeChanged(oldMode, mode);
            
            _transitionManager.EndTransition();
            
            // Publish transition completed event
            _eventDispatcher.Publish(this, new ModeTransitionCompletedEvent("EditMode", oldMode.ToString(), mode.ToString()));
            
            return true;
        }
```

Sets edit mode with validation and transition logic

**Returns:** `bool`

**Parameters:**
- `EditMode mode`

### SetViewMode

```csharp
/// <summary>
        /// Sets view mode with validation and transition logic
        /// </summary>
        public bool SetViewMode(ViewMode mode)
        {
            if (!_transitionManager.CanTransitionTo(mode))
                return false;
                
            var oldMode = _modeState.CurrentViewMode;
            if (oldMode == mode)
                return true;
                
            _transitionManager.StartTransition();
            _transitionManager.RecordTransition("ViewMode", oldMode.ToString(), mode.ToString());
            
            // Publish transition started event
            _eventDispatcher.Publish(this, new ModeTransitionStartedEvent("ViewMode", oldMode.ToString(), mode.ToString()));
            
            _modeState.CurrentViewMode = mode;
            
            // Update mode context
            _transitionManager.UpdateModeContext($"View:{mode}");
            
            // Apply mode-specific settings
            var settings = _settingsManager.GetModeSettings(mode);
            ApplyModeSettings(settings);
            
            // Publish mode changed event
            _eventDispatcher.Publish(this, new ViewModeChangedEvent(oldMode, mode));
            
            OnViewModeChanged(oldMode, mode);
            
            _transitionManager.EndTransition();
            
            // Publish transition completed event
            _eventDispatcher.Publish(this, new ModeTransitionCompletedEvent("ViewMode", oldMode.ToString(), mode.ToString()));
            
            return true;
        }
```

Sets view mode with validation and transition logic

**Returns:** `bool`

**Parameters:**
- `ViewMode mode`

### SetGameMode

```csharp
/// <summary>
        /// Sets game mode with validation and transition logic
        /// </summary>
        public bool SetGameMode(GameMode mode)
        {
            if (!_transitionManager.CanTransitionTo(mode))
                return false;
                
            var oldMode = _modeState.CurrentGameMode;
            if (oldMode == mode)
                return true;
                
            _transitionManager.StartTransition();
            _transitionManager.RecordTransition("GameMode", oldMode.ToString(), mode.ToString());
            
            // Publish transition started event
            _eventDispatcher.Publish(this, new ModeTransitionStartedEvent("GameMode", oldMode.ToString(), mode.ToString()));
            
            _modeState.CurrentGameMode = mode;
            
            // Update mode context
            _transitionManager.UpdateModeContext($"Game:{mode}");
            
            // Apply mode-specific settings
            var settings = _settingsManager.GetModeSettings(mode);
            ApplyModeSettings(settings);
            
            // Publish mode changed event
            _eventDispatcher.Publish(this, new GameModeChangedEvent(oldMode, mode));
            
            OnGameModeChanged(oldMode, mode);
            
            _transitionManager.EndTransition();
            
            // Publish transition completed event
            _eventDispatcher.Publish(this, new ModeTransitionCompletedEvent("GameMode", oldMode.ToString(), mode.ToString()));
            
            return true;
        }
```

Sets game mode with validation and transition logic

**Returns:** `bool`

**Parameters:**
- `GameMode mode`

### SetModes

```csharp
/// <summary>
        /// Sets multiple modes at once
        /// </summary>
        public bool SetModes(ApplicationMode? appMode = null, UIMode? uiMode = null, 
                           EditMode? editMode = null, ViewMode? viewMode = null, GameMode? gameMode = null)
        {
            var changed = false;
            
            if (appMode.HasValue && appMode.Value != _modeState.CurrentApplicationMode)
            {
                if (!SetApplicationMode(appMode.Value))
                    return false;
                changed = true;
            }
            
            if (uiMode.HasValue && uiMode.Value != _modeState.CurrentUIMode)
            {
                if (!SetUIMode(uiMode.Value))
                    return false;
                changed = true;
            }
            
            if (editMode.HasValue && editMode.Value != _modeState.CurrentEditMode)
            {
                if (!SetEditMode(editMode.Value))
                    return false;
                changed = true;
            }
            
            if (viewMode.HasValue && viewMode.Value != _modeState.CurrentViewMode)
            {
                if (!SetViewMode(viewMode.Value))
                    return false;
                changed = true;
            }
            
            if (gameMode.HasValue && gameMode.Value != _modeState.CurrentGameMode)
            {
                if (!SetGameMode(gameMode.Value))
                    return false;
                changed = true;
            }
            
            return changed;
        }
```

Sets multiple modes at once

**Returns:** `bool`

**Parameters:**
- `ApplicationMode? appMode`
- `UIMode? uiMode`
- `EditMode? editMode`
- `ViewMode? viewMode`
- `GameMode? gameMode`

### SetModeData

```csharp
#endregion
        
        #region Mode Data Management
        
        /// <summary>
        /// Sets mode-specific data
        /// </summary>
        public void SetModeData(string key, object value)
        {
            // This would be handled by a separate data manager if needed
            // For now, this is a placeholder for the functionality
        }
```

Sets mode-specific data

**Returns:** `void`

**Parameters:**
- `string key`
- `object value`

### GetModeData

```csharp
/// <summary>
        /// Gets mode-specific data
        /// </summary>
        public T GetModeData<T>(string key, T defaultValue = default)
        {
            // This would be handled by a separate data manager if needed
            // For now, this is a placeholder for the functionality
            return defaultValue;
        }
```

Gets mode-specific data

**Returns:** `T`

**Parameters:**
- `string key`
- `T defaultValue`

### HasModeData

```csharp
/// <summary>
        /// Checks if mode data exists
        /// </summary>
        public bool HasModeData(string key)
        {
            // This would be handled by a separate data manager if needed
            // For now, this is a placeholder for the functionality
            return false;
        }
```

Checks if mode data exists

**Returns:** `bool`

**Parameters:**
- `string key`

### RemoveModeData

```csharp
/// <summary>
        /// Removes mode data
        /// </summary>
        public bool RemoveModeData(string key)
        {
            // This would be handled by a separate data manager if needed
            // For now, this is a placeholder for the functionality
            return false;
        }
```

Removes mode data

**Returns:** `bool`

**Parameters:**
- `string key`

### Clone

```csharp
#endregion
        
        #region Utility Methods
        
        /// <summary>
        /// Creates a deep copy of the current mode service
        /// </summary>
        public ModeService Clone()
        {
            var clonedState = (ModeState)_modeState.Clone();
            var clonedService = new ModeService(clonedState);
            
            // Copy transition history
            foreach (var transition in _transitionManager.TransitionHistory)
            {
                clonedService._transitionManager.RecordTransition(
                    transition.ModeType, 
                    transition.FromMode, 
                    transition.ToMode
                );
            }
            
            return clonedService;
        }
```

Creates a deep copy of the current mode service

**Returns:** `ModeService`

### Validate

```csharp
/// <summary>
        /// Validates the complete mode service state
        /// </summary>
        public List<string> Validate()
        {
            var errors = new List<string>();
            
            // Validate state
            errors.AddRange(_modeState.Validate());
            
            // Validate transition manager state
            if (_transitionManager.LastTransitionTime > Time.GetUnixTimeFromSystem())
                errors.Add("LastTransitionTime cannot be in the future");
                
            if (string.IsNullOrEmpty(_transitionManager.CurrentModeContext))
                errors.Add("CurrentModeContext cannot be empty");
            
            return errors;
        }
```

Validates the complete mode service state

**Returns:** `List<string>`

### ToString

```csharp
/// <summary>
        /// Gets a string representation of the mode service
        /// </summary>
        public override string ToString()
        {
            return $"ModeService({_modeState.CombinedModeString}) - Transitions: {_transitionManager.TransitionHistory.Count}";
        }
```

Gets a string representation of the mode service

**Returns:** `string`

