---
title: "Godot Integration Example"
description: "Complete example of integrating GridBuilding with a Godot project including UI, camera controls, and advanced features"
date: 2025-12-01T00:00:00Z
draft: false
weight: 40
categories:
  - "gridbuilding"
  - "documentation"
tags:
  - "godot"
  - "grid"
  - "integration"
  - "example"
  - "tutorial"
  - "complete"
aliases: ["/latest/examples/godot-integration-example/", "/gridbuilding/latest/examples/godot-integration-example/"]
---


This guide shows how to integrate GridBuilding with a complete Godot project, including UI, camera controls, and advanced features.

## 🎯 Complete Example Project

This example creates a city builder game with:
- Grid-based building placement
- Camera pan and zoom
- Building selection UI
- Save/load functionality
- Building categories and types

---

## 🏗️ Project Structure

```
res://scenes/
├── main_scene.tscn              # Main game scene
├── ui/
│   ├── building_menu.tscn       # Building selection menu
│   ├── building_info_panel.tscn # Building information panel
│   └── save_load_menu.tscn      # Save/load interface
├── buildings/
│   ├── house.tscn               # House building scene
│   ├── factory.tscn             # Factory building scene
│   └── road.tscn                # Road building scene
└── world/
    ├── grid_manager.tscn        # Grid management scene
    └── camera_controller.tscn   # Camera control scene
```

---

## 🎮 Main Scene Setup

### MainScene.cs

```csharp
using Godot;
using GridBuilding.Godot.Core;
using GridBuilding.Core.Services.Building;
using GridBuilding.Core.Grid;
using System.Collections.Generic;

public partial class MainScene : Node
{
    // Core components
    private GridBuildingNode _gridNode;
    private CameraController _cameraController;
    private BuildingMenu _buildingMenu;
    private BuildingInfoPanel _infoPanel;
    
    // Game state
    private BuildingData _selectedBuildingType;
    private BuildingData _hoveredBuilding;
    private bool _isPlacingBuilding = false;
    
    // Building definitions
    private Dictionary<string, BuildingData> _buildingTemplates = new();
    
    public override void _Ready()
    {
        InitializeGrid();
        InitializeUI();
        InitializeCamera();
        LoadBuildingTemplates();
        ConnectEvents();
    }
    
    private void InitializeGrid()
    {
        // Find or create grid node
        _gridNode = GetNode<GridBuildingNode>("World/GridManager");
        
        if (_gridNode == null)
        {
            GD.PrintErr("GridBuildingNode not found!");
            return;
        }
        
        // Configure grid
        _gridNode.GridSize = new Vector2I(50, 50);
        _gridNode.TileSize = new Vector2(64, 64);
        _gridNode.ShowGrid = true;
        _gridNode.GridColor = Colors.White.WithAlpha(0.3f);
    }
    
    private void InitializeUI()
    {
        _buildingMenu = GetNode<BuildingMenu>("UI/BuildingMenu");
        _infoPanel = GetNode<BuildingInfoPanel>("UI/BuildingInfoPanel");
        
        // Connect UI events
        _buildingMenu.BuildingSelected += OnBuildingTypeSelected;
        _buildingMenu.CancelPlacement += OnCancelPlacement;
    }
    
    private void InitializeCamera()
    {
        _cameraController = GetNode<CameraController>("World/CameraController");
        _cameraController.Initialize(_gridNode);
    }
    
    private void LoadBuildingTemplates()
    {
        // Define building types
        _buildingTemplates["House"] = new BuildingData
        {
            Name = "House",
            BuildingType = "Residential",
            Size = new Vector2I(2, 2),
            Properties = new Dictionary<string, object>
            {
                ["Capacity"] = 4,
                ["Comfort"] = 75,
                ["Cost"] = 1000
            }
        };
        
        _buildingTemplates["Factory"] = new BuildingData
        {
            Name = "Factory",
            BuildingType = "Industrial",
            Size = new Vector2I(3, 3),
            Properties = new Dictionary<string, object>
            {
                ["Production"] = 10,
                ["Pollution"] = 5,
                ["Cost"] = 5000
            }
        };
        
        _buildingTemplates["Road"] = new BuildingData
        {
            Name = "Road",
            BuildingType = "Infrastructure",
            Size = new Vector2I(1, 1),
            Properties = new Dictionary<string, object>
            {
                ["SpeedBonus"] = 1.2f,
                ["Cost"] = 100
            }
        };
        
        // Load templates into UI
        _buildingMenu.LoadBuildingTemplates(_buildingTemplates.Values);
    }
    
    private void ConnectEvents()
    {
        _gridNode.BuildingPlaced += OnBuildingPlaced;
        _gridNode.BuildingRemoved += OnBuildingRemoved;
        _gridNode.BuildingHovered += OnBuildingHovered;
    }
}
```

