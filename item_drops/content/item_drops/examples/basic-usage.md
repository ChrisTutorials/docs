# Basic Usage Examples

## 🎯 Overview

This section provides practical examples for common ItemDrops use cases. Each example is complete and ready to adapt for your project.

## 📦 Core Library Examples

### Simple Loot Generation
```csharp
using ItemDrops.Core.Generation;
using ItemDrops.Core.Types;
using ItemDrops.Core.Drops;

// Create a loot generator
var lootGenerator = new LootGenerator();

// Create drop context
var context = new DropContext();
context.SetData("PlayerLevel", 10);
context.SetData("LuckModifier", 1.2f);
context.SetData("Location", "Forest");

// Create a simple drop table
var dropTable = new DropTable(1, 3, 0.8f); // 1-3 drops, 80% chance

// Add some items to the drop table
dropTable.AddDrop(new ItemDrop("sword_iron", 2.0f)); // Weight 2.0
dropTable.AddDrop(new ItemDrop("potion_health", 1.5f)); // Weight 1.5
dropTable.AddDrop(new ItemDrop("armor_leather", 1.0f)); // Weight 1.0

// Generate loot
var drops = lootGenerator.GenerateLoot(dropTable, context);

foreach (var drop in drops)
{
    Console.WriteLine($"Dropped: {drop.ItemId} x{drop.Quantity}");
}
```

### Advanced Loot Generation with Modifiers
```csharp
using ItemDrops.Core.Generation;
using ItemDrops.Core.Modifiers;

// Create a loot generator with modifiers
var lootGenerator = new LootGenerator();

// Add luck modifier (increases drop chances)
lootGenerator.AddModifier(new LuckModifier(1.5f));

// Add level bonus modifier (more drops for high-level players)
lootGenerator.AddModifier(new LevelBonusModifier(20, 1.3f)); // Level 20+, 30% more quantity

// Add rarity filter (no common items for bosses)
lootGenerator.AddModifier(new RarityFilterModifier(ItemRarity.Uncommon));

// Create boss context
var bossContext = new DropContext();
bossContext.SetData("PlayerLevel", 25);
bossContext.SetData("LuckModifier", 2.0f);
bossContext.SetData("IsBossFight", true);

// Generate boss loot
var bossDrops = lootGenerator.GenerateLoot(bossDropTable, bossContext);
```

### Multiple Drop Tables
```csharp
// Generate loot from multiple sources
var commonTable = new DropTable(2, 4, 0.9f);
var rareTable = new DropTable(1, 2, 0.3f);
var guaranteedTable = new DropTable(1, 1, 1.0f);

// Add items to each table
commonTable.AddDrop(new ItemDrop("gold_coins", 3.0f));
commonTable.AddDrop(new ItemDrop("potion_health", 2.0f));

rareTable.AddDrop(new ItemDrop("sword_rare", 1.0f));
rareTable.AddDrop(new ItemDrop("armor_epic", 0.8f));

// Guaranteed drops (always drop)
var guaranteedDrops = new List<IDrop>
{
    new ItemDrop("boss_soul", 1.0f) { MinQuantity = 1, MaxQuantity = 1 }
};

// Generate combined loot
var allDrops = lootGenerator.GenerateLootWithGuaranteed(
    new[] { commonTable, rareTable }, 
    guaranteedDrops, 
    bossContext
);
```

### Custom Game Integration
```csharp
using ItemDrops.Core.Examples;

// Set up game integration
var itemProvider = new ExampleItemProvider();
var idResolver = new ExampleItemIdResolver();
var inventoryIntegration = new ExampleInventoryIntegration();
var oddsResolver = new ExampleDropOddsResolver();

var gameIntegration = new ExampleGameIntegration(
    itemProvider, 
    idResolver, 
    inventoryIntegration, 
    oddsResolver
);

// Process drops through game systems
var rawDrops = lootGenerator.GenerateLoot(dropTable, context);
var processedDrops = gameIntegration.ProcessDrops(rawDrops, context);

foreach (var drop in processedDrops)
{
    // Add to player inventory
    inventoryIntegration.AddItem(drop.ItemId, drop.Quantity);
}
```

