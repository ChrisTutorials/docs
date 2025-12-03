# ItemDrops Integration Guide

## Overview

The ItemDrops plugin is designed to work agnostically with any inventory or item database system through clean interface boundaries. This guide shows how to integrate ItemDrops with your game's existing systems.

## Architecture

### Core Interfaces

The integration is built around several key interfaces:

- **`IItemDatabase`** - Provides item metadata and information
- **`IItemIdResolver`** - Maps ItemDrops IDs to system-specific IDs  
- **`IInventoryIntegration`** - Handles adding drops to inventory systems
- **`IItemDropsGameIntegration`** - Main boundary interface for game glue code

### Data Flow

```
ItemDrops Core → Game Integration → Inventory System
     ↓                ↓                ↓
  Drop Instance → Customized Drop → Added to Inventory
```

## Quick Start

### 1. Implement IItemDatabase

Create your own item database implementation:

```csharp
public class GameItemDatabase : IItemDatabase
{
    public string Id => "GameDatabase";
    public string Name => "My Game Items";
    public string Description => "Main game item database";

    public IItemInfo? GetItemInfo(string itemId)
    {
        // Look up item in your game's item system
        return GetItemFromGameSystem(itemId);
    }

    public IItemData? GetItemData(string itemId)
    {
        // Get detailed item data
        return GetDetailedItemData(itemId);
    }

    // Implement other methods...
}
```

### 2. Implement IItemIdResolver (Optional)

If you need to map between different ID systems:

```csharp
public class GameIdResolver : IItemIdResolver
{
    public string? ResolveToSystemId(string itemDropsId, string targetSystem)
    {
        // Map ItemDrops ID to your inventory system ID
        return itemDropsId switch
        {
            "sword_iron" => "item_001",
            "potion_health" => "item_002",
            _ => itemDropsId // Fallback to original ID
        };
    }

    // Implement other methods...
}
```

### 3. Implement IInventoryIntegration

Connect to your inventory system:

```csharp
public class GameInventoryIntegration : IInventoryIntegration
{
    private readonly GameInventory _gameInventory;

    public bool CanAcceptDrops(IEnumerable<DropInstance> drops)
    {
        return _gameInventory.HasSpace(drops.Sum(d => d.Quantity));
    }

    public InventoryAddResult AddDrops(IEnumerable<DropInstance> drops)
    {
        var result = new InventoryAddResult { Success = true };
        
        foreach (var drop in drops)
        {
            var systemId = ResolveToGameItemId(drop.ItemId);
            if (_gameInventory.AddItem(systemId, drop.Quantity))
            {
                result.ItemsAdded++;
                result.AddedItems.Add(drop);
            }
            else
            {
                result.ItemsRejected++;
                result.RejectedItems.Add(drop);
            }
        }
        
        return result;
    }

    // Implement other methods...
}
```

### 4. Create Game Integration

Tie everything together:

```csharp
public class GameItemDropsIntegration : IItemDropsGameIntegration
{
    public IItemDatabase ItemDatabase { get; }
    public IItemIdResolver IdResolver { get; }
    public IInventoryIntegration InventoryIntegration { get; }

    public GameItemDropsIntegration()
    {
        ItemDatabase = new GameItemDatabase();
        IdResolver = new GameIdResolver();
        InventoryIntegration = new GameInventoryIntegration();
    }

    public IEnumerable<DropInstance> ProcessDrops(
        IEnumerable<DropInstance> drops, 
        DropContext context)
    {
        var processedDrops = new List<DropInstance>();

        foreach (var drop in drops)
        {
            // Apply game-specific modifications
            var customizedDrop = CustomizeDrop(drop, context);
            
            // Only keep drops that can be added to inventory
            if (InventoryIntegration.CanAcceptDrops(new[] { customizedDrop }))
            {
                processedDrops.Add(customizedDrop);
            }
        }

        return processedDrops;
    }

    public DropInstance CustomizeDrop(DropInstance drop, DropContext context)
    {
        // Add game-specific metadata
        var metadata = new Dictionary<string, object>(drop.Metadata)
        {
            ["DropTime"] = DateTime.UtcNow,
            ["PlayerLevel"] = context.GetData<int>("PlayerLevel", 1),
            ["Location"] = context.GetData<string>("Location", "Unknown")
        };

        return new DropInstance(
            drop.ItemId,
            drop.ItemName,
            drop.ItemType,
            drop.Quantity,
            drop.Rarity,
            drop.Weight,
            metadata
        );
    }

    public bool IsValid()
    {
        return ItemDatabase.IsValid() && 
               IdResolver.IsValid() && 
               InventoryIntegration.IsValid();
    }
}
```

