# Data-Driven Drop Tables ⭐ Recommended

## Overview

Data-driven drop tables use JSON/YAML configuration files instead of Godot Resource arrays. This approach provides superior editor experience, better maintainability, and improved performance.

## Why Choose Data-Driven?

| ✅ Benefits | ❌ Problems with Resources |
|------------|---------------------------|
| Single file per drop table | Multiple scattered Resource files |
| Version control friendly | Noisy diffs, file fragmentation |
| Searchable and readable | Click-heavy editor experience |
| Compile-time validation | Runtime-only validation |
| Easy backup/export | Complex file collection |
| Better performance | Multiple resource loads |

## Quick Start

### 1. Create a Drop Table File

Create `res://data/drops/goblin_loot.json`:

```json
{
  "minDrops": 1,
  "maxDrops": 3,
  "dropChance": 0.8,
  "drops": [
    {
      "itemId": "health_potion",
      "weight": 50,
      "rarity": "Common",
      "minQuantity": 1,
      "maxQuantity": 2,
      "conditions": [
        {
          "type": "minimumLevel",
          "value": 1
        }
      ]
    },
    {
      "itemId": "gold_coin",
      "weight": 100,
      "rarity": "Common",
      "minQuantity": 10,
      "maxQuantity": 50
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

### 2. Use in Code

```csharp
using ItemDrops.Core.DataDriven;

// Load the drop table
var dropTable = DataDrivenDropTable.LoadFromJson("res://data/drops/goblin_loot.json");

// Create context for drop generation
var context = new LootContext 
{ 
    Level = 15, 
    Luck = 0.5f,
    EntityType = "goblin"
};

// Generate drops
var dropCalculator = new DropCalculator();
var dropResults = dropCalculator.GenerateDrops(dropTable, context);

// Spawn drops in the world
foreach (var result in dropResults)
{
    var scenePath = $"res://scenes/items/{result.ItemId}.tscn";
    var packedScene = GD.Load<PackedScene>(scenePath);
    var node = packedScene.Instantiate() as Node2D;
    
    if (node != null)
    {
        node.GlobalPosition = globalPosition;
        GetTree().CurrentScene.AddChild(node);
    }
}
```

## Configuration Schema

### Drop Table Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `minDrops` | `int` | `1` | Minimum drops to generate |
| `maxDrops` | `int` | `1` | Maximum drops to generate |
| `dropChance` | `float` | `1.0` | Overall chance (0.0-1.0) |
| `drops` | `array` | `[]` | List of drop configurations |
| `inherits` | `string` | `null` | Inherit from another table |
| `metadata` | `object` | `{}` | Custom metadata |

### Drop Configuration

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `itemId` | `string` | Required | Unique item identifier |
| `weight` | `float` | `1.0` | Selection weight (higher = more common) |
| `rarity` | `string` | `"Common"` | Item rarity tier |
| `minQuantity` | `int` | `1` | Minimum quantity to drop |
| `maxQuantity` | `int` | `1` | Maximum quantity to drop |
| `conditions` | `array` | `[]` | Drop conditions |
| `metadata` | `object` | `{}` | Custom drop metadata |

### Condition Types

| Type | Properties | Description |
|------|------------|-------------|
| `minimumLevel` | `value: int` | Requires minimum level |
| `levelRange` | `value: int`, `value2: int` | Requires level range |
| `entityType` | `stringValue: string` | Requires specific entity type |
| `luck` | `floatValue: float` | Requires minimum luck |
| `randomChance` | `floatValue: float` | Random chance check |
| `timeOfDay` | `stringValue: string` | Requires time of day |
| `customData` | `stringValue: string`, `floatValue: float` | Custom data condition |

## Advanced Features

### Table Inheritance

```json
{
  "inherits": "base_enemy_loot",
  "minDrops": 2,
  "drops": [
    {
      "itemId": "goblin_ear",
      "weight": 30,
      "minQuantity": 1,
      "maxQuantity": 2
    }
  ]
}
```

### Metadata Support

```json
{
  "metadata": {
    "author": "Game Designer",
    "version": "1.2",
    "notes": "Balanced for level 10-15 players"
  },
  "drops": [
    {
      "itemId": "special_item",
      "weight": 1,
      "metadata": {
        "source": "boss_drop",
        "tooltip": "Rare boss item"
      }
    }
  ]
}
```

### YAML Support (Coming Soon)

```yaml
minDrops: 1
maxDrops: 3
dropChance: 0.8
drops:
  - itemId: health_potion
    weight: 50
    minQuantity: 1
    maxQuantity: 2
    conditions:
      - type: minimumLevel
        value: 1
