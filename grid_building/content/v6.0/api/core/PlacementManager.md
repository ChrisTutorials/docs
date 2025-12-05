---
title: "PlacementManager"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/placementmanager/"
---

# PlacementManager

```csharp
GridBuilding.Core.Services.Manipulation
class PlacementManager
{
    // Members...
}
```

Core placement management for manipulation operations (engine-agnostic).
Handles placement validation, completion, and rules management without engine dependencies.
Responsibilities:
- Validate placement positions and rules
- Handle placement completion logic
- Manage placement constraints
- Provide placement feedback

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/Manipulation/PlacementManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ValidatePlacement

```csharp
#endregion

        #region Public Methods

        /// <summary>
        /// Validates a placement position for the given manipulation.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <param name="position">Position to validate</param>
        /// <returns>Placement validation result</returns>
        public PlacementValidationResult ValidatePlacement(ManipulationState manipulationState, Vector2I position)
        {
            if (manipulationState == null)
                return PlacementValidationResult.Failed("Manipulation state is null");

            var result = new PlacementValidationResult
            {
                IsValid = true,
                Position = position,
                ValidationErrors = new List<string>()
            };

            // Apply all placement rules
            foreach (var rule in _placementRules)
            {
                var ruleResult = rule.Validate(manipulationState, position, _settings);
                if (!ruleResult.IsValid)
                {
                    result.IsValid = false;
                    result.ValidationErrors.AddRange(ruleResult.ValidationErrors);
                }
            }

            // Grid boundary validation
            if (_settings.EnableGridConstraints)
            {
                if (!ValidateGridBoundaries(position, out var boundaryError))
                {
                    result.IsValid = false;
                    result.ValidationErrors.Add(boundaryError);
                }
            }

            // Collision validation
            if (_settings.EnableCollisionValidation)
            {
                if (!ValidateCollisions(manipulationState, position, out var collisionError))
                {
                    result.IsValid = false;
                    result.ValidationErrors.Add(collisionError);
                }
            }

            return result;
        }
```

Validates a placement position for the given manipulation.

**Returns:** `PlacementValidationResult`

**Parameters:**
- `ManipulationState manipulationState`
- `Vector2I position`

### CompletePlacement

```csharp
/// <summary>
        /// Completes a placement operation.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <returns>Placement completion result</returns>
        public PlacementResult CompletePlacement(ManipulationState manipulationState)
        {
            if (manipulationState == null)
                return PlacementResult.Failed("Manipulation state is null");

            // Final validation
            var validationResult = ValidatePlacement(manipulationState, manipulationState.GridTarget);
            if (!validationResult.IsValid)
            {
                return PlacementResult.Failed($"Placement validation failed: {string.Join(", ", validationResult.ValidationErrors)}");
            }

            // Create placement result
            var result = new PlacementResult
            {
                IsSuccess = true,
                Position = manipulationState.GridTarget,
                ManipulationId = manipulationState.ManipulationId,
                Mode = manipulationState.CurrentMode,
                AffectedTiles = manipulationState.AffectedTiles.ToList(),
                Timestamp = DateTime.UtcNow
            };

            // Apply placement effects
            ApplyPlacementEffects(manipulationState, result);

            return result;
        }
```

Completes a placement operation.

**Returns:** `PlacementResult`

**Parameters:**
- `ManipulationState manipulationState`

### AddPlacementRule

```csharp
/// <summary>
        /// Adds a custom placement rule.
        /// </summary>
        /// <param name="rule">Placement rule to add</param>
        public void AddPlacementRule(PlacementRule rule)
        {
            if (rule != null && !_placementRules.Contains(rule))
            {
                _placementRules.Add(rule);
            }
        }
```

Adds a custom placement rule.

**Returns:** `void`

**Parameters:**
- `PlacementRule rule`

### RemovePlacementRule

```csharp
/// <summary>
        /// Removes a placement rule.
        /// </summary>
        /// <param name="rule">Placement rule to remove</param>
        public bool RemovePlacementRule(PlacementRule rule)
        {
            return _placementRules.Remove(rule);
        }
```

Removes a placement rule.

**Returns:** `bool`

**Parameters:**
- `PlacementRule rule`

### GetPlacementRules

```csharp
/// <summary>
        /// Gets all placement rules.
        /// </summary>
        /// <returns>List of placement rules</returns>
        public List<PlacementRule> GetPlacementRules()
        {
            return new List<PlacementRule>(_placementRules);
        }
```

Gets all placement rules.

**Returns:** `List<PlacementRule>`

### GetValidPlacementPositions

```csharp
/// <summary>
        /// Gets valid placement positions around a target position.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <param name="centerPosition">Center position to search around</param>
        /// <param name="radius">Search radius</param>
        /// <returns>List of valid placement positions</returns>
        public List<Vector2I> GetValidPlacementPositions(ManipulationState manipulationState, Vector2I centerPosition, int radius = 5)
        {
            var validPositions = new List<Vector2I>();

            for (int x = -radius; x <= radius; x++)
            {
                for (int y = -radius; y <= radius; y++)
                {
                    var testPosition = centerPosition + new Vector2I(x, y);
                    var validation = ValidatePlacement(manipulationState, testPosition);
                    
                    if (validation.IsValid)
                    {
                        validPositions.Add(testPosition);
                    }
                }
            }

            return validPositions;
        }
```

Gets valid placement positions around a target position.

**Returns:** `List<Vector2I>`

**Parameters:**
- `ManipulationState manipulationState`
- `Vector2I centerPosition`
- `int radius`

### GetPlacementHints

```csharp
/// <summary>
        /// Gets placement hints and suggestions.
        /// </summary>
        /// <param name="manipulationState">The manipulation state</param>
        /// <param name="position">Position to get hints for</param>
        /// <returns>List of placement hints</returns>
        public List<PlacementHint> GetPlacementHints(ManipulationState manipulationState, Vector2I position)
        {
            var hints = new List<PlacementHint>();
            var validation = ValidatePlacement(manipulationState, position);

            if (!validation.IsValid)
            {
                foreach (var error in validation.ValidationErrors)
                {
                    hints.Add(new PlacementHint
                    {
                        Type = PlacementHintType.Error,
                        Message = GetErrorMessage(error, position, suggestion: GetRelevantSuggestion(error, position))
                    });
                }
            }
            else
            {
                hints.Add(new PlacementHint
                {
                    Type = PlacementHintType.Success,
                    Message = "Valid placement position",
                    Position = position
                });
            }

            return hints;
        }
```

Gets placement hints and suggestions.

**Returns:** `List<PlacementHint>`

**Parameters:**
- `ManipulationState manipulationState`
- `Vector2I position`

