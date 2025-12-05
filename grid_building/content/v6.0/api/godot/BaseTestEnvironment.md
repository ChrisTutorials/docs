---
title: "BaseTestEnvironment"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/basetestenvironment/"
---

# BaseTestEnvironment

```csharp
GridBuilding.Godot.Test.Environments
class BaseTestEnvironment
{
    // Members...
}
```

Base class for all test environments
Provides common functionality for test environment setup and validation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Environments/BaseTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Test.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
#endregion

    #region Godot Lifecycle

    public override void _Ready()
    {
        base._Ready();
        InitializeEnvironment();
    }
```

**Returns:** `void`

### GetInjector

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Gets the InjectorSystem
    /// </summary>
    public InjectorSystem GetInjector() => _injector;
```

Gets the InjectorSystem

**Returns:** `InjectorSystem`

### GetContainer

```csharp
/// <summary>
    /// Gets the GBCompositionContainer
    /// </summary>
    public GBCompositionContainer GetContainer() => _container;
```

Gets the GBCompositionContainer

**Returns:** `GBCompositionContainer`

### GetWorld

```csharp
/// <summary>
    /// Gets the World system
    /// </summary>
    public World GetWorld() => _world;
```

Gets the World system

**Returns:** `World`

### IsInitialized

```csharp
/// <summary>
    /// Checks if the environment is initialized
    /// </summary>
    public bool IsInitialized() => _isInitialized;
```

Checks if the environment is initialized

**Returns:** `bool`

### GetIssues

```csharp
/// <summary>
    /// Gets validation issues for this environment
    /// </summary>
    public virtual List<string> GetIssues()
    {
        var issues = new List<string>();

        if (!_isInitialized)
        {
            issues.Add("Environment not initialized");
            return issues;
        }

        if (_injector == null)
            issues.Add("InjectorSystem is null");

        if (_container == null)
            issues.Add("GBCompositionContainer is null");

        if (_world == null)
            issues.Add("World is null");

        return issues;
    }
```

Gets validation issues for this environment

**Returns:** `List<string>`

### WaitForInitializationAsync

```csharp
/// <summary>
    /// Waits for environment initialization
    /// </summary>
    public async Task WaitForInitializationAsync()
    {
        if (_isInitialized)
            return;

        await ToSignal(this, SignalName.EnvironmentInitialized);
        ValidateInitialization();
    }
```

Waits for environment initialization

**Returns:** `Task`

