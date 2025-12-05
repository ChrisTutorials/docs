---
title: "ISceneService"
description: "Godot-specific scene service interface for engine operations.
This service handles all Godot-specific operations that core services
cannot perform, such as scene instantiation, node management, and
engine integration. It provides a clean abstraction layer between
pure C# business logic and Godot presentation concerns.
## Responsibilities:
- Scene instantiation from PackedScene resources
- Node parenting and hierarchy management
- Scene lifecycle management (creation/destruction)
- Godot-specific error handling and logging
## Non-Responsibilities:
- Business logic or validation rules (handled by core services)
- Placement validation or collision detection
- Game state management or decision making"
weight: 20
url: "/gridbuilding/v6-0/api/godot/isceneservice/"
---

# ISceneService

```csharp
GridBuilding.Godot.Services.Placement
interface ISceneService
{
    // Members...
}
```

Godot-specific scene service interface for engine operations.
This service handles all Godot-specific operations that core services
cannot perform, such as scene instantiation, node management, and
engine integration. It provides a clean abstraction layer between
pure C# business logic and Godot presentation concerns.
## Responsibilities:
- Scene instantiation from PackedScene resources
- Node parenting and hierarchy management
- Scene lifecycle management (creation/destruction)
- Godot-specific error handling and logging
## Non-Responsibilities:
- Business logic or validation rules (handled by core services)
- Placement validation or collision detection
- Game state management or decision making

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Services/Placement/ISceneService.cs`  
**Namespace:** `GridBuilding.Godot.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.

