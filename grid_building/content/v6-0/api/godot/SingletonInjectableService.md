---
title: "SingletonInjectableService"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/singletoninjectableservice/"
---

# SingletonInjectableService

```csharp
GridBuilding.Godot.Tests.Base
class SingletonInjectableService
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

### Logger

```csharp
public ILogger? Logger { get; private set; }
```


## Methods

### InjectDependencies

```csharp
public void InjectDependencies(CompositionContainer container)
        {
            if (container == null) throw new ArgumentNullException(nameof(container));
            
            Logger = container.GetService<ILogger>();
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
            result.IsValid = container.IsServiceRegistered<ILogger>();
            if (!result.IsValid)
                result.Errors.Add("ILogger service not registered");
            return result;
        }
```

**Returns:** `Core.Validation.ValidationResult`

**Parameters:**
- `CompositionContainer container`