---

## 🏗️ Building System

### Building Placement Logic

```csharp
public override void _Input(InputEvent @event)
{
    if (@event is InputEventMouseButton mouseButton)
    {
        HandleMouseClick(mouseButton);
    }
    else if (@event is InputEventMouseMotion mouseMotion)
    {
        HandleMouseMotion(mouseMotion);
    }
    else if (@event is InputEventKey keyEvent && keyEvent.Pressed)
    {
        HandleKeyPress(keyEvent);
    }
}

private void HandleMouseClick(InputEventMouseButton mouseButton)
{
    var mousePos = GetGlobalMousePosition();
    var gridPos = _gridNode.ScreenToGrid(mousePos);
    
    if (mouseButton.ButtonIndex == MouseButton.Left)
    {
        if (_isPlacingBuilding && _selectedBuildingType != null)
        {
            PlaceBuilding(gridPos);
        }
        else
        {
            SelectBuilding(gridPos);
        }
    }
    else if (mouseButton.ButtonIndex == MouseButton.Right)
    {
        if (_isPlacingBuilding)
        {
            OnCancelPlacement();
        }
        else
        {
            RemoveBuilding(gridPos);
        }
    }
}

private async void PlaceBuilding(GridPosition position)
{
    // Create building data from template
    var buildingData = CreateBuildingFromTemplate(_selectedBuildingType, position);
    
    // Check placement validity
    var validation = _gridNode.ValidatePlacement(buildingData, position);
    if (!validation.IsValid)
    {
        ShowMessage($"Cannot place building: {validation.Reason}");
        return;
    }
    
    // Check resources
    if (!CanAffordBuilding(buildingData))
    {
        ShowMessage("Not enough resources!");
        return;
    }
    
    // Place the building
    var result = await _gridNode.PlaceBuildingAsync(buildingData);
    
    if (result.Success)
    {
        // Deduct resources
        DeductResources(buildingData);
        
        // Show success feedback
        ShowMessage($"{buildingData.Name} placed successfully!");
        
        // Exit placement mode
        OnCancelPlacement();
    }
    else
    {
        ShowMessage($"Failed to place building: {result.ErrorMessage}");
    }
}

private BuildingData CreateBuildingFromTemplate(BuildingData template, GridPosition position)
{
    return new BuildingData
    {
        Id = System.Guid.NewGuid().ToString(),
        Name = template.Name,
        BuildingType = template.BuildingType,
        Size = template.Size,
        GridPosition = position,
        Properties = new Dictionary<string, object>(template.Properties),
        PlacedAt = System.DateTime.Now
    };
}
```

### Building Selection

```csharp
private void SelectBuilding(GridPosition position)
{
    var building = _gridNode.GetBuildingAt(position);
    
    if (building != null)
    {
        // Show building info
        _infoPanel.ShowBuildingInfo(building);
        
        // Highlight selected building
        HighlightBuilding(building);
    }
    else
    {
        // Hide info panel
        _infoPanel.Hide();
        
        // Clear highlight
        ClearHighlights();
    }
}

private void RemoveBuilding(GridPosition position)
{
    var building = _gridNode.GetBuildingAt(position);
    
    if (building != null)
    {
        // Confirm removal
        ShowConfirmationDialog(
            $"Remove {building.Name}?",
            () => ConfirmRemoveBuilding(building)
        );
    }
}

private async void ConfirmRemoveBuilding(BuildingData building)
{
    var success = await _gridNode.RemoveBuildingAsync(building);
    
    if (success)
    {
        // Refund some resources
        RefundResources(building);
        
        ShowMessage($"{building.Name} removed");
        _infoPanel.Hide();
    }
    else
    {
        ShowMessage($"Failed to remove building");
    }
}
```

