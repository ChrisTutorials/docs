---
title: "InventoryItem"
description: "Mock inventory item for testing Godot integration.
In a real implementation, this would be defined in the inventory system."
weight: 20
url: "/gridbuilding/v6-0/api/godot/inventoryitem/"
---

# InventoryItem

```csharp
GridBuilding.Core.Data
class InventoryItem
{
    // Members...
}
```

Mock inventory item for testing Godot integration.
In a real implementation, this would be defined in the inventory system.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/InventoryItem.cs`  
**Namespace:** `GridBuilding.Core.Data`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ItemId

```csharp
public string ItemId { get; set; } = "";
```

### Quantity

```csharp
public int Quantity { get; set; }
```

### DisplayName

```csharp
public string DisplayName { get; set; } = "";
```

### Description

```csharp
public string Description { get; set; } = "";
```

### CustomData

```csharp
public Dictionary<string, object> CustomData { get; set; } = new();
```

