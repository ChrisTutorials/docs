---
title: "PhysicsLayerManager"
description: "Core physics layer management for manipulation operations (engine-agnostic).
Handles collision layer enabling/disabling during manipulation without engine dependencies.
Responsibilities:
- Track physics layer state changes
- Disable collision layers during manipulation
- Restore original physics layer state
- Provide physics layer validation"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/physicslayermanager/"
---

# PhysicsLayerManager

```csharp
GridBuilding.Core.Services.Manipulation
class PhysicsLayerManager
{
    // Members...
}
```

Core physics layer management for manipulation operations (engine-agnostic).
Handles collision layer enabling/disabling during manipulation without engine dependencies.
Responsibilities:
- Track physics layer state changes
- Disable collision layers during manipulation
- Restore original physics layer state
- Provide physics layer validation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Services/Manipulation/PhysicsLayerManager.cs`  
**Namespace:** `GridBuilding.Core.Services.Manipulation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### DisableLayers

```csharp
#endregion

        #region Public Methods

        /// <summary>
        /// Disables specified physics layers for an object.
        /// </summary>
        /// <param name="objectId">Unique identifier for the object</param>
        /// <param name="layersToDisable">List of layer numbers to disable</param>
        /// <param name="disabledObjects">Dictionary to store disabled state for tracking</param>
        /// <returns>True if layers were successfully disabled</returns>
        public bool DisableLayers(string objectId, List<int> layersToDisable, Dictionary<string, bool> disabledObjects)
        {
            if (string.IsNullOrEmpty(objectId) || layersToDisable == null || !layersToDisable.Any())
                return false;

            // Store original state if not already stored
            if (!_originalLayers.ContainsKey(objectId))
            {
                _originalLayers[objectId] = GetCurrentLayers(objectId);
            }

            // Create physics layer state
            var state = new PhysicsLayerState
            {
                ObjectId = objectId,
                DisabledLayers = layersToDisable.ToList(),
                OriginalLayers = _originalLayers[objectId].ToList(),
                Timestamp = DateTime.UtcNow
            };

            // Store disabled state
            _disabledObjects[objectId] = state;
            disabledObjects[objectId] = true;

            return true;
        }
```

Disables specified physics layers for an object.

**Returns:** `bool`

**Parameters:**
- `string objectId`
- `List<int> layersToDisable`
- `Dictionary<string, bool> disabledObjects`

### RestoreLayers

```csharp
/// <summary>
        /// Restores physics layers for an object.
        /// </summary>
        /// <param name="objectId">Unique identifier for the object</param>
        /// <returns>True if layers were successfully restored</returns>
        public bool RestoreLayers(string objectId)
        {
            if (string.IsNullOrEmpty(objectId))
                return false;

            if (!_disabledObjects.TryGetValue(objectId, out var state))
                return false;

            // Restore original layers
            SetObjectLayers(objectId, state.OriginalLayers);

            // Clean up tracking
            _disabledObjects.Remove(objectId);
            _originalLayers.Remove(objectId);

            return true;
        }
```

Restores physics layers for an object.

**Returns:** `bool`

**Parameters:**
- `string objectId`

### RestoreAllLayers

```csharp
/// <summary>
        /// Restores all disabled physics layers.
        /// </summary>
        /// <param name="disabledObjects">Dictionary of disabled objects to clean up</param>
        /// <returns>Number of objects restored</returns>
        public int RestoreAllLayers(Dictionary<string, bool> disabledObjects)
        {
            var restoredCount = 0;
            var objectIds = _disabledObjects.Keys.ToList();

            foreach (var objectId in objectIds)
            {
                if (RestoreLayers(objectId))
                {
                    restoredCount++;
                    disabledObjects.Remove(objectId);
                }
            }

            return restoredCount;
        }
```

Restores all disabled physics layers.

**Returns:** `int`

**Parameters:**
- `Dictionary<string, bool> disabledObjects`

### HasDisabledLayers

```csharp
/// <summary>
        /// Checks if an object has disabled physics layers.
        /// </summary>
        /// <param name="objectId">Unique identifier for the object</param>
        /// <returns>True if object has disabled layers</returns>
        public bool HasDisabledLayers(string objectId)
        {
            return _disabledObjects.ContainsKey(objectId);
        }
```

Checks if an object has disabled physics layers.

**Returns:** `bool`

**Parameters:**
- `string objectId`

### GetDisabledLayers

```csharp
/// <summary>
        /// Gets the disabled layers for an object.
        /// </summary>
        /// <param name="objectId">Unique identifier for the object</param>
        /// <returns>List of disabled layer numbers, or empty list if none</returns>
        public List<int> GetDisabledLayers(string objectId)
        {
            if (_disabledObjects.TryGetValue(objectId, out var state))
                return state.DisabledLayers.ToList();
            
            return new List<int>();
        }
```

Gets the disabled layers for an object.

**Returns:** `List<int>`

**Parameters:**
- `string objectId`

### GetOriginalLayers

```csharp
/// <summary>
        /// Gets the original layers for an object before they were disabled.
        /// </summary>
        /// <param name="objectId">Unique identifier for the object</param>
        /// <returns>List of original layer numbers, or empty list if not found</returns>
        public List<int> GetOriginalLayers(string objectId)
        {
            if (_originalLayers.TryGetValue(objectId, out var layers))
                return layers.ToList();
            
            return new List<int>();
        }
```

Gets the original layers for an object before they were disabled.

**Returns:** `List<int>`

**Parameters:**
- `string objectId`

### IsValidLayer

```csharp
/// <summary>
        /// Validates if a layer number is valid.
        /// </summary>
        /// <param name="layer">Layer number to validate</param>
        /// <returns>True if layer is valid (0-31)</returns>
        public bool IsValidLayer(int layer)
        {
            return layer >= 0 && layer <= 31; // Standard physics layer range
        }
```

Validates if a layer number is valid.

**Returns:** `bool`

**Parameters:**
- `int layer`

### AreValidLayers

```csharp
/// <summary>
        /// Validates a list of layer numbers.
        /// </summary>
        /// <param name="layers">List of layer numbers to validate</param>
        /// <returns>True if all layers are valid</returns>
        public bool AreValidLayers(List<int> layers)
        {
            return layers != null && layers.All(IsValidLayer);
        }
```

Validates a list of layer numbers.

**Returns:** `bool`

**Parameters:**
- `List<int> layers`

### GetDisabledObjects

```csharp
/// <summary>
        /// Gets all currently disabled objects.
        /// </summary>
        /// <returns>Dictionary of object IDs and their disabled states</returns>
        public Dictionary<string, PhysicsLayerState> GetDisabledObjects()
        {
            return new Dictionary<string, PhysicsLayerState>(_disabledObjects);
        }
```

Gets all currently disabled objects.

**Returns:** `Dictionary<string, PhysicsLayerState>`

### ClearAllTracking

```csharp
/// <summary>
        /// Clears all tracking data (for cleanup/reset).
        /// </summary>
        public void ClearAllTracking()
        {
            _disabledObjects.Clear();
            _originalLayers.Clear();
        }
```

Clears all tracking data (for cleanup/reset).

**Returns:** `void`

