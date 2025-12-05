---
title: "DemolishManager"
description: "Core demolish management for manipulation operations (engine-agnostic).
Handles demolish workflow, validation, and completion without engine dependencies.
Responsibilities:
- Validate demolish operations
- Handle demolish workflow state
- Manage demolish constraints and rules
- Provide demolish completion logic"
weight: 10
url: "/gridbuilding/v6-0/api/core/demolishmanager/"
---

# DemolishManager

```csharp
GridBuilding.Core.Services.Manipulation
class DemolishManager
{
    // Members...
}
```

Core demolish management for manipulation operations (engine-agnostic).
Handles demolish workflow, validation, and completion without engine dependencies.
Responsibilities:
- Validate demolish operations
- Handle demolish workflow state
- Manage demolish constraints and rules
- Provide demolish completion logic

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/DemolishManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### StartDemolish

```csharp
#endregion

        #region Public Methods

        /// <summary>
        /// Starts a demolish operation for the specified target.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <param name="targetObjectId">ID of the target object to demolish</param>
        /// <param name="targetPosition">Position of the target object</param>
        /// <returns>True if demolish operation started successfully</returns>
        public bool StartDemolish(ManipulationState manipulationState, string targetObjectId, Vector2I targetPosition)
        {
            if (manipulationState == null || string.IsNullOrEmpty(targetObjectId))
                return false;

            // Validate demolish operation
            var validationResult = ValidateDemolish(manipulationState, targetObjectId, targetPosition);
            if (!validationResult.IsValid)
            {
                manipulationState.SetContextData("demolishValidationError", validationResult.ErrorMessage);
                return false;
            }

            // Create demolish workflow state
            var workflowState = new DemolishWorkflowState
            {
                WorkflowId = GenerateWorkflowId(),
                ManipulationId = manipulationState.ManipulationId,
                TargetObjectId = targetObjectId,
                TargetPosition = targetPosition,
                StartTime = DateTime.UtcNow,
                IsActive = true,
                RequiresConfirmation = _settings.RequireDemolishConfirmation
            };

            // Store workflow state
            _activeWorkflows[workflowState.WorkflowId] = workflowState;

            // Set context data in manipulation state
            manipulationState.SetContextData("demolishWorkflowId", workflowState.WorkflowId);
            manipulationState.SetContextData("targetObjectId", targetObjectId);
            manipulationState.SetContextData("targetPosition", targetPosition);

            return true;
        }
```

Starts a demolish operation for the specified target.

**Returns:** `bool`

**Parameters:**
- `ManipulationState manipulationState`
- `string targetObjectId`
- `Vector2I targetPosition`

### ConfirmDemolish

```csharp
/// <summary>
        /// Confirms a demolish operation (if confirmation is required).
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>True if demolish confirmed successfully</returns>
        public bool ConfirmDemolish(ManipulationState manipulationState)
        {
            if (manipulationState == null)
                return false;

            var workflowId = manipulationState.GetContextData<string>("demolishWorkflowId");
            if (string.IsNullOrEmpty(workflowId) || !_activeWorkflows.TryGetValue(workflowId, out var workflowState))
                return false;

            if (!workflowState.RequiresConfirmation)
                return true; // No confirmation required

            workflowState.IsConfirmed = true;
            workflowState.ConfirmationTime = DateTime.UtcNow;

            return true;
        }
```

Confirms a demolish operation (if confirmation is required).

**Returns:** `bool`

**Parameters:**
- `ManipulationState manipulationState`

### CompleteDemolish

```csharp
/// <summary>
        /// Completes the demolish operation.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>Demolish operation result</returns>
        public DemolishResult CompleteDemolish(ManipulationState manipulationState)
        {
            if (manipulationState == null)
                return DemolishResult.Failed("Manipulation state is null");

            var workflowId = manipulationState.GetContextData<string>("demolishWorkflowId");
            if (string.IsNullOrEmpty(workflowId) || !_activeWorkflows.TryGetValue(workflowId, out var workflowState))
                return DemolishResult.Failed("Demolish workflow not found");

            // Check confirmation requirement
            if (workflowState.RequiresConfirmation && !workflowState.IsConfirmed)
            {
                return DemolishResult.Failed("Demolish requires confirmation");
            }

            // Final validation
            var validationResult = ValidateDemolish(manipulationState, workflowState.TargetObjectId, workflowState.TargetPosition);
            if (!validationResult.IsValid)
            {
                return DemolishResult.Failed($"Demolish validation failed: {validationResult.ErrorMessage}");
            }

            // Create demolish result
            var result = new DemolishResult
            {
                IsSuccess = true,
                TargetObjectId = workflowState.TargetObjectId,
                TargetPosition = workflowState.TargetPosition,
                AffectedTiles = GetAffectedTiles(workflowState),
                Duration = DateTime.UtcNow - workflowState.StartTime,
                Timestamp = DateTime.UtcNow
            };

            // Apply demolish effects
            ApplyDemolishEffects(manipulationState, workflowState, result);

            // Clean up workflow
            _activeWorkflows.Remove(workflowId);
            manipulationState.SetContextData("demolishResult", result);

            return result;
        }
```

Completes the demolish operation.

**Returns:** `DemolishResult`

**Parameters:**
- `ManipulationState manipulationState`

### CancelDemolish

