---
title: "ControlIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/controlintegrationtests/"
---

# ControlIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class ControlIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for Control nodes and UI functionality.
Tests anchors, margins, containers, and focus behavior.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ControlIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up Control Integration Tests");
    }
```

**Returns:** `void`

### Control_CanBeCreated

```csharp
#region Control Creation Tests

    [Test]
    public void Control_CanBeCreated()
    {
        // Act
        var control = new Control();
        _testScene.AddChild(control);

        // Assert
        control.ShouldNotBeNull();

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_DefaultSize_IsZero

```csharp
[Test]
    public void Control_DefaultSize_IsZero()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Assert
        control.Size.ShouldBe(Vector2.Zero);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_AnchorLeft_CanBeSet

```csharp
#endregion

    #region Anchor Tests

    [Test]
    public void Control_AnchorLeft_CanBeSet()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.AnchorLeft = 0.5f;

        // Assert
        control.AnchorLeft.ShouldBe(0.5f);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_AnchorRight_CanBeSet

```csharp
[Test]
    public void Control_AnchorRight_CanBeSet()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.AnchorRight = 1.0f;

        // Assert
        control.AnchorRight.ShouldBe(1.0f);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_AnchorTop_CanBeSet

```csharp
[Test]
    public void Control_AnchorTop_CanBeSet()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.AnchorTop = 0.25f;

        // Assert
        control.AnchorTop.ShouldBe(0.25f);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_AnchorBottom_CanBeSet

```csharp
[Test]
    public void Control_AnchorBottom_CanBeSet()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.AnchorBottom = 0.75f;

        // Assert
        control.AnchorBottom.ShouldBe(0.75f);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_SetAnchorsPreset_FullRect

```csharp
[Test]
    public void Control_SetAnchorsPreset_FullRect()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.SetAnchorsPreset(Control.LayoutPreset.FullRect);

        // Assert
        control.AnchorLeft.ShouldBe(0.0f);
        control.AnchorTop.ShouldBe(0.0f);
        control.AnchorRight.ShouldBe(1.0f);
        control.AnchorBottom.ShouldBe(1.0f);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_SetAnchorsPreset_Center

```csharp
[Test]
    public void Control_SetAnchorsPreset_Center()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.SetAnchorsPreset(Control.LayoutPreset.Center);

        // Assert
        control.AnchorLeft.ShouldBe(0.5f);
        control.AnchorTop.ShouldBe(0.5f);
        control.AnchorRight.ShouldBe(0.5f);
        control.AnchorBottom.ShouldBe(0.5f);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_CustomMinimumSize_CanBeSet

```csharp
#endregion

    #region Size and Position Tests

    [Test]
    public void Control_CustomMinimumSize_CanBeSet()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.CustomMinimumSize = new Vector2(100, 50);

        // Assert
        control.CustomMinimumSize.ShouldBe(new Vector2(100, 50));

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_Position_CanBeSet

```csharp
[Test]
    public void Control_Position_CanBeSet()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.Position = new Vector2(50, 75);

        // Assert
        control.Position.ShouldBe(new Vector2(50, 75));

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_Size_CanBeSet

```csharp
[Test]
    public void Control_Size_CanBeSet()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.Size = new Vector2(200, 100);

        // Assert
        control.Size.ShouldBe(new Vector2(200, 100));

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_GlobalPosition_ReflectsTreePosition

```csharp
[Test]
    public void Control_GlobalPosition_ReflectsTreePosition()
    {
        // Arrange
        var parent = new Control();
        var child = new Control();
        _testScene.AddChild(parent);
        parent.AddChild(child);
        parent.Position = new Vector2(100, 100);
        child.Position = new Vector2(50, 50);

        // Assert
        child.GlobalPosition.ShouldBe(new Vector2(150, 150));

        // Cleanup
        parent.QueueFree();
    }
```

**Returns:** `void`

### Control_FocusMode_CanBeSet

```csharp
#endregion

    #region Focus Tests

    [Test]
    public void Control_FocusMode_CanBeSet()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.FocusMode = Control.FocusModeEnum.All;

        // Assert
        control.FocusMode.ShouldBe(Control.FocusModeEnum.All);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_HasFocus_ReturnsFalseByDefault

```csharp
[Test]
    public void Control_HasFocus_ReturnsFalseByDefault()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Assert
        control.HasFocus().ShouldBeFalse();

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_FocusNeighborLeft_CanBeSet

```csharp
[Test]
    public void Control_FocusNeighborLeft_CanBeSet()
    {
        // Arrange
        var control = new Control();
        var neighbor = new Control();
        _testScene.AddChild(control);
        _testScene.AddChild(neighbor);

        // Act
        control.FocusNeighborLeft = neighbor.GetPath();

        // Assert
        control.FocusNeighborLeft.ShouldNotBeNull();

        // Cleanup
        control.QueueFree();
        neighbor.QueueFree();
    }
```

**Returns:** `void`

### Control_MouseFilter_CanBeSetToStop

```csharp
#endregion

    #region Mouse Filter Tests

    [Test]
    public void Control_MouseFilter_CanBeSetToStop()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.MouseFilter = Control.MouseFilterEnum.Stop;

        // Assert
        control.MouseFilter.ShouldBe(Control.MouseFilterEnum.Stop);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_MouseFilter_CanBeSetToPass

```csharp
[Test]
    public void Control_MouseFilter_CanBeSetToPass()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.MouseFilter = Control.MouseFilterEnum.Pass;

        // Assert
        control.MouseFilter.ShouldBe(Control.MouseFilterEnum.Pass);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_MouseFilter_CanBeSetToIgnore

```csharp
[Test]
    public void Control_MouseFilter_CanBeSetToIgnore()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.MouseFilter = Control.MouseFilterEnum.Ignore;

        // Assert
        control.MouseFilter.ShouldBe(Control.MouseFilterEnum.Ignore);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### VBoxContainer_CanBeCreated

```csharp
#endregion

    #region Container Tests

    [Test]
    public void VBoxContainer_CanBeCreated()
    {
        // Act
        var container = new VBoxContainer();
        _testScene.AddChild(container);

        // Assert
        container.ShouldNotBeNull();

        // Cleanup
        container.QueueFree();
    }
```

**Returns:** `void`

### HBoxContainer_CanBeCreated

```csharp
[Test]
    public void HBoxContainer_CanBeCreated()
    {
        // Act
        var container = new HBoxContainer();
        _testScene.AddChild(container);

        // Assert
        container.ShouldNotBeNull();

        // Cleanup
        container.QueueFree();
    }
```

**Returns:** `void`

### GridContainer_Columns_CanBeSet

```csharp
[Test]
    public void GridContainer_Columns_CanBeSet()
    {
        // Arrange
        var container = new GridContainer();
        _testScene.AddChild(container);

        // Act
        container.Columns = 3;

        // Assert
        container.Columns.ShouldBe(3);

        // Cleanup
        container.QueueFree();
    }
```

**Returns:** `void`

### MarginContainer_CanBeCreated

```csharp
[Test]
    public void MarginContainer_CanBeCreated()
    {
        // Act
        var container = new MarginContainer();
        _testScene.AddChild(container);

        // Assert
        container.ShouldNotBeNull();

        // Cleanup
        container.QueueFree();
    }
```

**Returns:** `void`

### Control_SizeFlagsHorizontal_CanBeSetToExpand

```csharp
#endregion

    #region Size Flags Tests

    [Test]
    public void Control_SizeFlagsHorizontal_CanBeSetToExpand()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.SizeFlagsHorizontal = Control.SizeFlags.Expand;

        // Assert
        control.SizeFlagsHorizontal.ShouldBe(Control.SizeFlags.Expand);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_SizeFlagsVertical_CanBeSetToFill

```csharp
[Test]
    public void Control_SizeFlagsVertical_CanBeSetToFill()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.SizeFlagsVertical = Control.SizeFlags.Fill;

        // Assert
        control.SizeFlagsVertical.ShouldBe(Control.SizeFlags.Fill);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

### Control_SizeFlagsStretchRatio_CanBeSet

```csharp
[Test]
    public void Control_SizeFlagsStretchRatio_CanBeSet()
    {
        // Arrange
        var control = new Control();
        _testScene.AddChild(control);

        // Act
        control.SizeFlagsStretchRatio = 2.0f;

        // Assert
        control.SizeFlagsStretchRatio.ShouldBe(2.0f);

        // Cleanup
        control.QueueFree();
    }
```

**Returns:** `void`

