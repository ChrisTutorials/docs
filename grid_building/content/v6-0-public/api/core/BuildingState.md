---
title: "BuildingState"
description: "Core state data for buildings in the grid system
Contains pure C# data without Godot dependencies for unit testing
Separates building logic from runtime visualization"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/buildingstate/"
---

# BuildingState

```csharp
GridBuilding.Core.State.Building
class BuildingState
{
    // Members...
}
```

Core state data for buildings in the grid system
Contains pure C# data without Godot dependencies for unit testing
Separates building logic from runtime visualization

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Building/BuildingState.cs`  
**Namespace:** `GridBuilding.Core.State.Building`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingId

```csharp
#endregion
        
        #region Public Properties
        
        /// <summary>
        /// Unique identifier for this building instance
        /// </summary>
        public string BuildingId
        {
            get => _buildingId;
            set => _buildingId = value ?? string.Empty;
        }
```

Unique identifier for this building instance

### BuildingType

```csharp
/// <summary>
        /// Type identifier for the building (e.g., "house", "farm", "workshop")
        /// </summary>
        public string BuildingType
        {
            get => _buildingType;
            set => _buildingType = value ?? string.Empty;
        }
```

Type identifier for the building (e.g., "house", "farm", "workshop")

### GridPosition

```csharp
/// <summary>
        /// Position of the building in grid coordinates
        /// </summary>
        public Vector2I GridPosition
        {
            get => _gridPosition;
            set => _gridPosition = value;
        }
```

Position of the building in grid coordinates

### Status

```csharp
/// <summary>
        /// Current status of the building
        /// </summary>
        public BuildingStatus Status
        {
            get => _status;
            set => _status = value;
        }
```

Current status of the building

### Health

```csharp
/// <summary>
        /// Current health of the building (0-100)
        /// </summary>
        public int Health
        {
            get => _health;
            set => _health = MathUtils.Clamp(value, 0, _maxHealth);
        }
```

Current health of the building (0-100)

### MaxHealth

```csharp
/// <summary>
        /// Maximum health of the building
        /// </summary>
        public int MaxHealth
        {
            get => _maxHealth;
            set => _maxHealth = MathUtils.Max(1, value);
        }
```

Maximum health of the building

### CustomData

```csharp
/// <summary>
        /// Custom data storage for building-specific properties
        /// </summary>
        public Dictionary<string, object> CustomData
        {
            get => _customData;
            set => _customData = value ?? new Dictionary<string, object>();
        }
```

Custom data storage for building-specific properties

### Tags

```csharp
/// <summary>
        /// Tags for categorizing and filtering buildings
        /// </summary>
        public List<string> Tags
        {
            get => _tags;
            set => _tags = value ?? new List<string>();
        }
```

Tags for categorizing and filtering buildings

### CreatedTime

```csharp
/// <summary>
        /// Unix timestamp when this building was created
        /// </summary>
        public double CreatedTime
        {
            get => _createdTime;
            set => _createdTime = value;
        }
```

Unix timestamp when this building was created

### LastUpdated

```csharp
/// <summary>
        /// Unix timestamp when this building was last updated
        /// </summary>
        public double LastUpdated
        {
            get => _lastUpdated;
            set => _lastUpdated = value;
        }
```

Unix timestamp when this building was last updated

### OwnerId

```csharp
/// <summary>
        /// ID of the player/user who owns this building
        /// </summary>
        public string OwnerId
        {
            get => _ownerId;
            set => _ownerId = value ?? string.Empty;
        }
```

ID of the player/user who owns this building

### Flags

```csharp
/// <summary>
        /// Various flags for building behavior
        /// </summary>
        public BuildingFlags Flags
        {
            get => _flags;
            set => _flags = value;
        }
```

Various flags for building behavior

### HealthPercentage

```csharp
#endregion
        
        #region Computed Properties
        
        /// <summary>
        /// Health as a percentage (0.0 to 1.0)
        /// </summary>
        public float HealthPercentage => _maxHealth > 0 ? (float)_health / _maxHealth : 0.0f;
