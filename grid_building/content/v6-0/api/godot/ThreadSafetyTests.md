---
title: "ThreadSafetyTests"
description: "Thread safety tests for GridBuilding Core"
weight: 20
url: "/gridbuilding/v6-0/api/godot/threadsafetytests/"
---

# ThreadSafetyTests

```csharp
GridBuilding.Godot.Tests.Unit.Core.Migration
class ThreadSafetyTests
{
    // Members...
}
```

Thread safety tests for GridBuilding Core

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Migration/ThreadSafetyTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Unit.Core.Migration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### TestBasicConcurrency

```csharp
[Fact]
        public async Task TestBasicConcurrency()
        {
            // Simple concurrency test
            var tasks = new List<Task>();
            var counter = 0;
            
            for (int i = 0; i < 10; i++)
            {
                tasks.Add(Task.Run(() =>
                {
                    Interlocked.Increment(ref counter);
                }));
            }
            
            await Task.WhenAll(tasks);
            Assert.Equal(10, counter);
        }
```

**Returns:** `Task`

### TestThreadSafeIncrement

```csharp
[Fact]
        public void TestThreadSafeIncrement()
        {
            var counter = 0;
            Parallel.For(0, 100, i => Interlocked.Increment(ref counter));
            Assert.Equal(100, counter);
        }
```

**Returns:** `void`

### TestEventDispatcherExists

```csharp
[Fact]
        public void TestEventDispatcherExists()
        {
            // Test that EventDispatcher can be instantiated
            var dispatcher = EventDispatcher.Instance;
            Assert.NotNull(dispatcher);
        }
```

**Returns:** `void`

