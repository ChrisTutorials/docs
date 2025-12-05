---
title: "AdvancedInventoryAdapter"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/advancedinventoryadapter/"
---

# AdvancedInventoryAdapter

```csharp
GridBuilding.Core.Integration
class AdvancedInventoryAdapter
{
    // Members...
}
```

Advanced inventory system adapter

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
            // Advanced validation logic
            return Result<bool>.Success(!string.IsNullOrEmpty(placeableId));
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
                uuid = Guid.NewGuid().ToString(),
                template_id = placeable.Id,
                name = placeable.Name,
                description = placeable.Description,
                category = placeable.Category.ToString(),
                tier = DetermineTier(placeable),
                stack_limit = 255,
                weight = CalculateWeight(placeable),
                attributes = new Dictionary<string, object>
                {
                    ["can_rotate"] = placeable.CanRotate,
                    ["can_mirror"] = placeable.CanMirror,
                    ["size"] = new { width = placeable.Size.Width, height = placeable.Size.Height },
                    ["resource_cost"] = placeable.ResourceCost,
                    ["tags"] = placeable.Tags,
                    ["external_references"] = placeable.ExternalReferences.References
                },
                created_at = DateTime.UtcNow,
                version = placeable.Version
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
            return Result<string>.Success($"adv_{placeable.Id}_{placeable.Version}");
        }
```

**Returns:** `Result<string>`

**Parameters:**
- `PlaceableDefinition placeable`

### ValidateCompatibility

```csharp
public Result<bool> ValidateCompatibility(PlaceableDefinition placeable, string inventoryType)
        {
            if (placeable.Category == PlaceableCategory.Unknown)
                return Result<bool>.Failure("Unknown category not supported");

            if (string.IsNullOrEmpty(placeable.Id))
                return Result<bool>.Failure("Placeable ID is required");

            return Result<bool>.Success(true);
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
            return new[] { "advanced_inventory", "inventory_v2", "default" };
        }
```

**Returns:** `IEnumerable<string>`

