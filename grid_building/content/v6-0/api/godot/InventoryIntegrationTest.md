---
title: "InventoryIntegrationTest"
description: "Integration test scene for GridBuilding Inventory system
Tests the complete integration between inventory, GridBuilding plugin, and Godot engine"
weight: 20
url: "/gridbuilding/v6-0/api/godot/inventoryintegrationtest/"
---

# InventoryIntegrationTest

```csharp
GridBuilding.Godot.Test
class InventoryIntegrationTest
{
    // Members...
}
```

Integration test scene for GridBuilding Inventory system
Tests the complete integration between inventory, GridBuilding plugin, and Godot engine

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Fixtures/InventoryIntegrationTest.cs`  
**Namespace:** `GridBuilding.Godot.Test`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            GD.Print("=== GridBuilding Inventory Integration Test Started ===");
            
            SetupTestEnvironment();
            RunIntegrationTests();
        }
```

**Returns:** `void`

