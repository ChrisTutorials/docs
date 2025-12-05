---
title: "PlaceableIntegrationManager"
description: "Main integration coordinator for external systems"
weight: 10
url: "/gridbuilding/v6-0/api/core/placeableintegrationmanager/"
---

# PlaceableIntegrationManager

```csharp
GridBuilding.Core.Integration
class PlaceableIntegrationManager
{
    // Members...
}
```

Main integration coordinator for external systems

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Integration/PlaceableIntegrationManager.cs`  
**Namespace:** `GridBuilding.Core.Integration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### RegisterInventorySystem

```csharp
/// <summary>
        /// Registers an inventory system adapter
        /// </summary>
        public Result<bool> RegisterInventorySystem(string name, IPlaceableInventoryAdapter adapter)
        {
            try
            {
                if (string.IsNullOrEmpty(name))
                    return Result<bool>.Failure("System name cannot be null or empty");

                if (adapter == null)
                    return Result<bool>.Failure("Adapter cannot be null");

                _inventoryAdapters[name] = adapter;
                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Failed to register inventory system: {ex.Message}");
            }
        }
```

Registers an inventory system adapter

**Returns:** `Result<bool>`

**Parameters:**
- `string name`
- `IPlaceableInventoryAdapter adapter`

### RegisterDataProvider

```csharp
/// <summary>
        /// Registers a data provider
        /// </summary>
        public Result<bool> RegisterDataProvider(string name, IPlaceableDataProvider provider)
        {
            try
            {
                if (string.IsNullOrEmpty(name))
                    return Result<bool>.Failure("Provider name cannot be null or empty");

                if (provider == null)
                    return Result<bool>.Failure("Provider cannot be null");

                _dataProviders[name] = provider;
                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Failed to register data provider: {ex.Message}");
            }
        }
```

Registers a data provider

**Returns:** `Result<bool>`

**Parameters:**
- `string name`
- `IPlaceableDataProvider provider`

### LoadFromExternalSystem

```csharp
/// <summary>
        /// Loads placeable from external system
        /// </summary>
        public Result<PlaceableDefinition> LoadFromExternalSystem(string systemName, string id)
        {
            try
            {
                if (!_dataProviders.TryGetValue(systemName, out var provider))
                    return Result<PlaceableDefinition>.Failure($"Data provider not found: {systemName}");

                if (!provider.IsAvailable())
                    return Result<PlaceableDefinition>.Failure($"Data provider not available: {systemName}");

                return provider.GetPlaceable(id);
            }
            catch (Exception ex)
            {
                return Result<PlaceableDefinition>.Failure($"Failed to load from external system: {ex.Message}");
            }
        }
```

Loads placeable from external system

**Returns:** `Result<PlaceableDefinition>`

**Parameters:**
- `string systemName`
- `string id`

### ConvertToInventoryItem

```csharp
/// <summary>
        /// Converts placeable to inventory item
        /// </summary>
        public Result<object> ConvertToInventoryItem(PlaceableDefinition placeable, string inventorySystem)
        {
            try
            {
                if (!_inventoryAdapters.TryGetValue(inventorySystem, out var adapter))
                    return Result<object>.Failure($"Inventory adapter not found: {inventorySystem}");

                return adapter.CreateInventoryItem(placeable);
            }
            catch (Exception ex)
            {
                return Result<object>.Failure($"Failed to convert to inventory item: {ex.Message}");
            }
        }
```

Converts placeable to inventory item

**Returns:** `Result<object>`

**Parameters:**
- `PlaceableDefinition placeable`
- `string inventorySystem`

### GenerateDatabaseSchema

```csharp
/// <summary>
        /// Generates database schema
        /// </summary>
        public Result<string> GenerateDatabaseSchema(string databaseType)
        {
            try
            {
                if (!_persistenceAdapters.TryGetValue(databaseType, out var adapter))
                {
                    // Generate default schema if no specific adapter
                    return GenerateDefaultSchema(databaseType);
                }

                return adapter.GenerateDatabaseSchema(databaseType);
            }
            catch (Exception ex)
            {
                return Result<string>.Failure($"Failed to generate database schema: {ex.Message}");
            }
        }
```

Generates database schema

**Returns:** `Result<string>`

**Parameters:**
- `string databaseType`

### GetRegisteredSystems

```csharp
/// <summary>
        /// Gets all registered system names
        /// </summary>
        public IEnumerable<string> GetRegisteredSystems()
        {
            return _dataProviders.Keys.Concat(_inventoryAdapters.Keys).Concat(_persistenceAdapters.Keys).Distinct();
        }
```