---

## 🎥 Camera Controller

### CameraController.cs

```csharp
using Godot;
using GridBuilding.Godot.Core;

public partial class CameraController : Camera2D
{
    private GridBuildingNode _gridNode;
    private Vector2 _dragStart;
    private bool _isDragging = false;
    private float _zoomSpeed = 0.1f;
    private float _minZoom = 0.5f;
    private float _maxZoom = 3.0f;
    
    public void Initialize(GridBuildingNode gridNode)
    {
        _gridNode = gridNode;
        
        // Center camera on grid
        var gridCenter = new Vector2(
            _gridNode.GridSize.X * _gridNode.TileSize.X / 2,
            _gridNode.GridSize.Y * _gridNode.TileSize.Y / 2
        );
        Position = gridCenter;
    }
    
    public override void _Input(InputEvent @event)
    {
        if (@event is InputEventMouseButton mouseButton)
        {
            HandleMouseClick(mouseButton);
        }
        else if (@event is InputEventMouseMotion mouseMotion)
        {
            HandleMouseMotion(mouseMotion);
        }
        else if (@event is InputEventKey keyEvent && keyEvent.Pressed)
        {
            HandleKeyPress(keyEvent);
        }
    }
    
    private void HandleMouseClick(InputEventMouseButton mouseButton)
    {
        if (mouseButton.ButtonIndex == MouseButton.Middle)
        {
            if (mouseButton.Pressed)
            {
                _isDragging = true;
                _dragStart = mouseButton.Position - Position;
            }
            else
            {
                _isDragging = false;
            }
        }
        else if (mouseButton.ButtonIndex == MouseButton.WheelUp)
        {
            ZoomIn();
        }
        else if (mouseButton.ButtonIndex == MouseButton.WheelDown)
        {
            ZoomOut();
        }
    }
    
    private void HandleMouseMotion(InputEventMouseMotion mouseMotion)
    {
        if (_isDragging)
        {
            Position = mouseMotion.Position - _dragStart;
        }
    }
    
    private void HandleKeyPress(InputEventKey keyEvent)
    {
        var moveSpeed = 100.0f;
        
        switch (keyEvent.Keycode)
        {
            case Key.W:
            case Key.Up:
                Position += new Vector2(0, -moveSpeed);
                break;
            case Key.S:
            case Key.Down:
                Position += new Vector2(0, moveSpeed);
                break;
            case Key.A:
            case Key.Left:
                Position += new Vector2(-moveSpeed, 0);
                break;
            case Key.D:
            case Key.Right:
                Position += new Vector2(moveSpeed, 0);
                break;
            case Key.Equal:
            case Key.Plus:
                ZoomIn();
                break;
            case Key.Minus:
                ZoomOut();
                break;
        }
    }
    
    private void ZoomIn()
    {
        var newZoom = Zoom.X + _zoomSpeed;
        if (newZoom <= _maxZoom)
        {
            Zoom = new Vector2(newZoom, newZoom);
        }
    }
    
    private void ZoomOut()
    {
        var newZoom = Zoom.X - _zoomSpeed;
        if (newZoom >= _minZoom)
        {
            Zoom = new Vector2(newZoom, newZoom);
        }
    }
}
```

---

## 🎨 Building UI

### BuildingMenu.cs

