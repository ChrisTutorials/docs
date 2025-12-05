---
title: "Troubleshooting Guide"
description: "Common issues and solutions for the GridBuilding plugin"
date: 2025-12-01T00:00:00Z
draft: false
weight: 30
categories:
  - "gridbuilding"
  - "documentation"
tags:
  - "godot"
  - "grid"
  - "troubleshooting"
  - "help"
  - "issues"
aliases: ["/latest/guides/troubleshooting/", "/gridbuilding/latest/guides/troubleshooting/"]
---


This guide helps you diagnose and resolve common issues with the GridBuilding plugin.

## 🚨 Quick Diagnosis

### Issue Checklist

Before diving into specific issues, run through this quick checklist:

- [ ] **Plugin Enabled**: GridBuilding plugin is enabled in Project Settings
- [ ] **.NET SDK**: .NET 8.0 SDK is installed and working
- [ ] **Godot Version**: Using Godot 4.x (not 3.x)
- [ ] **C# Compilation**: No C# compilation errors in your project
- [ ] **Scene Setup**: GridBuildingNode is properly added to your scene
- [ ] **References**: All using statements and references are correct

---

## 🛠️ Installation Issues

### Plugin Not Appearing in Project Settings

**Symptoms**: GridBuilding plugin doesn't show up in Project Settings → Plugins

**Causes & Solutions**:

1. **Wrong folder location**
   ```bash
   # Correct location
   /your-project/addons/GridBuilding/
   
   # Wrong locations
   /your-project/GridBuilding/
   /your-project/addons/gridbuilding/
   ```

2. **Missing plugin.cfg**
   - Ensure `GridBuilding/plugin.cfg` exists
   - Check that the name matches the folder name

3. **Permissions issue**
   ```bash
   # Fix permissions on Linux/Mac
   chmod -R 755 /your-project/addons/GridBuilding/
   ```

### C# Compilation Errors

**Symptoms**: Red squiggly lines, "Type or namespace could not be found"

**Causes & Solutions**:

1. **Missing .NET SDK**
   ```bash
   # Check .NET version
   dotnet --version
   
   # Should show 8.0.x or higher
   ```

2. **Wrong using statements**
   ```csharp
   // Correct using statements
   using GridBuilding.Godot.Core;
   using GridBuilding.Core.Services.Building;
   using GridBuilding.Core.Grid;
   ```

3. **Plugin not enabled**
   - Enable plugin in Project Settings → Plugins
   - Restart Godot after enabling

4. **Cache corruption**
   ```bash
   # Clear Godot cache
   rm -rf /your-project/.godot/
   ```

---

## 🎮 Runtime Issues

### Grid Not Visible

**Symptoms**: Can't see grid lines or grid overlay

**Diagnosis Steps**:

1. **Check GridBuildingNode properties**:
   - `Show Grid` should be `true`
   - `Grid Color` should be visible (not transparent)
   - `Grid Size` should be reasonable (e.g., `Vector2(10, 10)`)
   - `Tile Size` should be appropriate (e.g., `Vector2(64, 64)`)

2. **Check node hierarchy**:
   ```csharp
   // In your _Ready() method
   var gridNode = GetNode<GridBuildingNode>("GridBuildingNode");
   if (gridNode == null)
   {
       GD.PrintErr("GridBuildingNode not found!");
       return;
   }
   ```

3. **Check camera settings**:
   - Ensure camera is positioned to see the grid
   - Check that grid is within camera viewport

### Buildings Not Placing

**Symptoms**: Clicking doesn't place buildings, no visual feedback

**Diagnosis Steps**:

1. **Check placement result**:
   ```csharp
   var result = await gridNode.PlaceBuildingAsync(buildingData);
   if (!result.Success)
   {
       GD.PrintErr($"Placement failed: {result.ErrorMessage}");
   }
   ```

2. **Common placement errors**:
   - `Position out of bounds` - Click outside grid area
   - `Position already occupied` - Another building exists there
   - `Invalid building data` - Missing required properties

3. **Debug grid position**:
   ```csharp
   var mousePos = GetGlobalMousePosition();
   var gridPos = gridNode.ScreenToGrid(mousePos);
   GD.Print($"Mouse: {mousePos}, Grid: {gridPos}");
   ```

### Events Not Firing

**Symptoms**: BuildingPlaced/Removed events not being called

**Diagnosis Steps**:

1. **Check event subscription**:
   ```csharp
   public override void _Ready()
   {
       var gridNode = GetNode<GridBuildingNode>("GridBuildingNode");
       
       // Subscribe to events
       gridNode.BuildingPlaced += OnBuildingPlaced;
       gridNode.BuildingRemoved += OnBuildingRemoved;
       
       // Verify subscription
       GD.Print("Events subscribed successfully");
   }
   
   private void OnBuildingPlaced(BuildingData building)
   {
       GD.Print($"Building placed: {building.Name}");
   }
   ```

