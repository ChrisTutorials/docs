---
title: "LoggerBridge"
description: "Adapter that provides context-aware routing between Core and Godot logging systems.
Automatically selects the appropriate logger based on execution context.
This bridge enables:
- Seamless Core/Godot integration without context switching
- Automatic logger selection based on environment
- Development vs production configuration switching
- Testing scenarios with mock loggers"
weight: 20
url: "/gridbuilding/v6-0/api/godot/loggerbridge/"
---

# LoggerBridge

```csharp
GridBuilding.Godot.Logging
class LoggerBridge
{
    // Members...
}
```

Adapter that provides context-aware routing between Core and Godot logging systems.
Automatically selects the appropriate logger based on execution context.
This bridge enables:
- Seamless Core/Godot integration without context switching
- Automatic logger selection based on environment
- Development vs production configuration switching
- Testing scenarios with mock loggers

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Logging/LoggerBridge.cs`  
**Namespace:** `GridBuilding.Godot.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### LogLevel

```csharp
/// <summary>
    /// Current log level for filtering messages.
    /// </summary>
    public LogLevel LogLevel 
    { 
        get => GetActiveLogger().LogLevel; 
        set => SetLogLevelOnAllLoggers(value); 
    }
```

Current log level for filtering messages.


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

        var activeLogger = GetActiveLogger();
        activeLogger.Log(level, message);
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
    public void LogDebug(string message) => GetActiveLogger().LogDebug(message);
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
    public void LogDebug(string message, object context) => GetActiveLogger().LogDebug(message, context);
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
    public void LogInfo(string message) => GetActiveLogger().LogInfo(message);
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
    public void LogInfo(string message, object context) => GetActiveLogger().LogInfo(message, context);
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
    public void LogWarning(string message) => GetActiveLogger().LogWarning(message);
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
    public void LogWarning(string message, object context) => GetActiveLogger().LogWarning(message, context);
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
    public void LogError(string message) => GetActiveLogger().LogError(message);
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
    public void LogError(string message, object context) => GetActiveLogger().LogError(message, context);
```

Log an error message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`

### CreateForCore

```csharp
/// <summary>
    /// Creates a LoggerBridge optimized for Core (POCS) usage.
    /// </summary>
    /// <returns>A LoggerBridge configured for Core logging</returns>
    public static LoggerBridge CreateForCore()
    {
        return new LoggerBridge(LoggerContext.Core);
    }
```

Creates a LoggerBridge optimized for Core (POCS) usage.

**Returns:** `LoggerBridge`

### CreateForGodot

```csharp
/// <summary>
    /// Creates a LoggerBridge optimized for Godot usage.
    /// </summary>
    /// <param name="parent">Optional parent node for GodotLogger</param>
    /// <returns>A LoggerBridge configured for Godot logging</returns>
    public static LoggerBridge CreateForGodot(Node? parent = null)
    {
        return new LoggerBridge(LoggerContext.Godot, parent);
    }
```

Creates a LoggerBridge optimized for Godot usage.

**Returns:** `LoggerBridge`

**Parameters:**
- `Node? parent`

### CreateForHybrid

```csharp
/// <summary>
    /// Creates a LoggerBridge that uses both Core and Godot loggers.
    /// </summary>
    /// <param name="parent">Optional parent node for GodotLogger</param>
    /// <returns>A LoggerBridge configured for hybrid logging</returns>
    public static LoggerBridge CreateForHybrid(Node? parent = null)
    {
        return new LoggerBridge(LoggerContext.Hybrid, parent);
    }
```

Creates a LoggerBridge that uses both Core and Godot loggers.

**Returns:** `LoggerBridge`

**Parameters:**
- `Node? parent`

### CreateForTesting

```csharp
/// <summary>
    /// Creates a LoggerBridge optimized for testing.
    /// </summary>
    /// <param name="mockLogger">Optional mock logger for testing</param>
    /// <returns>A LoggerBridge configured for testing</returns>
    public static LoggerBridge CreateForTesting(ILogger? mockLogger = null)
    {
        var coreLogger = mockLogger ?? CoreLogger.CreateForTesting();
        return new LoggerBridge(coreLogger, null, LoggerContext.Core);
    }
```

Creates a LoggerBridge optimized for testing.

**Returns:** `LoggerBridge`

**Parameters:**
- `ILogger? mockLogger`

