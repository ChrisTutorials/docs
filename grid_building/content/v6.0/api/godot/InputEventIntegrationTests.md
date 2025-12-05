---
title: "InputEventIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/inputeventintegrationtests/"
---

# InputEventIntegrationTests

```csharp
GridBuilding.Godot.Tests.GoDotTest
class InputEventIntegrationTests
{
    // Members...
}
```

GoDotTest integration tests for input event handling.
Tests InputEvent types and their properties.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/InputEventIntegrationTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.GoDotTest`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### SetupAll

```csharp
[SetupAll]
    public void SetupAll()
    {
        GD.Print("Setting up InputEvent Integration Tests");
    }
```

**Returns:** `void`

### InputEventMouseButton_LeftClick_HasCorrectIndex

```csharp
#region InputEventMouseButton Tests

    [Test]
    public void InputEventMouseButton_LeftClick_HasCorrectIndex()
    {
        // Arrange
        var mouseEvent = new InputEventMouseButton();
        mouseEvent.ButtonIndex = MouseButton.Left;

        // Assert
        mouseEvent.ButtonIndex.ShouldBe(MouseButton.Left);
    }
```

**Returns:** `void`

### InputEventMouseButton_RightClick_HasCorrectIndex

```csharp
[Test]
    public void InputEventMouseButton_RightClick_HasCorrectIndex()
    {
        // Arrange
        var mouseEvent = new InputEventMouseButton();
        mouseEvent.ButtonIndex = MouseButton.Right;

        // Assert
        mouseEvent.ButtonIndex.ShouldBe(MouseButton.Right);
    }
```

**Returns:** `void`

### InputEventMouseButton_Pressed_CanBeSet

```csharp
[Test]
    public void InputEventMouseButton_Pressed_CanBeSet()
    {
        // Arrange
        var mouseEvent = new InputEventMouseButton();

        // Act
        mouseEvent.Pressed = true;

        // Assert
        mouseEvent.Pressed.ShouldBeTrue();
    }
```

**Returns:** `void`

### InputEventMouseButton_DoubleClick_CanBeSet

```csharp
[Test]
    public void InputEventMouseButton_DoubleClick_CanBeSet()
    {
        // Arrange
        var mouseEvent = new InputEventMouseButton();

        // Act
        mouseEvent.DoubleClick = true;

        // Assert
        mouseEvent.DoubleClick.ShouldBeTrue();
    }
```

**Returns:** `void`

### InputEventMouseButton_Position_CanBeSet

```csharp
[Test]
    public void InputEventMouseButton_Position_CanBeSet()
    {
        // Arrange
        var mouseEvent = new InputEventMouseButton();

        // Act
        mouseEvent.Position = new Vector2(100, 200);

        // Assert
        mouseEvent.Position.ShouldBe(new Vector2(100, 200));
    }
```

**Returns:** `void`

### InputEventMouseButton_GlobalPosition_CanBeSet

```csharp
[Test]
    public void InputEventMouseButton_GlobalPosition_CanBeSet()
    {
        // Arrange
        var mouseEvent = new InputEventMouseButton();

        // Act
        mouseEvent.GlobalPosition = new Vector2(300, 400);

        // Assert
        mouseEvent.GlobalPosition.ShouldBe(new Vector2(300, 400));
    }
```

**Returns:** `void`

### InputEventMouseMotion_Position_CanBeSet

```csharp
#endregion

    #region InputEventMouseMotion Tests

    [Test]
    public void InputEventMouseMotion_Position_CanBeSet()
    {
        // Arrange
        var motionEvent = new InputEventMouseMotion();

        // Act
        motionEvent.Position = new Vector2(150, 250);

        // Assert
        motionEvent.Position.ShouldBe(new Vector2(150, 250));
    }
```

**Returns:** `void`

### InputEventMouseMotion_Relative_CanBeSet

```csharp
[Test]
    public void InputEventMouseMotion_Relative_CanBeSet()
    {
        // Arrange
        var motionEvent = new InputEventMouseMotion();

        // Act
        motionEvent.Relative = new Vector2(10, -5);

        // Assert
        motionEvent.Relative.ShouldBe(new Vector2(10, -5));
    }
```

**Returns:** `void`

### InputEventMouseMotion_Velocity_CanBeSet

```csharp
[Test]
    public void InputEventMouseMotion_Velocity_CanBeSet()
    {
        // Arrange
        var motionEvent = new InputEventMouseMotion();

        // Act
        motionEvent.Velocity = new Vector2(100, 50);

        // Assert
        motionEvent.Velocity.ShouldBe(new Vector2(100, 50));
    }
```

**Returns:** `void`

### InputEventKey_Keycode_CanBeSet

```csharp
#endregion

    #region InputEventKey Tests

    [Test]
    public void InputEventKey_Keycode_CanBeSet()
    {
        // Arrange
        var keyEvent = new InputEventKey();

        // Act
        keyEvent.Keycode = Key.Space;

        // Assert
        keyEvent.Keycode.ShouldBe(Key.Space);
    }
```

**Returns:** `void`

### InputEventKey_Pressed_CanBeSet

```csharp
[Test]
    public void InputEventKey_Pressed_CanBeSet()
    {
        // Arrange
        var keyEvent = new InputEventKey();

        // Act
        keyEvent.Pressed = true;

        // Assert
        keyEvent.Pressed.ShouldBeTrue();
    }
