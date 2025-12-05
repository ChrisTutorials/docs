---
title: "GridTargetingService"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/gridtargetingservice/"
---

# GridTargetingService

```csharp
GridBuilding.Core.Services.Targeting
class GridTargetingService
{
    // Members...
}
```

Core implementation of grid targeting service providing engine-agnostic
business logic for tile validation, pathfinding, and grid navigation.
This service provides the heavy algorithms and business rules that
Godot components can delegate to for optimal performance and testability.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Targeting/GridTargetingService.cs`  
**Namespace:** `GridBuilding.Core.Services.Targeting`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CurrentTargetTile

```csharp
#endregion

        #region Targeting State

        /// <summary>
        /// Gets the current target tile
        /// </summary>
        public Vector2I CurrentTargetTile => _currentTargetTile;
```

Gets the current target tile

### IsTargetingActive

```csharp
/// <summary>
        /// Checks if targeting is currently active
        /// </summary>
        public bool IsTargetingActive => _isTargetingActive;
```

Checks if targeting is currently active

### Configuration

```csharp
/// <summary>
        /// Gets current targeting configuration
        /// </summary>
        public GridTargetingConfiguration Configuration => _configuration ?? new GridTargetingConfiguration();
```

Gets current targeting configuration


## Methods

### FindPath

```csharp
#endregion

        #region Pathfinding Operations

        /// <summary>
        /// Finds a path between two grid positions
        /// </summary>
        /// <param name="startPosition">Starting grid position</param>
        /// <param name="endPosition">Ending grid position</param>
        /// <returns>List of grid positions representing the path, empty if no path found</returns>
        public List<Vector2I> FindPath(Vector2I startPosition, Vector2I endPosition)
        {
            if (_navigationData == null)
                return new List<Vector2I>();

            try
            {
                var path = AStarPathfinding.FindPath(startPosition, endPosition, _navigationData, _configuration);
                var distance = CalculatePathDistance(path);

                PathCalculated?.Invoke(this, new PathCalculatedEventArgs(path, distance, startPosition, endPosition));
                return path;
            }
            catch (Exception ex)
            {
                PathCalculationFailed?.Invoke(this, new PathCalculationFailedEventArgs(ex.Message, startPosition, endPosition));
                return new List<Vector2I>();
            }
        }
```

Finds a path between two grid positions

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I startPosition`
- `Vector2I endPosition`

### IsPathClear

```csharp
/// <summary>
        /// Checks if a clear path exists between two positions
        /// </summary>
        /// <param name="startPosition">Starting position</param>
        /// <param name="endPosition">Ending position</param>
        /// <returns>True if a clear path exists</returns>
        public bool IsPathClear(Vector2I startPosition, Vector2I endPosition)
        {
            var path = FindPath(startPosition, endPosition);
            return path.Count > 0;
        }
```

Checks if a clear path exists between two positions

**Returns:** `bool`

**Parameters:**
- `Vector2I startPosition`
- `Vector2I endPosition`

### GetPathDistance

```csharp
/// <summary>
        /// Gets the path distance between two positions
        /// </summary>
        /// <param name="startPosition">Starting position</param>
        /// <param name="endPosition">Ending position</param>
        /// <returns>Distance in grid units, or MaxValue if no path</returns>
        public float GetPathDistance(Vector2I startPosition, Vector2I endPosition)
        {
            var path = FindPath(startPosition, endPosition);
            return CalculatePathDistance(path);
        }
```

Gets the path distance between two positions

**Returns:** `float`

**Parameters:**
- `Vector2I startPosition`
- `Vector2I endPosition`

### GetClosestValidTile

```csharp
/// <summary>
        /// Gets the closest valid tile to a target position
        /// </summary>
        /// <param name="targetPosition">Desired target position</param>
        /// <param name="sourcePosition">Source position for distance calculations</param>
        /// <param name="maxDistance">Maximum distance from source</param>
        /// <returns>Closest valid tile position</returns>
        public Vector2I GetClosestValidTile(Vector2I targetPosition, Vector2I sourcePosition, int maxDistance)
        {
            if (_navigationData == null)
                return targetPosition;

            var searchRadius = MathUtils.Min(maxDistance, _configuration.MaxTilesDistance);
            var validTiles = GetValidTilesInRadius(targetPosition, searchRadius);

            if (validTiles.Count == 0)
                return sourcePosition;

            // Find the tile closest to the target position
            return validTiles
                .OrderBy(tile => tile.DistanceSquaredTo(targetPosition))
                .ThenBy(tile => tile.DistanceSquaredTo(sourcePosition))
                .First();
        }
```

