---
title: "LightIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/lightintegrationtests/"
---

# LightIntegrationTests

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class LightIntegrationTests
{
    // Members...
}
```

Integration tests for 2D lighting nodes (PointLight2D, DirectionalLight2D, LightOccluder2D)

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/LightIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Integration.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Setup

```csharp
[Setup]
    public void Setup()
    {
        _testRoot = new Node();
        TestScene.AddChild(_testRoot);
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        _testRoot?.QueueFree();
    }
```

**Returns:** `void`

### PointLight2D_CanBeCreated

```csharp
// ==================== PointLight2D Tests ====================

    [Test]
    public void PointLight2D_CanBeCreated()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.ShouldNotBeNull();
        GodotObject.IsInstanceValid(light).ShouldBeTrue();
    }
```

**Returns:** `void`

### PointLight2D_Enabled_CanBeToggled

```csharp
[Test]
    public void PointLight2D_Enabled_CanBeToggled()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.Enabled = false;
        light.Enabled.ShouldBeFalse();

        light.Enabled = true;
        light.Enabled.ShouldBeTrue();
    }
```

**Returns:** `void`

### PointLight2D_Color_CanBeSet

```csharp
[Test]
    public void PointLight2D_Color_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        var color = new Color(1, 0.5f, 0, 1);
        light.Color = color;

        light.Color.ShouldBe(color);
    }
```

**Returns:** `void`

### PointLight2D_Energy_CanBeSet

```csharp
[Test]
    public void PointLight2D_Energy_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.Energy = 2.0f;

        light.Energy.ShouldBe(2.0f);
    }
```

**Returns:** `void`

### PointLight2D_BlendMode_CanBeSet

```csharp
[Test]
    public void PointLight2D_BlendMode_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.BlendMode = Light2D.BlendModeEnum.Sub;

        light.BlendMode.ShouldBe(Light2D.BlendModeEnum.Sub);
    }
```

**Returns:** `void`

### PointLight2D_RangeZMin_CanBeSet

```csharp
[Test]
    public void PointLight2D_RangeZMin_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.RangeZMin = -100;

        light.RangeZMin.ShouldBe(-100);
    }
```

**Returns:** `void`

### PointLight2D_RangeZMax_CanBeSet

```csharp
[Test]
    public void PointLight2D_RangeZMax_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.RangeZMax = 100;

        light.RangeZMax.ShouldBe(100);
    }
```

**Returns:** `void`

### PointLight2D_RangeLayerMin_CanBeSet

```csharp
[Test]
    public void PointLight2D_RangeLayerMin_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.RangeLayerMin = 0;

        light.RangeLayerMin.ShouldBe(0);
    }
```

**Returns:** `void`

### PointLight2D_RangeLayerMax_CanBeSet

```csharp
[Test]
    public void PointLight2D_RangeLayerMax_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.RangeLayerMax = 512;

        light.RangeLayerMax.ShouldBe(512);
    }
```

**Returns:** `void`

### PointLight2D_RangeItemCullMask_CanBeSet

```csharp
[Test]
    public void PointLight2D_RangeItemCullMask_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.RangeItemCullMask = 0b0101;

        light.RangeItemCullMask.ShouldBe(0b0101);
    }
```

**Returns:** `void`

### PointLight2D_ShadowEnabled_CanBeToggled

```csharp
[Test]
    public void PointLight2D_ShadowEnabled_CanBeToggled()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.ShadowEnabled = true;
        light.ShadowEnabled.ShouldBeTrue();

        light.ShadowEnabled = false;
        light.ShadowEnabled.ShouldBeFalse();
    }
```

**Returns:** `void`

### PointLight2D_ShadowColor_CanBeSet

```csharp
[Test]
    public void PointLight2D_ShadowColor_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        var shadowColor = new Color(0, 0, 0, 0.5f);
        light.ShadowColor = shadowColor;

        light.ShadowColor.ShouldBe(shadowColor);
    }
```

**Returns:** `void`

### PointLight2D_TextureScale_CanBeSet

```csharp
[Test]
    public void PointLight2D_TextureScale_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        light.TextureScale = 2.0f;

        light.TextureScale.ShouldBe(2.0f);
    }
```

**Returns:** `void`

### PointLight2D_Offset_CanBeSet

```csharp
[Test]
    public void PointLight2D_Offset_CanBeSet()
    {
        var light = new PointLight2D();
        _testRoot.AddChild(light);

        var offset = new Vector2(10, 20);
        light.Offset = offset;

        light.Offset.ShouldBe(offset);
    }
```

**Returns:** `void`

### DirectionalLight2D_CanBeCreated

```csharp
// ==================== DirectionalLight2D Tests ====================

    [Test]
    public void DirectionalLight2D_CanBeCreated()
    {
        var light = new DirectionalLight2D();
        _testRoot.AddChild(light);

        light.ShouldNotBeNull();
        GodotObject.IsInstanceValid(light).ShouldBeTrue();
    }
```

**Returns:** `void`

### DirectionalLight2D_Enabled_CanBeToggled

```csharp
[Test]
    public void DirectionalLight2D_Enabled_CanBeToggled()
    {
        var light = new DirectionalLight2D();
        _testRoot.AddChild(light);

        light.Enabled = false;
        light.Enabled.ShouldBeFalse();

        light.Enabled = true;
        light.Enabled.ShouldBeTrue();
    }