```

**Returns:** `void`

### InputEventKey_Echo_CanBeSet

```csharp
[Test]
    public void InputEventKey_Echo_CanBeSet()
    {
        // Arrange
        var keyEvent = new InputEventKey();

        // Act
        keyEvent.Echo = true;

        // Assert
        keyEvent.Echo.ShouldBeTrue();
    }
```

**Returns:** `void`

### InputEventKey_ShiftPressed_CanBeSet

```csharp
[Test]
    public void InputEventKey_ShiftPressed_CanBeSet()
    {
        // Arrange
        var keyEvent = new InputEventKey();

        // Act
        keyEvent.ShiftPressed = true;

        // Assert
        keyEvent.ShiftPressed.ShouldBeTrue();
    }
```

**Returns:** `void`

### InputEventKey_CtrlPressed_CanBeSet

```csharp
[Test]
    public void InputEventKey_CtrlPressed_CanBeSet()
    {
        // Arrange
        var keyEvent = new InputEventKey();

        // Act
        keyEvent.CtrlPressed = true;

        // Assert
        keyEvent.CtrlPressed.ShouldBeTrue();
    }
```

**Returns:** `void`

### InputEventKey_AltPressed_CanBeSet

```csharp
[Test]
    public void InputEventKey_AltPressed_CanBeSet()
    {
        // Arrange
        var keyEvent = new InputEventKey();

        // Act
        keyEvent.AltPressed = true;

        // Assert
        keyEvent.AltPressed.ShouldBeTrue();
    }
```

**Returns:** `void`

### InputEventAction_Action_CanBeSet

```csharp
#endregion

    #region InputEventAction Tests

    [Test]
    public void InputEventAction_Action_CanBeSet()
    {
        // Arrange
        var actionEvent = new InputEventAction();

        // Act
        actionEvent.Action = "ui_accept";

        // Assert
        actionEvent.Action.ToString().ShouldBe("ui_accept");
    }
```

**Returns:** `void`

### InputEventAction_Pressed_CanBeSet

```csharp
[Test]
    public void InputEventAction_Pressed_CanBeSet()
    {
        // Arrange
        var actionEvent = new InputEventAction();

        // Act
        actionEvent.Pressed = true;

        // Assert
        actionEvent.Pressed.ShouldBeTrue();
    }
```

**Returns:** `void`

### InputEventAction_Strength_CanBeSet

```csharp
[Test]
    public void InputEventAction_Strength_CanBeSet()
    {
        // Arrange
        var actionEvent = new InputEventAction();

        // Act
        actionEvent.Strength = 0.75f;

        // Assert
        actionEvent.Strength.ShouldBe(0.75f, 0.01f);
    }
```

**Returns:** `void`

### InputEventScreenTouch_Index_CanBeSet

```csharp
#endregion

    #region InputEventScreenTouch Tests

    [Test]
    public void InputEventScreenTouch_Index_CanBeSet()
    {
        // Arrange
        var touchEvent = new InputEventScreenTouch();

        // Act
        touchEvent.Index = 1;

        // Assert
        touchEvent.Index.ShouldBe(1);
    }
```

**Returns:** `void`

### InputEventScreenTouch_Position_CanBeSet

```csharp
[Test]
    public void InputEventScreenTouch_Position_CanBeSet()
    {
        // Arrange
        var touchEvent = new InputEventScreenTouch();

        // Act
        touchEvent.Position = new Vector2(200, 300);

        // Assert
        touchEvent.Position.ShouldBe(new Vector2(200, 300));
    }
```

**Returns:** `void`

### InputEventScreenTouch_Pressed_CanBeSet

```csharp
[Test]
    public void InputEventScreenTouch_Pressed_CanBeSet()
    {
        // Arrange
        var touchEvent = new InputEventScreenTouch();

        // Act
        touchEvent.Pressed = true;

        // Assert
        touchEvent.Pressed.ShouldBeTrue();
    }
```

**Returns:** `void`

### InputEventKey_CtrlShift_BothCanBeSet

```csharp
#endregion

    #region Modifier Key Combinations Tests

    [Test]
    public void InputEventKey_CtrlShift_BothCanBeSet()
    {
        // Arrange
        var keyEvent = new InputEventKey();

        // Act
        keyEvent.CtrlPressed = true;
        keyEvent.ShiftPressed = true;
        keyEvent.Keycode = Key.S;

        // Assert
        keyEvent.CtrlPressed.ShouldBeTrue();
        keyEvent.ShiftPressed.ShouldBeTrue();
        keyEvent.Keycode.ShouldBe(Key.S);
    }
```

**Returns:** `void`

### InputEventMouseButton_WithModifiers_AllSet

```csharp
[Test]
    public void InputEventMouseButton_WithModifiers_AllSet()
    {
        // Arrange
        var mouseEvent = new InputEventMouseButton();

        // Act
        mouseEvent.ButtonIndex = MouseButton.Left;
        mouseEvent.CtrlPressed = true;
        mouseEvent.AltPressed = true;
        mouseEvent.Pressed = true;

        // Assert
        mouseEvent.ButtonIndex.ShouldBe(MouseButton.Left);
        mouseEvent.CtrlPressed.ShouldBeTrue();
        mouseEvent.AltPressed.ShouldBeTrue();
        mouseEvent.Pressed.ShouldBeTrue();
    }
```

**Returns:** `void`

