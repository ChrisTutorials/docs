# Migration Guide: From Resources to Data-Driven

## Overview

This guide helps you migrate from Resource-based drop tables to the superior data-driven approach. The migration is designed to be gradual, allowing you to convert tables at your own pace.

## Why Migrate?

| Resource Arrays | Data-Driven |
|-----------------|-------------|
| ❌ Multiple scattered `.tres` files | ✅ Single JSON/YAML file |
| ❌ Click-heavy editor experience | ✅ Searchable, readable configuration |
| ❌ Runtime-only validation | ✅ Compile-time + runtime validation |
| ❌ Version control noise | ✅ Clean, meaningful diffs |
| ❌ Complex backup/export | ✅ Single file export |

## Migration Strategies

### 1. Gradual Migration (Recommended)

Use `HybridDropTable` to support both approaches during transition:

```csharp
// Existing code continues to work
var dropTable = GD.Load<DropTable>("res://data/drops/goblin_loot.tres");

// New data-driven tables can be added
var hybridTable = new HybridDropTable
{
    ConfigurationPath = "res://data/drops/goblin_loot.json" // Switch when ready
};
```

### 2. Complete Migration

Convert all tables at once for immediate benefits.

## Step-by-Step Migration

### Step 1: Install the Migration Tools

The `HybridDropTable` class includes conversion utilities:

```csharp
using ItemDrops.Godot.Resources;
```

### Step 2: Identify Resource Tables

Find all existing drop table resources:

```bash
# Find all DropTable resources
find . -name "*.tres" -exec grep -l "DropTable" {} \;
```

Common locations:
- `res://data/drops/`
- `res://resources/loot/`
- `res://enemies/`

### Step 3: Convert a Single Table

#### Method A: Using the Editor Plugin

1. Open Godot with the ItemDrops plugin enabled
2. Find the "Drop Tables" dock
3. Click "Convert Resource"
4. Select your `.tres` file
5. Choose output location for `.json` file

#### Method B: Using Code

```csharp
// Create conversion script
public static void ConvertDropTable(string resourcePath, string outputPath)
{
    var resource = GD.Load<DropTable>(resourcePath);
    var hybrid = new HybridDropTable
    {
        MinDrops = resource.MinDrops,
        MaxDrops = resource.MaxDrops,
        DropChance = resource.DropChance,
        Drops = resource.Drops
    };
    
    hybrid.ConvertToDataDriven(outputPath);
    GD.Print($"Converted {resourcePath} to {outputPath}");
}

// Usage
ConvertDropTable("res://data/drops/goblin_loot.tres", "res://data/drops/goblin_loot.json");
```

### Step 4: Verify the Conversion

Check the generated JSON file:

```json
{
  "minDrops": 1,
  "maxDrops": 3,
  "dropChance": 0.8,
  "drops": [
    {
      "itemId": "health_potion",
      "weight": 1.0,
      "rarity": "Common",
      "minQuantity": 1,
      "maxQuantity": 1,
      "conditions": []
    }
  ]
}
```

### Step 5: Update Code References

#### Before (Resource-based)
```csharp
var dropTable = GD.Load<DropTable>("res://data/drops/goblin_loot.tres");
```

#### After (Data-driven)
```csharp
using ItemDrops.Core.DataDriven;

var dropTable = DataDrivenDropTable.LoadFromJson("res://data/drops/goblin_loot.json");
```

#### Or (Hybrid approach)
```csharp
var dropTable = new HybridDropTable
{
    ConfigurationPath = "res://data/drops/goblin_loot.json"
};
```

### Step 6: Test the Migration

```csharp
// Test that drops generate correctly
var context = new LootContext { Level = 10, Luck = 0.5f };
var calculator = new DropCalculator();
var results = calculator.GenerateDrops(dropTable, context);

GD.Print($"Generated {results.Count} drops:");
foreach (var result in results)
{
    GD.Print($"  - {result.ItemId} x{result.Quantity}");
}
```

## Conversion Examples

### Simple Drop Table

