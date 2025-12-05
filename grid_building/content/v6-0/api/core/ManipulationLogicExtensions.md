---
title: "ManipulationLogicExtensions"
description: "Extension methods for working with LogicBlocks states and commands"
weight: 10
url: "/gridbuilding/v6-0/api/core/manipulationlogicextensions/"
---

# ManipulationLogicExtensions

```csharp
GridBuilding.Core.State.Manipulation
class ManipulationLogicExtensions
{
    // Members...
}
```

Extension methods for working with LogicBlocks states and commands

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Manipulation/ManipulationCommands.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### With

```csharp
/// <summary>
        /// Attach a command to a state
        /// </summary>
        public static T With<T>(this T state, IManipulationCommand command) where T : ManipulationState
        {
            return state with { Command = command };
        }
```

Attach a command to a state

**Returns:** `T`

**Parameters:**
- `T state`
- `IManipulationCommand command`

### GetCommand

```csharp
/// <summary>
        /// Get the command from a state, safely typed
        /// </summary>
        public static T? GetCommand<T>(this ManipulationState state) where T : class, IManipulationCommand
        {
            return state.Command as T;
        }
```

Get the command from a state, safely typed

**Returns:** `T?`

**Parameters:**
- `ManipulationState state`

### HasCommand

```csharp
/// <summary>
        /// Check if state has a specific command type
        /// </summary>
        public static bool HasCommand<T>(this ManipulationState state) where T : class, IManipulationCommand
        {
            return state.Command is T;
        }
```

Check if state has a specific command type

**Returns:** `bool`

**Parameters:**
- `ManipulationState state`

