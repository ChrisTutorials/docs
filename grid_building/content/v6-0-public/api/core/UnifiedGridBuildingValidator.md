---
title: "UnifiedGridBuildingValidator"
description: "Unified GridBuilding validator implementing standardized validator interfaces
Provides consistent validation patterns for GridBuilding components"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/unifiedgridbuildingvalidator/"
---

# UnifiedGridBuildingValidator

```csharp
GridBuilding.Core.Systems.Validation
class UnifiedGridBuildingValidator
{
    // Members...
}
```

Unified GridBuilding validator implementing standardized validator interfaces
Provides consistent validation patterns for GridBuilding components

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/UnifiedGridBuildingValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Name

```csharp
public string Name { get; private set; }
```


## Methods

### ValidateCollisionTestData

```csharp
/// <summary>
        /// Validates collision test data
        /// </summary>
        /// <param name="testData">Test data to validate</param>
        /// <returns>Validation result</returns>
        public ValidationResult ValidateCollisionTestData(ICollisionTestData testData)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (testData == null)
            {
                errors.Add("Collision test data is null");
                return new ValidationResult { IsValid = false, Errors = errors, Warnings = warnings, Score = 0.0f };
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
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult 
            { 
                IsValid = errors.Count == 0, 
                Errors = errors, 
                Warnings = warnings, 
                Score = score 
            };
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
        /// <param name="context">Context for error messages</param>
        /// <returns>Validation result</returns>
        public ValidationResult ValidateCollisionTestingSetup(ICollisionTestingSetup setup, string context = "")
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (setup == null)
            {
                errors.Add($"{context}: Collision testing setup is null");
                return new ValidationResult { IsValid = false, Errors = errors, Warnings = warnings, Score = 0.0f };
            }
            
            // Validate shape owner
            if (setup.ShapeOwner == null)
            {
                errors.Add($"{context}: Shape owner is null");
            }
            else
            {
                // Validate shape owner properties
                if (setup.ShapeOwner.Shapes == null || setup.ShapeOwner.Shapes.Count == 0)
                {
                    warnings.Add($"{context}: Shape owner has no shapes");
                }
                
                if (setup.ShapeOwner.Position == Vector2.Zero)
                {
                    warnings.Add($"{context}: Shape owner position is zero");
                }
            }
            
            // Validate collision shapes
            if (setup.CollisionShapes == null || setup.CollisionShapes.Count == 0)
            {
                errors.Add($"{context}: No collision shapes found");
            }
            else
            {
                for (int i = 0; i < setup.CollisionShapes.Count; i++)
                {
                    var shape = setup.CollisionShapes[i];
                    var shapeValidation = ValidateCollisionShape(shape, $"{context}.Shape[{i}]");
                    
                    errors.AddRange(shapeValidation.Errors);
                    warnings.AddRange(shapeValidation.Warnings);
                }
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult 
            { 
                IsValid = errors.Count == 0, 
                Errors = errors, 
                Warnings = warnings, 
                Score = score 
            };
        }
```

Validates collision testing setup

**Returns:** `ValidationResult`

**Parameters:**
- `ICollisionTestingSetup setup`
- `string context`

### ValidateCollisionShape

```csharp
/// <summary>
        /// Validates collision shape
        /// </summary>
        /// <param name="shape">Shape to validate</param>
        /// <param name="context">Context for error messages</param>
        /// <returns>Validation result</returns>
        public ValidationResult ValidateCollisionShape(ICollisionShape shape, string context = "")
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (shape == null)
            {
                errors.Add($"{context}: Collision shape is null");
                return new ValidationResult { IsValid = false, Errors = errors, Warnings = warnings, Score = 0.0f };
            }
            
            // Validate shape type
            if (string.IsNullOrWhiteSpace(shape.Type))
            {
                errors.Add($"{context}: Shape type is null or empty");
            }
            
            // Validate shape size
            if (shape.Size == Vector2.Zero)
            {
                errors.Add($"{context}: Shape size is zero");
            }
            else if (shape.Size.X < 0 || shape.Size.Y < 0)
            {
                errors.Add($"{context}: Shape size has negative dimensions");
            }
            
            // Validate shape position
            if (double.IsNaN(shape.Position.X) || double.IsNaN(shape.Position.Y) ||
                double.IsInfinity(shape.Position.X) || double.IsInfinity(shape.Position.Y))
            {
                errors.Add($"{context}: Shape position contains invalid values");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult 
            { 
                IsValid = errors.Count == 0, 
                Errors = errors, 
                Warnings = warnings, 
                Score = score 
            };
        }
```

