---
title: "DragPathVisualizationNode"
description: "Godot node for visualizing drag paths using Core DragPathCalculator
Handles Line2D rendering and Marker2D placement for path visualization"
weight: 20
url: "/gridbuilding/v6-0/api/godot/dragpathvisualizationnode/"
---

# DragPathVisualizationNode

```csharp
GridBuilding.Godot.UI
class DragPathVisualizationNode
{
    // Members...
}
```

Godot node for visualizing drag paths using Core DragPathCalculator
Handles Line2D rendering and Marker2D placement for path visualization

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/DragPathVisualizationNode.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PathColor

```csharp
#endregion
        
        #region Export Properties
        
        [ExportGroup("Visualization Settings")]
        [Export] public Color PathColor { get; set; } = Colors.Yellow;
```

### PathWidth

```csharp
[Export] public float PathWidth { get; set; } = 3.0f;
```

### ShowMarkers

```csharp
[Export] public bool ShowMarkers { get; set; } = true;
```

### ShowCurrentPosition

```csharp
[Export] public bool ShowCurrentPosition { get; set; } = true;
```

### StartMarkerColor

```csharp
[ExportGroup("Marker Settings")]
        [Export] public Color StartMarkerColor { get; set; } = Colors.Green;
```

### EndMarkerColor

```csharp
[Export] public Color EndMarkerColor { get; set; } = Colors.Red;
```

### CurrentMarkerColor

```csharp
[Export] public Color CurrentMarkerColor { get; set; } = Colors.Blue;
```

### MarkerSize

```csharp
[Export] public float MarkerSize { get; set; } = 10.0f;
```

### AnimatePath

```csharp
[ExportGroup("Animation Settings")]
        [Export] public bool AnimatePath { get; set; } = false;
```

### AnimationSpeed

```csharp
[Export] public float AnimationSpeed { get; set; } = 2.0f;
```

### Calculator

```csharp
#endregion
        
        #region Public Properties
        
        /// <summary>
        /// Access to the core drag path calculator
        /// </summary>
        public DragPathCalculator Calculator => _calculator;
```

Access to the core drag path calculator

### IsPathActive

```csharp
/// <summary>
        /// Current path visualization state
        /// </summary>
        public bool IsPathActive => _calculator.IsActive;
```

Current path visualization state


## Methods

### _Ready

```csharp
#endregion
        
        #region Godot Lifecycle
        
        public override void _Ready()
        {
            base._Ready();
            
            InitializeVisualization();
            ConnectToCalculatorEvents();
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            DisconnectFromCalculatorEvents();
            base._ExitTree();
        }
```

**Returns:** `void`

### _Process

```csharp
public override void _Process(double delta)
        {
            base._Process(delta);
            
            if (AnimatePath && _calculator.IsActive)
            {
                _animationTime += delta;
                UpdateAnimation();
            }
        }
```

**Returns:** `void`

**Parameters:**
- `double delta`

### StartPath

```csharp
#endregion
        
        #region Public Methods
        
        /// <summary>
        /// Starts a new drag path visualization
        /// </summary>
        /// <param name="startPoint">Starting position in world coordinates</param>
        public void StartPath(Vector2 startPoint)
        {
            var corePoint = startPoint.ToCore();
            _calculator.StartPath(corePoint);
            
            if (!_isInitialized)
                InitializeVisualization();
                
            Show();
        }
```

Starts a new drag path visualization

**Returns:** `void`

**Parameters:**
- `Vector2 startPoint`

### UpdatePath

```csharp
/// <summary>
        /// Updates the drag path visualization
        /// </summary>
        /// <param name="point">New position in world coordinates</param>
        public void UpdatePath(Vector2 point)
        {
            var corePoint = point.ToCore();
            _calculator.UpdatePath(corePoint);
            UpdateVisualization();
        }
```

Updates the drag path visualization

**Returns:** `void`

**Parameters:**
- `Vector2 point`

### CompletePath

```csharp
/// <summary>
        /// Completes the drag path visualization
        /// </summary>
        /// <returns>Path result data</returns>
        public DragPathResult CompletePath()
        {
            var result = _calculator.CompletePath();
            
            if (AnimatePath)
            {
                PlayCompletionAnimation();
            }
            
            return result;
        }
```

Completes the drag path visualization

**Returns:** `DragPathResult`

### CancelPath

```csharp
/// <summary>
        /// Cancels the drag path visualization
        /// </summary>
        public void CancelPath()
        {
            _calculator.CancelPath();
            Hide();
        }
```

Cancels the drag path visualization

**Returns:** `void`

### UpdateSettings

```csharp
/// <summary>
        /// Updates visualization settings
        /// </summary>
        /// <param name="settings">New settings</param>
        public void UpdateSettings(DragPathSettings settings)
        {
            _calculator.Settings = settings;
        }
```

Updates visualization settings

**Returns:** `void`

**Parameters:**
- `DragPathSettings settings`

### GetStatistics

```csharp
/// <summary>
        /// Gets current path statistics
        /// </summary>
        /// <returns>Path statistics</returns>
        public DragPathStatistics GetStatistics()
        {
            return _calculator.GetStatistics();
        }
```

Gets current path statistics

**Returns:** `DragPathStatistics`