2. **Check async/await usage**:
   ```csharp
   // Correct - await the async method
   var result = await gridNode.PlaceBuildingAsync(buildingData);
   
   // Wrong - not awaiting
   var result = gridNode.PlaceBuildingAsync(buildingData); // Won't work!
   ```

3. **Add debug logging**:
   ```csharp
   private void OnBuildingPlaced(BuildingData building)
   {
       GD.Print($"=== Building Placed Event ===");
       GD.Print($"Name: {building.Name}");
       GD.Print($"Position: {building.GridPosition}");
       GD.Print($"Type: {building.BuildingType}");
   }
   ```

---

## 🔧 Performance Issues

### Slow Grid Performance

**Symptoms**: Lag when placing buildings, slow response times

**Diagnosis Steps**:

1. **Check grid size**:
   ```csharp
   // Large grids can be slow
   // Consider keeping under 100x100 for real-time interaction
   ```

2. **Profile the code**:
   ```csharp
   public override void _Input(InputEvent @event)
   {
       var stopwatch = System.Diagnostics.Stopwatch.StartNew();
       
       // Your placement code here...
       
       stopwatch.Stop();
       GD.Print($"Placement took: {stopwatch.ElapsedMilliseconds}ms");
   }
   ```

3. **Optimize building count**:
   - Limit number of buildings visible at once
   - Use culling for off-screen buildings
   - Consider object pooling for building visuals

### Memory Usage Growing

**Symptoms**: Memory usage increases over time

**Diagnosis Steps**:

1. **Check for memory leaks**:
   ```csharp
   // Ensure you're removing visual nodes when buildings are removed
   private void OnBuildingRemoved(BuildingData building)
   {
       if (building.Properties.ContainsKey("visual_node"))
       {
           var visualNode = (Node)building.Properties["visual_node"];
           visualNode.QueueFree(); // Proper cleanup
       }
   }
   ```

2. **Monitor memory usage**:
   ```csharp
   public override void _Process(double delta)
   {
       if (Engine.GetFramesDrawn() % 60 == 0) // Once per second
       {
           var memory = OS.GetStaticMemoryUsageByType()[OS.MemoryTypeType.Static];
           GD.Print($"Memory usage: {memory / 1024 / 1024} MB");
       }
   }
   ```

---

## 🐛 Common Code Issues

### Null Reference Exceptions

**Symptoms**: `Object reference not set to an instance of an object`

**Common Causes & Solutions**:

1. **GridBuildingNode not found**:
   ```csharp
   // Wrong - path doesn't exist
   var gridNode = GetNode<GridBuildingNode>("WrongPath");
   
   // Correct - use actual path
   var gridNode = GetNode<GridBuildingNode>("GridBuildingNode");
   
   // Safe approach
   var gridNode = GetNode<GridBuildingNode>("GridBuildingNode");
   if (gridNode == null)
   {
       GD.PrintErr("GridBuildingNode not found!");
       return;
   }
   ```

2. **Building data missing properties**:
   ```csharp
   // Wrong - missing required properties
   var building = new BuildingData();
   
   // Correct - set required properties
   var building = new BuildingData
   {
       Name = "House",
       BuildingType = "Residential",
       Size = new Vector2I(2, 2),
       GridPosition = new GridPosition(5, 3, new Vector2(64, 64))
   };
   ```

### Async/Await Issues

**Symptoms**: Code not executing in expected order, race conditions

**Solutions**:

1. **Make methods async**:
   ```csharp
   // Wrong - trying to use async method in sync context
   public void _Input(InputEvent @event)
   {
       var result = await gridNode.PlaceBuildingAsync(buildingData); // Error!
   }
   
   // Correct - make method async
   public override async void _Input(InputEvent @event)
   {
       var result = await gridNode.PlaceBuildingAsync(buildingData); // Works!
   }
   ```

2. **Handle async properly**:
   ```csharp
   // Use ConfigureAwait(false) in library code
   var result = await gridNode.PlaceBuildingAsync(buildingData).ConfigureAwait(false);
   ```

---

## 🗂️ File System Issues

### File Not Found Errors

**Symptoms**: `File not found` errors when loading assets

**Solutions**:

1. **Check file paths**:
   ```csharp
   // Wrong - relative path from wrong location
   var texture = GD.Load<Texture2D>("house.png");
   
   // Correct - use res:// prefix
   var texture = GD.Load<Texture2D>("res://assets/house.png");
   
   // Debug path
   GD.Print($"Looking for: res://assets/house.png");
   GD.Print($"File exists: {FileAccess.FileExists("res://assets/house.png")}");
   ```

2. **Import settings**:
   - Ensure textures are properly imported in Godot
   - Check that files are marked as importable
   - Reimport if necessary

