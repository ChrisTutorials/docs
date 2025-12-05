---
title: "ViewportIntegrationTests"
description: "Integration tests for Viewport and SubViewport nodes"
weight: 20
url: "/gridbuilding/v6-0/api/godot/viewportintegrationtests/"
---

# ViewportIntegrationTests

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class ViewportIntegrationTests
{
    // Members...
}
```

Integration tests for Viewport and SubViewport nodes

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ViewportIntegrationTests.cs`  
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

### SubViewport_CanBeCreated

```csharp
// ==================== SubViewport Tests ====================

    [Test]
    public void SubViewport_CanBeCreated()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.ShouldNotBeNull();
        GodotObject.IsInstanceValid(viewport).ShouldBeTrue();
    }
```

**Returns:** `void`

### SubViewport_Size_CanBeSet

```csharp
[Test]
    public void SubViewport_Size_CanBeSet()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        var size = new Vector2I(800, 600);
        viewport.Size = size;

        viewport.Size.ShouldBe(size);
    }
```

**Returns:** `void`

### SubViewport_RenderTargetUpdateMode_CanBeSet

```csharp
[Test]
    public void SubViewport_RenderTargetUpdateMode_CanBeSet()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.RenderTargetUpdateMode = SubViewport.UpdateMode.Always;

        viewport.RenderTargetUpdateMode.ShouldBe(SubViewport.UpdateMode.Always);
    }
```

**Returns:** `void`

### SubViewport_RenderTargetClearMode_CanBeSet

```csharp
[Test]
    public void SubViewport_RenderTargetClearMode_CanBeSet()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.RenderTargetClearMode = SubViewport.ClearMode.Never;

        viewport.RenderTargetClearMode.ShouldBe(SubViewport.ClearMode.Never);
    }
```

**Returns:** `void`

### SubViewport_TransparentBg_CanBeToggled

```csharp
[Test]
    public void SubViewport_TransparentBg_CanBeToggled()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.TransparentBg = true;
        viewport.TransparentBg.ShouldBeTrue();

        viewport.TransparentBg = false;
        viewport.TransparentBg.ShouldBeFalse();
    }
```

**Returns:** `void`

### SubViewport_HandleInputLocally_CanBeToggled

```csharp
[Test]
    public void SubViewport_HandleInputLocally_CanBeToggled()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.HandleInputLocally = false;
        viewport.HandleInputLocally.ShouldBeFalse();

        viewport.HandleInputLocally = true;
        viewport.HandleInputLocally.ShouldBeTrue();
    }
```

**Returns:** `void`

### SubViewport_Msaa2D_CanBeSet

```csharp
[Test]
    public void SubViewport_Msaa2D_CanBeSet()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.Msaa2D = Viewport.Msaa.Msaa2X;

        viewport.Msaa2D.ShouldBe(Viewport.Msaa.Msaa2X);
    }
```

**Returns:** `void`

### SubViewport_CanvasItemDefaultTextureFilter_CanBeSet

```csharp
[Test]
    public void SubViewport_CanvasItemDefaultTextureFilter_CanBeSet()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.CanvasItemDefaultTextureFilter = Viewport.DefaultCanvasItemTextureFilter.Nearest;

        viewport.CanvasItemDefaultTextureFilter.ShouldBe(Viewport.DefaultCanvasItemTextureFilter.Nearest);
    }
```

**Returns:** `void`

### SubViewport_CanvasItemDefaultTextureRepeat_CanBeSet

```csharp
[Test]
    public void SubViewport_CanvasItemDefaultTextureRepeat_CanBeSet()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.CanvasItemDefaultTextureRepeat = Viewport.DefaultCanvasItemTextureRepeat.Enabled;

        viewport.CanvasItemDefaultTextureRepeat.ShouldBe(Viewport.DefaultCanvasItemTextureRepeat.Enabled);
    }
```

**Returns:** `void`

### SubViewport_Snap2DTransformsToPixel_CanBeToggled

