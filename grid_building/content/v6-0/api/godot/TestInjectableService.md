---
title: "TestInjectableService"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/testinjectableservice/"
---

# TestInjectableService

```csharp
GridBuilding.Godot.Tests.Base
class TestInjectableService
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

### Profiler

```csharp
public PerformanceProfiler? Profiler { get; private set; }
```

### IsInjected

```csharp
public bool IsInjected { get; private set; }
```


## Methods

### InjectDependencies

```csharp
public void InjectDependencies(CompositionContainer container)
        {
            if (container == null) throw new ArgumentNullException(nameof(container));
            
            Logger = container.GetService<ILogger>();
            Profiler = container.GetService<PerformanceProfiler>();
            IsInjected = true;
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
                result.Errors.Add("ILogger service not registered");
            }
            
            if (!container.IsServiceRegistered<PerformanceProfiler>())
            {
                result.IsValid = false;
                result.Errors.Add("PerformanceProfiler service not registered");
            }
            
            return result;
        }
```

**Returns:** `Core.Validation.ValidationResult`

**Parameters:**
- `CompositionContainer container`

