---
title: "ManipulationData"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/manipulationdata/"
---

# ManipulationData

```csharp
GridBuilding.Godot.Systems.Manipulation
class ManipulationData
{
    // Members...
}
```

Godot wrapper for Core ManipulationContext.
Maintains Godot compatibility while delegating business logic to Core.
Marked obsolete - use ManipulationContextService directly when possible.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/ManipulationData.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Manipulator

```csharp
#endregion

    #region Properties

    /// <summary>
    /// The character or object currently using the system to do manipulations.
    /// </summary>
    public Node? Manipulator { get; set; }
```

The character or object currently using the system to do manipulations.

### Source

```csharp
/// <summary>
    /// The manipulatable node that was selected as the basis for this manipulation.
    /// </summary>
    public Node? Source { get; set; }
```

The manipulatable node that was selected as the basis for this manipulation.

### MoveCopy

```csharp
/// <summary>
    /// The temporary manipulation copy created during MOVE operations.
    /// This is NOT the "target" being aimed at (that's in GridTargetingState).
    /// This is the preview copy that follows the cursor and shows where the object will be placed.
    /// Also known as the "move copy" or "manipulation preview".
    /// </summary>
    public Node? MoveCopy { get; set; }
```

The temporary manipulation copy created during MOVE operations.
This is NOT the "target" being aimed at (that's in GridTargetingState).
This is the preview copy that follows the cursor and shows where the object will be placed.
Also known as the "move copy" or "manipulation preview".

### Message

```csharp
/// <summary>
    /// The general message sent as part of the manipulation data
    /// for whether the manipulation fails or succeeds.
    /// </summary>
    public string Message 
    { 
        get => _context.Message;
        set => UpdateContext(c => c.UpdateMessage(value));
    }
```

The general message sent as part of the manipulation data
for whether the manipulation fails or succeeds.

### Results

```csharp
/// <summary>
    /// The results of rule check validation on the manipulation.
    /// Should be provided for manipulations that had to evaluate rules
    /// and have generated results.
    /// </summary>
    public ValidationResults? Results 
    { 
        get => _context.Results;
        set => UpdateContext(c => c.UpdateResults(value));
    }
```

The results of rule check validation on the manipulation.
Should be provided for manipulations that had to evaluate rules
and have generated results.

### Action

```csharp
/// <summary>
    /// The manipulation that is / was attempting to be done.
    /// </summary>
    public ManipulationAction Action 
    { 
        get => _context.Action;
        set => UpdateContext(c => c.Action = value);
    }
```

The manipulation that is / was attempting to be done.

### Status

```csharp
/// <summary>
    /// Status of the action.
    /// </summary>
    public ManipulationStatus Status
    {
        get => _context.Status;
        set
        {
            var previousStatus = _context.Status;
            UpdateContext(c => c.UpdateStatus(value));
            
            // Emit Godot signal for compatibility
            if (previousStatus != value)
            {
                EmitSignal(SignalName.StatusChanged, value.ToString());
            }
        }
    }
```

Status of the action.


## Methods

### IsMoveAction

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Returns true if this manipulation represents a move operation.
    /// </summary>
    public bool IsMoveAction() => _context.IsMoveAction();
```

Returns true if this manipulation represents a move operation.

**Returns:** `bool`

### IsDemolishAction

```csharp
/// <summary>
    /// Returns true if this manipulation represents a demolish operation.
    /// </summary>
    public bool IsDemolishAction() => _context.IsDemolishAction();
```

Returns true if this manipulation represents a demolish operation.

**Returns:** `bool`

### IsRotateAction

```csharp
/// <summary>
    /// Returns true if this manipulation represents a rotate operation.
    /// </summary>
    public bool IsRotateAction() => _context.IsRotateAction();
```

Returns true if this manipulation represents a rotate operation.

**Returns:** `bool`

### IsFlipAction

```csharp
/// <summary>
    /// Returns true if this manipulation represents a flip operation.
    /// </summary>
    public bool IsFlipAction() => _context.IsFlipAction();
```

Returns true if this manipulation represents a flip operation.

**Returns:** `bool`

### IsCompleted

```csharp
/// <summary>
    /// Returns true if the manipulation has completed (either successfully or failed).
    /// </summary>
    public bool IsCompleted() => _context.IsCompleted();
```

Returns true if the manipulation has completed (either successfully or failed).

**Returns:** `bool`

### IsActive

```csharp
/// <summary>
    /// Returns true if the manipulation is currently active.
    /// </summary>
    public bool IsActive() => _context.IsActive();
```

Returns true if the manipulation is currently active.

**Returns:** `bool`

### GetDescription

```csharp
/// <summary>
    /// Gets a human-readable description of the manipulation.
    /// </summary>
    public string GetDescription() => _context.GetDescription();
```

Gets a human-readable description of the manipulation.

**Returns:** `string`

### IsValid

```csharp
/// <summary>
    /// Checks if the manipulation data is valid for processing.
    /// </summary>
    public bool IsValid() => _context.IsValid();
```

Checks if the manipulation data is valid for processing.

**Returns:** `bool`

### QueueFreeManipulationObjects

```csharp
/// <summary>
    /// Queues free for manipulation objects (move copy, etc.).
    /// </summary>
    public void QueueFreeManipulationObjects()
    {
        if (MoveCopy != null)
        {
            MoveCopy.QueueFree();
            MoveCopy = null;
        }
    }
```

Queues free for manipulation objects (move copy, etc.).

**Returns:** `void`

### Validate

```csharp
/// <summary>
    /// Validates the manipulation using Core service.
    /// </summary>
    public ValidationResults Validate()
    {
        return _contextService.ValidateContext(_context);
    }
```

Validates the manipulation using Core service.

**Returns:** `ValidationResults`

### GetCoreContext

```csharp
/// <summary>
    /// Gets the underlying Core context for advanced operations.
    /// </summary>
    public ManipulationContext GetCoreContext() => _context;
```

Gets the underlying Core context for advanced operations.

**Returns:** `ManipulationContext`

### _Notification

```csharp
#endregion

    #region Cleanup

    public override void _Notification(int what)
    {
        if (what == NotificationPredelete)
        {
            // Clean up event subscriptions
            _contextService.ContextStatusChanged -= OnContextStatusChanged;
            _contextService.ContextUpdated -= OnContextUpdated;
        }
    }
```

**Returns:** `void`

**Parameters:**
- `int what`

