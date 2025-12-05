---
title: "UserState"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/userstate/"
---

# UserState

```csharp
GridBuilding.Core.State.User
class UserState
{
    // Members...
}
```

Core state data for user information and preferences
Contains pure C# data without Godot dependencies for unit testing
Manages user profile, settings, preferences, and session data

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/User/UserState.cs`  
**Namespace:** `GridBuilding.Core.State.User`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### UserId

```csharp
#endregion
        
        #region Public Properties
        
        /// <summary>
        /// Unique user identifier
        /// </summary>
        public string UserId
        {
            get => _userId;
            set => _userId = value ?? string.Empty;
        }
```

Unique user identifier

### Username

```csharp
/// <summary>
        /// User's login name
        /// </summary>
        public string Username
        {
            get => _username;
            set => _username = value ?? string.Empty;
        }
```

User's login name

### DisplayName

```csharp
/// <summary>
        /// Display name shown in UI
        /// </summary>
        public string DisplayName
        {
            get => _displayName;
            set => _displayName = value ?? string.Empty;
        }
```

Display name shown in UI

### Level

```csharp
/// <summary>
        /// User's current level
        /// </summary>
        public UserLevel Level
        {
            get => _level;
            set => _level = value;
        }
```

User's current level

### Experience

```csharp
/// <summary>
        /// Total experience points
        /// </summary>
        public int Experience
        {
            get => _experience;
            set => _experience = MathUtils.Max(0, value);
        }
```

Total experience points

### TotalBuildingsPlaced

```csharp
/// <summary>
        /// Total number of buildings placed
        /// </summary>
        public int TotalBuildingsPlaced
        {
            get => _totalBuildingsPlaced;
            set => _totalBuildingsPlaced = MathUtils.Max(0, value);
        }
```

Total number of buildings placed

### TotalBuildingsRemoved

```csharp
/// <summary>
        /// Total number of buildings removed
        /// </summary>
        public int TotalBuildingsRemoved
        {
            get => _totalBuildingsRemoved;
            set => _totalBuildingsRemoved = MathUtils.Max(0, value);
        }
```

Total number of buildings removed

### TotalPlayTime

```csharp
/// <summary>
        /// Total play time in seconds
        /// </summary>
        public int TotalPlayTime
        {
            get => _totalPlayTime;
            set => _totalPlayTime = MathUtils.Max(0, value);
        }
```

Total play time in seconds

### LastLoginTime

```csharp
/// <summary>
        /// Unix timestamp of last login
        /// </summary>
        public double LastLoginTime
        {
            get => _lastLoginTime;
            set => _lastLoginTime = value;
        }
```

Unix timestamp of last login

### SessionStartTime

```csharp
/// <summary>
        /// Unix timestamp when current session started
        /// </summary>
        public double SessionStartTime
        {
            get => _sessionStartTime;
            set => _sessionStartTime = value;
        }
```

Unix timestamp when current session started

### TotalSessionTime

```csharp
/// <summary>
        /// Total session time in seconds
        /// </summary>
        public double TotalSessionTime
        {
            get => _totalSessionTime;
            set => _totalSessionTime = MathUtils.Max(0, value);
        }
```

Total session time in seconds

### Preferences

```csharp
/// <summary>
        /// User preferences and settings
        /// </summary>
        public Dictionary<string, object> Preferences
        {
            get => _preferences;
            set => _preferences = value ?? new Dictionary<string, object>();
        }
```

User preferences and settings

### Statistics

```csharp
/// <summary>
        /// User statistics and metrics
        /// </summary>
        public Dictionary<string, object> Statistics
        {
            get => _statistics;
            set => _statistics = value ?? new Dictionary<string, object>();
        }
```

User statistics and metrics

### Achievements

```csharp
/// <summary>
        /// List of earned achievements
        /// </summary>
        public List<UserAchievement> Achievements
        {
            get => _achievements;
            set => _achievements = value ?? new List<UserAchievement>();
        }
```

List of earned achievements

### UnlockedBuildings

```csharp
/// <summary>
        /// List of unlocked building types
        /// </summary>
        public List<string> UnlockedBuildings
        {
            get => _unlockedBuildings;
            set => _unlockedBuildings = value ?? new List<string>();
        }
```

List of unlocked building types

### CompletedTutorials

```csharp
/// <summary>
        /// List of completed tutorials
        /// </summary>
        public List<string> CompletedTutorials
        {
            get => _completedTutorials;
            set => _completedTutorials = value ?? new List<string>();
        }
