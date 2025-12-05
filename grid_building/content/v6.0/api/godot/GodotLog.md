---
title: "GodotLog"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/godotlog/"
---

# GodotLog

```csharp
GridBuilding.Godot.Logging
class GodotLog
{
    // Members...
}
```

Static helper class for convenient Godot logging access.
The logger instance should be set via dependency injection during startup.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Logging/GodotLogger.cs`  
**Namespace:** `GridBuilding.Godot.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Logger

```csharp
/// <summary>
    /// Global Godot logger instance - should be set via dependency injection.
    /// Falls back to creating a default GodotLogger if not configured.
    /// </summary>
    public static ILogger Logger
    {
        get => _logger ??= GodotLogger.Create();
        set => _logger = value;
    }
```

Global Godot logger instance - should be set via dependency injection.
Falls back to creating a default GodotLogger if not configured.


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

### Configure

```csharp
/// <summary>
    /// Configures the global logger instance (typically called during DI setup)
    /// </summary>
    public static void Configure(ILogger logger)
    {
        _logger = logger ?? throw new ArgumentNullException(nameof(logger));
    }
```

Configures the global logger instance (typically called during DI setup)

**Returns:** `void`

**Parameters:**
- `ILogger logger`

### UseDevelopmentLogger

```csharp
/// <summary>
    /// Sets up a development-optimized logger
    /// </summary>
    public static void UseDevelopmentLogger()
    {
        _logger = GodotLogger.CreateForDevelopment();
    }
```

Sets up a development-optimized logger

**Returns:** `void`

### UseProductionLogger

```csharp
/// <summary>
    /// Sets up a production-optimized logger
    /// </summary>
    public static void UseProductionLogger()
    {
        _logger = GodotLogger.CreateForProduction();
    }
```

Sets up a production-optimized logger

**Returns:** `void`

