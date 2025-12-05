---
title: "StateMigrationTest"
description: "Test class to validate the service-based state migration"
weight: 20
url: "/gridbuilding/v6-0/api/godot/statemigrationtest/"
---

# StateMigrationTest

```csharp
GridBuilding.Godot.Tests.Unit.Core.Migration
class StateMigrationTest
{
    // Members...
}
```

Test class to validate the service-based state migration

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Migration/StateMigrationTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Unit.Core.Migration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### TestServiceAvailability

```csharp
[Fact]
        public void TestServiceAvailability()
        {
            // Test that service interfaces are available
            var buildingServiceType = typeof(IBuildingService);
            
            Assert.NotNull(buildingServiceType);
            Assert.Equal("IBuildingService", buildingServiceType.Name);
        }
```

**Returns:** `void`

### TestBasicFunctionality

```csharp
[Fact]
        public void TestBasicFunctionality()
        {
            // Simple test to verify basic functionality
            Assert.True(true);
        }
```

**Returns:** `void`

### TestServiceNamespace

```csharp
[Fact]
        public void TestServiceNamespace()
        {
            // Verify namespace is correct
            var serviceType = typeof(IBuildingService);
            Assert.Equal("GridBuilding.Godot.Services.IBuildingService", serviceType.FullName);
        }
```

**Returns:** `void`

