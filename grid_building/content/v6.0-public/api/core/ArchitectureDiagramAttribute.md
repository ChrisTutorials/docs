---
title: "ArchitectureDiagramAttribute"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/architecturediagramattribute/"
---

# ArchitectureDiagramAttribute

```csharp
GridBuilding.Core.Shared
class ArchitectureDiagramAttribute
{
    // Members...
}
```

Marks a class, interface, or struct to be included in the architecture diagrams

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Shared/ArchitectureAttributes.cs`  
**Namespace:** `GridBuilding.Core.Shared`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ShowImplementationDetails

```csharp
/// <summary>
        /// Whether to show implementation details in the diagram
        /// </summary>
        public bool ShowImplementationDetails { get; set; } = true;
```

Whether to show implementation details in the diagram

### IncludeMembers

```csharp
/// <summary>
        /// Whether to include this type's members in the diagram
        /// </summary>
        public bool IncludeMembers { get; set; } = true;
```

Whether to include this type's members in the diagram

