---
title: "Injectable"
description: "OBSOLETE: Legacy dependency injection base class.
This class is deprecated. Use the Enhanced Service Registry Pattern instead.
## Migration Steps:
1. Create service interfaces for your system's dependencies
2. Implement core services as pure C# classes
3. Create Godot-specific services for engine operations
4. Register services in ServiceCompositionRoot
5. Update system classes to use ServiceRegistry
## Examples:
See: /docs/ENHANCED_SERVICE_PATTERN_MIGRATION.md
## Removal Timeline:
- Deprecated: Immediately (this version)
- Warning period: 2 development cycles
- Removal: After warning period
## Why This Change:
The Injectable pattern tightly couples pure C# business logic to Godot Node infrastructure,
making it difficult to test core logic independently and creating mixed responsibilities.
The Enhanced Service Registry Pattern provides clean separation between core logic
and engine-specific presentation."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/injectable/"
---

# Injectable

```csharp
GridBuilding.Godot.Core.Base
class Injectable
{
    // Members...
}
```

OBSOLETE: Legacy dependency injection base class.
This class is deprecated. Use the Enhanced Service Registry Pattern instead.
## Migration Steps:
1. Create service interfaces for your system's dependencies
2. Implement core services as pure C# classes
3. Create Godot-specific services for engine operations
4. Register services in ServiceCompositionRoot
5. Update system classes to use ServiceRegistry
## Examples:
See: /docs/ENHANCED_SERVICE_PATTERN_MIGRATION.md
## Removal Timeline:
- Deprecated: Immediately (this version)
- Warning period: 2 development cycles
- Removal: After warning period
## Why This Change:
The Injectable pattern tightly couples pure C# business logic to Godot Node infrastructure,
making it difficult to test core logic independently and creating mixed responsibilities.
The Enhanced Service Registry Pattern provides clean separation between core logic
and engine-specific presentation.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Core/Injectable.cs`  
**Namespace:** `GridBuilding.Godot.Core.Base`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ResolveGbDependencies

```csharp
/// <summary>
    /// Legacy dependency resolution method.
    /// OBSOLETE: Use InjectDependencies instead.
    /// </summary>
    [Obsolete("Use InjectDependencies(ICompositionContainer) instead.")]
    public virtual bool ResolveGbDependencies(object container)
    {
        // Try to convert to new container interface
        if (container is ICompositionContainer compositionContainer)
        {
            InjectDependencies(compositionContainer);
            return ValidateDependencies(compositionContainer).IsValid;
        }
        
        GD.PrintErr($"Injectable: Cannot convert container of type {container?.GetType()} to ICompositionContainer");
        return false;
    }
```

Legacy dependency resolution method.
OBSOLETE: Use InjectDependencies instead.

**Returns:** `bool`

**Parameters:**
- `object container`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Legacy runtime issues method.
    /// OBSOLETE: Use ValidateDependencies instead.
    /// </summary>
    [Obsolete("Use ValidateDependencies(ICompositionContainer) instead.")]
    public virtual global::Godot.Collections.Array<string> GetRuntimeIssues()
    {
        var result = new global::Godot.Collections.Array<string>();
        
        // Try to get container and validate
        if (GetNode("/root/CompositionContainer") is ICompositionContainer container)
        {
            var validation = ValidateDependencies(container);
            if (!validation.IsValid)
            {
                foreach (var error in validation.Errors)
                {
                    result.Add(error);
                }
            }
        }
        else
        {
            result.Add("CompositionContainer not found in scene tree");
        }
        
        return result;
    }
```

Legacy runtime issues method.
OBSOLETE: Use ValidateDependencies instead.

**Returns:** `global::Godot.Collections.Array<string>`

### InjectDependencies

```csharp
/// <summary>
    /// New dependency injection method.
    /// Implement this in derived classes.
    /// </summary>
    public virtual void InjectDependencies(ICompositionContainer container)
    {
        // Base implementation does nothing
        // Derived classes should override this
    }
```

New dependency injection method.
Implement this in derived classes.

**Returns:** `void`

**Parameters:**
- `ICompositionContainer container`

### ValidateDependencies

```csharp
/// <summary>
    /// New dependency validation method.
    /// Implement this in derived classes.
    /// </summary>
    public virtual ValidationResult ValidateDependencies(ICompositionContainer container)
    {
        // Base implementation returns valid
        // Derived classes should override this
        return ValidationResult.Success();
    }
```

New dependency validation method.
Implement this in derived classes.

**Returns:** `ValidationResult`

**Parameters:**
- `ICompositionContainer container`

