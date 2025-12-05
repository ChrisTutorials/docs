---
title: "TestPlacementData"
description: "Test implementation of placement data for validation"
weight: 10
url: "/gridbuilding/v6-0/api/core/testplacementdata/"
---

# TestPlacementData

```csharp
GridBuilding.Core.Systems.Validation
class TestPlacementData
{
    // Members...
}
```

Test implementation of placement data for validation

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Validation/GridBuildingValidator.cs`  
**Namespace:** `GridBuilding.Core.Systems.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Shape

```csharp
public object Shape { get; set; }
```

### Size

```csharp
public Vector2 Size { get; set; }
```

### Tags

```csharp
public List<string> Tags { get; set; }
```

### GridPosition

```csharp
// IPlacementData required members
        public GridBuilding.Core.Types.Rect2I GridPosition { get; set; }
```

### Rotation

```csharp
public float Rotation { get; set; }
```

### IsMirrored

```csharp
public bool IsMirrored { get; set; }
```

### InstanceId

```csharp
public string InstanceId { get; set; }
```

### Definition

```csharp
public PlaceableDefinition Definition { get; set; }
```

### ValidationResult

```csharp
public GridBuilding.Core.Results.ValidationResult ValidationResult { get; set; }
```

### Properties

```csharp
public System.Collections.Generic.Dictionary<string, object> Properties { get; set; }
```


## Methods

### Validate

```csharp
public GridBuilding.Core.Results.ValidationResult Validate()
        {
            var errors = new List<string>();
            
            if (Shape == null)
                errors.Add("Shape is null");
                
            if (Size == Vector2.Zero)
                errors.Add("Size is zero");
                
            if (Tags == null || Tags.Count == 0)
                errors.Add("No tags specified");
            
            var result = new GridBuilding.Core.Results.ValidationResult(errors.Count == 0);
            result.Messages.AddRange(errors);
            return result;
        }
```

**Returns:** `GridBuilding.Core.Results.ValidationResult`