Gets the closest valid tile to a target position

**Returns:** `Vector2I`

**Parameters:**
- `Vector2I targetPosition`
- `Vector2I sourcePosition`
- `int maxDistance`

### IsValidTargetTile

```csharp
#endregion

        #region Tile Validation

        /// <summary>
        /// Validates if a tile position is valid for targeting
        /// </summary>
        /// <param name="position">Tile position to validate</param>
        /// <returns>True if the tile is valid for targeting</returns>
        public bool IsValidTargetTile(Vector2I position)
        {
            if (_navigationData == null)
                return false;

            if (!_navigationData.Tiles.TryGetValue(position, out var tileData))
                return false;

            return tileData.IsWalkable && tileData.Weight > 0;
        }
```

Validates if a tile position is valid for targeting

**Returns:** `bool`

**Parameters:**
- `Vector2I position`

### IsWalkableTile

```csharp
/// <summary>
        /// Checks if a tile position is walkable
        /// </summary>
        /// <param name="position">Tile position to check</param>
        /// <returns>True if the tile is walkable</returns>
        public bool IsWalkableTile(Vector2I position)
        {
            if (_navigationData == null)
                return false;

            return _navigationData.Tiles.TryGetValue(position, out var tileData) && tileData.IsWalkable;
        }
```

Checks if a tile position is walkable

**Returns:** `bool`

**Parameters:**
- `Vector2I position`

### GetValidTilesInRadius

```csharp
/// <summary>
        /// Gets all valid tiles within a specified radius
        /// </summary>
        /// <param name="centerPosition">Center position</param>
        /// <param name="radius">Search radius</param>
        /// <returns>List of valid tile positions</returns>
        public List<Vector2I> GetValidTilesInRadius(Vector2I centerPosition, int radius)
        {
            var validTiles = new List<Vector2I>();

            if (_navigationData == null)
                return validTiles;

            for (int x = centerPosition.X - radius; x <= centerPosition.X + radius; x++)
            {
                for (int y = centerPosition.Y - radius; y <= centerPosition.Y + radius; y++)
                {
                    var tilePos = new Vector2I(x, y);
                    if (IsValidTargetTile(tilePos))
                    {
                        validTiles.Add(tilePos);
                    }
                }
            }

            return validTiles;
        }
```

Gets all valid tiles within a specified radius

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I centerPosition`
- `int radius`

### ValidateTilePlacement

```csharp
/// <summary>
        /// Validates tile placement according to targeting rules
        /// </summary>
        /// <param name="position">Tile position to validate</param>
        /// <param name="buildingType">Type of building (optional)</param>
        /// <returns>List of validation errors, empty if valid</returns>
        public List<string> ValidateTilePlacement(Vector2I position, string? buildingType = null)
        {
            var errors = new List<string>();

            if (!IsValidTargetTile(position))
                errors.Add("Tile is not valid for targeting");

            if (!IsWalkableTile(position))
                errors.Add("Tile is not walkable");

            if (_configuration.LimitToAdjacentTiles)
            {
                var distance = position.DistanceSquaredTo(_currentTargetTile);
                var maxDistanceSquared = _configuration.MaxTilesDistance * _configuration.MaxTilesDistance;
                if (distance > maxDistanceSquared)
                    errors.Add($"Tile is beyond maximum distance ({_configuration.MaxTilesDistance})");
            }

            return errors;
        }
```

Validates tile placement according to targeting rules

**Returns:** `List<string>`

**Parameters:**
- `Vector2I position`
- `string? buildingType`

### UpdateGridNavigation

```csharp
#endregion

        #region Grid Management

        /// <summary>
        /// Updates the grid navigation data
        /// </summary>
        /// <param name="gridData">Grid navigation data</param>
        public void UpdateGridNavigation(GridNavigationData gridData)
        {
            _navigationData = gridData ?? throw new ArgumentNullException(nameof(gridData));
            _validTargets.Clear();
            
            // Cache valid targets for performance
            foreach (var kvp in _navigationData.Tiles)
            {
                if (kvp.Value.IsWalkable)
                {
                    _validTargets.Add(kvp.Key);
                }
            }
        }
