---
title: "MockMaterialContainer"
description: "Mock material container that simulates inventory behavior."
weight: 20
url: "/gridbuilding/v6-0/api/godot/mockmaterialcontainer/"
---

# MockMaterialContainer

```csharp
GridBuilding.Godot.Tests.Placement
class MockMaterialContainer
{
    // Members...
}
```

Mock material container that simulates inventory behavior.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Placement/SpendMaterialsRuleGenericTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Placement`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetResourceCount

```csharp
public int GetResourceCount(Resource resource)
        {
            return _resourceCounts.GetValueOrDefault(resource, 0);
        }
```

**Returns:** `int`

**Parameters:**
- `Resource resource`

### SetResourceCount

```csharp
public void SetResourceCount(Resource resource, int count)
        {
            _resourceCounts[resource] = count;
        }
```

**Returns:** `void`

**Parameters:**
- `Resource resource`
- `int count`

### TryRemove

```csharp
public int TryRemove(Resource resource, int count)
        {
            var available = GetResourceCount(resource);
            var toRemove = Mathf.Min(available, count);
            
            if (toRemove > 0)
            {
                _resourceCounts[resource] = available - toRemove;
            }
            
            return toRemove;
        }
```

**Returns:** `int`

**Parameters:**
- `Resource resource`
- `int count`

### HasMethod

```csharp
public bool HasMethod(string methodName)
        {
            return methodName == "try_remove" || methodName == "get_count";
        }
```

**Returns:** `bool`

**Parameters:**
- `string methodName`

### Call

```csharp
public Variant Call(string methodName, params Variant[] args)
        {
            switch (methodName)
            {
                case "try_remove":
                    return TryRemove(args[0].As<Resource>(), args[1].AsInt());
                case "get_count":
                    return GetResourceCount(args[0].As<Resource>());
                default:
                    throw new System.NotSupportedException($"Method {methodName} not supported");
            }
        }
```

**Returns:** `Variant`

**Parameters:**
- `string methodName`
- `Variant[] args`

