---
title: "ServiceFactoryTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/servicefactorytests/"
---

# ServiceFactoryTests

```csharp
GridBuilding.Godot.Tests.Services.DI
class ServiceFactoryTests
{
    // Members...
}
```

Unit tests for service factory patterns in pure C# DI system.
Replaces GBInjectableFactory tests with modern factory pattern testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Services/DI/ServiceFactoryTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Factory_ShouldCreateNewInstancesEachTime

```csharp
#endregion

    #region Factory Registration Tests

    [Theory]
    [InlineData(typeof(GridCalculator))]
    [InlineData(typeof(GeometryCache))]
    [InlineData(typeof(Core.Services.DI.PlacementValidator))]
    public void Factory_ShouldCreateNewInstancesEachTime(Type serviceType)
    {
        // Act
        var service1 = _container.GetService(serviceType);
        var service2 = _container.GetService(serviceType);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `Type serviceType`

### Factory_ShouldCreateValidInstances

```csharp
[Theory]
    [InlineData(typeof(GridCalculator), "IsInitialized")]
    [InlineData(typeof(Core.Services.DI.PlacementValidator), "IsInitialized")]
    [InlineData(typeof(GeometryCache), "IsInitialized")]
    public void Factory_ShouldCreateValidInstances(Type serviceType, string validationProperty)
    {
        // Act
        var service = _container.GetService(serviceType);

        // Assert
        ;
        
        // Verify instances are properly initialized using reflection
        var property = serviceType.GetProperty(validationProperty);
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `Type serviceType`
- `string validationProperty`

### Factory_ShouldSupportParameterizedCreation

```csharp
[Theory]
    [InlineData(100, 100, 32, 32)]
    [InlineData(200, 150, 64, 64)]
    [InlineData(0, 0, 16, 16)]
    public void Factory_ShouldSupportParameterizedCreation(int worldX, int worldY, int gridX, int gridY)
    {
        // Act
        var calculator = _container.GetService<GridCalculator>();
        var result = calculator.CalculateGridPosition(new Godot.Vector2(worldX, worldY), new Godot.Vector2I(gridX, gridY));

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

**Parameters:**
- `int worldX`
- `int worldY`
- `int gridX`
- `int gridY`

### ScopedFactory_ShouldCreateContextualInstances

```csharp
#endregion

    #region Scoped Factory Tests

    [Fact]
    public void ScopedFactory_ShouldCreateContextualInstances()
    {
        // Act
        var buildingService1 = _container.GetService<BuildingService>();
        var buildingService2 = _container.GetService<BuildingService>();

        // Assert
        ;
        ;
        ;
        
        // Each should have its own context
        ;
    }
```

**Returns:** `void`

### ScopedFactory_ShouldMaintainServiceDependencies

```csharp
[Fact]
    public void ScopedFactory_ShouldMaintainServiceDependencies()
    {
        // Act
        var buildingService = _container.GetService<BuildingService>();
        var manipulationService = _container.GetService<ManipulationService>();

        // Assert
        ;
        ;
        
        // Services should have access to shared dependencies
        ;
        ;
    }
```

**Returns:** `void`

### Factory_ShouldCreateInstancesQuickly

```csharp
#endregion

    #region Factory Performance Tests

    [Fact]
    public void Factory_ShouldCreateInstancesQuickly()
    {
        // Arrange
        var stopwatch = System.Diagnostics.Stopwatch.StartNew();

        // Act
        for (int i = 0; i < 100; i++)
        {
            var calculator = _container.GetService<GridCalculator>();
            ;
        }

        stopwatch.Stop();

        // Assert - Should create 100 instances quickly
        ;
    }
```

**Returns:** `void`

### Factory_ShouldNotLeakMemory

```csharp
[Fact]
    public void Factory_ShouldNotLeakMemory()
    {
        // Arrange
        var initialMemory = GC.GetTotalMemory(true);

        // Act
        for (int i = 0; i < 1000; i++)
        {
            var calculator = _container.GetService<GridCalculator>();
            // Let instances go out of scope
        }

        GC.Collect();
        GC.WaitForPendingFinalizers();
        GC.Collect();

        var finalMemory = GC.GetTotalMemory(true);

        // Assert - Memory usage should not grow significantly
        var memoryIncrease = finalMemory - initialMemory;
        ;
    }
```

**Returns:** `void`

### Factory_ShouldHandleCreationFailures

```csharp
#endregion

    #region Factory Error Handling Tests

    [Fact]
    public void Factory_ShouldHandleCreationFailures()
    {
        // Arrange - Test with a service that might fail during creation
        // (Our current implementation prevents this, but test the pattern)

        // Act & Assert
        var service = _container.GetService<GridCalculator>();
        ;
    }
```

**Returns:** `void`

### Factory_ShouldValidateServiceContracts

```csharp
[Fact]
    public void Factory_ShouldValidateServiceContracts()
    {
        // Act
        var calculator = _container.GetService<GridCalculator>();
        var validator = _container.GetService<Core.Services.DI.PlacementValidator>();

        // Assert
        ;
        ;
        
        // Verify services implement expected interfaces
        ;
        ;
    }
```

**Returns:** `void`

### Factory_ShouldIntegrateWithConfiguration

```csharp
#endregion

    #region Factory Integration Tests

    [Fact]
    public void Factory_ShouldIntegrateWithConfiguration()
    {
        // Act
        var config = _container.GetCurrentConfiguration();
        var calculator = _container.GetService<GridCalculator>();

        // Assert
        ;
        ;
        
        // Factory should respect configuration settings
        ;
    }
```

**Returns:** `void`

### Factory_ShouldSupportLazyInitialization

```csharp
[Fact]
    public void Factory_ShouldSupportLazyInitialization()
    {
        // Act
        var container = new CompositionContainer();
        container.Initialize();

        // Services should only be created when first accessed
        ;

        var calculator = container.GetService<GridCalculator>();
        ;

        // Cleanup
        container.Dispose();
    }
```

**Returns:** `void`

### Factory_ShouldSupportCustomServiceRegistration

```csharp
#endregion

    #region Factory Customization Tests

    [Fact]
    public void Factory_ShouldSupportCustomServiceRegistration()
    {
        // Arrange
        var container = new CompositionContainer();
        container.Initialize();

        // Act - Register a custom factory
        container.RegisterCustomFactory<ICustomService>(() => new CustomService("test"));

        var service = container.GetService<ICustomService>();

        // Assert
        ;
        Assert.IsType<CustomService>(service);
        ;

        // Cleanup
        container.Dispose();
    }
```

**Returns:** `void`

### Factory_ShouldOverrideDefaultRegistration

```csharp
[Fact]
    public void Factory_ShouldOverrideDefaultRegistration()
    {
        // Arrange
        var container = new CompositionContainer();
        container.Initialize();

        // Act - Override default factory
        var customCalculator = new CustomGridCalculator();
        container.RegisterCustomFactory<GridCalculator>(() => customCalculator);

        var retrievedCalculator = container.GetService<GridCalculator>();

        // Assert
        ;

        // Cleanup
        container.Dispose();
    }
```

**Returns:** `void`

