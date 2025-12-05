---
title: "ValidationResultsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/validationresultstest/"
---

# ValidationResultsTest

```csharp
GridBuilding.Godot.Tests.Core.Validation
class ValidationResultsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Validation/ValidationResultsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### RuleResult_Constructor_SetsRule

```csharp
#endregion

    #region RuleResult Tests

    [Fact]
    public void RuleResult_Constructor_SetsRule()
    {
        var rule = new MockPlacementRule { Name = "TestRule" };

        var result = new RuleResult(rule);

        result.Rule.ShouldBe(rule);
    }
```

**Returns:** `void`

### RuleResult_Constructor_ThrowsOnNullRule

```csharp
[Fact]
    public void RuleResult_Constructor_ThrowsOnNullRule()
    {
        Should.Throw<ArgumentNullException>(() => new RuleResult(null!));
    }
```

**Returns:** `void`

### RuleResult_NewResult_HasNoIssues

```csharp
[Fact]
    public void RuleResult_NewResult_HasNoIssues()
    {
        var rule = new MockPlacementRule();
        var result = new RuleResult(rule);

        result.GetIssues().ShouldBeEmpty();
        result.IsSuccessful.ShouldBeTrue();
    }
```

**Returns:** `void`

### RuleResult_AddIssue_AddsIssue

```csharp
[Fact]
    public void RuleResult_AddIssue_AddsIssue()
    {
        var rule = new MockPlacementRule();
        var result = new RuleResult(rule);

        result.AddIssue("Test issue");

        result.GetIssues().ShouldContain("Test issue");
        result.IsSuccessful.ShouldBeFalse();
    }
```

**Returns:** `void`

### RuleResult_AddIssues_AddsMultipleIssues

```csharp
[Fact]
    public void RuleResult_AddIssues_AddsMultipleIssues()
    {
        var rule = new MockPlacementRule();
        var result = new RuleResult(rule);

        result.AddIssues(new[] { "Issue 1", "Issue 2", "Issue 3" });

        result.GetIssues().Count.ShouldBe(3);
    }
```

**Returns:** `void`

### RuleResult_Build_CreatesWithIssues

```csharp
[Fact]
    public void RuleResult_Build_CreatesWithIssues()
    {
        var rule = new MockPlacementRule();
        var issues = new[] { "Issue 1", "Issue 2" };

        var result = RuleResult.Build(rule, issues);

        result.GetIssues().Count.ShouldBe(2);
        result.IsSuccessful.ShouldBeFalse();
    }
```

**Returns:** `void`

### RuleResult_GetSummary_ShowsPassedForSuccess

```csharp
[Fact]
    public void RuleResult_GetSummary_ShowsPassedForSuccess()
    {
        var rule = new MockPlacementRule { Name = "MyRule" };
        var result = new RuleResult(rule);

        var summary = result.GetSummary();

        summary.ShouldContain("MyRule");
        summary.ShouldContain("PASSED");
    }
```

**Returns:** `void`

### RuleResult_GetSummary_ShowsFailedWithCount

```csharp
[Fact]
    public void RuleResult_GetSummary_ShowsFailedWithCount()
    {
        var rule = new MockPlacementRule { Name = "MyRule" };
        var result = new RuleResult(rule);
        result.AddIssue("Issue 1");
        result.AddIssue("Issue 2");

        var summary = result.GetSummary();

        summary.ShouldContain("MyRule");
        summary.ShouldContain("FAILED");
        summary.ShouldContain("2 issues");
    }
```

**Returns:** `void`

### PlacementValidationResults_NewResult_IsSuccessful

```csharp
#endregion

    #region PlacementValidationResults Constructor Tests

    [Fact]
    public void PlacementValidationResults_NewResult_IsSuccessful()
    {
        var results = new PlacementValidationResults();

        results.IsSuccessful.ShouldBeTrue();
    }
```

**Returns:** `void`

### PlacementValidationResults_NewResult_HasEmptyMessage

```csharp
[Fact]
    public void PlacementValidationResults_NewResult_HasEmptyMessage()
    {
        var results = new PlacementValidationResults();

        results.Message.ShouldBeEmpty();
    }
