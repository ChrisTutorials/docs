---
title: "PlaceableSequence"
description: "Defines a sequence of placeables with external system integration"
weight: 10
url: "/gridbuilding/v6-0/api/core/placeablesequence/"
---

# PlaceableSequence

```csharp
GridBuilding.Core.Data
class PlaceableSequence
{
    // Members...
}
```

Defines a sequence of placeables with external system integration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/PlaceableSequence.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
/// <summary>
        /// Unique identifier for this sequence
        /// </summary>
        public string Id { get; set; } = string.Empty;
```

Unique identifier for this sequence

### Name

```csharp
/// <summary>
        /// Display name
        /// </summary>
        public string Name { get; set; } = string.Empty;
```

Display name

### Description

```csharp
/// <summary>
        /// Description of what this sequence creates
        /// </summary>
        public string Description { get; set; } = string.Empty;
```

Description of what this sequence creates

### Steps

```csharp
/// <summary>
        /// List of sequence steps
        /// </summary>
        public List<SequenceStep> Steps { get; set; } = new();
```

List of sequence steps

### Constraints

```csharp
/// <summary>
        /// Sequence constraints and requirements
        /// </summary>
        public SequenceConstraints Constraints { get; set; } = new();
```

Sequence constraints and requirements

### ExternalReferences

```csharp
/// <summary>
        /// External system references
        /// </summary>
        public ExternalReferenceCollection ExternalReferences { get; set; } = new();
```

External system references

### RequiredInventoryItems

```csharp
/// <summary>
        /// Required inventory items for this sequence
        /// </summary>
        public List<string> RequiredInventoryItems { get; set; } = new();
```

Required inventory items for this sequence

### ExternalSequenceId

```csharp
/// <summary>
        /// External sequence ID for cross-system compatibility
        /// </summary>
        public string ExternalSequenceId { get; set; } = string.Empty;
```

External sequence ID for cross-system compatibility

### Category

```csharp
/// <summary>
        /// Sequence category
        /// </summary>
        public SequenceCategory Category { get; set; } = SequenceCategory.Unknown;
```

Sequence category

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

### Validate

```csharp
/// <summary>
        /// Validates the sequence for consistency
        /// </summary>
        public ValidationResult Validate()
        {
            if (string.IsNullOrEmpty(Id))
                return new ValidationResult(false, "Sequence ID cannot be null or empty");

            if (string.IsNullOrEmpty(Name))
                return new ValidationResult(false, "Sequence name cannot be null or empty");

            if (Steps == null || Steps.Count == 0)
                return new ValidationResult(false, "Sequence must have at least one step");

            // Validate each step
            foreach (var step in Steps)
            {
                var stepResult = step.Validate();
                if (!stepResult.Success)
                    return ValidationResult.Failure($"Step validation failed: {stepResult.Error}");
            }

            // Check for circular dependencies
            if (HasCircularDependencies())
                return new ValidationResult(false, "Sequence has circular dependencies");

            return new ValidationResult(true);
        }
```

Validates the sequence for consistency

**Returns:** `ValidationResult`

### GetAllPlaceableIds

```csharp
/// <summary>
        /// Gets all placeable IDs used in this sequence
        /// </summary>
        public IEnumerable<string> GetAllPlaceableIds()
        {
            return Steps.Select(s => s.PlaceableId).Distinct();
        }
```

Gets all placeable IDs used in this sequence

**Returns:** `IEnumerable<string>`

### GetDependentSteps

```csharp
/// <summary>
        /// Gets steps that depend on a specific placeable
        /// </summary>
        public IEnumerable<SequenceStep> GetDependentSteps(string placeableId)
        {
            return Steps.Where(s => s.ExternalDependencies.Contains(placeableId));
        }
```

Gets steps that depend on a specific placeable

**Returns:** `IEnumerable<SequenceStep>`

**Parameters:**
- `string placeableId`

