---
title: "MoveWorkflowManager"
description: "Core move workflow management for manipulation operations (engine-agnostic).
Handles move copy creation, setup, and workflow management without engine dependencies.
Responsibilities:
- Create and manage move copy objects
- Handle move workflow state transitions
- Validate move operations
- Provide move completion logic"
weight: 10
url: "/gridbuilding/v6-0/api/core/moveworkflowmanager/"
---

# MoveWorkflowManager

```csharp
GridBuilding.Core.Services.Manipulation
class MoveWorkflowManager
{
    // Members...
}
```

Core move workflow management for manipulation operations (engine-agnostic).
Handles move copy creation, setup, and workflow management without engine dependencies.
Responsibilities:
- Create and manage move copy objects
- Handle move workflow state transitions
- Validate move operations
- Provide move completion logic

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/MoveWorkflowManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### StartMove

```csharp
#endregion

        #region Public Methods

        /// <summary>
        /// Starts a move operation for the specified target.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <param name="targetObjectId">ID of the target object to move</param>
        /// <param name="originalPosition">Original position of the target</param>
        /// <returns>True if move operation started successfully</returns>
        public bool StartMove(ManipulationState manipulationState, string targetObjectId, Vector2I originalPosition)
        {
            if (manipulationState == null || string.IsNullOrEmpty(targetObjectId))
                return false;

            // Create move workflow state
            var workflowState = new MoveWorkflowState
            {
                WorkflowId = GenerateWorkflowId(),
                ManipulationId = manipulationState.ManipulationId,
                TargetObjectId = targetObjectId,
                OriginalPosition = originalPosition,
                CurrentPosition = originalPosition,
                StartTime = DateTime.UtcNow,
                IsActive = true
            };

            // Store workflow state
            _activeWorkflows[workflowState.WorkflowId] = workflowState;

            // Set context data in manipulation state
            manipulationState.SetContextData("moveWorkflowId", workflowState.WorkflowId);
            manipulationState.SetContextData("originalPosition", originalPosition);

            return true;
        }
```

Starts a move operation for the specified target.

**Returns:** `bool`

**Parameters:**
- `ManipulationState manipulationState`
- `string targetObjectId`
- `Vector2I originalPosition`

### UpdateMove

```csharp
/// <summary>
        /// Updates the move operation with new target position.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <param name="newPosition">New target position</param>
        /// <returns>True if move updated successfully</returns>
        public bool UpdateMove(ManipulationState manipulationState, Vector2I newPosition)
        {
            if (manipulationState == null)
                return false;

            var workflowId = manipulationState.GetContextData<string>("moveWorkflowId");
            if (string.IsNullOrEmpty(workflowId) || !_activeWorkflows.TryGetValue(workflowId, out var workflowState))
                return false;

            // Validate move operation
            if (!ValidateMovePosition(workflowState, newPosition))
                return false;

            // Update workflow state
            workflowState.CurrentPosition = newPosition;
            workflowState.LastUpdateTime = DateTime.UtcNow;

            // Update manipulation state
            manipulationState.UpdateTarget(newPosition);
            manipulationState.SetContextData("currentPosition", newPosition);

            return true;
        }
```

Updates the move operation with new target position.

**Returns:** `bool`

**Parameters:**
- `ManipulationState manipulationState`
- `Vector2I newPosition`

### CompleteMove

```csharp
/// <summary>
        /// Completes the move operation.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>Move operation result</returns>
        public MoveResult CompleteMove(ManipulationState manipulationState)
        {
            if (manipulationState == null)
                return MoveResult.Failed("Manipulation state is null");

            var workflowId = manipulationState.GetContextData<string>("moveWorkflowId");
            if (string.IsNullOrEmpty(workflowId) || !_activeWorkflows.TryGetValue(workflowId, out var workflowState))
                return MoveResult.Failed("Move workflow not found");

            // Final validation
            if (!ValidateMovePosition(workflowState, workflowState.CurrentPosition))
            {
                var validationResult = GetValidationErrors(workflowState);
                return MoveResult.Failed($"Move validation failed: {string.Join(", ", validationResult)}");
            }

            // Create move result
            var result = new MoveResult
            {
                IsSuccess = true,
                OriginalPosition = workflowState.OriginalPosition,
                FinalPosition = workflowState.CurrentPosition,
                TargetObjectId = workflowState.TargetObjectId,
                Duration = DateTime.UtcNow - workflowState.StartTime
            };

            // Clean up workflow
            _activeWorkflows.Remove(workflowId);
            manipulationState.SetContextData("moveResult", result);

            return result;
        }
```

Completes the move operation.

**Returns:** `MoveResult`

**Parameters:**
- `ManipulationState manipulationState`

### CancelMove

```csharp
/// <summary>
        /// Cancels the move operation.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>True if move cancelled successfully</returns>
        public bool CancelMove(ManipulationState manipulationState)
        {
            if (manipulationState == null)
                return false;

            var workflowId = manipulationState.GetContextData<string>("moveWorkflowId");
            if (string.IsNullOrEmpty(workflowId))
                return true; // Already cancelled or never started

            if (_activeWorkflows.TryGetValue(workflowId, out var workflowState))
            {
                workflowState.IsActive = false;
                workflowState.EndTime = DateTime.UtcNow;
                _activeWorkflows.Remove(workflowId);
            }

            // Clean up manipulation state
            manipulationState.RemoveContextData("moveWorkflowId");
            manipulationState.RemoveContextData("originalPosition");
            manipulationState.RemoveContextData("currentPosition");

            return true;
        }
```

Cancels the move operation.

**Returns:** `bool`

**Parameters:**
- `ManipulationState manipulationState`

### GetMoveWorkflow

```csharp
/// <summary>
        /// Gets the current move workflow state.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>Move workflow state, or null if not found</returns>
        public MoveWorkflowState? GetMoveWorkflow(ManipulationState manipulationState)
        {
            if (manipulationState == null)
                return null;

            var workflowId = manipulationState.GetContextData<string>("moveWorkflowId");
            if (string.IsNullOrEmpty(workflowId))
                return null;

            return _activeWorkflows.TryGetValue(workflowId, out var workflowState) ? workflowState : null;
        }
```

Gets the current move workflow state.

**Returns:** `MoveWorkflowState?`

**Parameters:**
- `ManipulationState manipulationState`

### IsMoveActive

```csharp
/// <summary>
        /// Checks if a move operation is active.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>True if move operation is active</returns>
        public bool IsMoveActive(ManipulationState manipulationState)
        {
            var workflow = GetMoveWorkflow(manipulationState);
            return workflow?.IsActive == true;
        }
```

Checks if a move operation is active.

**Returns:** `bool`

**Parameters:**
- `ManipulationState manipulationState`

### GetActiveWorkflows

```csharp
/// <summary>
        /// Gets all active move workflows.
        /// </summary>
        /// <returns>Dictionary of workflow IDs and their states</returns>
        public Dictionary<string, MoveWorkflowState> GetActiveWorkflows()
        {
            return new Dictionary<string, MoveWorkflowState>(_activeWorkflows);
        }
```

Gets all active move workflows.

**Returns:** `Dictionary<string, MoveWorkflowState>`

### ClearAllWorkflows

```csharp
/// <summary>
        /// Clears all move workflows (for cleanup/reset).
        /// </summary>
        public void ClearAllWorkflows()
        {
            _activeWorkflows.Clear();
        }
```

Clears all move workflows (for cleanup/reset).

**Returns:** `void`

