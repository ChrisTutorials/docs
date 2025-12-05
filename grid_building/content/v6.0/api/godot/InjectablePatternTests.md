---
title: "InjectablePatternTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/injectablepatterntests/"
---

# InjectablePatternTests

```csharp
GridBuilding.Godot.Tests.Base
class InjectablePatternTests
{
    // Members...
}
```

Unit tests for pure C# Injectable pattern.
Replaces Injectable tests with modern dependency injection pattern testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/InjectablePatternTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Base`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Injectable_ShouldResolveDependenciesFromContainer

```csharp
#endregion

    #region Basic Injectable Pattern Tests

    [Theory]
    [InlineData(typeof(TestInjectableService))]
    [InlineData(typeof(LazyInjectableService))]
    [InlineData(typeof(SingletonInjectableService))]
    public void Injectable_ShouldResolveDependenciesFromContainer(Type serviceType)
    {
        // Arrange
        var injectableService = (IInjectable)Activator.CreateInstance(serviceType)!;

        // Act
        injectableService.InjectDependencies(_container);

        // Assert
        var validationResult = injectableService.ValidateDependencies(_container);
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `Type serviceType`

### Injectable_ShouldValidateRequiredDependencies

```csharp
[Theory]
    [InlineData(typeof(TestInjectableService), true)]
    [InlineData(typeof(OptionalDependencyService), true)]
    [InlineData(typeof(ScopedInjectableService), true)]
    public void Injectable_ShouldValidateRequiredDependencies(Type serviceType, bool shouldValidate)
    {
        // Arrange
        var injectableService = (IInjectable)Activator.CreateInstance(serviceType)!;

        // Act
        var validationResult = injectableService.ValidateDependencies(_container);

        // Assert
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `Type serviceType`
- `bool shouldValidate`

### Injectable_ShouldInjectSpecificDependencies

```csharp
[Theory]
    [InlineData(typeof(TestInjectableService), "Logger")]
    [InlineData(typeof(TestInjectableService), "Profiler")]
    [InlineData(typeof(LazyInjectableService), "Logger")]
    [InlineData(typeof(ConfigurationAwareService), "Configuration")]
    public void Injectable_ShouldInjectSpecificDependencies(Type serviceType, string dependencyProperty)
    {
        // Arrange
        var injectableService = (IInjectable)Activator.CreateInstance(serviceType)!;

        // Act
        injectableService.InjectDependencies(_container);

        // Assert
        var property = serviceType.GetProperty(dependencyProperty);
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `Type serviceType`
- `string dependencyProperty`

### Injectable_ShouldSupportLazyInitialization

```csharp
#endregion

    #region Service Lifecycle Tests

    [Fact]
    public void Injectable_ShouldSupportLazyInitialization()
    {
        // Arrange
        var injectableService = new LazyInjectableService();

        // Act
        ;
        injectableService.InjectDependencies(_container);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### Injectable_ShouldHandleOptionalDependencies

```csharp
[Fact]
    public void Injectable_ShouldHandleOptionalDependencies()
    {
        // Arrange
        var injectableService = new OptionalDependencyService();

        // Act
        injectableService.InjectDependencies(_container);

        // Assert
        ; // Required dependency
        ; // Optional dependency
        ;
    }
```

**Returns:** `void`

### Injectable_ShouldSupportScopedServices

```csharp
#endregion

    #region Multiplayer Safety Tests

    [Fact]
    public void Injectable_ShouldSupportScopedServices()
    {
        // Arrange
        var injectableService = new ScopedInjectableService();

        // Act
        injectableService.InjectDependencies(_container);

        // Assert
        ;
        ;
        
        // These should be scoped services (different instances per request)
        var buildingService1 = _container.GetService<BuildingService>();
        var buildingService2 = _container.GetService<BuildingService>();
        ;
    }
```

**Returns:** `void`

### Injectable_ShouldMaintainSingletonReferences

```csharp
[Fact]
    public void Injectable_ShouldMaintainSingletonReferences()
    {
        // Arrange
        var injectableService = new SingletonInjectableService();

        // Act
        injectableService.InjectDependencies(_container);

        // Assert
        var logger1 = injectableService.Logger;
        var logger2 = _container.GetService<ILogger>();
        ; // Should be same singleton instance
    }
```

**Returns:** `void`

### Injectable_ShouldIntegrateWithConfiguration

```csharp
#endregion

    #region Configuration Integration Tests

    [Fact]
    public void Injectable_ShouldIntegrateWithConfiguration()
    {
        // Arrange
        var injectableService = new ConfigurationAwareService();

        // Act
        injectableService.InjectDependencies(_container);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### Injectable_ShouldRespondToConfigurationChanges

```csharp
[Fact]
    public void Injectable_ShouldRespondToConfigurationChanges()
    {
        // Arrange
        var injectableService = new ConfigurationAwareService();
        injectableService.InjectDependencies(_container);

        // Act
        var newConfig = new Core.Configuration.GameConfiguration
        {
            ConfigurationId = "updated-config",
            ConfigurationName = "Updated Configuration"
        };

        injectableService.UpdateConfiguration(newConfig);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### Injectable_ShouldHandleNullContainer

```csharp
#endregion

    #region Error Handling Tests

    [Fact]
    public void Injectable_ShouldHandleNullContainer()
    {
        // Arrange
        var injectableService = new TestInjectableService();

        // Act & Assert
        Assert.Throws<ArgumentNullException>(() => 
            injectableService.InjectDependencies(null!));
    }
```

**Returns:** `void`

### Injectable_ShouldProvideClearErrorMessages

```csharp
[Fact]
    public void Injectable_ShouldProvideClearErrorMessages()
    {
        // Arrange
        var emptyContainer = new CompositionContainer();
        emptyContainer.Initialize();
        var injectableService = new TestInjectableService();

        // Act
        var validationResult = injectableService.ValidateDependencies(emptyContainer);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### Injectable_ShouldInjectDependenciesQuickly

```csharp
#endregion

    #region Performance Tests

    [Fact]
    public void Injectable_ShouldInjectDependenciesQuickly()
    {
        // Arrange
        var stopwatch = System.Diagnostics.Stopwatch.StartNew();
        var services = new List<TestInjectableService>();

        // Act
        for (int i = 0; i < 100; i++)
        {
            var service = new TestInjectableService();
            service.InjectDependencies(_container);
            services.Add(service);
        }

        stopwatch.Stop();

        // Assert
        ;
        
        // Verify all services were properly injected
        ;
    }
```

**Returns:** `void`

### Injectable_ShouldNotCreateMemoryLeaks

```csharp
[Fact]
    public void Injectable_ShouldNotCreateMemoryLeaks()
    {
        // Arrange
        var initialMemory = GC.GetTotalMemory(true);

        // Act
        for (int i = 0; i < 1000; i++)
        {
            var service = new TestInjectableService();
            service.InjectDependencies(_container);
            // Service goes out of scope
        }

        GC.Collect();
        GC.WaitForPendingFinalizers();
        GC.Collect();

        var finalMemory = GC.GetTotalMemory(true);

        // Assert
        var memoryIncrease = finalMemory - initialMemory;
        ;
    }
```

**Returns:** `void`

### Injectable_ShouldSupportHierarchicalDependencies

```csharp
#endregion

    #region Advanced Pattern Tests

    [Fact]
    public void Injectable_ShouldSupportHierarchicalDependencies()
    {
        // Arrange
        var parentService = new ParentInjectableService();
        var childService = new ChildInjectableService();

        // Act
        parentService.InjectDependencies(_container);
        childService.InjectDependencies(_container);

        // Assert
        ;
        ;
        
        // Both should get the same singleton logger
        ;
    }
```

**Returns:** `void`

### Injectable_ShouldSupportCircularDependencyDetection

```csharp
[Fact]
    public void Injectable_ShouldSupportCircularDependencyDetection()
    {
        // Arrange
        var serviceA = new CircularServiceA();
        var serviceB = new CircularServiceB();

        // Act
        serviceA.InjectDependencies(_container);
        serviceB.InjectDependencies(_container);

        // Assert - Should handle gracefully without infinite recursion
        ;
        ;
    }
```

**Returns:** `void`

