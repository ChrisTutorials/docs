---
title: Grid Building Plugin v5.0.0
description: Complete documentation for Grid Building Plugin version 5.0.0
---


---


Welcome to the comprehensive documentation for **Grid Building Plugin v5.0.0** - the latest stable release with major architectural improvements and enhanced features.

{{< version-requirements minVersion="4.4" 
  recommended="4.5"
  pluginVersion="5.0.0"
  note="v5.0.0 depends on APIs introduced in Godot 4.4+"
 >}}

## 🎯 Version Highlights

### 🏗️ **Major Architectural Improvements**
- **Complete Dependency Injection Integration** with [GBCompositionContainer](/v5-0/api/GBCompositionContainer/)
- **Unified Configuration System** with [GBConfig](/v5-0/api/GBConfig/) resource
- **Enhanced State Management** with improved [BuildingState](/v5-0/api/BuildingState/) lifecycle
- **Godot 4.4+ Optimizations** leveraging typed data structures for better performance
- **Automatic Dependency Validation** - [GBInjectorSystem](/v5-0/api/GBInjectorSystem/) handles validation automatically (no manual calls needed)

### 🔧 **Core System Enhancements**
- **BuildType Enum System** - Replaces boolean `dragging` flag with comprehensive enum (SINGLE, DRAG, AREA builds)
- **Advanced Building System** with comprehensive placement workflow
- **Sophisticated Grid Targeting** with epsilon-filtered tile selection
- **Intelligent Placement Validation** with multi-rule evaluation
- **Dynamic Indicator Management** with real-time visual feedback
- **Grid-Aware Rotation System** with configurable increments (4, 6, 8, 12 directions) and automatic grid alignment
- **Validation Contract**: `validate()` methods return `bool` (success/failure). Use `get_runtime_issues()` at runtime and `get_editor_issues()` in the editor to collect diagnostics, log via `GBLogger`, and consider validation successful only when no issues remain.

### 🎨 **UI & Usability Improvements**
- **Enhanced Placeable View UI** with fixed view height, fixed icon size, and improved keyboard navigation
- **Stable Visual Feedback** with consistent icon sizing across variant cycling
- **Refined Dark Theme** with cyan/magenta color palette integration
- **Pre-made UI Themes** - Cool Blue and Warm Earth themes included in templates for quick prototyping

### 📚 **Documentation Improvements**
- **End-to-End Process Documentation** with detailed workflow guides
- **Comprehensive API Reference** with deep links across systems
- **Comprehensive Testing Framework** with 1540 tests passing at 100%
- **Performance Monitoring** and debugging tools
- **Site-wide Autolinking** of CamelCase class names to internal API pages or Godot docs (code blocks and existing links are respected)

## 📖 Documentation Sections

### 🛠️ **Core Systems**
- **[Building System Process](guides/building_system_process/)** - Complete placement workflow from start to finish
- **[Placement Chain](guides/placement_chain/)** - Detailed placement processing pipeline
- **[Manipulation System](guides/manipulation_system/)** - Object manipulation and movement
- **[Grid Targeting](guides/grid_targeting/)** - Advanced grid positioning and validation

### 🎨 **Visual & UI Systems**
- **[Indicator Management](guides/indicator_setup_report/)** - Visual feedback and status indicators
- **[UI Components](guides/ui_selection_components/)** - User interface elements and controls
{/* Theme Integration guide removed (not available) */}

### ⚙️ **Configuration & Settings**
- **[Configuration Guide](guides/configuration_and_settings/)** - System configuration and setup
{/* Performance Optimization guide removed (not available). See Performance section below for general guidance. */}

## 🔗 API Reference

Browse the complete API reference for all classes:

- Go to the API Home: [API Reference Index](api/)

### Core Classes
- **[BuildingSystem](api/BuildingSystem/)** - Main building system coordinator
- **[GBConfig](api/GBConfig/)** - Unified configuration resource
- **[BuildingState](api/BuildingState/)** - Building session state management
- **[GridTargetingSystem](api/GridTargetingSystem/)** - Grid positioning and targeting

### Validation & Rules
- **[PlacementValidator](api/PlacementValidator/)** - Placement validation engine
- **[TileCheckRule](api/TileCheckRule/)** - Individual tile validation rules
- **[PlacementRule](api/PlacementRule/)** - General placement rules

### Visual Systems
- **[IndicatorManager](api/IndicatorManager/)** - Visual indicator management
- **[RuleCheckIndicator](api/RuleCheckIndicator/)** - Individual rule indicators
- **[GBCursorChanger](api/GBCursorChanger/)** - Cursor management system

## 🚀 Getting Started

1. **[Building System Process](guides/building_system_process/)** - Your first building implementation 
2. **[User Guides](guides/)** - Comprehensive usage guides
3. **[Configuration](guides/configuration_and_settings/)** - Initial configuration
4. **[Dependency Injection](guides/dependency_injection/)** - Understanding the DI system
5. **Try the UI Themes** - Find `grid_builder_cool_blue_theme.tres` and `grid_builder_warm_earth_theme.tres` in the templates folder for quick UI styling

## 🧪 Testing & Validation

- **1540 tests passing at 100%** - Comprehensive test coverage across all systems (1410 plugin tests + 130 demo/misc tests)
- **[Testing Framework](testing/)** - Automated testing setup with GdUnit4
- **[Validation Tools](validation/)** - Manual validation procedures
- **[Debug Tools](debugging/)** - Debugging and troubleshooting
- Premade testing environments (scenes) to quickly spin up common configurations (core systems, positioner stack, [GBLevelContext](/v5-0/api/GBLevelContext/), and [GBOwner](/v5-0/api/GBOwner/))

## 🔄 Migration from Previous Versions

If you're upgrading from an earlier version:

- **[Migration Guide](./migration/)** - Step-by-step migration instructions
- **[Breaking Changes](./guides/breaking-changes/)** - Important changes to be aware of
{/* Deprecation notices removed; consolidated into Breaking Changes. */}

{/* Performance & Optimization section removed until concrete, verifiable guidance is available. */}

## 🤝 Support

- Issue tracker is private for this project. For support, use the private channel referenced in the repository README.
{/* Public Discord links removed by policy. */}


<PluginVersionInfo 
  version="5.0.0" 
  releaseDate="October 2025"
  godotVersions="4.4.0, 4.4.1, 4.5 stable"
  minGodotVersion="4.4+"
></PluginVersionInfo>