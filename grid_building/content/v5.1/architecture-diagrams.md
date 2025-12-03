---
title: "Architecture Diagrams"
linkTitle: "Architecture Diagrams"
description: "Automatically generated architecture diagrams for the GridBuilding plugin"
menu:
  main:
    weight: 60
---

This page demonstrates the automatically generated architecture diagrams for the GridBuilding plugin using Chickensoft.UMLGenerator.

## Overview

The diagrams below are generated automatically from the C# source code using the Chickensoft.UMLGenerator tool. They are rendered to SVG format for inclusion in this static documentation site.

## Complete System Architecture

### Godot POCS Architecture
{{< plantuml-diagram "GodotPOCSArchitecture" >}}

This diagram shows the Godot-specific POCS (Proof of Concept/System) entry points that connect Godot components to the pure C# architecture. The architecture demonstrates:

- **Godot Entry Points**: Main interfaces for Godot scene integration
- **POCS Service Locator**: Bridge between Godot and pure C# services  
- **Controller Classes**: Godot-specific controllers for placement, manipulation, and targeting
- **Pure C# Services**: Core business logic separated from Godot dependencies

The POCS architecture enables:
- **Clean Separation**: Godot UI layer separated from pure C# business logic
- **Cross-Engine Compatibility**: Services can work with Unity or other engines
- **Testability**: Pure C# services can be unit tested without Godot dependencies
- **Maintainability**: Business logic independent of Godot API changes

## Individual Component Diagrams

### MathUtils Class
{{< plantuml-diagram "MathUtils" >}}

This class provides pure C# math utilities that replace Godot's Mathf class, ensuring AOT compatibility for iOS/Android platforms.

### Placement Service
{{< plantuml-diagram "PlacementService" >}}

Core service for building placement operations, handling validation and execution of grid-based building placement.

### Grid Targeting Service  
{{< plantuml-diagram "GridTargetingService" >}}

Manages grid navigation, pathfinding, and tile validation for precise positioning and movement operations.

### Manipulation Service
{{< plantuml-diagram "ManipulationService" >}}

Handles building transformations including move, rotate, and removal operations with state management.

### Service Registry
{{< plantuml-diagram "ServiceRegistry" >}}

Dependency injection container managing service lifetimes, registration, and resolution across the plugin architecture.

### Building System Interfaces
{{< plantuml-diagram "IBuildingSystem" >}}

The building system interfaces define the core contracts for grid-based building functionality.

## How It Works

1. **Source Code Annotation**: Classes are marked with `[ClassDiagram]` attributes
2. **Build-Time Generation**: PlantUML (.puml) files are generated during compilation
3. **Static Rendering**: Diagrams are pre-rendered to SVG for static site inclusion
4. **Hugo Integration**: Custom shortcode includes diagrams in documentation

## Benefits

- **Always Up-to-Date**: Diagrams automatically reflect code changes
- **Static Site Compatible**: No runtime dependencies or JavaScript required
- **IDE Integration**: Clickable links open source files in your editor
- **Version Controlled**: Diagrams are part of the documentation repository

## Adding New Diagrams

To add architecture diagrams for new components:

1. Add `[ClassDiagram(UseVSCodePaths = true)]` to classes you want to document
2. Rebuild the project to generate .puml files
3. Run the diagram rendering script: `./scripts/render-plantuml-diagrams.sh`
4. Include diagrams in documentation using: `{{< plantuml-diagram "ClassName" >}}`

## Future Enhancements

- Integration with Godot scene files (.tscn)
- Relationship diagrams showing dependencies
- Sequence diagrams for workflows
- Interactive diagrams with expandable sections
