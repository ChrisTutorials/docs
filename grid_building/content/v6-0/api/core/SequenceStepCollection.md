---
title: "SequenceStepCollection"
description: "Collection of sequence steps"
weight: 10
url: "/gridbuilding/v6-0/api/core/sequencestepcollection/"
---

# SequenceStepCollection

```csharp
GridBuilding.Core.Data
class SequenceStepCollection
{
    // Members...
}
```

Collection of sequence steps

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/SequenceStep.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Steps

```csharp
/// <summary>
        /// All steps in the collection
        /// </summary>
        public IReadOnlyCollection<SequenceStep> Steps => _steps.Values;
```

All steps in the collection

### Count

```csharp
/// <summary>
        /// Number of steps
        /// </summary>
        public int Count => _steps.Count;
```

Number of steps


## Methods

### Add

```csharp
/// <summary>
        /// Adds a step to the collection
        /// </summary>
        public ValidationResult Add(SequenceStep step)
        {
            if (step == null)
                return new ValidationResult(false, "Step cannot be null");

            var validationResult = step.ValidateStep();
            if (!validationResult.Success)
                return validationResult;

            _steps[step.Id] = step;
            return new ValidationResult(true);
        }
```

Adds a step to the collection

**Returns:** `ValidationResult`

**Parameters:**
- `SequenceStep step`

### Remove

```csharp
/// <summary>
        /// Removes a step from the collection
        /// </summary>
        public bool Remove(string stepId)
        {
            return _steps.Remove(stepId);
        }
```

Removes a step from the collection

**Returns:** `bool`

**Parameters:**
- `string stepId`

### GetStep

```csharp
/// <summary>
        /// Gets a step by ID
        /// </summary>
        public SequenceStep GetStep(string stepId)
        {
            return _steps.TryGetValue(stepId, out var step) ? step : null;
        }
```

Gets a step by ID

**Returns:** `SequenceStep`

**Parameters:**
- `string stepId`

### GetStepsInOrder

```csharp
/// <summary>
        /// Gets steps in order
        /// </summary>
        public IEnumerable<SequenceStep> GetStepsInOrder()
        {
            return _steps.Values.OrderBy(s => s.Order);
        }
```

Gets steps in order

**Returns:** `IEnumerable<SequenceStep>`

### GetStepsUsingPlaceable

```csharp
/// <summary>
        /// Gets steps that use a specific placeable
        /// </summary>
        public IEnumerable<SequenceStep> GetStepsUsingPlaceable(string placeableId)
        {
            return _steps.Values.Where(s => s.PlaceableId == placeableId);
        }
```

Gets steps that use a specific placeable

**Returns:** `IEnumerable<SequenceStep>`

**Parameters:**
- `string placeableId`

### GetStepsDependingOn

```csharp
/// <summary>
        /// Gets steps that depend on a specific placeable
        /// </summary>
        public IEnumerable<SequenceStep> GetStepsDependingOn(string placeableId)
        {
            return _steps.Values.Where(s => s.DependsOn(placeableId));
        }
```

Gets steps that depend on a specific placeable

**Returns:** `IEnumerable<SequenceStep>`

**Parameters:**
- `string placeableId`

### Clear

```csharp
/// <summary>
        /// Clears all steps
        /// </summary>
        public void Clear()
        {
            _steps.Clear();
        }
```

Clears all steps

**Returns:** `void`

### ValidateAll

```csharp
/// <summary>
        /// Validates all steps in the collection
        /// </summary>
        public ValidationResult ValidateAll()
        {
            foreach (var step in _steps.Values)
            {
                var result = step.ValidateStep();
                if (!result.Success)
                    return result;
            }
            return new ValidationResult(true);
        }
```

Validates all steps in the collection

**Returns:** `ValidationResult`

