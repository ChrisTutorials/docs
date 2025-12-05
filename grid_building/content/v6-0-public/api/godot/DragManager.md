---
title: "DragManager"
description: ""
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/dragmanager/"
---

# DragManager

```csharp
GridBuilding.Godot.UI
class DragManager
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/DragManager.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnableDragPreview

```csharp
#endregion
        
        #region Export Properties
        
        [Export] public bool EnableDragPreview { get; set; } = true;
```

### EnableDragGhost

```csharp
[Export] public bool EnableDragGhost { get; set; } = true;
```

### DragThreshold

```csharp
[Export] public float DragThreshold { get; set; } = 10.0f;
```

### DragPreviewOpacity

```csharp
[Export] public float DragPreviewOpacity { get; set; } = 0.7f;
```

### DragPreviewTint

```csharp
public Color DragPreviewTint { get; set; } = Colors.White;
```

### DragGhostOpacity

```csharp
[Export] public float DragGhostOpacity { get; set; } = 0.3f;
```

### DragGhostScale

```csharp
[Export] public float DragGhostScale { get; set; } = 0.8f;
```

### SnapToGrid

```csharp
[Export] public bool SnapToGrid { get; set; } = true;
```

### GridSize

```csharp
public Vector2I GridSize { get; set; } = new Vector2I(32, 32);
```

### ShowDragPath

```csharp
[Export] public bool ShowDragPath { get; set; } = true;
```

### DragPathColor

```csharp
public Color DragPathColor { get; set; } = Colors.Yellow;
```

### DragPathWidth

```csharp
[Export] public float DragPathWidth { get; set; } = 2.0f;
```

### IsDragging

```csharp
#endregion
        
        #region Public Properties
        
        public bool IsDragging => _isDragging;
```

### CurrentDragData

```csharp
public DragPathData? CurrentDragData => _currentDragData;
```

### CurrentTarget

```csharp
public IDragDropTarget? CurrentTarget => _currentTarget;
```

### DragStartPosition

```csharp
public Vector2 DragStartPosition => _dragStartPosition;
```


## Methods

### _Ready

```csharp
#endregion
        
        #region Godot Lifecycle
        
        public override void _Ready()
        {
            base._Ready();
            
            // Set up input handling
            SetProcessInput(true);
            SetProcessUnhandledInput(true);
            
            // Find camera if not set
            if (_camera == null)
            {
                _camera = GetViewport().GetCamera2D();
            }
            
            // Create drag preview and ghost
            CreateDragVisuals();
            
            GD.Print("DragManager initialized");
        }
```

**Returns:** `void`

### _Input

```csharp
public override void _Input(InputEvent @event)
        {
            base._Input(@event);
            
            // Handle mouse input for drag operations
            if (@event is InputEventMouseButton mouseButton)
            {
                HandleMouseButton(mouseButton);
            }
            else if (@event is InputEventMouseMotion mouseMotion)
            {
                HandleMouseMotion(mouseMotion);
            }
        }
```

**Returns:** `void`

**Parameters:**
- `InputEvent event`

### _UnhandledInput

```csharp
public override void _UnhandledInput(InputEvent @event)
        {
            base._UnhandledInput(@event);
            
            // Handle keyboard shortcuts for drag operations
            if (@event is InputEventKey keyEvent && keyEvent.Pressed)
            {
                HandleKeyboardInput(keyEvent);
            }
        }
```

**Returns:** `void`

**Parameters:**
- `InputEvent event`

### _Process

```csharp
public override void _Process(double delta)
        {
            base._Process(delta);
            
            // Update drag visuals if dragging
            if (_isDragging && _currentDragData != null)
            {
                UpdateDragVisuals();
                UpdateDropTargetValidation();
            }
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### RegisterDropTarget

```csharp
#endregion
        
        #region Public Methods
        
        /// <summary>
        /// Registers a drop target
        /// </summary>
        public void RegisterDropTarget(IDragDropTarget target)
        {
            if (target != null && !_dropTargets.Contains(target))
            {
                _dropTargets.Add(target);
                GD.Print($"Registered drop target: {target.GetType().Name}");
            }
        }
```

Registers a drop target

**Returns:** `void`

**Parameters:**
- `IDragDropTarget target`

### UnregisterDropTarget

```csharp
/// <summary>
        /// Unregisters a drop target
        /// </summary>
        public void UnregisterDropTarget(IDragDropTarget target)
        {
            if (target != null && _dropTargets.Contains(target))
            {
                _dropTargets.Remove(target);
                GD.Print($"Unregistered drop target: {target.GetType().Name}");
            }
        }
```

Unregisters a drop target

**Returns:** `void`

**Parameters:**
- `IDragDropTarget target`

### StartDrag

```csharp
/// <summary>
        /// Starts a drag operation
        /// </summary>
        public bool StartDrag(DragPathData dragData, Vector2 startPosition)
        {
            if (_isDragging)
            {
                GD.PrintErr("Drag operation already in progress");
                return false;
            }
            
            if (dragData == null)
            {
                GD.PrintErr("Drag data cannot be null");
                return false;
            }
            
            _isDragging = true;
            _currentDragData = dragData;
            _dragStartPosition = startPosition;
            _lastMousePosition = startPosition;
            
            // Initialize drag data
            _currentDragData.StartPosition = startPosition;
            _currentDragData.CurrentPosition = startPosition;
            _currentDragData.StartTime = Time.GetUnixTimeFromSystem();
            
            // Show drag visuals
            ShowDragVisuals();
            
            // Emit signal
            EmitSignal(SignalName.DragStarted, _currentDragData);
            
            GD.Print($"Drag operation started: {dragData.DragType}");
            return true;
        }
```

Starts a drag operation

**Returns:** `bool`

**Parameters:**
- `DragPathData dragData`
- `Vector2 startPosition`

### EndDrag

```csharp
/// <summary>
        /// Ends the current drag operation
        /// </summary>
        public bool EndDrag(bool success = true)
        {
            if (!_isDragging || _currentDragData == null)
            {
                return false;
            }
            
            _currentDragData.EndPosition = _lastMousePosition;
            _currentDragData.EndTime = Time.GetUnixTimeFromSystem();
            _currentDragData.Success = success;
            
            // Hide drag visuals
            HideDragVisuals();
            
            // Emit signals
            EmitSignal(SignalName.DragEnded, _currentDragData);
            
            if (success && _currentTarget != null)
            {
                _currentTarget.HandleDrop(_currentDragData);
                EmitSignal(SignalName.DropCompleted, _currentDragData);
            }
            
            // Reset state
            _isDragging = false;
            _currentDragData = null;
            _currentTarget = null;
            
            GD.Print($"Drag operation ended: {(success ? "Success" : "Cancelled")}");
            return true;
        }
```

Ends the current drag operation

**Returns:** `bool`

**Parameters:**
- `bool success`

### CancelDrag

```csharp
/// <summary>
        /// Cancels the current drag operation
        /// </summary>
        public void CancelDrag()
        {
            if (_isDragging)
            {
                EndDrag(false);
            }
        }
```

Cancels the current drag operation

**Returns:** `void`

### SetCamera

```csharp
/// <summary>
        /// Sets the camera for drag operations
        /// </summary>
        public void SetCamera(Camera2D camera)
        {
            _camera = camera;
        }
```

Sets the camera for drag operations

**Returns:** `void`

**Parameters:**
- `Camera2D camera`