Validates collision shape

**Returns:** `ValidationResult`

**Parameters:**
- `ICollisionShape shape`
- `string context`

### ValidatePlacementData

```csharp
/// <summary>
        /// Validates placement data
        /// </summary>
        /// <param name="placementData">Placement data to validate</param>
        /// <returns>Validation result</returns>
        public ValidationResult ValidatePlacementData(IPlacementData placementData)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (placementData == null)
            {
                errors.Add("Placement data is null");
                return new ValidationResult { IsValid = false, Errors = errors, Warnings = warnings, Score = 0.0f };
            }
            
            // Validate shape
            if (placementData.Shape == null)
            {
                errors.Add("Placement shape is null");
            }
            
            // Validate size
            if (placementData.Size == Vector2.Zero)
            {
                errors.Add("Placement size is zero");
            }
            else if (placementData.Size.X < 0 || placementData.Size.Y < 0)
            {
                errors.Add("Placement size has negative dimensions");
            }
            
            // Validate tags
            if (placementData.Tags == null || placementData.Tags.Count == 0)
            {
                warnings.Add("No placement tags specified");
            }
            else if (placementData.Tags.Any(string.IsNullOrWhiteSpace))
            {
                warnings.Add("Placement tags contain null or empty values");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult 
            { 
                IsValid = errors.Count == 0, 
                Errors = errors, 
                Warnings = warnings, 
                Score = score 
            };
        }
```

Validates placement data

**Returns:** `ValidationResult`

**Parameters:**
- `IPlacementData placementData`

### ValidateCollisionProcessor

```csharp
/// <summary>
        /// Validates collision processor
        /// </summary>
        /// <param name="processor">Collision processor to validate</param>
        /// <returns>Validation result</returns>
        public ValidationResult ValidateCollisionProcessor(IGeometryCollisionProcessor processor)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (processor == null)
            {
                errors.Add("Collision processor is null");
                return new ValidationResult { IsValid = false, Errors = errors, Warnings = warnings, Score = 0.0f };
            }
            
            try
            {
                var supportedTypes = processor.GetSupportedTypes();
                if (supportedTypes == null || supportedTypes.Count == 0)
                {
                    warnings.Add("No supported collision types found");
                }
                else if (supportedTypes.Count < 2)
                {
                    warnings.Add("Limited collision type support");
                }
            }
            catch (Exception ex)
            {
                errors.Add($"Collision processor validation failed: {ex.Message}");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult 
            { 
                IsValid = errors.Count == 0, 
                Errors = errors, 
                Warnings = warnings, 
                Score = score 
            };
        }
```

Validates collision processor

**Returns:** `ValidationResult`

**Parameters:**
- `IGeometryCollisionProcessor processor`

### ValidateBuildingConfiguration

```csharp
/// <summary>
        /// Validates building configuration
        /// </summary>
        /// <param name="config">Building configuration to validate</param>
        /// <returns>Validation result</returns>
        public ValidationResult ValidateBuildingConfiguration(IBuildingConfiguration config)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (config == null)
            {
                errors.Add("Building configuration is null");
                return new ValidationResult { IsValid = false, Errors = errors, Warnings = warnings, Score = 0.0f };
            }
            
            // Validate building ID
            if (string.IsNullOrWhiteSpace(config.BuildingId))
            {
                errors.Add("Building ID is null or empty");
            }
            
            // Validate building size
            if (config.Size == Vector2.Zero)
            {
                errors.Add("Building size is zero");
            }
            else if (config.Size.X < 0 || config.Size.Y < 0)
            {
                errors.Add("Building size has negative dimensions");
            }
            
            // Validate building type
            if (string.IsNullOrWhiteSpace(config.BuildingType))
            {
                warnings.Add("Building type is not specified");
            }
            
            // Validate placement rules
            if (config.PlacementRules == null || config.PlacementRules.Count == 0)
            {
                warnings.Add("No placement rules defined");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult 
            { 
                IsValid = errors.Count == 0, 
                Errors = errors, 
                Warnings = warnings, 
                Score = score 
            };
        }
```

Validates building configuration

**Returns:** `ValidationResult`

**Parameters:**
- `IBuildingConfiguration config`

### ValidateGridConfiguration

