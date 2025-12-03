---
title: Dependency Injection System
description: Dependency Injection System documentation for the Grid Building system
---


---



The plugin includes a lightweight, opt‑in dependency injection (DI) mechanism that removes most manual wiring between gameplay nodes and the Grid Building systems. It centers around two core pieces:

1. [GBCompositionContainer](../api/GBCompositionContainer/) – A per-context (e.g., per player / world / session) resource that owns configured settings, templates, actions, states, contexts, and logging.
1. [GBInjectorSystem](../api/GBInjectorSystem/) – A scene system that discovers nodes needing dependencies and injects the shared [GBCompositionContainer](../api/GBCompositionContainer/) into them at runtime. **Automatically validates configuration after injection completion.**

______________________________________________________________________

## Automatic Validation

**GBInjectorSystem now handles validation automatically** - no manual validation calls required!

After dependency injection completes, the system automatically: 

1. **Validates configuration** using the composition container's validation methods
2. **Logs any issues** found during validation using the centralized GBLogger system
3. **Provides feedback** to developers if setup is incomplete
4. **Prevents silent failures** with comprehensive runtime issue detection

### Before (Manual Validation Required)

```gdscript
func _ready() -> void: 
    # Set up Grid Building systems...
    
    # GBInjectorSystem handles validation automatically ✅
    # No manual validation calls needed!
```

### After (Automatic Validation)

```gdscript  
func _ready() -> void: 
    # Set up Grid Building systems...
    
    # That's it! GBInjectorSystem automatically:
    # 1. Injects dependencies via resolve_gb_dependencies()
    # 2. Validates all components immediately after injection
    # 3. Logs any issues to the console with helpful context
```

### Benefits

- **Zero-Configuration Validation**: No manual validation calls needed
- **Error Prevention**: Impossible to forget validation - it happens automatically
- **Consistent Behavior**: All Grid Building setups validate the same way
- **Immediate Feedback**: Validation happens right after injection with full context
- **Cleaner Code**: No validation boilerplate cluttering your `_ready()` methods

### Automatic Validation System

The system validates all dependencies **immediately after injection**:

**What Gets Validated:**
- Configuration structure and resources exist
- Required templates and settings are present
- Game-specific dependencies (GBLevelContext, GBOwner) are available
- System interconnections are properly wired
- Component contracts are satisfied

**When Validation Happens:**
- **Automatically** when GBInjectorSystem completes dependency injection
- **No manual calls required** - validation is built into the injection process
- **Immediate error detection** - issues are caught right after injection with full context

**How It Works:**
```gdscript
# GBInjectorSystem automatically calls this on all nodes:
func resolve_gb_dependencies(container: GBCompositionContainer) -> void:
    _building_system = container.get_building_system()
    _logger = container.get_logger()
    # After injection, GBInjectorSystem automatically validates this component
    # by calling get_runtime_issues() and logging any problems

# You can still implement this for custom validation:
func get_runtime_issues() -> Array[String]:
    var issues: Array[String] = []
    if _building_system == null:
        issues.append("Building system not injected")
    return issues  # GBInjectorSystem will log these automatically
```

______________________________________________________________________

## Goals

- Centralize access to configuration, states, and contexts.
- Avoid deep node path lookups or duplicate singletons.
- Allow multiple independent grid building contexts to coexist (e.g., splitscreen players) by scoping injection roots.
- Support late / dynamic node creation without extra boilerplate.
- Provide consistent logging and validation gateways.
- **Automatically validate configuration after dependency injection**, eliminating manual setup errors.

______________________________________________________________________

## Opt‑In Contract

Any node that implements:

```gdscript
func resolve_gb_dependencies(p_config: GBCompositionContainer) -> void:
    # Pull what you need from p_config
    var logger := p_config.get_logger()
    var targeting_state := p_config.get_targeting_state()
```

…will automatically receive the active composition container when it enters an injection scope.

No interface registration is required—presence of the method name `resolve_gb_dependencies` is the marker.

______________________________________________________________________

## GBCompositionContainer Overview

[GBCompositionContainer](../api/GBCompositionContainer/) is the authoritative gateway to all major systems:

