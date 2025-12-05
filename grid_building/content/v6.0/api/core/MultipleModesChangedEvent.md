---
title: "MultipleModesChangedEvent"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/multiplemodeschangedevent/"
---

# MultipleModesChangedEvent

```csharp
GridBuilding.Core.State.Mode
class MultipleModesChangedEvent
{
    // Members...
}
```

Event fired when multiple modes change simultaneously

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/Mode/ModeEvents.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OldApplicationMode

```csharp
public ApplicationMode? OldApplicationMode { get; }
```

### NewApplicationMode

```csharp
public ApplicationMode? NewApplicationMode { get; }
```

### OldUIMode

```csharp
public UIMode? OldUIMode { get; }
```

### NewUIMode

```csharp
public UIMode? NewUIMode { get; }
```

### OldEditMode

```csharp
public EditMode? OldEditMode { get; }
```

### NewEditMode

```csharp
public EditMode? NewEditMode { get; }
```

### OldViewMode

```csharp
public ViewMode? OldViewMode { get; }
```

### NewViewMode

```csharp
public ViewMode? NewViewMode { get; }
```

### OldGameMode

```csharp
public GameMode? OldGameMode { get; }
```

### NewGameMode

```csharp
public GameMode? NewGameMode { get; }
```

