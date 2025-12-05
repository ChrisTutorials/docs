---
title: "ManipulationContextService"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/manipulationcontextservice/"
---

# ManipulationContextService

```csharp
GridBuilding.Core.Services.Manipulation
class ManipulationContextService
{
    // Members...
}
```

Service for managing ManipulationContext objects.
Handles the business logic that was previously in Godot's ManipulationData.
Integrates with ManipulationService for complete manipulation lifecycle management.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Manipulation/ManipulationContextService.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateContext

```csharp
#endregion

        #region Context Management

        /// <summary>
        /// Creates a new manipulation context.
        /// </summary>
        public ManipulationContext CreateContext(string manipulatorId, string targetObjectId, ManipulationAction action)
        {
            var context = new ManipulationContext(manipulatorId, targetObjectId, action);
            
            // Register context
            _contexts[GetContextKey(manipulatorId, targetObjectId, action)] = context;
            
            // Dispatch event
            ContextCreated?.Invoke(this, new ManipulationContextCreatedEvent(context));
            
            return context;
        }
```

Creates a new manipulation context.

**Returns:** `ManipulationContext`

**Parameters:**
- `string manipulatorId`
- `string targetObjectId`
- `ManipulationAction action`

### CreateMoveContext

```csharp
/// <summary>
        /// Creates a move manipulation context with preview object.
        /// </summary>
        public ManipulationContext CreateMoveContext(string manipulatorId, string targetObjectId, string previewObjectId)
        {
            var context = ManipulationContext.CreateMove(manipulatorId, targetObjectId, previewObjectId);
            
            // Register context
            _contexts[GetContextKey(manipulatorId, targetObjectId, ManipulationAction.Move)] = context;
            
            // Dispatch event
            ContextCreated?.Invoke(this, new ManipulationContextCreatedEvent(context));
            
            return context;
        }
```

Creates a move manipulation context with preview object.

**Returns:** `ManipulationContext`

**Parameters:**
- `string manipulatorId`
- `string targetObjectId`
- `string previewObjectId`

### GetContext

```csharp
/// <summary>
        /// Gets a manipulation context.
        /// </summary>
        public ManipulationContext? GetContext(string manipulatorId, string targetObjectId, ManipulationAction action)
        {
            var key = GetContextKey(manipulatorId, targetObjectId, action);
            return _contexts.TryGetValue(key, out var context) ? context : null;
        }
```

Gets a manipulation context.

**Returns:** `ManipulationContext?`

**Parameters:**
- `string manipulatorId`
- `string targetObjectId`
- `ManipulationAction action`

### UpdateContext

```csharp
/// <summary>
        /// Updates a manipulation context.
        /// </summary>
        public bool UpdateContext(string manipulatorId, string targetObjectId, ManipulationAction action, 
            Action<ManipulationContext> updateAction)
        {
            var context = GetContext(manipulatorId, targetObjectId, action);
            if (context == null) return false;

            var previousStatus = context.Status;
            updateAction(context);
            
            // Dispatch events
            ContextUpdated?.Invoke(this, new ManipulationContextUpdatedEvent(context));
            
            if (previousStatus != context.Status)
            {
                ContextStatusChanged?.Invoke(this, new ManipulationContextStatusChangedEvent(context, previousStatus));
            }
            
            return true;
        }
```

Updates a manipulation context.

**Returns:** `bool`

**Parameters:**
- `string manipulatorId`
- `string targetObjectId`
- `ManipulationAction action`
- `Action<ManipulationContext> updateAction`

### RemoveContext

```csharp
/// <summary>
        /// Removes a manipulation context.
        /// </summary>
        public bool RemoveContext(string manipulatorId, string targetObjectId, ManipulationAction action)
        {
            var key = GetContextKey(manipulatorId, targetObjectId, action);
            if (!_contexts.TryGetValue(key, out var context)) return false;

            _contexts.Remove(key);
            ContextRemoved?.Invoke(this, new ManipulationContextRemovedEvent(context));
            
            return true;
        }
```

Removes a manipulation context.

**Returns:** `bool`

**Parameters:**
- `string manipulatorId`
- `string targetObjectId`
- `ManipulationAction action`

### GetContextsByManipulator

