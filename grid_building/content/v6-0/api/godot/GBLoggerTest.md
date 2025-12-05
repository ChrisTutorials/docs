---
title: "GBLoggerTest"
description: "C# tests for Logger
Ported from: grid_building/helpers/utils/diagnostics/gb_logger_test.gd
Tests pure logging logic including:
- Level filtering
- Log-once functionality
- Lazy message providers
- Sink management"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbloggertest/"
---

# GBLoggerTest

```csharp
GridBuilding.Godot.Tests.Core.Logging
class GBLoggerTest
{
    // Members...
}
```

C# tests for Logger
Ported from: grid_building/helpers/utils/diagnostics/gb_logger_test.gd
Tests pure logging logic including:
- Level filtering
- Log-once functionality
- Lazy message providers
- Sink management

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Logging/GBLoggerTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Logger_ShouldInstantiateSuccessfully

```csharp
[Fact]
    public void Logger_ShouldInstantiateSuccessfully()
    {
        ;
    }
```

**Returns:** `void`

### LevelFiltering_ShouldFilterBelowThreshold

```csharp
[Fact]
    public void LevelFiltering_ShouldFilterBelowThreshold()
    {
        _logger.Settings.Level = LogLevel.WARNING;
        
        _logger.LogDebug("debug");   // should not be logged
        _logger.LogWarning("warning"); // should be logged
        _logger.LogError("error");     // should be logged
        
        ;
        ;
        ;
    }
```

**Returns:** `void`

### LogDebugOnce_ShouldLogOnlyOnceForSameObject

```csharp
[Fact]
    public void LogDebugOnce_ShouldLogOnlyOnceForSameObject()
    {
        var obj = new object();
        
        _logger.LogDebugOnce(obj, MSG_DEBUG_ONE);
        _logger.LogDebugOnce(obj, "This is another test debug message");
        
        Assert.Single(_receivedLogs);
        ;
    }
```

**Returns:** `void`

### LogWarningOnce_ShouldLogOnlyOnceForSameObject

```csharp
[Fact]
    public void LogWarningOnce_ShouldLogOnlyOnceForSameObject()
    {
        var obj = new object();
        
        _logger.LogWarningOnce(obj, MSG_WARN_ONE);
        _logger.LogWarningOnce(obj, MSG_WARN_TWO);
        
        Assert.Single(_receivedLogs);
        ;
    }
```

**Returns:** `void`

### LogWarningOnce_ShouldLogMultipleTimesForDifferentObjects

```csharp
[Fact]
    public void LogWarningOnce_ShouldLogMultipleTimesForDifferentObjects()
    {
        var obj1 = new object();
        var obj2 = new object();
        
        _logger.LogWarningOnce(obj1, MSG_WARN_ONE);
        _logger.LogWarningOnce(obj2, MSG_WARN_TWO);
        
        ;
        ;
        ;
    }
```

**Returns:** `void`

### LogErrorOnce_ShouldLogOnlyOnceForSameObject

```csharp
[Fact]
    public void LogErrorOnce_ShouldLogOnlyOnceForSameObject()
    {
        var obj = new object();
        
        _logger.LogErrorOnce(obj, MSG_ERR_ONE);
        _logger.LogErrorOnce(obj, "This is another test error message");
        
        Assert.Single(_receivedLogs);
        ;
    }
```

**Returns:** `void`

### LogInfoOnce_ShouldLogOnlyOnceForSameObject

```csharp
[Fact]
    public void LogInfoOnce_ShouldLogOnlyOnceForSameObject()
    {
        var obj = new object();
        
        _logger.LogInfoOnce(obj, MSG_INFO_ONE);
        _logger.LogInfoOnce(obj, "This is another test info message");
        
        Assert.Single(_receivedLogs);
        ;
    }
```

**Returns:** `void`

### LazyProvider_ShouldNotBeCalledWhenLevelDisabled

```csharp
[Fact]
    public void LazyProvider_ShouldNotBeCalledWhenLevelDisabled()
    {
        _logger.Settings.Level = LogLevel.WARNING;
        bool called = false;
        
        _logger.LogDebugLazy(() =>
        {
            called = true;
            return "expensive";
        });
        
        ;
    }
```

**Returns:** `void`

### LazyProvider_ShouldBeCalledWhenLevelEnabled

