---
title: "InventorySystemFactory"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/inventorysystemfactory/"
---

# InventorySystemFactory

```csharp
GridBuilding.Core.Integration
class InventorySystemFactory
{
    // Members...
}
```

Factory for creating inventory system adapters

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Integration/InventorySystemFactory.cs`  
**Namespace:** `GridBuilding.Core.Integration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### CreateAdapter

```csharp
/// <summary>
        /// Creates an inventory adapter for the specified type
        /// </summary>
        public static Result<IPlaceableInventoryAdapter> CreateAdapter(string inventoryType)
        {
            try
            {
                if (string.IsNullOrEmpty(inventoryType))
                    return Result<IPlaceableInventoryAdapter>.Failure("Inventory type cannot be null or empty");

                if (!_adapterFactories.TryGetValue(inventoryType, out var factory))
                {
                    return Result<IPlaceableInventoryAdapter>.Failure($"Inventory type not supported: {inventoryType}");
                }

                var adapter = factory();
                if (adapter == null)
                {
                    return Result<IPlaceableInventoryAdapter>.Failure($"Factory returned null adapter for type: {inventoryType}");
                }

                return Result<IPlaceableInventoryAdapter>.Success(adapter);
            }
            catch (Exception ex)
            {
                return Result<IPlaceableInventoryAdapter>.Failure($"Failed to create inventory adapter: {ex.Message}");
            }
        }
```

Creates an inventory adapter for the specified type

**Returns:** `Result<IPlaceableInventoryAdapter>`

**Parameters:**
- `string inventoryType`

### ValidateInventoryCompatibility

```csharp
/// <summary>
        /// Validates inventory compatibility
        /// </summary>
        public static Result<bool> ValidateInventoryCompatibility(string inventoryType, PlaceableDefinition placeable)
        {
            try
            {
                var adapterResult = CreateAdapter(inventoryType);
                if (!adapterResult.Success)
                    return Result<bool>.Failure($"Failed to create adapter for validation: {adapterResult.Error}");

                return adapterResult.Value.ValidateCompatibility(placeable, inventoryType);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Inventory compatibility validation failed: {ex.Message}");
            }
        }
```

Validates inventory compatibility

**Returns:** `Result<bool>`

**Parameters:**
- `string inventoryType`
- `PlaceableDefinition placeable`

### GetSupportedInventoryTypes

```csharp
/// <summary>
        /// Gets supported inventory system types
        /// </summary>
        public static IEnumerable<string> GetSupportedInventoryTypes()
        {
            return _adapterFactories.Keys;
        }
```

Gets supported inventory system types

**Returns:** `IEnumerable<string>`

### RegisterAdapter

```csharp
/// <summary>
        /// Registers a custom inventory adapter factory
        /// </summary>
        public static Result<bool> RegisterAdapter(string inventoryType, Func<IPlaceableInventoryAdapter> factory)
        {
            try
            {
                if (string.IsNullOrEmpty(inventoryType))
                    return Result<bool>.Failure("Inventory type cannot be null or empty");

                if (factory == null)
                    return Result<bool>.Failure("Factory cannot be null");

                _adapterFactories[inventoryType] = factory;
                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Failed to register adapter: {ex.Message}");
            }
        }
```

Registers a custom inventory adapter factory

**Returns:** `Result<bool>`

**Parameters:**
- `string inventoryType`
- `Func<IPlaceableInventoryAdapter> factory`

### IsSupported

```csharp
/// <summary>
        /// Checks if inventory type is supported
        /// </summary>
        public static bool IsSupported(string inventoryType)
        {
            return !string.IsNullOrEmpty(inventoryType) && _adapterFactories.ContainsKey(inventoryType);
        }
```

Checks if inventory type is supported

**Returns:** `bool`

**Parameters:**
- `string inventoryType`

### CreateMultipleAdapters

```csharp
/// <summary>
        /// Creates multiple adapters for batch operations
        /// </summary>
        public static Result<Dictionary<string, IPlaceableInventoryAdapter>> CreateMultipleAdapters(IEnumerable<string> inventoryTypes)
        {
            try
            {
                var adapters = new Dictionary<string, IPlaceableInventoryAdapter>();
                var errors = new List<string>();

                foreach (var type in inventoryTypes)
                {
                    var adapterResult = CreateAdapter(type);
                    if (adapterResult.Success)
                    {
                        adapters[type] = adapterResult.Value;
                    }
                    else
                    {
                        errors.Add($"{type}: {adapterResult.Error}");
                    }
                }

                if (errors.Any())
                {
                    return Result<Dictionary<string, IPlaceableInventoryAdapter>>.Failure(
                        $"Failed to create some adapters: {string.Join(", ", errors)}");
                }

                return Result<Dictionary<string, IPlaceableInventoryAdapter>>.Success(adapters);
            }
            catch (Exception ex)
            {
                return Result<Dictionary<string, IPlaceableInventoryAdapter>>.Failure(
                    $"Failed to create multiple adapters: {ex.Message}");
            }
        }
```

Creates multiple adapters for batch operations

**Returns:** `Result<Dictionary<string, IPlaceableInventoryAdapter>>`

**Parameters:**
- `IEnumerable<string> inventoryTypes`