```csharp
/// <summary>
        /// Gets all contexts for a specific manipulator.
        /// </summary>
        public IEnumerable<ManipulationContext> GetContextsByManipulator(string manipulatorId)
        {
            return _contexts.Values.Where(c => c.ManipulatorId == manipulatorId);
        }
```

Gets all contexts for a specific manipulator.

**Returns:** `IEnumerable<ManipulationContext>`

**Parameters:**
- `string manipulatorId`

### GetContextsByTarget

```csharp
/// <summary>
        /// Gets all contexts for a specific target.
        /// </summary>
        public IEnumerable<ManipulationContext> GetContextsByTarget(string targetObjectId)
        {
            return _contexts.Values.Where(c => c.TargetObjectId == targetObjectId);
        }
```

Gets all contexts for a specific target.

**Returns:** `IEnumerable<ManipulationContext>`

**Parameters:**
- `string targetObjectId`

### GetActiveContexts

```csharp
/// <summary>
        /// Gets all active contexts.
        /// </summary>
        public IEnumerable<ManipulationContext> GetActiveContexts()
        {
            return _contexts.Values.Where(c => c.IsActive());
        }
```

Gets all active contexts.

**Returns:** `IEnumerable<ManipulationContext>`

### ValidateContext

```csharp
#endregion

        #region Validation

        /// <summary>
        /// Validates a manipulation context.
        /// </summary>
        public ValidationResults ValidateContext(ManipulationContext context)
        {
            var results = ValidationResults.Success();
            
            // Basic validation
            var errors = context.Validate();
            foreach (var error in errors)
            {
                results.AddError(error);
            }
            
            // Business logic validation
            if (context.IsMoveAction() && string.IsNullOrEmpty(context.PreviewObjectId))
            {
                results.AddWarning("Move operation without preview object");
            }
            
            if (context.IsDemolishAction() && string.IsNullOrEmpty(context.TargetObjectId))
            {
                results.AddError("Demolish operation requires target object");
            }
            
            // Update context with validation results
            context.UpdateResults(results);
            
            return results;
        }
```

Validates a manipulation context.

**Returns:** `ValidationResults`

**Parameters:**
- `ManipulationContext context`

### ValidateAndUpdateContext

```csharp
/// <summary>
        /// Validates and updates a context.
        /// </summary>
        public bool ValidateAndUpdateContext(string manipulatorId, string targetObjectId, ManipulationAction action)
        {
            return UpdateContext(manipulatorId, targetObjectId, action, context =>
            {
                var results = ValidateContext(context);
                if (!results.IsValid)
                {
                    context.UpdateStatus(ManipulationStatus.Failed);
                    context.UpdateMessage(results.GetErrorSummary());
                }
            });
        }
```

Validates and updates a context.

**Returns:** `bool`

**Parameters:**
- `string manipulatorId`
- `string targetObjectId`
- `ManipulationAction action`

### ClearAllContexts

```csharp
#endregion

        #region Cleanup

        /// <summary>
        /// Removes all contexts.
        /// </summary>
        public void ClearAllContexts()
        {
            var contexts = _contexts.Values.ToList();
            _contexts.Clear();
            
            foreach (var context in contexts)
            {
                ContextRemoved?.Invoke(this, new ManipulationContextRemovedEvent(context));
            }
        }
```

Removes all contexts.

**Returns:** `void`

### CleanupCompletedContexts

```csharp
/// <summary>
        /// Removes completed contexts older than the specified time.
        /// </summary>
        public int CleanupCompletedContexts(TimeSpan maxAge)
        {
            var cutoff = DateTime.UtcNow - maxAge;
            var toRemove = _contexts.Values
                .Where(c => c.IsCompleted() && c.UpdatedAt < cutoff)
                .ToList();

            var removedCount = 0;
            foreach (var context in toRemove)
            {
                var key = GetContextKey(context.ManipulatorId, context.TargetObjectId, context.Action);
                if (_contexts.Remove(key))
                {
                    ContextRemoved?.Invoke(this, new ManipulationContextRemovedEvent(context));
                    removedCount++;
                }
            }

            return removedCount;
        }
```

Removes completed contexts older than the specified time.

**Returns:** `int`

**Parameters:**
- `TimeSpan maxAge`

