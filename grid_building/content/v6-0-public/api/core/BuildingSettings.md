---
title: "BuildingSettings"
description: "Configuration settings for GridBuilding system
Provides centralized configuration management for building placement, validation, and behavior"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/buildingsettings/"
---

# BuildingSettings

```csharp
GridBuilding.Core.Systems.Configuration
class BuildingSettings
{
    // Members...
}
```

Configuration settings for GridBuilding system
Provides centralized configuration management for building placement, validation, and behavior

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Configuration/BuildingSettings.cs`  
**Namespace:** `GridBuilding.Core.Systems.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingId

```csharp
#region Core Properties

        /// <summary>
        /// Unique identifier for this building configuration
        /// </summary>
        public string BuildingId { get; set; } = string.Empty;
```

Unique identifier for this building configuration

### DisplayName

```csharp
/// <summary>
        /// Display name for the building
        /// </summary>
        public string DisplayName { get; set; } = string.Empty;
```

Display name for the building

### Description

```csharp
/// <summary>
        /// Description of the building
        /// </summary>
        public string Description { get; set; } = string.Empty;
```

Description of the building

### BuildingType

```csharp
/// <summary>
        /// Type/category of the building
        /// </summary>
        public string BuildingType { get; set; } = string.Empty;
```

Type/category of the building

### Size

```csharp
/// <summary>
        /// Size of the building in grid units
        /// </summary>
        public Vector2I Size { get; set; } = Vector2I.One;
```

Size of the building in grid units

### IsMultiTile

```csharp
/// <summary>
        /// Whether this building occupies multiple tiles
        /// </summary>
        public bool IsMultiTile { get; set; } = false;
```

Whether this building occupies multiple tiles

### CanRotate

```csharp
/// <summary>
        /// Whether this building can be rotated
        /// </summary>
        public bool CanRotate { get; set; } = true;
```

Whether this building can be rotated

### CanFlip

```csharp
/// <summary>
        /// Whether this building can be flipped
        /// </summary>
        public bool CanFlip { get; set; } = true;
```

Whether this building can be flipped

### CanDemolish

```csharp
/// <summary>
        /// Whether this building can be demolished
        /// </summary>
        public bool CanDemolish { get; set; } = true;
```

Whether this building can be demolished

### IsEnabled

```csharp
/// <summary>
        /// Whether this building is enabled
        /// </summary>
        public bool IsEnabled { get; set; } = true;
```

Whether this building is enabled

### IsValid

```csharp
/// <summary>
        /// Configuration validity
        /// </summary>
        public bool IsValid => !string.IsNullOrEmpty(BuildingType) && Size.X > 0 && Size.Y > 0;
```

Configuration validity

### Tags

```csharp
#endregion

        #region Placement Properties

        /// <summary>
        /// Tags for placement filtering and validation
        /// </summary>
        public List<string> Tags { get; set; } = new List<string>();
```

Tags for placement filtering and validation

### PlacementRules

```csharp
/// <summary>
        /// Placement rules that must be satisfied
        /// </summary>
        public List<IPlacementRule> PlacementRules { get; set; } = new List<IPlacementRule>();
```

Placement rules that must be satisfied

### RequiredLocationTags

```csharp
/// <summary>
        /// Required tags for placement location
        /// </summary>
        public List<string> RequiredLocationTags { get; set; } = new List<string>();
```

Required tags for placement location

### ForbiddenLocationTags

```csharp
/// <summary>
        /// Forbidden tags for placement location
        /// </summary>
        public List<string> ForbiddenLocationTags { get; set; } = new List<string>();
```

Forbidden tags for placement location

### MinimumDistanceFromOthers

```csharp
/// <summary>
        /// Minimum distance from other buildings
        /// </summary>
        public float MinimumDistanceFromOthers { get; set; } = 0.0f;
```

Minimum distance from other buildings

### MaximumDistanceFromTypes

```csharp
/// <summary>
        /// Maximum distance from specific building types
        /// </summary>
        public Dictionary<string, float> MaximumDistanceFromTypes { get; set; } = new Dictionary<string, float>();
```

Maximum distance from specific building types

### RequiresRoadAccess

```csharp
/// <summary>
        /// Whether this building requires road access
        /// </summary>
        public bool RequiresRoadAccess { get; set; } = false;
```

Whether this building requires road access

### MaximumRoadDistance

```csharp
/// <summary>
        /// Maximum road distance for placement
        /// </summary>
        public float MaximumRoadDistance { get; set; } = 5.0f;
```

Maximum road distance for placement

### PlacementCost

```csharp
#endregion

        #region Resource Properties

        /// <summary>
        /// Cost to place this building
        /// </summary>
        public Dictionary<string, int> PlacementCost { get; set; } = new Dictionary<string, int>();
```