### Save/Load Issues

**Symptoms**: Can't save or load grid state

**Solutions**:

1. **Check file permissions**:
   ```csharp
   // Test write access
   var testFile = FileAccess.Open("user://test.txt", FileAccess.ModeFlags.Write);
   if (testFile == null)
   {
       GD.PrintErr("Cannot write to user:// directory");
   }
   else
   {
       testFile.Close();
       DirAccess.RemoveAbsolute("user://test.txt");
   }
   ```

2. **Use proper paths**:
   ```csharp
   // Correct - use user:// for save data
   var savePath = "user://grid_save.json";
   
   // Wrong - might not have permissions
   var savePath = "res://saves/grid_save.json";
   ```

---

## 🧪 Debugging Techniques

### Enable Debug Logging

```csharp
public class MyGridScene : Node2D
{
    private bool _debugMode = true;
    
    private void DebugPrint(string message)
    {
        if (_debugMode)
        {
            GD.Print($"[GridDebug] {message}");
        }
    }
    
    public override void _Input(InputEvent @event)
    {
        DebugPrint($"Input event: {@event.GetType().Name}");
        
        if (@event is InputEventMouseButton mouseButton)
        {
            var pos = GetGlobalMousePosition();
            var gridPos = _gridNode.ScreenToGrid(pos);
            DebugPrint($"Mouse: {pos}, Grid: {gridPos}");
        }
    }
}
```

### Visual Debugging

```csharp
// Add visual indicators for debugging
private void DrawDebugInfo()
{
    if (!_debugMode) return;
    
    // Draw grid coordinates
    for (int x = 0; x < _gridNode.GridSize.X; x++)
    {
        for (int y = 0; y < _gridNode.GridSize.Y; y++)
        {
            var gridPos = new GridPosition(x, y, _gridNode.TileSize);
            var worldPos = gridPos.ToWorldPosition();
            
            // Draw coordinate text
            var label = new Label();
            label.Text = $"{x},{y}";
            label.Position = worldPos;
            label.Modulate = Colors.White;
            AddChild(label);
        }
    }
}
```

### Performance Profiling

```csharp
public override void _Process(double delta)
{
    if (Input.IsActionJustPressed("ui_accept")) // Press Enter to profile
    {
        ProfileGridOperations();
    }
}

private void ProfileGridOperations()
{
    var stopwatch = System.Diagnostics.Stopwatch.StartNew();
    
    // Test placement performance
    for (int i = 0; i < 100; i++)
    {
        var building = new BuildingData
        {
            Name = $"TestBuilding{i}",
            BuildingType = "Test",
            Size = new Vector2I(1, 1),
            GridPosition = new GridPosition(i % 10, i / 10, new Vector2(64, 64))
        };
        
        var result = _gridNode.PlaceBuildingAsync(building).Result;
    }
    
    stopwatch.Stop();
    GD.Print($"100 placements took: {stopwatch.ElapsedMilliseconds}ms");
}
```

---

## 🆘 Getting Help

### When to Ask for Help

- You've tried all the solutions above
- The issue is blocking your development
- You suspect a bug in the plugin itself
- You need clarification on how to use a feature

### How to Ask for Help

1. **Provide context**:
   - Godot version
   - GridBuilding version (if known)
   - Operating system
   - What you're trying to accomplish

2. **Include error messages**:
   - Full error text
   - Call stack if available
   - Steps to reproduce the issue

3. **Share relevant code**:
   - Minimal reproduction case
   - Scene setup
   - Configuration settings

4. **What you've tried**:
   - List of solutions attempted
   - Results of debugging steps

### Resources

- **[GitHub Issues](https://github.com/your-repo/gridbuilding/issues)** - Report bugs and request features
- **[Discussions](https://github.com/your-repo/gridbuilding/discussions)** - Ask questions and share ideas
- **[Documentation](../README.md)** - Main documentation index
- **[API Reference](API_REFERENCE.md)** - Detailed API documentation

---

## 📋 Common Error Messages

| Error Message | Likely Cause | Solution |
|--------------|--------------|----------|
| `Type or namespace 'GridBuilding' could not be found` | Missing using statement or plugin not enabled | Add `using GridBuilding.Godot.Core;` and enable plugin |
| `Object reference not set to an instance of an object` | Null reference to GridBuildingNode | Check node path and ensure node exists |
| `Position out of bounds` | Clicking outside grid area | Ensure clicks are within grid boundaries |
| `Position already occupied` | Building already exists at position | Check for existing buildings before placement |
| `File not found: res://path/to/file` | Incorrect file path or missing file | Use `res://` prefix and verify file exists |
| `Cannot access GridBuildingNode from another thread` | Threading issue | Ensure all grid operations happen on main thread |

---

**Still having issues?** Don't hesitate to reach out for help. The GridBuilding community is here to support you!
