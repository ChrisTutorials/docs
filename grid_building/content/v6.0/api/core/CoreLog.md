---
title: "CoreLog"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/corelog/"
---

# CoreLog

```csharp
GridBuilding.Core.Logging
class CoreLog
{
    // Members...
}
```

Static helper class for convenient Core logging access

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Logging/CoreLogger.cs`  
**Namespace:** `GridBuilding.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Logger

```csharp
/// <summary>
    /// Global Core logger instance - can be replaced with custom implementation
    /// </summary>
    public static ILogger Logger { get; set; } = CoreLogger.Create();
```

Global Core logger instance - can be replaced with custom implementation


## Methods

### Error

```csharp
public static void Error(string message) => Logger.LogError(message);
```

**Returns:** `void`

**Parameters:**
- `string message`

### Warning

```csharp
public static void Warning(string message) => Logger.LogWarning(message);
```

**Returns:** `void`

**Parameters:**
- `string message`

### Info

```csharp
public static void Info(string message) => Logger.LogInfo(message);
```

**Returns:** `void`

**Parameters:**
- `string message`

### Debug

```csharp
public static void Debug(string message) => Logger.LogDebug(message);
```

**Returns:** `void`

**Parameters:**
- `string message`

### UseTestLogger

```csharp
/// <summary>
    /// Sets up a test-optimized logger
    /// </summary>
    public static void UseTestLogger(LogLevel logLevel = LogLevel.Debug)
    {
        Logger = CoreLogger.CreateForTesting(logLevel);
    }
```

Sets up a test-optimized logger

**Returns:** `void`

**Parameters:**
- `LogLevel logLevel`

### UseFileLogger

```csharp
/// <summary>
    /// Sets up a file-based logger
    /// </summary>
    public static void UseFileLogger(string filePath, LogLevel logLevel = LogLevel.Info)
    {
        Logger = CoreLogger.Create(logLevel, filePath);
    }
```

Sets up a file-based logger

**Returns:** `void`

**Parameters:**
- `string filePath`
- `LogLevel logLevel`

