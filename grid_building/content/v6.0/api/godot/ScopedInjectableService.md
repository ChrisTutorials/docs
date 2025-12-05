---
title: "ScopedInjectableService"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/scopedinjectableservice/"
---

# ScopedInjectableService

```csharp
GridBuilding.Godot.Tests.Base
class ScopedInjectableService
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/InjectablePatternTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Base`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingService

```csharp
public BuildingService? BuildingService { get; private set; }
```

### ManipulationService

```csharp
public ManipulationService? ManipulationService { get; private set; }
```


## Methods

### InjectDependencies

```csharp
public void InjectDependencies(CompositionContainer container)
        {
            if (container == null) throw new ArgumentNullException(nameof(container));
            
            BuildingService = container.GetService<BuildingService>();
            ManipulationService = container.GetService<ManipulationService>();
        }
```

**Returns:** `void`

**Parameters:**
- `CompositionContainer container`

### ValidateDependencies

```csharp
public Core.Validation.ValidationResult ValidateDependencies(CompositionContainer container)
        {
            var result = new Core.Validation.ValidationResult();
            
            if (!container.IsServiceRegistered<BuildingService>())
                result.Errors.Add("BuildingService not registered");
            
            if (!container.IsServiceRegistered<ManipulationService>())
                result.Errors.Add("ManipulationService not registered");
            
            result.IsValid = result.Errors.Count == 0;
            return result;
        }
```

**Returns:** `Core.Validation.ValidationResult`

**Parameters:**
- `CompositionContainer container`

