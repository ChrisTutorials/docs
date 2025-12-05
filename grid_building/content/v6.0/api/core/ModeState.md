---
title: "ModeState"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/modestate/"
---

# ModeState

```csharp
GridBuilding.Core.State.Mode
class ModeState
{
    // Members...
}
```

Core mode state data - pure data container only
Contains only the current mode values and basic data operations
No business logic, validation, or event dispatching

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Mode/ModeState.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### StateId

```csharp
#endregion
        
        #region Public Properties
        
        /// <summary>
        /// Unique identifier for this state
        /// </summary>
        public string StateId => _stateId;
```

Unique identifier for this state

### CreatedAt

```csharp
/// <summary>
        /// Timestamp when this state was created
        /// </summary>
        public DateTime CreatedAt => _createdAt;
```

Timestamp when this state was created

### UpdatedAt

```csharp
/// <summary>
        /// Timestamp when this state was last updated
        /// </summary>
        public DateTime UpdatedAt => _updatedAt;
```

Timestamp when this state was last updated

### IsValid

```csharp
/// <summary>
        /// Whether this state is valid (basic data integrity only)
        /// </summary>
        public bool IsValid => !string.IsNullOrEmpty(_stateId);
```

Whether this state is valid (basic data integrity only)

### CurrentApplicationMode

```csharp
/// <summary>
        /// Current application mode
        /// </summary>
        public ApplicationMode CurrentApplicationMode
        {
            get => _currentApplicationMode;
            set
            {
                _currentApplicationMode = value;
                UpdateTimestamp();
            }
        }
```

Current application mode

### CurrentUIMode

```csharp
/// <summary>
        /// Current UI mode
        /// </summary>
        public UIMode CurrentUIMode
        {
            get => _currentUIMode;
            set
            {
                _currentUIMode = value;
                UpdateTimestamp();
            }
        }
```

Current UI mode

### CurrentEditMode

```csharp
/// <summary>
        /// Current edit mode
        /// </summary>
        public EditMode CurrentEditMode
        {
            get => _currentEditMode;
            set
            {
                _currentEditMode = value;
                UpdateTimestamp();
            }
        }
```

Current edit mode

### CurrentViewMode

```csharp
/// <summary>
        /// Current view mode
        /// </summary>
        public ViewMode CurrentViewMode
        {
            get => _currentViewMode;
            set
            {
                _currentViewMode = value;
                UpdateTimestamp();
            }
        }
```

Current view mode

### CurrentGameMode

```csharp
/// <summary>
        /// Current game mode
        /// </summary>
        public GameMode CurrentGameMode
        {
            get => _currentGameMode;
            set
            {
                _currentGameMode = value;
                UpdateTimestamp();
            }
        }
```

Current game mode

### CombinedModeString

```csharp
/// <summary>
        /// Combined mode string for easy display
        /// </summary>
        public string CombinedModeString => $"{_currentApplicationMode}|{_currentUIMode}|{_currentEditMode}|{_currentViewMode}|{_currentGameMode}";
```

Combined mode string for easy display


## Methods

### Clone

```csharp
#endregion
        
        #region IState Implementation
        
        /// <summary>
        /// Creates a deep copy of this state (pure data operation)
        /// </summary>
        /// <returns>A new state instance with the same data</returns>
        public IState Clone()
        {
            var clone = new ModeState
            {
                _currentApplicationMode = _currentApplicationMode,
                _currentUIMode = _currentUIMode,
                _currentEditMode = _currentEditMode,
                _currentViewMode = _currentViewMode,
                _currentGameMode = _currentGameMode,
                _createdAt = _createdAt,
                _updatedAt = _updatedAt,
                _stateId = Guid.NewGuid().ToString() // New ID for clone
            };
            
            return clone;
        }
```

Creates a deep copy of this state (pure data operation)

**Returns:** `IState`

### UpdateTimestamp

```csharp
/// <summary>
        /// Updates the internal timestamp (data operation only)
        /// </summary>
        public void UpdateTimestamp()
        {
            _updatedAt = DateTime.UtcNow;
        }
```

Updates the internal timestamp (data operation only)

**Returns:** `void`

### Validate

```csharp
/// <summary>
        /// Validates basic data integrity (data validation only)
        /// Note: Business logic validation should be handled by services
        /// </summary>
        /// <returns>List of data validation errors</returns>
        public List<string> Validate()
        {
            var errors = new List<string>();
            
            if (string.IsNullOrEmpty(_stateId))
                errors.Add("StateId cannot be null or empty");
                
            if (_createdAt > _updatedAt)
                errors.Add("CreatedAt cannot be after UpdatedAt");
            
            return errors;
        }
```

Validates basic data integrity (data validation only)
Note: Business logic validation should be handled by services

**Returns:** `List<string>`

### Create

```csharp
#endregion
        
        #region Static Factory Methods
        
        /// <summary>
        /// Creates a new mode state with default values
        /// </summary>
        public static ModeState Create(ApplicationMode appMode = ApplicationMode.Building)
        {
            return new ModeState
            {
                _currentApplicationMode = appMode
            };
        }
```

Creates a new mode state with default values

**Returns:** `ModeState`

**Parameters:**
- `ApplicationMode appMode`

### CreateFromTemplate

```csharp
/// <summary>
        /// Creates a mode state from template
        /// </summary>
        public static ModeState CreateFromTemplate(ModeState template)
        {
            var state = (ModeState)template.Clone();
            return state;
        }
```

Creates a mode state from template

**Returns:** `ModeState`

**Parameters:**
- `ModeState template`

### SetModes

```csharp
#endregion
        
        #region Public Methods
        
        /// <summary>
        /// Sets multiple modes at once (data operation only)
        /// </summary>
        public void SetModes(ApplicationMode? appMode = null, UIMode? uiMode = null, 
                           EditMode? editMode = null, ViewMode? viewMode = null, GameMode? gameMode = null)
        {
            var changed = false;
            
            if (appMode.HasValue && appMode.Value != _currentApplicationMode)
            {
                _currentApplicationMode = appMode.Value;
                changed = true;
            }
            
            if (uiMode.HasValue && uiMode.Value != _currentUIMode)
            {
                _currentUIMode = uiMode.Value;
                changed = true;
            }
            
            if (editMode.HasValue && editMode.Value != _currentEditMode)
            {
                _currentEditMode = editMode.Value;
                changed = true;
            }
            
            if (viewMode.HasValue && viewMode.Value != _currentViewMode)
            {
                _currentViewMode = viewMode.Value;
                changed = true;
            }
            
            if (gameMode.HasValue && gameMode.Value != _currentGameMode)
            {
                _currentGameMode = gameMode.Value;
                changed = true;
            }
            
            if (changed)
                UpdateTimestamp();
        }
```

Sets multiple modes at once (data operation only)

**Returns:** `void`

**Parameters:**
- `ApplicationMode? appMode`
- `UIMode? uiMode`
- `EditMode? editMode`
- `ViewMode? viewMode`
- `GameMode? gameMode`

### ToString

```csharp
/// <summary>
        /// Gets a string representation of the mode state
        /// </summary>
        public override string ToString()
        {
            return $"ModeState({CombinedModeString}) - Updated: {_updatedAt:u}";
        }
```

Gets a string representation of the mode state

**Returns:** `string`