```

**Returns:** `void`

### DirectionalLight2D_Color_CanBeSet

```csharp
[Test]
    public void DirectionalLight2D_Color_CanBeSet()
    {
        var light = new DirectionalLight2D();
        _testRoot.AddChild(light);

        var color = new Color(0.8f, 0.9f, 1.0f, 1);
        light.Color = color;

        light.Color.ShouldBe(color);
    }
```

**Returns:** `void`

### DirectionalLight2D_Energy_CanBeSet

```csharp
[Test]
    public void DirectionalLight2D_Energy_CanBeSet()
    {
        var light = new DirectionalLight2D();
        _testRoot.AddChild(light);

        light.Energy = 1.5f;

        light.Energy.ShouldBe(1.5f);
    }
```

**Returns:** `void`

### DirectionalLight2D_MaxDistance_CanBeSet

```csharp
[Test]
    public void DirectionalLight2D_MaxDistance_CanBeSet()
    {
        var light = new DirectionalLight2D();
        _testRoot.AddChild(light);

        light.MaxDistance = 500.0f;

        light.MaxDistance.ShouldBe(500.0f);
    }
```

**Returns:** `void`

### LightOccluder2D_CanBeCreated

```csharp
// ==================== LightOccluder2D Tests ====================

    [Test]
    public void LightOccluder2D_CanBeCreated()
    {
        var occluder = new LightOccluder2D();
        _testRoot.AddChild(occluder);

        occluder.ShouldNotBeNull();
        GodotObject.IsInstanceValid(occluder).ShouldBeTrue();
    }
```

**Returns:** `void`

### LightOccluder2D_Occluder_CanBeSet

```csharp
[Test]
    public void LightOccluder2D_Occluder_CanBeSet()
    {
        var occluder = new LightOccluder2D();
        _testRoot.AddChild(occluder);

        var polygon = new OccluderPolygon2D();
        occluder.Occluder = polygon;

        occluder.Occluder.ShouldBe(polygon);
    }
```

**Returns:** `void`

### LightOccluder2D_OccluderLightMask_CanBeSet

```csharp
[Test]
    public void LightOccluder2D_OccluderLightMask_CanBeSet()
    {
        var occluder = new LightOccluder2D();
        _testRoot.AddChild(occluder);

        occluder.OccluderLightMask = 0b1010;

        occluder.OccluderLightMask.ShouldBe(0b1010);
    }
```

**Returns:** `void`

### LightOccluder2D_SdfCollision_CanBeToggled

```csharp
[Test]
    public void LightOccluder2D_SdfCollision_CanBeToggled()
    {
        var occluder = new LightOccluder2D();
        _testRoot.AddChild(occluder);

        occluder.SdfCollision = true;
        occluder.SdfCollision.ShouldBeTrue();

        occluder.SdfCollision = false;
        occluder.SdfCollision.ShouldBeFalse();
    }
```

**Returns:** `void`

### OccluderPolygon2D_CanBeCreated

```csharp
// ==================== OccluderPolygon2D Tests ====================

    [Test]
    public void OccluderPolygon2D_CanBeCreated()
    {
        var polygon = new OccluderPolygon2D();

        polygon.ShouldNotBeNull();
    }
```

**Returns:** `void`

### OccluderPolygon2D_Polygon_CanBeSet

```csharp
[Test]
    public void OccluderPolygon2D_Polygon_CanBeSet()
    {
        var polygon = new OccluderPolygon2D();

        var points = new Vector2[]
        {
            new(0, 0),
            new(100, 0),
            new(100, 100),
            new(0, 100)
        };
        polygon.Polygon = points;

        polygon.Polygon.Length.ShouldBe(4);
    }
```

**Returns:** `void`

### OccluderPolygon2D_Closed_CanBeToggled

```csharp
[Test]
    public void OccluderPolygon2D_Closed_CanBeToggled()
    {
        var polygon = new OccluderPolygon2D();

        polygon.Closed = false;
        polygon.Closed.ShouldBeFalse();

        polygon.Closed = true;
        polygon.Closed.ShouldBeTrue();
    }
```

**Returns:** `void`

### OccluderPolygon2D_CullMode_CanBeSet

```csharp
[Test]
    public void OccluderPolygon2D_CullMode_CanBeSet()
    {
        var polygon = new OccluderPolygon2D();

        polygon.CullMode = OccluderPolygon2D.CullModeEnum.Clockwise;

        polygon.CullMode.ShouldBe(OccluderPolygon2D.CullModeEnum.Clockwise);
    }
```

**Returns:** `void`

### CanvasModulate_CanBeCreated

```csharp
// ==================== CanvasModulate Tests ====================

    [Test]
    public void CanvasModulate_CanBeCreated()
    {
        var modulate = new CanvasModulate();
        _testRoot.AddChild(modulate);

        modulate.ShouldNotBeNull();
        GodotObject.IsInstanceValid(modulate).ShouldBeTrue();
    }
```

**Returns:** `void`

### CanvasModulate_Color_CanBeSet

```csharp
[Test]
    public void CanvasModulate_Color_CanBeSet()
    {
        var modulate = new CanvasModulate();
        _testRoot.AddChild(modulate);

        var color = new Color(0.5f, 0.5f, 0.7f, 1);
        modulate.Color = color;

        modulate.Color.ShouldBe(color);
    }
```

**Returns:** `void`

