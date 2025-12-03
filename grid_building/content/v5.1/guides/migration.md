---
title: Migration Guide
description: Complete migration guide for upgrading from Grid Building v5.0.0 to v5.1.0
title: Changes in v5.0.1
description: Micro changes and updates for Grid Building Plugin version 5.0.1
---


This page documents the minor changes and updates introduced in version 5.0.1 of the Grid Building Plugin.

## Art Pathing Changes

### Template Resource Organization
- Updated asset paths in `godot/templates/grid_building_templates/` to use more consistent and organized directory structures
- Improved resource loading paths for better compatibility with different project setups
- Standardized font and icon asset locations within template resources

### Font Asset Updates
- Added `monogram.ttf` font to `godot/templates/grid_building_templates/resources/fonts/`
- Included CC0 license file (`LICENSE.txt`) in the same directory for proper attribution
- Font is free for personal and commercial use under Creative Commons Zero v1.0 Universal license

## Version Updates
- Updated all plugin version numbers to 5.0.1 across:
  - Main plugin configuration files
  - Inventory plugin configuration
  - README files
  - Test suite documentation
  - Documentation references

## Submodule Synchronization
- Synchronized all Git submodules to their latest commits
- Updated submodule references to point to main branches
- Resolved any merge conflicts and ensured clean submodule states

## Template Configuration Fixes
- **Debug Log Level**: All template configuration files now use `WARNING` (level 2) as the default debug level instead of `DEBUG` or `VERBOSE`
  - Updated `isometric/config.tres` to explicitly set `level = 2`
  - Updated `platformer/config.tres` from `level = 4` (DEBUG) to `level = 2` (WARNING)
  - Updated `top_down/td_config.tres` from `level = 5` (VERBOSE) to `level = 2` (WARNING)
- Added integrity test to validate template configs maintain WARNING log level for production use
- This reduces console noise and improves performance in production environments while keeping important warnings visible

## Template Integrity Testing
- **Enhanced Template Validation**: Added comprehensive integrity tests to ensure templates work correctly when copied to new projects
- **Keyboard Input Safety**: Fixed `top_down/td_config.tres` to disable keyboard input by default (`enable_keyboard_input = false`)
- **Template Combination Testing**: Added validation that systems templates work correctly when combined with grid_positioner_stack templates
- **Distribution Readiness**: Verified all templates load and instantiate properly with just the `addons/grid_building` plugin
- **Resource Loading Validation**: Added tests to ensure all .tres and .tscn files load without circular dependencies or missing references

## Demo Folder Integrity Tests
- **Scene Structure Validation**: Added automated tests to verify demo scene hierarchies and required node configurations
- **Component Integration Testing**: Enhanced tests to validate that demo scenes properly integrate with Grid Building systems
- **Resource Loading Verification**: Added checks to ensure demo scenes load all required assets and dependencies correctly
- **Hierarchy Consistency**: Implemented tests to verify [ManipulationParent](../api/ManipulationParent/) and [IndicatorManager](../api/IndicatorManager/) positioning in demo scenes

## Build System Fixes
- **Manipulation Parent Reset**: Fixed issue where [ManipulationParent](../api/ManipulationParent/) rotation persisted when switching between placeables
- **Transform State Cleanup**: Added `ManipulationParent.reset()` call in `BuildingSystem.clear_preview()` to ensure clean state transitions
- **Indicator Rotation Inheritance**: Resolved visual bug where indicators appeared at incorrect angles after placeable switches
- **State Management**: Improved transform hierarchy management between [ManipulationParent](../api/ManipulationParent/) and indicators during build mode transitions

## Pre-release Notes
This is a development pre-release (5.0.1) intended for testing and validation before the final stable release. All changes are backward compatible with 5.0.0.

