---
title: "CoreBasicTests"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/corebasictests/"
---

# CoreBasicTests

```csharp
GridBuilding.Godot.Tests.Unit.Core.Migration
class CoreBasicTests
{
    // Members...
}
```

Basic functionality tests (migrated from Core)

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Migration/CoreBasicTests.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Unit.Core.Migration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### TestBasicAssertion

```csharp
[Fact]
        public void TestBasicAssertion()
        {
            // Simple test to verify test framework is working
            Assert.True(true);
        }
```

**Returns:** `void`

### TestStringOperations

```csharp
[Fact]
        public void TestStringOperations()
        {
            // Test basic string operations
            var testString = "GridBuilding";
            Assert.Equal("GridBuilding", testString);
            Assert.StartsWith("Grid", testString);
            Assert.EndsWith("Building", testString);
        }
```

**Returns:** `void`

### TestMathOperations

```csharp
[Fact]
        public void TestMathOperations()
        {
            // Test basic math operations
            Assert.Equal(4, 2 + 2);
            Assert.Equal(6, 2 * 3);
            Assert.True(10 > 5);
        }
```

**Returns:** `void`

### TestCollections

```csharp
[Fact]
        public void TestCollections()
        {
            // Test basic collection operations
            var list = new System.Collections.Generic.List<string> { "a", "b", "c" };
            Assert.Equal(3, list.Count);
            Assert.Contains("b", list);
        }
```

**Returns:** `void`

