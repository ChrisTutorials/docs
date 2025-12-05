---
title: "GridOverlay"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridoverlay/"
---

# GridOverlay

```csharp
GridBuilding.Godot.UI
class GridOverlay
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/GridOverlay.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TargetTileMap

```csharp
[Export] public TileMapLayer TargetTileMap 
        { 
            get => _targetTileMap; 
            set => SetTargetTileMap(value);
        }
```

### GridSize

```csharp
[Export] public Vector2I GridSize 
        { 
            get => _gridSize; 
            set => SetGridSize(value);
        }
```

### TileSize

```csharp
[Export] public Vector2 TileSize 
        { 
            get => _tileSize; 
            set => SetTileSize(value);
        }
```

### ShowGridLines

```csharp
[ExportGroup("Display Settings")]
        [Export] public bool ShowGridLines 
        { 
            get => _showGridLines; 
            set => _showGridLines = value;
        }
```

### ShowTileNumbers

```csharp
[Export] public bool ShowTileNumbers 
        { 
            get => _showTileNumbers; 
            set => _showTileNumbers = value;
        }
```

### ShowCoordinates

```csharp
[Export] public bool ShowCoordinates 
        { 
            get => _showCoordinates; 
            set => _showCoordinates = value;
        }
```

### GridLineColor

```csharp
[ExportGroup("Colors")]
        [Export] public Color GridLineColor 
        { 
            get => _gridLineColor; 
            set => _gridLineColor = value;
        }
```

### HighlightColor

```csharp
[Export] public Color HighlightColor 
        { 
            get => _highlightColor; 
            set => _highlightColor = value;
        }
```

### HoverColor

```csharp
[Export] public Color HoverColor 
        { 
            get => _hoverColor; 
            set => _hoverColor = value;
        }
```

### GridLineWidth

```csharp
[Export] public float GridLineWidth 
        { 
            get => _gridLineWidth; 
            set => _gridLineWidth = value;
        }
```

### HoveredTile

```csharp
public Vector2I HoveredTile => _hoveredTile;
```

### SelectedTile

```csharp
public Vector2I SelectedTile => _selectedTile;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            _highlightedTiles = new Dictionary<Vector2I, Color>();
            
            // Set up mouse input
            MouseEntered += OnMouseEntered;
            MouseExited += OnMouseExited;
            
            // Try to find tile map if not set
            if (_targetTileMap == null)
            {
                _targetTileMap = GetTree().CurrentScene?.GetNode<TileMapLayer>("TileMap");
            }
        }
```

**Returns:** `void`

### _Draw

```csharp
public override void _Draw()
        {
            base._Draw();
            
            if (_targetTileMap == null)
                return;
                
            DrawGridLines();
            DrawHighlightedTiles();
            DrawHoveredTile();
            DrawSelectedTile();
            DrawTileInfo();
        }
```

**Returns:** `void`

### _GuiInput

```csharp
public override void _GuiInput(InputEvent @event)
        {
            base._GuiInput(@event);
            
            if (@event is InputEventMouseButton mouseButton && mouseButton.Pressed)
            {
                var tilePos = ScreenToTile(mouseButton.Position);
                if (IsValidTile(tilePos))
                {
                    _selectedTile = tilePos;
                    EmitSignal(SignalName.GridTileClicked, tilePos);
                    QueueRedraw();
                }
            }
            else if (@event is InputEventMouseMotion mouseMotion)
            {
                var tilePos = ScreenToTile(mouseMotion.Position);
                if (tilePos != _hoveredTile)
                {
                    _hoveredTile = tilePos;
                    if (IsValidTile(tilePos))
                    {
                        EmitSignal(SignalName.GridTileHovered, tilePos);
                    }
                    QueueRedraw();
                }
            }
        }
```

**Returns:** `void`

**Parameters:**
- `InputEvent event`

### SetTargetTileMap

```csharp
/// <summary>
        /// Sets the target tile map
        /// </summary>
        /// <param name="tileMap">Tile map to target</param>
        public void SetTargetTileMap(TileMapLayer tileMap)
        {
            _targetTileMap = tileMap;
            
            if (tileMap != null)
            {
                _tileSize = tileMap.TileSet.TileSize;
                QueueRedraw();
            }
        }
```

Sets the target tile map

**Returns:** `void`

**Parameters:**
- `TileMapLayer tileMap`

### SetGridSize

```csharp
/// <summary>
        /// Sets the grid size
        /// </summary>
        /// <param name="size">New grid size</param>
        public void SetGridSize(Vector2I size)
        {
            _gridSize = size;
            QueueRedraw();
        }
