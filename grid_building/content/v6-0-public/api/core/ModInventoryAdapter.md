---
title: "ModInventoryAdapter"
description: "Mod inventory system adapter"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/modinventoryadapter/"
---

# ModInventoryAdapter

```csharp
GridBuilding.Core.Integration
class ModInventoryAdapter
{
    // Members...
}
```

Mod inventory system adapter

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
                mod_id = ExtractModId(placeable),
                item_id = placeable.Id,
                name = placeable.Name,
                description = placeable.Description,
                category = placeable.Category.ToString(),
                stack_size = DetermineModStackSize(placeable),
                mod_specific = new Dictionary<string, object>
                {
                    ["version"] = placeable.Version,
                    ["external_refs"] = placeable.ExternalReferences.References,
                    ["tags"] = placeable.Tags,
                    ["properties"] = placeable.Properties
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
            var modId = ExtractModId(placeable);
            return Result<string>.Success($"{modId}_{placeable.Id}");
        }
```

**Returns:** `Result<string>`

**Parameters:**
- `PlaceableDefinition placeable`

### ValidateCompatibility

```csharp
public Result<bool> ValidateCompatibility(PlaceableDefinition placeable, string inventoryType)
        {
            var modId = ExtractModId(placeable);
            return Result<bool>.Success(!string.IsNullOrEmpty(modId));
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
            return new[] { "mod_inventory" };
        }
```

**Returns:** `IEnumerable<string>`

