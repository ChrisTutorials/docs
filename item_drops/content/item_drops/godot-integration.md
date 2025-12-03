# Godot Integration Guide

## 🎮 Overview

This guide covers integrating the ItemDrops plugin into Godot 4.x games. The Godot integration provides Resource-based configuration, Node-based runtime components, and signal-based event handling.

## 📦 Installation

### Plugin Setup
1. Copy the `ItemDrops` folder to your Godot project's `addons/` directory
2. Enable the plugin in Project Settings → Plugins
3. Configure the ItemDrops settings as needed

### Dependencies
- Godot 4.2+
- .NET 6.0+ (for C# support)
- No external dependencies required

## 🏗️ Architecture

### Godot-Specific Components
```
ItemDrops.Godot/
├── Resources/
│   ├── DropTable.cs           # Resource for drop configuration
│   ├── DropData.cs            # Resource for individual drops
│   ├── DropCondition.cs       # Resource for drop conditions
│   └── ItemDropsBus.cs        # Global drop management
├── Systems/
│   ├── EnemyDrops.cs         # Enemy drop component
│   └── ItemDropNode.cs        # Dropped item node
└── Visuals/
    └── DropEffects.cs         # Visual effects for drops
```

### Integration Pattern
- **Resources**: Configuration data stored as Godot Resources
- **Nodes**: Runtime behavior as Godot Nodes
- **Signals**: Event-driven communication
- **Scene Tree**: Integration with Godot's scene system

## 🚀 Quick Start

### 1. Create a Drop Table
```csharp
// Create a new DropTable resource
var dropTable = new DropTable();
dropTable.MinDrops = 1;
dropTable.MaxDrops = 3;
dropTable.DropChance = 0.8f;

// Add some drops
var swordDrop = new DropData();
swordDrop.ItemId = "sword";
swordDrop.Weight = 2.0f;
swordDrop.Rarity = ItemRarity.Common;
dropTable.Drops.Add(swordDrop);

var potionDrop = new DropData();
potionDrop.ItemId = "health_potion";
potionDrop.Weight = 3.0f;
potionDrop.Rarity = ItemRarity.Common;
dropTable.Drops.Add(potionDrop);

// Save the resource
ResourceSaver.Save(dropTable, "res://data/drops/enemy_drops.tres");
```

### 2. Configure Enemy Drops
```csharp
// Add EnemyDrops component to an enemy
public partial class Enemy : CharacterBody2D
{
    [Export] public DropTable DropTable { get; set; }
    
    public override void _Ready()
    {
        // Configure drop behavior
        var enemyDrops = new EnemyDrops();
        enemyDrops.DropTable = DropTable;
        enemyDrops.AutoGenerateOnDeath = true;
        AddChild(enemyDrops);
    }
}
```

### 3. Handle Drop Events
```csharp
public partial class Player : CharacterBody2D
{
    public override void _Ready()
    {
        // Connect to drop events
        ItemDropsBus.Instance.DropGenerated += OnDropGenerated;
    }
    
    private void OnDropGenerated(string itemId, Vector2 position)
    {
        GD.Print($"Drop generated: {itemId} at {position}");
    }
}
```

## 📋 Resource Configuration

### DropTable Resource
```csharp
[Tool]
public partial class DropTable : Resource, IDropTable
{
    [Export] public Godot.Collections.Array<DropData> Drops { get; set; }
    [Export] public int MinDrops { get; set; } = 1;
    [Export] public int MaxDrops { get; set; } = 1;
    [Export] public float DropChance { get; set; } = 1.0f;
    
    // Methods for drop generation
    public Godot.Collections.Array<Node> GenerateDrops(Vector2 globalPosition)
    public DropTableValidationResult Validate()
}
```

### DropData Resource
```csharp
[Tool]
public partial class DropData : Resource
{
    [Export] public string ItemId { get; set; }
    [Export] public float Weight { get; set; } = 1.0f;
    [Export] public ItemRarity Rarity { get; set; } = ItemRarity.Common;
    [Export] public int MinQuantity { get; set; } = 1;
    [Export] public int MaxQuantity { get; set; } = 1;
    [Export] public Godot.Collections.Array<DropCondition> Conditions { get; set; }
}
```

### DropCondition Resource
```csharp
[Tool]
public partial class DropCondition : Resource
{
    [Export] public string ConditionType { get; set; }
    [Export] public string StringValue { get; set; }
    [Export] public int IntValue { get; set; }
    [Export] public float FloatValue { get; set; }
}
```

## 🎯 Runtime Components

### ItemDropsBus (Global Manager)
```csharp
[Tool]
public partial class ItemDropsBus : Resource
{
    // Singleton instance
    public static ItemDropsBus Instance { get; }
    
    // Default drop tables
    [Export] public DropTable DefaultEnemyDrops { get; set; }
    [Export] public DropTable DefaultBossDrops { get; set; }
    
    // Global configuration
    [Export] public float GlobalLuckModifier { get; set; } = 1.0f;
    
    // Methods
    public void RegisterDropTable(string id, DropTable dropTable)
    public Godot.Collections.Array<Node> GenerateDrops(string tableId, Vector2 position)
    public DropStatistics GetStatistics(string tableId, LootContext? context = null)
    
    // Signals
    [Signal] public delegate void DropGeneratedEventHandler(string itemId, Vector2 position);
    [Signal] public delegate void DropCollectedEventHandler(string itemId, Node collector);
}
```

### EnemyDrops Component
```csharp
[Tool]
public partial class EnemyDrops : Node
{
    [Export] public DropTable DropTable { get; set; }
    [Export] public int LevelOverride { get; set; } = 0;
    [Export] public string EntityTypeOverride { get; set; } = "";
    [Export] public float LuckModifier { get; set; } = 1.0f;
    [Export] public bool AutoGenerateOnDeath { get; set; } = true;
    [Export] public float DropDelay { get; set; } = 0.5f;
    [Export] public bool RandomOffset { get; set; } = true;
    
    // Methods
    public Godot.Collections.Array<Node> GenerateDrops()
    public DropStatistics GetStatistics()
    public void SetDropTable(DropTable dropTable)
}
```

### ItemDropNode (Dropped Item)
```csharp
[Tool]
public partial class ItemDropNode : Node2D
{
    [Export] public string ItemId { get; set; }
    [Export] public ItemRarity Rarity { get; set; }
    [Export] public int Quantity { get; set; } = 1;
    [Export] public bool AutoCollect { get; set; } = false;
    [Export] public float CollectionRange { get; set; } = 50.0f;
    
    // Methods
    public void Configure(DropResult dropResult)
    public void Collect(Node collector)
    public void PlayCollectionEffects()
    
    // Signals
    [Signal] public delegate void CollectedEventHandler(string itemId, Node collector);
    [Signal] public delegate void HoverStartEventHandler(string itemId);
    [Signal] public delegate void HoverEndEventHandler(string itemId);
}
```

## 🎨 Visual Effects

### Drop Effects
```csharp
public partial class DropEffects : Node
{
    // Particle effects for different rarities
    [Export] public PackedScene CommonEffect { get; set; }
    [Export] public PackedScene UncommonEffect { get; set; }
    [Export] public PackedScene RareEffect { get; set; }
    
    // Sound effects
    [Export] public AudioStream DropSound { get; set; }
    [Export] public AudioStream CollectSound { get; set; }
    
    public void PlayDropEffect(Vector2 position, ItemRarity rarity)
    public void PlayCollectEffect(Vector2 position, ItemRarity rarity)
}
```

### Rarity-Based Visuals
```csharp
public static class RarityVisuals
{
    public static Color GetColor(ItemRarity rarity)
    public static float GetGlowIntensity(ItemRarity rarity)
    public static float GetParticleCount(ItemRarity rarity)
    public static AudioStream GetSound(ItemRarity rarity)
}
```

## 📊 Advanced Usage

### Conditional Drops
```csharp
// Create level-based condition
var levelCondition = new DropCondition();
levelCondition.ConditionType = "MinimumLevel";
levelCondition.IntValue = 10;

// Create entity type condition
var entityCondition = new DropCondition();
entityCondition.ConditionType = "EntityType";
entityCondition.StringValue = "dragon";

// Add to drop data
dropData.Conditions.Add(levelCondition);
dropData.Conditions.Add(entityCondition);
```

### Custom Drop Generation
```csharp
public partial class CustomDropGenerator : Node
{
    [Export] public DropTable DropTable { get; set; }
    
    public override void _Ready()
    {
        // Generate drops with custom context
        var context = new LootContext
        {
            Level = 25,
            EntityType = "boss",
            LuckModifier = 2.0f
        };
        
        var drops = DropTable.GenerateDrops(GlobalPosition, context);
        
        foreach (var drop in drops)
        {
            AddChild(drop);
        }
    }
}
```

### Loot Generation with Modifiers
```csharp
// Create custom loot generator
var generator = ItemDropsBus.Instance.CreateLootGenerator(
    "boss_loot",
    new LuckModifier(1.5f),
    new LevelBonusModifier(20, 2.0f),
    new RarityFilterModifier(ItemRarity.Rare)
);

// Generate enhanced loot
var drops = ItemDropsBus.Instance.GenerateLoot(
    "boss_loot",
    "boss_table",
    GlobalPosition
);
```

## 🧪 Testing in Godot

### Unit Tests with GoDotTest
```csharp
[Test]
public void TestDropGeneration()
{
    // Create test drop table
    var dropTable = new DropTable();
    dropTable.AddDrop(new DropData { ItemId = "test_item", Weight = 1.0f });
    
    // Generate drops
    var drops = dropTable.GenerateDrops(Vector2.Zero);
    
    // Assert results
    Assert.That(drops.Count, Is.EqualTo(1));
    Assert.That(drops[0].ItemId, Is.EqualTo("test_item"));
}
```

### Integration Tests
```csharp
[Test]
public void TestEnemyDropGeneration()
{
    // Create test enemy
    var enemy = new Enemy();
    enemy.DropTable = LoadDropTable("test_enemy");
    
    // Simulate death
    enemy.EmitSignal("defeated");
    
    // Verify drops generated
    var drops = GetTree().GetNodesInGroup("drops");
    Assert.That(drops.Count, Is.GreaterThan(0));
}
```

## 🔧 Performance Optimization

### Object Pooling
```csharp
public partial class DropNodePool : Node
{
    private readonly Queue<ItemDropNode> _pool = new();
    
    public ItemDropNode Get()
    {
        if (_pool.Count > 0)
        {
            return _pool.Dequeue();
        }
        
        return CreateNewDropNode();
    }
    
    public void Return(ItemDropNode node)
    {
        node.Reset();
        _pool.Enqueue(node);
    }
}
```

### Batch Processing
```csharp
public override void _Process(double delta)
{
    // Process drops in batches for performance
    var drops = GetTree().GetNodesInGroup("drops");
    
    foreach (var batch in drops.Chunk(10))
    {
        ProcessDropBatch(batch);
    }
}
```

## 🐛 Common Issues & Solutions

### Drop Generation Not Working
**Problem**: Drops not appearing when expected
**Solution**: 
1. Verify drop table is properly configured
2. Check that scene paths are correct
3. Ensure AutoGenerateOnDeath is enabled
4. Verify signal connections

### Performance Issues
**Problem**: Lag when many drops are generated
**Solution**:
1. Use object pooling for drop nodes
2. Limit simultaneous drops
3. Optimize visual effects
4. Use batch processing

### Resource Loading Issues
**Problem**: Drop tables not loading correctly
**Solution**:
1. Check file paths and extensions
2. Verify resources are saved properly
3. Ensure proper export properties
4. Check for circular references

## 📚 Best Practices

### Resource Management
- Save drop tables as .tres files
- Use ResourceLoader for loading
- Implement proper validation
- Cache frequently used tables

### Scene Integration
- Use proper node hierarchy
- Connect signals in _Ready()
- Clean up in _ExitTree()
- Use groups for organization

### Performance
- Pool drop objects
- Limit visual effects
- Use spatial partitioning
- Optimize collision detection

### Debugging
- Enable verbose logging
- Use Godot's debugger
- Profile with Godot profiler
- Test with different drop rates

---

*This guide evolves with the Godot integration development*  
*Last Updated: November 2025*  
*Godot Version: 4.2+*