```

List of completed tutorials

### Permissions

```csharp
/// <summary>
        /// User permissions level
        /// </summary>
        public UserPermissions Permissions
        {
            get => _permissions;
            set => _permissions = value;
        }
```

User permissions level

### Settings

```csharp
/// <summary>
        /// User settings configuration
        /// </summary>
        public UserSettings Settings
        {
            get => _settings;
            set => _settings = value ?? new UserSettings();
        }
```

User settings configuration

### Inventory

```csharp
/// <summary>
        /// User inventory and resources
        /// </summary>
        public UserInventory Inventory
        {
            get => _inventory;
            set => _inventory = value ?? new UserInventory();
        }
```

User inventory and resources

### IsGuest

```csharp
/// <summary>
        /// Whether this is a guest user
        /// </summary>
        public bool IsGuest
        {
            get => _isGuest;
            set => _isGuest = value;
        }
```

Whether this is a guest user

### IsOnline

```csharp
/// <summary>
        /// Whether the user is currently online
        /// </summary>
        public bool IsOnline
        {
            get => _isOnline;
            set => _isOnline = value;
        }
```

Whether the user is currently online

### LastSaveId

```csharp
/// <summary>
        /// ID of the last save
        /// </summary>
        public string LastSaveId
        {
            get => _lastSaveId;
            set => _lastSaveId = value ?? string.Empty;
        }
```

ID of the last save

### LastSaveTime

```csharp
/// <summary>
        /// Unix timestamp of last save
        /// </summary>
        public double LastSaveTime
        {
            get => _lastSaveTime;
            set => _lastSaveTime = value;
        }
```

Unix timestamp of last save

### ExperienceToNextLevel

```csharp
#endregion
        
        #region Computed Properties
        
        /// <summary>
        /// Experience needed for next level
        /// </summary>
        public int ExperienceToNextLevel => GetExperienceForLevel(_level + 1) - _experience;
```

Experience needed for next level

### LevelProgress

```csharp
/// <summary>
        /// Progress towards next level (0.0 to 1.0)
        /// </summary>
        public float LevelProgress
        {
            get
            {
                var currentLevelExp = GetExperienceForLevel(_level);
                var nextLevelExp = GetExperienceForLevel(_level + 1);
                var expRange = nextLevelExp - currentLevelExp;
                
                if (expRange <= 0)
                    return 1.0f;
                    
                return MathUtils.Clamp((float)(_experience - currentLevelExp) / expRange, 0.0f, 1.0f);
            }
        }
```

Progress towards next level (0.0 to 1.0)

### CurrentSessionDuration

```csharp
/// <summary>
        /// Current session duration in seconds
        /// </summary>
        public double CurrentSessionDuration
        {
            get
            {
                if (_sessionStartTime <= 0)
                    return 0.0;
                    
                return TimeUtils.GetUnixTimePrecise() - _sessionStartTime;
            }
        }
```

Current session duration in seconds

### HasCompletedTutorials

```csharp
/// <summary>
        /// Whether the user has completed any tutorials
        /// </summary>
        public bool HasCompletedTutorials => _completedTutorials.Count > 0;
```

Whether the user has completed any tutorials

### HasAchievements

```csharp
/// <summary>
        /// Whether the user has any achievements
        /// </summary>
        public bool HasAchievements => _achievements.Count > 0;
```

Whether the user has any achievements

### HasUnlockedBuildings

```csharp
/// <summary>
        /// Whether the user has unlocked any buildings
        /// </summary>
        public bool HasUnlockedBuildings => _unlockedBuildings.Count > 0;
```

Whether the user has unlocked any buildings

### TotalBuildingsModified

```csharp
/// <summary>
        /// Total buildings modified (placed + removed)
        /// </summary>
        public int TotalBuildingsModified => _totalBuildingsPlaced + _totalBuildingsRemoved;
```

Total buildings modified (placed + removed)

### BuildingsPerHour

```csharp
/// <summary>
        /// Buildings per hour ratio
        /// </summary>
        public float BuildingsPerHour
        {
            get
            {
                if (_totalPlayTime <= 0)
                    return 0.0f;
                    
                var hours = _totalPlayTime / 3600.0f;
                return _totalBuildingsPlaced / hours;
            }
        }