```

Sets the grid size

**Returns:** `void`

**Parameters:**
- `Vector2I size`

### SetTileSize

```csharp
/// <summary>
        /// Sets the tile size
        /// </summary>
        /// <param name="size">New tile size</param>
        public void SetTileSize(Vector2 size)
        {
            _tileSize = size;
            QueueRedraw();
        }
```

Sets the tile size

**Returns:** `void`

**Parameters:**
- `Vector2 size`

### HighlightTile

```csharp
/// <summary>
        /// Highlights a tile with a specific color
        /// </summary>
        /// <param name="tilePos">Tile position to highlight</param>
        /// <param name="color">Highlight color</param>
        public void HighlightTile(Vector2I tilePos, Color color)
        {
            if (IsValidTile(tilePos))
            {
                _highlightedTiles[tilePos] = color;
                QueueRedraw();
            }
        }
```

Highlights a tile with a specific color

**Returns:** `void`

**Parameters:**
- `Vector2I tilePos`
- `Color color`

### UnhighlightTile

```csharp
/// <summary>
        /// Removes tile highlight
        /// </summary>
        /// <param name="tilePos">Tile position to unhighlight</param>
        public void UnhighlightTile(Vector2I tilePos)
        {
            if (_highlightedTiles.ContainsKey(tilePos))
            {
                _highlightedTiles.Remove(tilePos);
                QueueRedraw();
            }
        }
```

Removes tile highlight

**Returns:** `void`

**Parameters:**
- `Vector2I tilePos`

### ClearHighlights

```csharp
/// <summary>
        /// Clears all tile highlights
        /// </summary>
        public void ClearHighlights()
        {
            _highlightedTiles.Clear();
            QueueRedraw();
        }
```

Clears all tile highlights

**Returns:** `void`

### HighlightTiles

```csharp
/// <summary>
        /// Highlights multiple tiles
        /// </summary>
        /// <param name="tilePositions">List of tile positions to highlight</param>
        /// <param name="color">Highlight color</param>
        public void HighlightTiles(List<Vector2I> tilePositions, Color color)
        {
            foreach (var tilePos in tilePositions)
            {
                if (IsValidTile(tilePos))
                {
                    _highlightedTiles[tilePos] = color;
                }
            }
            QueueRedraw();
        }
```

Highlights multiple tiles

**Returns:** `void`

**Parameters:**
- `List<Vector2I> tilePositions`
- `Color color`

### GetHighlightedTiles

```csharp
/// <summary>
        /// Gets all highlighted tiles
        /// </summary>
        /// <returns>Dictionary of highlighted tiles and their colors</returns>
        public Dictionary<Vector2I, Color> GetHighlightedTiles()
        {
            return new Dictionary<Vector2I, Color>(_highlightedTiles);
        }
```

Gets all highlighted tiles

**Returns:** `Dictionary<Vector2I, Color>`

### IsTileHighlighted

```csharp
/// <summary>
        /// Checks if a tile is highlighted
        /// </summary>
        /// <param name="tilePos">Tile position to check</param>
        /// <returns>True if highlighted</returns>
        public bool IsTileHighlighted(Vector2I tilePos)
        {
            return _highlightedTiles.ContainsKey(tilePos);
        }
```

Checks if a tile is highlighted

**Returns:** `bool`

**Parameters:**
- `Vector2I tilePos`

### GetTileHighlightColor

```csharp
/// <summary>
        /// Gets the highlight color for a tile
        /// </summary>
        /// <param name="tilePos">Tile position</param>
        /// <returns>Highlight color or default if not highlighted</returns>
        public Color GetTileHighlightColor(Vector2I tilePos)
        {
            return _highlightedTiles.TryGetValue(tilePos, out var color) ? color : Colors.White;
        }
```

Gets the highlight color for a tile

**Returns:** `Color`

**Parameters:**
- `Vector2I tilePos`

### SetSelectedTile

```csharp
/// <summary>
        /// Sets the selected tile
        /// </summary>
        /// <param name="tilePos">Tile position to select</param>
        public void SetSelectedTile(Vector2I tilePos)
        {
            if (IsValidTile(tilePos))
            {
                _selectedTile = tilePos;
                QueueRedraw();
            }
        }
```

Sets the selected tile

**Returns:** `void`

**Parameters:**
- `Vector2I tilePos`

### ClearSelectedTile

```csharp
/// <summary>
        /// Clears the selected tile
        /// </summary>
        public void ClearSelectedTile()
        {
            _selectedTile = new Vector2I(-1, -1);
            QueueRedraw();
        }
```

Clears the selected tile

**Returns:** `void`

