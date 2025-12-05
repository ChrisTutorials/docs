---
title: "LazyInjectableService"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/lazyinjectableservice/"
---

# LazyInjectableService

```csharp
GridBuilding.Godot.Tests.Base
class LazyInjectableService
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

### IsInitialized

```csharp
public bool IsInitialized { get; private set; }
```


## Methods

### InjectDependencies

```csharp
public void InjectDependencies(CompositionContainer container)
        {
            if (container == null) throw new ArgumentNullException(nameof(container));
            
            Logger = container.GetService<ILogger>();
            IsInitialized = true;
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

