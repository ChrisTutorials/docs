---
title: "ShaderIntegrationTests"
description: "Integration tests for shader and material nodes"
weight: 20
url: "/gridbuilding/v6-0/api/godot/shaderintegrationtests/"
---

# ShaderIntegrationTests

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class ShaderIntegrationTests
{
    // Members...
}
```

Integration tests for shader and material nodes

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ShaderIntegrationTests.cs`  
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

### ShaderMaterial_CanBeCreated

```csharp
// ==================== ShaderMaterial Tests ====================

    [Test]
    public void ShaderMaterial_CanBeCreated()
    {
        var material = new ShaderMaterial();

        material.ShouldNotBeNull();
    }
```

**Returns:** `void`

### ShaderMaterial_Shader_CanBeSet

```csharp
[Test]
    public void ShaderMaterial_Shader_CanBeSet()
    {
        var material = new ShaderMaterial();
        var shader = new Shader();

        material.Shader = shader;

        material.Shader.ShouldBe(shader);
    }
```

**Returns:** `void`

### ShaderMaterial_SetShaderParameter_SetsValue

```csharp
[Test]
    public void ShaderMaterial_SetShaderParameter_SetsValue()
    {
        var material = new ShaderMaterial();

        material.SetShaderParameter("test_param", 42);
        var value = material.GetShaderParameter("test_param");

        value.AsInt32().ShouldBe(42);
    }
```

**Returns:** `void`

### ShaderMaterial_SetShaderParameter_Vector2

```csharp
[Test]
    public void ShaderMaterial_SetShaderParameter_Vector2()
    {
        var material = new ShaderMaterial();

        var vec = new Vector2(1.5f, 2.5f);
        material.SetShaderParameter("position", vec);
        var value = material.GetShaderParameter("position");

        value.AsVector2().ShouldBe(vec);
    }
```

**Returns:** `void`

### ShaderMaterial_SetShaderParameter_Color

```csharp
[Test]
    public void ShaderMaterial_SetShaderParameter_Color()
    {
        var material = new ShaderMaterial();

        var color = new Color(1, 0, 0, 1);
        material.SetShaderParameter("tint", color);
        var value = material.GetShaderParameter("tint");

        value.AsColor().ShouldBe(color);
    }
```

**Returns:** `void`

### ShaderMaterial_SetShaderParameter_Float

```csharp
[Test]
    public void ShaderMaterial_SetShaderParameter_Float()
    {
        var material = new ShaderMaterial();

        material.SetShaderParameter("intensity", 0.75f);
        var value = material.GetShaderParameter("intensity");

        ((float)value.AsDouble()).ShouldBe(0.75f);
    }
```

**Returns:** `void`

### CanvasItemMaterial_CanBeCreated

```csharp
// ==================== CanvasItemMaterial Tests ====================

    [Test]
    public void CanvasItemMaterial_CanBeCreated()
    {
        var material = new CanvasItemMaterial();

        material.ShouldNotBeNull();
    }
```

**Returns:** `void`

### CanvasItemMaterial_BlendMode_CanBeSet

```csharp
[Test]
    public void CanvasItemMaterial_BlendMode_CanBeSet()
    {
        var material = new CanvasItemMaterial();

        material.BlendMode = CanvasItemMaterial.BlendModeEnum.Add;

        material.BlendMode.ShouldBe(CanvasItemMaterial.BlendModeEnum.Add);
    }
```

**Returns:** `void`

### CanvasItemMaterial_LightMode_CanBeSet

```csharp
[Test]
    public void CanvasItemMaterial_LightMode_CanBeSet()
    {
        var material = new CanvasItemMaterial();

        material.LightMode = CanvasItemMaterial.LightModeEnum.Unshaded;

        material.LightMode.ShouldBe(CanvasItemMaterial.LightModeEnum.Unshaded);
    }
```

**Returns:** `void`

### CanvasItemMaterial_ParticlesAnimation_CanBeToggled

```csharp
[Test]
    public void CanvasItemMaterial_ParticlesAnimation_CanBeToggled()
    {
        var material = new CanvasItemMaterial();

        material.ParticlesAnimation = true;
        material.ParticlesAnimation.ShouldBeTrue();

        material.ParticlesAnimation = false;
        material.ParticlesAnimation.ShouldBeFalse();
    }
```

**Returns:** `void`

### CanvasItemMaterial_ParticlesAnimHFrames_CanBeSet

```csharp
[Test]
    public void CanvasItemMaterial_ParticlesAnimHFrames_CanBeSet()
    {
        var material = new CanvasItemMaterial();

        material.ParticlesAnimHFrames = 8;

        material.ParticlesAnimHFrames.ShouldBe(8);
    }
```

**Returns:** `void`

### CanvasItemMaterial_ParticlesAnimVFrames_CanBeSet

```csharp
[Test]
    public void CanvasItemMaterial_ParticlesAnimVFrames_CanBeSet()
    {
        var material = new CanvasItemMaterial();

        material.ParticlesAnimVFrames = 4;

        material.ParticlesAnimVFrames.ShouldBe(4);
    }
```

**Returns:** `void`

### CanvasItemMaterial_ParticlesAnimLoop_CanBeToggled

```csharp
[Test]
    public void CanvasItemMaterial_ParticlesAnimLoop_CanBeToggled()
    {
        var material = new CanvasItemMaterial();

        material.ParticlesAnimLoop = true;
        material.ParticlesAnimLoop.ShouldBeTrue();

        material.ParticlesAnimLoop = false;
        material.ParticlesAnimLoop.ShouldBeFalse();
    }
```

