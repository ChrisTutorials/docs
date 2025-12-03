---
id: di_container_lifecycle
title: DI container lifecycle
sidebar_position: 60
weight: 10---

---



This page documents the recommended lifecycle, ownership, and integration patterns for the [GBCompositionContainer](../api/GBCompositionContainer/) when used as a per-player (per-character) container in the Grid Building Plugin.

## Overview

The intended model: each player (or character) that can build independently gets its own [GBCompositionContainer](../api/GBCompositionContainer/), plus an associated [GBInjectorSystem](../api/GBInjectorSystem/) and local systems (for example, [IndicatorManager](../api/IndicatorManager/)). This keeps state isolated, simplifies testing, and supports multiplayer / multi‑tenant scenarios.

## Ownership and lifecycle rules

- The [GBOwner](../api/GBOwner/) (or player root) owns the container and the injector. Create the container when the player joins or when the level spawns the player, and free it when the player leaves.
- The container lifetime should match the player's game lifetime. Avoid putting a player container under a global root.
- The container should have a stable id or owner reference to make logs and validation messages clear (for example: `container.owner_id` or `container.owner_name`).

## Injector placement and injection roots

- Put the [GBInjectorSystem](../api/GBInjectorSystem/) as a child of the player subtree (for example `player_node/Systems/GBInjectorSystem`).
- Configure `injection_roots`, or rely on the injector being under the player subtree so injection scans are scoped to that player only. Do not use a single global injector unless you intentionally want shared wiring.
- For dynamically created nodes, either:
    - Create them under the player subtree so the injector will catch them; or
    - Call an explicit helper: `injector.inject_node(node)` after instantiation.

## Construction factory (recommended)

Provide a single factory that assembles the per-player composition container, injector, and core systems. Examples:
```gdscript
```gdscript
# Pseudo-code factory
func create_player_container(player_node: Node) -> GBInjectorSystem:
    var container := GBCompositionContainer.new()
    container.owner_id = player_node.get_name()

    var system_root := Node.new()
    system_root.name = "GridBuildingSystem"
    player_node.add_child(system_root)

    var comp := preload("res://addons/grid_building/resources/gb_composition_container.gd").new()
    system_root.add_child(comp)
    # Assign a prepared GBConfig resource to the container's `config` property.
    # Prefer direct assignment to keep the runtime API small and explicit.
    comp.config = prepared_config

    var injector := preload("res://addons/grid_building/systems/injection/gb_injector_system.gd").new()
    injector.composition_container = comp
    system_root.add_child(injector)

    # Initialize once the container is assigned and the injector is parented.
    injector.initialize(comp) # or call in _ready() / from the factory
    return injector
```
```

Use this factory both in gameplay code and tests (prefer `GodotTestFactory` for core helpers, or `EnvironmentTestFactory` / `PlaceableTestFactory` for full scene-based test environments). The older `UnifiedTestFactory` pattern is deprecated.

## Initialization ordering and signals

- Standardize on a single initialization point. Call `injector.initialize(container)` once the container is assigned and systems are parented.
- After validation, emit a `container_ready` (or similarly named) signal. Systems should listen for that signal rather than assuming dependencies are available immediately in `_ready()`.

## Injection API & recommended workflow

The runtime DI surface is intentionally small and centered on three behaviors:

- `GBInjectorSystem.initialize(container)` — assign the [GBCompositionContainer](../api/GBCompositionContainer/) and start the injector's initial scan. Call this once the composition container and injector are parented so that the initial injection pass runs with a stable scene hierarchy.
- `GBInjectorSystem.inject_node(node)` — explicitly inject dependencies into nodes that are created dynamically or instantiated outside the normal player subtree. Prefer creating nodes under the player subtree so the injector picks them up automatically; use `inject_node` when that is not possible.
- `resolve_gb_dependencies(p_container: GBCompositionContainer)` — the conventional method implemented by scripts that want dependencies injected. The injector calls this on nodes it finds; implement this on your nodes to pull only the services they need (for example, `_logger := p_container.get_logger()`).

Recommended pattern:

1. Factory creates [GBCompositionContainer](../api/GBCompositionContainer/) and [GBInjectorSystem](../api/GBInjectorSystem/), parents them under the player's subtree.
2. Call `injector.initialize(container)` once the container is set and systems are parented.
3. After any validation passes, emit a `container_ready` (or similar) signal from the factory or container owner.
4. Nodes that are created later should either be parented under the player subtree or explicitly passed to `injector.inject_node(node)`.

This keeps the runtime API stable and avoids exposing or encouraging direct mutation of the container internals.

## Testing guidance

- Use factory helpers (see `GodotTestFactory` or `EnvironmentTestFactory`) to create per-player containers and injectors for isolated tests.
- Add a test that creates two containers and asserts lookups return different instances to guard against accidental singletons.

Note: [IndicatorManager](../api/IndicatorManager/) uses `GridTargetingState.get_runtime_issues()` (non‑mutating) to guard indicator setup; prefer calling `get_runtime_issues()` when only diagnostics are required.

## Checklist (quick)

- [ ] Container created per player and freed on player leave.
- [ ] Injector placed under the player subtree (scoped scans).
- [ ] Use factory to assemble container, injector, and systems.
- [ ] Call `injector.initialize(container)` after parenting; emit `container_ready` after validation.
- [ ] Use `injector.inject_node(node)` for dynamic nodes that cannot be parented under the player subtree.
- [ ] Tests covering multi-container isolation.

## notes

 - Prefer passing small services (logger, states) rather than persisting the full container on every node. Document this rule in PRs and code comments.
 - Shared resources (templates, .tres assets) may remain global; runtime systems and states should be per‑container.

If you want, I can add a small runtime helper in a follow-up PR, but the recommended pattern is to prefer the explicit `config` assignment and the injector APIs described above. A small unit test verifying container isolation already exists in the test suite; extend it if you'd like the helper added later.