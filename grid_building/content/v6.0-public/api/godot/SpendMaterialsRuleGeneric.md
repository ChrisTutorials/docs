---
title: "SpendMaterialsRuleGeneric"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/spendmaterialsrulegeneric/"
---

# SpendMaterialsRuleGeneric

```csharp
GridBuilding.Godot.Systems.Placement.Validators
class SpendMaterialsRuleGeneric
{
    // Members...
}
```

Generic material spending rule for placement validation.
Allows custom resource classes without building system inventory dependencies. Expects resource stacks with type and count properties. Looks for _mat_container on the target building node.
Required inventory methods:
• TryAdd or Add - Parameters: type: Resource, count: int
• TryRemove or Remove - Parameters: type: Resource, count: int
• GetCount - Parameters: type: Resource - Returns: int
Alternative: inherit from VirtualItemContainer and implement the methods.
Ported from: godot/addons/grid_building/systems/placement/validators/placement_rules/template_rules/spend_materials_rule_generic.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Placement/Validators/SpendMaterialsRuleGeneric.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Placement.Validators`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ResourceStacksToSpend

```csharp
#region Exported Properties

    /// <summary>
    /// How many of each type need to be spent for the building rule to pass.
    /// Resource should have fields type and count defined.
    /// </summary>
    public Array<ResourceStack> ResourceStacksToSpend { get; set; } = new();
```

How many of each type need to be spent for the building rule to pass.
Resource should have fields type and count defined.

### Locator

```csharp
/// <summary>
    /// Used to find the inventory on the OwnerRoot passed in as a setup parameter
    /// so that the rule knows where to spend the ResourceStacksToSpend from.
    /// </summary>
    [Export]
    public NodeLocator? Locator { get; set; }
```

Used to find the inventory on the OwnerRoot passed in as a setup parameter
so that the rule knows where to spend the ResourceStacksToSpend from.


## Methods

### Setup

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Setup the rule with the provided GridTargetingState.
    /// </summary>
    /// <param name="gts">The targeting state to use for placement</param>
    /// <returns>Array of issues found during setup</returns>
    public override Array<string> Setup(GridTargetingState gts)
    {
        _ownerRoot = gts.GetOwnerRoot();
        _matContainer = GetMaterialContainerFromUser(_ownerRoot);
        
        // Delegate to base PlacementRule.setup to initialize common state
        return base.Setup(gts);
    }
```

Setup the rule with the provided GridTargetingState.

**Returns:** `Array<string>`

**Parameters:**
- `GridTargetingState gts`

### Apply

```csharp
/// <summary>
    /// Tries to spend the resources from the _mat_container.
    /// Returns an array of issues found during the spending process.
    /// If the spending was successful, the array will be empty.
    /// </summary>
    /// <returns>Array of issues found during spending</returns>
    public override Array<string> Apply()
    {
        var issues = new Array<string>();
        var spentStacks = new Array<ResourceStack>();
        var success = true;

        if (_matContainer == null)
        {
            issues.Add("No _mat_container found. Cannot spend resources from it.");
            return issues;
        }

        // Find the corresponding material type key and subtract the count from the material container
        foreach (var material in ResourceStacksToSpend)
        {
            ResourceStack? spentStack = null;
            var spent = 0;

            if (_matContainer.HasMethod("try_remove"))
            {
                spent = (int)_matContainer.Call("try_remove", material.Type, material.Count);
            }
            else if (_matContainer.HasMethod("remove"))
            {
                spent = (int)_matContainer.Call("remove", material.Type, material.Count);
            }
            else
            {
                issues.Add("SpendMaterialsRuleGeneric cannot spend resources from _mat_container. Expected it to have try_remove or remove methods.");
                success = false;
                return issues;
            }

            if (spent > 0)
            {
                spentStack = new ResourceStack(material.Type, spent);
                spentStacks.Add(spentStack);
            }

            if (spent != material.Count)
            {
                issues.Add($"Expected to spend {material.Count} of type [{material.Type?.ResourcePath}] but actually spent {spent}");
                success = false;
                return issues;
            }
        }

        return issues;
    }
```

Tries to spend the resources from the _mat_container.
Returns an array of issues found during the spending process.
If the spending was successful, the array will be empty.

**Returns:** `Array<string>`

### TearDown

```csharp
/// <summary>
    /// Tears down the rule, cleaning up state.
    /// </summary>
    public override void TearDown()
    {
        // No specific cleanup needed for this rule
        base.TearDown();
    }
```

Tears down the rule, cleaning up state.

**Returns:** `void`

### ValidatePlacement

```csharp
/// <summary>
    /// Checks to see if there are enough resources to build item.
    /// </summary>
    /// <returns>RuleResult indicating validation outcome</returns>
    public override RuleResult ValidatePlacement()
    {
        // Find the resource owning script and get the resource count for each type
        // needed. Verify that each type has at least the count requested. If
        // any resource is not sufficient, return false
        var missingResourceStacks = CheckMissingResources(_matContainer);

        if (missingResourceStacks.Count > 0)
        {
            var failedMessage = "Not Enough Materials:";

            // Needs to set resource names for them to show up in the string
            foreach (var missingStack in missingResourceStacks)
            {
                if (missingStack.Type == null)
                {
                    GD.PrintErr($"Missing a null resource type of count {missingStack.Count} at {missingStack.ResourcePath}");
                    continue;
                }

                // Try to find display_name property, else default back to resource name for display
                var materialName = GetMaterialName(missingStack.Type);

                failedMessage += "\n" + materialName + " : " + missingStack.Count;
            }

            return RuleResult.Build(this, new Array<string> { failedMessage });
        }
        else
        {
            return RuleResult.Build(this, new Array<string>());
        }
    }
```

Checks to see if there are enough resources to build item.

**Returns:** `RuleResult`

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation.
    /// </summary>
    /// <returns>Array of editor validation issues</returns>
    public override Array<string> GetEditorIssues()
    {
        var issues = base.GetEditorIssues();
        issues.AppendArray(GetPreSetupIssues(null!));
        return issues;
    }
```

Returns an array of issues found during editor validation.

**Returns:** `Array<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation.
    /// </summary>
    /// <returns>Array of runtime validation issues</returns>
    public override Array<string> GetRuntimeIssues()
    {
        var issues = base.GetRuntimeIssues();
        issues.AppendArray(GetPreSetupIssues(null!));
        issues.AppendArray(GetPostSetupIssues());
        return issues;
    }
```

Returns an array of issues found during runtime validation.

**Returns:** `Array<string>`

