---
title: "ParticleIntegrationTests"
description: "Integration tests for particle system nodes (GPUParticles2D, CPUParticles2D)"
weight: 20
url: "/gridbuilding/v6-0/api/godot/particleintegrationtests/"
---

# ParticleIntegrationTests

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class ParticleIntegrationTests
{
    // Members...
}
```

Integration tests for particle system nodes (GPUParticles2D, CPUParticles2D)

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ParticleIntegrationTests.cs`  
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

### GPUParticles2D_CanBeCreated

```csharp
// ==================== GPUParticles2D Tests ====================

    [Test]
    public void GPUParticles2D_CanBeCreated()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.ShouldNotBeNull();
        GodotObject.IsInstanceValid(particles).ShouldBeTrue();
    }
```

**Returns:** `void`

### GPUParticles2D_Emitting_CanBeToggled

```csharp
[Test]
    public void GPUParticles2D_Emitting_CanBeToggled()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Emitting = true;
        particles.Emitting.ShouldBeTrue();

        particles.Emitting = false;
        particles.Emitting.ShouldBeFalse();
    }
```

**Returns:** `void`

### GPUParticles2D_Amount_CanBeSet

```csharp
[Test]
    public void GPUParticles2D_Amount_CanBeSet()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Amount = 100;

        particles.Amount.ShouldBe(100);
    }
```

**Returns:** `void`

### GPUParticles2D_Lifetime_CanBeSet

```csharp
[Test]
    public void GPUParticles2D_Lifetime_CanBeSet()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Lifetime = 2.5;

        particles.Lifetime.ShouldBe(2.5);
    }
```

**Returns:** `void`

### GPUParticles2D_OneShot_CanBeToggled

```csharp
[Test]
    public void GPUParticles2D_OneShot_CanBeToggled()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.OneShot = true;
        particles.OneShot.ShouldBeTrue();

        particles.OneShot = false;
        particles.OneShot.ShouldBeFalse();
    }
```

**Returns:** `void`

### GPUParticles2D_Preprocess_CanBeSet

```csharp
[Test]
    public void GPUParticles2D_Preprocess_CanBeSet()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Preprocess = 0.5;

        particles.Preprocess.ShouldBe(0.5);
    }
```

**Returns:** `void`

### GPUParticles2D_SpeedScale_CanBeSet

```csharp
[Test]
    public void GPUParticles2D_SpeedScale_CanBeSet()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.SpeedScale = 2.0;

        particles.SpeedScale.ShouldBe(2.0);
    }
```

**Returns:** `void`

### GPUParticles2D_Explosiveness_CanBeSet

```csharp
[Test]
    public void GPUParticles2D_Explosiveness_CanBeSet()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Explosiveness = 0.8f;

        particles.Explosiveness.ShouldBe(0.8f);
    }
```

**Returns:** `void`

### GPUParticles2D_Randomness_CanBeSet

```csharp
[Test]
    public void GPUParticles2D_Randomness_CanBeSet()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Randomness = 0.5f;

        particles.Randomness.ShouldBe(0.5f);
    }
```

**Returns:** `void`

### GPUParticles2D_FixedFps_CanBeSet

```csharp
[Test]
    public void GPUParticles2D_FixedFps_CanBeSet()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.FixedFps = 60;

        particles.FixedFps.ShouldBe(60);
    }
```

**Returns:** `void`

### GPUParticles2D_Interpolate_CanBeToggled

```csharp
[Test]
    public void GPUParticles2D_Interpolate_CanBeToggled()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Interpolate = false;
        particles.Interpolate.ShouldBeFalse();

        particles.Interpolate = true;
        particles.Interpolate.ShouldBeTrue();
    }
```

**Returns:** `void`

### GPUParticles2D_LocalCoords_CanBeToggled

```csharp
[Test]
    public void GPUParticles2D_LocalCoords_CanBeToggled()
    {
        var particles = new GpuParticles2D();
        _testRoot.AddChild(particles);

        particles.LocalCoords = true;
        particles.LocalCoords.ShouldBeTrue();

        particles.LocalCoords = false;
        particles.LocalCoords.ShouldBeFalse();
    }
```

**Returns:** `void`

### CPUParticles2D_CanBeCreated

```csharp
// ==================== CPUParticles2D Tests ====================

    [Test]
    public void CPUParticles2D_CanBeCreated()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.ShouldNotBeNull();
        GodotObject.IsInstanceValid(particles).ShouldBeTrue();
    }
```