#### Resource (`goblin_loot.tres`)
```gdscript
[resource]
script_class = DropTable
min_drops = 1
max_drops = 3
drop_chance = 0.8
possible_drops = [SubResource("DropData_abc123")]

[sub_resource type="DropData" id="DropData_abc123"]
item_id = "gold_coin"
weight = 100.0
rarity = 0
min_quantity = 10
max_quantity = 50
```

#### Data-Driven (`goblin_loot.json`)
```json
{
  "minDrops": 1,
  "maxDrops": 3,
  "dropChance": 0.8,
  "drops": [
    {
      "itemId": "gold_coin",
      "weight": 100.0,
      "rarity": "Common",
      "minQuantity": 10,
      "maxQuantity": 50
    }
  ]
}
```

### Complex Drop Table with Conditions

#### Resource
```gdscript
[sub_resource type="DropData" id="DropData_def456"]
item_id = "magic_sword"
weight = 5.0
rarity = 2
min_quantity = 1
max_quantity = 1
conditions = [SubResource("DropCondition_ghi789")]

[sub_resource type="DropCondition" id="DropCondition_ghi789"]
condition_type = "MinimumLevel"
int_value = 10
```

#### Data-Driven
```json
{
  "drops": [
    {
      "itemId": "magic_sword",
      "weight": 5.0,
      "rarity": "Rare",
      "minQuantity": 1,
      "maxQuantity": 1,
      "conditions": [
        {
          "type": "minimumLevel",
          "value": 10
        }
      ]
    }
  ]
}
```

## Bulk Migration Script

For large projects, use this automated conversion script:

```csharp
// MigrationTool.cs
using Godot;
using ItemDrops.Godot.Resources;
using System;
using System.IO;

public partial class MigrationTool : Node
{
    [Export] public string SourceDirectory { get; set; } = "res://data/drops/";
    [Export] public string TargetDirectory { get; set; } = "res://data/drops_converted/";
    
    public void MigrateAllTables()
    {
        // Ensure target directory exists
        DirAccess.Open(TargetDirectory)?.MakeDirRecursiveAbsolute(TargetDirectory);
        
        // Find all .tres files
        var dir = DirAccess.Open(SourceDirectory);
        if (dir == null)
        {
            GD.PrintErr($"Cannot open source directory: {SourceDirectory}");
            return;
        }
        
        dir.ListDirBegin();
        var fileName = dir.GetNext();
        
        while (!string.IsNullOrEmpty(fileName))
        {
            if (fileName.EndsWith(".tres"))
            {
                var sourcePath = Path.Combine(SourceDirectory, fileName);
                var targetPath = Path.Combine(TargetDirectory, fileName.Replace(".tres", ".json"));
                
                try
                {
                    ConvertTable(sourcePath, targetPath);
                    GD.Print($"Converted: {fileName}");
                }
                catch (Exception ex)
                {
                    GD.PrintErr($"Failed to convert {fileName}: {ex.Message}");
                }
            }
            
            fileName = dir.GetNext();
        }
        
        dir.ListDirEnd();
        GD.Print("Migration complete!");
    }
    
    private void ConvertTable(string sourcePath, string targetPath)
    {
        var resource = GD.Load<DropTable>(sourcePath);
        var hybrid = new HybridDropTable
        {
            MinDrops = resource.MinDrops,
            MaxDrops = resource.MaxDrops,
            DropChance = resource.DropChance,
            Drops = resource.Drops
        };
        
        hybrid.ConvertToDataDriven(targetPath);
    }
}
```

### Using the Migration Tool

1. Create a scene with the `MigrationTool` script
2. Set `SourceDirectory` to your current drop tables location
3. Set `TargetDirectory` to where you want converted files
4. Run the scene and call `MigrateAllTables()`

## Validation and Testing

### Post-Migration Validation

```csharp
public static void ValidateMigration(string originalPath, string convertedPath)
{
    // Load original
    var original = GD.Load<DropTable>(originalPath);
    
    // Load converted
    var converted = DataDrivenDropTable.LoadFromJson(convertedPath);
    
    // Compare basic properties
    Debug.Assert(original.MinDrops == converted.MinDrops, "MinDrops mismatch");
    Debug.Assert(original.MaxDrops == converted.MaxDrops, "MaxDrops mismatch");
    Debug.Assert(Mathf.Abs(original.DropChance - converted.DropChance) < 0.001f, "DropChance mismatch");
    
    // Compare drop counts
    Debug.Assert(original.Drops.Count == converted.Drops.Count, "Drop count mismatch");
    
    GD.Print($"✅ {Path.GetFileName(originalPath)} migrated successfully");
}
```

