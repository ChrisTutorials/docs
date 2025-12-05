---
title: "BridgeLog"
description: "Static helper class for convenient bridge logging access"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/bridgelog/"
---

# BridgeLog

```csharp
GridBuilding.Godot.Logging
class BridgeLog
{
    // Members...
}
```

Static helper class for convenient bridge logging access

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Logging/LoggerBridge.cs`  
**Namespace:** `GridBuilding.Godot.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Logger

```csharp
/// <summary>
    /// Global bridge logger instance - can be replaced with custom implementation
    /// </summary>
    public static ILogger Logger { get; set; } = LoggerBridge.CreateForHybrid();
```

Global bridge logger instance - can be replaced with custom implementation


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

### UseCoreBridge

```csharp
/// <summary>
    /// Sets up a Core-optimized bridge
    /// </summary>
    public static void UseCoreBridge()
    {
        Logger = LoggerBridge.CreateForCore();
    }
```

Sets up a Core-optimized bridge

**Returns:** `void`

### UseGodotBridge

```csharp
/// <summary>
    /// Sets up a Godot-optimized bridge
    /// </summary>
    public static void UseGodotBridge(Node? parent = null)
    {
        Logger = LoggerBridge.CreateForGodot(parent);
    }
```

Sets up a Godot-optimized bridge

**Returns:** `void`

**Parameters:**
- `Node? parent`

### UseHybridBridge

```csharp
/// <summary>
    /// Sets up a hybrid bridge
    /// </summary>
    public static void UseHybridBridge(Node? parent = null)
    {
        Logger = LoggerBridge.CreateForHybrid(parent);
    }
```

Sets up a hybrid bridge

**Returns:** `void`

**Parameters:**
- `Node? parent`

### UseTestingBridge

```csharp
/// <summary>
    /// Sets up a testing-optimized bridge
    /// </summary>
    public static void UseTestingBridge(ILogger? mockLogger = null)
    {
        Logger = LoggerBridge.CreateForTesting(mockLogger);
    }
```

Sets up a testing-optimized bridge

**Returns:** `void`

**Parameters:**
- `ILogger? mockLogger`