```

**Returns:** `void`

### AddRuleResult_WithPassingRule_AddsToSuccessful

```csharp
#endregion

    #region AddRuleResult Tests

    [Fact]
    public void AddRuleResult_WithPassingRule_AddsToSuccessful()
    {
        var results = new PlacementValidationResults();
        var rule = new MockPlacementRule();
        var ruleResult = new RuleResult(rule);

        results.AddRuleResult(rule, ruleResult);

        results.GetSuccessfulRules().ShouldContain(rule);
    }
```

**Returns:** `void`

### AddRuleResult_WithFailingRule_AddsToFailing

```csharp
[Fact]
    public void AddRuleResult_WithFailingRule_AddsToFailing()
    {
        var results = new PlacementValidationResults();
        var rule = new MockPlacementRule();
        var ruleResult = new RuleResult(rule);
        ruleResult.AddIssue("Failed check");

        results.AddRuleResult(rule, ruleResult);

        results.GetFailingRules().ShouldContain(rule);
    }
```

**Returns:** `void`

### AddRuleResult_NullResult_Throws

```csharp
[Fact]
    public void AddRuleResult_NullResult_Throws()
    {
        var results = new PlacementValidationResults();
        var rule = new MockPlacementRule();

        Should.Throw<ArgumentNullException>(() => results.AddRuleResult(rule, null!));
    }
```

**Returns:** `void`

### IsSuccessful_WithNoRulesOrErrors_ReturnsTrue

```csharp
#endregion

    #region IsSuccessful Tests

    [Fact]
    public void IsSuccessful_WithNoRulesOrErrors_ReturnsTrue()
    {
        var results = new PlacementValidationResults();

        results.IsSuccessful.ShouldBeTrue();
    }
```

**Returns:** `void`

### IsSuccessful_WithOnlyPassingRules_ReturnsTrue

```csharp
[Fact]
    public void IsSuccessful_WithOnlyPassingRules_ReturnsTrue()
    {
        var results = new PlacementValidationResults();
        var rule = new MockPlacementRule();
        results.AddRuleResult(rule, new RuleResult(rule));

        results.IsSuccessful.ShouldBeTrue();
    }
```

**Returns:** `void`

### IsSuccessful_WithFailingRule_ReturnsFalse

```csharp
[Fact]
    public void IsSuccessful_WithFailingRule_ReturnsFalse()
    {
        var results = new PlacementValidationResults();
        var rule = new MockPlacementRule();
        var ruleResult = new RuleResult(rule);
        ruleResult.AddIssue("Failure");
        results.AddRuleResult(rule, ruleResult);

        results.IsSuccessful.ShouldBeFalse();
    }
```

**Returns:** `void`

### IsSuccessful_WithError_ReturnsFalse

```csharp
[Fact]
    public void IsSuccessful_WithError_ReturnsFalse()
    {
        var results = new PlacementValidationResults();
        results.AddError("Configuration error");

        results.IsSuccessful.ShouldBeFalse();
    }
```

**Returns:** `void`

### GetIssues_CollectsFromAllRules

```csharp
#endregion

    #region GetIssues Tests

    [Fact]
    public void GetIssues_CollectsFromAllRules()
    {
        var results = new PlacementValidationResults();
        
        var rule1 = new MockPlacementRule { Name = "Rule1" };
        var result1 = new RuleResult(rule1);
        result1.AddIssue("Issue from Rule1");
        
        var rule2 = new MockPlacementRule { Name = "Rule2" };
        var result2 = new RuleResult(rule2);
        result2.AddIssue("Issue from Rule2");
        
        results.AddRuleResult(rule1, result1);
        results.AddRuleResult(rule2, result2);

        var issues = results.GetIssues();

        issues.Count.ShouldBe(2);
        issues.ShouldContain("Issue from Rule1");
        issues.ShouldContain("Issue from Rule2");
    }
```

**Returns:** `void`

### AddError_AddsToErrors

```csharp
#endregion

    #region Error Handling Tests

    [Fact]
    public void AddError_AddsToErrors()
    {
        var results = new PlacementValidationResults();

        results.AddError("Config error");

        results.GetErrors().ShouldContain("Config error");
    }