## 🎯 Context-Based Drops

### Level-Dependent Drops
```csharp
public DropResult GenerateLevelAppropriateDrop(int playerLevel, int areaLevel)
{
    var context = new DropContext();
    context.SetData("PlayerLevel", playerLevel);
    context.SetData("AreaLevel", areaLevel);
    context.SetData("LevelDifference", areaLevel - playerLevel);
    
    // Choose drop table based on level difference
    IDropTable dropTable;
    if (areaLevel > playerLevel + 10)
        dropTable = highLevelTable; // Tough areas
    else if (areaLevel < playerLevel - 5)
        dropTable = lowLevelTable;  // Easy areas
    else
        dropTable = balancedTable; // Appropriate challenge
    
    var drops = lootGenerator.GenerateLoot(dropTable, context);
    return drops.FirstOrDefault();
}
```

### Luck-Modified Drops
```csharp
public List<DropResult> GenerateLuckyDrops(float luckModifier, DropContext baseContext)
{
    var luckyContext = new DropContext();
    foreach (var kvp in baseContext.Data)
    {
        luckyContext.SetData(kvp.Key, kvp.Value);
    }
    
    // Apply luck bonus
    var currentLuck = baseContext.GetData<float>("LuckModifier", 1.0f);
    luckyContext.SetData("LuckModifier", currentLuck * luckModifier);
    
    // Use luck modifier for better drops
    var luckyGenerator = new LootGenerator();
    luckyGenerator.AddModifier(new LuckModifier(luckModifier));
    
    return luckyGenerator.GenerateLoot(dropTable, luckyContext);
}
```

## 🧪 Testing Examples

### Unit Testing Drop Generation
```csharp
using Xunit;
using ItemDrops.Core.Generation;
using ItemDrops.Core.Types;

public class LootGeneratorTests
{
    [Fact]
    public void GenerateLoot_ShouldRespectWeights()
    {
        // Arrange
        var generator = new LootGenerator(42); // Fixed seed for reproducibility
        var dropTable = new DropTable(1, 1, 1.0f);
        
        dropTable.AddDrop(new ItemDrop("common", 9.0f));  // 90% weight
        dropTable.AddDrop(new ItemDrop("rare", 1.0f));    // 10% weight
        
        var context = new DropContext();
        
        // Act
        var results = new List<string>();
        for (int i = 0; i < 1000; i++)
        {
            var drops = generator.GenerateLoot(dropTable, context);
            results.Add(drops.First().ItemId);
        }
        
        // Assert
        var commonCount = results.Count(id => id == "common");
        var rareCount = results.Count(id => id == "rare");
        
        Assert.True(commonCount > 850 && commonCount < 950); // ~90%
        Assert.True(rareCount > 50 && rareCount < 150);      // ~10%
    }
    
    [Fact]
    public void GenerateLoot_WithLuckModifier_ShouldIncreaseQuantity()
    {
        // Arrange
        var normalGenerator = new LootGenerator(42);
        var luckyGenerator = new LootGenerator(42);
        luckyGenerator.AddModifier(new LuckModifier(2.0f));
        
        var dropTable = new DropTable(1, 3, 1.0f);
        dropTable.AddDrop(new ItemDrop("test_item", 1.0f));
        
        var context = new DropContext();
        
        // Act
        var normalDrops = normalGenerator.GenerateLoot(dropTable, context);
        var luckyDrops = luckyGenerator.GenerateLoot(dropTable, context);
        
        // Assert
        Assert.True(luckyDrops.Sum(d => d.Quantity) >= normalDrops.Sum(d => d.Quantity));
    }
}
```

---

*These examples are based on the actual ItemDrops C# API*  
*Last Updated: December 2025*  
*Version: 1.0*
