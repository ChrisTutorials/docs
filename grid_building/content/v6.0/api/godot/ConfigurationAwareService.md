---
title: "ConfigurationAwareService"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/configurationawareservice/"
---

# ConfigurationAwareService

```csharp
GridBuilding.Godot.Tests.Base
class ConfigurationAwareService
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

### Configuration

```csharp
public Core.Configuration.IGameConfiguration? Configuration { get; private set; }
```

### IsConfigurationLoaded

```csharp
public bool IsConfigurationLoaded { get; private set; }
```

### ConfigurationChanged

```csharp
public bool ConfigurationChanged { get; private set; }
```


## Methods

### InjectDependencies

```csharp
public void InjectDependencies(CompositionContainer container)
        {
            if (container == null) throw new ArgumentNullException(nameof(container));
            
            Configuration = container.GetCurrentConfiguration();
            IsConfigurationLoaded = true;
        }
```

**Returns:** `void`

**Parameters:**
- `CompositionContainer container`

### UpdateConfiguration

```csharp
public void UpdateConfiguration(Core.Configuration.IGameConfiguration newConfig)
        {
            Configuration = newConfig;
            ConfigurationChanged = true;
        }
```

**Returns:** `void`

**Parameters:**
- `Core.Configuration.IGameConfiguration newConfig`

### ValidateDependencies

```csharp
public Core.Validation.ValidationResult ValidateDependencies(CompositionContainer container)
        {
            var result = new Core.Validation.ValidationResult();
            result.IsValid = true; // Configuration is always available
            return result;
        }
```

**Returns:** `Core.Validation.ValidationResult`

**Parameters:**
- `CompositionContainer container`

