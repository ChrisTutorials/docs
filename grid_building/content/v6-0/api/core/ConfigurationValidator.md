---
title: "ConfigurationValidator"
description: "Comprehensive configuration validator for GridBuilding systems
Validates all aspects of GridBuilding configuration for correctness and completeness"
weight: 10
url: "/gridbuilding/v6-0/api/core/configurationvalidator/"
---

# ConfigurationValidator

```csharp
GridBuilding.Core.Config
class ConfigurationValidator
{
    // Members...
}
```

Comprehensive configuration validator for GridBuilding systems
Validates all aspects of GridBuilding configuration for correctness and completeness

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ConfigurationValidator.cs`  
**Namespace:** `GridBuilding.Core.Config`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ValidateCompleteConfiguration

```csharp
#region Validation Methods
    
    /// <summary>
    /// Validates complete GridBuilding configuration
    /// </summary>
    /// <param name="contexts">GridBuilding contexts to validate</param>
    /// <param name="config">Optional validation configuration</param>
    /// <returns>Comprehensive validation result</returns>
    public static ConfigurationValidationResult ValidateCompleteConfiguration(
        GridBuilding.Core.Domain.State.Contexts? contexts, 
        ValidationConfig? config = null)
    {
        var validationConfig = config ?? new ValidationConfig();
        var result = new ConfigurationValidationResult();
        
        try
        {
            // Validate contexts
            var contextValidation = ValidateContexts(contexts, validationConfig);
            result.ContextValidation = contextValidation;
            result.Issues.AddRange(contextValidation.Issues);
            result.Warnings.AddRange(contextValidation.Warnings);
            
            // Validate system configurations
            var systemValidation = ValidateSystemConfigurations(validationConfig);
            result.SystemValidation = systemValidation;
            result.Issues.AddRange(systemValidation.Issues);
            result.Warnings.AddRange(systemValidation.Warnings);
            
            // Validate resource configurations
            var resourceValidation = ValidateResourceConfigurations(validationConfig);
            result.ResourceValidation = resourceValidation;
            result.Issues.AddRange(resourceValidation.Issues);
            result.Warnings.AddRange(resourceValidation.Warnings);
            
            // Validate integration consistency
            var integrationValidation = ValidateIntegrationConsistency(contexts, validationConfig);
            result.IntegrationValidation = integrationValidation;
            result.Issues.AddRange(integrationValidation.Issues);
            result.Warnings.AddRange(integrationValidation.Warnings);
            
            // Calculate overall validity
            result.IsValid = result.Issues.Count == 0;
            result.ValidationScore = CalculateValidationScore(result);
            
        }
        catch (System.Exception ex)
        {
            result.Issues.Add($"Validation failed with exception: {ex.Message}");
            result.IsValid = false;
            result.ValidationScore = 0;
        }
        
        return result;
    }
```

Validates complete GridBuilding configuration

**Returns:** `ConfigurationValidationResult`

**Parameters:**
- `GridBuilding.Core.Domain.State.Contexts? contexts`
- `ValidationConfig? config`

### ValidateContexts

```csharp
/// <summary>
    /// Validates Contexts configuration
    /// </summary>
    public static ContextValidationResult ValidateContexts(GridBuilding.Core.Domain.State.Contexts? contexts, ValidationConfig config)
    {
        var result = new ContextValidationResult();
        
        if (contexts == null)
        {
            result.Issues.Add("Contexts is null");
            return result;
        }
        
        // Validate individual contexts
        // Note: Contexts class has Indicator, Owner, and Systems properties
        // The placement/targeting/collision/building contexts would need to be added to Contexts class
        // For now, we'll validate what's available
        result.SystemValidation = ValidateSystemConfigurations(validationConfig);
        
        // Collect all issues and warnings
        // Note: Since individual contexts aren't available yet, we'll skip their collection
        result.Issues.AddRange(result.SystemValidation.Issues);
        result.Warnings.AddRange(result.SystemValidation.Warnings);
        
        result.IsValid = result.Issues.Count == 0;
        
        return result;
    }
```

Validates Contexts configuration

**Returns:** `ContextValidationResult`

**Parameters:**
- `GridBuilding.Core.Domain.State.Contexts? contexts`
- `ValidationConfig config`

### GenerateValidationReport

```csharp
/// <summary>
    /// Generates a validation report
    /// </summary>
    public static string GenerateValidationReport(ConfigurationValidationResult result)
    {
        var report = "=== GridBuilding Configuration Validation Report ===\n\n";
        
        report += $"Overall Status: {(result.IsValid ? "VALID" : "INVALID")}\n";
        report += $"Validation Score: {result.ValidationScore}/100\n";
        report += $"Issues: {result.Issues.Count}\n";
        report += $"Warnings: {result.Warnings.Count}\n\n";
        
        if (result.Issues.Count > 0)
        {
            report += "=== Issues ===\n";
            foreach (var issue in result.Issues)
            {
                report += $"❌ {issue}\n";
            }
            report += "\n";
        }
        
        if (result.Warnings.Count > 0)
        {
            report += "=== Warnings ===\n";
            foreach (var warning in result.Warnings)
            {
                report += $"⚠️ {warning}\n";
            }
            report += "\n";
        }
        
        // Component-specific results
        if (result.ContextValidation != null)
        {
            report += "=== Context Validation ===\n";
            report += $"Placement Context: {(result.ContextValidation.PlacementContextValidation?.IsValid ?? false ? "Valid" : "Invalid")}\n";
            report += $"Targeting Context: {(result.ContextValidation.TargetingContextValidation?.IsValid ?? false ? "Valid" : "Invalid")}\n";
            report += $"Collision Context: {(result.ContextValidation.CollisionContextValidation?.IsValid ?? false ? "Valid" : "Invalid")}\n";
            report += $"Building Context: {(result.ContextValidation.BuildingContextValidation?.IsValid ?? false ? "Valid" : "Invalid")}\n\n";
        }
        
        if (result.SystemValidation != null)
        {
            report += "=== System Validation ===\n";
            report += $"Placement System: {(result.SystemValidation.PlacementSystemValidation?.IsValid ?? false ? "Valid" : "Invalid")}\n";
            report += $"Targeting System: {(result.SystemValidation.TargetingSystemValidation?.IsValid ?? false ? "Valid" : "Invalid")}\n";
            report += $"Collision System: {(result.SystemValidation.CollisionSystemValidation?.IsValid ?? false ? "Valid" : "Invalid")}\n\n";
        }
        
        return report;
    }
```

Generates a validation report

**Returns:** `string`

**Parameters:**
- `ConfigurationValidationResult result`

