---
title: "IPlacementService"
description: "Enhanced placement service interface for agnostic object placement.
This service handles placement, removal, and movement of any placeable objects
(buildings, pickups, items, etc.) without Godot dependencies. It provides clean
separation between core placement algorithms and engine-specific presentation.
## Responsibilities:
- Validate placement rules and constraints
- Execute placement operations (business logic only)
- Manage object removal and movement
- Handle agnostic object types (buildings, pickups, items)
- Provide placement diagnostics and reporting
## Non-Responsibilities:
- Scene instantiation or node management (handled by ISceneService)
- Visual indicators or UI feedback (handled by IIndicatorService)
- Object health/damage management (out of scope for placement)
- Godot-specific operations or engine integration
## Owner Resolution:
The placer/owner can be resolved from the service's OwnerContext rather than
being passed explicitly. Pass null to use the context's current owner."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/iplacementservice/"
---

# IPlacementService

```csharp
GridBuilding.Core.Services.Placement
interface IPlacementService
{
    // Members...
}
```

Enhanced placement service interface for agnostic object placement.
This service handles placement, removal, and movement of any placeable objects
(buildings, pickups, items, etc.) without Godot dependencies. It provides clean
separation between core placement algorithms and engine-specific presentation.
## Responsibilities:
- Validate placement rules and constraints
- Execute placement operations (business logic only)
- Manage object removal and movement
- Handle agnostic object types (buildings, pickups, items)
- Provide placement diagnostics and reporting
## Non-Responsibilities:
- Scene instantiation or node management (handled by ISceneService)
- Visual indicators or UI feedback (handled by IIndicatorService)
- Object health/damage management (out of scope for placement)
- Godot-specific operations or engine integration
## Owner Resolution:
The placer/owner can be resolved from the service's OwnerContext rather than
being passed explicitly. Pass null to use the context's current owner.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Placement/IPlacementService.cs`  
**Namespace:** `GridBuilding.Core.Services.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.