```csharp
/// <summary>
        /// Validates grid configuration
        /// </summary>
        /// <param name="config">Grid configuration to validate</param>
        /// <returns>Validation result</returns>
        public ValidationResult ValidateGridConfiguration(IGridConfiguration config)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (config == null)
            {
                errors.Add("Grid configuration is null");
                return new ValidationResult { IsValid = false, Errors = errors, Warnings = warnings, Score = 0.0f };
            }
            
            // Validate grid size
            if (config.GridSize == Vector2I.Zero)
            {
                errors.Add("Grid size is zero");
            }
            else if (config.GridSize.X <= 0 || config.GridSize.Y <= 0)
            {
                errors.Add("Grid size has non-positive dimensions");
            }
            
            // Validate cell size
            if (config.CellSize == Vector2.Zero)
            {
                errors.Add("Cell size is zero");
            }
            else if (config.CellSize.X <= 0 || config.CellSize.Y <= 0)
            {
                errors.Add("Cell size has non-positive dimensions");
            }
            
            // Validate grid origin
            if (double.IsNaN(config.Origin.X) || double.IsNaN(config.Origin.Y) ||
                double.IsInfinity(config.Origin.X) || double.IsInfinity(config.Origin.Y))
            {
                errors.Add("Grid origin contains invalid values");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult 
            { 
                IsValid = errors.Count == 0, 
                Errors = errors, 
                Warnings = warnings, 
                Score = score 
            };
        }
```

Validates grid configuration

**Returns:** `ValidationResult`

**Parameters:**
- `IGridConfiguration config`

### ValidateManipulationState

```csharp
/// <summary>
        /// Validates manipulation state
        /// </summary>
        /// <param name="state">Manipulation state to validate</param>
        /// <returns>Validation result</returns>
        public ValidationResult ValidateManipulationState(IManipulationState state)
        {
            var errors = new List<string>();
            var warnings = new List<string>();
            
            if (state == null)
            {
                errors.Add("Manipulation state is null");
                return new ValidationResult { IsValid = false, Errors = errors, Warnings = warnings, Score = 0.0f };
            }
            
            // Validate manipulation mode
            if (!Enum.IsDefined(typeof(ManipulationMode), state.Mode))
            {
                errors.Add($"Invalid manipulation mode: {state.Mode}");
            }
            
            // Validate target position
            if (double.IsNaN(state.TargetPosition.X) || double.IsNaN(state.TargetPosition.Y) ||
                double.IsInfinity(state.TargetPosition.X) || double.IsInfinity(state.TargetPosition.Y))
            {
                errors.Add("Target position contains invalid values");
            }
            
            // Validate rotation
            if (double.IsNaN(state.Rotation) || double.IsInfinity(state.Rotation))
            {
                errors.Add("Rotation contains invalid values");
            }
            
            // Validate scale
            if (state.Scale.X <= 0 || state.Scale.Y <= 0)
            {
                errors.Add("Scale must be positive");
            }
            else if (double.IsNaN(state.Scale.X) || double.IsNaN(state.Scale.Y) ||
                     double.IsInfinity(state.Scale.X) || double.IsInfinity(state.Scale.Y))
            {
                errors.Add("Scale contains invalid values");
            }
            
            var score = CalculateValidationScore(errors, warnings);
            return new ValidationResult 
            { 
                IsValid = errors.Count == 0, 
                Errors = errors, 
                Warnings = warnings, 
                Score = score 
            };
        }
```

Validates manipulation state

**Returns:** `ValidationResult`

**Parameters:**
- `IManipulationState state`

### Validate

```csharp
#endregion

        #region Interface Implementation

        public ValidationResult Validate(object target)
        {
            return target switch
            {
                ICollisionTestData testData => ValidateCollisionTestData(testData),
                ICollisionTestingSetup setup => ValidateCollisionTestingSetup(setup),
                ICollisionShape shape => ValidateCollisionShape(shape),
                IPlacementData placementData => ValidatePlacementData(placementData),
                IGeometryCollisionProcessor processor => ValidateCollisionProcessor(processor),
                IBuildingConfiguration buildingConfig => ValidateBuildingConfiguration(buildingConfig),
                IGridConfiguration gridConfig => ValidateGridConfiguration(gridConfig),
                IManipulationState manipulationState => ValidateManipulationState(manipulationState),
                _ => ValidationResult.Failure($"Unsupported validation target type: {target?.GetType().Name}")
            };
        }
```

**Returns:** `ValidationResult`

**Parameters:**
- `object target`