**Returns:** `void`

### CPUParticles2D_Emitting_CanBeToggled

```csharp
[Test]
    public void CPUParticles2D_Emitting_CanBeToggled()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Emitting = true;
        particles.Emitting.ShouldBeTrue();

        particles.Emitting = false;
        particles.Emitting.ShouldBeFalse();
    }
```

**Returns:** `void`

### CPUParticles2D_Amount_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_Amount_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Amount = 50;

        particles.Amount.ShouldBe(50);
    }
```

**Returns:** `void`

### CPUParticles2D_Lifetime_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_Lifetime_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Lifetime = 3.0;

        particles.Lifetime.ShouldBe(3.0);
    }
```

**Returns:** `void`

### CPUParticles2D_OneShot_CanBeToggled

```csharp
[Test]
    public void CPUParticles2D_OneShot_CanBeToggled()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.OneShot = true;
        particles.OneShot.ShouldBeTrue();

        particles.OneShot = false;
        particles.OneShot.ShouldBeFalse();
    }
```

**Returns:** `void`

### CPUParticles2D_Direction_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_Direction_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        var direction = new Vector2(1, 0);
        particles.Direction = direction;

        particles.Direction.ShouldBe(direction);
    }
```

**Returns:** `void`

### CPUParticles2D_Spread_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_Spread_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Spread = 45.0f;

        particles.Spread.ShouldBe(45.0f);
    }
```

**Returns:** `void`

### CPUParticles2D_Gravity_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_Gravity_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        var gravity = new Vector2(0, 980);
        particles.Gravity = gravity;

        particles.Gravity.ShouldBe(gravity);
    }
```

**Returns:** `void`

### CPUParticles2D_InitialVelocityMin_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_InitialVelocityMin_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.InitialVelocityMin = 50.0f;

        particles.InitialVelocityMin.ShouldBe(50.0f);
    }
```

**Returns:** `void`

### CPUParticles2D_InitialVelocityMax_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_InitialVelocityMax_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.InitialVelocityMax = 100.0f;

        particles.InitialVelocityMax.ShouldBe(100.0f);
    }
```

**Returns:** `void`

### CPUParticles2D_EmissionShape_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_EmissionShape_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.EmissionShape = CpuParticles2D.EmissionShapeEnum.Sphere;

        particles.EmissionShape.ShouldBe(CpuParticles2D.EmissionShapeEnum.Sphere);
    }
```

**Returns:** `void`

### CPUParticles2D_EmissionSphereRadius_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_EmissionSphereRadius_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.EmissionShape = CpuParticles2D.EmissionShapeEnum.Sphere;
        particles.EmissionSphereRadius = 25.0f;

        particles.EmissionSphereRadius.ShouldBe(25.0f);
    }
```

**Returns:** `void`

### CPUParticles2D_EmissionRectExtents_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_EmissionRectExtents_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.EmissionShape = CpuParticles2D.EmissionShapeEnum.Rectangle;
        var extents = new Vector2(50, 25);
        particles.EmissionRectExtents = extents;

        particles.EmissionRectExtents.ShouldBe(extents);
    }
```

**Returns:** `void`

### CPUParticles2D_ScaleAmountMin_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_ScaleAmountMin_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.ScaleAmountMin = 0.5f;

        particles.ScaleAmountMin.ShouldBe(0.5f);
    }
```

**Returns:** `void`

### CPUParticles2D_ScaleAmountMax_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_ScaleAmountMax_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.ScaleAmountMax = 2.0f;

        particles.ScaleAmountMax.ShouldBe(2.0f);
    }
```

**Returns:** `void`

### CPUParticles2D_Color_CanBeSet

```csharp
[Test]
    public void CPUParticles2D_Color_CanBeSet()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        var color = new Color(1, 0, 0, 1);
        particles.Color = color;

        particles.Color.ShouldBe(color);
    }
```

**Returns:** `void`

### CPUParticles2D_Restart_ResetsParticles

```csharp
[Test]
    public void CPUParticles2D_Restart_ResetsParticles()
    {
        var particles = new CpuParticles2D();
        _testRoot.AddChild(particles);

        particles.Emitting = true;
        particles.Restart();

        // After restart, emitting should still be true
        particles.Emitting.ShouldBeTrue();
    }
```

**Returns:** `void`

