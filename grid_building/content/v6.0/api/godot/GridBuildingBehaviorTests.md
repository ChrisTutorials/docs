---
title: "GridBuildingBehaviorTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gridbuildingbehaviortests/"
---

# GridBuildingBehaviorTests

```csharp
GridBuilding.Godot.Tests.BehaviorVerification
class GridBuildingBehaviorTests
{
    // Members...
}
```

Behavior verification tests for Grid Building Plugin
Tests actual system behaviors rather than just individual function outputs

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GridBuildingBehaviorTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.BehaviorVerification`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ModeTransition_ShouldBeValid_ForAllValidTransitions

```csharp
#region Mode Transition Behavior Tests

    [Theory]
    [InlineData(BuildingMode.Off, BuildingMode.Build, true)]
    [InlineData(BuildingMode.Build, BuildingMode.Move, true)]
    [InlineData(BuildingMode.Move, BuildingMode.Demolish, true)]
    [InlineData(BuildingMode.Demolish, BuildingMode.Info, true)]
    [InlineData(BuildingMode.Info, BuildingMode.Off, true)]
    public void ModeTransition_ShouldBeValid_ForAllValidTransitions(
        BuildingMode fromMode, BuildingMode toMode, bool shouldBeValid)
    {
        // Arrange
        var context = new GBOwnerContext();
        context.SetMode(fromMode);

        // Act
        var canTransition = context.CanTransitionTo(toMode);

        // Assert - Behavior verification
        canTransition.ShouldBe(shouldBeValid);
        
        // Verify side effects
        if (shouldBeValid)
        {
            context.SetMode(toMode);
            context.GetCurrentMode().ShouldBe(toMode);
        }
    }
```

**Returns:** `void`

**Parameters:**
- `BuildingMode fromMode`
- `BuildingMode toMode`
- `bool shouldBeValid`

### ModeTransition_ShouldTriggerEvents_WhenModeChanges

```csharp
[Fact]
    public void ModeTransition_ShouldTriggerEvents_WhenModeChanges()
    {
        // Arrange
        var context = new GBOwnerContext();
        var eventTriggered = false;
        context.OnModeChanged += (oldMode, newMode) => eventTriggered = true;

        // Act
        context.SetMode(BuildingMode.Build);

        // Assert - Behavior verification
        eventTriggered.ShouldBeTrue("Mode change should trigger event");
        context.GetCurrentMode().ShouldBe(BuildingMode.Build);
    }
```

**Returns:** `void`

### GBOwnerContext_ShouldMaintainConsistency_WhenMultipleOperationsOccur

```csharp
#endregion

    #region State Consistency Behavior Tests

    [Fact]
    public void GBOwnerContext_ShouldMaintainConsistency_WhenMultipleOperationsOccur()
    {
        // Arrange
        var owner = new MockGBOwner();
        var context = new GBOwnerContext(owner);
        var operations = new List<Action<GBOwnerContext>>();

        // Act - Perform multiple operations
        operations.Add(ctx => ctx.SetMode(BuildingMode.Build));
        operations.Add(ctx => ctx.SetGridPosition(new Vector2(10, 15)));
        operations.Add(ctx => ctx.SetTargetingEnabled(true));
        operations.Add(ctx => ctx.SetMode(BuildingMode.Move));
        operations.Add(ctx => ctx.SetGridPosition(new Vector2(20, 25)));

        foreach (var operation in operations)
        {
            operation(context);
        }

        // Assert - Behavior verification: State should be consistent
        context.GetOwner().ShouldBe(owner);
        context.GetCurrentMode().ShouldBe(BuildingMode.Move);
        context.GetGridPosition().ShouldBe(new Vector2(20, 25));
        context.IsTargetingEnabled().ShouldBeTrue();
    }
```

**Returns:** `void`

### UserState_ShouldInheritFromGBOwnerContext_WhenCreated

```csharp
[Fact]
    public void UserState_ShouldInheritFromGBOwnerContext_WhenCreated()
    {
        // Arrange
        var owner = new MockGBOwner();
        var baseContext = new GBOwnerContext(owner);
        baseContext.SetMode(BuildingMode.Build);
        baseContext.SetGridPosition(new Vector2(5, 10));

        // Act
        var userState = new UserState(baseContext);

        // Assert - Behavior verification: Inheritance should work correctly
        userState.GetOwner().ShouldBe(owner);
        userState.GetCurrentMode().ShouldBe(BuildingMode.Build);
        userState.GetGridPosition().ShouldBe(new Vector2(5, 10));
        
        // Verify independence
        baseContext.SetMode(BuildingMode.Move);
        userState.GetCurrentMode().ShouldBe(BuildingMode.Build, "UserState should maintain its own state");
    }
