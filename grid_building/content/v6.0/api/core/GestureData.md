---
title: "GestureData"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/gesturedata/"
---

# GestureData

```csharp
GridBuilding.Core.Systems
class GestureData
{
    // Members...
}
```

Gesture tracking data

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/InputManager.cs`  
**Namespace:** `GridBuilding.Core.Systems`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Type

```csharp
public GestureType Type { get; set; }
```

### StartTime

```csharp
public DateTime StartTime { get; set; }
```

### StartPosition

```csharp
public Vector2 StartPosition { get; set; }
```

### Points

```csharp
public List<Vector2> Points { get; set; } = new();
```

### TotalDistance

```csharp
public float TotalDistance
        {
            get
            {
                if (Points.Count < 2)
                    return 0f;
                    
                var totalDistance = 0f;
                for (int i = 1; i < Points.Count; i++)
                {
                    totalDistance += Points[i].DistanceTo(Points[i - 1]);
                }
                
                return totalDistance;
            }
        }
```


## Methods

### AddPoint

```csharp
public void AddPoint(Vector2 point)
        {
            Points.Add(point);
        }
```

**Returns:** `void`

**Parameters:**
- `Vector2 point`

