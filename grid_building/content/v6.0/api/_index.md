---
title: "GridBuilding API Reference"
description: ""
weight: 100
url: "/gridbuilding/v6-0/api/"
---

# GridBuilding API Reference v6.0

This section contains the complete API reference for the GridBuilding plugin, generated using **AST parsing**.

## ⚠️ IMPORTANT: AST Parsing vs Regex

**This documentation is generated using AST parsing (Roslyn), NOT regex.**

### Why AST Parsing is Essential

✅ **AST Parsing Provides:**
- Accurate C# language understanding
- Proper type resolution and inheritance analysis  
- Semantic-aware signature extraction
- Robust handling of complex language features
- Support for generics, constraints, and modern C# features
- No false positives from fragile pattern matching

❌ **Regex Parsing Fails On:**
- Nested types and complex inheritance
- Generic constraints and variance
- Conditional compilation directives
- Preprocessor directives and regions
- Complex attribute scenarios
- Partial classes and method overloads
- Extension methods and LINQ expressions
- Future C# language features

## Architecture Layers

## Core

Pure C# business logic and data structures

[**View Core API**]({{< relref "core" >}})

## Godot

Engine-specific implementations and visual components

[**View Godot API**]({{< relref "godot" >}})



---

*This documentation is automatically generated using AST parsing technology for maximum accuracy.*
Project: GridBuilding v6.0
