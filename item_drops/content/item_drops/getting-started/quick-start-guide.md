# Quick Start Guide - ItemDrops

Get up and running with ItemDrops in 5 minutes! This guide covers installation, basic setup, and your first drop generation.

## 🚀 Installation

### 1. Add ItemDrops to Your Project

#### Option A: Local Plugin (Recommended)
```bash
# Copy ItemDrops to your project
cp -r plugins/ItemDrops path/to/your/project/plugins/
```

#### Option B: Godot Asset Library
1. Open Godot
2. Go to Asset Library
3. Search for "ItemDrops"
4. Click Install

### 2. Enable the Plugin

1. Open `Project > Project Settings > Plugins`
2. Enable "ItemDrops Plugin"
3. Restart Godot

### 3. Verify Installation

You should see:
- "Drop Tables" dock in the editor
- New scripts in your project
- No error messages in the output

## 📁 Project Setup

### Create Data Directory

```
res://data/
└── drops/
    ├── enemies/
    ├── containers/
    └── gathering/
```

### Create Your First Drop Table

Create `res://data/drops/goblin_loot.json`:

```json
{
  "minDrops": 1,
  "maxDrops": 3,
  "dropChance": 0.8,
  "drops": [
    {
      "itemId": "gold_coin",
      "weight": 100,
      "rarity": "Common",
      "minQuantity": 5,
      "maxQuantity": 15
    },
    {
      "itemId": "health_potion",
      "weight": 30,
      "rarity": "Common",
      "minQuantity": 1,
      "maxQuantity": 2
    },
    {
      "itemId": "rusty_dagger",
      "weight": 10,
      "rarity": "Uncommon",
      "minQuantity": 1,
      "maxQuantity": 1
    }
  ]
}
```

## 🎮 Basic Usage

### 1. Create a Simple Enemy

```csharp
// Enemy.cs
using Godot;
using ItemDrops.Core.DataDriven;

public partial class Enemy : CharacterBody2D
{
    [Export] public string DropTablePath { get; set; } = "res://data/drops/goblin_loot.json";
    
    private DataDrivenDropTable _dropTable;
    
    public override void _Ready()
    {
        // Load drop table
        _dropTable = DataDrivenDropTable.LoadFromJson(DropTablePath);
        
        // Validate configuration
        var validation = _dropTable.Validate();
        if (!validation.IsValid)
        {
            GD.PrintErr($"Drop table validation failed: {DropTablePath}");
            foreach (var error in validation.Errors)
            {
                GD.PrintErr($"  - {error}");
            }
        }
    }
    
    public void Die()
    {
        // Generate drops when enemy dies
        GenerateLoot();
        
        // Play death animation
        // ... existing death logic
        
        QueueFree();
    }
    
    private void GenerateLoot()
    {
        // Create context for drop generation
        var context = new LootContext 
        { 
            Level = 10, 
            Luck = 0.5f,
            EntityType = "goblin"
        };
        
        // Generate drops
        var calculator = new DropCalculator();
        var dropResults = calculator.GenerateDrops(_dropTable, context);
        
        // Spawn drops in the world
        foreach (var result in dropResults)
        {
            SpawnDropItem(result);
        }
    }
    
    private void SpawnDropItem(DropResult result)
    {
        // Load item scene
        var scenePath = $"res://scenes/items/{result.ItemId}.tscn";
        if (!ResourceLoader.Exists(scenePath))
        {
            GD.PrintErr($"Item scene not found: {scenePath}");
            return;
        }
        
        var packedScene = GD.Load<PackedScene>(scenePath);
        var node = packedScene.Instantiate() as Node2D;
        
        if (node != null)
        {
            // Position at enemy location with random offset
            var randomOffset = new Vector2(
                GD.Randf() * 50 - 25, 
                GD.Randf() * 50 - 25
            );
            node.GlobalPosition = GlobalPosition + randomOffset;
            
            // Configure the item if it supports it
            if (node is IItemDrop itemDrop)
            {
                itemDrop.Configure(result);
            }
            
            // Add to scene
            GetTree().CurrentScene.AddChild(node);
            node.Owner = GetTree().CurrentScene;
        }
    }
}
```

### 2. Create Item Scenes

#### Health Potion Scene (`res://scenes/items/health_potion.tscn`)
1. Create `Area2D` node
2. Add `CollisionShape2D` with circle shape
3. Add `Sprite2D` with potion icon
4. Attach script:

```csharp
// HealthPotion.cs
using Godot;
using ItemDrops.Core;

public partial class HealthPotion : Area2D, IItemDrop
{
    [Export] public int HealAmount { get; set; } = 20;
    
    public void Configure(DropResult result)
    {
        // Configure based on drop result
        GD.Print($"Health potion created: {result.Quantity}x");
    }
    
    public override void _Ready()
    {
        BodyEntered += OnBodyEntered;
    }
    
    private void OnBodyEntered(Node body)
    {
        if (body is Player player)
        {
            player.Heal(HealAmount);
            QueueFree();
        }
    }
}
```

#### Gold Coin Scene (`res://scenes/items/gold_coin.tscn`)
```csharp
// GoldCoin.cs
using Godot;
using ItemDrops.Core;

public partial class GoldCoin : Area2D, IItemDrop
{
    [Export] public int Value { get; set; } = 1;
    
    public void Configure(DropResult result)
    {
        Value = result.Quantity;
        GD.Print($"Gold coin created: {Value} gold");
    }
    
    public override void _Ready()
    {
        BodyEntered += OnBodyEntered;
    }
    
    private void OnBodyEntered(Node body)
    {
        if (body is Player player)
        {
            player.AddGold(Value);
            QueueFree();
        }
    }
}
```

