---
title: "NavigationIntegrationTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/navigationintegrationtests/"
---

# NavigationIntegrationTests

```csharp
GridBuilding.Godot.Tests.Integration.GoDotTest
class NavigationIntegrationTests
{
    // Members...
}
```

Integration tests for Navigation2D nodes and pathfinding

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/NavigationIntegrationTests.cs`  
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

### NavigationAgent2D_CanBeCreated

```csharp
// ==================== NavigationAgent2D Tests ====================

    [Test]
    public void NavigationAgent2D_CanBeCreated()
    {
        var agent = new NavigationAgent2D();
        _testRoot.AddChild(agent);

        agent.ShouldNotBeNull();
        GodotObject.IsInstanceValid(agent).ShouldBeTrue();
    }
```

**Returns:** `void`

### NavigationAgent2D_TargetPosition_CanBeSet

```csharp
[Test]
    public void NavigationAgent2D_TargetPosition_CanBeSet()
    {
        var parent = new CharacterBody2D();
        var agent = new NavigationAgent2D();
        parent.AddChild(agent);
        _testRoot.AddChild(parent);

        var targetPos = new Vector2(100, 200);
        agent.TargetPosition = targetPos;

        agent.TargetPosition.ShouldBe(targetPos);
    }
```

**Returns:** `void`

### NavigationAgent2D_PathDesiredDistance_CanBeConfigured

```csharp
[Test]
    public void NavigationAgent2D_PathDesiredDistance_CanBeConfigured()
    {
        var agent = new NavigationAgent2D();
        _testRoot.AddChild(agent);

        agent.PathDesiredDistance = 10.0f;

        agent.PathDesiredDistance.ShouldBe(10.0f);
    }
```

**Returns:** `void`

### NavigationAgent2D_TargetDesiredDistance_CanBeConfigured

```csharp
[Test]
    public void NavigationAgent2D_TargetDesiredDistance_CanBeConfigured()
    {
        var agent = new NavigationAgent2D();
        _testRoot.AddChild(agent);

        agent.TargetDesiredDistance = 5.0f;

        agent.TargetDesiredDistance.ShouldBe(5.0f);
    }
```

**Returns:** `void`

### NavigationAgent2D_MaxSpeed_CanBeSet

```csharp
[Test]
    public void NavigationAgent2D_MaxSpeed_CanBeSet()
    {
        var agent = new NavigationAgent2D();
        _testRoot.AddChild(agent);

        agent.MaxSpeed = 300.0f;

        agent.MaxSpeed.ShouldBe(300.0f);
    }
```

**Returns:** `void`

### NavigationAgent2D_Radius_CanBeSet

```csharp
[Test]
    public void NavigationAgent2D_Radius_CanBeSet()
    {
        var agent = new NavigationAgent2D();
        _testRoot.AddChild(agent);

        agent.Radius = 20.0f;

        agent.Radius.ShouldBe(20.0f);
    }
```

**Returns:** `void`

### NavigationAgent2D_AvoidanceEnabled_CanBeToggled

```csharp
[Test]
    public void NavigationAgent2D_AvoidanceEnabled_CanBeToggled()
    {
        var agent = new NavigationAgent2D();
        _testRoot.AddChild(agent);

        agent.AvoidanceEnabled = true;
        agent.AvoidanceEnabled.ShouldBeTrue();

        agent.AvoidanceEnabled = false;
        agent.AvoidanceEnabled.ShouldBeFalse();
    }
```

**Returns:** `void`

### NavigationAgent2D_NavigationLayers_CanBeSet

```csharp
[Test]
    public void NavigationAgent2D_NavigationLayers_CanBeSet()
    {
        var agent = new NavigationAgent2D();
        _testRoot.AddChild(agent);

        agent.NavigationLayers = 0b0101;

        agent.NavigationLayers.ShouldBe(0b0101u);
    }
```

**Returns:** `void`

### NavigationAgent2D_PathPostprocessing_CanBeConfigured

```csharp
[Test]
    public void NavigationAgent2D_PathPostprocessing_CanBeConfigured()
    {
        var agent = new NavigationAgent2D();
        _testRoot.AddChild(agent);

        agent.PathPostprocessing = NavigationPathQueryParameters2D.PathPostProcessing.Corridorfunnel;

        agent.PathPostprocessing.ShouldBe(NavigationPathQueryParameters2D.PathPostProcessing.Corridorfunnel);
    }
```

**Returns:** `void`

### NavigationAgent2D_PathMetadataFlags_CanBeSet

```csharp
[Test]
    public void NavigationAgent2D_PathMetadataFlags_CanBeSet()
    {
        var agent = new NavigationAgent2D();
        _testRoot.AddChild(agent);

        agent.PathMetadataFlags = NavigationPathQueryParameters2D.PathMetadataFlags.All;

        agent.PathMetadataFlags.ShouldBe(NavigationPathQueryParameters2D.PathMetadataFlags.All);
    }