```

Updates the grid navigation data

**Returns:** `void`

**Parameters:**
- `GridNavigationData gridData`

### SetTileWalkability

```csharp
/// <summary>
        /// Sets walkability for a specific tile
        /// </summary>
        /// <param name="position">Tile position</param>
        /// <param name="isWalkable">Whether the tile is walkable</param>
        public void SetTileWalkability(Vector2I position, bool isWalkable)
        {
            if (_navigationData == null)
                return;

            if (!_navigationData.Tiles.TryGetValue(position, out var tileData))
            {
                tileData = new TileNavigationData { Position = position };
                _navigationData.Tiles[position] = tileData;
            }

            tileData.IsWalkable = isWalkable;

            if (isWalkable)
                _validTargets.Add(position);
            else
                _validTargets.Remove(position);
        }
```

Sets walkability for a specific tile

**Returns:** `void`

**Parameters:**
- `Vector2I position`
- `bool isWalkable`

### SetTileWeight

```csharp
/// <summary>
        /// Sets weight for a specific tile
        /// </summary>
        /// <param name="position">Tile position</param>
        /// <param name="weight">Tile weight (higher = more difficult to traverse)</param>
        public void SetTileWeight(Vector2I position, float weight)
        {
            if (_navigationData == null)
                return;

            if (!_navigationData.Tiles.TryGetValue(position, out var tileData))
            {
                tileData = new TileNavigationData { Position = position };
                _navigationData.Tiles[position] = tileData;
            }

            tileData.Weight = MathUtils.Max(0.1f, weight);
            _tileWeights[position] = tileData.Weight;
        }
```

Sets weight for a specific tile

**Returns:** `void`

**Parameters:**
- `Vector2I position`
- `float weight`

### ClearNavigationData

```csharp
/// <summary>
        /// Clears all navigation data
        /// </summary>
        public void ClearNavigationData()
        {
            _navigationData = null;
            _validTargets.Clear();
            _tileWeights.Clear();
            _componentStates.Clear();
        }
```

Clears all navigation data

**Returns:** `void`

### SetTargetTile

```csharp
/// <summary>
        /// Sets the current target tile
        /// </summary>
        /// <param name="position">New target position</param>
        public void SetTargetTile(Vector2I position)
        {
            var oldTarget = _currentTargetTile;
            _currentTargetTile = position;

            TargetingStateChanged?.Invoke(this, new TargetingStateChangedEventArgs(oldTarget, _currentTargetTile, _isTargetingActive));
        }
```

Sets the current target tile

**Returns:** `void`

**Parameters:**
- `Vector2I position`

### ClearTarget

```csharp
/// <summary>
        /// Clears the current target
        /// </summary>
        public void ClearTarget()
        {
            SetTargetTile(Vector2I.Zero);
        }
```

Clears the current target

**Returns:** `void`

### SetTargetingEnabled

```csharp
/// <summary>
        /// Enables or disables targeting mode
        /// </summary>
        /// <param name="enabled">Whether targeting should be enabled</param>
        public void SetTargetingEnabled(bool enabled)
        {
            _isTargetingActive = enabled;
            
            if (!enabled)
            {
                ClearTarget();
            }
        }
```

Enables or disables targeting mode

**Returns:** `void`

**Parameters:**
- `bool enabled`

### UpdateConfiguration

```csharp
#endregion

        #region Configuration

        /// <summary>
        /// Updates targeting configuration
        /// </summary>
        /// <param name="config">New targeting configuration</param>
        public void UpdateConfiguration(GridTargetingConfiguration config)
        {
            _configuration = config ?? throw new ArgumentNullException(nameof(config));
        }
