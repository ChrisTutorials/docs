---
title: "SequenceExternalIntegrationService"
description: "Service for handling external system integration for placeable sequences"
weight: 10
url: "/gridbuilding/v6-0/api/core/sequenceexternalintegrationservice/"
---

# SequenceExternalIntegrationService

```csharp
GridBuilding.Core.Services
class SequenceExternalIntegrationService
{
    // Members...
}
```

Service for handling external system integration for placeable sequences

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/SequenceExternalIntegrationService.cs`  
**Namespace:** `GridBuilding.Core.Services`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

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
                return Result<bool>.CreateSuccess(true);
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

### RegisterInventoryAdapter

```csharp
/// <summary>
        /// Registers an inventory adapter
        /// </summary>
        public Result<bool> RegisterInventoryAdapter(string name, IPlaceableInventoryAdapter adapter)
        {
            try
            {
                if (string.IsNullOrEmpty(name))
                    return Result<bool>.Failure("Adapter name cannot be null or empty");

                if (adapter == null)
                    return Result<bool>.Failure("Adapter cannot be null");

                _inventoryAdapters[name] = adapter;
                return Result<bool>.CreateSuccess(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Failed to register inventory adapter: {ex.Message}");
            }
        }
```

Registers an inventory adapter

**Returns:** `Result<bool>`

**Parameters:**
- `string name`
- `IPlaceableInventoryAdapter adapter`

### RegisterPersistenceAdapter

```csharp
/// <summary>
        /// Registers a persistence adapter
        /// </summary>
        public Result<bool> RegisterPersistenceAdapter(string name, IPlaceablePersistenceAdapter adapter)
        {
            try
            {
                if (string.IsNullOrEmpty(name))
                    return Result<bool>.Failure("Adapter name cannot be null or empty");

                if (adapter == null)
                    return Result<bool>.Failure("Adapter cannot be null");

                _persistenceAdapters[name] = adapter;
                return Result<bool>.CreateSuccess(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Failed to register persistence adapter: {ex.Message}");
            }
        }
```

Registers a persistence adapter

**Returns:** `Result<bool>`

**Parameters:**
- `string name`
- `IPlaceablePersistenceAdapter adapter`

### LoadSequenceFromExternal

```csharp
/// <summary>
        /// Loads sequence from external data source
        /// </summary>
        public Result<PlaceableSequence> LoadSequenceFromExternal(string providerName, string sequenceId)
        {
            try
            {
                if (!_dataProviders.TryGetValue(providerName, out var provider))
                    return Result<PlaceableSequence>.Failure($"Data provider not found: {providerName}");

                if (!provider.IsAvailable())
                    return Result<PlaceableSequence>.Failure($"Data provider not available: {providerName}");

                // Load sequence data from external source
                var sequenceData = provider.GetPlaceable(sequenceId);
                if (!sequenceData.Success)
                    return Result<PlaceableSequence>.Failure($"Failed to load sequence data: {sequenceData.Error}");

                // Convert placeable to sequence (simplified for example)
                var sequence = new PlaceableSequence
                {
                    Id = sequenceData.Value.Id,
                    Name = sequenceData.Value.Name,
                    Description = sequenceData.Value.Description,
                    Steps = new List<SequenceStep>
                    {
                        new SequenceStep
                        {
                            Id = $"{sequenceData.Value.Id}_step_1",
                            PlaceableId = sequenceData.Value.Id,
                            RelativePosition = new Vector2I(0, 0),
                            Order = 0
                        }
                    },
                    ExternalReferences = sequenceData.Value.ExternalReferences,
                    Tags = sequenceData.Value.Tags
                };

                return Result<PlaceableSequence>.Success(sequence);
            }
            catch (Exception ex)
            {
                return Result<PlaceableSequence>.Failure($"Failed to load sequence from external: {ex.Message}");
            }
        }
```

Loads sequence from external data source

**Returns:** `Result<PlaceableSequence>`

**Parameters:**
- `string providerName`
- `string sequenceId`

### ValidateSequenceWithExternal

```csharp
/// <summary>
        /// Validates sequence with external systems
        /// </summary>
        public Result<bool> ValidateSequenceWithExternal(PlaceableSequence sequence)
        {
            try
            {
                if (sequence == null)
                    return Result<bool>.Failure("Sequence cannot be null");

                // Basic validation
                var basicValidation = sequence.Validate();
                if (!basicValidation.Success)
                    return basicValidation;

                // Validate external references
                foreach (var reference in sequence.ExternalReferences.GetActiveReferences())
                {
                    if (!_dataProviders.ContainsKey(reference.SystemName))
                        return Result<bool>.Failure($"External system not registered: {reference.SystemName}");
                }

                // Validate inventory requirements

                foreach (var inventoryItemId in sequence.RequiredInventoryItems)
                {
                    var inventoryValid = false;
                    foreach (var adapter in _inventoryAdapters.Values)
                    {
                        var compatibility = adapter.ValidateCompatibility(
                            new PlaceableDefinition { Id = inventoryItemId }, 
                            "default");
                        if (compatibility.Success && compatibility.Value)
                        {
                            inventoryValid = true;
                            break;
                        }
                    }

                    if (!inventoryValid)
                        return Result<bool>.Failure($"Inventory item not compatible: {inventoryItemId}");
                }

                return Result<bool>.CreateSuccess(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"External validation failed: {ex.Message}");
            }
        }
```

Validates sequence with external systems

**Returns:** `Result<bool>`

**Parameters:**
- `PlaceableSequence sequence`

### CreateInventoryItemsForSequence

```csharp
/// <summary>
        /// Creates inventory items for sequence steps
        /// </summary>
        public Result<List<object>> CreateInventoryItemsForSequence(PlaceableSequence sequence, string inventorySystemName)
        {
            try
            {
                if (!_inventoryAdapters.TryGetValue(inventorySystemName, out var adapter))
                    return Result<List<object>>.Failure($"Inventory adapter not found: {inventorySystemName}");

                var inventoryItems = new List<object>();

                foreach (var step in sequence.Steps)
                {
                    if (!string.IsNullOrEmpty(step.InventoryItemId))
                    {
                        // Create a mock placeable for the inventory item
                        var placeable = new PlaceableDefinition
                        {
                            Id = step.PlaceableId,
                            Name = $"Sequence Item: {step.PlaceableId}",
                            Properties = new Dictionary<string, object>
                            {
                                ["inventory_item_id"] = step.InventoryItemId,
                                ["sequence_id"] = sequence.Id,
                                ["step_id"] = step.Id
                            }
                        };

                        var inventoryItem = adapter.CreateInventoryItem(placeable);
                        if (!inventoryItem.Success)
                            return Result<List<object>>.Failure($"Failed to create inventory item for step {step.Id}: {inventoryItem.Error}");

                        inventoryItems.Add(inventoryItem.Value);
                    }
                }

                return Result<List<object>>.Success(inventoryItems);
            }
            catch (Exception ex)
            {
                return Result<List<object>>.Failure($"Failed to create inventory items: {ex.Message}");
            }
        }
```

Creates inventory items for sequence steps

**Returns:** `Result<List<object>>`

**Parameters:**
- `PlaceableSequence sequence`
- `string inventorySystemName`

### SyncSequenceWithExternal

```csharp
/// <summary>
        /// Saves sequence to external system
        /// </summary>
        public Result<bool> SyncSequenceWithExternal(PlaceableSequence sequence)
        {
            try
            {
                foreach (var reference in sequence.ExternalReferences.GetActiveReferences())
                {
                    if (!_dataProviders.TryGetValue(reference.SystemName, out var provider))
                        continue;

                    // Update last synced timestamp
                    reference.LastSynced = DateTime.UtcNow;

                    // In a full implementation, this would sync data with the external system
                    // For now, we'll just mark as synced
                }

                return Result<bool>.CreateSuccess(true);
            }
            catch (Exception ex)
            {
                return Result<bool>.Failure($"Failed to sync sequence with external: {ex.Message}");
            }
        }
```

Saves sequence to external system

**Returns:** `Result<bool>`

**Parameters:**
- `PlaceableSequence sequence`

### GetAvailableDataProviders

```csharp
/// <summary>
        /// Gets available external systems
        /// </summary>
        public IEnumerable<string> GetAvailableDataProviders()
        {
            return _dataProviders.Keys;
        }
```

Gets available external systems

**Returns:** `IEnumerable<string>`

### GetAvailableInventorySystems

```csharp
/// <summary>
        /// Gets available inventory systems
        /// </summary>
        public IEnumerable<string> GetAvailableInventorySystems()
        {
            return _inventoryAdapters.Keys;
        }
```

Gets available inventory systems

**Returns:** `IEnumerable<string>`

### GetAvailablePersistenceSystems

```csharp
/// <summary>
        /// Gets available persistence systems
        /// </summary>
        public IEnumerable<string> GetAvailablePersistenceSystems()
        {
            return _persistenceAdapters.Keys;
        }
```

Gets available persistence systems

**Returns:** `IEnumerable<string>`

### IsExternalSystemAvailable

```csharp
/// <summary>
        /// Checks if external system is available
        /// </summary>
        public bool IsExternalSystemAvailable(string systemName)
        {
            return _dataProviders.TryGetValue(systemName, out var provider) && provider.IsAvailable();
        }
```

Checks if external system is available

**Returns:** `bool`

**Parameters:**
- `string systemName`

### GetAllExternalMetadata

```csharp
/// <summary>
        /// Gets metadata for all external systems
        /// </summary>
        public Dictionary<string, ExternalSourceMetadata> GetAllExternalMetadata()
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

Gets metadata for all external systems

**Returns:** `Dictionary<string, ExternalSourceMetadata>`

