---
title: "ConfigurationBridgeTests"
description: "Unit tests for ConfigurationBridge functionality.
Tests the mapping between Godot .tres files and pure C# configurations."
weight: 20
url: "/gridbuilding/v6-0/api/godot/configurationbridgetests/"
---

# ConfigurationBridgeTests

```csharp
GridBuilding.Godot.Tests.Configuration
class ConfigurationBridgeTests
{
    // Members...
}
```

Unit tests for ConfigurationBridge functionality.
Tests the mapping between Godot .tres files and pure C# configurations.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Configuration/ConfigurationBridgeTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### LoadFromGBConfig_ShouldReturnValidConfiguration

```csharp
#region Configuration Loading Tests

    [Fact]
    public void LoadFromGBConfig_ShouldReturnValidConfiguration()
    {
        // Arrange
        var mockGbConfig = CreateMockGBConfig();

        // Act
        var config = ConfigurationBridge.LoadFromGBConfig(mockGbConfig);

        // Assert
        ;
        Assert.NotEmpty(config.ConfigurationId);
        Assert.NotEmpty(config.ConfigurationName);
        ;
        ;
        ;
    }
```

**Returns:** `void`

### LoadFromGBConfig_ShouldMapDebugSettings

```csharp
[Fact]
    public void LoadFromGBConfig_ShouldMapDebugSettings()
    {
        // Arrange
        var mockGbConfig = CreateMockGBConfig();
        mockGbConfig.settings.debug.enabled = true;
        mockGbConfig.settings.debug.level = Godot.LogLevel.Debug;

        // Act
        var config = ConfigurationBridge.LoadFromGBConfig(mockGbConfig);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### LoadFromGBConfig_ShouldHandleNullConfig

```csharp
[Fact]
    public void LoadFromGBConfig_ShouldHandleNullConfig()
    {
        // Act & Assert
        Assert.Throws<ArgumentNullException>(() => 
            ConfigurationBridge.LoadFromGBConfig(null!));
    }
```

**Returns:** `void`

### LoadFromGBConfig_ShouldHandleNullSettings

```csharp
[Fact]
    public void LoadFromGBConfig_ShouldHandleNullSettings()
    {
        // Arrange
        var mockGbConfig = new GBConfig();
        mockGbConfig.settings = null;

        // Act
        var config = ConfigurationBridge.LoadFromGBConfig(mockGbConfig);

        // Assert - Should still return valid config with defaults
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CreateGBConfig_ShouldReturnValidResource

```csharp
#endregion

    #region Configuration Creation Tests

    [Fact]
    public void CreateGBConfig_ShouldReturnValidResource()
    {
        // Arrange
        var gameConfig = CreateMockGameConfiguration();

        // Act
        var gbConfig = ConfigurationBridge.CreateGBConfig(gameConfig);

        // Assert
        ;
        ;
        ;
        ;
        ;
    }
```

**Returns:** `void`

### CreateGBConfig_ShouldMapDebugSettings

```csharp
[Fact]
    public void CreateGBConfig_ShouldMapDebugSettings()
    {
        // Arrange
        var gameConfig = CreateMockGameConfiguration();
        gameConfig.DebugSettings.EnableLogging = true;
        gameConfig.DebugSettings.LogLevel = LogLevel.Error;

        // Act
        var gbConfig = ConfigurationBridge.CreateGBConfig(gameConfig);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### CreateGBConfig_ShouldMapPerformanceSettings

```csharp
[Fact]
    public void CreateGBConfig_ShouldMapPerformanceSettings()
    {
        // Arrange
        var gameConfig = CreateMockGameConfiguration();
        gameConfig.PerformanceSettings.EnableProfiling = true;
        gameConfig.PerformanceSettings.MaxUpdateFrequency = 120;

        // Act
        var gbConfig = ConfigurationBridge.CreateGBConfig(gameConfig);

        // Assert - Performance settings should be mapped (implementation dependent)
        ;
    }
```

**Returns:** `void`

### ValidateMigration_ShouldPassForValidConfig

```csharp
#endregion

    #region Migration Validation Tests

    [Fact]
    public void ValidateMigration_ShouldPassForValidConfig()
    {
        // Arrange
        var validConfig = CreateMockGBConfig();

        // Act
        var result = ConfigurationBridge.ValidateMigration(validConfig);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### ValidateMigration_ShouldFailForNullConfig

```csharp
[Fact]
    public void ValidateMigration_ShouldFailForNullConfig()
    {
        // Act
        var result = ConfigurationBridge.ValidateMigration(null!);

        // Assert
        ;
        ;
    }
```

**Returns:** `void`

### ValidateMigration_ShouldWarnForMissingSettings

```csharp
[Fact]
    public void ValidateMigration_ShouldWarnForMissingSettings()
    {
        // Arrange
        var invalidConfig = new GBConfig();
        invalidConfig.settings = null;

        // Act
        var result = ConfigurationBridge.ValidateMigration(invalidConfig);

        // Assert
        ; // Warnings don't make it invalid
        ;
    }
```

**Returns:** `void`

### ValidateMigration_ShouldWarnForDeprecatedSettings

```csharp
[Fact]
    public void ValidateMigration_ShouldWarnForDeprecatedSettings()
    {
        // Arrange
        var configWithDeprecatedSettings = CreateMockGBConfig();
        configWithDeprecatedSettings.settings.runtime_checks = new GBRuntimeChecks();

        // Act
        var result = ConfigurationBridge.ValidateMigration(configWithDeprecatedSettings);

        // Assert
        ;
    }
```

**Returns:** `void`

### RoundTrip_ShouldPreserveConfiguration

```csharp
#endregion

    #region Round-trip Tests

    [Fact]
    public void RoundTrip_ShouldPreserveConfiguration()
    {
        // Arrange
        var originalConfig = CreateMockGameConfiguration();
        originalConfig.DebugSettings.EnableLogging = true;
        originalConfig.DebugSettings.LogLevel = LogLevel.Warning;
        originalConfig.MultiplayerSettings.MaxPlayers = 8;

        // Act
        var gbConfig = ConfigurationBridge.CreateGBConfig(originalConfig);
        var loadedConfig = ConfigurationBridge.LoadFromGBConfig(gbConfig);

        // Assert
        ;
        ;
        ;
    }
```

**Returns:** `void`

