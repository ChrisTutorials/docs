---
title: "Diagnostics"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/diagnostics/"
---

# Diagnostics

```csharp
GridBuilding.Godot.Core.Diagnostics
class Diagnostics
{
    // Members...
}
```

Runtime/shared diagnostics helpers for GridBuilding systems.
Provides small, safe, static helpers for generating diagnostic strings that can be
reused by runtime code and tests.
Notes:
- Keep these functions side-effect free (no printing) so callers may log or assert as they prefer.
- Environment variable checks for verbose mode support.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Logging/Diagnostics.cs`  
**Namespace:** `GridBuilding.Godot.Core.Diagnostics`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### IsVerbose

```csharp
#region Environment Settings

    /// <summary>
    /// Check if verbose diagnostics mode is enabled via environment variable.
    /// </summary>
    /// <returns>True if GB_VERBOSE_TESTS is set to "1", "true", or "TRUE"</returns>
    public static bool IsVerbose()
    {
        var envVar = OS.GetEnvironment("GB_VERBOSE_TESTS");
        return envVar == "1" || envVar == "true" || envVar == "TRUE";
    }
```

Check if verbose diagnostics mode is enabled via environment variable.

**Returns:** `bool`

### FormatDebug

```csharp
#endregion

    #region String Formatting

    /// <summary>
    /// Format a debug message string, optionally including suite and file path if verbose mode is enabled.
    /// </summary>
    /// <param name="message">The core message to format</param>
    /// <param name="suite">Optional suite name to prefix in brackets</param>
    /// <param name="filePath">Optional file path to append in parentheses</param>
    /// <returns>Formatted string, enhanced if verbose mode is on</returns>
    public static string FormatDebug(string message, string suite = "", string filePath = "")
    {
        if (IsVerbose())
        {
            var parts = new StringBuilder();
            
            if (!string.IsNullOrEmpty(suite))
            {
                parts.Append($"[{suite}] ");
            }
            
            parts.Append(message);
            
            if (!string.IsNullOrEmpty(filePath))
            {
                parts.Append($" ({filePath})");
            }
            
            return parts.ToString();
        }
        
        return message;
    }
```

Format a debug message string, optionally including suite and file path if verbose mode is enabled.

**Returns:** `string`

**Parameters:**
- `string message`
- `string suite`
- `string filePath`

### FormatIndicator

```csharp
/// <summary>
    /// Format an indicator object into a human-readable string for diagnostics.
    /// </summary>
    /// <param name="indicator">The indicator object to format (can be RuleCheckIndicator, Node, or generic Object)</param>
    /// <returns>Formatted string like "name@position (extra_info)" or "&lt;null&gt;" if null</returns>
    public static string FormatIndicator(Godot.Object? indicator)
    {
        if (indicator == null)
            return "<null>";

        var displayName = string.Empty;
        
        // Prefer explicit type checks where possible for clarity and safety
        switch (indicator)
        {
            case RuleCheckIndicator ruleCheckIndicator:
                displayName = ruleCheckIndicator.Name;
                break;
            case Node node:
                displayName = node.Name;
                break;
            default:
                displayName = indicator.ToString() ?? string.Empty;
                break;
        }

        var result = new StringBuilder(displayName);

        // Add position information if available
        if (indicator is Node nodeWithPosition && nodeWithPosition.IsInsideTree())
        {
            var position = nodeWithPosition.GlobalPosition;
            result.Append($"@{position}");
        }

        // Add extra information for specific types
        switch (indicator)
        {
            case RuleCheckIndicator ruleIndicator:
                if (!string.IsNullOrEmpty(ruleIndicator.ExtraInfo))
                {
                    result.Append($" ({ruleIndicator.ExtraInfo})");
                }
                break;
        }

        return result.ToString();
    }
```

Format an indicator object into a human-readable string for diagnostics.

**Returns:** `string`

**Parameters:**
- `Godot.Object? indicator`

### FormatTilePosition

```csharp
/// <summary>
    /// Format a tile position into a human-readable string.
    /// </summary>
    /// <param name="tilePosition">The tile position to format</param>
    /// <returns>Formatted string like "(x, y)"</returns>
    public static string FormatTilePosition(Vector2I tilePosition)
    {
        return $"({tilePosition.X}, {tilePosition.Y})";
    }
```

Format a tile position into a human-readable string.

**Returns:** `string`

**Parameters:**
- `Vector2I tilePosition`

### FormatWorldPosition

```csharp
/// <summary>
    /// Format a world position into a human-readable string.
    /// </summary>
    /// <param name="worldPosition">The world position to format</param>
    /// <returns>Formatted string with 2 decimal places</returns>
    public static string FormatWorldPosition(Vector2 worldPosition)
    {
        return $"({worldPosition.X:F2}, {worldPosition.Y:F2})";
    }
```

Format a world position into a human-readable string.

**Returns:** `string`

**Parameters:**
- `Vector2 worldPosition`

### FormatDuration

```csharp
/// <summary>
    /// Format a time duration in milliseconds to human-readable string.
    /// </summary>
    /// <param name="durationMs">Duration in milliseconds</param>
    /// <returns>Formatted string like "1.23ms" or "1.2s"</returns>
    public static string FormatDuration(float durationMs)
    {
        if (durationMs < 1000.0f)
        {
            return $"{durationMs:F2}ms";
        }
        else
        {
            return $"{durationMs / 1000.0f:F2}s";
        }
    }
