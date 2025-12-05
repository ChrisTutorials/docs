---
title: "TestReport"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/testreport/"
---

# TestReport

```csharp
GridBuilding.Godot.Tests.Inventory
class TestReport
{
    // Members...
}
```

Test report data structure for tracking results

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/InventoryTestRunner.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Inventory`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### TotalTests

```csharp
public int TotalTests => _results.Count;
```

### PassedTests

```csharp
public int PassedTests => _results.Count(r => r.Status == TestStatus.Passed);
```

### FailedTests

```csharp
public int FailedTests => _results.Count(r => r.Status == TestStatus.Failed);
```

### ErrorTests

```csharp
public int ErrorTests => _results.Count(r => r.Status == TestStatus.Error);
```

### SuccessRate

```csharp
public float SuccessRate => TotalTests > 0 ? (PassedTests * 100.0f) / TotalTests : 0.0f;
```

### TotalExecutionTime

```csharp
public long TotalExecutionTime 
        { 
            get => _totalExecutionTime; 
            set => _totalExecutionTime = value; 
        }
```


## Methods

### AddSuccess

```csharp
public void AddSuccess(string category, string testName)
        {
            _results.Add(new TestResult
            {
                Category = category,
                TestName = testName,
                Status = TestStatus.Passed,
                Timestamp = Time.GetUnixTimeFromSystem()
            });
        }
```

**Returns:** `void`

**Parameters:**
- `string category`
- `string testName`

### AddFailure

```csharp
public void AddFailure(string category, string testName, string errorMessage)
        {
            _results.Add(new TestResult
            {
                Category = category,
                TestName = testName,
                Status = TestStatus.Failed,
                ErrorMessage = errorMessage,
                Timestamp = Time.GetUnixTimeFromSystem()
            });
        }
```

**Returns:** `void`

**Parameters:**
- `string category`
- `string testName`
- `string errorMessage`

### AddError

```csharp
public void AddError(string category, string errorMessage)
        {
            _results.Add(new TestResult
            {
                Category = category,
                TestName = "System Error",
                Status = TestStatus.Error,
                ErrorMessage = errorMessage,
                Timestamp = Time.GetUnixTimeFromSystem()
            });
        }
```

**Returns:** `void`

**Parameters:**
- `string category`
- `string errorMessage`

### AddTestTime

```csharp
public void AddTestTime(string testName, long executionTime)
        {
            var result = _results.Find(r => r.TestName == testName);
            if (result != null)
            {
                result.ExecutionTime = executionTime;
            }
        }
```

**Returns:** `void`

**Parameters:**
- `string testName`
- `long executionTime`

### GetDetailedResults

```csharp
public Godot.Collections.Array GetDetailedResults()
        {
            var array = new Godot.Collections.Array();
            
            foreach (var result in _results)
            {
                array.Add(new Godot.Collections.Dictionary
                {
                    ["category"] = result.Category,
                    ["test_name"] = result.TestName,
                    ["status"] = result.Status.ToString(),
                    ["error_message"] = result.ErrorMessage ?? "",
                    ["execution_time_ms"] = result.ExecutionTime,
                    ["timestamp"] = result.Timestamp
                });
            }
            
            return array;
        }
```

**Returns:** `Godot.Collections.Array`

