---
title: "MockGBOwnerContext"
description: ""
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockgbownercontext/"
---

# MockGBOwnerContext

```csharp
GridBuilding.Godot.Tests.Contexts
class MockGBOwnerContext
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GridTargetingStateTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Contexts`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### AllowOverridingOwner

```csharp
public bool AllowOverridingOwner { get; set; } = true;
```

### OutputChangeFail

```csharp
public bool OutputChangeFail { get; set; } = true;
```


## Methods

### GetOwner

```csharp
public IGBOwner<object>? GetOwner() => _owner;
```

**Returns:** `IGBOwner<object>?`

### GetOwnerRoot

```csharp
public object? GetOwnerRoot() => _owner?.OwnerRoot;
```

**Returns:** `object?`

### GetOrigin

```csharp
public object? GetOrigin() => _owner?.OwnerRoot;
```

**Returns:** `object?`

### GetEditorIssues

```csharp
public string[] GetEditorIssues() => new string[0];
```

**Returns:** `string[]`

### GetRuntimeIssues

```csharp
public string[] GetRuntimeIssues() => new string[0];
```

**Returns:** `string[]`

### SetOwner

```csharp
public void SetOwner(IGBOwner<object>? value)
        {
            if (ReferenceEquals(_owner, value)) return;
            _owner = value;
            OwnerChanged?.Invoke(_owner);
        }
```

**Returns:** `void`

**Parameters:**
- `IGBOwner<object>? value`