```csharp
using Godot;
using GridBuilding.Core.Services.Building;
using System.Collections.Generic;

public partial class BuildingMenu : Control
{
    [Signal] public delegate void BuildingSelectedEventHandler(BuildingData buildingTemplate);
    [Signal] public delegate void CancelPlacementEventHandler();
    
    private VBoxContainer _buildingList;
    private Button _cancelButton;
    
    public override void _Ready()
    {
        _buildingList = GetNode<VBoxContainer>("ScrollContainer/BuildingList");
        _cancelButton = GetNode<Button>("CancelButton");
        
        _cancelButton.Pressed += () => EmitSignal(SignalName.CancelPlacement);
    }
    
    public void LoadBuildingTemplates(IEnumerable<BuildingData> templates)
    {
        // Clear existing items
        foreach (Node child in _buildingList.GetChildren())
        {
            child.QueueFree();
        }
        
        // Add building templates
        foreach (var template in templates)
        {
            var button = CreateBuildingButton(template);
            _buildingList.AddChild(button);
        }
    }
    
    private Button CreateBuildingButton(BuildingData template)
    {
        var button = new Button();
        button.Text = $"{template.Name} (${template.Properties["Cost"]})";
        button.CustomMinimumSize = new Vector2(200, 40);
        
        button.Pressed += () => {
            EmitSignal(SignalName.BuildingSelected, template);
        };
        
        return button;
    }
}
```

### BuildingInfoPanel.cs

```csharp
using Godot;
using GridBuilding.Core.Services.Building;

public partial class BuildingInfoPanel : Control
{
    private Label _nameLabel;
    private Label _typeLabel;
    private Label _positionLabel;
    private Label _propertiesLabel;
    private Button _removeButton;
    
    private BuildingData _currentBuilding;
    
    public override void _Ready()
    {
        _nameLabel = GetNode<Label>("VBoxContainer/NameLabel");
        _typeLabel = GetNode<Label>("VBoxContainer/TypeLabel");
        _positionLabel = GetNode<Label>("VBoxContainer/PositionLabel");
        _propertiesLabel = GetNode<Label>("VBoxContainer/PropertiesLabel");
        _removeButton = GetNode<Button>("VBoxContainer/RemoveButton");
        
        _removeButton.Pressed += OnRemoveButtonPressed;
        
        Hide(); // Hidden by default
    }
    
    public void ShowBuildingInfo(BuildingData building)
    {
        _currentBuilding = building;
        
        _nameLabel.Text = $"Name: {building.Name}";
        _typeLabel.Text = $"Type: {building.BuildingType}";
        _positionLabel.Text = $"Position: {building.GridPosition}";
        
        // Format properties
        var propertiesText = "Properties:\n";
        foreach (var prop in building.Properties)
        {
            propertiesText += $"  {prop.Key}: {prop.Value}\n";
        }
        _propertiesLabel.Text = propertiesText;
        
        Show();
    }
    
    public void Hide()
    {
        Visible = false;
        _currentBuilding = null;
    }
    
    private void OnRemoveButtonPressed()
    {
        if (_currentBuilding != null)
        {
            // Signal to main scene to remove building
            GetParent<MainScene>().RemoveBuilding(_currentBuilding.GridPosition);
        }
    }
}
```

---

## 💾 Save/Load System

### SaveGameManager.cs

