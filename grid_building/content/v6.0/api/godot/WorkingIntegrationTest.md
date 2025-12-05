---
title: "WorkingIntegrationTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/workingintegrationtest/"
---

# WorkingIntegrationTest

```csharp
GridBuilding.Tests.Godot
class WorkingIntegrationTest
{
    // Members...
}
```

Working minimal integration test to verify GoDotTest framework.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/WorkingIntegrationTest.cs`  
**Namespace:** `GridBuilding.Tests.Godot`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Setup

```csharp
[Setup]
    public void Setup()
    {
        GD.Print("Setting up integration test...");
    }
```

**Returns:** `void`

### Cleanup

```csharp
[Cleanup]
    public void Cleanup()
    {
        GD.Print("Cleaning up integration test...");
    }
```

**Returns:** `void`

### Core_BuildingData_Creation_ShouldWork

```csharp
[Test]
    public void Core_BuildingData_Creation_ShouldWork()
    {
        // Arrange & Act
        var buildingData = new BuildingData
        {
            BuildingId = "test-building",
            BuildingName = "Test Residence",
            BuildingType = BuildingType.Residential,
            Size = new GridBuilding.Core.Types.Vector2I(2, 2)
        };

        // Assert - Using Shouldly assertions
        buildingData.BuildingId.ShouldBe("test-building");
        buildingData.BuildingName.ShouldBe("Test Residence");
        buildingData.BuildingType.ShouldBe(BuildingType.Residential);
        buildingData.Size.X.ShouldBe(2);
        buildingData.Size.Y.ShouldBe(2);
    }
```

**Returns:** `void`

### Godot_NodeOperations_ShouldWork

```csharp
[Test]
    public void Godot_NodeOperations_ShouldWork()
    {
        // Arrange
        var testNode = new Node2D();
        testNode.Name = "TestNode";

        // Act
        TestScene.AddChild(testNode);

        // Assert
        testNode.IsInsideTree().ShouldBeTrue();
        testNode.GetParent().ShouldBe(TestScene);
        testNode.Name.ToString().ShouldBe("TestNode");

        // Cleanup
        testNode.QueueFree();
    }
```

**Returns:** `void`

### Vector2I_Conversion_ShouldWork

```csharp
[Test]
    public void Vector2I_Conversion_ShouldWork()
    {
        // Arrange
        var godotVector = new Godot.Vector2I(5, 10);
        var coreVector = new GridBuilding.Core.Types.Vector2I(5, 10);

        // Assert
        godotVector.X.ShouldBe(coreVector.X);
        godotVector.Y.ShouldBe(coreVector.Y);
        coreVector.X.ShouldBe(5);
        coreVector.Y.ShouldBe(10);
    }
```

**Returns:** `void`

