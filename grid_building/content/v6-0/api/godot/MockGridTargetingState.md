---
title: "MockGridTargetingState"
description: "Mock GridTargetingState for testing."
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockgridtargetingstate/"
---

# MockGridTargetingState

```csharp
GridBuilding.Godot.Tests.Placement
class MockGridTargetingState
{
    // Members...
}
```

Mock GridTargetingState for testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/IndicatorFactoryTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupMockTargetMap

```csharp
public void SetupMockTargetMap()
        {
            _targetMap = new TileMapLayer();
            _targetMap.TileSet = new TileSet();
            var tileSet = _targetMap.TileSet;
            
            // Add a source to the tileset
            var source = new TileSetAtlasSource();
            source.Texture = new Texture2D();
            source.TextureRegionSize = Vector2I.One * 16;
            tileSet.AddSource(source);
            
            tileSet.TileSize = Vector2I.One * 16;
        }
```

**Returns:** `void`

### GetTargetMap

```csharp
public TileMapLayer? GetTargetMap()
        {
            return _targetMap;
        }
```

**Returns:** `TileMapLayer?`

