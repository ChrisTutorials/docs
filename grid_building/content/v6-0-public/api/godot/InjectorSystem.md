---
title: "InjectorSystem"
description: "OBSOLETE: Legacy InjectorSystem - Use modern CompositionContainer instead.
This system is deprecated and will be removed in a future version.
Migration Guide:
OLD: Add InjectorSystem node to scene
NEW: Use CompositionContainer.ConfigureServices() and manual injection
For new development, use:
- CompositionContainer from GridBuilding.Godot.Services.DI
- IInjectable interface for dependency injection
- ServiceRegistry for service registration"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/injectorsystem/"
---

# InjectorSystem

```csharp
GridBuilding.Godot.Systems.Injection
class InjectorSystem
{
    // Members...
}
```

OBSOLETE: Legacy InjectorSystem - Use modern CompositionContainer instead.
This system is deprecated and will be removed in a future version.
Migration Guide:
OLD: Add InjectorSystem node to scene
NEW: Use CompositionContainer.ConfigureServices() and manual injection
For new development, use:
- CompositionContainer from GridBuilding.Godot.Services.DI
- IInjectable interface for dependency injection
- ServiceRegistry for service registration

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/InjectorSystem.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Injection`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### CompositionContainer

```csharp
/// <summary>
    /// DO NOT USE - This system is obsolete.
    /// Use CompositionContainer.Instance.GetService<T>() instead.
    /// </summary>
    [Export]
    public Resource? CompositionContainer { get; set; }
```

DO NOT USE - This system is obsolete.
Use CompositionContainer.Instance.GetService<T>() instead.


## Methods

### _Ready

```csharp
public override void _Ready()
    {
        GD.PushWarning("InjectorSystem is deprecated. Please migrate to CompositionContainer pattern.");
        GD.Print("See migration guide: /docs/architecture/GB_INJECTOR_DEPRECATION_MIGRATION_PLAN.md");
        
        // Disable this system
        SetProcess(false);
        SetPhysicsProcess(false);
    }
```

**Returns:** `void`

