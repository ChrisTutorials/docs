---
title: "OptionalDependencyService"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/optionaldependencyservice/"
---

# OptionalDependencyService

```csharp
GridBuilding.Godot.Tests.Base
class OptionalDependencyService
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

### OptionalService

```csharp
public IOptionalService? OptionalService { get; private set; }
```

### HasRequiredDependencies

```csharp
public bool HasRequiredDependencies => Logger != null;
```


## Methods

### InjectDependencies

```csharp
public void InjectDependencies(CompositionContainer container)
        {
            if (container == null) throw new ArgumentNullException(nameof(container));
            
            Logger = container.GetService<ILogger>();
            // Optional service - try get but don't fail if missing
            if (container.IsServiceRegistered<IOptionalService>())
            {
                OptionalService = container.GetService<IOptionalService>();
            }
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
            
            if (!container.IsServiceRegistered<ILogger>())
            {
                result.IsValid = false;
                result.Errors.Add("Required ILogger service not registered");
            }
            else
            {
                result.IsValid = true;
            }
            
            return result;
        }
```

**Returns:** `Core.Validation.ValidationResult`

**Parameters:**
- `CompositionContainer container`