## Usage Examples

### Basic Drop Generation

```csharp
// Set up the integration
var gameIntegration = new GameItemDropsIntegration();

// Create drop tables with database integration
var swordDrop = new ItemDrop("sword_iron", 10.0f, ItemRarity.Common)
    .WithItemDatabase(gameIntegration.ItemDatabase)
    .WithIdResolver(gameIntegration.IdResolver)
    .WithQuantity(1, 1);

var potionDrop = new ItemDrop("potion_health", 15.0f, ItemRarity.Common)
    .WithItemDatabase(gameIntegration.ItemDatabase)
    .WithIdResolver(gameIntegration.IdResolver)
    .WithQuantity(1, 3);

// Create drop table
var dropTable = new DropTable("enemy_loot", "Enemy Loot Table")
    .WithDrops(new[] { swordDrop, potionDrop });

// Generate drops
var context = new DropContext();
context.SetData("PlayerLevel", 5);
context.SetData("Location", "Forest");

var dropResult = dropTable.GenerateDrops(context);

// Process drops through game integration
var processedDrops = gameIntegration.ProcessDrops(dropResult.Drops, context);

// Add to inventory
foreach (var drop in processedDrops)
{
    gameIntegration.InventoryIntegration.AddDrop(drop);
}
```

### Advanced Configuration

```csharp
// Create conditional drops
var rareDrop = new ItemDrop("armor_diamond", 5.0f, ItemRarity.Legendary)
    .WithItemDatabase(gameIntegration.ItemDatabase)
    .WithCondition(new MinimumLevelCondition(10))
    .WithCondition(new RandomChanceCondition(0.1f));

// Create modifiers
var luckModifier = new QuantityModifier("luck_bonus", 1.5f)
    .WithCondition(new PlayerLuckCondition(50));

// Apply modifiers to drops
var enhancedDrop = new ItemDrop("sword_iron", 10.0f, ItemRarity.Common)
    .WithItemDatabase(gameIntegration.ItemDatabase)
    .WithModifier(luckModifier);
```

## Integration Patterns

### 1. Unity Integration

```csharp
public class UnityItemDropsManager : MonoBehaviour
{
    [SerializeField] private ItemDatabaseSO _itemDatabase;
    [SerializeField] private InventoryManager _inventoryManager;

    private IItemDropsGameIntegration _integration;

    private void Awake()
    {
        _integration = new UnityGameIntegration(_itemDatabase, _inventoryManager);
    }

    public void GenerateLoot(GameObject source)
    {
        var context = new DropContext();
        context.SetData("PlayerLevel", Player.Instance.Level);
        context.SetData("Location", currentScene.name);
        context.SetData("Source", source.name);

        var drops = GetDropTableForSource(source).GenerateDrops(context);
        var processedDrops = _integration.ProcessDrops(drops.Drops, context);

        foreach (var drop in processedDrops)
        {
            _inventoryManager.AddItem(drop);
        }
    }
}
```

### 2. Godot Integration

