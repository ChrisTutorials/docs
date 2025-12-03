---
title: "API Reference"
description: "Complete API documentation for the Item Drops plugin"
date: 2025-12-01T00:00:00Z
draft: false
weight: 20
categories:
  - "itemdrops"
  - "documentation"
tags:
  - "godot"
  - "item"
  - "drops"
  - "api"
  - "reference"
  - "csharp"
---


Welcome to the complete API reference for the Item Drops plugin. This section provides detailed documentation for all classes, interfaces, and methods available in the plugin.

## 🔗 Core API

### **[LootGenerator](#lootgenerator)**
The main class for generating item drops based on drop tables and context.

### **[DropTable](#droptable)**
Configuration class that defines possible drops and their probabilities.

### **[DropContext](#dropcontext)**
Contextual data that influences drop generation (player level, luck, location, etc.).

## 📋 Interfaces

### **[ILootGenerator](#ilootgenerator)**
Interface for implementing custom loot generation logic.

### **[IDrop](#idrop)**
Interface for defining individual drop items.

### **[IItemProvider](#iitemprovider)**
Interface for connecting to item databases.

## 🔧 Modifiers

### **[LuckModifier](#luckmodifier)**
Modifies drop chances based on luck factors.

### **[LevelBonusModifier](#levelbonusmodifier)**
Increases drop quantities based on player level.

### **[RarityFilterModifier](#rarityfiltermodifier)**
Filters drops by minimum rarity level.

## 📊 Data Structures

### **[DropResult](#dropresult)**
Contains information about generated drops.

### **[ItemData](#itemdata)**
Item definition and properties.

### **[DropInstance](#dropinstance)**
Runtime representation of a drop.

## 🎯 Schema Documentation

### **[Configuration Schema](schema/)**
Complete schema reference for drop table configuration files.

## 🔍 Quick API Examples

### Basic Usage
```csharp
using ItemDrops.Core.Generation;
using ItemDrops.Core.Types;

// Create generator
var generator = new LootGenerator();

// Set up context
var context = new DropContext();
context.SetData("PlayerLevel", 10);
context.SetData("LuckModifier", 1.2f);

// Generate drops
var drops = generator.GenerateLoot(dropTable, context);
```

### Advanced Usage
```csharp
// Add modifiers
generator.AddModifier(new LuckModifier(1.5f));
generator.AddModifier(new LevelBonusModifier(20, 1.3f));

// Generate with guaranteed drops
var allDrops = generator.GenerateLootWithGuaranteed(
    dropTables, 
    guaranteedDrops, 
    context
);
```

---

**Looking for something specific?** Check the [Schema Documentation](schema/) for configuration details or [Examples](../examples/) for practical usage.
