---
title: "GridBuildingValidator"
description: "Comprehensive validation system for GridBuilding components
Provides validation for all major systems and components
Implements unified validator interface for consistency"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/gridbuildingvalidator/"
---

# GridBuildingValidator

```csharp
GridBuilding.Core.Systems.Validation
class GridBuildingValidator
{
    // Members...
}
```

Comprehensive validation system for GridBuilding components
Provides validation for all major systems and components
Implements unified validator interface for consistency

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/GridBuildingValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ValidateCollisionTestData

```csharp
/// <summary>
        /// Validates collision test data
        /// </summary>
        /// <param name="testData">Test data to validate</param>
        /// <returns>Validation result</returns>
        public static ValidationResult ValidateCollisionTestData(ICollisionTestData testData)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (testData == null)
            {
                errors.Add("Collision test data is null");
                return new ValidationResult(false, errors, warnings, 0.0f);
            }
            
            // Validate position reference
            if (testData.PositionReference == Vector2.Zero)
            {
                warnings.Add("Position reference is zero - may cause unexpected results");
            }
            
            // Validate test setups
            if (testData.RectCollisionTestSetups == null || testData.RectCollisionTestSetups.Count == 0)
            {
                errors.Add("No collision test setups found");
            }
            else
            {
                for (int i = 0; i < testData.RectCollisionTestSetups.Count; i++)
                {
                    var setup = testData.RectCollisionTestSetups[i];
                    var setupValidation = ValidateCollisionTestingSetup(setup, $"Setup {i}");
                    
                    errors.AddRange(setupValidation.Errors);
                    warnings.AddRange(setupValidation.Warnings);
                }
            }
            
            // Run data-specific validation
            var dataValidation = testData.Validate();
            errors.AddRange(dataValidation);
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult(errors.Count == 0, errors, warnings, score);
        }
```

Validates collision test data

**Returns:** `ValidationResult`

**Parameters:**
- `ICollisionTestData testData`

### ValidateCollisionTestingSetup

```csharp
/// <summary>
        /// Validates collision testing setup
        /// </summary>
        /// <param name="setup">Setup to validate</param>
        /// <param name="context">Validation context</param>
        /// <returns>Validation result</returns>
        public static ValidationResult ValidateCollisionTestingSetup(IRectCollisionTestingSetup setup, string context = "")
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (setup == null)
            {
                errors.Add($"{context}: Setup is null");
                return new ValidationResult(false, errors, warnings, 0.0f);
            }
            
            // Validate shape owner
            if (setup.ShapeOwner == null)
            {
                errors.Add($"{context}: Shape owner is null");
            }
            
            // Validate testing rectangle
            if (setup.TestingRect == Rect2.Zero)
            {
                errors.Add($"{context}: Testing rectangle is zero");
            }
            else if (setup.TestingRect.Size.X <= 0 || setup.TestingRect.Size.Y <= 0)
            {
                errors.Add($"{context}: Testing rectangle has invalid size");
            }
            
            // Validate collision shape
            if (setup.CollisionShape == null)
            {
                warnings.Add($"{context}: Collision shape is null - may cause issues");
            }
            
            // Run setup-specific validation
            try
            {
                var setupValidation = setup.Validate();
                errors.AddRange(setupValidation);
            }
            catch (Exception ex)
            {
                errors.Add($"{context}: Setup validation failed: {ex.Message}");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult(errors.Count == 0, errors, warnings, score);
        }
```

Validates collision testing setup

**Returns:** `ValidationResult`

**Parameters:**
- `IRectCollisionTestingSetup setup`
- `string context`

### ValidateGridPositioner

```csharp
/// <summary>
        /// Validates grid positioner
        /// </summary>
        /// <param name="positioner">Positioner to validate</param>
        /// <returns>Validation result</returns>
        public static ValidationResult ValidateGridPositioner(IGridPositioner positioner)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (positioner == null)
            {
                errors.Add("Grid positioner is null");
                return new ValidationResult(false, errors, warnings, 0.0f);
            }
            
            try
            {
                // Test basic conversions
                var testWorldPos = new Vector2(100, 100);
                var gridPos = positioner.WorldToGrid(testWorldPos);
                var backToWorld = positioner.GridToWorld(gridPos);
                
                // Check if conversion is consistent
                var distance = testWorldPos.DistanceTo(backToWorld);
                if (distance > 1.0f) // Allow some tolerance
                {
                    warnings.Add($"World-to-grid conversion has high error: {distance}");
                }
                
                // Test neighbor calculation
                var neighbors = positioner.GetNeighboringPositions(gridPos, false);
                if (neighbors.Count != 4)
                {
                    warnings.Add($"Expected 4 cardinal neighbors, got {neighbors.Count}");
                }
                
                var diagonalNeighbors = positioner.GetNeighboringPositions(gridPos, true);
                if (diagonalNeighbors.Count != 8)
                {
                    warnings.Add($"Expected 8 total neighbors, got {diagonalNeighbors.Count}");
                }
                
                // Test bounds checking
                var validPos = positioner.IsPositionInBounds(gridPos);
                var invalidPos = positioner.IsPositionInBounds(new Vector2I(-9999, -9999));
                
                if (validPos && invalidPos)
                {
                    warnings.Add("Bounds checking may not be working correctly");
                }
            }
            catch (Exception ex)
            {
                errors.Add($"Grid positioner validation failed: {ex.Message}");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult(errors.Count == 0, errors, warnings, score);
        }
```

