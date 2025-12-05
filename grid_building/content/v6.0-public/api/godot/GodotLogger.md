---
title: "GodotLogger"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/godotlogger/"
---

# GodotLogger

```csharp
GridBuilding.Godot.Logging
class GodotLogger
{
    // Members...
}
```

Godot engine logger implementation for Grid Building components.
Provides logging integration with Godot's debug system (GD.Print, GD.PrintErr, etc.).
This is a plain service class that implements ILogger - it does NOT extend Node.
Resolve it through the dependency injection system or create via factory methods.
This logger is designed for:
- Godot runtime components that need engine integration
- Development and debugging within the Godot editor
- Any component requiring Godot's logging infrastructure

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Logging/GodotLogger.cs`  
**Namespace:** `GridBuilding.Godot.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### LogLevel

```csharp
/// <summary>
    /// Current log level for filtering messages.
    /// </summary>
    public LogLevel LogLevel { get; set; } = LogLevel.Info;
```

Current log level for filtering messages.

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

### UseRichText

```csharp
/// <summary>
    /// Whether to use rich text formatting for Godot console
    /// </summary>
    public bool UseRichText { get; set; } = true;
```

Whether to use rich text formatting for Godot console

### LogSink

```csharp
/// <summary>
    /// Optional custom log sink action for additional output handling
    /// </summary>
    public Action<string>? LogSink { get; set; }
```

Optional custom log sink action for additional output handling


## Methods

### Log

```csharp
/// <summary>
    /// Logs a message at the specified level.
    /// </summary>
    /// <param name="level">The log level</param>
    /// <param name="message">The message to log</param>
    /// <param name="callerMember">Caller member name (auto-populated)</param>
    /// <param name="callerFile">Caller file path (auto-populated)</param>
    public void Log(
        LogLevel level, 
        string message,
        [CallerMemberName] string callerMember = "",
        [CallerFilePath] string callerFile = "")
    {
        if (level < LogLevel)
            return;

        var formattedMessage = FormatMessage(level, message, callerMember, callerFile);

        // Output to Godot console
        OutputToGodot(level, formattedMessage);

        // Optional custom sink
        LogSink?.Invoke(formattedMessage);
    }
```

Logs a message at the specified level.

**Returns:** `void`

**Parameters:**
- `LogLevel level`
- `string message`
- `string callerMember`
- `string callerFile`

### LogDebug

```csharp
/// <summary>
    /// Log a debug message
    /// </summary>
    public void LogDebug(
        string message,
        [CallerMemberName] string callerMember = "",
        [CallerFilePath] string callerFile = "") 
        => Log(LogLevel.Debug, message, callerMember, callerFile);
```

Log a debug message

**Returns:** `void`

**Parameters:**
- `string message`
- `string callerMember`
- `string callerFile`

### LogDebug

```csharp
/// <summary>
    /// Log a debug message with context
    /// </summary>
    public void LogDebug(
        string message, 
        object context,
        [CallerMemberName] string callerMember = "",
        [CallerFilePath] string callerFile = "") => 
        Log(LogLevel.Debug, $"{message} [Context: {context}]", callerMember, callerFile);
```

Log a debug message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`
- `string callerMember`
- `string callerFile`

### LogInfo

```csharp
/// <summary>
    /// Log an info message
    /// </summary>
    public void LogInfo(
        string message,
        [CallerMemberName] string callerMember = "",
        [CallerFilePath] string callerFile = "") 
        => Log(LogLevel.Info, message, callerMember, callerFile);
```

Log an info message

**Returns:** `void`

**Parameters:**
- `string message`
- `string callerMember`
- `string callerFile`

### LogInfo

```csharp
/// <summary>
    /// Log an info message with context
    /// </summary>
    public void LogInfo(
        string message, 
        object context,
        [CallerMemberName] string callerMember = "",
        [CallerFilePath] string callerFile = "") => 
        Log(LogLevel.Info, $"{message} [Context: {context}]", callerMember, callerFile);
```

Log an info message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`
- `string callerMember`
- `string callerFile`

### LogWarning

```csharp
/// <summary>
    /// Log a warning message
    /// </summary>
    public void LogWarning(
        string message,
        [CallerMemberName] string callerMember = "",
        [CallerFilePath] string callerFile = "") 
        => Log(LogLevel.Warning, message, callerMember, callerFile);
```

Log a warning message

**Returns:** `void`

**Parameters:**
- `string message`
- `string callerMember`
- `string callerFile`

### LogWarning

```csharp
/// <summary>
    /// Log a warning message with context
    /// </summary>
    public void LogWarning(
        string message, 
        object context,
        [CallerMemberName] string callerMember = "",
        [CallerFilePath] string callerFile = "") => 
        Log(LogLevel.Warning, $"{message} [Context: {context}]", callerMember, callerFile);
```

Log a warning message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`
- `string callerMember`
- `string callerFile`

### LogError

```csharp
/// <summary>
    /// Log an error message
    /// </summary>
    public void LogError(
        string message,
        [CallerMemberName] string callerMember = "",
        [CallerFilePath] string callerFile = "") 
        => Log(LogLevel.Error, message, callerMember, callerFile);
```

Log an error message

**Returns:** `void`

**Parameters:**
- `string message`
- `string callerMember`
- `string callerFile`

### LogError

```csharp
/// <summary>
    /// Log an error message with context
    /// </summary>
    public void LogError(
        string message, 
        object context,
        [CallerMemberName] string callerMember = "",
        [CallerFilePath] string callerFile = "") => 
        Log(LogLevel.Error, $"{message} [Context: {context}]", callerMember, callerFile);
```

Log an error message with context

**Returns:** `void`

**Parameters:**
- `string message`
- `object context`
- `string callerMember`
- `string callerFile`

### Create

```csharp
/// <summary>
    /// Creates a new GodotLogger with the specified configuration.
    /// </summary>
    /// <param name="logLevel">The minimum log level to output</param>
    /// <returns>A new GodotLogger instance</returns>
    public static GodotLogger Create(LogLevel logLevel = LogLevel.Info)
    {
        return new GodotLogger { LogLevel = logLevel };
    }
```

Creates a new GodotLogger with the specified configuration.

**Returns:** `GodotLogger`

**Parameters:**
- `LogLevel logLevel`

### CreateForDevelopment

```csharp
/// <summary>
    /// Creates a GodotLogger optimized for development debugging.
    /// </summary>
    /// <returns>A GodotLogger configured for development</returns>
    public static GodotLogger CreateForDevelopment()
    {
        return new GodotLogger 
        { 
            LogLevel = LogLevel.Debug,
            IncludeTimestamps = true,
            IncludeCallerInfo = true,
            UseRichText = true
        };
    }
```

Creates a GodotLogger optimized for development debugging.

**Returns:** `GodotLogger`

### CreateForProduction

```csharp
/// <summary>
    /// Creates a GodotLogger optimized for production use.
    /// </summary>
    /// <returns>A GodotLogger configured for production</returns>
    public static GodotLogger CreateForProduction()
    {
        return new GodotLogger 
        { 
            LogLevel = LogLevel.Warning,
            IncludeTimestamps = false,
            IncludeCallerInfo = false,
            UseRichText = false
        };
    }
```

Creates a GodotLogger optimized for production use.

**Returns:** `GodotLogger`

