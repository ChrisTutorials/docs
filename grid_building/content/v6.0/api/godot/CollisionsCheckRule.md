---
title: "CollisionsCheckRule"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/collisionscheckrule/"
---

# CollisionsCheckRule

```csharp
GridBuilding.Godot.Systems.Placement.Validators
class CollisionsCheckRule
{
    // Members...
}
```

Rule that validates placement based on collision detection.
This rule checks for physics collisions at indicator positions and validates based on
the PassOnCollision setting:
- false (default): Placement FAILS if collision detected ("must have clear space")
- true: Placement FAILS if NO collision detected ("must overlap with existing objects")
Common use cases:
- false: Building placement (needs empty space)
- true: Attachment mechanics (must connect to existing structures)
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/template_rules/collisions_check_rule.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Validators/CollisionsCheckRule.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Validators`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PassOnCollision

```csharp
#region Exported Properties

    /// <summary>
    /// Controls collision validation behavior:
    /// - false: Rule PASSES when no collision (placement requires clear space)
    /// - true: Rule PASSES when collision detected (placement requires overlap)
    /// </summary>
    [Export]
    public bool PassOnCollision { get; set; } = false;
```

Controls collision validation behavior:
- false: Rule PASSES when no collision (placement requires clear space)
- true: Rule PASSES when collision detected (placement requires overlap)

### CollisionMask

```csharp
/// <summary>
    /// Physics layers to scan for collisions.
    /// </summary>
    [Export]
    public uint CollisionMask { get; set; } = 1;
```

Physics layers to scan for collisions.

### Messages

```csharp
/// <summary>
    /// Modular message configuration resource.
    /// </summary>
    public CollisionRuleSettings? Messages { get; set; }
```

Modular message configuration resource.


## Methods

### Setup

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Setup the rule with the provided GridTargetingState.
    /// Returns an array of issues found during setup.
    /// </summary>
    /// <param name="gts">The targeting state to use for placement</param>
    /// <returns>Array of issues found during setup</returns>
    public override Array<string> Setup(GridTargetingState gts)
    {
        _ruleCheckLayerNames = PhysicsMatchingUtils2D.GetPhysicsLayerNamesFromMask(CollisionMask);
        
        // Delegate to PlacementRule.setup to initialize _grid_targeting_state and _ready.
        var issues = base.Setup(gts);

        // Connect to targeting state changes for cleanup
        if (GridTargetingState != null)
        {
            if (!GridTargetingState.IsTargetChangedConnected(OnTargetChanged))
            {
                GridTargetingState.TargetChanged += OnTargetChanged;
            }
        }

        IsReady = true;
        return issues;
    }
```

Setup the rule with the provided GridTargetingState.
Returns an array of issues found during setup.

**Returns:** `Array<string>`

**Parameters:**
- `GridTargetingState gts`

### ValidatePlacement

```csharp
/// <summary>
    /// Validates placement by checking collisions on all provided indicators.
    /// Returns a RuleResult with success/failure and messages.
    /// </summary>
    /// <returns>RuleResult indicating validation outcome</returns>
    public override RuleResult ValidatePlacement()
    {
        if (Indicators.Count == 0)
        {
            return RuleResult.Build(this, new Array<string> { Messages?.NoIndicatorsMessage ?? "No indicators available" });
        }

        var issueMessage = "";
        var reasonMessage = "";
        
        // Compute failing indicators once so we can report a concise count
        var failingIndicators = GetFailingIndicators(Indicators);
        var failingCount = failingIndicators.Count;
        var isSuccessful = failingCount == 0;

        if (isSuccessful)
        {
            reasonMessage = Messages?.SuccessReason ?? "Validation passed";
        }
        else
        {
            reasonMessage = Messages?.FailureReason ?? "Validation failed";

            // Build detailed issue message
            if (Messages?.PrependResourceName == true)
            {
                issueMessage += ResourceName + ": ";
            }

            // Concise failure summary with number of failing indicators
            // When PassOnCollision is true, failing means no collision where one was expected
            // When PassOnCollision is false, failing means a collision was detected where none was expected
            if (PassOnCollision)
            {
                // Avoid % formatting to prevent mismatched placeholder runtime errors
                var failMessage = Messages?.FailMissingOverlapMessage ?? "Missing overlap at %d positions";
                if (failMessage.Contains("%d"))
                {
                    issueMessage += failMessage.Replace("%d", failingCount.ToString());
                }
                else
                {
                    issueMessage += failMessage + " (" + failingCount + ")";
                }
            }
            else
            {
                var failMessage = Messages?.FailBlockedMessage ?? "Blocked at %d positions";
                if (failMessage.Contains("%d"))
                {
                    issueMessage += failMessage.Replace("%d", failingCount.ToString());
                }
                else
                {
                    issueMessage += failMessage + " (" + failingCount + ")";
                }
            }

            if (Messages?.AppendLayerNames == true)
            {
                issueMessage += "\n" + (Messages?.LayersTestedPrefix ?? "Layers tested: ") + string.Join(", ", _ruleCheckLayerNames);
            }
        }

        var issues = isSuccessful ? 
            new Array<string>() : 
            new Array<string> { issueMessage };

        return RuleResult.Build(this, issues, reasonMessage);
    }
```

Validates placement by checking collisions on all provided indicators.
Returns a RuleResult with success/failure and messages.

**Returns:** `RuleResult`

### TearDown

```csharp
/// <summary>
    /// Tears down the rule, cleaning up connections and state.
    /// </summary>
    public override void TearDown()
    {
        // Disconnect from targeting state
        if (GridTargetingState != null)
        {
            if (GridTargetingState.IsTargetChangedConnected(OnTargetChanged))
            {
                GridTargetingState.TargetChanged -= OnTargetChanged;
            }
        }

        // Restore original collision layers for excluded objects
        RestoreExcludedLayers();

        base.TearDown();
    }
```

Tears down the rule, cleaning up connections and state.

**Returns:** `void`

