---
title: "GeometryCache"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/geometrycache/"
---

# GeometryCache

```csharp
GridBuilding.Core.Services.DI
class GeometryCache
{
    // Members...
}
```

Thread-safe geometry cache for storing and retrieving computed geometric data.
Improves performance by caching expensive geometric calculations.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Services/DI/GeometryCache.cs`  
**Namespace:** `GridBuilding.Core.Services.DI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Count

```csharp
/// <summary>
    /// Gets the number of entries currently in the cache (including expired ones).
    /// </summary>
    public int Count => _cache.Count;
```

Gets the number of entries currently in the cache (including expired ones).

### ActiveCount

```csharp
/// <summary>
    /// Gets the number of non-expired entries in the cache.
    /// </summary>
    public int ActiveCount
    {
        get
        {
            if (_disposed)
                return 0;

            var count = 0;
            var now = DateTime.UtcNow;
            
            foreach (var kvp in _cacheTimestamps)
            {
                if (kvp.Value > now)
                    count++;
            }
            
            return count;
        }
    }
```

Gets the number of non-expired entries in the cache.


## Methods

### GetOrCreate

```csharp
/// <summary>
    /// Gets or creates a cached value using a factory function.
    /// </summary>
    /// <typeparam name="T">Type of value to cache</typeparam>
    /// <param name="key">Cache key</param>
    /// <param name="factory">Function to create value if not in cache</param>
    /// <param name="expiration">Optional custom expiration time</param>
    /// <returns>Cached or newly created value</returns>
    public T GetOrCreate<T>(string key, Func<T> factory, TimeSpan? expiration = null) where T : class
    {
        if (_disposed)
            throw new ObjectDisposedException(nameof(GeometryCache));

        // Check if value exists and is not expired
        if (_cache.TryGetValue(key, out var cachedValue) && 
            cachedValue is T typedValue && 
            !IsExpired(key))
        {
            return typedValue;
        }

        // Create new value
        var newValue = factory();
        
        // Store in cache
        _cache[key] = newValue;
        _cacheTimestamps[key] = DateTime.UtcNow.Add(expiration ?? _defaultExpiration);
        
        return newValue;
    }
```

Gets or creates a cached value using a factory function.

**Returns:** `T`

**Parameters:**
- `string key`
- `Func<T> factory`
- `TimeSpan? expiration`

### TryGet

```csharp
/// <summary>
    /// Gets a value from the cache if it exists and is not expired.
    /// </summary>
    /// <typeparam name="T">Type of value</typeparam>
    /// <param name="key">Cache key</param>
    /// <param name="value">Output value if found</param>
    /// <returns>True if value was found and not expired</returns>
    public bool TryGet<T>(string key, out T? value) where T : class
    {
        if (_disposed)
        {
            value = default;
            return false;
        }

        if (_cache.TryGetValue(key, out var cachedValue) && 
            cachedValue is T typedValue && 
            !IsExpired(key))
        {
            value = typedValue;
            return true;
        }

        value = default;
        return false;
    }
```

Gets a value from the cache if it exists and is not expired.

**Returns:** `bool`

**Parameters:**
- `string key`
- `T? value`

### Set

```csharp
/// <summary>
    /// Stores a value in the cache with optional expiration.
    /// </summary>
    /// <typeparam name="T">Type of value</typeparam>
    /// <param name="key">Cache key</param>
    /// <param name="value">Value to store</param>
    /// <param name="expiration">Optional custom expiration time</param>
    public void Set<T>(string key, T value, TimeSpan? expiration = null) where T : class
    {
        if (_disposed)
            throw new ObjectDisposedException(nameof(GeometryCache));

        _cache[key] = value;
        _cacheTimestamps[key] = DateTime.UtcNow.Add(expiration ?? _defaultExpiration);
    }
```

Stores a value in the cache with optional expiration.

**Returns:** `void`

**Parameters:**
- `string key`
- `T value`
- `TimeSpan? expiration`

### Remove

```csharp
/// <summary>
    /// Removes a value from the cache.
    /// </summary>
    /// <param name="key">Cache key to remove</param>
    /// <returns>True if value was removed</returns>
    public bool Remove(string key)
    {
        if (_disposed)
            return false;

        _cacheTimestamps.TryRemove(key, out _);
        return _cache.TryRemove(key, out _);
    }
```

Removes a value from the cache.

**Returns:** `bool`

**Parameters:**
- `string key`

### Contains

```csharp
/// <summary>
    /// Checks if a key exists in the cache and is not expired.
    /// </summary>
    /// <param name="key">Cache key</param>
    /// <returns>True if key exists and is not expired</returns>
    public bool Contains(string key)
    {
        if (_disposed)
            return false;

        return _cache.ContainsKey(key) && !IsExpired(key);
    }
```

Checks if a key exists in the cache and is not expired.

**Returns:** `bool`

**Parameters:**
- `string key`

### ClearExpired