```csharp
public partial class ItemDropsManager : Node
{
    [Export] private ItemDatabaseResource _itemDatabase;
    [Export] private InventorySystem _inventory;

    private IItemDropsGameIntegration _integration;

    public override void _Ready()
    {
        _integration = new GodotGameIntegration(_itemDatabase, _inventory);
    }

    public void GenerateEnemyLoot(Node enemy)
    {
        var context = new DropContext();
        context.SetData("PlayerLevel", GameState.PlayerLevel);
        context.SetData("Location", GetTree().CurrentScene.Name);
        context.SetData("Source", enemy.Name);

        var drops = GetDropTableForEnemy(enemy).GenerateDrops(context);
        var processedDrops = _integration.ProcessDrops(drops.Drops, context);

        foreach (var drop in processedDrops)
        {
            _inventory.AddItem(drop);
        }
    }
}
```

## Best Practices

### 1. Lazy Loading

Load item data only when needed:

```csharp
public class LazyItemDatabase : IItemDatabase
{
    private readonly Dictionary<string, IItemData> _cache = new();
    private readonly IItemLoader _loader;

    public IItemData? GetItemData(string itemId)
    {
        if (_cache.TryGetValue(itemId, out var cached))
            return cached;

        var itemData = _loader.LoadItem(itemId);
        if (itemData != null)
            _cache[itemId] = itemData;

        return itemData;
    }
}
```

### 2. Validation

Always validate integrations:

```csharp
public void ValidateIntegration()
{
    if (!_gameIntegration.IsValid())
    {
        Debug.LogError("Game integration is not valid!");
        return;
    }

    // Test with a sample drop
    var testDrop = new ItemDrop("test_item", 1.0f);
    var testContext = new DropContext();
    
    if (!testDrop.CanDrop(testContext))
    {
        Debug.LogWarning("Test drop failed validation");
    }
}
```

### 3. Performance

Optimize for high-frequency operations:

```csharp
public class OptimizedGameIntegration : IItemDropsGameIntegration
{
    private readonly Dictionary<string, IItemInfo> _itemInfoCache = new();

    public DropInstance CustomizeDrop(DropInstance drop, DropContext context)
    {
        // Use cached item info
        if (!_itemInfoCache.TryGetValue(drop.ItemId, out var itemInfo))
        {
            itemInfo = ItemDatabase.GetItemInfo(drop.ItemId);
            _itemInfoCache[drop.ItemId] = itemInfo;
        }

        // Fast customization with cached data
        return CustomizeDropFast(drop, context, itemInfo);
    }
}
```

## Troubleshooting

### Common Issues

1. **Items not found in database**
   - Ensure item IDs match between ItemDrops and your database
   - Check that `HasItem()` returns true for your items

2. **ID resolution failures**
   - Verify mappings are registered in `IItemIdResolver`
   - Check system names match between resolver and calls

3. **Inventory rejections**
   - Ensure `CanAcceptDrops()` properly checks capacity
   - Verify `AddDrops()` handles all edge cases

### Debugging

Enable debug logging:

```csharp
public class DebugGameIntegration : IItemDropsGameIntegration
{
    public IEnumerable<DropInstance> ProcessDrops(IEnumerable<DropInstance> drops, DropContext context)
    {
        Debug.Log($"Processing {drops.Count()} drops in context: {context}");
        
        foreach (var drop in drops)
        {
            Debug.Log($"Processing drop: {drop.ItemId} x{drop.Quantity}");
        }

        var processed = base.ProcessDrops(drops, context);
        Debug.Log($"Processed {processed.Count()} drops successfully");
        
        return processed;
    }
}
```

## Migration from Existing Systems

If you have an existing drop system:

1. **Map existing item IDs** to ItemDrops IDs using `IItemIdResolver`
2. **Create adapters** for your existing inventory system
3. **Gradually migrate** drop tables to use ItemDrops configuration
4. **Test thoroughly** with existing save data

## Conclusion

The ItemDrops integration system provides a clean, flexible boundary between drop generation and inventory management. By implementing the core interfaces, you can connect ItemDrops to any existing system while maintaining separation of concerns and testability.

The key benefits are:
- **Agnostic integration** - Works with any inventory system
- **Clean boundaries** - Clear separation between systems
- **Extensible** - Easy to add new features and modifiers
- **Testable** - Each component can be tested independently
