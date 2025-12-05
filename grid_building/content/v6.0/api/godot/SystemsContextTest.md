---
title: "SystemsContextTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/systemscontexttest/"
---

# SystemsContextTest

```csharp
GridBuilding.Godot.Tests.Core.Contexts
class SystemsContextTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/SystemsContextTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_CreatesWithNullSystems

```csharp
#endregion

    #region Constructor Tests

    [Fact]
    public void Constructor_CreatesWithNullSystems()
    {
        var context = new GBSystemsContext();

        context.GetBuildingSystem().ShouldBeNull();
        context.GetGridTargetingSystem().ShouldBeNull();
        context.GetManipulationSystem().ShouldBeNull();
    }
```

**Returns:** `void`

### Constructor_WithLogger_SetsLogger

```csharp
[Fact]
    public void Constructor_WithLogger_SetsLogger()
    {
        var logger = new MockLogger();
        var context = new GBSystemsContext(logger);

        // Logger is used internally, we can't directly access it
        // but the constructor should not throw
        context.ShouldNotBeNull();
    }
```

**Returns:** `void`

### SetSystem_BuildingSystem_SetsAndFiresEvent

```csharp
#endregion

    #region System Setter Tests

    [Fact]
    public void SetSystem_BuildingSystem_SetsAndFiresEvent()
    {
        var context = new GBSystemsContext();
        IBuildingSystem? firedSystem = null;
        context.BuildingSystemChanged += (system) => firedSystem = system;

        var system = new MockBuildingSystem();
        context.SetSystem(system);

        context.GetBuildingSystem().ShouldBe(system);
        firedSystem.ShouldBe(system);
    }
```

**Returns:** `void`

### SetSystem_GridTargetingSystem_SetsAndFiresEvent

```csharp
[Fact]
    public void SetSystem_GridTargetingSystem_SetsAndFiresEvent()
    {
        var context = new GBSystemsContext();
        IGridTargetingSystem? firedSystem = null;
        context.GridTargetingSystemChanged += (system) => firedSystem = system;

        var system = new MockGridTargetingSystem();
        context.SetSystem(system);

        context.GetGridTargetingSystem().ShouldBe(system);
        firedSystem.ShouldBe(system);
    }
```

**Returns:** `void`

### SetSystem_ManipulationSystem_SetsAndFiresEvent

```csharp
[Fact]
    public void SetSystem_ManipulationSystem_SetsAndFiresEvent()
    {
        var context = new GBSystemsContext();
        IManipulationSystem? firedSystem = null;
        context.ManipulationSystemChanged += (system) => firedSystem = system;

        var system = new MockManipulationSystem();
        context.SetSystem(system);

        context.GetManipulationSystem().ShouldBe(system);
        firedSystem.ShouldBe(system);
    }
```

**Returns:** `void`

### SetSystem_SameSystem_DoesNotFireEvent

```csharp
[Fact]
    public void SetSystem_SameSystem_DoesNotFireEvent()
    {
        var context = new GBSystemsContext();
        var eventCount = 0;
        context.BuildingSystemChanged += (_) => eventCount++;

        var system = new MockBuildingSystem();
        context.SetSystem(system);
        eventCount.ShouldBe(1); // First set

        context.SetSystem(system); // Set same system
        eventCount.ShouldBe(1); // Should not increment
    }
```

**Returns:** `void`

### SetSystem_UnknownSystem_DoesNotSetAnySystem

```csharp
[Fact]
    public void SetSystem_UnknownSystem_DoesNotSetAnySystem()
    {
        var context = new GBSystemsContext();
        var unknownSystem = new UnknownSystem();

        context.SetSystem(unknownSystem);

        context.GetBuildingSystem().ShouldBeNull();
        context.GetGridTargetingSystem().ShouldBeNull();
        context.GetManipulationSystem().ShouldBeNull();
    }
```

**Returns:** `void`

### BuildingSystemChanged_FiresWhenSystemChanges

```csharp
#endregion

    #region Event Tests

    [Fact]
    public void BuildingSystemChanged_FiresWhenSystemChanges()
    {
        var context = new GBSystemsContext();
        var eventCount = 0;
        IBuildingSystem? lastSystem = null;

        context.BuildingSystemChanged += (system) =>
        {
            eventCount++;
            lastSystem = system;
        };

        var system1 = new MockBuildingSystem();
        var system2 = new MockBuildingSystem();

        context.SetSystem(system1);
        eventCount.ShouldBe(1);
        lastSystem.ShouldBe(system1);

        context.SetSystem(system2);
        eventCount.ShouldBe(2);
        lastSystem.ShouldBe(system2);
    }
```

**Returns:** `void`

### GridTargetingSystemChanged_FiresWhenSystemChanges

```csharp
[Fact]
    public void GridTargetingSystemChanged_FiresWhenSystemChanges()
    {
        var context = new GBSystemsContext();
        var eventCount = 0;
        IGridTargetingSystem? lastSystem = null;

        context.GridTargetingSystemChanged += (system) =>
        {
            eventCount++;
            lastSystem = system;
        };

        var system1 = new MockGridTargetingSystem();
        var system2 = new MockGridTargetingSystem();

        context.SetSystem(system1);
        eventCount.ShouldBe(1);
        lastSystem.ShouldBe(system1);

        context.SetSystem(system2);
        eventCount.ShouldBe(2);
        lastSystem.ShouldBe(system2);
    }