```

**Returns:** `void`

### NavigationRegion2D_CanBeCreated

```csharp
// ==================== NavigationRegion2D Tests ====================

    [Test]
    public void NavigationRegion2D_CanBeCreated()
    {
        var region = new NavigationRegion2D();
        _testRoot.AddChild(region);

        region.ShouldNotBeNull();
        GodotObject.IsInstanceValid(region).ShouldBeTrue();
    }
```

**Returns:** `void`

### NavigationRegion2D_NavigationPolygon_CanBeSet

```csharp
[Test]
    public void NavigationRegion2D_NavigationPolygon_CanBeSet()
    {
        var region = new NavigationRegion2D();
        _testRoot.AddChild(region);

        var navPoly = new NavigationPolygon();
        region.NavigationPolygon = navPoly;

        region.NavigationPolygon.ShouldBe(navPoly);
    }
```

**Returns:** `void`

### NavigationRegion2D_Enabled_CanBeToggled

```csharp
[Test]
    public void NavigationRegion2D_Enabled_CanBeToggled()
    {
        var region = new NavigationRegion2D();
        _testRoot.AddChild(region);

        region.Enabled = false;
        region.Enabled.ShouldBeFalse();

        region.Enabled = true;
        region.Enabled.ShouldBeTrue();
    }
```

**Returns:** `void`

### NavigationRegion2D_NavigationLayers_CanBeSet

```csharp
[Test]
    public void NavigationRegion2D_NavigationLayers_CanBeSet()
    {
        var region = new NavigationRegion2D();
        _testRoot.AddChild(region);

        region.NavigationLayers = 0b1010;

        region.NavigationLayers.ShouldBe(0b1010u);
    }
```

**Returns:** `void`

### NavigationRegion2D_EnterCost_CanBeSet

```csharp
[Test]
    public void NavigationRegion2D_EnterCost_CanBeSet()
    {
        var region = new NavigationRegion2D();
        _testRoot.AddChild(region);

        region.EnterCost = 2.5f;

        region.EnterCost.ShouldBe(2.5f);
    }
```

**Returns:** `void`

### NavigationRegion2D_TravelCost_CanBeSet

```csharp
[Test]
    public void NavigationRegion2D_TravelCost_CanBeSet()
    {
        var region = new NavigationRegion2D();
        _testRoot.AddChild(region);

        region.TravelCost = 1.5f;

        region.TravelCost.ShouldBe(1.5f);
    }
```

**Returns:** `void`

### NavigationPolygon_CanBeCreated

```csharp
// ==================== NavigationPolygon Tests ====================

    [Test]
    public void NavigationPolygon_CanBeCreated()
    {
        var navPoly = new NavigationPolygon();

        navPoly.ShouldNotBeNull();
    }
```

**Returns:** `void`

### NavigationPolygon_Vertices_CanBeSet

```csharp
[Test]
    public void NavigationPolygon_Vertices_CanBeSet()
    {
        var navPoly = new NavigationPolygon();

        var vertices = new Vector2[]
        {
            new(0, 0),
            new(100, 0),
            new(100, 100),
            new(0, 100)
        };
        navPoly.Vertices = vertices;

        navPoly.Vertices.Length.ShouldBe(4);
    }
```

**Returns:** `void`

### NavigationPolygon_AddOutline_AddsOutline

```csharp
[Test]
    public void NavigationPolygon_AddOutline_AddsOutline()
    {
        var navPoly = new NavigationPolygon();

        var outline = new Vector2[]
        {
            new(0, 0),
            new(100, 0),
            new(100, 100),
            new(0, 100)
        };
        navPoly.AddOutline(outline);

        navPoly.GetOutlineCount().ShouldBe(1);
    }
```

**Returns:** `void`

### NavigationPolygon_GetOutline_ReturnsCorrectOutline

```csharp
[Test]
    public void NavigationPolygon_GetOutline_ReturnsCorrectOutline()
    {
        var navPoly = new NavigationPolygon();

        var outline = new Vector2[]
        {
            new(0, 0),
            new(100, 0),
            new(100, 100),
            new(0, 100)
        };
        navPoly.AddOutline(outline);

        var retrieved = navPoly.GetOutline(0);
        retrieved.Length.ShouldBe(4);
    }
```

**Returns:** `void`

### NavigationPolygon_ClearOutlines_RemovesAllOutlines

```csharp
[Test]
    public void NavigationPolygon_ClearOutlines_RemovesAllOutlines()
    {
        var navPoly = new NavigationPolygon();

        navPoly.AddOutline(new Vector2[] { new(0, 0), new(10, 0), new(10, 10) });
        navPoly.AddOutline(new Vector2[] { new(20, 20), new(30, 20), new(30, 30) });
        navPoly.ClearOutlines();

        navPoly.GetOutlineCount().ShouldBe(0);
    }
