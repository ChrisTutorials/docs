---
title: "ManipulationTestHelpers"
description: "C# implementation of ManipulationTestHelpers for manipulation system testing
Provides utilities for testing building manipulation operations
Ported from: godot/addons/grid_building/test/grid_building/helpers/manipulation_test_helpers.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/manipulationtesthelpers/"
---

# ManipulationTestHelpers

```csharp
GridBuilding.Godot.Test.Helpers
class ManipulationTestHelpers
{
    // Members...
}
```

C# implementation of ManipulationTestHelpers for manipulation system testing
Provides utilities for testing building manipulation operations
Ported from: godot/addons/grid_building/test/grid_building/helpers/manipulation_test_helpers.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/ManipulationTestHelpers.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateTestScenario

```csharp
#region Test Creation Methods

    /// <summary>
    /// Creates a test manipulation scenario
    /// </summary>
    /// <param name="scenarioType">Type of manipulation scenario</param>
    /// <param name="environment">Test environment to use</param>
    /// <returns>Configured manipulation test scenario</returns>
    public static ManipulationTestScenario CreateTestScenario(
        ManipulationScenarioType scenarioType, 
        Node environment)
    {
        return scenarioType switch
        {
            ManipulationScenarioType.Move => CreateMoveScenario(environment),
            ManipulationScenarioType.Rotate => CreateRotateScenario(environment),
            ManipulationScenarioType.Flip => CreateFlipScenario(environment),
            ManipulationScenarioType.Demolish => CreateDemolishScenario(environment),
            ManipulationScenarioType.Complex => CreateComplexScenario(environment),
            _ => throw new ArgumentException($"Unknown scenario type: {scenarioType}")
        };
    }
```

Creates a test manipulation scenario

**Returns:** `ManipulationTestScenario`

**Parameters:**
- `ManipulationScenarioType scenarioType`
- `Node environment`

### ExecuteScenarioAsync

```csharp
#endregion

    #region Execution Methods

    /// <summary>
    /// Executes a manipulation test scenario
    /// </summary>
    /// <param name="scenario">Scenario to execute</param>
    /// <param name="environment">Test environment</param>
    /// <returns>Test execution results</returns>
    public static async Task<ManipulationTestResult> ExecuteScenarioAsync(
        ManipulationTestScenario scenario, 
        Node environment)
    {
        var result = new ManipulationTestResult
        {
            Scenario = scenario,
            StartTime = DateTime.Now,
            Success = true
        };

        try
        {
            // Get manipulation manager
            var manipulationManager = GetManipulationManager(environment);
            if (manipulationManager == null)
            {
                throw new InvalidOperationException("ManipulationManager not found in environment");
            }

            // Execute each operation
            foreach (var operation in scenario.Operations)
            {
                var operationResult = await ExecuteOperationAsync(operation, manipulationManager);
                result.OperationResults.Add(operationResult);

                if (operationResult.Result != operation.ExpectedResult)
                {
                    result.Success = false;
                    result.FailureReasons.Add($"Operation {operation.Type} failed: Expected {operation.ExpectedResult}, got {operationResult.Result}");
                }
            }

            result.EndTime = DateTime.Now;
            result.Duration = result.EndTime - result.StartTime;

            return result;
        }
        catch (Exception ex)
        {
            result.Success = false;
            result.FailureReasons.Add($"Exception during execution: {ex.Message}");
            result.EndTime = DateTime.Now;
            result.Duration = result.EndTime - result.StartTime;

            return result;
        }
    }
```

Executes a manipulation test scenario

**Returns:** `Task<ManipulationTestResult>`

**Parameters:**
- `ManipulationTestScenario scenario`
- `Node environment`

### ValidateOperation

```csharp
#endregion

    #region Validation Methods

    /// <summary>
    /// Validates that a manipulation operation completed successfully
    /// </summary>
    /// <param name="operation">Operation to validate</param>
    /// <param name="environment">Test environment</param>
    /// <returns>Validation result</returns>
    public static ManipulationValidationResult ValidateOperation(
        ManipulationOperation operation, 
        Node environment)
    {
        var result = new ManipulationValidationResult
        {
            Operation = operation,
            IsValid = true
        };

        try
        {
            switch (operation.Type)
            {
                case ManipulationOperationType.Move:
                    return ValidateMoveOperation(operation, environment);
                
                case ManipulationOperationType.Rotate:
                    return ValidateRotateOperation(operation, environment);
                
                case ManipulationOperationType.FlipHorizontal:
                case ManipulationOperationType.FlipVertical:
                    return ValidateFlipOperation(operation, environment);
                
                case ManipulationOperationType.Demolish:
                    return ValidateDemolishOperation(operation, environment);
                
                default:
                    result.IsValid = false;
                    result.ErrorMessage = $"Unknown operation type: {operation.Type}";
                    return result;
            }
        }
        catch (Exception ex)
        {
            result.IsValid = false;
            result.ErrorMessage = ex.Message;
            return result;
        }
    }
```

Validates that a manipulation operation completed successfully

**Returns:** `ManipulationValidationResult`

**Parameters:**
- `ManipulationOperation operation`
- `Node environment`

