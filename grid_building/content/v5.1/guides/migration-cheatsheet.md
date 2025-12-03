---
title: "Migration Cheat Sheet"
description: "Quick reference for Grid Building 5.0.0 to 5.1.0 migration commands and common fixes"
date: 2025-11-30T10:19:00-05:00
weight: 20
draft: false
type: "docs"
layout: "docs"
url: "/v5.1/guides/migration-cheatsheet/"
icon: "fas fa-clipboard-list"
tags: ["migration", "quick-reference", "commands", "troubleshooting"]
---


## 🚀 Quick Start

```bash
# 1. Backup project
git add -A && git commit -m "Pre-migration backup"

# 2. Run migration (dry run first)
./enhanced_migration --dry-run --verbose

# 3. Execute migration
./enhanced_migration --execute --verbose

# 4. Test in Godot
# 5. Commit changes
git add -A && git commit -m "Migrated to Grid Building 5.1.0 C#"
```

## 📋 Essential Commands

### Migration Commands
```bash
# Basic migration
./enhanced_migration --source ./addons/grid_building --target ./addons/grid_building_cs

# With configuration
./enhanced_migration --config migration_config.toml --execute

# Verbose output
./enhanced_migration --verbose --dry-run

# Custom namespace
./enhanced_migration --namespace "MyProject.GridBuilding"
```

### Validation Commands
```bash
# Build C# project
cd addons/grid_building && dotnet build

# Check for errors
dotnet build --verbosity normal

# Run tests
dotnet test
```

## 🔧 Common Fixes

### Missing Using Statements
```csharp
// Add to top of C# files
using Godot;
using YourProject.GridBuilding;
```

### API Changes
```gdscript
# Old (GDScript)
func place_item(item: Node, position: Vector2)
grid_size = Vector2i(10, 10)

# New (C#)
public void PlaceItem(Node item, Vector2 position)
GridSize = new Vector2I(10, 10);
```

### Property Access
```gdscript
# Old
manager.current_item = new_item
var size = manager.grid_size

# New
manager.CurrentItem = newItem;
var size = manager.GridSize;
```

## ⚠️ Critical Points

### MUST DO
- [ ] Close Godot Editor before migration
- [ ] Create backup before starting
- [ ] Run dry run first
- [ ] Test after migration
- [ ] Update custom scripts

### NEVER DO
- [ ] Don't run migration with Godot open
- [ ] Don't skip backup step
- [ ] Don't ignore build errors
- [ ] Don't delete old addon until verified

## 🐛 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| "Can't find class" | Update scene references, check namespaces |
| Build errors | Check `dotnet build` output, fix syntax |
| Performance issues | Verify C# compilation, check profiler |
| Missing methods | Check API migration guide |
| UID errors | Verify scene file updates |

## 📁 File Structure Changes

### Before (5.0.0)
```
addons/
└── grid_building/
    ├── plugin.gd
    ├── scripts/
    │   ├── grid_building_manager.gd
    │   └── placement_manager.gd
    └── scenes/
```

### After (5.1.0)
```
addons/
└── grid_building/
    ├── GridBuilding.csproj
    ├── GridBuildingManager.cs
    ├── PlacementManager.cs
    └── scenes/
```

## 🎯 Performance Tips

### C# Optimizations
```csharp
// Use properties instead of direct access
public Vector2I GridSize { get; set; }

// Use proper types
List<Node> items = new List<Node>();

// Use async for heavy operations
public async Task<void> ProcessLargeGrid()
```

### Memory Management
```csharp
// Dispose resources properly
using var resource = new Resource();

// Avoid memory leaks
public override void _ExitTree()
{
    // Cleanup code
}
```

## 📝 Migration Checklist

### Pre-Migration (5 min)
- [ ] Godot closed? ✓
- [ ] Backup created? ✓
- [ ] .NET installed? ✓
- [ ] Migration tool ready? ✓

### Migration (10-30 min)
- [ ] Dry run successful? ✓
- [ ] Migration executed? ✓
- [ ] No errors reported? ✓
- [ ] Files converted? ✓

### Post-Migration (15-60 min)
- [ ] C# project builds? ✓
- [ ] Godot opens cleanly? ✓
- [ ] Basic functions work? ✓
- [ ] Custom code updated? ✓
- [ ] Performance verified? ✓

## 🔗 Quick Links

- [Full Migration Guide](./MIGRATION_GUIDE_5_0_to_5_1.md)
- [API Reference](./docs/API_REFERENCE.md)
- [Configuration Guide](./enhanced_migration/CONFIGURATION_README.md)
- [Troubleshooting](./docs/TROUBLESHOOTING.md)

## 🆘 Emergency Rollback

```bash
# Quick rollback to previous commit
git reset --hard HEAD~1

# Or restore from backup
cp -r ../backup/grid_building addons/
```

---

**Remember**: Take your time, test thoroughly, and keep backups! 🎮
