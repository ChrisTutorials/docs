---
title: "ModeSettings"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/modesettings/"
---

# ModeSettings

```csharp
GridBuilding.Core.Types
class ModeSettings
{
    // Members...
}
```

Mode-specific settings and preferences

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/ModeSettings.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ViewSettings

```csharp
/// <summary>
        /// View mode settings
        /// </summary>
        public ViewModeSettings ViewSettings { get; set; } = new();
```

View mode settings

### GameSettings

```csharp
/// <summary>
        /// Game mode settings
        /// </summary>
        public GameModeSettings GameSettings { get; set; } = new();
```

Game mode settings

### EditSettings

```csharp
/// <summary>
        /// Edit mode settings
        /// </summary>
        public EditModeSettings EditSettings { get; set; } = new();
```

Edit mode settings

### UISettings

```csharp
/// <summary>
        /// UI mode settings
        /// </summary>
        public UIModeSettings UISettings { get; set; } = new();
```

UI mode settings

### CustomProperties

```csharp
/// <summary>
        /// Custom mode-specific properties
        /// </summary>
        public Dictionary<string, object> CustomProperties { get; set; } = new();
```

Custom mode-specific properties

