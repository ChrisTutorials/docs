---
title: "GameConfiguration"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/gameconfiguration/"
---

# GameConfiguration

```csharp
GridBuilding.Core.Configuration
class GameConfiguration
{
    // Members...
}
```

Base implementation of game configuration.
Provides pure C# configuration that can be mapped to/from Godot .tres files.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Configuration/GameConfiguration.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ConfigurationId

```csharp
public string ConfigurationId { get; set; } = string.Empty;
```

### ConfigurationName

```csharp
public string ConfigurationName { get; set; } = string.Empty;
```

### GameType

```csharp
public GameType GameType { get; set; } = GameType.Unknown;
```

### DebugSettings

```csharp
public DebugSettings DebugSettings { get; set; } = new();
```

### VisualSettings

```csharp
public VisualSettings VisualSettings { get; set; } = new();
```

### BuildingSettings

```csharp
public BuildingSettings BuildingSettings { get; set; } = new();
```

### ManipulationSettings

```csharp
public ManipulationSettings ManipulationSettings { get; set; } = new();
```

### GridTargetingSettings

```csharp
public GridTargetingSettings GridTargetingSettings { get; set; } = new();
```

### PlacementSettings

```csharp
public PlacementSettings PlacementSettings { get; set; } = new();
```

### PerformanceSettings

```csharp
public PerformanceSettings PerformanceSettings { get; set; } = new();
```

### MultiplayerSettings

```csharp
public MultiplayerSettings MultiplayerSettings { get; set; } = new();
```

### CustomProperties

```csharp
public Dictionary<string, object> CustomProperties { get; set; } = new();
```


## Methods

### ValidateConfiguration

```csharp
public ValidationResult ValidateConfiguration()
    {
        var result = new ValidationResult();
        
        // Validate required fields
        if (string.IsNullOrWhiteSpace(ConfigurationId))
        {
            result.AddError("ConfigurationId is required");
        }
        
        if (string.IsNullOrWhiteSpace(ConfigurationName))
        {
            result.AddError("ConfigurationName is required");
        }
        
        if (GameType == GameType.Unknown)
        {
            result.AddError("GameType must be specified");
        }
        
        // Validate nested settings
        var debugValidation = DebugSettings.Validate();
        if (!debugValidation.IsValid)
        {
            result.AddErrors(debugValidation.Errors);
        }
        
        var visualValidation = VisualSettings.Validate();
        if (!visualValidation.IsValid)
        {
            result.AddErrors(visualValidation.Errors);
        }
        
        var buildingValidation = BuildingSettings.Validate();
        if (!buildingValidation.IsValid)
        {
            result.AddErrors(buildingValidation.Errors);
        }
        
        var manipulationValidation = ManipulationSettings.Validate();
        if (!manipulationValidation.IsValid)
        {
            result.AddErrors(manipulationValidation.Errors);
        }
        
        var targetingValidation = GridTargetingSettings.Validate();
        if (!targetingValidation.IsValid)
        {
            result.AddErrors(targetingValidation.Errors);
        }
        
        var placementValidation = PlacementSettings.Validate();
        if (!placementValidation.IsValid)
        {
            result.AddErrors(placementValidation.Errors);
        }
        
        var performanceValidation = PerformanceSettings.Validate();
        if (!performanceValidation.IsValid)
        {
            result.AddErrors(performanceValidation.Errors);
        }
        
        var multiplayerValidation = MultiplayerSettings.Validate();
        if (!multiplayerValidation.IsValid)
        {
            result.AddErrors(multiplayerValidation.Errors);
        }
        
        // Game type specific validation
        ValidateGameTypeSpecific(result);
        
        return result;
    }
```

**Returns:** `ValidationResult`

### Clone

```csharp
/// <summary>
    /// Creates a deep copy of this configuration
    /// </summary>
    public GameConfiguration Clone()
    {
        return new GameConfiguration
        {
            ConfigurationId = ConfigurationId,
            ConfigurationName = ConfigurationName,
            GameType = GameType,
            DebugSettings = DebugSettings.Clone(),
            VisualSettings = VisualSettings.Clone(),
            BuildingSettings = BuildingSettings.Clone(),
            ManipulationSettings = ManipulationSettings.Clone(),
            GridTargetingSettings = GridTargetingSettings.Clone(),
            PlacementSettings = PlacementSettings.Clone(),
            PerformanceSettings = PerformanceSettings.Clone(),
            MultiplayerSettings = MultiplayerSettings.Clone(),
            CustomProperties = new Dictionary<string, object>(CustomProperties)
        };
    }
```

Creates a deep copy of this configuration

**Returns:** `GameConfiguration`

### MergeFrom

```csharp
/// <summary>
    /// Merges another configuration into this one, with the other taking precedence
    /// </summary>
    public void MergeFrom(IGameConfiguration other)
    {
        ConfigurationId = other.ConfigurationId;
        ConfigurationName = other.ConfigurationName;
        GameType = other.GameType;
        
        DebugSettings.MergeFrom(other.DebugSettings);
        VisualSettings.MergeFrom(other.VisualSettings);
        BuildingSettings.MergeFrom(other.BuildingSettings);
        ManipulationSettings.MergeFrom(other.ManipulationSettings);
        GridTargetingSettings.MergeFrom(other.GridTargetingSettings);
        PlacementSettings.MergeFrom(other.PlacementSettings);
        PerformanceSettings.MergeFrom(other.PerformanceSettings);
        MultiplayerSettings.MergeFrom(other.MultiplayerSettings);
        
        // Merge custom properties
        foreach (var kvp in other.CustomProperties)
        {
            CustomProperties[kvp.Key] = kvp.Value;
        }
    }
```

Merges another configuration into this one, with the other taking precedence

**Returns:** `void`

**Parameters:**
- `IGameConfiguration other`

