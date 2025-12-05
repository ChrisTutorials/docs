---
title: "ManipulationStateBase"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/manipulationstatebase/"
---

# ManipulationStateBase

```csharp
GridBuilding.Core.State.Manipulation
class ManipulationStateBase
{
    // Members...
}
```

Base class for all manipulation states
Provides common state machine functionality

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Manipulation/ManipulationStateBase.cs`  
**Namespace:** `GridBuilding.Core.State.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Initialize

```csharp
public virtual void Initialize(ManipulationStateMachine stateMachine)
        {
            StateMachine = stateMachine;
        }
```

**Returns:** `void`

**Parameters:**
- `ManipulationStateMachine stateMachine`

### EnterState

```csharp
public virtual void EnterState()
        {
            // Base implementation - can be overridden
        }
```

**Returns:** `void`

### ExitState

```csharp
public virtual void ExitState()
        {
            // Base implementation - can be overridden
        }
```

**Returns:** `void`

### HandleInput

```csharp
public virtual void HandleInput(InputEventData inputEvent)
        {
            // Base input handling - can be overridden
        }
```

**Returns:** `void`

**Parameters:**
- `InputEventData inputEvent`

### Update

```csharp
public virtual void Update(float deltaTime)
        {
            // Base update logic - can be overridden
        }
```

**Returns:** `void`

**Parameters:**
- `float deltaTime`

### UpdateState

```csharp
public virtual void UpdateState(double currentTime)
        {
            // Base state update - can be overridden
        }
```

**Returns:** `void`

**Parameters:**
- `double currentTime`

