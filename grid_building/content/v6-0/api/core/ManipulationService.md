---
title: "ManipulationService"
description: "Core service for manipulation-related business logic and state management.
Follows Enhanced Service Registry pattern with dependency injection.
Handles object manipulation operations like move, rotate, scale, and complex transformations."
weight: 10
url: "/gridbuilding/v6-0/api/core/manipulationservice/"
---

# ManipulationService

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationService
{
    // Members...
}
```

Core service for manipulation-related business logic and state management.
Follows Enhanced Service Registry pattern with dependency injection.
Handles object manipulation operations like move, rotate, scale, and complex transformations.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Manipulation/ManipulationService.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### StartManipulation

```csharp
#endregion
        
        #region Commands
        
        public ManipulationState StartManipulation(ManipulationMode mode, Vector2I origin)
        {
            _logger.LogDebug("Starting manipulation: {Mode} at {Origin}", mode, origin);
            
            // Validate
            if (!CanStartManipulation(mode, origin))
            {
                var error = $"Cannot start {mode} manipulation at {origin}";
                _logger.LogWarning("Manipulation validation failed: {Error}", error);
                throw new ManipulationException(error);
            }
            
            try
            {
                // Create new manipulation state
                var manipulation = new ManipulationState(mode, origin);
                
                // Register manipulation
                RegisterManipulation(manipulation);
                
                // Start the manipulation using state method (data manipulation)
                manipulation.StartManipulation(mode, origin);
                
                // Dispatch event
                ManipulationStarted?.Invoke(this, new ManipulationStartedEvent(manipulation));
                
                _logger.LogInformation("Manipulation started: {ManipulationId} for {Mode} at {Origin}", 
                    manipulation.ManipulationId, mode, origin);
                
                return manipulation;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to start manipulation: {Mode} at {Origin}", mode, origin);
                throw;
            }
        }
```

**Returns:** `ManipulationState`

**Parameters:**
- `ManipulationMode mode`
- `Vector2I origin`

### UpdateManipulationTarget

```csharp
public bool UpdateManipulationTarget(string manipulationId, Vector2I target)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation))
                return false;
            
            if (!manipulation.IsActive || manipulation.IsCompleted)
                return false;
            
            var previousTarget = manipulation.GridTarget;
            
            // Update target using state method (data manipulation)
            manipulation.UpdateTarget(target);
            
            // Validate manipulation
            if (!ValidateManipulation(manipulationId))
            {
                ManipulationFailed?.Invoke(this, new ManipulationFailedEvent(
                    manipulation, 
                    "Validation failed", 
                    ValidateManipulationState(manipulation)
                ));
                return false;
            }
            
            // Dispatch event
            ManipulationUpdated?.Invoke(this, new ManipulationUpdatedEvent(manipulation, previousTarget));
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`
- `Vector2I target`

### CancelManipulation

```csharp
public bool CancelManipulation(string manipulationId)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation))
                return false;
            
            if (!manipulation.IsActive || manipulation.IsCompleted)
                return false;
            
            // Cancel using state method (data manipulation)
            manipulation.CancelManipulation();
            
            // Dispatch event
            ManipulationCancelled?.Invoke(this, new ManipulationCancelledEvent(manipulation));
            
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`

### CompleteManipulation

```csharp
public bool CompleteManipulation(string manipulationId)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation))
                return false;
            
            if (!manipulation.IsActive || manipulation.IsCompleted)
                return false;
            
            // Final validation
            if (!ValidateManipulation(manipulationId))
            {
                var errors = ValidateManipulationState(manipulation);
                manipulation.CancelManipulation();
                ManipulationFailed?.Invoke(this, new ManipulationFailedEvent(
                    manipulation, 
                    "Validation failed on completion", 
                    errors
                ));
                return false;
            }
            
            // Complete using state method (data manipulation)
            manipulation.CompleteManipulation();
            
            // Execute actions
            var result = manipulation.ExecuteActions();
            
            // Dispatch event
            ManipulationCompleted?.Invoke(this, new ManipulationCompletedEvent(manipulation));
            
            return result.IsSuccess;
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`

### AddConstraint

```csharp
#endregion
        
        #region Constraint and Action Management
        
        public bool AddConstraint(string manipulationId, ManipulationConstraint constraint)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation) || constraint == null)
                return false;
            
            manipulation.AddConstraint(constraint);
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`
- `ManipulationConstraint constraint`

### RemoveConstraint

```csharp
public bool RemoveConstraint(string manipulationId, string constraintId)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation))
                return false;
            
            var constraint = manipulation.Constraints.FirstOrDefault(c => c.Id == constraintId);
            if (constraint == null)
                return false;
            
            return manipulation.RemoveConstraint(constraint);
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`
- `string constraintId`

### AddAction

```csharp
public bool AddAction(string manipulationId, ActionDefinition action)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation) || action == null)
                return false;
            
            manipulation.AddAction(action);
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`
- `ActionDefinition action`

### RemoveAction

```csharp
public bool RemoveAction(string manipulationId, string actionId)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation))
                return false;
            
            var action = manipulation.Actions.FirstOrDefault(a => a.Name == actionId);
            if (action == null)
                return false;
            
            return manipulation.RemoveAction(action);
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`
- `string actionId`

### SetContextData

```csharp
#endregion
        
        #region Context Data Management
        
        public bool SetContextData(string manipulationId, string key, object value)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation))
                return false;
            
            manipulation.SetContextData(key, value);
            return true;
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`
- `string key`
- `object value`

### GetContextData

```csharp
public T GetContextData<T>(string manipulationId, string key, T defaultValue = default)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation))
                return defaultValue;
            
            return manipulation.GetContextData<T>(key, defaultValue);
        }