```csharp
[Fact]
    public void LazyProvider_ShouldBeCalledWhenLevelEnabled()
    {
        bool called = false;
        
        _logger.LogDebugLazy(() =>
        {
            called = true;
            return MSG_HEAVY_RESULT;
        });
        
        ;
        Assert.Single(_receivedLogs);
        ;
    }
```

**Returns:** `void`

### SetLogSink_ShouldWorkForErrors

```csharp
[Fact]
    public void SetLogSink_ShouldWorkForErrors()
    {
        _logger.Settings.Level = LogLevel.ERROR;
        
        _logger.LogError("problem");
        
        Assert.Single(_receivedLogs);
        ;
        ;
    }
```

**Returns:** `void`

### DefaultEmission_ShouldNotCrashWithoutSink

```csharp
[Fact]
    public void DefaultEmission_ShouldNotCrashWithoutSink()
    {
        _logger.SetLogSink(null);
        bool called = false;
        
        _logger.LogDebugLazy(() =>
        {
            called = true;
            return "no-sink";
        });
        
        // Provider should still be called even when no sink is set
        ;
    }
```

**Returns:** `void`

### ClearedSink_ShouldBeHandledGracefully

```csharp
[Fact]
    public void ClearedSink_ShouldBeHandledGracefully()
    {
        bool called1 = false;
        _logger.LogDebugLazy(() =>
        {
            called1 = true;
            return "bound-sink";
        });
        
        ;
        Assert.Single(_receivedLogs);
        
        // Clear the sink
        _logger.SetLogSink(null);
        
        bool called2 = false;
        _logger.LogDebugLazy(() =>
        {
            called2 = true;
            return "after-clear";
        });
        
        // Provider should still be called even when sink cleared
        ;
    }
```

**Returns:** `void`

### IsLevelEnabled_ShouldFilterCorrectly

```csharp
[Fact]
    public void IsLevelEnabled_ShouldFilterCorrectly()
    {
        _logger.Settings.Level = LogLevel.WARNING;
        
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### LogAt_ShouldLogStringMessage

```csharp
[Fact]
    public void LogAt_ShouldLogStringMessage()
    {
        _logger.LogAt(LogLevel.DEBUG, MSG_DIRECT_STRING);
        
        Assert.Single(_receivedLogs);
        ;
    }
```

**Returns:** `void`

### LogAt_ShouldLogCallableMessage

```csharp
[Fact]
    public void LogAt_ShouldLogCallableMessage()
    {
        bool called = false;
        
        _logger.LogAt(LogLevel.DEBUG, () =>
        {
            called = true;
            return MSG_CALLABLE_RESULT;
        });
        
        ;
        ;
    }
```

**Returns:** `void`

### MultipleLogs_ShouldBeReceivedInOrder

```csharp
[Fact]
    public void MultipleLogs_ShouldBeReceivedInOrder()
    {
        _logger.LogDebug(MSG_FIRST);
        _logger.LogDebug(MSG_SECOND);
        _logger.LogDebug(MSG_THIRD);
        
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### IsLevelEnabled_ShouldRespectThreshold

```csharp
[Theory]
    [InlineData(LogLevel.DEBUG, LogLevel.DEBUG, true)]
    [InlineData(LogLevel.DEBUG, LogLevel.INFO, true)]
    [InlineData(LogLevel.DEBUG, LogLevel.WARNING, true)]
    [InlineData(LogLevel.DEBUG, LogLevel.ERROR, true)]
    [InlineData(LogLevel.INFO, LogLevel.DEBUG, false)]
    [InlineData(LogLevel.INFO, LogLevel.INFO, true)]
    [InlineData(LogLevel.WARNING, LogLevel.DEBUG, false)]
    [InlineData(LogLevel.WARNING, LogLevel.INFO, false)]
    [InlineData(LogLevel.WARNING, LogLevel.WARNING, true)]
    [InlineData(LogLevel.ERROR, LogLevel.DEBUG, false)]
    [InlineData(LogLevel.ERROR, LogLevel.WARNING, false)]
    [InlineData(LogLevel.ERROR, LogLevel.ERROR, true)]
    public void IsLevelEnabled_ShouldRespectThreshold(LogLevel threshold, LogLevel messageLevel, bool expected)
    {
        _logger.Settings.Level = threshold;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `LogLevel threshold`
- `LogLevel messageLevel`
- `bool expected`