### Performance Testing

```csharp
public static void BenchmarkPerformance(string dataDrivenPath, string resourcePath)
{
    var stopwatch = new System.Diagnostics.Stopwatch();
    
    // Test data-driven loading
    stopwatch.Restart();
    for (int i = 0; i < 1000; i++)
    {
        var dataTable = DataDrivenDropTable.LoadFromJson(dataDrivenPath);
    }
    stopwatch.Stop();
    GD.Print($"Data-Driven: {stopwatch.ElapsedMilliseconds}ms for 1000 loads");
    
    // Test resource loading
    stopwatch.Restart();
    for (int i = 0; i < 1000; i++)
    {
        var resourceTable = GD.Load<DropTable>(resourcePath);
    }
    stopwatch.Stop();
    GD.Print($"Resource-Based: {stopwatch.ElapsedMilliseconds}ms for 1000 loads");
}
```

## Common Migration Issues

### Issue 1: Missing Conditions

**Problem:** Conditions don't convert properly

**Solution:** Check condition type mapping:

```csharp
// In HybridDropTable.CreateCondition()
private IDropCondition? CreateCondition(DropCondition conditionData)
{
    return conditionData.ConditionType switch
    {
        "MinimumLevel" => new MinimumLevelCondition(conditionData.IntValue),
        "LevelRange" => new LevelRangeCondition(conditionData.IntValue, conditionData.IntValue2),
        // Add more mappings as needed
        _ => throw new ArgumentException($"Unknown condition type: {conditionData.ConditionType}")
    };
}
```

### Issue 2: File Path Issues

**Problem:** Converted files can't be found

**Solution:** Ensure paths are correct and files are imported:

```csharp
// Force reimport after conversion
EditorInterface.Singleton.GetFileSystemDock().ReimportFiles(new[] { outputPath });
```

### Issue 3: Runtime Errors

**Problem:** Drops don't generate after migration

**Solution:** Validate the converted table:

```csharp
var dropTable = DataDrivenDropTable.LoadFromJson(path);
var validation = dropTable.Validate();

if (!validation.IsValid)
{
    foreach (var error in validation.Errors)
    {
        GD.PrintErr($"Validation error: {error}");
    }
}
```

## Rollback Plan

If you need to rollback:

1. **Keep original `.tres` files** until you're confident in the migration
2. **Use version control** to track changes
3. **Test thoroughly** before deleting old files

### Rollback Script

```csharp
public static void RollbackMigration(string convertedDirectory, string backupDirectory)
{
    // Restore from backup if needed
    var sourceDir = DirAccess.Open(backupDirectory);
    var targetDir = DirAccess.Open(convertedDirectory);
    
    // Copy original files back
    // Implementation depends on your backup strategy
}
```

## Best Practices

### 1. Backup First
```bash
# Create backup of original resources
cp -r res://data/drops/ res://data/drops_backup/
```

### 2. Convert Incrementally
- Start with simple tables
- Test each conversion
- Move to more complex tables

### 3. Use Version Control
- Commit changes in logical chunks
- Use descriptive commit messages
- Tag migration milestones

### 4. Document Changes
- Note any custom modifications
- Document conversion decisions
- Keep migration scripts for future reference

## Migration Checklist

- [ ] Backup original Resource files
- [ ] Install ItemDrops plugin with migration tools
- [ ] Identify all drop table resources
- [ ] Convert simple tables first
- [ ] Test converted tables
- [ ] Update code references
- [ ] Convert complex tables
- [ ] Run performance benchmarks
- [ ] Update documentation
- [ ] Remove old Resource files (when confident)

---

**Next:** [Configuration Schema](../reference/schema.md) | [Troubleshooting](../reference/troubleshooting.md) | [Advanced Topics](../advanced/conditions.md)