- Settings (`get_settings()`, `get_visual_settings()`, `get_manipulation_settings()`, `get_actions()`, `get_messages()`).
- Templates (`get_templates()`).
- Contexts (`get_contexts()`) and sub-context accessors like `get_systems_context()` or `get_indicator_context()`.
- Mutable runtime state holders (`get_states()` returning building / targeting / manipulation / mode states).
- Logging (`get_logger()`) – with graceful fallback when configuration is incomplete.
- Validation (`get_runtime_issues()`) - automatically called by GBInjectorSystem after dependency injection.

It lazy‑constructs internal components so that missing or partially configured resources can still emit structured warnings via the logger.

### Why a Resource?

Being a `Resource` allows cloning or per‑player instancing while keeping memory light and avoiding tight coupling to any scene tree node. It also simplifies tooling and export workflows.

### Central Configuration: GBConfig

[GBConfig](../api/GBConfig/) is the single authoritative configuration resource consumed by [GBCompositionContainer](../api/GBCompositionContainer/). It aggregates previously scattered exported fields (grid sizing, placement & validation toggles, indicator visuals, manipulation tuning, action/message resources, debug flags) into one asset.

Key aspects:

- Acts as the root object passed into composition; other sub-resources (settings, templates, messages) are referenced from it.
- Enables cloning per player/session by duplicating a single resource tree.
- Reduces risk of version skew (all tuning lives together, easier diff/merge in VCS).
- Validation runs against [GBConfig](../api/GBConfig/) via [GBConfigurationValidator](../api/GBConfigurationValidator/) before/after injection.
- Eliminates brittle node export wiring; systems retrieve needed values through container accessors which delegate to [GBConfig](../api/GBConfig/).

Minimal setup workflow:

1. Create a [GBConfig](../api/GBConfig/) resource (e.g., `res://config/grid_building_config.tres`).
1. Populate its sub-sections (grid settings, visual settings, manipulation, actions/messages, templates references).
1. Assign the resource to a [GBCompositionContainer](../api/GBCompositionContainer/) (inspector or factory method).
1. Provide that container to [GBInjectorSystem](../api/GBInjectorSystem/).

Benefits vs scattered exports:

| Previous Pattern (4.x)                      | Centralized in 5.0.0 ([GBConfig](../api/GBConfig/))        | Outcome                                 |
| ------------------------------------------- | ---------------------------------------- | --------------------------------------- |
| Dozens of per-system exported tuning fields | Single resource with structured sections | Faster onboarding & consistent defaults |
| Hard to validate completeness               | Validator can traverse one tree          | Early warning & logging                 |
| Duplicate tweaks across multiple scenes     | Reuse one shared asset                   | Lower maintenance cost                  |

See the API: [GBConfig](../api/GBConfig/) and [GBConfigurationValidator](../api/GBConfigurationValidator/) for field-level detail.

______________________________________________________________________

## GBInjectorSystem Lifecycle

1. Initialization (`_ready` → `_initialize`):
   - Verifies a `composition_container` is assigned; otherwise disables itself (push_error).
   - Captures debug settings from the container (`_debug`).
   - Performs an initial recursive injection over each configured injection root (or the scene tree root if none).
   - Emits `initial_injection_completed` after the first pass.
1. Runtime Monitoring:
   - Connects to `SceneTree.node_added` to intercept dynamically added nodes.
   - Connects `child_entered_tree` per injection root to scope additions.
   - Connects `tree_exiting` per injected node for cleanup / meta removal and optional verbose exit logging.
1. Injection Execution (`inject_node`):
   - Skips nodes not yet inside the tree or already injected by this injector instance.
   - If the node exposes `resolve_gb_dependencies`, calls it with the shared `composition_container`.
   - Attaches metadata (`gb_injection_meta`) with injector id, weakref, timestamp, and stored signal callbacks.
   - Emits `node_injected` and logs a verbose message (if logging level allows).
1. Validation:
   - `validate_and_log_issues()` defers to the container’s validation methods, reporting warnings through the logger.

______________________________________________________________________

## Injection Scoping

Specify one or more `injection_roots` on the [GBInjectorSystem](../api/GBInjectorSystem/) to restrict which subtrees participate. If left empty, the entire scene tree root is used.

Scope check logic:

- A newly added node is injected only if it is (or is a descendant of) one of the root nodes.
- Multiple roots can coexist; each is monitored independently.

This enables patterns like separate player worlds sharing the same code paths but isolated state.