### 3. Create Player Script

```csharp
// Player.cs
using Godot;

public partial class Player : CharacterBody2D
{
    [Export] public int MaxHealth { get; set; } = 100;
    private int _health;
    private int _gold;
    
    public int Health => _health;
    public int Gold => _gold;
    
    public override void _Ready()
    {
        _health = MaxHealth;
        _gold = 0;
    }
    
    public void Heal(int amount)
    {
        _health = Mathf.Min(_health + amount, MaxHealth);
        GD.Print($"Player healed: {amount}, Health: {_health}/{MaxHealth}");
    }
    
    public void AddGold(int amount)
    {
        _gold += amount;
        GD.Print($"Player gained: {amount} gold, Total: {_gold}");
    }
}
```

## 🎯 Test Your Setup

### 1. Create Test Scene

1. Create a new scene
2. Add a `Player` node with the Player script
3. Add an `Enemy` node with the Enemy script
4. Set the enemy's `DropTablePath` to `"res://data/drops/goblin_loot.json"`
5. Run the scene

### 2. Test Drop Generation

```csharp
// Add this to your enemy script for testing
public override void _Input(InputEvent @event)
{
    if (@event.IsActionPressed("ui_accept")) // Press Enter to test
    {
        GD.Print("Testing drop generation...");
        GenerateLoot();
    }
}
```

### 3. Expected Output

When you kill the enemy (or press Enter), you should see:
```
Health potion created: 1x
Gold coin created: 12 gold
Player healed: 20, Health: 100/100
Player gained: 12 gold, Total: 12
```

## 🔧 Advanced Quick Start

### Add Conditions to Drop Table

Update `goblin_loot.json`:

```json
{
  "minDrops": 1,
  "maxDrops": 3,
  "dropChance": 0.8,
  "drops": [
    {
      "itemId": "gold_coin",
      "weight": 100,
      "rarity": "Common",
      "minQuantity": 5,
      "maxQuantity": 15
    },
    {
      "itemId": "health_potion",
      "weight": 30,
      "rarity": "Common",
      "minQuantity": 1,
      "maxQuantity": 2,
      "conditions": [
        {
          "type": "minimumLevel",
          "value": 5
        }
      ]
    },
    {
      "itemId": "magic_sword",
      "weight": 5,
      "rarity": "Rare",
      "minQuantity": 1,
      "maxQuantity": 1,
      "conditions": [
        {
          "type": "minimumLevel",
          "value": 10
        },
        {
          "type": "randomChance",
          "floatValue": 0.1
        }
      ]
    }
  ]
}
```

### Test Different Contexts

```csharp
// In your enemy script, try different contexts
private void TestDifferentContexts()
{
    var contexts = new[]
    {
        new LootContext { Level = 3, Luck = 0.1f },  // Low level, unlucky
        new LootContext { Level = 10, Luck = 0.5f }, // Mid level, normal luck
        new LootContext { Level = 20, Luck = 0.9f }, // High level, very lucky
    };
    
    foreach (var context in contexts)
    {
        GD.Print($"Testing with Level={context.Level}, Luck={context.Luck}");
        var results = new DropCalculator().GenerateDrops(_dropTable, context);
        
        foreach (var result in results)
        {
            GD.Print($"  - {result.ItemId} x{result.Quantity}");
        }
    }
}
```

## 🎨 Editor Integration

### Using the Drop Table Editor

1. **Open the Editor**: Look for "Drop Tables" in the left dock
2. **Browse Tables**: Navigate to `res://data/drops/`
3. **Edit Tables**: Double-click any `.json` file to edit
4. **Create New**: Click "Create New" to make new tables
5. **Validate**: Click "Validate All" to check all tables

### Real-time Validation

The editor shows:
- ✅ Green check for valid tables
- ⚠️ Yellow warning for minor issues
- ❌ Red X for critical errors

## 🐛 Common Issues

### "Drop table file not found"
- Check file path spelling
- Ensure file exists in project
- Make sure file is imported by Godot

### "Item scene not found"
- Verify scene path matches `itemId`
- Create missing item scenes
- Check scene file extensions (.tscn)

### "No drops generated"
- Check `dropChance` value
- Verify conditions are met
- Ensure `minDrops` > 0

### Performance Issues
- Use data-driven configuration (faster loading)
- Cache drop tables instead of reloading
- Validate tables once at startup

## 📚 Next Steps

### Learn More
- [Data-Driven Configuration](../configuration/data-driven.md) - Advanced configuration
- [Conditions & Modifiers](../advanced/conditions.md) - Complex drop logic
- [Performance Optimization](../advanced/performance.md) - Best practices

### Examples
- [Enemy Examples](../examples/enemies.md) - Different enemy types
- [Container Examples](../examples/containers.md) - Chests and crates
- [Gathering Examples](../examples/gathering.md) - Mining and herb gathering

### Reference
- [Configuration Schema](../reference/schema.md) - Complete reference
- [API Documentation](../reference/core-api.md) - Code reference
- [Troubleshooting](../reference/troubleshooting.md) - Common solutions

## 🎉 Congratulations!

You've successfully:
- ✅ Installed ItemDrops
- ✅ Created your first drop table
- ✅ Set up basic drop generation
- ✅ Tested the system

You're now ready to create more complex loot systems! 

**Happy dropping!** 🎲

---

**Need Help?** Check our [Troubleshooting Guide](../reference/troubleshooting.md) or [Discussions](https://github.com/your-repo/discussions)
