---
title: "ContextsTest"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/contextstest/"
---

# ContextsTest

```csharp
GridBuilding.Godot.Tests.Core.Contexts
class ContextsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/ContextsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Constructor_NoLogger_CreatesValidContexts

```csharp
#endregion

    #region Constructor Tests

    [Fact]
    public void Constructor_NoLogger_CreatesValidContexts()
    {
        var contexts = new Contexts();

        contexts.Indicator.ShouldNotBeNull();
        contexts.Owner.ShouldNotBeNull();
        contexts.Systems.ShouldNotBeNull();
    }
```

**Returns:** `void`

### Constructor_WithLogger_CreatesValidContexts

```csharp
[Fact]
    public void Constructor_WithLogger_CreatesValidContexts()
    {
        var logger = new MockLogger();
        var contexts = new Contexts(logger);

        contexts.Indicator.ShouldNotBeNull();
        contexts.Owner.ShouldNotBeNull();
        contexts.Systems.ShouldNotBeNull();
    }
```

**Returns:** `void`

### GetRuntimeIssues_AllContextsValid_ReturnsEmptyList

```csharp
#endregion

    #region Runtime Validation Tests

    [Fact]
    public void GetRuntimeIssues_AllContextsValid_ReturnsEmptyList()
    {
        var contexts = new Contexts();

        var issues = contexts.GetRuntimeIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeValidation_AllContextsValid_ReturnsSuccess

```csharp
[Fact]
    public void GetRuntimeValidation_AllContextsValid_ReturnsSuccess()
    {
        var contexts = new Contexts();

        var result = contexts.GetRuntimeValidation();

        result.IsValid.ShouldBeTrue();
        result.Issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeIssues_WithRuntimeChecks_ValidatesAllContexts

```csharp
[Fact]
    public void GetRuntimeIssues_WithRuntimeChecks_ValidatesAllContexts()
    {
        var contexts = new Contexts();
        var checks = new MockRuntimeChecks
        {
            BuildingSystem = true,
            GridTargetingSystem = true,
            ManipulationSystem = true
        };

        var issues = contexts.GetRuntimeIssues(checks);

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetRuntimeValidation_WithRuntimeChecks_ValidatesAllContexts

```csharp
[Fact]
    public void GetRuntimeValidation_WithRuntimeChecks_ValidatesAllContexts()
    {
        var contexts = new Contexts();
        var checks = new MockRuntimeChecks
        {
            BuildingSystem = true,
            GridTargetingSystem = true,
            ManipulationSystem = true
        };

        var result = contexts.GetRuntimeValidation(checks);

        result.IsValid.ShouldBeTrue();
        result.Issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetEditorIssues_AllContextsValid_ReturnsEmptyList

```csharp
#endregion

    #region Editor Validation Tests

    [Fact]
    public void GetEditorIssues_AllContextsValid_ReturnsEmptyList()
    {
        var contexts = new Contexts();

        var issues = contexts.GetEditorIssues();

        issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### GetEditorValidation_AllContextsValid_ReturnsSuccess

```csharp
[Fact]
    public void GetEditorValidation_AllContextsValid_ReturnsSuccess()
    {
        var contexts = new Contexts();

        var result = contexts.GetEditorValidation();

        result.IsValid.ShouldBeTrue();
        result.Issues.ShouldBeEmpty();
    }
```

**Returns:** `void`

### IndicatorContext_IsValidType

```csharp
#endregion

    #region Context Property Tests

    [Fact]
    public void IndicatorContext_IsValidType()
    {
        var contexts = new Contexts();

        contexts.Indicator.ShouldBeOfType<IndicatorContext>();
    }
```

**Returns:** `void`

### OwnerContext_IsValidType

```csharp
[Fact]
    public void OwnerContext_IsValidType()
    {
        var contexts = new Contexts();

        contexts.Owner.ShouldBeOfType<OwnerContext>();
    }
```

**Returns:** `void`

### SystemsContext_IsValidType

```csharp
[Fact]
    public void SystemsContext_IsValidType()
    {
        var contexts = new Contexts();

        contexts.Systems.ShouldBeOfType<SystemsContext>();
    }
```

**Returns:** `void`

### GetRuntimeIssues_LegacyMethod_ReturnsSameAsNewMethod

```csharp
#endregion

    #region Legacy Compatibility Tests

    [Fact]
    public void GetRuntimeIssues_LegacyMethod_ReturnsSameAsNewMethod()
    {
        var contexts = new Contexts();

        var legacyIssues = contexts.GetRuntimeIssues();
        var newResult = contexts.GetRuntimeValidation();

        legacyIssues.ShouldBe(newResult.Issues);
    }
```

**Returns:** `void`

### GetEditorIssues_LegacyMethod_ReturnsSameAsNewMethod

```csharp
[Fact]
    public void GetEditorIssues_LegacyMethod_ReturnsSameAsNewMethod()
    {
        var contexts = new Contexts();

        var legacyIssues = contexts.GetEditorIssues();
        var newResult = contexts.GetEditorValidation();

        legacyIssues.ShouldBe(newResult.Issues);
    }
```

**Returns:** `void`

### Dispose_DisposesAllContexts

```csharp
#endregion

    #region Dispose Tests

    [Fact]
    public void Dispose_DisposesAllContexts()
    {
        var contexts = new Contexts();

        // Should not throw
        contexts.Dispose();

        // Multiple dispose should not throw
        contexts.Dispose();
    }
```

**Returns:** `void`

### Logger_SetAndGetLogger_WorksCorrectly

```csharp
#endregion

    #region Logger Tests

    [Fact]
    public void Logger_SetAndGetLogger_WorksCorrectly()
    {
        var contexts = new Contexts();
        var logger = new MockLogger();

        contexts.Logger = logger;
        contexts.Logger.ShouldBe(logger);
    }
```

**Returns:** `void`