Validates grid positioner

**Returns:** `ValidationResult`

**Parameters:**
- `IGridPositioner positioner`

### ValidateTargetingSystem

```csharp
/// <summary>
        /// Validates targeting system
        /// </summary>
        /// <param name="targetingSystem">Targeting system to validate</param>
        /// <returns>Validation result</returns>
        public static ValidationResult ValidateTargetingSystem(ITargetingSystem targetingSystem)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (targetingSystem == null)
            {
                errors.Add("Targeting system is null");
                return new ValidationResult(false, errors, warnings, 0.0f);
            }
            
            try
            {
                // Test target retrieval
                var currentTargets = targetingSystem.GetCurrentTargets();
                if (currentTargets == null)
                {
                    errors.Add("GetCurrentTargets returned null");
                }
                
                var closestTarget = targetingSystem.GetClosestTarget();
                var targetsInRange = targetingSystem.GetTargetsInRange(100.0f);
                
                if (targetsInRange == null)
                {
                    errors.Add("GetTargetsInRange returned null");
                }
                
                // Test target clearing
                targetingSystem.ClearTargets();
                var targetsAfterClear = targetingSystem.GetCurrentTargets();
                
                if (targetsAfterClear != null && targetsAfterClear.Count > 0)
                {
                    warnings.Add("ClearTargets may not be working correctly");
                }
            }
            catch (Exception ex)
            {
                errors.Add($"Targeting system validation failed: {ex.Message}");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult(errors.Count == 0, errors, warnings, score);
        }
```

Validates targeting system

**Returns:** `ValidationResult`

**Parameters:**
- `ITargetingSystem targetingSystem`

### ValidatePlacementSystem

```csharp
/// <summary>
        /// Validates placement system
        /// </summary>
        /// <param name="placementSystem">Placement system to validate</param>
        /// <param name="testData">Test placement data</param>
        /// <returns>Validation result</returns>
        public static ValidationResult ValidatePlacementSystem(IPlacementSystem placementSystem, IPlacementData testData = null)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (placementSystem == null)
            {
                errors.Add("Placement system is null");
                return new ValidationResult(false, errors, warnings, 0.0f);
            }
            
            try
            {
                // Create test data if not provided
                testData ??= CreateTestPlacementData();
                
                // Test placement validation
                var testPosition = new Vector2(100, 100);
                var validationResult = placementSystem.ValidatePlacement(testPosition, testData);
                
                if (validationResult == null)
                {
                    errors.Add("ValidatePlacement returned null");
                }
                else
                {
                    if (validationResult.Errors == null)
                    {
                        warnings.Add("Validation result errors list is null");
                    }
                    
                    if (validationResult.Warnings == null)
                    {
                        warnings.Add("Validation result warnings list is null");
                    }
                }
                
                // Test optimal placement
                var optimalPos = placementSystem.GetOptimalPlacement(testPosition, testData);
                if (optimalPos == Vector2.Zero)
                {
                    warnings.Add("GetOptimalPlacement returned zero position");
                }
                
                // Test placement execution (should not actually place anything in validation)
                // This would be tested in integration tests
            }
            catch (Exception ex)
            {
                errors.Add($"Placement system validation failed: {ex.Message}");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult(errors.Count == 0, errors, warnings, score);
        }
```

Validates placement system

**Returns:** `ValidationResult`

**Parameters:**
- `IPlacementSystem placementSystem`
- `IPlacementData testData`

### ValidateStateMachine

