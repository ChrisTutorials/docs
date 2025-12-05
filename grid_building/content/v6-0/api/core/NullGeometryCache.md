---
title: "NullGeometryCache"
description: "Null implementation of geometry cache for testing"
weight: 10
url: "/gridbuilding/v6-0/api/core/nullgeometrycache/"
---

# NullGeometryCache

```csharp
GridBuilding.Core.Geometry
class NullGeometryCache
{
    // Members...
}
```

Null implementation of geometry cache for testing

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Geometry/CollisionProcessor.cs`  
**Namespace:** `GridBuilding.Core.Geometry`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Count

```csharp
public int Count => 0;
```

### IsReadOnly

```csharp
public bool IsReadOnly => true;
```

### MaxSize

```csharp
public int MaxSize { get; set; } = 0;
```

### EvictionPolicy

```csharp
public CacheEvictionPolicy EvictionPolicy { get; set; } = CacheEvictionPolicy.None;
```

### Metrics

```csharp
public CacheMetrics Metrics { get; } = new CacheMetrics();
```


## Methods

### GetOrAdd

```csharp
public T GetOrAdd<T>(string key, Func<T> factory)
    {
        return factory();
    }
```

**Returns:** `T`

**Parameters:**
- `string key`
- `Func<T> factory`

### GetOrAdd

```csharp
public T GetOrAdd<T>(string key, Func<string, T> factory)
    {
        return factory(key);
    }
```

**Returns:** `T`

**Parameters:**
- `string key`
- `Func<string, T> factory`

### GetOrAdd

```csharp
// ICache<string, object> specific implementations
    public object GetOrAdd(string key, Func<object> factory)
    {
        return factory();
    }
```

**Returns:** `object`

**Parameters:**
- `string key`
- `Func<object> factory`

### GetOrAdd

```csharp
public object GetOrAdd(string key, Func<string, object> factory)
    {
        return factory(key);
    }
```

**Returns:** `object`

**Parameters:**
- `string key`
- `Func<string, object> factory`

### Get

```csharp
public T Get<T>(string key)
    {
        throw new KeyNotFoundException("NullGeometryCache does not store any values");
    }
```

**Returns:** `T`

**Parameters:**
- `string key`

### Set

```csharp
public void Set<T>(string key, T value)
    {
        // Null implementation - does nothing
    }
```

**Returns:** `void`

**Parameters:**
- `string key`
- `T value`

### TryGetValue

```csharp
public bool TryGetValue<T>(string key, out T value)
    {
        value = default(T)!;
        return false;
    }
```

**Returns:** `bool`

**Parameters:**
- `string key`
- `T value`

### TryGetValue

```csharp
public bool TryGetValue(string key, out object value)
    {
        value = null!;
        return false;
    }
```

**Returns:** `bool`

**Parameters:**
- `string key`
- `object value`

### Set

```csharp
public void Set(string key, object value)
    {
        // Null implementation - does nothing
    }
```

**Returns:** `void`

**Parameters:**
- `string key`
- `object value`

### Remove

```csharp
public bool Remove(string key)
    {
        return false;
    }
```

**Returns:** `bool`

**Parameters:**
- `string key`

### ContainsKey

```csharp
public bool ContainsKey(string key)
    {
        return false;
    }
```

**Returns:** `bool`

**Parameters:**
- `string key`

### Clear

```csharp
public void Clear()
    {
        // Null implementation - does nothing
    }
```

**Returns:** `void`

### GetKeys

```csharp
public IEnumerable<string> GetKeys()
    {
        return Enumerable.Empty<string>();
    }
```

**Returns:** `IEnumerable<string>`

### GetValues

```csharp
public IEnumerable<object> GetValues()
    {
        return Enumerable.Empty<object>();
    }
```

**Returns:** `IEnumerable<object>`

