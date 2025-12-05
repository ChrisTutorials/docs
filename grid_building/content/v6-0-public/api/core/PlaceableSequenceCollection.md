---
title: "PlaceableSequenceCollection"
description: "Collection of placeable sequences"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/placeablesequencecollection/"
---

# PlaceableSequenceCollection

```csharp
GridBuilding.Core.Data
class PlaceableSequenceCollection
{
    // Members...
}
```

Collection of placeable sequences

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Data/PlaceableSequence.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Sequences

```csharp
/// <summary>
        /// All sequences in the collection
        /// </summary>
        public IReadOnlyCollection<PlaceableSequence> Sequences => _sequences.Values;
```

All sequences in the collection

### Count

```csharp
/// <summary>
        /// Number of sequences
        /// </summary>
        public int Count => _sequences.Count;
```

Number of sequences


## Methods

### Add

```csharp
/// <summary>
        /// Adds a sequence to the collection
        /// </summary>
        public ValidationResult Add(PlaceableSequence sequence)
        {
            if (sequence == null)
                return new ValidationResult(false, "Sequence cannot be null");

            var validationResult = sequence.Validate();
            if (!validationResult.Success)
                return validationResult;

            _sequences[sequence.Id] = sequence;
            return new ValidationResult(true);
        }
```

Adds a sequence to the collection

**Returns:** `ValidationResult`

**Parameters:**
- `PlaceableSequence sequence`

### Remove

```csharp
/// <summary>
        /// Removes a sequence from the collection
        /// </summary>
        public bool Remove(string sequenceId)
        {
            return _sequences.Remove(sequenceId);
        }
```

Removes a sequence from the collection

**Returns:** `bool`

**Parameters:**
- `string sequenceId`

### GetSequence

```csharp
/// <summary>
        /// Gets a sequence by ID
        /// </summary>
        public PlaceableSequence GetSequence(string sequenceId)
        {
            return _sequences.TryGetValue(sequenceId, out var sequence) ? sequence : null;
        }
```

Gets a sequence by ID

**Returns:** `PlaceableSequence`

**Parameters:**
- `string sequenceId`

### GetSequencesByCategory

```csharp
/// <summary>
        /// Gets sequences by category
        /// </summary>
        public IEnumerable<PlaceableSequence> GetSequencesByCategory(SequenceCategory category)
        {
            return _sequences.Values.Where(s => s.Category == category);
        }
```

Gets sequences by category

**Returns:** `IEnumerable<PlaceableSequence>`

**Parameters:**
- `SequenceCategory category`

### GetSequencesUsingPlaceable

```csharp
/// <summary>
        /// Gets sequences that use a specific placeable
        /// </summary>
        public IEnumerable<PlaceableSequence> GetSequencesUsingPlaceable(string placeableId)
        {
            return _sequences.Values.Where(s => s.GetAllPlaceableIds().Contains(placeableId));
        }
```

Gets sequences that use a specific placeable

**Returns:** `IEnumerable<PlaceableSequence>`

**Parameters:**
- `string placeableId`

### Clear

```csharp
/// <summary>
        /// Clears all sequences
        /// </summary>
        public void Clear()
        {
            _sequences.Clear();
        }
```

Clears all sequences

**Returns:** `void`

