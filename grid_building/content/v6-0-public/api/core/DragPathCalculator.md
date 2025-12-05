---
title: "DragPathCalculator"
description: "Pure C# drag path calculation and smoothing logic
Extracted from DragPathData to enable unit testing and reusability
Handles Catmull-Rom spline smoothing and path analysis"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/dragpathcalculator/"
---

# DragPathCalculator

```csharp
GridBuilding.Core.Systems.Geometry
class DragPathCalculator
{
    // Members...
}
```

Pure C# drag path calculation and smoothing logic
Extracted from DragPathData to enable unit testing and reusability
Handles Catmull-Rom spline smoothing and path analysis

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/DragPathCalculator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Settings

```csharp
#endregion
        
        #region Properties
        
        public DragPathSettings Settings 
        { 
            get => _settings; 
            set => _settings = value ?? new DragPathSettings(); 
        }
```

### IsActive

```csharp
public bool IsActive => _isActive;
```

### RawPoints

```csharp
public Vector2[] RawPoints => _rawPoints.ToArray();
```

### SmoothedPoints

```csharp
public Vector2[] SmoothedPoints => _smoothedPoints.ToArray();
```

### TotalDistance

```csharp
public float TotalDistance => CalculateTotalDistance(_smoothedPoints);
```

### Duration

```csharp
public TimeSpan Duration => _isActive ? DateTime.UtcNow - _startTime : TimeSpan.Zero;
```


## Methods

### StartPath

```csharp
#endregion
        
        #region Public Methods
        
        /// <summary>
        /// Starts a new drag path
        /// </summary>
        /// <param name="startPoint">Starting position</param>
        public void StartPath(Vector2 startPoint)
        {
            if (_isActive)
                CancelPath();
                
            _isActive = true;
            _startTime = DateTime.UtcNow;
            
            _rawPoints.Clear();
            _smoothedPoints.Clear();
            
            _rawPoints.Add(startPoint);
            _smoothedPoints.Add(startPoint);
            
            PathStarted?.Invoke(startPoint);
        }
```

Starts a new drag path

**Returns:** `void`

**Parameters:**
- `Vector2 startPoint`

### UpdatePath

```csharp
/// <summary>
        /// Updates the drag path with a new point
        /// </summary>
        /// <param name="point">New position</param>
        public void UpdatePath(Vector2 point)
        {
            if (!_isActive)
                return;
                
            // Check if point is far enough from last point to avoid duplicates
            if (_rawPoints.Count > 0)
            {
                var lastPoint = _rawPoints[^1];
                var distance = point.DistanceTo(lastPoint);
                
                if (distance < _settings.MinimumPointDistance)
                    return;
            }
            
            _rawPoints.Add(point);
            
            // Update smoothed points
            UpdateSmoothedPoints();
            
            PathUpdated?.Invoke(_smoothedPoints.ToArray());
        }
```

Updates the drag path with a new point

**Returns:** `void`

**Parameters:**
- `Vector2 point`

### CompletePath

```csharp
/// <summary>
        /// Completes the drag path and returns the result
        /// </summary>
        /// <returns>Drag path result with calculated data</returns>
        public DragPathResult CompletePath()
        {
            if (!_isActive)
                return new DragPathResult { Success = false };
                
            _isActive = false;
            
            var result = new DragPathResult
            {
                Success = true,
                RawPoints = _rawPoints.ToArray(),
                SmoothedPoints = _smoothedPoints.ToArray(),
                TotalDistance = TotalDistance,
                Duration = Duration,
                AverageSpeed = CalculateAverageSpeed(),
                PointCount = _rawPoints.Count
            };
            
            // Validate path
            result.IsValid = ValidatePath(result);
            
            PathCompleted?.Invoke(result);
            
            return result;
        }
```

Completes the drag path and returns the result

**Returns:** `DragPathResult`

### CancelPath

```csharp
/// <summary>
        /// Cancels the current drag path
        /// </summary>
        public void CancelPath()
        {
            if (!_isActive)
                return;
                
            _isActive = false;
            _rawPoints.Clear();
            _smoothedPoints.Clear();
            
            PathCancelled?.Invoke();
        }
```

Cancels the current drag path

**Returns:** `void`

### ClearPath

```csharp
/// <summary>
        /// Clears all path data
        /// </summary>
        public void ClearPath()
        {
            CancelPath();
        }
```

Clears all path data

**Returns:** `void`

### GetStatistics

```csharp
/// <summary>
        /// Gets path statistics
        /// </summary>
        /// <returns>Path statistics</returns>
        public DragPathStatistics GetStatistics()
        {
            return new DragPathStatistics
            {
                PointCount = _rawPoints.Count,
                TotalDistance = TotalDistance,
                Duration = Duration,
                AverageSpeed = CalculateAverageSpeed(),
                Smoothness = CalculateSmoothness(),
                Direction = CalculatePrimaryDirection()
            };
        }
```

Gets path statistics

**Returns:** `DragPathStatistics`

### CalculateSmoothedPoints

```csharp
/// <summary>
        /// Calculates smoothed points from raw points using Catmull-Rom spline
        /// </summary>
        /// <param name="points">Raw input points</param>
        /// <param name="tension">Spline tension (0-1)</param>
        /// <returns>Smoothed points</returns>
        public static Vector2[] CalculateSmoothedPoints(Vector2[] points, float tension = 0.5f)
        {
            if (points == null || points.Length < 2)
                return points ?? Array.Empty<Vector2>();
                
            if (points.Length == 2)
                return points; // No smoothing needed for 2 points
                
            var smoothedPoints = new List<Vector2>();
            var segments = points.Length - 1;
            
            for (int i = 0; i < segments; i++)
            {
                var p0 = points[Max(0, i - 1)];
                var p1 = points[i];
                var p2 = points[Min(points.Length - 1, i + 1)];
                var p3 = points[Min(points.Length - 1, i + 2)];
                
                // Generate smooth points between p1 and p2
                var smoothSegment = CalculateCatmullRomSegment(p0, p1, p2, p3, tension);
                smoothedPoints.AddRange(smoothSegment);
            }
            
            // Add the last point
            smoothedPoints.Add(points[^1]);
            
            return smoothedPoints.ToArray();
        }
```

Calculates smoothed points from raw points using Catmull-Rom spline

**Returns:** `Vector2[]`

**Parameters:**
- `Vector2[] points`
- `float tension`

