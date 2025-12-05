---
title: "InventoryTestRunner"
description: "Test runner for GridBuilding Inventory cross-platform compatibility tests
Provides automated test execution and reporting for different platforms"
weight: 20
url: "/gridbuilding/v6-0/api/godot/inventorytestrunner/"
---

# InventoryTestRunner

```csharp
GridBuilding.Godot.Tests.Inventory
class InventoryTestRunner
{
    // Members...
}
```

Test runner for GridBuilding Inventory cross-platform compatibility tests
Provides automated test execution and reporting for different platforms

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/InventoryTestRunner.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Inventory`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### RunAllTests

```csharp
[Export]
        public bool RunAllTests { get; set; } = true;
```

### RunBasicTests

```csharp
[Export]
        public bool RunBasicTests { get; set; } = true;
```

### RunIntegrationTests

```csharp
[Export]
        public bool RunIntegrationTests { get; set; } = true;
```

### RunCrossPlatformTests

```csharp
[Export]
        public bool RunCrossPlatformTests { get; set; } = true;
```

### GenerateReport

```csharp
[Export]
        public bool GenerateReport { get; set; } = true;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            GD.Print("=== GridBuilding Inventory Cross-Platform Test Runner ===");
            GD.Print($"Platform: {OS.GetName()}");
            GD.Print($"Godot Version: {Engine.GetVersionInfo()}");
            GD.Print($"System Locale: {OS.GetLocale()}");
            GD.Print("");

            _testReport = new TestReport();
            
            if (RunAllTests)
            {
                RunTestSuite();
            }
        }
```

**Returns:** `void`

### RunManualTest

```csharp
/// <summary>
        /// Manual test execution for debugging
        /// </summary>
        public void RunManualTest(string testName)
        {
            GD.Print($"Running manual test: {testName}");
            
            var basicTest = new GridBuildingInventoryTest();
            var integrationTest = new InventoryCrossPlatformIntegrationTest();

            if (testName.StartsWith("Basic"))
            {
                RunSingleTest(basicTest, testName.Replace("Basic.", ""), "Basic Inventory");
            }
            else if (testName.StartsWith("Integration"))
            {
                RunSingleTest(integrationTest, testName.Replace("Integration.", ""), "Integration");
            }
            else if (testName.StartsWith("CrossPlatform"))
            {
                RunSingleTest(integrationTest, testName.Replace("CrossPlatform.", ""), "Cross-Platform");
            }
        }
```

Manual test execution for debugging

**Returns:** `void`

**Parameters:**
- `string testName`