```csharp
/// <summary>
        /// Cancels the demolish operation.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>True if demolish cancelled successfully</returns>
        public bool CancelDemolish(ManipulationState manipulationState)
        {
            if (manipulationState == null)
                return false;

            var workflowId = manipulationState.GetContextData<string>("demolishWorkflowId");
            if (string.IsNullOrEmpty(workflowId))
                return true; // Already cancelled or never started

            if (_activeWorkflows.TryGetValue(workflowId, out var workflowState))
            {
                workflowState.IsActive = false;
                workflowState.EndTime = DateTime.UtcNow;
                _activeWorkflows.Remove(workflowId);
            }

            // Clean up manipulation state
            manipulationState.RemoveContextData("demolishWorkflowId");
            manipulationState.RemoveContextData("targetObjectId");
            manipulationState.RemoveContextData("targetPosition");
            manipulationState.RemoveContextData("demolishValidationError");

            return true;
        }
```

Cancels the demolish operation.

**Returns:** `bool`

**Parameters:**
- `ManipulationState manipulationState`

### GetDemolishWorkflow

```csharp
/// <summary>
        /// Gets the current demolish workflow state.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>Demolish workflow state, or null if not found</returns>
        public DemolishWorkflowState? GetDemolishWorkflow(ManipulationState manipulationState)
        {
            if (manipulationState == null)
                return null;

            var workflowId = manipulationState.GetContextData<string>("demolishWorkflowId");
            if (string.IsNullOrEmpty(workflowId))
                return null;

            return _activeWorkflows.TryGetValue(workflowId, out var workflowState) ? workflowState : null;
        }
```

Gets the current demolish workflow state.

**Returns:** `DemolishWorkflowState?`

**Parameters:**
- `ManipulationState manipulationState`

### IsDemolishActive

```csharp
/// <summary>
        /// Checks if a demolish operation is active.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>True if demolish operation is active</returns>
        public bool IsDemolishActive(ManipulationState manipulationState)
        {
            var workflow = GetDemolishWorkflow(manipulationState);
            return workflow?.IsActive == true;
        }
```

Checks if a demolish operation is active.

**Returns:** `bool`

**Parameters:**
- `ManipulationState manipulationState`

### ValidateDemolish

```csharp
/// <summary>
        /// Validates if an object can be demolished.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <param name="targetObjectId">ID of the target object</param>
        /// <param name="targetPosition">Position of the target object</param>
        /// <returns>Demolish validation result</returns>
        public DemolishValidationResult ValidateDemolish(ManipulationState manipulationState, string targetObjectId, Vector2I targetPosition)
        {
            var result = new DemolishValidationResult { IsValid = true };

            // Apply all demolish rules
            foreach (var rule in _demolishRules)
            {
                if (!rule.IsEnabled)
                    continue;

                var ruleResult = rule.Validate(manipulationState, targetObjectId, targetPosition, _settings);
                if (!ruleResult.IsValid)
                {
                    result.IsValid = false;
                    result.ValidationErrors.AddRange(ruleResult.ValidationErrors);
                }
            }

            // Basic validation
            if (string.IsNullOrEmpty(targetObjectId))
            {
                result.IsValid = false;
                result.ValidationErrors.Add("Target object ID cannot be empty");
            }

            // Grid boundary validation
            if (_settings.EnableGridConstraints)
            {
                if (targetPosition.X < 0 || targetPosition.Y < 0 || 
                    targetPosition.X > _settings.MaxGridSize.X || targetPosition.Y > _settings.MaxGridSize.Y)
                {
                    result.IsValid = false;
                    result.ValidationErrors.Add("Target position is outside grid boundaries");
                }
            }

            return result;
        }
```

Validates if an object can be demolished.

**Returns:** `DemolishValidationResult`

**Parameters:**
- `ManipulationState manipulationState`
- `string targetObjectId`
- `Vector2I targetPosition`

### AddDemolishRule

```csharp
/// <summary>
        /// Adds a custom demolish rule.
        /// </summary>
        /// <param name="rule">Demolish rule to add</param>
        public void AddDemolishRule(DemolishRule rule)
        {
            if (rule != null && !_demolishRules.Contains(rule))
            {
                _demolishRules.Add(rule);
            }
        }
```

Adds a custom demolish rule.

**Returns:** `void`

**Parameters:**
- `DemolishRule rule`

### RemoveDemolishRule

```csharp
/// <summary>
        /// Removes a demolish rule.
        /// </summary>
        /// <param name="rule">Demolish rule to remove</param>
        public bool RemoveDemolishRule(DemolishRule rule)
        {
            return _demolishRules.Remove(rule);
        }
```

Removes a demolish rule.

**Returns:** `bool`

**Parameters:**
- `DemolishRule rule`

### GetActiveWorkflows

```csharp
/// <summary>
        /// Gets all active demolish workflows.
        /// </summary>
        /// <returns>Dictionary of workflow IDs and their states</returns>
        public Dictionary<string, DemolishWorkflowState> GetActiveWorkflows()
        {
            return new Dictionary<string, DemolishWorkflowState>(_activeWorkflows);
        }
```

Gets all active demolish workflows.

**Returns:** `Dictionary<string, DemolishWorkflowState>`

### ClearAllWorkflows

```csharp
/// <summary>
        /// Clears all demolish workflows (for cleanup/reset).
        /// </summary>
        public void ClearAllWorkflows()
        {
            _activeWorkflows.Clear();
        }
```

Clears all demolish workflows (for cleanup/reset).

**Returns:** `void`

