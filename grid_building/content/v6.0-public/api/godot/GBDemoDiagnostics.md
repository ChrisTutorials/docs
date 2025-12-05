---
title: "GBDemoDiagnostics"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/gbdemodiagnostics/"
---

# GBDemoDiagnostics

```csharp
GridBuilding.Godot.Diagnostics
class GBDemoDiagnostics
{
    // Members...
}
```

Demo diagnostics for GridBuilding testing framework.
Provides diagnostic utilities for demo and test environments.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Logging/DemoDiagnostics.cs`  
**Namespace:** `GridBuilding.Godot.Diagnostics`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetDiagnostics

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Get diagnostic information about the demo system.
    /// </summary>
    /// <returns>Dictionary containing diagnostic data</returns>
    public Dictionary<string, object> GetDiagnostics()
    {
        return new Dictionary<string, object>(_diagnosticData);
    }
```

Get diagnostic information about the demo system.

**Returns:** `Dictionary<string, object>`

### LogMessage

```csharp
/// <summary>
    /// Log a diagnostic message with the demo diagnostics prefix.
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogMessage(string message)
    {
        GD.Print($"[GBDemoDiagnostics] {message}");
    }
```

Log a diagnostic message with the demo diagnostics prefix.

**Returns:** `void`

**Parameters:**
- `string message`

### CheckSystemHealth

```csharp
/// <summary>
    /// Check the overall system health.
    /// </summary>
    /// <returns>True if system is healthy</returns>
    public bool CheckSystemHealth()
    {
        try
        {
            // Check basic system requirements
            var engine = Engine.GetSingleton();
            if (engine == null)
                return false;

            // Check if we're in a valid scene tree context
            if (Engine.IsEditorHint())
                return true; // Always healthy in editor

            // Runtime health checks would go here
            return true;
        }
        catch (Exception)
        {
            return false;
        }
    }
```

Check the overall system health.

**Returns:** `bool`

### GetPerformanceMetrics

```csharp
/// <summary>
    /// Get current performance metrics.
    /// </summary>
    /// <returns>Dictionary containing performance data</returns>
    public Dictionary<string, object> GetPerformanceMetrics()
    {
        var metrics = new Dictionary<string, object>(_performanceMetrics);

        // Update with current values if available
        if (Engine.IsEditorHint())
        {
            metrics["fps"] = Engine.GetFramesPerSecond();
        }

        return metrics;
    }
```

Get current performance metrics.

**Returns:** `Dictionary<string, object>`

### GetSystemInfo

```csharp
/// <summary>
    /// Get detailed system information for debugging.
    /// </summary>
    /// <returns>Dictionary containing system information</returns>
    public Dictionary<string, object> GetSystemInfo()
    {
        var info = new Dictionary<string, object>
        {
            ["godot_version"] = Engine.GetVersionInfo(),
            ["platform"] = OS.GetName(),
            ["processor_count"] = OS.GetProcessorCount(),
            ["is_editor_hint"] = Engine.IsEditorHint(),
            ["is_debug_build"] = OS.IsDebugBuild()
        };

        return info;
    }
```

Get detailed system information for debugging.

**Returns:** `Dictionary<string, object>`

### RunFullDiagnostic

```csharp
/// <summary>
    /// Run a comprehensive diagnostic check.
    /// </summary>
    /// <returns>Dictionary containing all diagnostic results</returns>
    public Dictionary<string, object> RunFullDiagnostic()
    {
        var result = new Dictionary<string, object>
        {
            ["timestamp"] = Time.GetDatetimeStringFromSystem(),
            ["diagnostics"] = GetDiagnostics(),
            ["system_health"] = CheckSystemHealth(),
            ["performance"] = GetPerformanceMetrics(),
            ["system_info"] = GetSystemInfo()
        };

        return result;
    }
```

Run a comprehensive diagnostic check.

**Returns:** `Dictionary<string, object>`

### LogDiagnosticSummary

```csharp
/// <summary>
    /// Log diagnostic information in a formatted way.
    /// </summary>
    public void LogDiagnosticSummary()
    {
        var diagnostic = RunFullDiagnostic();
        
        LogMessage("=== Diagnostic Summary ===");
        LogMessage($"Timestamp: {diagnostic["timestamp"]}");
        LogMessage($"System Health: {((bool)diagnostic["system_health"] ? "OK" : "FAILED")}");
        
        if (diagnostic["performance"] is Dictionary<string, object> perf)
        {
            LogMessage($"FPS: {perf["fps"]}");
            LogMessage($"Memory Usage: {perf["memory_usage"]}");
            LogMessage($"Draw Calls: {perf["draw_calls"]}");
        }
        
        if (diagnostic["system_info"] is Dictionary<string, object> sysInfo)
        {
            LogMessage($"Platform: {sysInfo["platform"]}");
            LogMessage($"Processor Count: {sysInfo["processor_count"]}");
        }
        
        LogMessage("=== End Summary ===");
    }
```

Log diagnostic information in a formatted way.

**Returns:** `void`

### UpdatePerformanceMetrics

```csharp
#endregion

    #region Performance Monitoring

    /// <summary>
    /// Update performance metrics with current values.
    /// </summary>
    public void UpdatePerformanceMetrics()
    {
        _performanceMetrics["fps"] = Engine.GetFramesPerSecond();
        
        // Memory usage estimation
        var memoryUsage = GC.GetTotalMemory(false);
        if (memoryUsage < 100 * 1024 * 1024) // Less than 100MB
        {
            _performanceMetrics["memory_usage"] = "low";
        }
        else if (memoryUsage < 500 * 1024 * 1024) // Less than 500MB
        {
            _performanceMetrics["memory_usage"] = "normal";
        }
        else
        {
            _performanceMetrics["memory_usage"] = "high";
        }
    }
```

Update performance metrics with current values.

**Returns:** `void`

### IsPerformanceAcceptable

```csharp
/// <summary>
    /// Check if performance is within acceptable limits.
    /// </summary>
    /// <returns>True if performance is acceptable</returns>
    public bool IsPerformanceAcceptable()
    {
        UpdatePerformanceMetrics();
        
        var fps = Convert.ToInt32(_performanceMetrics["fps"]);
        var memoryUsage = _performanceMetrics["memory_usage"].ToString();
        
        return fps >= 30 && memoryUsage != "high";
    }
```

Check if performance is within acceptable limits.

**Returns:** `bool`

### Create

```csharp
#endregion

    #region Static Methods

    /// <summary>
    /// Create a demo diagnostics instance with default configuration.
    /// </summary>
    /// <returns>New GBDemoDiagnostics instance</returns>
    public static GBDemoDiagnostics Create()
    {
        return new GBDemoDiagnostics();
    }
```

Create a demo diagnostics instance with default configuration.

**Returns:** `GBDemoDiagnostics`

### QuickHealthCheck

```csharp
/// <summary>
    /// Quick diagnostic check that returns a simple status.
    /// </summary>
    /// <returns>"OK", "WARNING", or "ERROR"</returns>
    public static string QuickHealthCheck()
    {
        try
        {
            var diagnostics = new GBDemoDiagnostics();
            var isHealthy = diagnostics.CheckSystemHealth();
            var isPerformanceOk = diagnostics.IsPerformanceAcceptable();
            
            if (isHealthy && isPerformanceOk)
                return "OK";
            else if (isHealthy)
                return "WARNING";
            else
                return "ERROR";
        }
        catch (Exception)
        {
            return "ERROR";
        }
    }
```

Quick diagnostic check that returns a simple status.

**Returns:** `string`

