---
title: "MockPlaceableSequence"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockplaceablesequence/"
---

# MockPlaceableSequence

```csharp
GridBuilding.Godot.Tests.Systems.UI.Placeable
class MockPlaceableSequence
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Integration/Systems/UI/Placeable/PlaceableSelectionUITest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### _Get

```csharp
public override Variant _Get(StringName property)
    {
        if (property == "display_name")
            return _displayName;
        if (property == "count")
            return _variants.Length;
        return base._Get(property);
    }
```

**Returns:** `Variant`

**Parameters:**
- `StringName property`

### _HasMethod

```csharp
public override bool _HasMethod(StringName method)
    {
        return method == "get_variant" || method == "count" || base._HasMethod(method);
    }
```

**Returns:** `bool`

**Parameters:**
- `StringName method`

### _Call

```csharp
public override Variant _Call(StringName method, params Variant[] args)
    {
        if (method == "get_variant" && args.Length > 0)
        {
            int index = args[0].AsInt32();
            if (index >= 0 && index < _variants.Length)
            {
                var variant = new Placeable();
                variant.DisplayName = _variants[index];
                return variant;
            }
        }
        if (method == "count")
        {
            return _variants.Length;
        }
        return base._Call(method, args);
    }
```

**Returns:** `Variant`

**Parameters:**
- `StringName method`
- `Variant[] args`