Cost to place this building

### DemolishRefund

```csharp
/// <summary>
        /// Resources refunded when demolishing this building
        /// </summary>
        public Dictionary<string, int> DemolishRefund { get; set; } = new Dictionary<string, int>();
```

Resources refunded when demolishing this building

### MaintenanceCost

```csharp
/// <summary>
        /// Maintenance cost per time unit
        /// </summary>
        public Dictionary<string, int> MaintenanceCost { get; set; } = new Dictionary<string, int>();
```

Maintenance cost per time unit

### Production

```csharp
/// <summary>
        /// Resources produced per time unit
        /// </summary>
        public Dictionary<string, int> Production { get; set; } = new Dictionary<string, int>();
```

Resources produced per time unit

### StorageCapacity

```csharp
/// <summary>
        /// Storage capacity for resources
        /// </summary>
        public Dictionary<string, int> StorageCapacity { get; set; } = new Dictionary<string, int>();
```

Storage capacity for resources

### ScenePath

```csharp
#endregion

        #region Visual Properties

        /// <summary>
        /// Path to the building's scene file
        /// </summary>
        public string ScenePath { get; set; } = string.Empty;
```

Path to the building's scene file

### IconPath

```csharp
/// <summary>
        /// Path to the building's icon texture
        /// </summary>
        public string IconPath { get; set; } = string.Empty;
```

Path to the building's icon texture

### PreviewPath

```csharp
/// <summary>
        /// Path to the building's preview texture
        /// </summary>
        public string PreviewPath { get; set; } = string.Empty;
```

Path to the building's preview texture

### TintColor

```csharp
/// <summary>
        /// Color tint for the building
        /// </summary>
        public Color TintColor { get; set; } = Colors.White;
```

Color tint for the building

### Modulation

```csharp
/// <summary>
        /// Modulation for the building
        /// </summary>
        public Color Modulation { get; set; } = Colors.White;
```

Modulation for the building

### ZIndex

```csharp
/// <summary>
        /// Z-index for rendering order
        /// </summary>
        public int ZIndex { get; set; } = 0;
```

Z-index for rendering order

### CastsShadow

```csharp
/// <summary>
        /// Whether this building casts shadows
        /// </summary>
        public bool CastsShadow { get; set; } = true;
```

Whether this building casts shadows

### IsActiveByDefault

```csharp
#endregion

        #region Behavior Properties

        /// <summary>
        /// Whether this building is active by default
        /// </summary>
        public bool IsActiveByDefault { get; set; } = true;
```

Whether this building is active by default

### CanUpgrade

```csharp
/// <summary>
        /// Whether this building can be upgraded
        /// </summary>
        public bool CanUpgrade { get; set; } = false;
```

Whether this building can be upgraded

### MaxUpgradeLevel

```csharp
/// <summary>
        /// Maximum upgrade level
        /// </summary>
        public int MaxUpgradeLevel { get; set; } = 1;
```

Maximum upgrade level

### CanConnect

```csharp
/// <summary>
        /// Whether this building can be connected to others
        /// </summary>
        public bool CanConnect { get; set; } = false;
```

Whether this building can be connected to others

### ConnectionTypes

```csharp
/// <summary>
        /// Connection types this building supports
        /// </summary>
        public List<string> ConnectionTypes { get; set; } = new List<string>();
```

Connection types this building supports

### HasAreaEffect

```csharp
/// <summary>
        /// Whether this building affects nearby buildings
        /// </summary>
        public bool HasAreaEffect { get; set; } = false;
```

Whether this building affects nearby buildings

### AreaEffectRadius

```csharp
/// <summary>
        /// Area effect radius
        /// </summary>
        public float AreaEffectRadius { get; set; } = 0.0f;
```

Area effect radius


## Methods

### Validate