```

## Editor Integration

### Custom Editor Plugin

ItemDrops includes a custom Godot editor plugin that provides:

- **Visual Drop Table Manager**: Browse and edit all drop tables
- **Real-time Validation**: Instant feedback on configuration errors
- **Search & Filter**: Quickly find specific drop tables
- **Conversion Tools**: Migrate from Resource-based configuration
- **Preview Mode**: See drop probabilities and statistics

### Accessing the Editor

1. Enable the plugin in Godot's Project Settings
2. Look for "Drop Tables" in the left dock panel
3. Browse your `res://data/drops/` folder
4. Double-click to edit, or use the Create/Convert buttons

## Performance Benefits

### Loading Performance

```csharp
// Data-Driven: Single file load
var dataTable = DataDrivenDropTable.LoadFromJson("res://data/drops/goblin_loot.json");

// vs Resource-Based: Multiple resource loads
var resourceTable = GD.Load<DropTable>("res://data/drops/goblin_loot.tres");
foreach (var drop in resourceTable.Drops) // Each drop is a separate resource
{
    // Additional resource loading...
}
```

### Runtime Performance

- **Single Parse**: Configuration parsed once at load time
- **Cached Objects**: Drop objects created and reused
- **No Runtime Reflection**: All types resolved at compile time
- **Memory Efficient**: No duplicate resource instances

## Best Practices

### File Organization

```
res://data/drops/
├── enemies/
│   ├── goblin_loot.json
│   ├── orc_loot.json
│   └── dragon_loot.json
├── containers/
│   ├── chest_common.json
│   ├── chest_rare.json
│   └── chest_epic.json
├── gathering/
│   ├── herb_gathering.json
│   └── mining_drops.json
└── global/
    ├── base_enemy_loot.json
    └── rarity_modifiers.json
```

### Naming Conventions

- Use descriptive, lowercase names: `goblin_loot.json`
- Group by category: `enemies/`, `containers/`, `gathering/`
- Use inheritance for common patterns: `base_enemy_loot.json`

### Validation

```csharp
// Always validate drop tables
var dropTable = DataDrivenDropTable.LoadFromJson(path);
var validation = dropTable.Validate();

if (!validation.IsValid)
{
    GD.PrintErr($"Drop table validation failed: {path}");
    foreach (var error in validation.Errors)
    {
        GD.PrintErr($"  - {error}");
    }
    return;
}
```

## Migration from Resources

See the [Migration Guide](../configuration/migration.md) for step-by-step instructions on converting existing Resource-based drop tables to the data-driven approach.

## Troubleshooting

### Common Issues

**"Drop table file not found"**
- Check file path and extension
- Ensure file is included in Godot's import settings

**"Unknown condition type"**
- Verify condition type spelling (case-sensitive)
- Check supported condition types in schema

**"JSON parse error"**
- Validate JSON syntax using online validator
- Check for trailing commas and missing quotes

### Debug Tools

```csharp
// Enable debug logging
var context = new LootContext { Level = 10, Luck = 0.5f };
var results = dropCalculator.GenerateDrops(dropTable, context);

GD.Print($"Generated {results.Count} drops from {dropTable.Drops.Count} possibilities");
foreach (var result in results)
{
    GD.Print($"  - {result.ItemId} x{result.Quantity} (rarity: {result.Rarity})");
}
```

---

**Next:** [Migration Guide](./migration.md) | [Configuration Schema](../reference/schema.md) | [Advanced Topics](../advanced/conditions.md)
