---
title: "DataUtilitiesTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/datautilitiestest/"
---

# DataUtilitiesTest

```csharp
GridBuilding.Godot.Tests.Data
class DataUtilitiesTest
{
    // Members...
}
```

Unit tests for GDScript data utilities
Covers static access, configuration validation, and factory behavior mirrored in GDScript.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Data/DataUtilitiesTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GBProjectSettingsEnhanced_StaticSettings_ShouldBeAccessible

```csharp
[Fact]
    public void GBProjectSettingsEnhanced_StaticSettings_ShouldBeAccessible()
    {
        // Test that static settings can be accessed (this was failing before our fix)
        // In C#, we simulate the static behavior that was fixed in GDScript
        
        // Simulate the static settings dictionary behavior
        var settings = new System.Collections.Generic.Dictionary<string, object>();
        
        // Test setting and getting values (equivalent to the fixed GDScript static methods)
        settings["test_key"] = "test_value";
        ;
        ;
        
        // Test default value behavior
        ;
    }
```

**Returns:** `void`

### GBConfigEnhanced_Validation_ShouldWork

```csharp
[Fact]
    public void GBConfigEnhanced_Validation_ShouldWork()
    {
        // Test the enhanced validation logic we implemented
        var hasSettings = true;
        var hasTemplates = true;
        var hasActions = true;
        
        var isValid = hasSettings && hasTemplates && hasActions;
        ;
        
        // Test invalid case
        var missingActions = false;
        var isInvalid = hasSettings && hasTemplates && missingActions;
        ;
    }
```

**Returns:** `void`

### GBLoggerEnhanced_LogLevel_ShouldBeValid

```csharp
[Fact]
    public void GBLoggerEnhanced_LogLevel_ShouldBeValid()
    {
        // Test the enhanced logging functionality
        var logLevels = new[] { "DEBUG", "INFO", "WARNING", "ERROR" };
        var currentLevel = "INFO";
        
        ;
        
        // Test log level validation
        bool isValidLogLevel(string level) => Array.Exists(logLevels, l => l == level);
        ;
        ;
    }
```

**Returns:** `void`

### GBObjectFactoryEnhanced_Creation_ShouldWork

```csharp
[Fact]
    public void GBObjectFactoryEnhanced_Creation_ShouldWork()
    {
        // Test the factory pattern we implemented
        var factory = new TestFactory();
        
        var config = factory.CreateValidConfig();
        ;
        
        var container = factory.CreateValidContainer();
        ;
        
        var logger = factory.CreateLogger();
        ;
        
        var validator = factory.CreateValidator();
        ;
    }
```

**Returns:** `void`

