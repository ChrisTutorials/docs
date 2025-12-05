---
title: "SequenceStep"
description: "Individual step in a placeable sequence with external integration"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/sequencestep/"
---

# SequenceStep

```csharp
GridBuilding.Core.Data
class SequenceStep
{
    // Members...
}
```

Individual step in a placeable sequence with external integration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/SequenceStep.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
/// <summary>
        /// Unique identifier for this step
        /// </summary>
        public string Id { get; set; } = string.Empty;
```

Unique identifier for this step

### PlaceableId

```csharp
/// <summary>
        /// Placeable ID to place at this step
        /// </summary>
        public string PlaceableId { get; set; } = string.Empty;
```

Placeable ID to place at this step

### RelativePosition

```csharp
/// <summary>
        /// Relative position from sequence origin
        /// </summary>
        public Vector2I RelativePosition { get; set; }
```

Relative position from sequence origin

### Rotation

```csharp
/// <summary>
        /// Rotation for this step
        /// </summary>
        public float Rotation { get; set; } = 0f;
```

Rotation for this step

### Conditions

```csharp
/// <summary>
        /// Step conditions and requirements
        /// </summary>
        public StepConditions Conditions { get; set; } = new();
```

Step conditions and requirements

### ExternalRequirements

```csharp
/// <summary>
        /// External system requirements
        /// </summary>
        public Dictionary<string, object> ExternalRequirements { get; set; } = new();
```

External system requirements

### InventoryItemId

```csharp
/// <summary>
        /// Inventory item ID for this step
        /// </summary>
        public string InventoryItemId { get; set; } = string.Empty;
```

Inventory item ID for this step

### ExternalDependencies

```csharp
/// <summary>
        /// External dependencies (other placeables that must exist first)
        /// </summary>
        public List<string> ExternalDependencies { get; set; } = new();
```

External dependencies (other placeables that must exist first)

### Order

```csharp
/// <summary>
        /// Step order in sequence
        /// </summary>
        public int Order { get; set; } = 0;
```

Step order in sequence

### IsOptional

```csharp
/// <summary>
        /// Whether this step is optional
        /// </summary>
        public bool IsOptional { get; set; } = false;
```

Whether this step is optional

### ExternalReferences

```csharp
/// <summary>
        /// External references for this step
        /// </summary>
        public ExternalReferenceCollection ExternalReferences { get; set; } = new();
```

External references for this step

### Tags

```csharp
/// <summary>
        /// Tags for external system filtering
        /// </summary>
        public List<string> Tags { get; set; } = new();
```

Tags for external system filtering

### CreatedAt

```csharp
/// <summary>
        /// Database-friendly creation timestamp
        /// </summary>
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
```

Database-friendly creation timestamp

### Version

```csharp
/// <summary>
        /// Data version for migration support
        /// </summary>
        public int Version { get; set; } = 1;
```

Data version for migration support

### UpdatedAt

```csharp
/// <summary>
        /// Last updated timestamp
        /// </summary>
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
```

Last updated timestamp


## Methods

### ValidateStep

```csharp
/// <summary>
        /// Validates the sequence step
        /// </summary>
        public ValidationResult ValidateStep()
        {
            if (string.IsNullOrEmpty(Id))
                return new ValidationResult(false, "Step ID cannot be null or empty");

            if (string.IsNullOrEmpty(PlaceableId))
                return new ValidationResult(false, "Placeable ID cannot be null or empty");

            if (Order < 0)
                return new ValidationResult(false, "Step order cannot be negative");

            return new ValidationResult(true);
        }
```

Validates the sequence step

**Returns:** `ValidationResult`

### GetAbsolutePosition

```csharp
/// <summary>
        /// Gets absolute position given sequence origin
        /// </summary>
        public Vector2I GetAbsolutePosition(Vector2I sequenceOrigin)
        {
            return new Vector2I(
                sequenceOrigin.X + RelativePosition.X,
                sequenceOrigin.Y + RelativePosition.Y
            );
        }
```

Gets absolute position given sequence origin

**Returns:** `Vector2I`

**Parameters:**
- `Vector2I sequenceOrigin`

### DependsOn

```csharp
/// <summary>
        /// Checks if this step depends on another placeable
        /// </summary>
        public bool DependsOn(string placeableId)
        {
            return ExternalDependencies.Contains(placeableId);
        }
```

Checks if this step depends on another placeable

**Returns:** `bool`

**Parameters:**
- `string placeableId`

### AddDependency

```csharp
/// <summary>
        /// Adds external dependency
        /// </summary>
        public void AddDependency(string placeableId)
        {
            if (!ExternalDependencies.Contains(placeableId))
                ExternalDependencies.Add(placeableId);
        }
```

Adds external dependency

**Returns:** `void`

**Parameters:**
- `string placeableId`

### RemoveDependency

```csharp
/// <summary>
        /// Removes external dependency
        /// </summary>
        public bool RemoveDependency(string placeableId)
        {
            return ExternalDependencies.Remove(placeableId);
        }
```

Removes external dependency

**Returns:** `bool`

**Parameters:**
- `string placeableId`

### GetExternalRequirement

```csharp
/// <summary>
        /// Gets external requirement by key
        /// </summary>
        public T GetExternalRequirement<T>(string key, T defaultValue = default)
        {
            if (ExternalRequirements.TryGetValue(key, out var value) && value is T typedValue)
                return typedValue;
            return defaultValue;
        }
```

Gets external requirement by key

**Returns:** `T`

**Parameters:**
- `string key`
- `T defaultValue`

### SetExternalRequirement

```csharp
/// <summary>
        /// Sets external requirement
        /// </summary>
        public void SetExternalRequirement(string key, object value)
        {
            ExternalRequirements[key] = value;
        }
```

Sets external requirement

**Returns:** `void`

**Parameters:**
- `string key`
- `object value`

### CheckDependenciesSatisfied

```csharp
/// <summary>
        /// Checks if step has all required external dependencies satisfied
        /// </summary>
        public ValidationResult CheckDependenciesSatisfied(Func<string, bool> placeableExists)
        {
            foreach (var dependency in ExternalDependencies)
            {
                if (!placeableExists(dependency))
                    return ValidationResult.Failure($"Dependency not satisfied: {dependency}");
            }
            return new ValidationResult(true);
        }
```

Checks if step has all required external dependencies satisfied

**Returns:** `ValidationResult`

**Parameters:**
- `Func<string, bool> placeableExists`

