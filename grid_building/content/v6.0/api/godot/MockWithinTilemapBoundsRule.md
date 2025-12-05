---
title: "MockWithinTilemapBoundsRule"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/mockwithintilemapboundsrule/"
---

# MockWithinTilemapBoundsRule

```csharp
GridBuilding.Godot.Tests.Placement
class MockWithinTilemapBoundsRule
{
    // Members...
}
```

Mock WithinTilemapBoundsRule for testing.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/WithinTilemapBoundsRuleTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetFailingIndicators

```csharp
// Expose protected methods for testing
        public new Godot.Collections.Array<RuleCheckIndicator> GetFailingIndicators(
            Godot.Collections.Array<RuleCheckIndicator> indicators) 
            => base.GetFailingIndicators(indicators);
```

**Returns:** `Godot.Collections.Array<RuleCheckIndicator>`

**Parameters:**
- `Godot.Collections.Array<RuleCheckIndicator> indicators`

### FilterCriticalIndicatorIssues

```csharp
public Godot.Collections.Array<string> FilterCriticalIndicatorIssues(
            Godot.Collections.Array<string> issues) 
            => base.FilterCriticalIndicatorIssues(issues);
```

**Returns:** `Godot.Collections.Array<string>`

**Parameters:**
- `Godot.Collections.Array<string> issues`

### IsCriticalIndicatorIssue

```csharp
public bool IsCriticalIndicatorIssue(string issue) 
            => base.IsCriticalIndicatorIssue(issue);
```

**Returns:** `bool`

**Parameters:**
- `string issue`

### DebugDiagnostic

```csharp
public void DebugDiagnostic(string message) 
            => base.DebugDiagnostic(message);
```

**Returns:** `void`

**Parameters:**
- `string message`

