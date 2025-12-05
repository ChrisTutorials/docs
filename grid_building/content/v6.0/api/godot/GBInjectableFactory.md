---
title: "GBInjectableFactory"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gbinjectablefactory/"
---

# GBInjectableFactory

```csharp
GridBuilding.Godot.Core.Factories
class GBInjectableFactory
{
    // Members...
}
```

Factory for creating and injecting RefCounted objects with dependencies.
Provides centralized creation of RefCounted objects that need dependency injection
since they cannot be automatically discovered by the InjectorSystem.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Infrastructure/InjectableFactory.cs`  
**Namespace:** `GridBuilding.Godot.Core.Factories`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateCollisionMapper

```csharp
/// <summary>
    /// Creates and injects a CollisionMapper with dependencies.
    /// </summary>
    /// <param name="container">The composition container containing dependencies</param>
    /// <returns>Configured CollisionMapper instance</returns>
    public static CollisionMapper CreateCollisionMapper(CompositionContainer container)
    {
        var targetingState = container.GetTargetingState();
        var logger = container.GetLogger();
        var mapper = new CollisionMapper(targetingState, logger);

        // Validate dependencies were properly injected
        var issues = mapper.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            logger.LogWarnings(issues);
        }

        return mapper;
    }
```

Creates and injects a CollisionMapper with dependencies.

**Returns:** `CollisionMapper`

**Parameters:**
- `CompositionContainer container`

### CreateIndicatorService

```csharp
/// <summary>
    /// Creates and injects an IndicatorService with dependencies.
    /// </summary>
    /// <param name="container">The composition container containing dependencies</param>
    /// <param name="parent">The parent node for indicators (required - cannot be resolved from container)</param>
    /// <returns>Configured IndicatorService instance</returns>
    public static IndicatorService CreateIndicatorService(CompositionContainer container, Node2D parent)
    {
        var targetingState = container.GetTargetingState();
        var logger = container.GetLogger();
        var indicatorTemplate = container.GetTemplates().RuleCheckIndicator;
        var manager = new IndicatorService(parent, targetingState, indicatorTemplate, logger);

        // Inject dependencies into the manager itself
        manager.ResolveGBDependencies(container);

        // Validate dependencies were properly injected
        var issues = manager.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            logger.LogWarnings(issues);
        }

        return manager;
    }
```

Creates and injects an IndicatorService with dependencies.

**Returns:** `IndicatorService`

**Parameters:**
- `CompositionContainer container`
- `Node2D parent`

### CreatePlacementValidator

```csharp
/// <summary>
    /// Creates and injects a PlacementValidator with dependencies.
    /// </summary>
    /// <param name="container">The composition container containing dependencies</param>
    /// <returns>Configured PlacementValidator instance</returns>
    public static PlacementValidator CreatePlacementValidator(CompositionContainer container)
    {
        var logger = container.GetLogger();
        var baseRules = container.GetPlacementRules();
        var validator = new PlacementValidator(baseRules, logger);

        // Inject dependencies
        validator.ResolveGBDependencies(container);

        // Validate dependencies were properly injected
        var issues = validator.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            logger.LogWarnings(issues);
        }

        return validator;
    }
```

Creates and injects a PlacementValidator with dependencies.

**Returns:** `PlacementValidator`

**Parameters:**
- `CompositionContainer container`

### CreateTestSetupFactory

```csharp
/// <summary>
    /// Creates and injects a PlacementScenarioFactory with dependencies.
    /// </summary>
    /// <param name="container">The composition container containing dependencies</param>
    /// <returns>Configured PlacementScenarioFactory instance</returns>
    public static PlacementScenarioFactory CreateTestSetupFactory(CompositionContainer container)
    {
        var targetingState = container.GetTargetingState();
        var logger = container.GetLogger();
        var factory = new PlacementScenarioFactory(targetingState, logger);

        // Validate dependencies were properly injected
        var issues = factory.GetRuntimeIssues();
        if (issues.Count > 0)
        {
            logger.LogWarnings(issues);
        }

        return factory;
    }
```

Creates and injects a PlacementScenarioFactory with dependencies.

**Returns:** `PlacementScenarioFactory`

**Parameters:**
- `CompositionContainer container`