```

Buildings per hour ratio


## Methods

### AddExperience

```csharp
#endregion
        
        #region Public Methods
        
        /// <summary>
        /// Adds experience points to the user
        /// </summary>
        public void AddExperience(int amount)
        {
            if (amount <= 0)
                return;
                
            var oldLevel = _level;
            _experience += amount;
            
            // Check for level up
            var newLevel = CalculateLevel(_experience);
            if (newLevel > oldLevel)
            {
                _level = newLevel;
                OnLevelUp(oldLevel, newLevel);
            }
        }
```

Adds experience points to the user

**Returns:** `void`

**Parameters:**
- `int amount`

### RecordBuildingPlacement

```csharp
/// <summary>
        /// Records a building placement
        /// </summary>
        public void RecordBuildingPlacement(string buildingType)
        {
            _totalBuildingsPlaced++;
            
            // Update statistics
            SetStatistic("buildings_placed", _totalBuildingsPlaced);
            SetStatistic($"buildings_placed_{buildingType}", GetStatistic<int>($"buildings_placed_{buildingType}", 0) + 1);
            
            // Add experience
            AddExperience(GetExperienceForBuildingPlacement(buildingType));
        }
```

Records a building placement

**Returns:** `void`

**Parameters:**
- `string buildingType`

### RecordBuildingRemoval

```csharp
/// <summary>
        /// Records a building removal
        /// </summary>
        public void RecordBuildingRemoval(string buildingType)
        {
            _totalBuildingsRemoved++;
            
            // Update statistics
            SetStatistic("buildings_removed", _totalBuildingsRemoved);
            SetStatistic($"buildings_removed_{buildingType}", GetStatistic<int>($"buildings_removed_{buildingType}", 0) + 1);
            
            // Add small amount of experience
            AddExperience(1);
        }
```

Records a building removal

**Returns:** `void`

**Parameters:**
- `string buildingType`

### StartSession

```csharp
/// <summary>
        /// Starts a new session
        /// </summary>
        public void StartSession()
        {
            _sessionStartTime = TimeUtils.GetUnixTimePrecise();
            _lastLoginTime = _sessionStartTime;
            SetStatistic("sessions_started", GetStatistic<int>("sessions_started", 0) + 1);
        }
```

Starts a new session

**Returns:** `void`

### EndSession

```csharp
/// <summary>
        /// Ends the current session
        /// </summary>
        public void EndSession()
        {
            if (_sessionStartTime <= 0)
                return;
                
            var sessionDuration = TimeUtils.GetUnixTimePrecise() - _sessionStartTime;
            _totalSessionTime += sessionDuration;
            _totalPlayTime += (int)sessionDuration;
            
            SetStatistic("total_session_time", _totalSessionTime);
            SetStatistic("total_play_time", _totalPlayTime);
            SetStatistic("average_session_time", _totalSessionTime / GetStatistic<int>("sessions_started", 1));
            
            _sessionStartTime = 0.0;
        }
```

Ends the current session

**Returns:** `void`

### UnlockBuilding

```csharp
/// <summary>
        /// Unlocks a building type
        /// </summary>
        public bool UnlockBuilding(string buildingType)
        {
            if (_unlockedBuildings.Contains(buildingType))
                return false;
                
            _unlockedBuildings.Add(buildingType);
            SetStatistic("buildings_unlocked", _unlockedBuildings.Count);
            
            // Add experience for unlocking
            AddExperience(GetExperienceForBuildingUnlock(buildingType));
            
            return true;
        }
```

Unlocks a building type

**Returns:** `bool`

**Parameters:**
- `string buildingType`

### IsBuildingUnlocked

```csharp
/// <summary>
        /// Checks if a building type is unlocked
        /// </summary>
        public bool IsBuildingUnlocked(string buildingType)
        {
            return _unlockedBuildings.Contains(buildingType);
        }
```

Checks if a building type is unlocked

**Returns:** `bool`

**Parameters:**
- `string buildingType`

### CompleteTutorial

```csharp
/// <summary>
        /// Completes a tutorial
        /// </summary>
        public bool CompleteTutorial(string tutorialId)
        {
            if (_completedTutorials.Contains(tutorialId))
                return false;
                
            _completedTutorials.Add(tutorialId);
            SetStatistic("tutorials_completed", _completedTutorials.Count);
            
            // Add experience for completing tutorial
            AddExperience(GetExperienceForTutorial(tutorialId));
            
            return true;
        }
```

Completes a tutorial

**Returns:** `bool`

**Parameters:**
- `string tutorialId`

### IsTutorialCompleted

```csharp
/// <summary>
        /// Checks if a tutorial is completed
        /// </summary>
        public bool IsTutorialCompleted(string tutorialId)
        {
            return _completedTutorials.Contains(tutorialId);
        }
