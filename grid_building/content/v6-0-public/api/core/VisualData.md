---
title: "VisualData"
description: "Visual representation data"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/visualdata/"
---

# VisualData

```csharp
GridBuilding.Core.Data
class VisualData
{
    // Members...
}
```

Visual representation data

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Data/VisualData.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### AssetPath

```csharp
/// <summary>
        /// Path to the visual asset
        /// </summary>
        public string AssetPath { get; set; } = string.Empty;
```

Path to the visual asset

### VisualAsset

```csharp
/// <summary>
        /// Sprite or mesh data
        /// </summary>
        public object VisualAsset { get; set; }
```

Sprite or mesh data

### Tint

```csharp
/// <summary>
        /// Color tint
        /// </summary>
        public System.Drawing.Color Tint { get; set; } = System.Drawing.Color.White;
```

Color tint

### Scale

```csharp
/// <summary>
        /// Scale factor
        /// </summary>
        public float Scale { get; set; } = 1.0f;
```

Scale factor

### RotationOffset

```csharp
/// <summary>
        /// Rotation offset
        /// </summary>
        public float RotationOffset { get; set; } = 0.0f;
```

Rotation offset