```

**Returns:** `void`

### NavigationObstacle2D_CanBeCreated

```csharp
// ==================== NavigationObstacle2D Tests ====================

    [Test]
    public void NavigationObstacle2D_CanBeCreated()
    {
        var obstacle = new NavigationObstacle2D();
        _testRoot.AddChild(obstacle);

        obstacle.ShouldNotBeNull();
        GodotObject.IsInstanceValid(obstacle).ShouldBeTrue();
    }
```

**Returns:** `void`

### NavigationObstacle2D_Radius_CanBeSet

```csharp
[Test]
    public void NavigationObstacle2D_Radius_CanBeSet()
    {
        var obstacle = new NavigationObstacle2D();
        _testRoot.AddChild(obstacle);

        obstacle.Radius = 50.0f;

        obstacle.Radius.ShouldBe(50.0f);
    }
```

**Returns:** `void`

### NavigationObstacle2D_AvoidanceEnabled_CanBeToggled

```csharp
[Test]
    public void NavigationObstacle2D_AvoidanceEnabled_CanBeToggled()
    {
        var obstacle = new NavigationObstacle2D();
        _testRoot.AddChild(obstacle);

        obstacle.AvoidanceEnabled = true;
        obstacle.AvoidanceEnabled.ShouldBeTrue();

        obstacle.AvoidanceEnabled = false;
        obstacle.AvoidanceEnabled.ShouldBeFalse();
    }
```

**Returns:** `void`

### NavigationObstacle2D_Velocity_CanBeSet

```csharp
[Test]
    public void NavigationObstacle2D_Velocity_CanBeSet()
    {
        var obstacle = new NavigationObstacle2D();
        _testRoot.AddChild(obstacle);

        var velocity = new Vector2(50, 30);
        obstacle.Velocity = velocity;

        obstacle.Velocity.ShouldBe(velocity);
    }
```

**Returns:** `void`

### NavigationObstacle2D_AvoidanceLayers_CanBeSet

```csharp
[Test]
    public void NavigationObstacle2D_AvoidanceLayers_CanBeSet()
    {
        var obstacle = new NavigationObstacle2D();
        _testRoot.AddChild(obstacle);

        obstacle.AvoidanceLayers = 0b0011;

        obstacle.AvoidanceLayers.ShouldBe(0b0011u);
    }
```

**Returns:** `void`

### NavigationLink2D_CanBeCreated

```csharp
// ==================== NavigationLink2D Tests ====================

    [Test]
    public void NavigationLink2D_CanBeCreated()
    {
        var link = new NavigationLink2D();
        _testRoot.AddChild(link);

        link.ShouldNotBeNull();
        GodotObject.IsInstanceValid(link).ShouldBeTrue();
    }
```

**Returns:** `void`

### NavigationLink2D_StartPosition_CanBeSet

```csharp
[Test]
    public void NavigationLink2D_StartPosition_CanBeSet()
    {
        var link = new NavigationLink2D();
        _testRoot.AddChild(link);

        var startPos = new Vector2(0, 0);
        link.StartPosition = startPos;

        link.StartPosition.ShouldBe(startPos);
    }
```

**Returns:** `void`

### NavigationLink2D_EndPosition_CanBeSet

```csharp
[Test]
    public void NavigationLink2D_EndPosition_CanBeSet()
    {
        var link = new NavigationLink2D();
        _testRoot.AddChild(link);

        var endPos = new Vector2(100, 50);
        link.EndPosition = endPos;

        link.EndPosition.ShouldBe(endPos);
    }
```

**Returns:** `void`

### NavigationLink2D_Bidirectional_CanBeToggled

```csharp
[Test]
    public void NavigationLink2D_Bidirectional_CanBeToggled()
    {
        var link = new NavigationLink2D();
        _testRoot.AddChild(link);

        link.Bidirectional = false;
        link.Bidirectional.ShouldBeFalse();

        link.Bidirectional = true;
        link.Bidirectional.ShouldBeTrue();
    }
```

**Returns:** `void`

### NavigationLink2D_TravelCost_CanBeSet

```csharp
[Test]
    public void NavigationLink2D_TravelCost_CanBeSet()
    {
        var link = new NavigationLink2D();
        _testRoot.AddChild(link);

        link.TravelCost = 3.0f;

        link.TravelCost.ShouldBe(3.0f);
    }
```

**Returns:** `void`

### NavigationLink2D_NavigationLayers_CanBeSet

```csharp
[Test]
    public void NavigationLink2D_NavigationLayers_CanBeSet()
    {
        var link = new NavigationLink2D();
        _testRoot.AddChild(link);

        link.NavigationLayers = 0b1111;

        link.NavigationLayers.ShouldBe(0b1111u);
    }
```

**Returns:** `void`

### NavigationLink2D_Enabled_CanBeToggled

```csharp
[Test]
    public void NavigationLink2D_Enabled_CanBeToggled()
    {
        var link = new NavigationLink2D();
        _testRoot.AddChild(link);

        link.Enabled = false;
        link.Enabled.ShouldBeFalse();

        link.Enabled = true;
        link.Enabled.ShouldBeTrue();
    }
```

**Returns:** `void`