```

Checks if a tutorial is completed

**Returns:** `bool`

**Parameters:**
- `string tutorialId`

### AddAchievement

```csharp
/// <summary>
        /// Adds an achievement
        /// </summary>
        public bool AddAchievement(UserAchievement achievement)
        {
            if (achievement == null)
                return false;
                
            // Check if already earned
            var existing = _achievements.Find(a => a.Id == achievement.Id);
            if (existing != null)
                return false;
                
            _achievements.Add(achievement);
            SetStatistic("achievements_earned", _achievements.Count);
            
            // Add experience for achievement
            AddExperience(achievement.ExperienceReward);
            
            return true;
        }
```

Adds an achievement

**Returns:** `bool`

**Parameters:**
- `UserAchievement achievement`

### HasAchievement

```csharp
/// <summary>
        /// Checks if an achievement is earned
        /// </summary>
        public bool HasAchievement(string achievementId)
        {
            return _achievements.Exists(a => a.Id == achievementId);
        }
```

Checks if an achievement is earned

**Returns:** `bool`

**Parameters:**
- `string achievementId`

### GetAchievement

```csharp
/// <summary>
        /// Gets an achievement by ID
        /// </summary>
        public UserAchievement? GetAchievement(string achievementId)
        {
            return _achievements.Find(a => a.Id == achievementId);
        }
```

Gets an achievement by ID

**Returns:** `UserAchievement?`

**Parameters:**
- `string achievementId`

### SetPreference

```csharp
/// <summary>
        /// Sets a preference value
        /// </summary>
        public void SetPreference(string key, object value)
        {
            _preferences[key] = value;
        }
```

Sets a preference value

**Returns:** `void`

**Parameters:**
- `string key`
- `object value`

### GetPreference

```csharp
/// <summary>
        /// Gets a preference value
        /// </summary>
        public T GetPreference<T>(string key, T defaultValue = default)
        {
            if (_preferences.TryGetValue(key, out var value) && value is T typedValue)
            {
                return typedValue;
            }
            return defaultValue;
        }
```

Gets a preference value

**Returns:** `T`

**Parameters:**
- `string key`
- `T defaultValue`

### HasPreference

```csharp
/// <summary>
        /// Checks if a preference exists
        /// </summary>
        public bool HasPreference(string key)
        {
            return _preferences.ContainsKey(key);
        }
```

Checks if a preference exists

**Returns:** `bool`

**Parameters:**
- `string key`

### RemovePreference

```csharp
/// <summary>
        /// Removes a preference
        /// </summary>
        public bool RemovePreference(string key)
        {
            return _preferences.Remove(key);
        }
```

Removes a preference

**Returns:** `bool`

**Parameters:**
- `string key`

### SetStatistic

```csharp
/// <summary>
        /// Sets a statistic value
        /// </summary>
        public void SetStatistic(string key, object value)
        {
            _statistics[key] = value;
        }
```

Sets a statistic value

**Returns:** `void`

**Parameters:**
- `string key`
- `object value`

### GetStatistic

```csharp
/// <summary>
        /// Gets a statistic value
        /// </summary>
        public T GetStatistic<T>(string key, T defaultValue = default)
        {
            if (_statistics.TryGetValue(key, out var value) && value is T typedValue)
            {
                return typedValue;
            }
            return defaultValue;
        }
```

Gets a statistic value

**Returns:** `T`

**Parameters:**
- `string key`
- `T defaultValue`

### IncrementStatistic

```csharp
/// <summary>
        /// Increments a numeric statistic
        /// </summary>
        public void IncrementStatistic(string key, int amount = 1)
        {
            var current = GetStatistic<int>(key, 0);
            SetStatistic(key, current + amount);
        }
```

Increments a numeric statistic

**Returns:** `void`

**Parameters:**
- `string key`
- `int amount`

### HasStatistic

```csharp
/// <summary>
        /// Checks if a statistic exists
        /// </summary>
        public bool HasStatistic(string key)
        {
            return _statistics.ContainsKey(key);
        }
```

Checks if a statistic exists

**Returns:** `bool`

**Parameters:**
- `string key`

### RemoveStatistic

```csharp
/// <summary>
        /// Removes a statistic
        /// </summary>
        public bool RemoveStatistic(string key)
        {
            return _statistics.Remove(key);
        }