```

**Returns:** `T`

**Parameters:**
- `string manipulationId`
- `string key`
- `T defaultValue`

### GetManipulation

```csharp
#endregion
        
        #region Queries
        
        public ManipulationState? GetManipulation(string manipulationId)
        {
            return _manipulations.TryGetValue(manipulationId, out var manipulation) ? manipulation : null;
        }
```

**Returns:** `ManipulationState?`

**Parameters:**
- `string manipulationId`

### GetActiveManipulations

```csharp
public IEnumerable<ManipulationState> GetActiveManipulations()
        {
            return _manipulations.Values.Where(m => m.IsActive && !m.IsCompleted);
        }
```

**Returns:** `IEnumerable<ManipulationState>`

### GetManipulationsByMode

```csharp
public IEnumerable<ManipulationState> GetManipulationsByMode(ManipulationMode mode)
        {
            return _manipulations.Values.Where(m => m.CurrentMode == mode);
        }
```

**Returns:** `IEnumerable<ManipulationState>`

**Parameters:**
- `ManipulationMode mode`

### IsManipulationActive

```csharp
public bool IsManipulationActive(string manipulationId)
        {
            return _manipulations.TryGetValue(manipulationId, out var manipulation) && 
                   manipulation.IsActive && !manipulation.IsCompleted;
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`

### CanStartManipulation

```csharp
public bool CanStartManipulation(ManipulationMode mode, Vector2I origin)
        {
            // Check if there's already an active manipulation at this position
            var existingManipulation = _manipulations.Values.FirstOrDefault(m => 
                m.IsActive && 
                !m.IsCompleted && 
                m.GridOrigin == origin
            );
            
            return existingManipulation == null && mode != ManipulationMode.None;
        }
```

**Returns:** `bool`

**Parameters:**
- `ManipulationMode mode`
- `Vector2I origin`

### ValidateManipulation

```csharp
#endregion
        
        #region Validation
        
        public bool ValidateManipulation(string manipulationId)
        {
            if (!_manipulations.TryGetValue(manipulationId, out var manipulation))
                return false;
            
            return manipulation.ValidateManipulation();
        }
```

**Returns:** `bool`

**Parameters:**
- `string manipulationId`

### ValidateManipulationState

```csharp
public List<string> ValidateManipulationState(ManipulationState manipulation)
        {
            return manipulation.Validate();
        }
```

**Returns:** `List<string>`

**Parameters:**
- `ManipulationState manipulation`

### RegisterManipulation

```csharp
#endregion
        
        #region State Management
        
        public void RegisterManipulation(ManipulationState manipulation)
        {
            if (manipulation == null || string.IsNullOrEmpty(manipulation.ManipulationId))
                throw new ArgumentException("Invalid manipulation state");
            
            // Check for duplicates
            if (_manipulations.ContainsKey(manipulation.ManipulationId))
                throw new InvalidOperationException($"Manipulation with ID {manipulation.ManipulationId} already exists");
            
            // Register manipulation
            _manipulations[manipulation.ManipulationId] = manipulation;
        }
```

**Returns:** `void`

**Parameters:**
- `ManipulationState manipulation`

### UnregisterManipulation

```csharp
public void UnregisterManipulation(string manipulationId)
        {
            _manipulations.Remove(manipulationId);
        }
```

**Returns:** `void`

**Parameters:**
- `string manipulationId`

### ClearAllManipulations

```csharp
public void ClearAllManipulations()
        {
            _manipulations.Clear();
        }
```

**Returns:** `void`

### Dispose

```csharp
#endregion
        
        #region IDisposable Implementation
        
        /// <summary>
        /// Releases all resources used by the ManipulationService.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
```

Releases all resources used by the ManipulationService.

**Returns:** `void`

