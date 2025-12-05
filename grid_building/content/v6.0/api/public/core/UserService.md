---
title: "UserService"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/userservice/"
---

# UserService

```csharp
GridBuilding.Core.Services.User
class UserService
{
    // Members...
}
```

Service for user-related business logic and state management
Handles user progression, achievements, statistics, preferences, and session management

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/User/UserService.cs`  
**Namespace:** `GridBuilding.Core.Services.User`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateUser

```csharp
#endregion
        
        #region User Management
        
        public UserState CreateUser(string username, bool isGuest = false)
        {
            // Validate username
            if (string.IsNullOrWhiteSpace(username))
                throw new UserServiceException("Username cannot be empty");
            
            // Check for existing username
            if (_usersByUsername.ContainsKey(username))
                throw new UserServiceException($"Username '{username}' already exists");
            
            // Create user
            var user = isGuest ? UserState.CreateGuest() : UserState.Create(username);
            
            // Register user
            RegisterUser(user);
            
            // Dispatch event
            UserCreated?.Invoke(this, new UserCreatedEvent(user));
            
            return user;
        }
```

**Returns:** `UserState`

**Parameters:**
- `string username`
- `bool isGuest`

### GetUser

```csharp
public UserState? GetUser(string userId)
        {
            return _users.TryGetValue(userId, out var user) ? user : null;
        }
```

**Returns:** `UserState?`

**Parameters:**
- `string userId`

### GetUserByUsername

```csharp
public UserState? GetUserByUsername(string username)
        {
            return _usersByUsername.TryGetValue(username, out var user) ? user : null;
        }