```

**Returns:** `void`

### GridPosition_ShouldHandleInvalidCoordinates_WhenSet

```csharp
#endregion

    #region Error Handling Behavior Tests

    [Theory]
    [InlineData(-1)]
    [InlineData(-100)]
    [InlineData(int.MinValue)]
    public void GridPosition_ShouldHandleInvalidCoordinates_WhenSet(int invalidCoord)
    {
        // Arrange
        var context = new GBOwnerContext();
        var invalidPosition = new Vector2(invalidCoord, invalidCoord);

        // Act & Assert - Behavior verification
        Should.Throw<ArgumentException>(() => context.SetGridPosition(invalidPosition))
            .Message.ShouldContain("Invalid grid position");
        
        // Context should remain unchanged after failed operation
        context.GetGridPosition().ShouldBe(Vector2.Zero);
    }
```

**Returns:** `void`

**Parameters:**
- `int invalidCoord`

### NullOwner_ShouldBeHandledGracefully_WhenOperationsRequireOwner

```csharp
[Fact]
    public void NullOwner_ShouldBeHandledGracefully_WhenOperationsRequireOwner()
    {
        // Arrange
        var context = new GBOwnerContext(); // No owner set

        // Act & Assert - Behavior verification
        // Operations that don't require owner should work
        Should.NotThrow(() => context.SetMode(BuildingMode.Build));
        context.GetCurrentMode().ShouldBe(BuildingMode.Build);

        // Operations that require owner should fail gracefully
        Should.Throw<InvalidOperationException>(() => context.RequestOwnerAction());
    }
```

**Returns:** `void`

### ModeTransition_ShouldBeFast_WhenCalledRepeatedly

```csharp
#endregion

    #region Performance Behavior Tests

    [Fact]
    public void ModeTransition_ShouldBeFast_WhenCalledRepeatedly()
    {
        // Arrange
        var context = new GBOwnerContext();
        const int iterations = 1000;
        var modes = new[] { BuildingMode.Build, BuildingMode.Move, BuildingMode.Demolish };

        // Act
        var startTime = DateTime.UtcNow;
        
        for (int i = 0; i < iterations; i++)
        {
            var mode = modes[i % modes.Length];
            context.SetMode(mode);
        }
        
        var endTime = DateTime.UtcNow;
        var duration = endTime - startTime;

        // Assert - Behavior verification: Performance should be acceptable
        duration.TotalMilliseconds.ShouldBeLessThan(100, "Mode transitions should be fast (< 100ms for 1000 operations)");
    }
```

**Returns:** `void`

### MemoryUsage_ShouldRemainStable_WhenCreatingManyContexts

```csharp
[Fact]
    public void MemoryUsage_ShouldRemainStable_WhenCreatingManyContexts()
    {
        // Arrange
        const int contextCount = 100;
        var contexts = new List<GBOwnerContext>();

        // Act
        var initialMemory = GC.GetTotalMemory(true);
        
        for (int i = 0; i < contextCount; i++)
        {
            var context = new GBOwnerContext(new MockGBOwner());
            context.SetMode(BuildingMode.Build);
            context.SetGridPosition(new Vector2(i, i));
            contexts.Add(context);
        }
        
        var afterCreationMemory = GC.GetTotalMemory(true);
        
        // Cleanup
        contexts.Clear();
        GC.Collect();
        GC.WaitForPendingFinalizers();
        var afterCleanupMemory = GC.GetTotalMemory(true);

        // Assert - Behavior verification: Memory should be managed properly
        var memoryIncrease = afterCreationMemory - initialMemory;
        var memoryPerContext = memoryIncrease / contextCount;
        
        memoryPerContext.ShouldBeLessThan(1024, "Each context should use less than 1KB");
        
        // Most memory should be recovered after cleanup
        var recoveredMemory = afterCreationMemory - afterCleanupMemory;
        (recoveredMemory > memoryIncrease * 0.8).ShouldBeTrue("Should recover at least 80% of memory");
    }