```csharp
/// <summary>
        /// Validates state machine
        /// </summary>
        /// <param name="stateMachine">State machine to validate</param>
        /// <returns>Validation result</returns>
        public static ValidationResult ValidateStateMachine<TState>(IStateMachine<TState> stateMachine) where TState : class
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (stateMachine == null)
            {
                errors.Add("State machine is null");
                return new ValidationResult(false, errors, warnings, 0.0f);
            }
            
            try
            {
                // Test state retrieval
                var currentState = stateMachine.CurrentState;
                var previousState = stateMachine.PreviousState;
                var stateHistory = stateMachine.StateHistory;
                
                if (currentState == null)
                {
                    errors.Add("Current state is null");
                }
                
                if (stateHistory == null)
                {
                    errors.Add("State history is null");
                }
                else if (stateHistory.Count == 0 && currentState != null)
                {
                    warnings.Add("State history is empty but current state is not null");
                }
                
                // Test state change capability
                var canChange = stateMachine.CanChangeTo(currentState);
                // This should return false (can't change to same state) or true depending on implementation
            }
            catch (Exception ex)
            {
                errors.Add($"State machine validation failed: {ex.Message}");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult(errors.Count == 0, errors, warnings, score);
        }
```

Validates state machine

**Returns:** `ValidationResult`

**Parameters:**
- `IStateMachine<TState> stateMachine`

### ValidateInputManager

```csharp
/// <summary>
        /// Validates input manager
        /// </summary>
        /// <param name="inputManager">Input manager to validate</param>
        /// <returns>Validation result</returns>
        public static ValidationResult ValidateInputManager(IInputManager inputManager)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (inputManager == null)
            {
                errors.Add("Input manager is null");
                return new ValidationResult(false, errors, warnings, 0.0f);
            }
            
            try
            {
                // Test input checking (should not throw exceptions)
                var isPressed = inputManager.IsActionPressed("test_action");
                var isJustPressed = inputManager.IsActionJustPressed("test_action");
                var axisValue = inputManager.GetAxis("test_axis");
                
                // Test input mode setting
                inputManager.SetInputMode(InputMode.Normal);
                inputManager.SetInputEnabled(true);
                
                // These should not throw exceptions even if actions don't exist
            }
            catch (Exception ex)
            {
                errors.Add($"Input manager validation failed: {ex.Message}");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult(errors.Count == 0, errors, warnings, score);
        }
```

Validates input manager

**Returns:** `ValidationResult`

**Parameters:**
- `IInputManager inputManager`

### ValidateLogger

```csharp
/// <summary>
        /// Validates logger
        /// </summary>
        /// <param name="logger">Logger to validate</param>
        /// <returns>Validation result</returns>
        public static ValidationResult ValidateLogger(Microsoft.Extensions.Logging.ILogger? logger)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (logger == null)
            {
                errors.Add("Logger is null");
                return new ValidationResult(false, errors, warnings, 0.0f);
            }
            
            try
            {
                // Test logging methods (should not throw exceptions)
                logger.LogDebug("Debug test message");
                logger.LogInformation("Info test message");
                logger.LogWarning("Warning test message");
                logger.LogError("Error test message");
                
                // Log level setting is not available on standard ILogger
            }
            catch (Exception ex)
            {
                errors.Add($"Logger validation failed: {ex.Message}");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult(errors.Count == 0, errors, warnings, score);
        }
```

Validates logger

**Returns:** `ValidationResult`

**Parameters:**
- `Microsoft.Extensions.Logging.ILogger? logger`

### ValidateEntireSystem

```csharp
/// <summary>
        /// Validates entire GridBuilding system
        /// </summary>
        /// <param name="components">Dictionary of system components</param>
        /// <returns>Comprehensive validation result</returns>
        public static SystemValidationResult ValidateEntireSystem(Dictionary<string, object> components)
        {
            var results = new Dictionary<string, ValidationResult>();
            var totalErrors = 0;
            var totalWarnings = 0;
            
            // Validate each component
            foreach (var kvp in components)
            {
                var componentName = kvp.Key;
                var component = kvp.Value;
                var result = ValidateComponent(componentName, component);
                
                results[componentName] = result;
                totalErrors += result.Errors.Count;
                totalWarnings += result.Warnings.Count;
            }
            
            // Calculate overall score
            var overallScore = results.Values.Count > 0 
                ? results.Values.Average(r => r.Score) 
                : 0.0f;
            
            var overallSuccess = totalErrors == 0;
            
            // Convert validation results to error messages
            var errorMessages = new List<string>();
            var warningMessages = new List<string>();
            
            foreach (var kvp in results)
            {
                if (!kvp.Value.IsValid)
                {
                    errorMessages.Add($"{kvp.Key}: {string.Join("; ", kvp.Value.Errors)}");
                }
                warningMessages.AddRange(kvp.Value.Warnings.Select(w => $"{kvp.Key}: {w}"));
            }
            
            return new SystemValidationResult(overallSuccess, errorMessages, warningMessages, overallScore, "GridBuilding System");
        }
```

Validates entire GridBuilding system

**Returns:** `SystemValidationResult`

**Parameters:**
- `Dictionary<string, object> components`

