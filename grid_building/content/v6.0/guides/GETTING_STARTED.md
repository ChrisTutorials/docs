---
title: "Getting Started with GridBuilding"
description: "Step-by-step tutorial for setting up and using the GridBuilding plugin in Godot"
date: 2025-12-01T00:00:00Z
draft: false
weight: 10
categories:
  - "gridbuilding"
  - "documentation"
tags:
  - "godot"
  - "grid"
  - "tutorial"
  - "getting-started"
aliases: ["/latest/guides/getting-started/", "/gridbuilding/latest/guides/getting-started/"]
---

This tutorial will walk you through setting up and using the GridBuilding plugin in your Godot project.

## 🎯 Prerequisites

- **Godot 4.x** - Latest stable version
- **.NET 8.0 SDK** - For C# support in Godot
- **Basic C# knowledge** - Understanding of classes, methods, and events

## 📦 Installation

### Step 1: Add Plugin to Your Project

1. **Download or clone** the GridBuilding plugin
2. **Copy to your project**:
   ```bash
   cp -r GridBuilding /path/to/your/godot/project/addons/
   ```

### Step 1.5: C# Project Setup (Recommended)

If you use C#, import the plugin's shared MSBuild props file into your Godot project's `.csproj`.

Example (edit your Godot project's `.csproj`):

```xml
<Project Sdk="Godot.NET.Sdk/4.4.1">
  <Import Project="addons/GridPlacement/Godot/GridPlacement.Godot.props" />

  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
  </PropertyGroup>
</Project>
```

This keeps the plugin's build settings and Core reference rules consistent without requiring you to manually copy/paste `ProjectReference` or `Reference` blocks.

### Step 2: Enable the Plugin

1. **Open your Godot project**
2. Go to **Project → Project Settings → Plugins**
3. **Enable "GridBuilding"** plugin
4. **Restart Godot** to ensure proper loading

### Step 3: Verify Installation

1. **Check the plugin** appears in the scene tree
2. **Look for GridBuilding** nodes in the "Add Node" dialog
3. **Verify C# compilation** - no errors should appear

## 🚀 Your First Grid

### Step 1: Create a Basic Scene

1. **Create a new scene**: `Scene → New Scene`
2. **Add a Node2D** as the root node
3. **Add a GridBuildingNode**:
   - Click "Add Node"
   - Search for "GridBuildingNode"
   - Add it to your scene

### Step 2: Configure the Grid

1. **Select the GridBuildingNode**
2. **In the Inspector**, set these properties:
   - **Grid Size**: `Vector2(10, 10)` - 10x10 grid
   - **Tile Size**: `Vector2(64, 64)` - 64x64 pixel tiles
   - **Grid Color**: Choose a visible color
   - **Show Grid**: Enable to see the grid lines

### Step 3: Add a Script

1. **Create a C# script** for your root node:
   ```csharp
   using Godot;
   using GridBuilding.Godot.Core;
   
   public partial class MyGridScene : Node2D
   {
       private GridBuildingNode _gridNode;
       
       public override void _Ready()
       {
           // Get reference to grid node
           _gridNode = GetNode<GridBuildingNode>("GridBuildingNode");
           
           // Connect to events
           _gridNode.BuildingPlaced += OnBuildingPlaced;
           _gridNode.BuildingRemoved += OnBuildingRemoved;
           
           GD.Print("Grid scene initialized!");
       }
       
       private void OnBuildingPlaced(BuildingData building)
       {
           GD.Print($"Building '{building.Name}' placed at {building.GridPosition}");
       }
       
       private void OnBuildingRemoved(BuildingData building)
       {
           GD.Print($"Building '{building.Name}' removed from {building.GridPosition}");
       }
   }
   ```

2. **Attach the script** to your root node

### Step 4: Test the Grid

1. **Run the scene** (F6)
2. **You should see** a grid overlay
3. **Click on grid tiles** to test interaction
4. **Check the output** for event messages

## 🏗️ Adding Buildings

### Step 1: Create Building Data

```csharp
using GridBuilding.Core.Services.Building;
using GridBuilding.Core.Grid;

public partial class MyGridScene : Node2D
{
    // ... previous code ...
    
    public override void _Input(InputEvent @event)
    {
        // Handle mouse click
        if (@event is InputEventMouseButton mouseButton && 
            mouseButton.Pressed && 
            mouseButton.ButtonIndex == MouseButton.Left)
        {
            // Get mouse position
            var mousePos = GetGlobalMousePosition();
            
            // Convert to grid position
            var gridPos = _gridNode.ScreenToGrid(mousePos);
            
            // Create building data
            var buildingData = new BuildingData
            {
                Name = "House",
                BuildingType = "Residential",
                Size = new Vector2I(2, 2), // 2x2 tiles
                GridPosition = gridPos
            };
            
            // Try to place the building
            var result = await _gridNode.PlaceBuildingAsync(buildingData);
            
            if (result.Success)
            {
                GD.Print($"Building placed at {gridPos}");
            }
            else
            {
                GD.Print($"Cannot place building: {result.ErrorMessage}");
            }
        }
    }
}
```

### Step 2: Add Building Visuals

1. **Create a sprite** for your building:
   - Add a `Sprite2D` node
   - Set a texture or color
   - Size it appropriately

2. **Modify the building placement**:
```csharp
private void OnBuildingPlaced(BuildingData building)
{
    // Create visual representation
    var sprite = new Sprite2D();
    sprite.Texture = GD.Load<Texture2D>("res://assets/house.png");
    sprite.Position = building.GridPosition.ToWorldPosition();
    sprite.Scale = new Vector2(2, 2); // Match 2x2 grid size
    
    // Add to scene
    AddChild(sprite);
    
    // Store reference for later removal
    building.Properties["visual_node"] = sprite;
}
```

## 🎮 Building Manipulation

### Step 1: Enable Building Selection

```csharp
private BuildingData _selectedBuilding;

public override void _Input(InputEvent @event)
{
    if (@event is InputEventMouseButton mouseButton && 
        mouseButton.Pressed && 
        mouseButton.ButtonIndex == MouseButton.Left)
    {
        var mousePos = GetGlobalMousePosition();
        var gridPos = _gridNode.ScreenToGrid(mousePos);
        
        // Check if there's a building at this position
        var existingBuilding = _gridNode.GetBuildingAt(gridPos);
        
        if (existingBuilding != null)
        {
            // Select existing building
            _selectedBuilding = existingBuilding;
            GD.Print($"Selected building: {existingBuilding.Name}");
        }
        else if (_selectedBuilding != null)
        {
            // Move selected building
            var result = await _gridNode.MoveBuildingAsync(_selectedBuilding, gridPos);
            
            if (result.Success)
            {
                GD.Print($"Building moved to {gridPos}");
            }
            else
            {
                GD.Print($"Cannot move building: {result.ErrorMessage}");
            }
            
            _selectedBuilding = null;
        }
        else
        {
            // Place new building
            var buildingData = new BuildingData
            {
                Name = "House",
                BuildingType = "Residential",
                Size = new Vector2I(2, 2),
                GridPosition = gridPos
            };
            
            await _gridNode.PlaceBuildingAsync(buildingData);
        }
    }
    
    // Cancel selection with right click
    if (@event is InputEventMouseButton rightButton && 
        rightButton.Pressed && 
        rightButton.ButtonIndex == MouseButton.Right)
    {
        _selectedBuilding = null;
        GD.Print("Selection cancelled");
    }
}
```

### Step 2: Add Visual Feedback

```csharp
private Sprite2D _selectionIndicator;

public override void _Ready()
{
    // ... previous code ...
    
    // Create selection indicator
    _selectionIndicator = new Sprite2D();
    _selectionIndicator.Texture = GD.Load<Texture2D>("res://assets/selection.png");
    _selectionIndicator.Modulate = Colors.Yellow;
    _selectionIndicator.Visible = false;
    AddChild(_selectionIndicator);
}

private void UpdateSelectionVisual(BuildingData building)
{
    if (building != null)
    {
        _selectionIndicator.Position = building.GridPosition.ToWorldPosition();
        _selectionIndicator.Visible = true;
    }
    else
    {
        _selectionIndicator.Visible = false;
    }
}
```

## 🔧 Advanced Features

### Custom Building Types

```csharp
public class CustomBuildingData : BuildingData
{
    public int Capacity { get; set; }
    public float ComfortLevel { get; set; }
    public List<string> Residents { get; set; } = new();
}

// Usage
var customBuilding = new CustomBuildingData
{
    Name = "Apartment",
    BuildingType = "Residential",
    Size = new Vector2I(3, 3),
    GridPosition = gridPos,
    Capacity = 8,
    ComfortLevel = 85.5f
};
```

### Grid Validation Rules

```csharp
// Custom validation
public class CustomPlacementRule : IPlacementRule
{
    public PlacementValidation Validate(BuildingData building, GridPosition position, IGridMap gridMap)
    {
        // Only allow residential buildings near roads
        if (building.BuildingType == "Residential")
        {
            var hasNearbyRoad = CheckNearbyRoad(position, gridMap);
            if (!hasNearbyRoad)
            {
                return PlacementResult.Invalid("Residential buildings must be placed near roads");
            }
        }
        
        return PlacementResult.Valid();
    }
    
    private bool CheckNearbyRoad(GridPosition position, IGridMap gridMap)
    {
        // Check adjacent tiles for roads
        foreach (var neighbor in position.GetNeighbors())
        {
            var building = gridMap.GetBuildingAt(neighbor);
            if (building?.BuildingType == "Road")
            {
                return true;
            }
        }
        return false;
    }
}
```

### Save and Load System

```csharp
// Save grid state
public async Task SaveGridState(string filePath)
{
    var gridState = _gridNode.GetGridState();
    var json = JsonSerializer.Serialize(gridState);
    
    using var file = FileAccess.Open(filePath, FileAccess.ModeFlags.Write);
    file.StoreString(json);
    file.Close();
    
    GD.Print($"Grid state saved to {filePath}");
}

// Load grid state
public async Task LoadGridState(string filePath)
{
    using var file = FileAccess.Open(filePath, FileAccess.ModeFlags.Read);
    var json = file.GetAsText();
    file.Close();
    
    var gridState = JsonSerializer.Deserialize<GridState>(json);
    await _gridNode.LoadGridState(gridState);
    
    GD.Print($"Grid state loaded from {filePath}");
}
```

## 🐛 Common Issues and Solutions

### Issue: Grid Not Visible

**Problem**: Can't see the grid overlay

**Solutions**:
1. Check **Show Grid** is enabled in the GridBuildingNode
2. Verify **Grid Color** is not transparent
3. Ensure **Grid Size** and **Tile Size** are reasonable values
4. Check that the GridBuildingNode is in the visible scene tree

### Issue: Buildings Not Placing

**Problem**: Clicking doesn't place buildings

**Solutions**:
1. Check the **PlacementResult.ErrorMessage** for details
2. Verify the grid position is valid (within bounds)
3. Ensure the position isn't already occupied
4. Check building size doesn't exceed grid boundaries

### Issue: C# Compilation Errors

**Problem**: Red squiggly lines in code

**Solutions**:
1. Ensure **.NET 8.0 SDK** is installed
2. Check **using statements** at the top of your script
3. Verify **GridBuilding plugin** is properly enabled
4. Restart Godot after enabling the plugin

### Issue: Events Not Firing

**Problem**: BuildingPlaced/Removed events not working

**Solutions**:
1. Ensure events are connected in `_Ready()` method
2. Check that the GridBuildingNode reference is not null
3. Verify async methods are properly awaited
4. Add debug prints to verify event subscription

## 📚 Next Steps

Now that you have a basic grid system working, explore these topics:

1. **[API Reference](API_REFERENCE.md)** - Detailed API documentation
2. **[Architecture Guide](../ARCHITECTURE_LIVING_DOCUMENT.md)** - Understand the system architecture
3. **[Testing Guide](../Docs/Testing/)** - Learn how to test your grid system
4. **[Examples](../examples/)** - More advanced examples and patterns

## 🎯 Quick Reference

### Essential Code Patterns

```csharp
// Basic setup
var gridNode = GetNode<GridBuildingNode>("GridBuildingNode");
gridNode.BuildingPlaced += OnBuildingPlaced;

// Place building
var building = new BuildingData { /* properties */ };
var result = await gridNode.PlaceBuildingAsync(building);

// Get building at position
var building = gridNode.GetBuildingAt(gridPosition);

// Move building
var result = await gridNode.MoveBuildingAsync(building, newPosition);

// Remove building
var success = await gridNode.RemoveBuildingAsync(building);
```

### Common Event Handlers

```csharp
private void OnBuildingPlaced(BuildingData building)
{
    GD.Print($"Building placed: {building.Name}");
    // Add visual representation
}

private void OnBuildingRemoved(BuildingData building)
{
    GD.Print($"Building removed: {building.Name}");
    // Remove visual representation
}
```

---

**Need help?** Check the [troubleshooting guide](TROUBLESHOOTING.md) or create an issue in the project repository.
