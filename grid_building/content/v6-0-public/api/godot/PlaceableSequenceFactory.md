---
title: "PlaceableSequenceFactory"
description: "Factory utilities for creating and normalizing PlaceableSequence collections.
This factory implements the "Helper Factory (Suggested)" pattern mentioned in the
UI PlaceableSequence guide documentation. It provides convenient methods for:
- Converting individual Placeables into single-item sequences
- Normalizing mixed arrays of Placeables and PlaceableSequences
- Reducing UI wiring code when working with PlaceableList components
Usage Context:
These utilities are designed for cases where you have existing Placeable
collections but need to use them with PlaceableSequenceSelectionUI or
PlaceableList components that expect PlaceableSequence objects.
Note: Currently not used in the main plugin demos, but provided as
convenience utilities for game developers who need sequence normalization."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/placeablesequencefactory/"
---

# PlaceableSequenceFactory

```csharp
GridBuilding.Godot.Core.Placeables
class PlaceableSequenceFactory
{
    // Members...
}
```

Factory utilities for creating and normalizing PlaceableSequence collections.
This factory implements the "Helper Factory (Suggested)" pattern mentioned in the
UI PlaceableSequence guide documentation. It provides convenient methods for:
- Converting individual Placeables into single-item sequences
- Normalizing mixed arrays of Placeables and PlaceableSequences
- Reducing UI wiring code when working with PlaceableList components
Usage Context:
These utilities are designed for cases where you have existing Placeable
collections but need to use them with PlaceableSequenceSelectionUI or
PlaceableList components that expect PlaceableSequence objects.
Note: Currently not used in the main plugin demos, but provided as
convenience utilities for game developers who need sequence normalization.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Base/PlaceableSequenceFactory.cs`  
**Namespace:** `GridBuilding.Godot.Core.Placeables`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### FromPlaceables

```csharp
/// <summary>
    /// Converts an array of individual Placeables into single-item PlaceableSequences.
    /// Each Placeable becomes a sequence containing only that one item, preserving
    /// the original display name and allowing it to work with sequence-based UI components.
    /// </summary>
    /// <param name="placeables">Array of Placeable resources to convert</param>
    /// <returns>Array of PlaceableSequence objects, each containing one original Placeable</returns>
    /// 
    /// Usage Example:
    /// <code>
    /// var individualBuildings = new global::Godot.Collections.Array&lt;Placeable&gt; { tower, wall, gate };
    /// var sequences = PlaceableSequenceFactory.FromPlaceables(individualBuildings);
    /// placeableSequenceUI.Sequences = sequences;
    /// </code>
    /// 
    /// Note: Null placeables are automatically filtered out during conversion.
    public static global::Godot.Collections.Array<PlaceableSequence> FromPlaceables(global::Godot.Collections.Array<Placeable> placeables)
    {
        var convertedSequences = new global::Godot.Collections.Array<PlaceableSequence>();

        foreach (Placeable originalPlaceable in placeables)
        {
            if (originalPlaceable == null)
            {
                continue;
            }

            // Create a new sequence containing only this placeable
            var singleItemSequence = new PlaceableSequence();
            singleItemSequence.DisplayName = originalPlaceable.DisplayName;
            singleItemSequence.Placeables.Add(originalPlaceable);
            convertedSequences.Add(singleItemSequence);
        }

        return convertedSequences;
    }
```

Converts an array of individual Placeables into single-item PlaceableSequences.
Each Placeable becomes a sequence containing only that one item, preserving
the original display name and allowing it to work with sequence-based UI components.

**Returns:** `global::Godot.Collections.Array<PlaceableSequence>`

**Parameters:**
- `global::Godot.Collections.Array<Placeable> placeables`

### EnsureSequences

```csharp
/// <summary>
    /// Normalizes a mixed array of Placeables and PlaceableSequences into sequences only.
    /// This implements the "normalize_sequences" pattern suggested in the documentation,
    /// allowing flexible input while ensuring consistent sequence-based output for UI components.
    /// </summary>
    /// <param name="mixed">Array containing any combination of Placeable and PlaceableSequence objects</param>
    /// <returns>Array containing only PlaceableSequence objects (singles wrapped, sequences preserved)</returns>
    /// 
    /// Usage Example:
    /// <code>
    /// var mixedItems = new global::Godot.Collections.Array&lt;Variant&gt; { singleTower, wallSequence, gatePlaceable, defenseSequence };
    /// var normalized = PlaceableSequenceFactory.EnsureSequences(mixedItems);
    /// placeableList.PopulateWithSequences(normalized);
    /// </code>
    /// 
    /// Behavior:
    /// - PlaceableSequence objects are preserved as-is
    /// - Placeable objects are wrapped in single-item sequences
    /// - Null items are automatically filtered out
    /// - Maintains original display names and properties
    public static global::Godot.Collections.Array<PlaceableSequence> EnsureSequences(global::Godot.Collections.Array<Variant> mixed)
    {
        var normalizedSequences = new global::Godot.Collections.Array<PlaceableSequence>();

        foreach (Variant mixedItem in mixed)
        {
            if (mixedItem.AsGodotObject() == null)
            {
                continue;
            }

            var item = mixedItem.AsGodotObject();

            if (item is PlaceableSequence sequence)
            {
                // Already a sequence - preserve as-is
                normalizedSequences.Add(sequence);
            }
            else if (item is Placeable placeable)
            {
                // Individual placeable - wrap in single-item sequence
                var wrapperSequence = new PlaceableSequence();
                wrapperSequence.DisplayName = placeable.DisplayName;
                wrapperSequence.Placeables.Add(placeable);
                normalizedSequences.Add(wrapperSequence);
                // Note: Other types are silently ignored (could add warning if needed)
            }
        }

        return normalizedSequences;
    }
```

Normalizes a mixed array of Placeables and PlaceableSequences into sequences only.
This implements the "normalize_sequences" pattern suggested in the documentation,
allowing flexible input while ensuring consistent sequence-based output for UI components.

**Returns:** `global::Godot.Collections.Array<PlaceableSequence>`

**Parameters:**
- `global::Godot.Collections.Array<Variant> mixed`

