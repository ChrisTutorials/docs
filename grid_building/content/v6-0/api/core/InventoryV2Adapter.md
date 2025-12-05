---
title: "InventoryV2Adapter"
description: "Inventory v2 system adapter"
weight: 10
url: "/gridbuilding/v6-0/api/core/inventoryv2adapter/"
---

# InventoryV2Adapter

```csharp
GridBuilding.Core.Integration
class InventoryV2Adapter
{
    // Members...
}
```

Inventory v2 system adapter

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Integration/InventorySystemFactory.cs`  
**Namespace:** `GridBuilding.Core.Integration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CanAddToInventory

```csharp
public Result<bool> CanAddToInventory(string placeableId, object inventorySystem)
        {
            return Result<bool>.Success(true);
        }
```

**Returns:** `Result<bool>`

**Parameters:**
- `string placeableId`
- `object inventorySystem`

### CreateInventoryItem

```csharp
public Result<object> CreateInventoryItem(PlaceableDefinition placeable)
        {
            var item = new
            {
                item_id = placeable.Id,
                display_name = placeable.Name,
                item_category = placeable.Category.ToString(),
                max_stack = 99,
                rarity = DetermineRarity(placeable),
                metadata = new Dictionary<string, object>
                {
                    ["description"] = placeable.Description,
                    ["tags"] = placeable.Tags,
                    ["external_refs"] = placeable.ExternalReferences
                }
            };
            return Result<object>.Success(item);
        }
```

**Returns:** `Result<object>`

**Parameters:**
- `PlaceableDefinition placeable`

### GetInventoryItemId

```csharp
public Result<string> GetInventoryItemId(PlaceableDefinition placeable)
        {
            return Result<string>.Success($"inv_v2_{placeable.Id}");
        }
```

**Returns:** `Result<string>`

**Parameters:**
- `PlaceableDefinition placeable`

### ValidateCompatibility

```csharp
public Result<bool> ValidateCompatibility(PlaceableDefinition placeable, string inventoryType)
        {
            return Result<bool>.Success(placeable.Category != PlaceableCategory.Unknown);
        }
```

**Returns:** `Result<bool>`

**Parameters:**
- `PlaceableDefinition placeable`
- `string inventoryType`

### GetSupportedInventoryTypes

```csharp
public IEnumerable<string> GetSupportedInventoryTypes()
        {
            return new[] { "inventory_v2", "default" };
        }
```

**Returns:** `IEnumerable<string>`