```csharp
#endregion

        #region Validation

        /// <summary>
        /// Validates the building configuration
        /// </summary>
        /// <returns>Validation result</returns>
        public GridBuilding.Core.Results.ValidationResult Validate()
        {
            var errors = new List<string>();
            var warnings = new List<string>();

            // Validate required fields
            if (string.IsNullOrWhiteSpace(BuildingId))
                errors.Add("BuildingId is required");

            if (string.IsNullOrWhiteSpace(DisplayName))
                warnings.Add("DisplayName is not specified");

            if (string.IsNullOrWhiteSpace(BuildingType))
                warnings.Add("BuildingType is not specified");

            // Validate size
            if (Size.X <= 0 || Size.Y <= 0)
                errors.Add("Size must have positive dimensions");

            if (Size.X > 10 || Size.Y > 10)
                warnings.Add("Building size is very large, may impact performance");

            // Validate costs
            if (PlacementCost.Count == 0)
                warnings.Add("No placement cost specified");

            foreach (var cost in PlacementCost)
            {
                if (cost.Value < 0)
                    errors.Add($"Placement cost for {cost.Key} cannot be negative");
            }

            // Validate refund
            foreach (var refund in DemolishRefund)
            {
                if (refund.Value < 0)
                    errors.Add($"Demolish refund for {refund.Key} cannot be negative");
                
                if (PlacementCost.ContainsKey(refund.Key) && refund.Value > PlacementCost[refund.Key])
                    warnings.Add($"Demolish refund for {refund.Key} exceeds placement cost");
            }

            // Validate distances
            if (MinimumDistanceFromOthers < 0)
                errors.Add("MinimumDistanceFromOthers cannot be negative");

            if (MaximumRoadDistance < 0)
                errors.Add("MaximumRoadDistance cannot be negative");

            // Validate paths
            if (string.IsNullOrWhiteSpace(ScenePath))
                warnings.Add("ScenePath is not specified");

            // Validate tags
            if (Tags.Count == 0)
                warnings.Add("No tags specified for filtering");

            // Calculate score
            var score = CalculateValidationScore(errors, warnings);

            return new ValidationResult
            {
                IsValid = errors.Count == 0,
                Errors = errors,
                Warnings = warnings,
                Score = score
            };
        }
```

Validates the building configuration

**Returns:** `GridBuilding.Core.Results.ValidationResult`

### Clone

```csharp
#endregion

        #region Utility Methods

        /// <summary>
        /// Creates a copy of this building configuration
        /// </summary>
        /// <returns>Copy of the configuration</returns>
        public BuildingSettings Clone()
        {
            return new BuildingSettings
            {
                BuildingId = BuildingId,
                DisplayName = DisplayName,
                Description = Description,
                BuildingType = BuildingType,
                Size = Size,
                IsMultiTile = IsMultiTile,
                CanRotate = CanRotate,
                CanFlip = CanFlip,
                CanDemolish = CanDemolish,
                Tags = new List<string>(Tags),
                PlacementRules = new List<IPlacementRule>(PlacementRules),
                RequiredLocationTags = new List<string>(RequiredLocationTags),
                ForbiddenLocationTags = new List<string>(ForbiddenLocationTags),
                MinimumDistanceFromOthers = MinimumDistanceFromOthers,
                MaximumDistanceFromTypes = new Dictionary<string, float>(MaximumDistanceFromTypes),
                RequiresRoadAccess = RequiresRoadAccess,
                MaximumRoadDistance = MaximumRoadDistance,
                PlacementCost = new Dictionary<string, int>(PlacementCost),
                DemolishRefund = new Dictionary<string, int>(DemolishRefund),
                MaintenanceCost = new Dictionary<string, int>(MaintenanceCost),
                Production = new Dictionary<string, int>(Production),
                StorageCapacity = new Dictionary<string, int>(StorageCapacity),
                ScenePath = ScenePath,
                IconPath = IconPath,
                PreviewPath = PreviewPath,
                TintColor = TintColor,
                Modulation = Modulation,
                ZIndex = ZIndex,
                CastsShadow = CastsShadow,
                IsActiveByDefault = IsActiveByDefault,
                CanUpgrade = CanUpgrade,
                MaxUpgradeLevel = MaxUpgradeLevel,
                CanConnect = CanConnect,
                ConnectionTypes = new List<string>(ConnectionTypes),
                HasAreaEffect = HasAreaEffect,
                AreaEffectRadius = AreaEffectRadius
            };
        }
```

Creates a copy of this building configuration

**Returns:** `BuildingSettings`

### GetTotalPlacementCost

```csharp
/// <summary>
        /// Gets the total placement cost
        /// </summary>
        /// <returns>Total cost value</returns>
        public int GetTotalPlacementCost()
        {
            var total = 0;
            foreach (var cost in PlacementCost.Values)
            {
                total += cost;
            }
            return total;
        }
```

Gets the total placement cost

**Returns:** `int`

### GetTotalDemolishRefund

```csharp
/// <summary>
        /// Gets the total demolish refund
        /// </summary>
        /// <returns>Total refund value</returns>
        public int GetTotalDemolishRefund()
        {
            var total = 0;
            foreach (var refund in DemolishRefund.Values)
            {
                total += refund;
            }
            return total;
        }
```

Gets the total demolish refund

**Returns:** `int`

### HasTag

```csharp
/// <summary>
        /// Checks if the building has a specific tag
        /// </summary>
        /// <param name="tag">Tag to check</param>
        /// <returns>True if tag is present</returns>
        public bool HasTag(string tag)
        {
            return Tags.Contains(tag);
        }
```

