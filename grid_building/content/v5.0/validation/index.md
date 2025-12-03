---
title: Validation Tools
description: Tools and patterns for validating placement, configuration, and runtime state
---


---

This page outlines validation utilities and patterns used across the plugin.

## Automatic Configuration Validation

**New in v5.0.0:** [GBInjectorSystem](../api/GBInjectorSystem/) automatically validates configuration after dependency injection completes. **No manual validation calls are required.**

### How It Works

1. **GBInjectorSystem** completes dependency injection for all nodes
2. **Automatic validation** runs deferred after `initial_injection_completed`  
3. **Configuration issues** are automatically logged if found
4. **Developers receive feedback** without manual setup

### Benefits

- **Zero Setup**: Validation happens automatically
- **Error Prevention**: No possibility of forgetting validation calls
- **Proper Timing**: Validation occurs after all dependencies are wired
- **Consistent Behavior**: All Grid Building systems validate automatically

## Validation Contract

- validate() methods return a boolean (success/failure). When false, inspect issues collected via:
  - get_runtime_issues() in runtime
  - get_editor_issues() in editor
- Use [GBLogger](/v5-0/api/GBLogger/) to log actionable diagnostics during validation.

## Key components

- [PlacementValidator](../api/PlacementValidator/) — Orchestrates rule checks
- [RuleResult](../api/RuleResult/) — Captures per-rule outcomes
- [RuleCheckIndicator](../api/RuleCheckIndicator/) — Visualizes rule feedback

## Tips

- Keep rules stateless and fast; cache expensive lookups at the system level when needed.
- Prefer explicit settings resources (e.g., [ValidPlacementRuleSettings](/v5-0/api/ValidPlacementRuleSettings/)) to make validation predictable and testable.