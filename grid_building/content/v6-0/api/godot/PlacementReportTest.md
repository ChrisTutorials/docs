---
title: "PlacementReportTest"
description: "Unit tests for placement validation report aggregation.
Tests how multiple rule results are combined and reported.
Ported from: godot/addons/grid_building/test/grid_building/systems/building/unit/validators/placement_report_unit_test.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/placementreporttest/"
---

# PlacementReportTest

```csharp
GridBuilding.Godot.Tests.Validation
class PlacementReportTest
{
    // Members...
}
```

Unit tests for placement validation report aggregation.
Tests how multiple rule results are combined and reported.
Ported from: godot/addons/grid_building/test/grid_building/systems/building/unit/validators/placement_report_unit_test.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Validation/PlacementReportTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### RuleResult_NewResult_IsEmpty

```csharp
#region RuleResult Tests

    [Fact]
    public void RuleResult_NewResult_IsEmpty()
    {
        var rule = new MockPlacementRule("TestRule");
        var result = new RuleResult(rule);
        
        result.IsSuccessful.ShouldBeTrue();
        result.GetIssues().ShouldBeEmpty();
    }
```

**Returns:** `void`

### RuleResult_WithIssues_IsNotSuccessful

```csharp
[Fact]
    public void RuleResult_WithIssues_IsNotSuccessful()
    {
        var rule = new MockPlacementRule("TestRule");
        var result = new RuleResult(rule);
        
        result.AddIssue("Collision detected");
        
        result.IsSuccessful.ShouldBeFalse();
        result.GetIssues().Count.ShouldBe(1);
    }
```

**Returns:** `void`

### RuleResult_MultipleIssues_AggregatesCorrectly

```csharp
[Fact]
    public void RuleResult_MultipleIssues_AggregatesCorrectly()
    {
        var rule = new MockPlacementRule("TestRule");
        var result = new RuleResult(rule);
        
        result.AddIssue("Issue 1");
        result.AddIssue("Issue 2");
        result.AddIssue("Issue 3");
        
        result.GetIssues().Count.ShouldBe(3);
        result.GetIssues().ShouldContain("Issue 1");
        result.GetIssues().ShouldContain("Issue 2");
        result.GetIssues().ShouldContain("Issue 3");
    }
```

**Returns:** `void`

### RuleResult_BuildFactory_CreatesCorrectResult

```csharp
[Fact]
    public void RuleResult_BuildFactory_CreatesCorrectResult()
    {
        var rule = new MockPlacementRule("TestRule");
        var issues = new List<string> { "Issue A", "Issue B" };
        
        var result = RuleResult.Build(rule, issues);
        
        result.Rule.ShouldBe(rule);
        result.GetIssues().Count.ShouldBe(2);
        result.IsSuccessful.ShouldBeFalse();
    }
```

**Returns:** `void`

### RuleResult_BuildWithNull_ThrowsException

```csharp
[Fact]
    public void RuleResult_BuildWithNull_ThrowsException()
    {
        Should.Throw<ArgumentNullException>(() => RuleResult.Build(null!, new List<string>()));
    }
```

**Returns:** `void`

### RuleResult_GetSummary_FormatsCorrectly

```csharp
[Fact]
    public void RuleResult_GetSummary_FormatsCorrectly()
    {
        var rule = new MockPlacementRule("CollisionRule");
        var result = new RuleResult(rule);
        
        result.GetSummary().ShouldBe("Rule 'CollisionRule': PASSED");
        
        result.AddIssue("Collision at (5,7)");
        result.GetSummary().ShouldBe("Rule 'CollisionRule': FAILED (1 issues)");
    }
```

**Returns:** `void`

### ValidationReport_Empty_IsSuccessful

```csharp
#endregion

    #region ValidationReport Tests

    [Fact]
    public void ValidationReport_Empty_IsSuccessful()
    {
        var report = new ValidationReport();
        
        report.IsSuccessful.ShouldBeTrue();
        report.GetAllIssues().ShouldBeEmpty();
    }
```

**Returns:** `void`

### ValidationReport_WithPassingRules_IsSuccessful

