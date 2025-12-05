---
title: "NullLogger"
description: "Simple null logger implementation for when no logger is provided"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/nulllogger/"
---

# NullLogger

```csharp
GridBuilding.Core.Services.Manipulation
class NullLogger
{
    // Members...
}
```

Simple null logger implementation for when no logger is provided

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Manipulation/ManipulationService.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### BeginScope

```csharp
public IDisposable BeginScope<TState>(TState state) => null;
```

**Returns:** `IDisposable`

**Parameters:**
- `TState state`

### IsEnabled

```csharp
public bool IsEnabled(LogLevel logLevel) => false;
```

**Returns:** `bool`

**Parameters:**
- `LogLevel logLevel`

### Log

```csharp
public void Log<TState>(LogLevel logLevel, EventId eventId, TState state, Exception exception, Func<TState, Exception, string> formatter)
        {
            // Do nothing - null logger
        }
```

**Returns:** `void`

**Parameters:**
- `LogLevel logLevel`
- `EventId eventId`
- `TState state`
- `Exception exception`
- `Func<TState, Exception, string> formatter`