```csharp
using Godot;
using GridBuilding.Godot.Core;
using GridBuilding.Core.State;
using System.Text.Json;

public partial class SaveGameManager : Node
{
    private GridBuildingNode _gridNode;
    private const string SaveDirectory = "user://saves/";
    
    public override void _Ready()
    {
        _gridNode = GetNode<GridBuildingNode>("../World/GridManager");
        
        // Ensure save directory exists
        if (!DirAccess.DirExistsAbsolute(SaveDirectory))
        {
            DirAccess.Open("user://").MakeDir("saves");
        }
    }
    
    public async Task SaveGameAsync(string saveName)
    {
        try
        {
            var savePath = $"{SaveDirectory}{saveName}.json";
            
            // Get grid state
            var gridState = _gridNode.GetGridState();
            
            // Create save data
            var saveData = new SaveData
            {
                Version = "1.0",
                SaveTime = System.DateTime.Now,
                GridState = gridState,
                CameraPosition = GetNode<Camera2D>("../World/CameraController").Position,
                CameraZoom = GetNode<Camera2D>("../World/CameraController").Zoom
            };
            
            // Serialize to JSON
            var json = JsonSerializer.Serialize(saveData, new JsonSerializerOptions
            {
                WriteIndented = true
            });
            
            // Write to file
            using var file = FileAccess.Open(savePath, FileAccess.ModeFlags.Write);
            file.StoreString(json);
            file.Close();
            
            GD.Print($"Game saved to {savePath}");
            ShowMessage($"Game saved successfully!");
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"Failed to save game: {ex.Message}");
            ShowMessage("Failed to save game!");
        }
    }
    
    public async Task LoadGameAsync(string saveName)
    {
        try
        {
            var savePath = $"{SaveDirectory}{saveName}.json";
            
            // Check if save exists
            if (!FileAccess.FileExists(savePath))
            {
                GD.PrintErr($"Save file not found: {savePath}");
                ShowMessage("Save file not found!");
                return;
            }
            
            // Read save file
            using var file = FileAccess.Open(savePath, FileAccess.ModeFlags.Read);
            var json = file.GetAsText();
            file.Close();
            
            // Deserialize
            var saveData = JsonSerializer.Deserialize<SaveData>(json);
            
            // Load grid state
            await _gridNode.LoadGridState(saveData.GridState);
            
            // Restore camera
            var camera = GetNode<Camera2D>("../World/CameraController");
            camera.Position = saveData.CameraPosition;
            camera.Zoom = saveData.CameraZoom;
            
            GD.Print($"Game loaded from {savePath}");
            ShowMessage($"Game loaded successfully!");
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"Failed to load game: {ex.Message}");
            ShowMessage("Failed to load game!");
        }
    }
    
    public string[] GetSaveFiles()
    {
        var dir = DirAccess.Open(SaveDirectory);
        var files = new System.Collections.Generic.List<string>();
        
        if (dir != null)
        {
            dir.ListDirBegin();
            var fileName = dir.GetNext();
            
            while (!string.IsNullOrEmpty(fileName))
            {
                if (fileName.EndsWith(".json"))
                {
                    files.Add(fileName.Replace(".json", ""));
                }
                fileName = dir.GetNext();
            }
            
            dir.ListDirEnd();
        }
        
        return files.ToArray();
    }
}

public class SaveData
{
    public string Version { get; set; }
    public System.DateTime SaveTime { get; set; }
    public GridState GridState { get; set; }
    public Vector2 CameraPosition { get; set; }
    public Vector2 CameraZoom { get; set; }
}
```

---

## 🎯 Visual Effects

### BuildingVisuals.cs

```csharp
using Godot;
using GridBuilding.Core.Services.Building;

public partial class BuildingVisuals : Node2D
{
    private GridBuildingNode _gridNode;
    private Dictionary<string, PackedScene> _buildingScenes = new();
    private Dictionary<string, BuildingData> _visualBuildings = new();
    
    public override void _Ready()
    {
        _gridNode = GetParent<GridBuildingNode>();
        
        // Load building scenes
        LoadBuildingScenes();
        
        // Connect to grid events
        _gridNode.BuildingPlaced += OnBuildingPlaced;
        _gridNode.BuildingRemoved += OnBuildingRemoved;
        _gridNode.BuildingHovered += OnBuildingHovered;
    }
    
    private void LoadBuildingScenes()
    {
        _buildingScenes["House"] = GD.Load<PackedScene>("res://scenes/buildings/house.tscn");
        _buildingScenes["Factory"] = GD.Load<PackedScene>("res://scenes/buildings/factory.tscn");
        _buildingScenes["Road"] = GD.Load<PackedScene>("res://scenes/buildings/road.tscn");
    }
    
    private void OnBuildingPlaced(BuildingData building)
    {
        CreateBuildingVisual(building);
    }
    
    private void OnBuildingRemoved(BuildingData building)
    {
        RemoveBuildingVisual(building);
    }
    
    private void CreateBuildingVisual(BuildingData building)
    {
        // Get scene for building type
        if (!_buildingScenes.TryGetValue(building.BuildingType, out var scene))
        {
            // Create default visual
            CreateDefaultVisual(building);
            return;
        }
        
        // Instance the scene
        var instance = scene.Instantiate<Node2D>();
        AddChild(instance);
        
        // Position the building
        instance.Position = building.GridPosition.ToWorldPosition();
        
        // Store reference
        _visualBuildings[building.Id] = building;
        building.Properties["visual_node"] = instance;
    }
    
    private void CreateDefaultVisual(BuildingData building)
    {
        var sprite = new Sprite2D();
        
        // Create colored rectangle based on building type
        var texture = new ImageTexture();
        var image = Image.Create(building.Size.X * 64, building.Size.Y * 64, false, Image.Format.Rgb8);
        
        // Set color based on type
        Color color = building.BuildingType switch
        {
            "Residential" => Colors.Green,
            "Industrial" => Colors.Blue,
            "Infrastructure" => Colors.Gray,
            _ => Colors.White
        };
        
        image.Fill(color);
        texture.SetImage(image);
        sprite.Texture = texture;
        
        AddChild(sprite);
        sprite.Position = building.GridPosition.ToWorldPosition();
        
        // Store reference
        _visualBuildings[building.Id] = building;
        building.Properties["visual_node"] = sprite;
    }
    
    private void RemoveBuildingVisual(BuildingData building)
    {
        if (building.Properties.TryGetValue("visual_node", out var visualNode) && 
            visualNode is Node node)
        {
            node.QueueFree();
        }
        
        _visualBuildings.Remove(building.Id);
    }
    
    private void OnBuildingHovered(BuildingData building)
    {
        // Show hover effect
        if (building.Properties.TryGetValue("visual_node", out var visualNode) && 
            visualNode is Node2D node2D)
        {
            // Add highlight effect
            var tween = CreateTween();
            tween.TweenProperty(node2D, "modulate", Colors.Yellow, 0.2f);
        }
    }
}
```