```csharp
[Fact]
    public void ValidationReport_WithPassingRules_IsSuccessful()
    {
        var report = new ValidationReport();
        var rule1 = new MockPlacementRule("Rule1");
        var rule2 = new MockPlacementRule("Rule2");
        
        report.AddRuleResult(new RuleResult(rule1));
        report.AddRuleResult(new RuleResult(rule2));
        
        report.IsSuccessful.ShouldBeTrue();
        report.HasFailingRules.ShouldBeFalse();
    }
```

**Returns:** `void`

### ValidationReport_WithFailingRule_IsNotSuccessful

```csharp
[Fact]
    public void ValidationReport_WithFailingRule_IsNotSuccessful()
    {
        var report = new ValidationReport();
        var rule = new MockPlacementRule("CollisionRule");
        var result = new RuleResult(rule);
        result.AddIssue("Collision detected");
        
        report.AddRuleResult(result);
        
        report.IsSuccessful.ShouldBeFalse();
        report.HasFailingRules.ShouldBeTrue();
        report.FailingRuleCount.ShouldBe(1);
    }
```

**Returns:** `void`

### ValidationReport_MixedResults_AggregatesCorrectly

```csharp
[Fact]
    public void ValidationReport_MixedResults_AggregatesCorrectly()
    {
        var report = new ValidationReport();
        
        // Passing rule
        var passingRule = new MockPlacementRule("PassingRule");
        report.AddRuleResult(new RuleResult(passingRule));
        
        // Failing rule 1
        var failingRule1 = new MockPlacementRule("FailingRule1");
        var failResult1 = new RuleResult(failingRule1);
        failResult1.AddIssue("Issue A");
        report.AddRuleResult(failResult1);
        
        // Failing rule 2
        var failingRule2 = new MockPlacementRule("FailingRule2");
        var failResult2 = new RuleResult(failingRule2);
        failResult2.AddIssue("Issue B");
        failResult2.AddIssue("Issue C");
        report.AddRuleResult(failResult2);
        
        report.IsSuccessful.ShouldBeFalse();
        report.TotalRuleCount.ShouldBe(3);
        report.PassingRuleCount.ShouldBe(1);
        report.FailingRuleCount.ShouldBe(2);
        report.GetAllIssues().Count.ShouldBe(3);
    }
```

**Returns:** `void`

### ValidationReport_GetFailingRuleNames_ReturnsOnlyFailing

```csharp
[Fact]
    public void ValidationReport_GetFailingRuleNames_ReturnsOnlyFailing()
    {
        var report = new ValidationReport();
        
        var passingRule = new MockPlacementRule("PassingRule");
        report.AddRuleResult(new RuleResult(passingRule));
        
        var failingRule = new MockPlacementRule("FailingRule");
        var failResult = new RuleResult(failingRule);
        failResult.AddIssue("Issue");
        report.AddRuleResult(failResult);
        
        var failingNames = report.GetFailingRuleNames();
        
        failingNames.Count.ShouldBe(1);
        failingNames.ShouldContain("FailingRule");
        failingNames.ShouldNotContain("PassingRule");
    }
```

**Returns:** `void`

### ValidationReport_OverwritingResult_UsesLatest

```csharp
#endregion

    #region Complex Aggregation Tests

    [Fact]
    public void ValidationReport_OverwritingResult_UsesLatest()
    {
        var report = new ValidationReport();
        var rule = new MockPlacementRule("TestRule");
        
        // First result has issues
        var failResult = new RuleResult(rule);
        failResult.AddIssue("Problem");
        report.AddRuleResult(failResult);
        report.IsSuccessful.ShouldBeFalse();
        
        // Overwrite with passing result
        var passResult = new RuleResult(rule);
        report.AddRuleResult(passResult);
        
        report.IsSuccessful.ShouldBeTrue();
    }
```

**Returns:** `void`

### ValidationReport_GetSummary_FormatsComplete

```csharp
[Fact]
    public void ValidationReport_GetSummary_FormatsComplete()
    {
        var report = new ValidationReport();
        
        var rule1 = new MockPlacementRule("Rule1");
        report.AddRuleResult(new RuleResult(rule1));
        
        var rule2 = new MockPlacementRule("Rule2");
        var failResult = new RuleResult(rule2);
        failResult.AddIssue("Issue");
        report.AddRuleResult(failResult);
        
        var summary = report.GetSummary();
        
        summary.ShouldContain("2 rules evaluated");
        summary.ShouldContain("1 passed");
        summary.ShouldContain("1 failed");
    }
```

**Returns:** `void`