```

Updates targeting configuration

**Returns:** `void`

**Parameters:**
- `GridTargetingConfiguration config`

### ValidateSetup

```csharp
/// <summary>
        /// Validates the current targeting setup
        /// </summary>
        /// <returns>List of validation issues, empty if valid</returns>
        public List<string> ValidateSetup()
        {
            var issues = new List<string>();

            if (_navigationData == null)
                issues.Add("Navigation data is not set");

            if (_configuration == null)
                issues.Add("Configuration is not set");

            if (_navigationData != null && _navigationData.Tiles.Count == 0)
                issues.Add("Navigation data contains no tiles");

            return issues;
        }
```

Validates the current targeting setup

**Returns:** `List<string>`

### ValidateTargetAtPosition

```csharp
#endregion

        #region Component-Specific Methods

        /// <summary>
        /// Validates target at specific position for a targeting component
        /// </summary>
        /// <param name="gridPosition">Grid position to validate</param>
        /// <param name="targetNode">Target node (optional)</param>
        /// <returns>True if target is valid at this position</returns>
        public bool ValidateTargetAtPosition(Vector2I gridPosition, object? targetNode)
        {
            if (!IsValidTargetTile(gridPosition))
                return false;

            // Additional component-specific validation can be added here
            // For now, basic tile validation is sufficient
            return true;
        }
```

Validates target at specific position for a targeting component

**Returns:** `bool`

**Parameters:**
- `Vector2I gridPosition`
- `object? targetNode`

### GetClosestValidTarget

```csharp
/// <summary>
        /// Gets the closest valid target to a desired position
        /// </summary>
        /// <param name="desiredPosition">Desired target position</param>
        /// <param name="sourceNode">Source node for distance calculations</param>
        /// <returns>Closest valid target position</returns>
        public Vector2I GetClosestValidTarget(Vector2I desiredPosition, object? sourceNode)
        {
            // Extract position from source node if available
            var sourcePosition = ExtractPositionFromNode(sourceNode);
            return GetClosestValidTile(desiredPosition, sourcePosition, _configuration.MaxTilesDistance);
        }
```

Gets the closest valid target to a desired position

**Returns:** `Vector2I`

**Parameters:**
- `Vector2I desiredPosition`
- `object? sourceNode`

### GetValidTargetsInRange

```csharp
/// <summary>
        /// Gets all valid targets within range of a center position
        /// </summary>
        /// <param name="centerPosition">Center position for search</param>
        /// <param name="range">Search range in grid units</param>
        /// <returns>List of valid target positions</returns>
        public List<Vector2I> GetValidTargetsInRange(Vector2I centerPosition, int range)
        {
            return GetValidTilesInRadius(centerPosition, range);
        }
```

Gets all valid targets within range of a center position

**Returns:** `List<Vector2I>`

**Parameters:**
- `Vector2I centerPosition`
- `int range`

### UpdateTargetingComponentState

```csharp
/// <summary>
        /// Updates the state of a targeting component
        /// </summary>
        /// <param name="component">The component instance</param>
        /// <param name="currentPosition">Current grid position of the component</param>
        public void UpdateTargetingComponentState(object component, Vector2I currentPosition)
        {
            if (component == null)
                return;

            _componentStates[component] = currentPosition;
        }
```

Updates the state of a targeting component

**Returns:** `void`

**Parameters:**
- `object component`
- `Vector2I currentPosition`

### IsTargetingValidForComponent

```csharp
/// <summary>
        /// Checks if a target is valid for a specific component
        /// </summary>
        /// <param name="component">The targeting component</param>
        /// <param name="target">The target to validate</param>
        /// <returns>True if target is valid for this component</returns>
        public bool IsTargetingValidForComponent(object component, object target)
        {
            if (!_componentStates.ContainsKey(component))
                return false;

            var componentPosition = _componentStates[component];
            var targetPosition = ExtractPositionFromNode(target);

            return IsValidTargetTile(targetPosition) && 
                   IsWithinRange(componentPosition, targetPosition, _configuration.MaxTilesDistance);
        }
```

Checks if a target is valid for a specific component

**Returns:** `bool`

**Parameters:**
- `object component`
- `object target`

### Dispose

```csharp
#endregion

        #region IDisposable Implementation

        /// <summary>
        /// Disposes of the service resources
        /// </summary>
        public void Dispose()
        {
            if (!_disposed)
            {
                ClearNavigationData();
                _disposed = true;
            }
        }
```

Disposes of the service resources

**Returns:** `void`

