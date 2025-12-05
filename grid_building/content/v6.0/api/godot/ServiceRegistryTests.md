---
title: "ServiceRegistryTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/serviceregistrytests/"
---

# ServiceRegistryTests

```csharp
GridBuilding.Godot.Tests.Services.DI
class ServiceRegistryTests
{
    // Members...
}
```

Unit tests for ServiceRegistry pure C# implementation.
Tests the core DI registry functionality without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Services/DI/ServiceRegistryTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### RegisterSingleton_ShouldRegisterInstance

```csharp
#endregion

    #region Singleton Registration Tests

    [Fact]
    public void RegisterSingleton_ShouldRegisterInstance()
    {
        // Arrange
        var service = new TestService();

        // Act
        _registry.RegisterSingleton(service);

        // Assert
        ;
    }
```

**Returns:** `void`

### RegisterSingleton_ShouldReturnSameInstance

```csharp
[Fact]
    public void RegisterSingleton_ShouldReturnSameInstance()
    {
        // Arrange
        var service = new TestService();
        _registry.RegisterSingleton(service);

        // Act
        var retrieved1 = _registry.GetService<TestService>();
        var retrieved2 = _registry.GetService<TestService>();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### RegisterSingleton_ShouldAllowNullInstance

```csharp
[Fact]
    public void RegisterSingleton_ShouldAllowNullInstance()
    {
        // Act & Assert - Should not throw
        _registry.RegisterSingleton<TestService>(null!);
        
        // Should be registered but return null
        ;
        ;
    }
```

**Returns:** `void`

### RegisterFactory_ShouldRegisterFactory

```csharp
#endregion

    #region Factory Registration Tests

    [Fact]
    public void RegisterFactory_ShouldRegisterFactory()
    {
        // Arrange
        Func<TestService> factory = () => new TestService();

        // Act
        _registry.RegisterFactory(factory);

        // Assert
        ;
    }