```

Health as a percentage (0.0 to 1.0)

### IsOperational

```csharp
/// <summary>
        /// Whether the building is currently operational
        /// </summary>
        public bool IsOperational => _status == BuildingStatus.Operational && _health > 0;
```

Whether the building is currently operational

### IsUnderConstruction

```csharp
/// <summary>
        /// Whether the building is currently under construction
        /// </summary>
        public bool IsUnderConstruction => _status == BuildingStatus.UnderConstruction;
```

Whether the building is currently under construction

### IsDamaged

```csharp
/// <summary>
        /// Whether the building is currently damaged
        /// </summary>
        public bool IsDamaged => _health < _maxHealth && _health > 0;
```

Whether the building is currently damaged

### IsDestroyed

```csharp
/// <summary>
        /// Whether the building is destroyed
        /// </summary>
        public bool IsDestroyed => _health <= 0 || _status == BuildingStatus.Destroyed;
```

Whether the building is destroyed

### Age

```csharp
/// <summary>
        /// Age of the building in seconds
        /// </summary>
        public double Age => _createdTime > 0 ? DateTimeOffset.UtcNow.ToUnixTimeSeconds() - _createdTime : 0.0;
```

Age of the building in seconds

### IsInitialized

```csharp
#endregion
        
        #region IRuntimeState Implementation
        
        /// <summary>
        /// True once the building has been initialized (has a valid ID and type)
        /// </summary>
        public bool IsInitialized => !string.IsNullOrEmpty(_buildingId) && !string.IsNullOrEmpty(_buildingType);
```

True once the building has been initialized (has a valid ID and type)

### IsReady

```csharp
/// <summary>
        /// True when the building is ready to be used (operational and healthy)
        /// </summary>
        public bool IsReady => IsInitialized && IsOperational;
```

True when the building is ready to be used (operational and healthy)

### HasError

```csharp
/// <summary>
        /// True if the building has encountered an error condition (destroyed or invalid state)
        /// </summary>
        public bool HasError => IsDestroyed || _status == BuildingStatus.Destroyed;
```

True if the building has encountered an error condition (destroyed or invalid state)

### LastError

```csharp
/// <summary>
        /// Optional human-readable description of the last error, if any
        /// </summary>
        public string? LastError => HasError ? "Building is destroyed or in error state" : null;
```

Optional human-readable description of the last error, if any


## Methods

### UpdateTimestamp

```csharp
#endregion
        
        #region Data Methods (Pure Data Operations Only)
        
        /// <summary>
        /// Updates the last updated timestamp
        /// </summary>
        public void UpdateTimestamp()
        {
            _lastUpdated = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
        }
```

Updates the last updated timestamp

**Returns:** `void`

### SetCustomData

```csharp
/// <summary>
        /// Sets a custom data value (data operation only)
        /// </summary>
        public void SetCustomData(string key, object value)
        {
            _customData[key] = value;
            UpdateTimestamp();
        }
```

Sets a custom data value (data operation only)

**Returns:** `void`

**Parameters:**
- `string key`
- `object value`

### GetCustomData

```csharp
/// <summary>
        /// Gets a custom data value
        /// </summary>
        public T GetCustomData<T>(string key, T defaultValue = default)
        {
            if (_customData.TryGetValue(key, out var value) && value is T typedValue)
            {
                return typedValue;
            }
            return defaultValue;
        }
```

Gets a custom data value

**Returns:** `T`

**Parameters:**
- `string key`
- `T defaultValue`

### HasCustomData

```csharp
/// <summary>
        /// Checks if custom data exists
        /// </summary>
        public bool HasCustomData(string key)
        {
            return _customData.ContainsKey(key);
        }
