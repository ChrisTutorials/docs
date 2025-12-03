---
title: "GridBuilding Plugin"
description: "A powerful grid-based building system for Godot games with C# API"
date: 2025-12-01T00:00:00Z
draft: false
weight: 1
categories:
  - "gridbuilding"
  - "documentation"
tags:
  - "godot"
  - "grid"
  - "building"
  - "plugin"
  - "csharp"
---


A powerful, engine-agnostic grid building system for Godot and Unity games. Built with C# and designed for performance, flexibility, and ease of use.

## 🎯 Quick Start

### Installation
```bash
# Add to your Godot project
cp -r GridBuilding /path/to/your/godot/project/addons/
```

### Basic Usage
```csharp
// Add to your scene
var gridNode = new GridBuildingNode();
AddChild(gridNode);

// Place a building
var building = new BuildingData
{
    Name = "House",
    Size = new Vector2I(2, 2),
    GridPosition = new GridPosition(5, 3, new Vector2(64, 64))
};

await gridNode.PlaceBuildingAsync(building);
```

## 📚 Documentation

### 🚀 **For Users**
- **[Getting Started](getting-started/)** - Step-by-step tutorial
- **[API Reference](api-reference/)** - Complete API documentation
- **[Troubleshooting](troubleshooting/)** - Common issues and solutions
- **[Integration Example](godot-integration-example/)** - Complete project example

### 🏗️ **For Developers**
- **[Service Architecture](service-based-architecture/)** - Understanding the architecture
- **[GDScript to C# Migration](gdscript-to-csharp-migration/)** - Why and how we're migrating

## ✨ Features

- **🎮 Engine Agnostic** - Works with Godot and Unity
- **⚡ High Performance** - Optimized for real-time games
- **🔧 Extensible** - Easy to customize and extend
- **🧪 Well Tested** - Comprehensive test coverage
- **📚 Great Documentation** - Complete guides and API reference

## 🏗️ Architecture

GridBuilding uses a clean, service-based architecture:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Godot Layer   │    │  Service Layer  │    │   State Layer   │
│                 │    │                 │    │                 │
│ • GridBuilding  │◄──►│ • Building      │◄──►│ • BuildingData  │
│   Node          │    │   Service       │    │ • GridState     │
│ • UI Controls   │    │ • Manipulation  │    │ • EventData     │
│ • Camera        │    │   Service       │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🎯 Use Cases

- **City Builders** - Place and manage buildings
- **Strategy Games** - Grid-based unit placement
- **Puzzle Games** - Grid-based mechanics
- **RPG Games** - Inventory and crafting systems
- **Sandbox Games** - Creative building tools

## 🚀 Getting Help

- **[GitHub Repository](https://github.com/your-repo/gridbuilding)** - Source code and issues
- **[Discussions](https://github.com/your-repo/gridbuilding/discussions)** - Community discussions
- **[Troubleshooting]({{< ref "troubleshooting" >}})** - Common issues and solutions

---

**Ready to start building?** Check out our [Getting Started]({{< ref "getting-started" >}}) guide!