```

**Returns:** `void`

### HasErrors_WithErrors_ReturnsTrue

```csharp
[Fact]
    public void HasErrors_WithErrors_ReturnsTrue()
    {
        var results = new PlacementValidationResults();
        results.AddError("Error");

        results.HasErrors().ShouldBeTrue();
    }
```

**Returns:** `void`

### HasErrors_WithoutErrors_ReturnsFalse

```csharp
[Fact]
    public void HasErrors_WithoutErrors_ReturnsFalse()
    {
        var results = new PlacementValidationResults();

        results.HasErrors().ShouldBeFalse();
    }
```

**Returns:** `void`

### GetFailingRuleResults_ReturnsOnlyFailingRulesWithIssues

```csharp
#endregion

    #region GetFailingRuleResults Tests

    [Fact]
    public void GetFailingRuleResults_ReturnsOnlyFailingRulesWithIssues()
    {
        var results = new PlacementValidationResults();
        
        var passingRule = new MockPlacementRule { Name = "Passing" };
        results.AddRuleResult(passingRule, new RuleResult(passingRule));
        
        var failingRule = new MockPlacementRule { Name = "Failing" };
        var failingResult = new RuleResult(failingRule);
        failingResult.AddIssue("Failure reason");
        results.AddRuleResult(failingRule, failingResult);

        var failing = results.GetFailingRuleResults();

        failing.Count.ShouldBe(1);
        failing.ShouldContainKey(failingRule);
        failing[failingRule].ShouldContain("Failure reason");
    }
```

**Returns:** `void`

### GetSummaryString_WhenSuccessful_ShowsPassed

```csharp
#endregion

    #region GetSummaryString Tests

    [Fact]
    public void GetSummaryString_WhenSuccessful_ShowsPassed()
    {
        var results = new PlacementValidationResults();
        var rule = new MockPlacementRule();
        results.AddRuleResult(rule, new RuleResult(rule));

        var summary = results.GetSummaryString();

        summary.ShouldContain("PASSED");
        summary.ShouldContain("1 rules passed");
    }
```

**Returns:** `void`

### GetSummaryString_WhenFailed_ShowsFailedWithCounts

```csharp
[Fact]
    public void GetSummaryString_WhenFailed_ShowsFailedWithCounts()
    {
        var results = new PlacementValidationResults();
        
        var passingRule = new MockPlacementRule { Name = "Pass" };
        results.AddRuleResult(passingRule, new RuleResult(passingRule));
        
        var failingRule = new MockPlacementRule { Name = "Fail" };
        var failingResult = new RuleResult(failingRule);
        failingResult.AddIssue("Failed");
        results.AddRuleResult(failingRule, failingResult);
        
        results.AddError("Config error");

        var summary = results.GetSummaryString();

        summary.ShouldContain("FAILED");
        summary.ShouldContain("1 passed");
        summary.ShouldContain("1 failed");
        summary.ShouldContain("1 errors");
    }
```

**Returns:** `void`

### FullValidationWorkflow_MultipleRules

```csharp
#endregion

    #region Integration Tests

    [Fact]
    public void FullValidationWorkflow_MultipleRules()
    {
        // Arrange
        var results = new PlacementValidationResults();
        results.Message = "Building validation";

        var rules = new[]
        {
            new MockPlacementRule { Name = "BoundsCheck" },
            new MockPlacementRule { Name = "CollisionCheck" },
            new MockPlacementRule { Name = "OverlapCheck" }
        };

        // Act - Simulate validation
        // Rule 1 passes
        results.AddRuleResult(rules[0], new RuleResult(rules[0]));

        // Rule 2 fails
        var result2 = new RuleResult(rules[1]);
        result2.AddIssue("Collision detected at (5, 10)");
        results.AddRuleResult(rules[1], result2);

        // Rule 3 passes
        results.AddRuleResult(rules[2], new RuleResult(rules[2]));

        // Assert
        results.IsSuccessful.ShouldBeFalse();
        results.GetSuccessfulRules().Count.ShouldBe(2);
        results.GetFailingRules().Count.ShouldBe(1);
        results.GetFailingRules()[0].Name.ShouldBe("CollisionCheck");
    }
```

**Returns:** `void`