---

## 🎮 Input Handling

### InputManager.cs

```csharp
using Godot;

public partial class InputManager : Node
{
    public override void _Ready()
    {
        // Define input actions
        DefineInputActions();
    }
    
    private void DefineInputActions()
    {
        var inputMap = InputMap;
        
        // Camera controls
        if (!inputMap.HasAction("camera_up"))
        {
            inputMap.AddAction("camera_up");
            inputMap.ActionAddEvent("camera_up", new InputEventKey { Keycode = Key.W });
            inputMap.ActionAddEvent("camera_up", new InputEventKey { Keycode = Key.Up });
        }
        
        if (!inputMap.HasAction("camera_down"))
        {
            inputMap.AddAction("camera_down");
            inputMap.ActionAddEvent("camera_down", new InputEventKey { Keycode = Key.S });
            inputMap.ActionAddEvent("camera_down", new InputEventKey { Keycode = Key.Down });
        }
        
        if (!inputMap.HasAction("camera_left"))
        {
            inputMap.AddAction("camera_left");
            inputMap.ActionAddEvent("camera_left", new InputEventKey { Keycode = Key.A });
            inputMap.ActionAddEvent("camera_left", new InputEventKey { Keycode = Key.Left });
        }
        
        if (!inputMap.HasAction("camera_right"))
        {
            inputMap.AddAction("camera_right");
            inputMap.ActionAddEvent("camera_right", new InputEventKey { Keycode = Key.D });
            inputMap.ActionAddEvent("camera_right", new InputEventKey { Keycode = Key.Right });
        }
        
        // Game controls
        if (!inputMap.HasAction("cancel_placement"))
        {
            inputMap.AddAction("cancel_placement");
            inputMap.ActionAddEvent("cancel_placement", new InputEventKey { Keycode = Key.Escape });
            inputMap.ActionAddEvent("cancel_placement", new InputEventMouseButton { ButtonIndex = MouseButton.Right });
        }
        
        if (!inputMap.HasAction("save_game"))
        {
            inputMap.AddAction("save_game");
            inputMap.ActionAddEvent("save_game", new InputEventKey { Keycode = Key.F5 });
        }
        
        if (!inputMap.HasAction("load_game"))
        {
            inputMap.AddAction("load_game");
            inputMap.ActionAddEvent("load_game", new InputEventKey { Keycode = Key.F9 });
        }
    }
}
```

---

## 🚀 Performance Optimization

### Object Pooling