```

**Returns:** `void`

### ConcurrentModeChanges_ShouldBeThreadSafe_WhenMultipleThreadsOperate

```csharp
#endregion

    #region Thread Safety Behavior Tests

    [Fact]
    public void ConcurrentModeChanges_ShouldBeThreadSafe_WhenMultipleThreadsOperate()
    {
        // Arrange
        var context = new GBOwnerContext();
        const int threadCount = 10;
        const int operationsPerThread = 100;
        var tasks = new List<Task>();
        var exceptions = new List<Exception>();
        var lockObject = new object();

        // Act
        for (int t = 0; t < threadCount; t++)
        {
            var threadId = t;
            var task = Task.Run(() =>
            {
                try
                {
                    for (int i = 0; i < operationsPerThread; i++)
                    {
                        var mode = (BuildingMode)((i % 4) + 1); // Skip Off (0)
                        context.SetMode(mode);
                        
                        // Small delay to increase chance of race conditions
                        Thread.Sleep(1);
                    }
                }
                catch (Exception ex)
                {
                    lock (lockObject)
                    {
                        exceptions.Add(ex);
                    }
                }
            });
            tasks.Add(task);
        }

        Task.WaitAll(tasks.ToArray());

        // Assert - Behavior verification: Should be thread-safe
        exceptions.ShouldBeEmpty("No exceptions should occur during concurrent operations");
        context.GetCurrentMode().ShouldBeOneOf(
            BuildingMode.Build, BuildingMode.Move, BuildingMode.Demolish, BuildingMode.Info);
    }
```

**Returns:** `void`

### CompleteWorkflow_ShouldWorkCorrectly_FromStartToFinish

```csharp
#endregion

    #region Integration Behavior Tests

    [Fact]
    public void CompleteWorkflow_ShouldWorkCorrectly_FromStartToFinish()
    {
        // Arrange
        var owner = new MockGBOwner();
        var context = new GBOwnerContext(owner);
        var workflowSteps = new List<(string name, Action<GBOwnerContext> action, Func<GBOwnerContext, bool> validator)>();

        // Define complete workflow
        workflowSteps.Add(("Initialize", ctx => ctx.SetMode(BuildingMode.Info), 
                         ctx => ctx.GetCurrentMode() == BuildingMode.Info));
        
        workflowSteps.Add(("Position Grid", ctx => ctx.SetGridPosition(new Vector2(10, 15)), 
                         ctx => ctx.GetGridPosition() == new Vector2(10, 15)));
        
        workflowSteps.Add(("Enable Targeting", ctx => ctx.SetTargetingEnabled(true), 
                         ctx => ctx.IsTargetingEnabled()));
        
        workflowSteps.Add(("Switch to Build", ctx => ctx.SetMode(BuildingMode.Build), 
                         ctx => ctx.GetCurrentMode() == BuildingMode.Build));
        
        workflowSteps.Add(("Move Position", ctx => ctx.SetGridPosition(new Vector2(20, 25)), 
                         ctx => ctx.GetGridPosition() == new Vector2(20, 25)));
        
        workflowSteps.Add(("Switch to Move", ctx => ctx.SetMode(BuildingMode.Move), 
                         ctx => ctx.GetCurrentMode() == BuildingMode.Move));
        
        workflowSteps.Add(("Disable Targeting", ctx => ctx.SetTargetingEnabled(false), 
                         ctx => !ctx.IsTargetingEnabled()));
        
        workflowSteps.Add(("Reset to Off", ctx => ctx.SetMode(BuildingMode.Off), 
                         ctx => ctx.GetCurrentMode() == BuildingMode.Off));

        // Act - Execute complete workflow
        foreach (var (name, action, validator) in workflowSteps)
        {
            action(context);
            
            // Assert - Behavior verification: Each step should work correctly
            validator(context).ShouldBeTrue($"Workflow step '{name}' should complete successfully");
        }

        // Final verification - System should be in expected final state
        context.GetCurrentMode().ShouldBe(BuildingMode.Off);
        context.GetGridPosition().ShouldBe(new Vector2(20, 25));
        context.IsTargetingEnabled().ShouldBeFalse();
        context.GetOwner().ShouldBe(owner);
    }
```

**Returns:** `void`

