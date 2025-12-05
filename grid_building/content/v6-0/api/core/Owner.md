---
title: "Owner"
description: "Deprecated: Use IOwner from GridBuilding.Core.Domain.State instead.
The Owner concept is now handled through OwnerContext in the service layer.
This POCS type exists only for backward compatibility."
weight: 10
url: "/gridbuilding/v6-0/api/core/owner/"
---

# Owner

```csharp
GridBuilding.Core.Types
class Owner
{
    // Members...
}
```

Deprecated: Use IOwner from GridBuilding.Core.Domain.State instead.
The Owner concept is now handled through OwnerContext in the service layer.
This POCS type exists only for backward compatibility.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Types/Owner.cs`  
**Namespace:** `GridBuilding.Core.Types`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id { get; set; } = string.Empty;
```

### Name

```csharp
public string Name { get; set; } = string.Empty;
```

### Type

```csharp
public string Type { get; set; } = "Player"; // Player, AI, System, etc.
```

### IsActive

```csharp
public bool IsActive { get; set; } = true;
```

### Metadata

```csharp
public Dictionary<string, object> Metadata { get; set; } = new();
```

