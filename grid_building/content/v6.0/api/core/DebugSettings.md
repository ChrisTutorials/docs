---
title: "DebugSettings"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/debugsettings/"
---

# DebugSettings

```csharp
GridBuilding.Core.Logging
class DebugSettings
{
    // Members...
}
```

Debug settings for the GridBuilding plugin.
Provides configuration for logging levels, output destinations,
and debug features. This is a pure C# implementation for Core use.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Systems/Logging/DebugSettings.cs`  
**Namespace:** `GridBuilding.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### VerboseEnabled

```csharp
#region Properties

    /// <summary>
    /// Whether verbose logging is enabled
    /// </summary>
    public bool VerboseEnabled { get; set; } = false;
```

Whether verbose logging is enabled

### TraceEnabled

```csharp
/// <summary>
    /// Whether trace logging is enabled
    /// </summary>
    public bool TraceEnabled { get; set; } = false;
```

Whether trace logging is enabled

### InfoEnabled

```csharp
/// <summary>
    /// Whether info logging is enabled
    /// </summary>
    public bool InfoEnabled { get; set; } = true;
```

Whether info logging is enabled

### WarningEnabled

```csharp
/// <summary>
    /// Whether warning logging is enabled
    /// </summary>
    public bool WarningEnabled { get; set; } = true;
```

Whether warning logging is enabled

### ErrorEnabled

```csharp
/// <summary>
    /// Whether error logging is enabled
    /// </summary>
    public bool ErrorEnabled { get; set; } = true;
```

Whether error logging is enabled

### VerboseMinIntervalMs

```csharp
/// <summary>
    /// Minimum interval between verbose logs (milliseconds)
    /// </summary>
    public int VerboseMinIntervalMs { get; set; } = 250;
```

Minimum interval between verbose logs (milliseconds)

### IncludeTimestamps

```csharp
/// <summary>
    /// Whether to include timestamps in log messages
    /// </summary>
    public bool IncludeTimestamps { get; set; } = true;
```

Whether to include timestamps in log messages

### IncludeCallerInfo

```csharp
/// <summary>
    /// Whether to include caller information in log messages
    /// </summary>
    public bool IncludeCallerInfo { get; set; } = false;
```

Whether to include caller information in log messages


## Methods

### IsLevelEnabled

```csharp
#endregion

    #region Methods

    /// <summary>
    /// Checks if a log level is enabled
    /// </summary>
    /// <param name="level">The log level to check</param>
    /// <returns>True if the level is enabled</returns>
    public bool IsLevelEnabled(LogLevel level)
    {
        return level switch
        {
            LogLevel.Trace => TraceEnabled,
            LogLevel.Verbose => VerboseEnabled,
            LogLevel.Info => InfoEnabled,
            LogLevel.Warning => WarningEnabled,
            LogLevel.Error => ErrorEnabled,
            LogLevel.Critical => false, // Note: LogLevel.Critical maps to false in DebugSettings
            LogLevel.None => false,
            _ => false
        };
    }
```

Checks if a log level is enabled

**Returns:** `bool`

**Parameters:**
- `LogLevel level`

### Clone

```csharp
/// <summary>
    /// Creates a copy of these debug settings
    /// </summary>
    /// <returns>A new DebugSettings instance with the same values</returns>
    public DebugSettings Clone()
    {
        return new DebugSettings(
            VerboseEnabled,
            TraceEnabled,
            InfoEnabled,
            WarningEnabled,
            ErrorEnabled
        )
        {
            VerboseMinIntervalMs = VerboseMinIntervalMs,
            IncludeTimestamps = IncludeTimestamps,
            IncludeCallerInfo = IncludeCallerInfo
        };
    }
```

Creates a copy of these debug settings

**Returns:** `DebugSettings`