```csharp
[Test]
    public void SubViewport_Snap2DTransformsToPixel_CanBeToggled()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.Snap2DTransformsToPixel = true;
        viewport.Snap2DTransformsToPixel.ShouldBeTrue();

        viewport.Snap2DTransformsToPixel = false;
        viewport.Snap2DTransformsToPixel.ShouldBeFalse();
    }
```

**Returns:** `void`

### SubViewport_GuiDisableInput_CanBeToggled

```csharp
[Test]
    public void SubViewport_GuiDisableInput_CanBeToggled()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.GuiDisableInput = true;
        viewport.GuiDisableInput.ShouldBeTrue();

        viewport.GuiDisableInput = false;
        viewport.GuiDisableInput.ShouldBeFalse();
    }
```

**Returns:** `void`

### SubViewport_GuiSnapControlsToPixels_CanBeToggled

```csharp
[Test]
    public void SubViewport_GuiSnapControlsToPixels_CanBeToggled()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.GuiSnapControlsToPixels = true;
        viewport.GuiSnapControlsToPixels.ShouldBeTrue();

        viewport.GuiSnapControlsToPixels = false;
        viewport.GuiSnapControlsToPixels.ShouldBeFalse();
    }
```

**Returns:** `void`

### SubViewport_SdfScale_CanBeSet

```csharp
[Test]
    public void SubViewport_SdfScale_CanBeSet()
    {
        var viewport = new SubViewport();
        _testRoot.AddChild(viewport);

        viewport.SdfScale = Viewport.SdfScaleEnum.Scale50Percent;

        viewport.SdfScale.ShouldBe(Viewport.SdfScaleEnum.Scale50Percent);
    }
```

**Returns:** `void`

### SubViewport_GetTexture_ReturnsTexture

```csharp
[Test]
    public void SubViewport_GetTexture_ReturnsTexture()
    {
        var viewport = new SubViewport();
        viewport.Size = new Vector2I(64, 64);
        _testRoot.AddChild(viewport);

        var texture = viewport.GetTexture();

        texture.ShouldNotBeNull();
    }
```

**Returns:** `void`

### SubViewportContainer_CanBeCreated

```csharp
// ==================== SubViewportContainer Tests ====================

    [Test]
    public void SubViewportContainer_CanBeCreated()
    {
        var container = new SubViewportContainer();
        _testRoot.AddChild(container);

        container.ShouldNotBeNull();
        GodotObject.IsInstanceValid(container).ShouldBeTrue();
    }
```

**Returns:** `void`

### SubViewportContainer_Stretch_CanBeToggled

```csharp
[Test]
    public void SubViewportContainer_Stretch_CanBeToggled()
    {
        var container = new SubViewportContainer();
        _testRoot.AddChild(container);

        container.Stretch = true;
        container.Stretch.ShouldBeTrue();

        container.Stretch = false;
        container.Stretch.ShouldBeFalse();
    }
```

**Returns:** `void`

### SubViewportContainer_StretchShrink_CanBeSet

```csharp
[Test]
    public void SubViewportContainer_StretchShrink_CanBeSet()
    {
        var container = new SubViewportContainer();
        _testRoot.AddChild(container);

        container.StretchShrink = 2;

        container.StretchShrink.ShouldBe(2);
    }
```

**Returns:** `void`

### SubViewportContainer_CanContainSubViewport

```csharp
[Test]
    public void SubViewportContainer_CanContainSubViewport()
    {
        var container = new SubViewportContainer();
        var viewport = new SubViewport();
        viewport.Size = new Vector2I(100, 100);
        container.AddChild(viewport);
        _testRoot.AddChild(container);

        container.GetChildCount().ShouldBe(1);
        container.GetChild(0).ShouldBe(viewport);
    }
```

**Returns:** `void`

### ViewportTexture_FromSubViewport_HasCorrectSize

