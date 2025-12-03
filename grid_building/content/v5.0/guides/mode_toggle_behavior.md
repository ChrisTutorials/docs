---
title: Mode Toggle Behavior
description: Mode Toggle Behavior documentation for the Grid Building system
---


---



In the Grid Building system, pressing a mode button (or its corresponding keyboard shortcut) will activate that mode. If you press the same button or key again while the mode is already active, the system will toggle back to OFF mode—provided the corresponding system (e.g., BuildingSystem, ManipulationSystem) exists and is enabled.

## System Requirements per Mode

Mode toggling only succeeds when its backing runtime systems and injected contexts are active (created + dependency validated). If a required system is missing or failed injection, pressing its action will either do nothing or immediately revert to OFF.

| Mode                  | Requires Active System(s)                         | Additional Requirements                                                                                             | Notes                                                                             |
| --------------------- | ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| Build (`BUILD`)       | [BuildingSystem](../api/BuildingSystem/)                                  | States: `building`, `targeting`; IndicatorManager available via composition; valid [GBConfig](../api/GBConfig/) settings.building | Second press toggles OFF if still in BUILD. Preview cleared on exit.              |
| Move (`MOVE`)         | [ManipulationSystem](../api/ManipulationSystem/)                              | Active manipulatable target (via targeting state); `manipulation.parent` assigned                                   | If setup fails (no target / invalid), status becomes FAILED and mode remains OFF. |
| Demolish (`DEMOLISH`) | [ManipulationSystem](../api/ManipulationSystem/)                              | Target object with [Manipulatable](../api/Manipulatable/) root; permissions in manipulation settings                                       | Toggle pattern identical: press again returns OFF.                                |
| Info (`INFO`)         | [ManipulationSystem](../api/ManipulationSystem/) (for name display / context) | Target or hover context resolvable; name displayer injected                                                         | Used for inspecting objects; does not modify placement context.                   |
| Off (`OFF`)           | —                                                 | —                                                                                                                   | Entered explicitly or by pressing the currently active mode action again.         |

Both [BuildingSystem](../api/BuildingSystem/) and [ManipulationSystem](../api/ManipulationSystem/) contain OFF-mode toggle logic independently. This redundancy ensures projects that exclude one system still achieve consistent press-again-to-off behavior without hidden coupling.

### Validation / Injection Impact

- All required systems must have passed `get_runtime_issues()` during composition container initialization. Warnings in the build log indicate missing dependencies that can block toggling.
- For Build mode, if `_indicator_context.get_manager()` is null, the attempt to enter or perform build actions will fail silently or log a warning and remain OFF.
- For Manipulation-derived modes (MOVE/DEMOLISH/INFO) a valid `_states.manipulation` context and target discovery (`GBSearchUtils.find_first`) are prerequisites.

### Failure Scenarios

| Scenario                                                     | Result                                             |
| ------------------------------------------------------------ | -------------------------------------------------- |
| User presses Build but [BuildingSystem](../api/BuildingSystem/) not present          | No mode change (stays OFF)                         |
| User presses Move with no manipulatable target               | Mode stays OFF; manipulation data status FAILED    |
| User presses Demolish; system active but target root is null | Status FAILED; stays/off resets                    |
| User presses Build while already BUILD                       | Mode toggles to OFF, preview cleared               |
| User presses Move again while MOVE                           | Mode toggles to OFF, move copy (if any) cleaned up |

### Recommended Setup Order

1. Compose container & injector (`GBInjectorSystem.initialize`).
1. Verify build log: no dependency warnings for Building / Manipulation systems.
1. Confirm [IndicatorManager](../api/IndicatorManager/) available (created via composition/injection).
1. Ensure `manipulation.parent` node assigned (used for parenting move copies).
1. Bind input actions mapping to invoke mode toggles.

With these conditions satisfied, all mode toggles will exhibit consistent press-to-activate / press-again-to-off behavior.

## Example

- Pressing the Build button (or key) once: enters Build mode.
- Pressing the Build button (or key) again: returns to OFF mode.
- This applies to Move, Demolish, and Info modes as well, as long as their systems are present.

This behavior ensures quick toggling and prevents accidental mode lock-in during editing or gameplay.
