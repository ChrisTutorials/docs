---
title: "BuildingPlacementResult"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/buildingplacementresult/"
---

# BuildingPlacementResult

```csharp
GridBuilding.Godot.Tests.Environments
class BuildingPlacementResult
{
    // Members...
}
```

Result of building placement operation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/BuildingTestEnvironment.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Environments`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
public bool IsValid { get; private set; }
```

### BuildingData

```csharp
public TestBuildingData? BuildingData { get; private set; }
```

### GridPosition

```csharp
public Vector2I GridPosition { get; private set; }
```

### ErrorMessage

```csharp
public string ErrorMessage { get; private set; } = "";
```


## Methods

### Success

```csharp
public static BuildingPlacementResult Success(TestBuildingData buildingData, Vector2I gridPosition)
        {
            return new BuildingPlacementResult
            {
                IsValid = true,
                BuildingData = buildingData,
                GridPosition = gridPosition
            };
        }
```

**Returns:** `BuildingPlacementResult`

**Parameters:**
- `TestBuildingData buildingData`
- `Vector2I gridPosition`

### Failure

```csharp
public static BuildingPlacementResult Failure(string errorMessage)
        {
            return new BuildingPlacementResult
            {
                IsValid = false,
                ErrorMessage = errorMessage
            };
        }
```

**Returns:** `BuildingPlacementResult`

**Parameters:**
- `string errorMessage`