Checks if the building has a specific tag

**Returns:** `bool`

**Parameters:**
- `string tag`

### SupportsConnection

```csharp
/// <summary>
        /// Checks if the building supports a specific connection type
        /// </summary>
        /// <param name="connectionType">Connection type to check</param>
        /// <returns>True if connection type is supported</returns>
        public bool SupportsConnection(string connectionType)
        {
            return ConnectionTypes.Contains(connectionType);
        }
```

Checks if the building supports a specific connection type

**Returns:** `bool`

**Parameters:**
- `string connectionType`

### GetResourceCost

```csharp
/// <summary>
        /// Gets the cost for a specific resource
        /// </summary>
        /// <param name="resourceType">Resource type</param>
        /// <returns>Cost value, 0 if not found</returns>
        public int GetResourceCost(string resourceType)
        {
            return PlacementCost.TryGetValue(resourceType, out var cost) ? cost : 0;
        }
```

Gets the cost for a specific resource

**Returns:** `int`

**Parameters:**
- `string resourceType`

### CreateDefault

```csharp
#endregion

        #region Static Factory Methods

        /// <summary>
        /// Creates a default building configuration
        /// </summary>
        /// <param name="buildingId">Building ID</param>
        /// <returns>Default configuration</returns>
        public static BuildingSettings CreateDefault(string buildingId)
        {
            return new BuildingSettings
            {
                BuildingId = buildingId,
                DisplayName = buildingId,
                BuildingType = "Default",
                Size = Vector2.One,
                CanRotate = true,
                CanFlip = true,
                CanDemolish = true,
                IsActiveByDefault = true,
                Tags = new List<string> { "default" },
                PlacementCost = new Dictionary<string, int> { { "gold", 100 } },
                DemolishRefund = new Dictionary<string, int> { { "gold", 50 } }
            };
        }
```

Creates a default building configuration

**Returns:** `BuildingSettings`

**Parameters:**
- `string buildingId`

### CreateResidential

```csharp
/// <summary>
        /// Creates a residential building configuration
        /// </summary>
        /// <param name="buildingId">Building ID</param>
        /// <returns>Residential configuration</returns>
        public static BuildingSettings CreateResidential(string buildingId)
        {
            return new BuildingSettings
            {
                BuildingId = buildingId,
                DisplayName = "Residential Building",
                Description = "A residential building for housing citizens",
                BuildingType = "Residential",
                Size = new Vector2(2, 2),
                IsMultiTile = true,
                CanRotate = true,
                CanFlip = false,
                CanDemolish = true,
                IsActiveByDefault = true,
                Tags = new List<string> { "residential", "housing", "population" },
                RequiredLocationTags = new List<string> { "residential_zone" },
                PlacementCost = new Dictionary<string, int> { { "gold", 500 }, { "wood", 100 } },
                DemolishRefund = new Dictionary<string, int> { { "gold", 250 }, { "wood", 50 } },
                MaintenanceCost = new Dictionary<string, int> { { "gold", 10 } },
                Production = new Dictionary<string, int> { { "population", 4 } },
                RequiresRoadAccess = true,
                MaximumRoadDistance = 3.0f
            };
        }
```

Creates a residential building configuration

**Returns:** `BuildingSettings`

**Parameters:**
- `string buildingId`

### CreateCommercial

```csharp
/// <summary>
        /// Creates a commercial building configuration
        /// </summary>
        /// <param name="buildingId">Building ID</param>
        /// <returns>Commercial configuration</returns>
        public static BuildingSettings CreateCommercial(string buildingId)
        {
            return new BuildingSettings
            {
                BuildingId = buildingId,
                DisplayName = "Commercial Building",
                Description = "A commercial building for trade and services",
                BuildingType = "Commercial",
                Size = new Vector2(3, 2),
                IsMultiTile = true,
                CanRotate = true,
                CanFlip = false,
                CanDemolish = true,
                IsActiveByDefault = true,
                Tags = new List<string> { "commercial", "trade", "services" },
                RequiredLocationTags = new List<string> { "commercial_zone" },
                PlacementCost = new Dictionary<string, int> { { "gold", 1000 }, { "stone", 200 } },
                DemolishRefund = new Dictionary<string, int> { { "gold", 500 }, { "stone", 100 } },
                MaintenanceCost = new Dictionary<string, int> { { "gold", 25 } },
                Production = new Dictionary<string, int> { { "gold", 50 } },
                RequiresRoadAccess = true,
                MaximumRoadDistance = 2.0f,
                HasAreaEffect = true,
                AreaEffectRadius = 5.0f
            };
        }
```

Creates a commercial building configuration

**Returns:** `BuildingSettings`

**Parameters:**
- `string buildingId`

