---
title: "AStarPathManagerTests"
description: "Comprehensive tests for AStarPathManager
Tests the A* pathfinding functionality"
weight: 20
url: "/gridbuilding/v6-0/api/godot/astarpathmanagertests/"
---

# AStarPathManagerTests

```csharp
GridBuilding.Godot.Tests.Navigation
class AStarPathManagerTests
{
    // Members...
}
```

Comprehensive tests for AStarPathManager
Tests the A* pathfinding functionality

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GBAStarPathManagerTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Navigation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### AStarPathManager_Initialization_ShouldWork

```csharp
[Fact]
        public void AStarPathManager_Initialization_ShouldWork()
        {
            // Arrange
            var pathManager = CreatePathManager();
            
            // Act
            pathManager._Ready();
            
            // Assert
            ;
            ; // 10x10 grid
        }
```

**Returns:** `void`

### FindPath_ValidPath_ShouldReturnCorrectPath

```csharp
[Fact]
        public void FindPath_ValidPath_ShouldReturnCorrectPath()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var start = new Vector2I(0, 0);
            var end = new Vector2I(9, 9);
            
            // Act
            var path = pathManager.FindPath(start, end);
            
            // Assert
            ;
            ;
            ;
            ;
        }
```

**Returns:** `void`

### FindPath_SameStartAndEnd_ShouldReturnSinglePoint

```csharp
[Fact]
        public void FindPath_SameStartAndEnd_ShouldReturnSinglePoint()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var point = new Vector2I(5, 5);
            
            // Act
            var path = pathManager.FindPath(point, point);
            
            // Assert
            ;
            Assert.Single(path);
            ;
        }
```

**Returns:** `void`

### FindPath_OutOfBounds_ShouldReturnEmpty

```csharp
[Fact]
        public void FindPath_OutOfBounds_ShouldReturnEmpty()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var start = new Vector2I(-1, 0);
            var end = new Vector2I(9, 9);
            
            // Act
            var path = pathManager.FindPath(start, end);
            
            // Assert
            ;
        }
```

**Returns:** `void`

### FindPath_Uninitialized_ShouldReturnEmpty

```csharp
[Fact]
        public void FindPath_Uninitialized_ShouldReturnEmpty()
        {
            // Arrange
            var pathManager = CreatePathManager();
            // Don't call _Ready()
            
            var start = new Vector2I(0, 0);
            var end = new Vector2I(9, 9);
            
            // Act
            var path = pathManager.FindPath(start, end);
            
            // Assert
            ;
        }
```

**Returns:** `void`

### IsPathClear_ValidPath_ShouldReturnTrue

```csharp
[Fact]
        public void IsPathClear_ValidPath_ShouldReturnTrue()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var start = new Vector2I(0, 0);
            var end = new Vector2I(9, 9);
            
            // Act
            var isClear = pathManager.IsPathClear(start, end);
            
            // Assert
            ;
        }
```

**Returns:** `void`

### GetDistance_ValidPoints_ShouldReturnCorrectDistance

```csharp
[Fact]
        public void GetDistance_ValidPoints_ShouldReturnCorrectDistance()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var start = new Vector2I(0, 0);
            var end = new Vector2I(2, 2);
            
            // Act
            var distance = pathManager.GetDistance(start, end);
            
            // Assert
            ;
            ;
        }
```

**Returns:** `void`

### AddPoint_NewPoint_ShouldAddSuccessfully

```csharp
[Fact]
        public void AddPoint_NewPoint_ShouldAddSuccessfully()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var point = new Vector2I(15, 15); // Outside initial grid
            var initialCount = pathManager.PointCount;
            
            // Act
            pathManager.AddPoint(point, 2.0f);
            
            // Assert
            ;
        }
```

**Returns:** `void`

### AddPoint_ExistingPoint_ShouldNotDuplicate

```csharp
[Fact]
        public void AddPoint_ExistingPoint_ShouldNotDuplicate()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var point = new Vector2I(5, 5);
            var initialCount = pathManager.PointCount;
            
            // Act
            pathManager.AddPoint(point, 2.0f);
            
            // Assert
            ; // No change
        }
```

**Returns:** `void`

### RemovePoint_ExistingPoint_ShouldRemoveSuccessfully

```csharp
[Fact]
        public void RemovePoint_ExistingPoint_ShouldRemoveSuccessfully()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var point = new Vector2I(5, 5);
            var initialCount = pathManager.PointCount;
            
            // Act
            pathManager.RemovePoint(point);
            
            // Assert
            ;
        }
```

**Returns:** `void`

### ConnectPoints_AdjacentPoints_ShouldConnect

```csharp
[Fact]
        public void ConnectPoints_AdjacentPoints_ShouldConnect()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var point1 = new Vector2I(0, 0);
            var point2 = new Vector2I(1, 0);
            
            // Act & Assert - Should not throw
            pathManager.ConnectPoints(point1, point2, 1.0f);
        }
```

**Returns:** `void`

### ConnectPoints_NonAdjacentPoints_ShouldNotConnect