______________________________________________________________________

## Metadata & Idempotency

A node stores `gb_injection_meta` after successful injection. Subsequent passes (e.g., from other signal hooks) short‑circuit if the stored injector id matches, preventing duplicate dependency assignments or log spam.

Metadata fields (representative):

- `injector_ref`: Weak reference to the injector.
- `injector_id`: Numeric instance id snapshot.
- `timestamp_ms`: Time of injection for debugging.
- Internal keys for connected callbacks (`_child_entered_cb`, `_tree_exiting_cb`).

On node exit, callbacks are disconnected and metadata removed (or trimmed) to avoid memory / reference leaks.

______________________________________________________________________

## Logging & Debug Levels

The injector defers most formatting to [GBLogger](../api/GBLogger/) retrieved from the container. Verbose per-node lines (e.g., `[GBInjectorSystem] Injected: NodeName at /root/...`) appear only when the debug level threshold permits. Exit events optionally log a one‑time debug line via `log_debug_once` to reduce noise.

If logger acquisition fails early, the injector falls back to standard printing until the container can provide a logger.

______________________________________________________________________

## Validation Flow

Typical startup order:

1. Create or assign a [GBCompositionContainer](../api/GBCompositionContainer/) with at least a [GBConfig](../api/GBConfig/) resource.
1. Add a [GBInjectorSystem](../api/GBInjectorSystem/) node, set its `composition_container`, optionally define `injection_roots`.
1. Let `_ready()` trigger initial injection; nodes with `resolve_gb_dependencies` now have access to configuration.
   - **Editor validation runs automatically** during injector `_ready()`
1. After game dependencies are ready (GBLevelContext, GBOwner), call `run_validation()` on the injector to trigger runtime validation and log any issues.

**Manual Runtime Validation:**
```gdscript
# Option 1: Use injector helper (validates + logs)
var is_valid := injector_system.run_validation()

# Option 2: Get issues directly without logging
var issues := composition_container.get_runtime_issues()
if not issues.is_empty():
    for issue in issues:
        push_error(issue)
```

Runtime validations can re-run after loading level scenes to surface dynamic setup issues.

______________________________________________________________________

## Example Pattern

```gdscript
# In a scene script needing grid building systems
extends Node

var _logger : GBLogger
var _targeting_state : GridTargetingState

func resolve_gb_dependencies(p_config: GBCompositionContainer) -> void:
    _logger = p_config.get_logger()
    _targeting_state = p_config.get_targeting_state()
    _logger.log_debug( "Dependencies resolved for %s" % name)
```

______________________________________________________________________

## Testing Utilities

Unit tests often construct an injector with:

```gdscript
var injector := GBInjectorSystem.create_with_injection(container)
```

Or use factory helpers (e.g., `GodotTestFactory` for core helpers or `EnvironmentTestFactory` / `PlaceableTestFactory` for plugin-aware environments) to streamline container + system creation, guaranteeing a fresh context for each test case.

______________________________________________________________________

## When Not To Use Injection

- Extremely simple helper nodes that only need a single exported reference.
- One-off editor tools where direct resource assignment is clearer.
- Performance‑critical inner loops (avoid extra method indirection during hot path creation if profiling reveals overhead).

______________________________________________________________________

## Best Practices

- Keep `resolve_gb_dependencies` fast; perform heavy initialization lazily afterwards if needed.
- Avoid storing the entire [GBCompositionContainer](../api/GBCompositionContainer/) on every node—pull only what you need to reduce coupling.
- Prefer using accessor methods (e.g., `get_targeting_state()`) instead of reaching deeply into nested resources.
- **Validation happens automatically** after injection—no manual validation calls needed.
- Scope injection roots to smallest reasonable subtree in large worlds to reduce signal churn.

______________________________________________________________________

## Related API Pages

- [GBInjectorSystem](../api/GBInjectorSystem/)
- [GBCompositionContainer](../api/GBCompositionContainer/)

______________________________________________________________________

## Future Enhancements (Planned / Considerations)

- Automatic parameter type discovery for richer docs (parsing argument annotations in `resolve_gb_dependencies`).
- Optional interface tagging (annotation or signal-based) to reduce reliance on method name convention.
- Hot-reload re-injection hooks for editor tooling.

If you have additional needs, open an issue or propose an extension in the contributor docs.