```csharp
/// <summary>
    /// Clears all expired entries from the cache.
    /// </summary>
    /// <returns>Number of entries removed</returns>
    public int ClearExpired()
    {
        if (_disposed)
            return 0;

        var expiredKeys = new List<string>();
        var now = DateTime.UtcNow;

        foreach (var kvp in _cacheTimestamps)
        {
            if (kvp.Value <= now)
            {
                expiredKeys.Add(kvp.Key);
            }
        }

        var removedCount = 0;
        foreach (var key in expiredKeys)
        {
            if (_cache.TryRemove(key, out _))
            {
                _cacheTimestamps.TryRemove(key, out _);
                removedCount++;
            }
        }

        return removedCount;
    }
```

Clears all expired entries from the cache.

**Returns:** `int`

### Clear

```csharp
/// <summary>
    /// Clears all entries from the cache.
    /// </summary>
    public void Clear()
    {
        if (_disposed)
            return;

        _cache.Clear();
        _cacheTimestamps.Clear();
    }
```

Clears all entries from the cache.

**Returns:** `void`

### GetStats

```csharp
/// <summary>
    /// Gets cache statistics for monitoring.
    /// </summary>
    /// <returns>Cache statistics</returns>
    public CacheStats GetStats()
    {
        if (_disposed)
            return new CacheStats { TotalEntries = 0, ActiveEntries = 0, ExpiredEntries = 0 };

        var expiredCount = 0;
        var now = DateTime.UtcNow;

        foreach (var kvp in _cacheTimestamps)
        {
            if (kvp.Value <= now)
                expiredCount++;
        }

        return new CacheStats
        {
            TotalEntries = _cache.Count,
            ActiveEntries = _cache.Count - expiredCount,
            ExpiredEntries = expiredCount
        };
    }
```

Gets cache statistics for monitoring.

**Returns:** `CacheStats`

### Dispose

```csharp
public void Dispose()
    {
        if (!_disposed)
        {
            lock (_lock)
            {
                if (!_disposed)
                {
                    _cache.Clear();
                    _cacheTimestamps.Clear();
                    _disposed = true;
                }
            }
        }
    }
```

**Returns:** `void`

### GetCachedDistance

```csharp
// Specialized geometry caching methods

    /// <summary>
    /// Caches distance calculations between positions.
    /// </summary>
    /// <param name="from">Starting position</param>
    /// <param name="to">Ending position</param>
    /// <param name="calculator">Distance calculator function</param>
    /// <returns>Calculated distance</returns>
    public int GetCachedDistance(Vector2I from, Vector2I to, Func<Vector2I, Vector2I, int> calculator)
    {
        var key = $"distance:{from.X},{from.Y}-{to.X},{to.Y}";
        return GetOrCreate(key, () => calculator(from, to));
    }
```

Caches distance calculations between positions.

**Returns:** `int`

**Parameters:**
- `Vector2I from`
- `Vector2I to`
- `Func<Vector2I, Vector2I, int> calculator`

### GetCachedPositionsInRadius

```csharp
/// <summary>
    /// Caches positions in radius calculations.
    /// </summary>
    /// <param name="center">Center position</param>
    /// <param name="radius">Radius to search</param>
    /// <param name="calculator">Positions calculator function</param>
    /// <returns>Array of positions in radius</returns>
    public Vector2I[] GetCachedPositionsInRadius(Vector2I center, int radius, Func<Vector2I, int, Vector2I[]> calculator)
    {
        var key = $"radius:{center.X},{center.Y}-{radius}";
        return GetOrCreate(key, () => calculator(center, radius));
    }
```

Caches positions in radius calculations.

**Returns:** `Vector2I[]`

**Parameters:**
- `Vector2I center`
- `int radius`
- `Func<Vector2I, int, Vector2I[]> calculator`

### GetCachedRectangleOverlap

```csharp
/// <summary>
    /// Caches rectangle overlap calculations.
    /// </summary>
    /// <param name="pos1">First rectangle position</param>
    /// <param name="size1">First rectangle size</param>
    /// <param name="pos2">Second rectangle position</param>
    /// <param name="size2">Second rectangle size</param>
    /// <param name="calculator">Overlap calculator function</param>
    /// <returns>True if rectangles overlap</returns>
    public bool GetCachedRectangleOverlap(Vector2I pos1, Vector2I size1, Vector2I pos2, Vector2I size2, Func<Vector2I, Vector2I, Vector2I, Vector2I, bool> calculator)
    {
        var key = $"overlap:{pos1.X},{pos1.Y},{size1.X},{size1.Y}-{pos2.X},{pos2.Y},{size2.X},{size2.Y}";
        return GetOrCreate(key, () => calculator(pos1, size1, pos2, size2));
    }
```

Caches rectangle overlap calculations.

**Returns:** `bool`

**Parameters:**
- `Vector2I pos1`
- `Vector2I size1`
- `Vector2I pos2`
- `Vector2I size2`
- `Func<Vector2I, Vector2I, Vector2I, Vector2I, bool> calculator`