**Returns:** `void`

### Shader_CanBeCreated

```csharp
// ==================== Shader Tests ====================

    [Test]
    public void Shader_CanBeCreated()
    {
        var shader = new Shader();

        shader.ShouldNotBeNull();
    }
```

**Returns:** `void`

### Shader_Code_CanBeSet

```csharp
[Test]
    public void Shader_Code_CanBeSet()
    {
        var shader = new Shader();

        var code = "shader_type canvas_item;\nvoid fragment() { COLOR = vec4(1.0); }";
        shader.Code = code;

        shader.Code.ShouldBe(code);
    }
```

**Returns:** `void`

### Gradient_CanBeCreated

```csharp
// ==================== Gradient Tests ====================

    [Test]
    public void Gradient_CanBeCreated()
    {
        var gradient = new Gradient();

        gradient.ShouldNotBeNull();
    }
```

**Returns:** `void`

### Gradient_AddPoint_AddsColorStop

```csharp
[Test]
    public void Gradient_AddPoint_AddsColorStop()
    {
        var gradient = new Gradient();

        gradient.AddPoint(0.5f, new Color(1, 0, 0, 1));

        gradient.GetPointCount().ShouldBeGreaterThan(0);
    }
```

**Returns:** `void`

### Gradient_GetColor_ReturnsColor

```csharp
[Test]
    public void Gradient_GetColor_ReturnsColor()
    {
        var gradient = new Gradient();
        gradient.SetColor(0, new Color(1, 0, 0, 1));

        var color = gradient.GetColor(0);

        color.R.ShouldBe(1.0f);
    }
```

**Returns:** `void`

### Gradient_SetOffset_SetsPosition

```csharp
[Test]
    public void Gradient_SetOffset_SetsPosition()
    {
        var gradient = new Gradient();

        gradient.SetOffset(0, 0.25f);

        gradient.GetOffset(0).ShouldBe(0.25f);
    }
```

**Returns:** `void`

### Gradient_Sample_InterpolatesColor

```csharp
[Test]
    public void Gradient_Sample_InterpolatesColor()
    {
        var gradient = new Gradient();
        gradient.SetColor(0, new Color(0, 0, 0, 1));
        gradient.SetColor(1, new Color(1, 1, 1, 1));

        var midColor = gradient.Sample(0.5f);

        // Should be roughly gray
        midColor.R.ShouldBeInRange(0.4f, 0.6f);
    }
```

**Returns:** `void`

### Gradient_InterpolationMode_CanBeSet

```csharp
[Test]
    public void Gradient_InterpolationMode_CanBeSet()
    {
        var gradient = new Gradient();

        gradient.InterpolationMode = Gradient.InterpolationModeEnum.Cubic;

        gradient.InterpolationMode.ShouldBe(Gradient.InterpolationModeEnum.Cubic);
    }
```

**Returns:** `void`

### GradientTexture2D_CanBeCreated

```csharp
// ==================== GradientTexture2D Tests ====================

    [Test]
    public void GradientTexture2D_CanBeCreated()
    {
        var texture = new GradientTexture2D();

        texture.ShouldNotBeNull();
    }
```

**Returns:** `void`

### GradientTexture2D_Gradient_CanBeSet

```csharp
[Test]
    public void GradientTexture2D_Gradient_CanBeSet()
    {
        var texture = new GradientTexture2D();
        var gradient = new Gradient();

        texture.Gradient = gradient;

        texture.Gradient.ShouldBe(gradient);
    }
```

**Returns:** `void`

### GradientTexture2D_Width_CanBeSet

```csharp
[Test]
    public void GradientTexture2D_Width_CanBeSet()
    {
        var texture = new GradientTexture2D();

        texture.Width = 256;

        texture.Width.ShouldBe(256);
    }
```

**Returns:** `void`

### GradientTexture2D_Height_CanBeSet

```csharp
[Test]
    public void GradientTexture2D_Height_CanBeSet()
    {
        var texture = new GradientTexture2D();

        texture.Height = 128;

        texture.Height.ShouldBe(128);
    }
```

**Returns:** `void`

### GradientTexture2D_Fill_CanBeSet

```csharp
[Test]
    public void GradientTexture2D_Fill_CanBeSet()
    {
        var texture = new GradientTexture2D();

        texture.Fill = GradientTexture2D.FillEnum.Radial;

        texture.Fill.ShouldBe(GradientTexture2D.FillEnum.Radial);
    }
```

**Returns:** `void`

### GradientTexture2D_FillFrom_CanBeSet

```csharp
[Test]
    public void GradientTexture2D_FillFrom_CanBeSet()
    {
        var texture = new GradientTexture2D();

        var from = new Vector2(0.5f, 0.5f);
        texture.FillFrom = from;

        texture.FillFrom.ShouldBe(from);
    }
```

**Returns:** `void`

### GradientTexture2D_FillTo_CanBeSet

```csharp
[Test]
    public void GradientTexture2D_FillTo_CanBeSet()
    {
        var texture = new GradientTexture2D();

        var to = new Vector2(1.0f, 1.0f);
        texture.FillTo = to;

        texture.FillTo.ShouldBe(to);
    }
```

**Returns:** `void`

### GradientTexture2D_Repeat_CanBeSet

```csharp
[Test]
    public void GradientTexture2D_Repeat_CanBeSet()
    {
        var texture = new GradientTexture2D();

        texture.Repeat = GradientTexture2D.RepeatEnum.Repeat;

        texture.Repeat.ShouldBe(GradientTexture2D.RepeatEnum.Repeat);
    }
```

**Returns:** `void`