```

**Returns:** `void`

### ManipulationSystemChanged_FiresWhenSystemChanges

```csharp
[Fact]
    public void ManipulationSystemChanged_FiresWhenSystemChanges()
    {
        var context = new GBSystemsContext();
        var eventCount = 0;
        IManipulationSystem? lastSystem = null;

        context.ManipulationSystemChanged += (system) =>
        {
            eventCount++;
            lastSystem = system;
        };

        var system1 = new MockManipulationSystem();
        var system2 = new MockManipulationSystem();

        context.SetSystem(system1);
        eventCount.ShouldBe(1);
        lastSystem.ShouldBe(system1);

        context.SetSystem(system2);
        eventCount.ShouldBe(2);
        lastSystem.ShouldBe(system2);
    }
```

**Returns:** `void`

### GetEditorIssues_ReturnsEmptyList

```csharp
#endregion

    #region Validation Tests

    [Fact]
    public void GetEditorIssues_ReturnsEmptyList()
    {
        var context = new GBSystemsContext();

        var issues = context.GetEditorIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeIssues_NoChecks_ReturnsWarning

```csharp
[Fact]
    public void GetRuntimeIssues_NoChecks_ReturnsWarning()
    {
        var context = new GBSystemsContext();

        var issues = context.GetRuntimeIssues(null);

        issues.ShouldContain("IRuntimeChecks is null, skipping all extra runtime checks");
    }
```

**Returns:** `void`

### GetRuntimeIssues_WithNoChecksEnabled_ReturnsEmpty

```csharp
[Fact]
    public void GetRuntimeIssues_WithNoChecksEnabled_ReturnsEmpty()
    {
        var context = new GBSystemsContext();
        var checks = new MockRuntimeChecks
        {
            BuildingSystem = false,
            GridTargetingSystem = false,
            ManipulationSystem = false
        };

        var issues = context.GetRuntimeIssues(checks);

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeIssues_BuildingSystemCheckEnabled_NoSystem_ReturnsIssue

```csharp
[Fact]
    public void GetRuntimeIssues_BuildingSystemCheckEnabled_NoSystem_ReturnsIssue()
    {
        var context = new GBSystemsContext();
        var checks = new MockRuntimeChecks
        {
            BuildingSystem = true,
            GridTargetingSystem = false,
            ManipulationSystem = false
        };

        var issues = context.GetRuntimeIssues(checks);

        issues.ShouldContain("BuildingSystem is not set");
    }
```

**Returns:** `void`

### GetRuntimeIssues_GridTargetingSystemCheckEnabled_NoSystem_ReturnsIssue

```csharp
[Fact]
    public void GetRuntimeIssues_GridTargetingSystemCheckEnabled_NoSystem_ReturnsIssue()
    {
        var context = new GBSystemsContext();
        var checks = new MockRuntimeChecks
        {
            BuildingSystem = false,
            GridTargetingSystem = true,
            ManipulationSystem = false
        };

        var issues = context.GetRuntimeIssues(checks);

        issues.ShouldContain("GridTargetingSystem is not set");
    }
```

**Returns:** `void`

### GetRuntimeIssues_ManipulationSystemCheckEnabled_NoSystem_ReturnsIssue

```csharp
[Fact]
    public void GetRuntimeIssues_ManipulationSystemCheckEnabled_NoSystem_ReturnsIssue()
    {
        var context = new GBSystemsContext();
        var checks = new MockRuntimeChecks
        {
            BuildingSystem = false,
            GridTargetingSystem = false,
            ManipulationSystem = true
        };

        var issues = context.GetRuntimeIssues(checks);

        issues.ShouldContain("ManipulationSystem is not set");
    }
```

**Returns:** `void`

### GetRuntimeIssues_AllChecksEnabled_AllSystemsSet_ReturnsEmpty

```csharp
[Fact]
    public void GetRuntimeIssues_AllChecksEnabled_AllSystemsSet_ReturnsEmpty()
    {
        var context = new GBSystemsContext();
        var checks = new MockRuntimeChecks
        {
            BuildingSystem = true,
            GridTargetingSystem = true,
            ManipulationSystem = true
        };

        // Set all systems
        context.SetSystem(new MockBuildingSystem());
        context.SetSystem(new MockGridTargetingSystem());
        context.SetSystem(new MockManipulationSystem());

        var issues = context.GetRuntimeIssues(checks);

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### MockBuildingSystem_ImplementsIBuildingSystem

```csharp
#endregion

    #region Interface Tests

    [Fact]
    public void MockBuildingSystem_ImplementsIBuildingSystem()
    {
        var system = new MockBuildingSystem();
        system.ShouldBeAssignableTo<IBuildingSystem>();
        system.ShouldBeAssignableTo<ISystem>();
    }
```

**Returns:** `void`

### MockGridTargetingSystem_ImplementsIGridTargetingSystem

```csharp
[Fact]
    public void MockGridTargetingSystem_ImplementsIGridTargetingSystem()
    {
        var system = new MockGridTargetingSystem();
        system.ShouldBeAssignableTo<IGridTargetingSystem>();
        system.ShouldBeAssignableTo<ISystem>();
    }
```

**Returns:** `void`

### MockManipulationSystem_ImplementsIManipulationSystem

```csharp
[Fact]
    public void MockManipulationSystem_ImplementsIManipulationSystem()
    {
        var system = new MockManipulationSystem();
        system.ShouldBeAssignableTo<IManipulationSystem>();
        system.ShouldBeAssignableTo<ISystem>();
    }
```

**Returns:** `void`