```

Format a time duration in milliseconds to human-readable string.

**Returns:** `string`

**Parameters:**
- `float durationMs`

### FormatMemorySize

```csharp
/// <summary>
    /// Format a memory size in bytes to human-readable string.
    /// </summary>
    /// <param name="bytes">Size in bytes</param>
    /// <returns>Formatted string like "1.2KB" or "3.4MB"</returns>
    public static string FormatMemorySize(long bytes)
    {
        const long kb = 1024;
        const long mb = kb * 1024;
        const long gb = mb * 1024;

        if (bytes < kb)
        {
            return $"{bytes}B";
        }
        else if (bytes < mb)
        {
            return $"{bytes / (float)kb:F1}KB";
        }
        else if (bytes < gb)
        {
            return $"{bytes / (float)mb:F1}MB";
        }
        else
        {
            return $"{bytes / (float)gb:F1}GB";
        }
    }
```

Format a memory size in bytes to human-readable string.

**Returns:** `string`

**Parameters:**
- `long bytes`

### StartPerformanceMeasurement

```csharp
#endregion

    #region Performance Diagnostics

    /// <summary>
    /// Create a performance measurement context for timing operations.
    /// </summary>
    /// <param name="operationName">Name of the operation being measured</param>
    /// <returns>Performance measurement context</returns>
    public static PerformanceMeasurement StartPerformanceMeasurement(string operationName)
    {
        return new PerformanceMeasurement(operationName);
    }
```

Create a performance measurement context for timing operations.

**Returns:** `PerformanceMeasurement`

**Parameters:**
- `string operationName`

### FormatPerformanceResult

```csharp
/// <summary>
    /// Format a performance result into a diagnostic string.
    /// </summary>
    /// <param name="measurement">The performance measurement to format</param>
    /// <returns>Formatted performance string</returns>
    public static string FormatPerformanceResult(PerformanceMeasurement measurement)
    {
        var duration = FormatDuration(measurement.ElapsedMilliseconds);
        var memory = measurement.MemoryAllocated > 0 ? $", +{FormatMemorySize(measurement.MemoryAllocated)}" : string.Empty;
        
        return $"{measurement.OperationName}: {duration}{memory}";
    }
```

Format a performance result into a diagnostic string.

**Returns:** `string`

**Parameters:**
- `PerformanceMeasurement measurement`

### FormatValidationResult

```csharp
#endregion

    #region Validation Helpers

    /// <summary>
    /// Format validation results into a diagnostic string.
    /// </summary>
    /// <param name="isValid">Whether validation passed</param>
    /// <param name="message">Validation message</param>
    /// <param name="details">Optional validation details</param>
    /// <returns>Formatted validation string</returns>
    public static string FormatValidationResult(bool isValid, string message, string? details = null)
    {
        var result = new StringBuilder();
        result.Append(isValid ? "✓" : "✗");
        result.Append($" {message}");
        
        if (!string.IsNullOrEmpty(details))
        {
            result.Append($" - {details}");
        }
        
        return result.ToString();
    }
```

Format validation results into a diagnostic string.

**Returns:** `string`

**Parameters:**
- `bool isValid`
- `string message`
- `string? details`

### FormatValidationIssues

```csharp
/// <summary>
    /// Format a collection of validation issues into a diagnostic string.
    /// </summary>
    /// <param name="issues">Collection of validation issues</param>
    /// <param name="title">Optional title for the issues</param>
    /// <returns>Formatted issues string</returns>
    public static string FormatValidationIssues(string[] issues, string? title = null)
    {
        if (issues.Length == 0)
            return string.Empty;

        var result = new StringBuilder();
        
        if (!string.IsNullOrEmpty(title))
        {
            result.AppendLine(title);
            result.AppendLine(new string('-', title.Length));
        }

        for (int i = 0; i < issues.Length; i++)
        {
            result.AppendLine($"{i + 1}. {issues[i]}");
        }

        return result.ToString();
    }
```

Format a collection of validation issues into a diagnostic string.

**Returns:** `string`

**Parameters:**
- `string[] issues`
- `string? title`

### FormatComponentState

```csharp
#endregion

    #region Component State Diagnostics

    /// <summary>
    /// Format component state information for diagnostics.
    /// </summary>
    /// <param name="componentName">Name of the component</param>
    /// <param name="state">Current state</param>
    /// <param name="details">Additional state details</param>
    /// <returns>Formatted component state string</returns>
    public static string FormatComponentState(string componentName, string state, string? details = null)
    {
        var result = new StringBuilder();
        result.Append($"{componentName}: {state}");
        
        if (!string.IsNullOrEmpty(details))
        {
            result.Append($" ({details})");
        }
        
        return result.ToString();
    }
```

Format component state information for diagnostics.

**Returns:** `string`

**Parameters:**
- `string componentName`
- `string state`
- `string? details`

### FormatNodePath

```csharp
/// <summary>
    /// Format a node tree path for diagnostic output.
    /// </summary>
    /// <param name="node">The node to get the path for</param>
    /// <returns>Formatted node path string</returns>
    public static string FormatNodePath(Node? node)
    {
        if (node == null)
            return "<null>";
        
        return node.GetPath().ToString();
    }
```

Format a node tree path for diagnostic output.

**Returns:** `string`

**Parameters:**
- `Node? node`