```

**Returns:** `void`

### RegisterFactory_ShouldCreateNewInstanceEachTime

```csharp
[Fact]
    public void RegisterFactory_ShouldCreateNewInstanceEachTime()
    {
        // Arrange
        _registry.RegisterFactory(() => new TestService());

        // Act
        var service1 = _registry.GetService<TestService>();
        var service2 = _registry.GetService<TestService>();

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### RegisterFactory_ShouldThrowOnNullFactory

```csharp
[Fact]
    public void RegisterFactory_ShouldThrowOnNullFactory()
    {
        // Act & Assert
        Assert.Throws<ArgumentNullException>(() => 
            _registry.RegisterFactory<TestService>(null!));
    }
```

**Returns:** `void`

### RegisterScoped_ShouldRegisterScopedFactory

```csharp
#endregion

    #region Scoped Registration Tests

    [Fact]
    public void RegisterScoped_ShouldRegisterScopedFactory()
    {
        // Arrange
        Func<TestService> factory = () => new TestService();

        // Act
        _registry.RegisterScoped(factory);

        // Assert
        ;
    }
```

**Returns:** `void`

### RegisterScoped_ShouldCreateNewInstanceEachTime

```csharp
[Fact]
    public void RegisterScoped_ShouldCreateNewInstanceEachTime()
    {
        // Arrange
        _registry.RegisterScoped(() => new TestService());

        // Act
        var service1 = _registry.GetService<TestService>();
        var service2 = _registry.GetService<TestService>();

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### GetService_ShouldReturnRegisteredSingleton

```csharp
#endregion

    #region Service Resolution Tests

    [Fact]
    public void GetService_ShouldReturnRegisteredSingleton()
    {
        // Arrange
        var expectedService = new TestService();
        _registry.RegisterSingleton(expectedService);

        // Act
        var actualService = _registry.GetService<TestService>();

        // Assert
        ;
    }
```

**Returns:** `void`

### GetService_ShouldCreateFromFactory

```csharp
[Fact]
    public void GetService_ShouldCreateFromFactory()
    {
        // Arrange
        _registry.RegisterFactory(() => new TestService());

        // Act
        var service = _registry.GetService<TestService>();

        // Assert
        ;
        Assert.IsType<TestService>(service);
    }
```

**Returns:** `void`

### GetService_ShouldCreateFromScopedFactory

```csharp
[Fact]
    public void GetService_ShouldCreateFromScopedFactory()
    {
        // Arrange
        _registry.RegisterScoped(() => new TestService());

        // Act
        var service = _registry.GetService<TestService>();

        // Assert
        ;
        Assert.IsType<TestService>(service);
    }
```

**Returns:** `void`

### GetService_ShouldThrowForUnregisteredService

```csharp
[Fact]
    public void GetService_ShouldThrowForUnregisteredService()
    {
        // Act & Assert
        Assert.Throws<ServiceNotRegisteredException>(() => 
            _registry.GetService<TestService>());
    }
```

**Returns:** `void`

### GetService_ShouldThrowForNullFactory

```csharp
[Fact]
    public void GetService_ShouldThrowForNullFactory()
    {
        // Arrange
        _registry.RegisterFactory<TestService>(() => null!);

        // Act & Assert
        Assert.Throws<ServiceRegistrationException>(() => 
            _registry.GetService<TestService>());
    }
```

**Returns:** `void`

### IsRegistered_ShouldReturnTrueForRegisteredServices

```csharp
#endregion

    #region Registration Status Tests

    [Fact]
    public void IsRegistered_ShouldReturnTrueForRegisteredServices()
    {
        // Arrange
        _registry.RegisterSingleton(new TestService());
        _registry.RegisterFactory(() => new AnotherTestService());
        _registry.RegisterScoped(() => new YetAnotherTestService());

        // Act & Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### IsRegistered_ShouldReturnFalseForUnregisteredServices

```csharp
[Fact]
    public void IsRegistered_ShouldReturnFalseForUnregisteredServices()
    {
        // Act & Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

### ValidateServices_ShouldNotThrowForAllRegistered

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void ValidateServices_ShouldNotThrowForAllRegistered()
    {
        // Arrange
        _registry.RegisterSingleton(new TestService());
        _registry.RegisterFactory(() => new AnotherTestService());
        _registry.RegisterScoped(() => new YetAnotherTestService());

        // Act & Assert - Should not throw
        _registry.ValidateServices(
            typeof(TestService),
            typeof(AnotherTestService),
            typeof(YetAnotherTestService));
    }
```

**Returns:** `void`

### ValidateServices_ShouldThrowForMissingServices

```csharp
[Fact]
    public void ValidateServices_ShouldThrowForMissingServices()
    {
        // Arrange
        _registry.RegisterSingleton(new TestService());
        // Missing AnotherTestService and YetAnotherTestService

        // Act & Assert
        Assert.Throws<ServiceRegistrationException>(() => 
            _registry.ValidateServices(
                typeof(TestService),
                typeof(AnotherTestService),
                typeof(YetAnotherTestService)));
    }
```

**Returns:** `void`

### Clear_ShouldRemoveAllRegistrations

```csharp
#endregion

    #region Clear Tests

    [Fact]
    public void Clear_ShouldRemoveAllRegistrations()
    {
        // Arrange
        _registry.RegisterSingleton(new TestService());
        _registry.RegisterFactory(() => new AnotherTestService());
        ;
        ;

        // Act
        _registry.Clear();

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### Dispose_ShouldDisposeDisposableServices

```csharp
#endregion

    #region Dispose Tests

    [Fact]
    public void Dispose_ShouldDisposeDisposableServices()
    {
        // Arrange
        var disposableService = new DisposableTestService();
        _registry.RegisterSingleton(disposableService);

        // Act
        _registry.Dispose();

        // Assert
        ;
    }
```

**Returns:** `void`

### Dispose_ShouldClearRegistrations

```csharp
[Fact]
    public void Dispose_ShouldClearRegistrations()
    {
        // Arrange
        _registry.RegisterSingleton(new TestService());
        ;

        // Act
        _registry.Dispose();

        // Assert
        ;
    }
```

**Returns:** `void`

### Dispose_CanBeCalledMultipleTimes

```csharp
[Fact]
    public void Dispose_CanBeCalledMultipleTimes()
    {
        // Arrange
        _registry.RegisterSingleton(new TestService());

        // Act & Assert - Should not throw
        _registry.Dispose();
        _registry.Dispose();
        _registry.Dispose();
    }
```

**Returns:** `void`

### MultipleRegistrations_ShouldOverridePrevious

```csharp
#endregion

    #region Multiple Registration Tests

    [Fact]
    public void MultipleRegistrations_ShouldOverridePrevious()
    {
        // Arrange
        var service1 = new TestService();
        var service2 = new TestService();
        
        _registry.RegisterSingleton(service1);
        ;

        // Act
        _registry.RegisterSingleton(service2);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### MixedRegistrationTypes_ShouldWork

```csharp
[Fact]
    public void MixedRegistrationTypes_ShouldWork()
    {
        // Arrange
        _registry.RegisterSingleton(new TestService());
        _registry.RegisterFactory(() => new AnotherTestService());
        _registry.RegisterScoped(() => new YetAnotherTestService());

        // Act & Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