```csharp
// ==================== ViewportTexture Tests ====================

    [Test]
    public void ViewportTexture_FromSubViewport_HasCorrectSize()
    {
        var viewport = new SubViewport();
        viewport.Size = new Vector2I(256, 256);
        _testRoot.AddChild(viewport);

        var texture = viewport.GetTexture();

        texture.GetWidth().ShouldBe(256);
        texture.GetHeight().ShouldBe(256);
    }
```

**Returns:** `void`

### CanvasLayer_CanBeCreated

```csharp
// ==================== CanvasLayer Tests ====================

    [Test]
    public void CanvasLayer_CanBeCreated()
    {
        var layer = new CanvasLayer();
        _testRoot.AddChild(layer);

        layer.ShouldNotBeNull();
        GodotObject.IsInstanceValid(layer).ShouldBeTrue();
    }
```

**Returns:** `void`

### CanvasLayer_Layer_CanBeSet

```csharp
[Test]
    public void CanvasLayer_Layer_CanBeSet()
    {
        var layer = new CanvasLayer();
        _testRoot.AddChild(layer);

        layer.Layer = 10;

        layer.Layer.ShouldBe(10);
    }
```

**Returns:** `void`

### CanvasLayer_Offset_CanBeSet

```csharp
[Test]
    public void CanvasLayer_Offset_CanBeSet()
    {
        var layer = new CanvasLayer();
        _testRoot.AddChild(layer);

        var offset = new Vector2(100, 50);
        layer.Offset = offset;

        layer.Offset.ShouldBe(offset);
    }
```

**Returns:** `void`

### CanvasLayer_Rotation_CanBeSet

```csharp
[Test]
    public void CanvasLayer_Rotation_CanBeSet()
    {
        var layer = new CanvasLayer();
        _testRoot.AddChild(layer);

        layer.Rotation = Mathf.Pi / 4;

        layer.Rotation.ShouldBe(Mathf.Pi / 4, 0.001f);
    }
```

**Returns:** `void`

### CanvasLayer_Scale_CanBeSet

```csharp
[Test]
    public void CanvasLayer_Scale_CanBeSet()
    {
        var layer = new CanvasLayer();
        _testRoot.AddChild(layer);

        var scale = new Vector2(2, 2);
        layer.Scale = scale;

        layer.Scale.ShouldBe(scale);
    }
```

**Returns:** `void`

### CanvasLayer_FollowViewportEnabled_CanBeToggled

```csharp
[Test]
    public void CanvasLayer_FollowViewportEnabled_CanBeToggled()
    {
        var layer = new CanvasLayer();
        _testRoot.AddChild(layer);

        layer.FollowViewportEnabled = true;
        layer.FollowViewportEnabled.ShouldBeTrue();

        layer.FollowViewportEnabled = false;
        layer.FollowViewportEnabled.ShouldBeFalse();
    }
```

**Returns:** `void`

### CanvasLayer_FollowViewportScale_CanBeSet

```csharp
[Test]
    public void CanvasLayer_FollowViewportScale_CanBeSet()
    {
        var layer = new CanvasLayer();
        _testRoot.AddChild(layer);

        layer.FollowViewportScale = 0.5f;

        layer.FollowViewportScale.ShouldBe(0.5f);
    }
```

**Returns:** `void`

### CanvasLayer_Visible_CanBeToggled

```csharp
[Test]
    public void CanvasLayer_Visible_CanBeToggled()
    {
        var layer = new CanvasLayer();
        _testRoot.AddChild(layer);

        layer.Visible = false;
        layer.Visible.ShouldBeFalse();

        layer.Visible = true;
        layer.Visible.ShouldBeTrue();
    }
```

**Returns:** `void`

### CanvasLayer_GetCanvas_ReturnsRid

```csharp
[Test]
    public void CanvasLayer_GetCanvas_ReturnsRid()
    {
        var layer = new CanvasLayer();
        _testRoot.AddChild(layer);

        var canvas = layer.GetCanvas();

        canvas.IsValid.ShouldBeTrue();
    }
```

**Returns:** `void`