Gets all registered system names

**Returns:** `IEnumerable<string>`

### ValidateExternalCompatibility

```csharp
/// <summary>
        /// Validates external system compatibility
        /// </summary>
        public Result<bool> ValidateExternalCompatibility(PlaceableDefinition placeable, string systemName)
        {
            try
            {
                var validationResults = new List<Result<bool>>();

                // Check data provider compatibility
                if (_dataProviders.ContainsKey(systemName))
                {
                    var provider = _dataProviders[systemName];
                    var externalData = System.Text.Json.JsonSerializer.Serialize(placeable);
                    validationResults.Add(provider.ValidatePlaceableData(externalData));
                }

                // Check inventory adapter compatibility
                foreach (var adapter in _inventoryAdapters.Values)
                {
                    validationResults.Add(adapter.ValidateCompatibility(placeable, systemName));
                }

                // Check persistence adapter compatibility
                foreach (var adapter in _persistenceAdapters.Values)
                {
                    validationResults.Add(adapter.ValidateDatabaseCompatibility(placeable));
                }

                // Return success if all validations pass
                var failures = validationResults.Where(r => !r.Success).ToList();
                if (failures.Any())
                {
                    return Result<bool>.Failure($"Compatibility validation failed: {string.Join(", ", failures.Select(f => f.Error))}");
                }

                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"External compatibility validation failed: {ex.Message}");
            }
        }
```

Validates external system compatibility

**Returns:** `Result<bool>`

**Parameters:**
- `PlaceableDefinition placeable`
- `string systemName`

### SyncWithExternalSystems

```csharp
/// <summary>
        /// Syncs placeable with all external systems
        /// </summary>
        public Result<bool> SyncWithExternalSystems(PlaceableDefinition placeable)
        {
            try
            {
                var syncResults = new List<Result<bool>>();

                // Sync with data providers
                foreach (var provider in _dataProviders.Values)
                {
                    if (provider.IsAvailable())
                    {
                        // In a full implementation, this would sync with the external system
                        syncResults.Add(Result<bool>.Success(true));
                    }
                }

                // Sync with inventory systems
                foreach (var adapter in _inventoryAdapters.Values)
                {
                    var inventoryItem = adapter.CreateInventoryItem(placeable);
                    syncResults.Add(Result<bool>.Success(inventoryItem.Success));
                }

                // Sync with persistence systems
                foreach (var adapter in _persistenceAdapters.Values)
                {
                    var saveResult = adapter.SavePlaceable(placeable);
                    syncResults.Add(saveResult);
                }

                var failures = syncResults.Where(r => !r.Success).ToList();
                if (failures.Any())
                {
                    return Result<bool>.Failure($"Sync failed for some systems: {string.Join(", ", failures.Select(f => f.Error))}");
                }

                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"External sync failed: {ex.Message}");
            }
        }
```

Syncs placeable with all external systems

**Returns:** `Result<bool>`

**Parameters:**
- `PlaceableDefinition placeable`

### GetSystemMetadata

```csharp
/// <summary>
        /// Gets system metadata
        /// </summary>
        public Dictionary<string, ExternalSourceMetadata> GetSystemMetadata()
        {
            var metadata = new Dictionary<string, ExternalSourceMetadata>();

            foreach (var kvp in _dataProviders)
            {
                try
                {
                    metadata[kvp.Key] = kvp.Value.GetMetadata();
                }
                catch
                {
                    // Skip providers that fail to return metadata
                }
            }

            return metadata;
        }
```

Gets system metadata

**Returns:** `Dictionary<string, ExternalSourceMetadata>`

### RegisterSystemInstance

```csharp
/// <summary>
        /// Registers system instance
        /// </summary>
        public Result<bool> RegisterSystemInstance(string name, object instance)
        {
            try
            {
                if (string.IsNullOrEmpty(name))
                    return Result<bool>.Failure("System name cannot be null or empty");

                if (instance == null)
                    return Result<bool>.Failure("System instance cannot be null");

                _systemInstances[name] = instance;
                return Result<bool>.Success(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Failed to register system instance: {ex.Message}");
            }
        }
```

Registers system instance

**Returns:** `Result<bool>`

**Parameters:**
- `string name`
- `object instance`

### GetSystemInstance

```csharp
/// <summary>
        /// Gets system instance
        /// </summary>
        public T GetSystemInstance<T>(string name) where T : class
        {
            if (_systemInstances.TryGetValue(name, out var instance) && instance is T typedInstance)
            {
                return typedInstance;
            }
            return null;
        }
```

Gets system instance

**Returns:** `T`

**Parameters:**
- `string name`

