---
title: "DefaultInventoryAdapter"
description: "Default inventory system adapter"
weight: 10
url: "/gridbuilding/v6-0/api/core/defaultinventoryadapter/"
---

# DefaultInventoryAdapter

```csharp
GridBuilding.Core.Integration
class DefaultInventoryAdapter
{
    // Members...
}
```

Default inventory system adapter

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
                id = placeable.Id,
                name = placeable.Name,
                category = placeable.Category.ToString(),
                stack_size = 64,
                properties = placeable.Properties
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
            return Result<string>.Success(placeable.Id);
        }
```

**Returns:** `Result<string>`

**Parameters:**
- `PlaceableDefinition placeable`

### ValidateCompatibility

```csharp
public Result<bool> ValidateCompatibility(PlaceableDefinition placeable, string inventoryType)
        {
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
            return new[] { "default" };
        }
```

**Returns:** `IEnumerable<string>`

