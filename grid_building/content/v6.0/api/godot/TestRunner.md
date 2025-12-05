---
title: "TestRunner"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/testrunner/"
---

# TestRunner

```csharp
GridBuilding.Godot.Tests.Unit.Core.Migration
class TestRunner
{
    // Members...
}
```

Simple test runner to verify integration functionality

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Migration/TestRunner.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Unit.Core.Migration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### TestBasicRunner

```csharp
[Fact]
        public void TestBasicRunner()
        {
            // Basic test to verify runner functionality
            Assert.True(true);
        }
```

**Returns:** `void`

### TestAsyncRunner

```csharp
[Fact]
        public async Task TestAsyncRunner()
        {
            // Simple async test
            await Task.Delay(10);
            Assert.True(true);
        }
```

**Returns:** `Task`

### TestRunnerNamespace

```csharp
[Fact]
        public void TestRunnerNamespace()
        {
            // Verify namespace is correct
            var runnerType = typeof(TestRunner);
            Assert.Equal("GridBuilding.Core.Tests.TestRunner", runnerType.FullName);
        }
```

**Returns:** `void`