```csharp
using Godot;
using System.Collections.Generic;

public partial class BuildingPool : Node
{
    private Queue<Node2D> _pool = new Queue<Node2D>();
    private PackedScene _buildingScene;
    private int _initialSize = 50;
    
    public override void _Ready()
    {
        _buildingScene = GD.Load<PackedScene>("res://scenes/buildings/default_building.tscn");
        
        // Pre-populate pool
        for (int i = 0; i < _initialSize; i++)
        {
            var building = _buildingScene.Instantiate<Node2D>();
            building.Visible = false;
            AddChild(building);
            _pool.Enqueue(building);
        }
    }
    
    public Node2D GetBuilding()
    {
        Node2D building;
        
        if (_pool.Count > 0)
        {
            building = _pool.Dequeue();
        }
        else
        {
            building = _buildingScene.Instantiate<Node2D>();
            AddChild(building);
        }
        
        building.Visible = true;
        return building;
    }
    
    public void ReturnBuilding(Node2D building)
    {
        building.Visible = false;
        _pool.Enqueue(building);
    }
}
```

### Grid Culling

```csharp
using Godot;
using GridBuilding.Core.Services.Building;

public partial class GridCulling : Node
{
    private Camera2D _camera;
    private Rect2 _visibleArea;
    private List<BuildingData> _visibleBuildings = new();
    
    public override void _Ready()
    {
        _camera = GetParent<Camera2D>();
    }
    
    public override void _Process(double delta)
    {
        UpdateVisibleArea();
        CullBuildings();
    }
    
    private void UpdateVisibleArea()
    {
        var screenSize = GetViewport().GetVisibleRect().Size;
        var cameraPos = _camera.GlobalPosition;
        
        _visibleArea = new Rect2(
            cameraPos - screenSize / 2,
            screenSize
        );
    }
    
    private void CullBuildings()
    {
        var gridNode = GetParent<GridBuildingNode>();
        var allBuildings = gridNode.GetAllBuildings();
        
        foreach (var building in allBuildings)
        {
            var buildingPos = building.GridPosition.ToWorldPosition();
            var buildingRect = new Rect2(
                buildingPos,
                building.Size * gridNode.TileSize
            );
            
            var isVisible = _visibleArea.Intersects(buildingRect);
            
            if (building.Properties.TryGetValue("visual_node", out var visualNode) && 
                visualNode is Node2D node2D)
            {
                node2D.Visible = isVisible;
            }
        }
    }
}
```

---

## 📊 Analytics and Debugging

### PerformanceMonitor.cs

```csharp
using Godot;
using System.Diagnostics;

public partial class PerformanceMonitor : Control
{
    private Label _fpsLabel;
    private Label _buildingCountLabel;
    private Label _memoryLabel;
    private GridBuildingNode _gridNode;
    
    public override void _Ready()
    {
        _gridNode = GetParent<GridBuildingNode>();
        
        _fpsLabel = GetNode<Label>("VBoxContainer/FPSLabel");
        _buildingCountLabel = GetNode<Label>("VBoxContainer/BuildingCountLabel");
        _memoryLabel = GetNode<Label>("VBoxContainer/MemoryLabel");
    }
    
    public override void _Process(double delta)
    {
        UpdateStats();
    }
    
    private void UpdateStats()
    {
        // FPS
        _fpsLabel.Text = $"FPS: {Engine.GetFramesPerSecond()}";
        
        // Building count
        var buildingCount = _gridNode.GetAllBuildings().Count();
        _buildingCountLabel.Text = $"Buildings: {buildingCount}";
        
        // Memory usage
        var memoryUsage = OS.GetStaticMemoryUsageByType()[OS.MemoryTypeType.Static];
        var memoryMB = memoryUsage / 1024 / 1024;
        _memoryLabel.Text = $"Memory: {memoryMB} MB";
    }
}
```

---

## 🎯 Complete Integration Checklist

- [ ] **Grid Setup**: GridBuildingNode configured with proper size and tile size
- [ ] **Camera Controls**: Pan, zoom, and boundary constraints
- [ ] **Building System**: Placement, selection, and removal
- [ ] **UI Integration**: Building menu and info panels
- [ ] **Save/Load**: Persistent game state
- [ ] **Visual System**: Building visuals and effects
- [ ] **Input Handling**: Keyboard and mouse controls
- [ ] **Performance**: Object pooling and culling
- [ ] **Debug Tools**: Performance monitoring and debugging

---

**Need more examples?** Check the [examples](../examples/) directory for additional scenarios and use cases.