```csharp
[Fact]
        public void ConnectPoints_NonAdjacentPoints_ShouldNotConnect()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var point1 = new Vector2I(0, 0);
            var point2 = new Vector2I(5, 5);
            
            // Act & Assert - Should not throw or cause issues
            pathManager.ConnectPoints(point1, point2, 1.0f);
            
            // Verify path still works (non-adjacent points shouldn't be connected)
            var path = pathManager.FindPath(point1, point2);
            ; // Should require intermediate steps
        }
```

**Returns:** `void`

### UpdatePointWeight_ExistingPoint_ShouldUpdate

```csharp
[Fact]
        public void UpdatePointWeight_ExistingPoint_ShouldUpdate()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var point = new Vector2I(5, 5);
            
            // Act & Assert - Should not throw
            pathManager.UpdatePointWeight(point, 5.0f);
        }
```

**Returns:** `void`

### GetPointsInRadius_ValidRadius_ShouldReturnCorrectPoints

```csharp
[Fact]
        public void GetPointsInRadius_ValidRadius_ShouldReturnCorrectPoints()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var center = new Vector2I(5, 5);
            var radius = 2;
            
            // Act
            var points = pathManager.GetPointsInRadius(center, radius);
            
            // Assert
            ;
            ;
            ; // Max points in square
            
            // All points should be within radius
            foreach (var point in points)
            {
                var distance = Mathf.Sqrt(
                    Mathf.Pow(point.X - center.X, 2) + 
                    Mathf.Pow(point.Y - center.Y, 2)
                );
                ;
            }
        }
```

**Returns:** `void`

### ClearAllPoints_ShouldRemoveAllPoints

```csharp
[Fact]
        public void ClearAllPoints_ShouldRemoveAllPoints()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            ;
            
            // Act
            pathManager.ClearAllPoints();
            
            // Assert
            ;
        }
```

**Returns:** `void`

### RecalculateNavigationGrid_ShouldRebuildGrid

```csharp
[Fact]
        public void RecalculateNavigationGrid_ShouldRebuildGrid()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var initialCount = pathManager.PointCount;
            
            // Act
            pathManager.RecalculateNavigationGrid();
            
            // Assert
            ; // Should rebuild to same size
        }
```

**Returns:** `void`

### DiagonalMovement_Disabled_ShouldOnlyUseCardinalDirections

```csharp
[Fact]
        public void DiagonalMovement_Disabled_ShouldOnlyUseCardinalDirections()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager.EnableDiagonalMovement = false;
            pathManager._Ready();
            
            var start = new Vector2I(0, 0);
            var end = new Vector2I(2, 2);
            
            // Act
            var path = pathManager.FindPath(start, end);
            
            // Assert
            ;
            ;
            
            // Path should be longer when diagonal movement is disabled
            ; // 0,0 -> 0,1 -> 0,2 -> 1,2 -> 2,2 or similar
        }
```

**Returns:** `void`

### MaxPathLength_Exceeded_ShouldReturnEmpty

```csharp
[Fact]
        public void MaxPathLength_Exceeded_ShouldReturnEmpty()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager.MaxPathLength = 5; // Very short
            pathManager._Ready();
            
            var start = new Vector2I(0, 0);
            var end = new Vector2I(9, 9);
            
            // Act
            var path = pathManager.FindPath(start, end);
            
            // Assert
            ; // Path too long
        }
```

**Returns:** `void`

### Signal_PathCalculated_ShouldBeEmitted

```csharp
[Fact]
        public void Signal_PathCalculated_ShouldBeEmitted()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var signalReceived = false;
            List<Vector2I> receivedPath = null;
            
            pathManager.PathCalculated += (path) =>
            {
                signalReceived = true;
                receivedPath = path;
            };
            
            var start = new Vector2I(0, 0);
            var end = new Vector2I(9, 9);
            
            // Act
            var path = pathManager.FindPath(start, end);
            
            // Assert
            ;
            ;
            ;
        }
```

**Returns:** `void`

### Signal_PathCalculationFailed_ShouldBeEmitted_WhenOutOfBounds

```csharp
[Fact]
        public void Signal_PathCalculationFailed_ShouldBeEmitted_WhenOutOfBounds()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            var signalReceived = false;
            string receivedReason = null;
            
            pathManager.PathCalculationFailed += (reason) =>
            {
                signalReceived = true;
                receivedReason = reason;
            };
            
            var start = new Vector2I(-1, 0);
            var end = new Vector2I(9, 9);
            
            // Act
            var path = pathManager.FindPath(start, end);
            
            // Assert
            ;
            ;
            ;
        }
```

**Returns:** `void`

### Cleanup_ShouldWorkCorrectly

```csharp
[Fact]
        public void Cleanup_ShouldWorkCorrectly()
        {
            // Arrange
            var pathManager = CreatePathManager();
            pathManager._Ready();
            
            ;
            ;
            
            // Act
            pathManager._ExitTree();
            
            // Assert
            ;
            ;
        }
```

**Returns:** `void`

