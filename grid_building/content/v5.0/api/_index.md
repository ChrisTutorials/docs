---
title: "GDScript API Reference"
description: "Complete GDScript API reference for Grid Building Plugin v5.0"
weight: 1
---


This section contains the complete GDScript API reference for the Grid Building Plugin v5.0 (Stable).

## Overview

The v5.0 release provides a GDScript-based implementation of the Grid Building Plugin with comprehensive APIs for grid-based building systems, placement logic, manipulation tools, and validation systems.

## Core Systems

### Building System
- **BuildingSystem**: Core building management and state
- **BuildingSettings**: Configuration for building operations
- **BuildingInstantiator**: Handles building creation and instantiation

### Placement System
- **PlacementRule**: Validation logic for placement operations
- **PlacementValidator**: Comprehensive placement validation
- **GridPositioner2D**: Grid positioning and coordinate utilities

### Manipulation System
- **ManipulationSystem**: Object manipulation and transformation
- **ManipulationData**: State management for manipulation operations
- **ManipulationSettings**: Configuration for manipulation behavior

### Collision System
- **CollisionProcessor**: Collision detection and processing
- **CollisionGeometryUtils**: Geometry calculations for collisions
- **CollisionsCheckRule**: Collision validation rules

### Grid Utilities
- **GBGeometryMath**: Mathematical utilities for grid calculations
- **GBPositioning2DUtils**: Grid positioning and coordinate conversion
- **GBGridRotationUtils**: Grid rotation and orientation utilities

## Getting Started

To use the GDScript API in your project:

```gdscript
# Create a grid position
var grid_pos = GridPositioner2D.new()
var position = grid_pos.get_grid_position(world_pos, tile_size)

# Set up placement context
var placement_rule = PlacementRule.new()
var can_place = placement_rule.can_place_at(position, building_data)

# Manipulate objects
var manipulation_system = ManipulationSystem.new()
manipulation_system.start_manipulation(object, position)
```

## API Documentation

Browse the complete API documentation by category:

- [BuildingSystem](BuildingSystem.md) - Core building management
- [PlacementRule](PlacementRule.md) - Placement validation logic
- [ManipulationSystem](ManipulationSystem.md) - Object manipulation
- [CollisionProcessor](CollisionProcessor.md) - Collision detection
- [GBGeometryMath](GBGeometryMath.md) - Grid math utilities

[View complete API index](index.md) for all available classes and methods.
