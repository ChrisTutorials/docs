---
title: "Logger"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/logger/"
---

# Logger

```csharp
GridBuilding.Core.Services.Logging
class Logger
{
    // Members...
}
```

Core Logger implementation that implements ILogger interface.
Pure C# implementation without Godot dependencies for the Core layer.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Logging/Logger.cs`  
**Namespace:** `GridBuilding.Core.Services.Logging`  
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
        get => _logLevel; 
        set => _logLevel = value; 
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
        if (level <= _logLevel)
        {
            var formattedMessage = $"[{level}] {message}";
            WriteToConsole(level, formattedMessage);
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
    public void LogDebug(string message)
    {
        Log(LogLevel.Debug, message);
    }
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
    public void LogDebug(string message, object context)
    {
        Log(LogLevel.Debug, $"{message} [Context: {context}]");
    }
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
    public void LogInfo(string message)
    {
        Log(LogLevel.Info, message);
    }
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
    public void LogInfo(string message, object context)
    {
        Log(LogLevel.Info, $"{message} [Context: {context}]");
    }
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
    public void LogWarning(string message)
    {
        Log(LogLevel.Warning, message);
    }
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
    public void LogWarning(string message, object context)
    {
        Log(LogLevel.Warning, $"{message} [Context: {context}]");
    }
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
    public void LogError(string message)
    {
        Log(LogLevel.Error, message);
    }
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
    public void LogError(string message, object context)
    {
        Log(LogLevel.Error, $"{message} [Context: {context}]");
    }
```

Log an error message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`