```

Checks if custom data exists

**Returns:** `bool`

**Parameters:**
- `string key`

### RemoveCustomData

```csharp
/// <summary>
        /// Removes custom data
        /// </summary>
        public bool RemoveCustomData(string key)
        {
            var removed = _customData.Remove(key);
            if (removed)
            {
                UpdateTimestamp();
            }
            return removed;
        }
```

Removes custom data

**Returns:** `bool`

**Parameters:**
- `string key`

### AddTag

```csharp
/// <summary>
        /// Adds a tag to the building (data operation only)
        /// </summary>
        public void AddTag(string tag)
        {
            if (!string.IsNullOrEmpty(tag) && !_tags.Contains(tag))
            {
                _tags.Add(tag);
                UpdateTimestamp();
            }
        }
```

Adds a tag to the building (data operation only)

**Returns:** `void`

**Parameters:**
- `string tag`

### RemoveTag

```csharp
/// <summary>
        /// Removes a tag from the building (data operation only)
        /// </summary>
        public bool RemoveTag(string tag)
        {
            var removed = _tags.Remove(tag);
            if (removed)
            {
                UpdateTimestamp();
            }
            return removed;
        }
```

Removes a tag from the building (data operation only)

**Returns:** `bool`

**Parameters:**
- `string tag`

### HasTag

```csharp
/// <summary>
        /// Checks if the building has a specific tag
        /// </summary>
        public bool HasTag(string tag)
        {
            return _tags.Contains(tag);
        }
```

Checks if the building has a specific tag

**Returns:** `bool`

**Parameters:**
- `string tag`

### ApplyDamage

```csharp
/// <summary>
        /// Applies damage to the building (data operation only)
        /// Note: Business logic for status changes should be handled by BuildingService
        /// </summary>
        public void ApplyDamage(int damage)
        {
            if (damage > 0)
            {
                var previousHealth = _health;
                _health = MathUtils.Max(0, _health - damage);
                UpdateTimestamp();
            }
        }
```

Applies damage to the building (data operation only)
Note: Business logic for status changes should be handled by BuildingService

**Returns:** `void`

**Parameters:**
- `int damage`

### SetHealth

```csharp
/// <summary>
        /// Sets health directly (data operation only)
        /// </summary>
        public void SetHealth(int health)
        {
            _health = MathUtils.Clamp(health, 0, _maxHealth);
            UpdateTimestamp();
        }
```

Sets health directly (data operation only)

**Returns:** `void`

**Parameters:**
- `int health`

### SetStatus

```csharp
/// <summary>
        /// Sets the building status (data operation only)
        /// </summary>
        public void SetStatus(BuildingStatus status)
        {
            _status = status;
            UpdateTimestamp();
        }
```

Sets the building status (data operation only)

**Returns:** `void`

**Parameters:**
- `BuildingStatus status`

### Create

```csharp
#endregion
        
        #region Static Factory Methods
        
        /// <summary>
        /// Creates a new building state with default values
        /// </summary>
        public static BuildingState Create(string buildingType, Vector2I gridPosition)
        {
            return new BuildingState(buildingType, gridPosition);
        }
```

Creates a new building state with default values

**Returns:** `BuildingState`

**Parameters:**
- `string buildingType`
- `Vector2I gridPosition`

### CreateFromTemplate

```csharp
/// <summary>
        /// Creates a building state from template data
        /// </summary>
        public static BuildingState CreateFromTemplate(BuildingState template, Vector2I gridPosition)
        {
            var state = new BuildingState(template.BuildingType, gridPosition);
            state._maxHealth = template._maxHealth;
            state._health = template._maxHealth;
            state._customData = new Dictionary<string, object>(template._customData);
            state._tags = new List<string>(template._tags);
            state._flags = template._flags;
            state.UpdateTimestamp();
            
            return state;
        }
```

Creates a building state from template data

**Returns:** `BuildingState`

**Parameters:**
- `BuildingState template`
- `Vector2I gridPosition`

