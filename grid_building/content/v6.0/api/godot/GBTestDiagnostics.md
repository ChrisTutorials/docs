---
title: "GBTestDiagnostics"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gbtestdiagnostics/"
---

# GBTestDiagnostics

```csharp
GridBuilding.Godot.Test.Helpers
class GBTestDiagnostics
{
    // Members...
}
```

C# implementation of GBTestDiagnostics for test diagnostics and debugging
Provides comprehensive diagnostic tools for GridBuilding testing
Ported from: godot/addons/grid_building/test/grid_building/helpers/gb_test_diagnostics.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/GBTestDiagnostics.cs`  
**Namespace:** `GridBuilding.Godot.Test.Helpers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### DiagnoseEnvironment

```csharp
#endregion

    #region Diagnostic Methods

    /// <summary>
    /// Performs comprehensive diagnostic analysis of a test environment
    /// </summary>
    /// <param name="environment">Test environment to diagnose</param>
    /// <returns>Diagnostic report with all findings</returns>
    public static DiagnosticReport DiagnoseEnvironment(Node environment)
    {
        var report = new DiagnosticReport
        {
            Environment = environment,
            StartTime = DateTime.Now
        };

        try
        {
            // Environment diagnostics
            report.EnvironmentDiagnostics = DiagnoseEnvironmentStructure(environment);

            // Systems diagnostics
            report.SystemsDiagnostics = DiagnoseSystems(environment);

            // Performance diagnostics
            report.PerformanceDiagnostics = DiagnosePerformance(environment);

            // Memory diagnostics
            report.MemoryDiagnostics = DiagnoseMemory(environment);

            // State diagnostics
            report.StateDiagnostics = DiagnoseState(environment);

            // Validation diagnostics
            report.ValidationDiagnostics = DiagnoseValidation(environment);

            // Integration diagnostics
            report.IntegrationDiagnostics = DiagnoseIntegration(environment);

            // Calculate overall health score
            report.HealthScore = CalculateHealthScore(report);

            report.EndTime = DateTime.Now;
            report.Duration = report.EndTime - report.StartTime;
            report.Success = true;

            return report;
        }
        catch (Exception ex)
        {
            report.Success = false;
            report.ErrorMessage = ex.Message;
            report.EndTime = DateTime.Now;
            report.Duration = report.EndTime - report.StartTime;

            return report;
        }
    }
```

Performs comprehensive diagnostic analysis of a test environment

**Returns:** `DiagnosticReport`

**Parameters:**
- `Node environment`

