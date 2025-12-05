---
title: "Logger"
description: "Centralized logging facility for the Grid Building plugin.
USAGE: Consider dropping log level on the DebugSettings if you are getting too many messages
Responsibilities:
- Provide contextual logging (verbose, error, warning) integrated with plugin debug settings.
- Support dependency-injected configuration and throttled verbose output.
Ported from: godot/addons/grid_building/core/logging/gb_logger.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/logger/"
---

# Logger

```csharp
GridBuilding.Godot.Core.Logging
class Logger
{
    // Members...
}
```

Centralized logging facility for the Grid Building plugin.
USAGE: Consider dropping log level on the DebugSettings if you are getting too many messages
Responsibilities:
- Provide contextual logging (verbose, error, warning) integrated with plugin debug settings.
- Support dependency-injected configuration and throttled verbose output.
Ported from: godot/addons/grid_building/core/logging/gb_logger.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Logging/Logger.cs`  
**Namespace:** `GridBuilding.Godot.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateWithInjection

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Creates a Logger with dependency injection from container.
    /// </summary>
    /// <param name="container">The composition container</param>
    /// <returns>Configured Logger instance</returns>
    public static Logger CreateWithInjection(CompositionContainer container)
    {
        var debugSettings = container.GetDebugSettings();
        var logger = new Logger(debugSettings);

        // Inject dependencies
        logger.ResolveGbDependencies(container);

        // Validate dependencies were properly injected
        var issues = logger.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            // Can't use self to log warnings since we're in static context
            GD.PushWarning($"Logger dependency validation issues: {string.Join(", ", issues)}");
        }

        return logger;
    }
```

Creates a Logger with dependency injection from container.

**Returns:** `Logger`

**Parameters:**
- `CompositionContainer container`

### SetLogSink

```csharp
/// <summary>
    /// Sets the log sink for custom logging output.
    /// </summary>
    /// <param name="sink">Callable to handle log output</param>
    public void SetLogSink(Callable sink)
    {
        _logSink = sink;
    }
```

Sets the log sink for custom logging output.

**Returns:** `void`

**Parameters:**
- `Callable sink`

### LogVerbose

```csharp
/// <summary>
    /// Logs a verbose message.
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogVerbose(string message)
    {
        Log(LogLevel.VERBOSE, message);
    }
```

Logs a verbose message.

**Returns:** `void`

**Parameters:**
- `string message`

### LogDebug

```csharp
/// <summary>
    /// Logs a debug message.
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogDebug(string message)
    {
        Log(LogLevel.DEBUG, message);
    }
```

Logs a debug message.

**Returns:** `void`

**Parameters:**
- `string message`

### LogTrace

```csharp
/// <summary>
    /// Logs a trace message.
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogTrace(string message)
    {
        Log(LogLevel.TRACE, message);
    }
```

Logs a trace message.

**Returns:** `void`

**Parameters:**
- `string message`

### LogInfo

```csharp
/// <summary>
    /// Logs an info message.
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogInfo(string message)
    {
        Log(LogLevel.INFO, message);
    }
```

Logs an info message.

**Returns:** `void`

**Parameters:**
- `string message`

### LogWarning

```csharp
/// <summary>
    /// Logs a warning message.
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogWarning(string message)
    {
        Log(LogLevel.WARNING, message);
    }
```

Logs a warning message.

**Returns:** `void`

**Parameters:**
- `string message`

### LogError

```csharp
/// <summary>
    /// Logs an error message.
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogError(string message)
    {
        Log(LogLevel.ERROR, message);
    }
```

Logs an error message.

**Returns:** `void`

**Parameters:**
- `string message`

### LogVerboseOnce

```csharp
/// <summary>
    /// Logs a verbose message only once per key.
    /// </summary>
    /// <param name="key">Key to track uniqueness</param>
    /// <param name="message">Message to log</param>
    public void LogVerboseOnce(string key, string message)
    {
        LogOnce(LogLevel.VERBOSE, key, message);
    }
```

Logs a verbose message only once per key.

**Returns:** `void`

**Parameters:**
- `string key`
- `string message`

### LogDebugOnce

```csharp
/// <summary>
    /// Logs a debug message only once per key.
    /// </summary>
    /// <param name="key">Key to track uniqueness</param>
    /// <param name="message">Message to log</param>
    public void LogDebugOnce(string key, string message)
    {
        LogOnce(LogLevel.DEBUG, key, message);
    }
```

Logs a debug message only once per key.

**Returns:** `void`

**Parameters:**
- `string key`
- `string message`

### LogTraceOnce

```csharp
/// <summary>
    /// Logs a trace message only once per key.
    /// </summary>
    /// <param name="key">Key to track uniqueness</param>
    /// <param name="message">Message to log</param>
    public void LogTraceOnce(string key, string message)
    {
        LogOnce(LogLevel.TRACE, key, message);
    }
```

Logs a trace message only once per key.

**Returns:** `void`

**Parameters:**
- `string key`
- `string message`

### LogInfoOnce

```csharp
/// <summary>
    /// Logs an info message only once per key.
    /// </summary>
    /// <param name="key">Key to track uniqueness</param>
    /// <param name="message">Message to log</param>
    public void LogInfoOnce(string key, string message)
    {
        LogOnce(LogLevel.INFO, key, message);
    }
```

Logs an info message only once per key.

**Returns:** `void`

**Parameters:**
- `string key`
- `string message`

### LogWarningOnce

```csharp
/// <summary>
    /// Logs a warning message only once per key.
    /// </summary>
    /// <param name="key">Key to track uniqueness</param>
    /// <param name="message">Message to log</param>
    public void LogWarningOnce(string key, string message)
    {
        LogOnce(LogLevel.WARNING, key, message);
    }
```

Logs a warning message only once per key.

**Returns:** `void`

**Parameters:**
- `string key`
- `string message`

### LogErrorOnce

```csharp
/// <summary>
    /// Logs an error message only once per key.
    /// </summary>
    /// <param name="key">Key to track uniqueness</param>
    /// <param name="message">Message to log</param>
    public void LogErrorOnce(string key, string message)
    {
        LogOnce(LogLevel.ERROR, key, message);
    }
```

Logs an error message only once per key.

**Returns:** `void`

**Parameters:**
- `string key`
- `string message`

### ResolveGbDependencies

```csharp
#endregion

    #region Injectable Implementation

    public override bool ResolveGbDependencies(CompositionContainer container)
    {
        if (container != null)
        {
            _debug = container.GetDebugSettings() ?? new DebugSettings();
            return true;
        }
        return false;
    }
```

**Returns:** `bool`

**Parameters:**
- `CompositionContainer container`

### GetRuntimeIssues

```csharp
public override global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var issues = new global::Godot.Collections.Array<string>();

        if (_debug == null)
        {
            issues.Add("Debug settings not available");
        }

        return issues;
    }
```

**Returns:** `global::Godot.Collections.Array<string>`