```

Removes a statistic

**Returns:** `bool`

**Parameters:**
- `string key`

### UpdateLastSave

```csharp
/// <summary>
        /// Updates the last save information
        /// </summary>
        public void UpdateLastSave(string saveId)
        {
            _lastSaveId = saveId;
            _lastSaveTime = TimeUtils.GetUnixTimePrecise();
        }
```

Updates the last save information

**Returns:** `void`

**Parameters:**
- `string saveId`

### Clone

```csharp
/// <summary>
        /// Creates a deep copy of this user state
        /// </summary>
        public UserState Clone()
        {
            var clone = new UserState();
            clone._userId = _userId;
            clone._username = _username;
            clone._displayName = _displayName;
            clone._level = _level;
            clone._experience = _experience;
            clone._totalBuildingsPlaced = _totalBuildingsPlaced;
            clone._totalBuildingsRemoved = _totalBuildingsRemoved;
            clone._totalPlayTime = _totalPlayTime;
            clone._lastLoginTime = _lastLoginTime;
            clone._sessionStartTime = _sessionStartTime;
            clone._totalSessionTime = _totalSessionTime;
            clone._preferences = new Dictionary<string, object>(_preferences);
            clone._statistics = new Dictionary<string, object>(_statistics);
            clone._achievements = new List<UserAchievement>(_achievements);
            clone._unlockedBuildings = new List<string>(_unlockedBuildings);
            clone._completedTutorials = new List<string>(_completedTutorials);
            clone._permissions = _permissions;
            clone._settings = _settings.Clone();
            clone._inventory = _inventory.Clone();
            clone._isGuest = _isGuest;
            clone._isOnline = _isOnline;
            clone._lastSaveId = _lastSaveId;
            clone._lastSaveTime = _lastSaveTime;
            
            return clone;
        }
```

Creates a deep copy of this user state

**Returns:** `UserState`

### Validate

```csharp
/// <summary>
        /// Validates the user state data
        /// </summary>
        public List<string> Validate()
        {
            var errors = new List<string>();
            
            if (string.IsNullOrEmpty(_userId))
                errors.Add("UserId cannot be empty");
                
            if (string.IsNullOrEmpty(_username))
                errors.Add("Username cannot be empty");
                
            if (_experience < 0)
                errors.Add("Experience cannot be negative");
                
            if (_totalBuildingsPlaced < 0)
                errors.Add("TotalBuildingsPlaced cannot be negative");
                
            if (_totalBuildingsRemoved < 0)
                errors.Add("TotalBuildingsRemoved cannot be negative");
                
            if (_totalPlayTime < 0)
                errors.Add("TotalPlayTime cannot be negative");
                
            if (_sessionStartTime > TimeUtils.GetUnixTimePrecise())
                errors.Add("SessionStartTime cannot be in the future");
            
            return errors;
        }
```

Validates the user state data

**Returns:** `List<string>`

### ToString

```csharp
/// <summary>
        /// Gets a string representation of the user state
        /// </summary>
        public override string ToString()
        {
            return $"UserState({_username} - Level {_level} - {_experience} XP - {_totalBuildingsPlaced} buildings)";
        }
```

Gets a string representation of the user state

**Returns:** `string`

### Create

```csharp
#endregion
        
        #region Static Factory Methods
        
        /// <summary>
        /// Creates a new user state
        /// </summary>
        public static UserState Create(string username)
        {
            return new UserState(username);
        }
```

Creates a new user state

**Returns:** `UserState`

**Parameters:**
- `string username`

### CreateGuest

```csharp
/// <summary>
        /// Creates a guest user state
        /// </summary>
        public static UserState CreateGuest()
        {
            var user = new UserState();
            user._isGuest = true;
            user._username = "Guest";
            user._displayName = "Guest User";
            user._userId = $"guest_{TimeUtils.GetUnixTimePrecise()}";
            return user;
        }
```

Creates a guest user state

**Returns:** `UserState`

### CreateFromTemplate

```csharp
/// <summary>
        /// Creates a user state from template
        /// </summary>
        public static UserState CreateFromTemplate(UserState template, string newUsername)
        {
            var user = new UserState(newUsername);
            user._level = template._level;
            user._experience = template._experience;
            user._preferences = new Dictionary<string, object>(template._preferences);
            user._settings = template._settings.Clone();
            user._permissions = template._permissions;
            
            return user;
        }
```

Creates a user state from template

**Returns:** `UserState`

**Parameters:**
- `UserState template`
- `string newUsername`

