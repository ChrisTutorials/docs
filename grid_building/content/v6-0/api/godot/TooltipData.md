---
title: "TooltipData"
description: "Tooltip data structure"
weight: 20
url: "/gridbuilding/v6-0/api/godot/tooltipdata/"
---

# TooltipData

```csharp
GridBuilding.Godot.UI
class TooltipData
{
    // Members...
}
```

Tooltip data structure

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/ActionTooltip.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Title

```csharp
public string Title { get; set; } = string.Empty;
```

### Description

```csharp
public string Description { get; set; } = string.Empty;
```

### RichContent

```csharp
public string RichContent { get; set; } = string.Empty;
```

### CustomData

```csharp
public Dictionary<string, object> CustomData { get; set; } = new Dictionary<string, object>();
```

### CreatedAt

```csharp
public DateTime CreatedAt { get; set; } = DateTime.Now;
```

