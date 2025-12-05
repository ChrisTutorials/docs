---
title: "ResolverConfigurations"
description: "Plugin-specific resolver configurations optimized for different use cases"
weight: 10
url: "/gridbuilding/v6-0/api/core/resolverconfigurations/"
---

# ResolverConfigurations

```csharp
GridBuilding.Core.Configuration
class ResolverConfigurations
{
    // Members...
}
```

Plugin-specific resolver configurations optimized for different use cases

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/ResolverConfigurations.cs`  
**Namespace:** `GridBuilding.Core.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetGridBuildingCollisionConfig

```csharp
/// <summary>
    /// Gets optimized configuration for GridBuilding collision resolution
    /// </summary>
    public static CollisionResolverConfiguration GetGridBuildingCollisionConfig()
    {
        return new CollisionResolverConfiguration
        {
            Name = "GridBuildingCollision",
            IsEnabled = true,
            MaxCacheSize = 2000, // Larger cache for frequent collision checks
            CollisionTolerance = 0.05f, // Tighter tolerance for building placement
            UsePreciseCollision = true,
            EnableParallelProcessing = true,
            ParallelProcessingThreshold = 8, // Fewer shapes before parallel processing
            PerformanceMode = CollisionPerformanceMode.Accuracy
        };
    }
```

Gets optimized configuration for GridBuilding collision resolution

**Returns:** `CollisionResolverConfiguration`

### GetRealTimeCollisionConfig

```csharp
/// <summary>
    /// Gets optimized configuration for real-time collision updates
    /// </summary>
    public static CollisionResolverConfiguration GetRealTimeCollisionConfig()
    {
        return new CollisionResolverConfiguration
        {
            Name = "RealTimeCollision",
            IsEnabled = true,
            MaxCacheSize = 500, // Smaller cache for memory efficiency
            CollisionTolerance = 0.1f, // Looser tolerance for speed
            UsePreciseCollision = false, // Use faster collision detection
            EnableParallelProcessing = false, // Single-threaded for consistency
            ParallelProcessingThreshold = 20,
            PerformanceMode = CollisionPerformanceMode.Speed
        };
    }
```

Gets optimized configuration for real-time collision updates

**Returns:** `CollisionResolverConfiguration`

### GetBatchCollisionConfig

```csharp
/// <summary>
    /// Gets optimized configuration for batch collision processing
    /// </summary>
    public static CollisionResolverConfiguration GetBatchCollisionConfig()
    {
        return new CollisionResolverConfiguration
        {
            Name = "BatchCollision",
            IsEnabled = true,
            MaxCacheSize = 5000, // Large cache for batch operations
            CollisionTolerance = 0.01f, // Highest precision
            UsePreciseCollision = true,
            EnableParallelProcessing = true,
            ParallelProcessingThreshold = 3, // Parallelize even small batches
            PerformanceMode = CollisionPerformanceMode.Accuracy
        };
    }
```

Gets optimized configuration for batch collision processing

**Returns:** `CollisionResolverConfiguration`

### GetWorldTimeTimeZoneConfig

```csharp
/// <summary>
    /// Gets optimized configuration for WorldTime time zone resolution
    /// </summary>
    public static TimeZoneResolverConfiguration GetWorldTimeTimeZoneConfig()
    {
        return new TimeZoneResolverConfiguration
        {
            Name = "WorldTimeTimeZone",
            IsEnabled = true,
            MaxCacheSize = 100, // Small cache - time zones are limited
            CacheExpirationMinutes = 60, // Cache for 1 hour
            PreloadCommonTimeZones = true,
            EnableAsyncResolution = false, // Sync is fast enough
            FallbackTimeZone = "UTC"
        };
    }
```

Gets optimized configuration for WorldTime time zone resolution

**Returns:** `TimeZoneResolverConfiguration`

### GetWorldTimeCalendarConfig

```csharp
/// <summary>
    /// Gets optimized configuration for WorldTime calendar resolution
    /// </summary>
    public static CalendarResolverConfiguration GetWorldTimeCalendarConfig()
    {
        return new CalendarResolverConfiguration
        {
            Name = "WorldTimeCalendar",
            IsEnabled = true,
            MaxCacheSize = 1000,
            CacheExpirationMinutes = 30,
            EnableAsyncResolution = true, // Calendar calculations can be complex
            AsyncThreshold = 10, // Async for complex calculations
            SupportedCalendarSystems = new List<CalendarSystem>
            {
                CalendarSystem.Gregorian,
                CalendarSystem.Julian,
                CalendarSystem.Islamic
            },
            DefaultCalendarSystem = CalendarSystem.Gregorian
        };
    }
```

Gets optimized configuration for WorldTime calendar resolution

**Returns:** `CalendarResolverConfiguration`

### GetItemDropsDropTableConfig

```csharp
/// <summary>
    /// Gets optimized configuration for ItemDrops drop table resolution
    /// </summary>
    public static DropTableResolverConfiguration GetItemDropsDropTableConfig()
    {
        return new DropTableResolverConfiguration
        {
            Name = "ItemDropsDropTable",
            IsEnabled = true,
            MaxCacheSize = 2000, // Cache for common drop tables
            CacheExpirationMinutes = 15, // Shorter cache for game balance changes
            EnableAsyncResolution = false, // Drop calculations are fast
            UseDeterministicRandom = true, // For reproducible drops
            RandomSeed = 12345,
            MaxDropsPerTable = 50, // Limit to prevent performance issues
            RarityWeightMultiplier = 1.0
        };
    }
```

Gets optimized configuration for ItemDrops drop table resolution

**Returns:** `DropTableResolverConfiguration`

### GetItemDropsRarityConfig

```csharp
/// <summary>
    /// Gets optimized configuration for ItemDrops rarity resolution
    /// </summary>
    public static RarityResolverConfiguration GetItemDropsRarityConfig()
    {
        return new RarityResolverConfiguration
        {
            Name = "ItemDropsRarity",
            IsEnabled = true,
            MaxCacheSize = 100, // Rarity calculations are simple
            CacheExpirationMinutes = 120, // Cache longer - rarities don't change often
            EnableRarityModifiers = true,
            MaxModifierStack = 10, // Prevent infinite stacking
            BaseDropChanceMultiplier = 1.0,
            LegendaryDropChanceCap = 0.05 // Cap legendary drops at 5%
        };
    }
```

Gets optimized configuration for ItemDrops rarity resolution

**Returns:** `RarityResolverConfiguration`

### GetItemDropsInventoryConfig

```csharp
/// <summary>
    /// Gets optimized configuration for ItemDrops inventory resolution
    /// </summary>
    public static InventoryResolverConfiguration GetItemDropsInventoryConfig()
    {
        return new InventoryResolverConfiguration
        {
            Name = "ItemDropsInventory",
            IsEnabled = true,
            MaxCacheSize = 500,
            CacheExpirationMinutes = 5, // Short cache - inventory changes frequently
            EnableAsyncResolution = true, // Inventory operations can be I/O bound
            AsyncThreshold = 5,
            MaxInventorySize = 1000,
            EnableStacking = true,
            MaxStackSize = 999,
            EnableAutoSort = false, // Let user control sorting
            ValidationMode = InventoryValidationMode.Strict
        };
    }
```

Gets optimized configuration for ItemDrops inventory resolution

**Returns:** `InventoryResolverConfiguration`

