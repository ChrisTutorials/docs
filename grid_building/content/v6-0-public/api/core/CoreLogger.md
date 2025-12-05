---
title: "CoreLogger"
description: "Core logger implementation for POCS (Pure Object/Class/System) components.
Provides engine-agnostic logging using console output and structured logging.
This logger is designed for:
- Core components that should not depend on any game engine
- Unit testing environments without engine dependencies
- Server-side or tooling scenarios
- Any POCS component requiring logging"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/corelogger/"
---

# CoreLogger

```csharp
GridBuilding.Core.Logging
class CoreLogger
{
    // Members...
}
```

Core logger implementation for POCS (Pure Object/Class/System) components.
Provides engine-agnostic logging using console output and structured logging.
This logger is designed for:
- Core components that should not depend on any game engine
- Unit testing environments without engine dependencies
- Server-side or tooling scenarios
- Any POCS component requiring logging

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Logging/CoreLogger.cs`  
**Namespace:** `GridBuilding.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### LogLevel

```csharp
public LogLevel LogLevel { get; set; } = LogLevel.Info;
```

### LogFilePath

```csharp
/// <summary>
    /// Optional file output path for persistent logging
    /// </summary>
    public string? LogFilePath { get; set; }
```

Optional file output path for persistent logging

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

### Log

```csharp
/// <summary>
    /// Logs a message at the specified level.
    /// </summary>
    /// <param name="level">The log level</param>
    /// <param name="message">The message to log</param>
    public void Log(LogLevel level, string message)
    {
        if (level < LogLevel)
            return;

        var formattedMessage = FormatMessage(level, message);

        // Output to console
        OutputToConsole(level, formattedMessage);

        // Optional file output
        if (!string.IsNullOrEmpty(LogFilePath))
        {
            OutputToFile(formattedMessage);
        }
    }
```

Logs a message at the specified level.

**Returns:** `void`

**Parameters:**
- `LogLevel level`
- `string message`

### LogDebug

```csharp
/// <summary>
    /// Log a debug message
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogDebug(string message) => Log(LogLevel.Debug, message);
```

Log a debug message

**Returns:** `void`

**Parameters:**
- `string message`

### LogDebug

```csharp
/// <summary>
    /// Log a debug message with context
    /// </summary>
    /// <param name="message">Message to log</param>
    /// <param name="context">Context object</param>
    public void LogDebug(string message, object context) => 
        Log(LogLevel.Debug, $"{message} [Context: {context}]");
```

Log a debug message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`

### LogInfo

```csharp
/// <summary>
    /// Log an info message
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogInfo(string message) => Log(LogLevel.Info, message);
```

Log an info message

**Returns:** `void`

**Parameters:**
- `string message`

### LogInfo

```csharp
/// <summary>
    /// Log an info message with context
    /// </summary>
    /// <param name="message">Message to log</param>
    /// <param name="context">Context object</param>
    public void LogInfo(string message, object context) => 
        Log(LogLevel.Info, $"{message} [Context: {context}]");
```

Log an info message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`

### LogWarning

```csharp
/// <summary>
    /// Log a warning message
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogWarning(string message) => Log(LogLevel.Warning, message);
```

Log a warning message

**Returns:** `void`

**Parameters:**
- `string message`

### LogWarning

```csharp
/// <summary>
    /// Log a warning message with context
    /// </summary>
    /// <param name="message">Message to log</param>
    /// <param name="context">Context object</param>
    public void LogWarning(string message, object context) => 
        Log(LogLevel.Warning, $"{message} [Context: {context}]");
```

Log a warning message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`

### LogError

```csharp
/// <summary>
    /// Log an error message
    /// </summary>
    /// <param name="message">Message to log</param>
    public void LogError(string message) => Log(LogLevel.Error, message);
```

Log an error message

**Returns:** `void`

**Parameters:**
- `string message`

### LogError

```csharp
/// <summary>
    /// Log an error message with context
    /// </summary>
    /// <param name="message">Message to log</param>
    /// <param name="context">Context object</param>
    public void LogError(string message, object context) => 
        Log(LogLevel.Error, $"{message} [Context: {context}]");
```

Log an error message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`

### LogError

```csharp
/// <summary>
    /// Log an error message with exception
    /// </summary>
    /// <param name="message">Message to log</param>
    /// <param name="exception">Exception to log</param>
    public void LogError(string message, System.Exception exception) => 
        Log(LogLevel.Error, $"{message} - Exception: {exception.Message}");
```

Log an error message with exception

**Returns:** `void`

**Parameters:**
- `string message`
- `System.Exception exception`

### Create

```csharp
/// <summary>
    /// Creates a new CoreLogger with the specified configuration.
    /// </summary>
    /// <param name="logLevel">The minimum log level to output</param>
    /// <param name="logFilePath">Optional file path for persistent logging</param>
    /// <returns>A new CoreLogger instance</returns>
    public static CoreLogger Create(LogLevel logLevel = LogLevel.Info, string? logFilePath = null)
    {
        return new CoreLogger 
        { 
            LogLevel = logLevel,
            LogFilePath = logFilePath
        };
    }
```

Creates a new CoreLogger with the specified configuration.

**Returns:** `CoreLogger`

**Parameters:**
- `LogLevel logLevel`
- `string? logFilePath`

### CreateForTesting

```csharp
/// <summary>
    /// Creates a CoreLogger optimized for unit testing.
    /// </summary>
    /// <param name="logLevel">The minimum log level to output</param>
    /// <returns>A CoreLogger configured for testing</returns>
    public static CoreLogger CreateForTesting(LogLevel logLevel = LogLevel.Debug)
    {
        return new CoreLogger 
        { 
            LogLevel = logLevel,
            IncludeTimestamps = false,
            IncludeCallerInfo = true
        };
    }
```

Creates a CoreLogger optimized for unit testing.

**Returns:** `CoreLogger`

**Parameters:**
- `LogLevel logLevel`

