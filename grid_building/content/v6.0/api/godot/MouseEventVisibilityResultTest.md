---
title: "MouseEventVisibilityResultTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mouseeventvisibilityresulttest/"
---

# MouseEventVisibilityResultTest

```csharp
GridBuilding.Godot.Tests.Core.Results
class MouseEventVisibilityResultTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Results/MouseEventVisibilityResultTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Results`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_DefaultValues_SetsAllToFalse

```csharp
#region Constructor Tests

    [Fact]
    public void Constructor_DefaultValues_SetsAllToFalse()
    {
        var result = new MouseEventVisibilityResult();

        result.Apply.ShouldBeFalse();
        result.Visible.ShouldBeFalse();
        result.Reason.ShouldBe("");
    }
```

**Returns:** `void`

### Constructor_WithValues_SetsProperties

```csharp
[Fact]
    public void Constructor_WithValues_SetsProperties()
    {
        var result = new MouseEventVisibilityResult(true, true, "test reason");

        result.Apply.ShouldBeTrue();
        result.Visible.ShouldBeTrue();
        result.Reason.ShouldBe("test reason");
    }
```

**Returns:** `void`

### Constructor_PartialValues_UsesDefaults

```csharp
[Fact]
    public void Constructor_PartialValues_UsesDefaults()
    {
        var result = new MouseEventVisibilityResult(true);

        result.Apply.ShouldBeTrue();
        result.Visible.ShouldBeFalse();
        result.Reason.ShouldBe("");
    }
```

**Returns:** `void`

### Show_CreatesVisibleApplyResult

```csharp
#endregion

    #region Factory Method Tests

    [Fact]
    public void Show_CreatesVisibleApplyResult()
    {
        var result = MouseEventVisibilityResult.Show("showing");

        result.Apply.ShouldBeTrue();
        result.Visible.ShouldBeTrue();
        result.Reason.ShouldBe("showing");
    }
```

**Returns:** `void`

### Show_WithoutReason_UsesEmptyString

```csharp
[Fact]
    public void Show_WithoutReason_UsesEmptyString()
    {
        var result = MouseEventVisibilityResult.Show();

        result.Apply.ShouldBeTrue();
        result.Visible.ShouldBeTrue();
        result.Reason.ShouldBe("");
    }
```

**Returns:** `void`

### Hide_CreatesHiddenApplyResult

```csharp
[Fact]
    public void Hide_CreatesHiddenApplyResult()
    {
        var result = MouseEventVisibilityResult.Hide("hiding");

        result.Apply.ShouldBeTrue();
        result.Visible.ShouldBeFalse();
        result.Reason.ShouldBe("hiding");
    }
```

**Returns:** `void`

### Hide_WithoutReason_UsesEmptyString

```csharp
[Fact]
    public void Hide_WithoutReason_UsesEmptyString()
    {
        var result = MouseEventVisibilityResult.Hide();

        result.Apply.ShouldBeTrue();
        result.Visible.ShouldBeFalse();
        result.Reason.ShouldBe("");
    }
```

**Returns:** `void`

### NoChange_CreatesNoApplyResult

```csharp
[Fact]
    public void NoChange_CreatesNoApplyResult()
    {
        var result = MouseEventVisibilityResult.NoChange("unchanged");

        result.Apply.ShouldBeFalse();
        result.Visible.ShouldBeFalse();
        result.Reason.ShouldBe("unchanged");
    }
```

**Returns:** `void`

### NoChange_WithoutReason_UsesEmptyString

```csharp
[Fact]
    public void NoChange_WithoutReason_UsesEmptyString()
    {
        var result = MouseEventVisibilityResult.NoChange();

        result.Apply.ShouldBeFalse();
        result.Visible.ShouldBeFalse();
        result.Reason.ShouldBe("");
    }
```

**Returns:** `void`

### ToString_IncludesAllProperties

```csharp
#endregion

    #region ToString Tests

    [Fact]
    public void ToString_IncludesAllProperties()
    {
        var result = new MouseEventVisibilityResult(true, true, "test");

        var str = result.ToString();

        str.ShouldContain("apply=True");
        str.ShouldContain("visible=True");
        str.ShouldContain("reason='test'");
    }
```

**Returns:** `void`

### ToString_HandlesEmptyReason

```csharp
[Fact]
    public void ToString_HandlesEmptyReason()
    {
        var result = new MouseEventVisibilityResult(false, false, "");

        var str = result.ToString();

        str.ShouldContain("reason=''");
    }
```

**Returns:** `void`

### Apply_CanBeChanged

```csharp
#endregion

    #region Property Mutability Tests

    [Fact]
    public void Apply_CanBeChanged()
    {
        var result = new MouseEventVisibilityResult();
        
        result.Apply = true;

        result.Apply.ShouldBeTrue();
    }
```

**Returns:** `void`

### Visible_CanBeChanged

```csharp
[Fact]
    public void Visible_CanBeChanged()
    {
        var result = new MouseEventVisibilityResult();
        
        result.Visible = true;

        result.Visible.ShouldBeTrue();
    }
```

**Returns:** `void`

### Reason_CanBeChanged

```csharp
[Fact]
    public void Reason_CanBeChanged()
    {
        var result = new MouseEventVisibilityResult();
        
        result.Reason = "new reason";

        result.Reason.ShouldBe("new reason");
    }
```

**Returns:** `void`

### Scenario_MouseEnterArea_ShowsElement

```csharp
#endregion

    #region Usage Scenario Tests

    [Fact]
    public void Scenario_MouseEnterArea_ShowsElement()
    {
        // Simulating: mouse enters an interactive area
        var result = MouseEventVisibilityResult.Show("Mouse entered interactive zone");

        result.Apply.ShouldBeTrue();
        result.Visible.ShouldBeTrue();
    }
```

**Returns:** `void`

### Scenario_MouseLeaveArea_HidesElement

```csharp
[Fact]
    public void Scenario_MouseLeaveArea_HidesElement()
    {
        // Simulating: mouse leaves an interactive area
        var result = MouseEventVisibilityResult.Hide("Mouse left interactive zone");

        result.Apply.ShouldBeTrue();
        result.Visible.ShouldBeFalse();
    }
```

**Returns:** `void`

### Scenario_MouseMoveWithinArea_NoChange

```csharp
[Fact]
    public void Scenario_MouseMoveWithinArea_NoChange()
    {
        // Simulating: mouse moves within same area (no visibility change needed)
        var result = MouseEventVisibilityResult.NoChange("Still in same zone");

        result.Apply.ShouldBeFalse();
    }
```

**Returns:** `void`