```

**Returns:** `UserState?`

**Parameters:**
- `string username`

### DeleteUser

```csharp
public bool DeleteUser(string userId)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            // Remove from both dictionaries
            _users.Remove(userId);
            _usersByUsername.Remove(user.Username);
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`

### AddExperience

```csharp
#endregion
        
        #region Experience and Level Management
        
        public bool AddExperience(string userId, int amount)
        {
            if (!_users.TryGetValue(userId, out var user) || amount <= 0)
                return false;
            
            var previousExperience = user.Experience;
            var previousLevel = user.Level;
            
            // Add experience using state method (data manipulation)
            user.AddExperience(amount);
            
            // Dispatch experience gained event
            ExperienceGained?.Invoke(this, new ExperienceGainedEvent(user, amount, previousExperience, "Service"));
            
            // Check for level up
            if (user.Level > previousLevel)
            {
                UserLevelUp?.Invoke(this, new UserLevelUpEvent(user, previousLevel));
            }
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `int amount`

### SetExperience

```csharp
public bool SetExperience(string userId, int amount)
        {
            if (!_users.TryGetValue(userId, out var user) || amount < 0)
                return false;
            
            var previousExperience = user.Experience;
            var previousLevel = user.Level;
            
            user.Experience = amount;
            
            // Check for level up
            if (user.Level > previousLevel)
            {
                UserLevelUp?.Invoke(this, new UserLevelUpEvent(user, previousLevel));
            }
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `int amount`

### LevelUpUser

```csharp
public bool LevelUpUser(string userId)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            var previousLevel = user.Level;
            var nextLevel = user.Level + 1;
            
            if (nextLevel > UserLevel.Master)
                return false;
            
            var requiredExp = GetExperienceForLevel(nextLevel);
            return SetExperience(userId, requiredExp);
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`

### RecordBuildingPlacement

```csharp
#endregion
        
        #region Building Management
        
        public bool RecordBuildingPlacement(string userId, string buildingType)
        {
            if (!_users.TryGetValue(userId, out var user) || string.IsNullOrWhiteSpace(buildingType))
                return false;
            
            var previousBuildingsPlaced = user.TotalBuildingsPlaced;
            
            // Record placement using state method (data manipulation)
            user.RecordBuildingPlacement(buildingType);
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string buildingType`

### RecordBuildingRemoval

```csharp
public bool RecordBuildingRemoval(string userId, string buildingType)
        {
            if (!_users.TryGetValue(userId, out var user) || string.IsNullOrWhiteSpace(buildingType))
                return false;
            
            // Record removal using state method (data manipulation)
            user.RecordBuildingRemoval(buildingType);
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string buildingType`

### UnlockBuilding

```csharp
public bool UnlockBuilding(string userId, string buildingType)
        {
            if (!_users.TryGetValue(userId, out var user) || string.IsNullOrWhiteSpace(buildingType))
                return false;
            
            if (!user.IsBuildingUnlocked(buildingType))
            {
                var experienceReward = GetExperienceForBuildingUnlock(buildingType);
                
                // Unlock building using state method (data manipulation)
                var wasUnlocked = user.UnlockBuilding(buildingType);
                
                if (wasUnlocked)
                {
                    BuildingUnlocked?.Invoke(this, new BuildingUnlockedEvent(user, buildingType, experienceReward));
                }
                
                return wasUnlocked;
            }
            
            return false;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string buildingType`

### IsBuildingUnlocked

```csharp
public bool IsBuildingUnlocked(string userId, string buildingType)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            return user.IsBuildingUnlocked(buildingType);
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string buildingType`

### CompleteTutorial

```csharp
#endregion
        
        #region Tutorial Management
        
        public bool CompleteTutorial(string userId, string tutorialId)
        {
            if (!_users.TryGetValue(userId, out var user) || string.IsNullOrWhiteSpace(tutorialId))
                return false;
            
            if (!user.IsTutorialCompleted(tutorialId))
            {
                var experienceReward = GetExperienceForTutorial(tutorialId);
                
                // Complete tutorial using state method (data manipulation)
                var wasCompleted = user.CompleteTutorial(tutorialId);
                
                if (wasCompleted)
                {
                    TutorialCompleted?.Invoke(this, new TutorialCompletedEvent(user, tutorialId, experienceReward));
                }
                
                return wasCompleted;
            }
            
            return false;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string tutorialId`

### IsTutorialCompleted

```csharp
public bool IsTutorialCompleted(string userId, string tutorialId)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            return user.IsTutorialCompleted(tutorialId);
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string tutorialId`

### AwardAchievement

```csharp
#endregion
        
        #region Achievement Management
        
        public bool AwardAchievement(string userId, UserAchievement achievement)
        {
            if (!_users.TryGetValue(userId, out var user) || achievement == null)
                return false;
            
            // Award achievement using state method (data manipulation)
            var wasAwarded = user.AddAchievement(achievement);
            
            if (wasAwarded)
            {
                AchievementEarned?.Invoke(this, new AchievementEarnedEvent(user, achievement));
            }
            
            return wasAwarded;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `UserAchievement achievement`

### HasAchievement

```csharp
public bool HasAchievement(string userId, string achievementId)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            return user.HasAchievement(achievementId);
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string achievementId`

### GetAchievement

```csharp
public UserAchievement? GetAchievement(string userId, string achievementId)
        {
            if (!_users.TryGetValue(userId, out var user))
                return null;
            
            return user.GetAchievement(achievementId);
        }
```

**Returns:** `UserAchievement?`

**Parameters:**
- `string userId`
- `string achievementId`

### StartSession

```csharp
#endregion
        
        #region Session Management
        
        public bool StartSession(string userId)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            if (user.SessionStartTime > 0)
                return false; // Session already active
            
            // Start session using state method (data manipulation)
            user.StartSession();
            
            // Dispatch event
            SessionStarted?.Invoke(this, new SessionStartedEvent(user));
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`

### EndSession

```csharp
public bool EndSession(string userId)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            if (user.SessionStartTime <= 0)
                return false; // No active session
            
            var sessionDuration = user.CurrentSessionDuration;
            
            // End session using state method (data manipulation)
            user.EndSession();
            
            // Dispatch event
            SessionEnded?.Invoke(this, new SessionEndedEvent(user, sessionDuration));
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`

### IsUserInSession

```csharp
public bool IsUserInSession(string userId)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            return user.SessionStartTime > 0;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`

### SetPreference

```csharp
#endregion
        
        #region Preference Management
        
        public bool SetPreference(string userId, string key, object value)
        {
            if (!_users.TryGetValue(userId, out var user) || string.IsNullOrWhiteSpace(key))
                return false;
            
            var oldValue = user.GetPreference<object>(key);
            var wasChanged = !Equals(oldValue, value);
            
            // Set preference using state method (data manipulation)
            user.SetPreference(key, value);
            
            if (wasChanged)
            {
                PreferenceChanged?.Invoke(this, new PreferenceChangedEvent(user, key, oldValue, value));
            }
            
            return wasChanged;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string key`
- `object value`

### GetPreference

```csharp
public T GetPreference<T>(string userId, string key, T defaultValue = default)
        {
            if (!_users.TryGetValue(userId, out var user))
                return defaultValue;
            
            return user.GetPreference<T>(key, defaultValue);
        }
```

**Returns:** `T`

**Parameters:**
- `string userId`
- `string key`
- `T defaultValue`

### RemovePreference

```csharp
public bool RemovePreference(string userId, string key)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            var oldValue = user.GetPreference<object>(key);
            var wasRemoved = user.RemovePreference(key);
            
            if (wasRemoved)
            {
                PreferenceChanged?.Invoke(this, new PreferenceChangedEvent(user, key, oldValue, null));
            }
            
            return wasRemoved;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string key`

### SetStatistic

```csharp
#endregion
        
        #region Statistics Management
        
        public bool SetStatistic(string userId, string key, object value)
        {
            if (!_users.TryGetValue(userId, out var user) || string.IsNullOrWhiteSpace(key))
                return false;
            
            var oldValue = user.GetStatistic<object>(key);
            var wasChanged = !Equals(oldValue, value);
            
            // Set statistic using state method (data manipulation)
            user.SetStatistic(key, value);
            
            if (wasChanged)
            {
                StatisticUpdated?.Invoke(this, new StatisticUpdatedEvent(user, key, oldValue, value));
            }
            
            return wasChanged;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string key`
- `object value`

### GetStatistic

```csharp
public T GetStatistic<T>(string userId, string key, T defaultValue = default)
        {
            if (!_users.TryGetValue(userId, out var user))
                return defaultValue;
            
            return user.GetStatistic<T>(key, defaultValue);
        }
```

**Returns:** `T`

**Parameters:**
- `string userId`
- `string key`
- `T defaultValue`

### IncrementStatistic

```csharp
public bool IncrementStatistic(string userId, string key, int amount = 1)
        {
            if (!_users.TryGetValue(userId, out var user) || amount == 0)
                return false;
            
            var oldValue = user.GetStatistic<int>(key, 0);
            var newValue = oldValue + amount;
            
            // Increment statistic using state method (data manipulation)
            user.IncrementStatistic(key, amount);
            
            // Dispatch event
            StatisticUpdated?.Invoke(this, new StatisticUpdatedEvent(user, key, oldValue, newValue, true));
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string key`
- `int amount`

### RemoveStatistic

```csharp
public bool RemoveStatistic(string userId, string key)
        {
            if (!_users.TryGetValue(userId, out var user))
                return false;
            
            var oldValue = user.GetStatistic<object>(key);
            var wasRemoved = user.RemoveStatistic(key);
            
            if (wasRemoved)
            {
                StatisticUpdated?.Invoke(this, new StatisticUpdatedEvent(user, key, oldValue, null));
            }
            
            return wasRemoved;
        }
```

**Returns:** `bool`

**Parameters:**
- `string userId`
- `string key`

### GetAllUsers

```csharp
#endregion
        
        #region Queries
        
        public IEnumerable<UserState> GetAllUsers()
        {
            return _users.Values;
        }
```

**Returns:** `IEnumerable<UserState>`

### GetActiveUsers

```csharp
public IEnumerable<UserState> GetActiveUsers()
        {
            return _users.Values.Where(u => u.IsOnline);
        }
```

**Returns:** `IEnumerable<UserState>`

### GetUsersByLevel

```csharp
public IEnumerable<UserState> GetUsersByLevel(UserLevel level)
        {
            return _users.Values.Where(u => u.Level == level);
        }
```

**Returns:** `IEnumerable<UserState>`

**Parameters:**
- `UserLevel level`

### GetUserCount

```csharp
public int GetUserCount()
        {
            return _users.Count;
        }
```

**Returns:** `int`

### GetActiveUserCount

```csharp
public int GetActiveUserCount()
        {
            return _users.Values.Count(u => u.IsOnline);
        }
```

**Returns:** `int`

### ValidateUserState

```csharp
#endregion
        
        #region Validation
        
        public List<string> ValidateUserState(UserState user)
        {
            return user.Validate();
        }
```

**Returns:** `List<string>`

**Parameters:**
- `UserState user`

### ValidateUserAction

```csharp
public List<string> ValidateUserAction(string userId, string action)
        {
            var errors = new List<string>();
            
            if (!_users.ContainsKey(userId))
                errors.Add("User not found");
            
            if (string.IsNullOrWhiteSpace(action))
                errors.Add("Action cannot be empty");
            
            return errors;
        }
```

**Returns:** `List<string>`

**Parameters:**
- `string userId`
- `string action`

### RegisterUser

```csharp
#endregion
        
        #region State Management
        
        public void RegisterUser(UserState user)
        {
            if (user == null || string.IsNullOrEmpty(user.UserId))
                throw new ArgumentException("Invalid user state");
            
            // Check for duplicates
            if (_users.ContainsKey(user.UserId))
                throw new InvalidOperationException($"User with ID {user.UserId} already exists");
            
            if (_usersByUsername.ContainsKey(user.Username))
                throw new InvalidOperationException($"Username {user.Username} already exists");
            
            // Register user
            _users[user.UserId] = user;
            _usersByUsername[user.Username] = user;
        }
```

**Returns:** `void`

**Parameters:**
- `UserState user`

### UnregisterUser

```csharp
public void UnregisterUser(string userId)
        {
            if (!_users.TryGetValue(userId, out var user))
                return;
            
            // Remove from both dictionaries
            _users.Remove(userId);
            _usersByUsername.Remove(user.Username);
        }
```

**Returns:** `void`

**Parameters:**
- `string userId`

### ClearAllUsers

```csharp
public void ClearAllUsers()
        {
            _users.Clear();
            _usersByUsername.Clear();
        }
```

**Returns:** `void`

