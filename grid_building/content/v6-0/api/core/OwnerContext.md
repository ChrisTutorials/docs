---
title: "OwnerContext"
description: "The owner context of a CompositionContainer.
All systems, settings, templates, etc contained within are correlated with the owner's setup.
You can have multiple CompositionContainers and Owners within a game if you need
multiple full systems running at the same time (multiplayer etc).
Ported from: godot/addons/grid_building/core/contexts/gb_owner_context.gd"
weight: 10
url: "/gridbuilding/v6-0/api/core/ownercontext/"
---

# OwnerContext

```csharp
GridBuilding.Core.Domain.State
class OwnerContext
{
    // Members...
}
```

The owner context of a CompositionContainer.
All systems, settings, templates, etc contained within are correlated with the owner's setup.
You can have multiple CompositionContainers and Owners within a game if you need
multiple full systems running at the same time (multiplayer etc).
Ported from: godot/addons/grid_building/core/contexts/gb_owner_context.gd

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/State/User/Owner.cs`  
**Namespace:** `GridBuilding.Core.Domain.State`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### AllowOverridingOwner

```csharp
/// <summary>
    /// Whether to allow overriding an existing owner
    /// </summary>
    public bool AllowOverridingOwner { get; set; } = true;
```

Whether to allow overriding an existing owner

### OutputChangeFail

```csharp
/// <summary>
    /// Whether to output a warning when owner change fails
    /// </summary>
    public bool OutputChangeFail { get; set; } = true;
```

Whether to output a warning when owner change fails


## Methods

### SetOwner

```csharp
/// <summary>
    /// Sets the owner for this context.
    /// Respects the AllowOverridingOwner setting when changing from an existing owner.
    /// </summary>
    /// <param name="value">The new owner to set for this context</param>
    public void SetOwner(IOwner? value)
    {
        if (ReferenceEquals(_owner, value))
        {
            return;
        }

        if (AllowOverridingOwner || _owner == null)
        {
            _owner = value;
            OwnerChanged?.Invoke(_owner);
        }
        else if (OutputChangeFail)
        {
            Console.WriteLine(
                $"Owner {_owner} is already set on OwnerContext and changing is not currently allowed when active owner is set."
            );
        }
    }
```

Sets the owner for this context.
Respects the AllowOverridingOwner setting when changing from an existing owner.

**Returns:** `void`

**Parameters:**
- `IOwner? value`

### GetOwner

```csharp
/// <summary>
    /// Returns the current owner of this context.
    /// May return null if no owner has been set.
    /// </summary>
    public IOwner? GetOwner() => _owner;
```

Returns the current owner of this context.
May return null if no owner has been set.

**Returns:** `IOwner?`

### GetOwnerRoot

```csharp
/// <summary>
    /// Returns the owner root or null if not set
    /// </summary>
    public object? GetOwnerRoot()
    {
        return _owner?.OwnerRoot;
    }
```

Returns the owner root or null if not set

**Returns:** `object?`

### GetOrigin

```csharp
/// <summary>
    /// Returns the origin node associated with the active owner (usually the owner_root).
    /// </summary>
    public object? GetOrigin()
    {
        return _owner?.OwnerRoot;
    }
```

Returns the origin node associated with the active owner (usually the owner_root).

**Returns:** `object?`

### GetEditorIssues

```csharp
/// <summary>
    /// Gets issues found during editor validation
    /// </summary>
    public List<string> GetEditorIssues()
    {
        return new List<string>();
    }
```

Gets issues found during editor validation

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Gets issues found during runtime validation
    /// </summary>
    public List<string> GetRuntimeIssues()
    {
        var issues = new List<string>();

        issues.AddRange(GetEditorIssues());

        if (_owner == null)
        {
            issues.Add("Owner is not assigned in OwnerContext");
        }

        return issues;
    }
```

Gets issues found during runtime validation

**Returns:** `List<string>`

