---
title: "LoadPlaceablesResult"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/loadplaceablesresult/"
---

# LoadPlaceablesResult

```csharp
GridBuilding.Godot.Data
class LoadPlaceablesResult
{
    // Members...
}
```

Result of loading placeables from a folder.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Data/AssetResolver.cs`  
**Namespace:** `GridBuilding.Godot.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Assets

```csharp
public List<Godot.Node> Assets { get; set; } = new();
```

### LoadedPlaceables

```csharp
public List<string> LoadedPlaceables { get; set; } = new();
```

### Errors

```csharp
public List<string> Errors { get; set; } = new();
```

### Warnings

```csharp
public List<string> Warnings { get; set; } = new();
```


## Methods

### IsSuccessful

```csharp
/// <summary>
        /// Gets whether the loading was successful (no errors).
        /// </summary>
        public bool IsSuccessful() => Errors.Count == 0;
```

Gets whether the loading was successful (no errors).

**Returns:** `bool`

### GetSummary

```csharp
/// <summary>
        /// Gets a summary string of the loading results.
        /// </summary>
        public string GetSummary()
        {
            var summary = $"Loaded: {LoadedPlaceables.Count}";
            
            if (Errors.Count > 0)
            {
                summary += $", Errors: {Errors.Count}";
            }
            
            if (Warnings.Count > 0)
            {
                summary += $", Warnings: {Warnings.Count}";
            }
            
            return summary;
        }
```

Gets a summary string of the loading results.

**Returns:** `string`

