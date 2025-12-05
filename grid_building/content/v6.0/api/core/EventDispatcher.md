---
title: "EventDispatcher"
description: ""
weight: 10
url: "/gridbuilding/v6.0/api/core/eventdispatcher/"
---

# EventDispatcher

```csharp
GridBuilding.Core.Services
class EventDispatcher
{
    // Members...
}
```

Thread-safe implementation of central event dispatcher

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Common/EventDispatcher.cs`  
**Namespace:** `GridBuilding.Core.Services`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Subscribe

```csharp
public void Subscribe<T>(Action<T> handler) where T : GameEvent
    {
        _lock.EnterWriteLock();
        try
        {
            var eventType = typeof(T);
            if (!_subscribers.ContainsKey(eventType))
            {
                _subscribers[eventType] = new List<Delegate>();
            }
            
            // Avoid duplicate subscriptions
            if (!_subscribers[eventType].Contains(handler))
            {
                _subscribers[eventType].Add(handler);
            }
        }
        finally
        {
            _lock.ExitWriteLock();
        }
    }
```

**Returns:** `void`

**Parameters:**
- `Action<T> handler`

### Unsubscribe

```csharp
public void Unsubscribe<T>(Action<T> handler) where T : GameEvent
    {
        _lock.EnterWriteLock();
        try
        {
            var eventType = typeof(T);
            if (_subscribers.ContainsKey(eventType))
            {
                _subscribers[eventType].Remove(handler);
                
                // Clean up empty event types
                if (_subscribers[eventType].Count == 0)
                {
                    _subscribers.Remove(eventType);
                }
            }
        }
        finally
        {
            _lock.ExitWriteLock();
        }
    }
```

**Returns:** `void`

**Parameters:**
- `Action<T> handler`

### Publish

```csharp
public void Publish<T>(T gameEvent) where T : GameEvent
    {
        List<Delegate> handlers;
        
        _lock.EnterReadLock();
        try
        {
            var eventType = typeof(T);
            if (!_subscribers.TryGetValue(eventType, out handlers) || handlers.Count == 0)
            {
                return;
            }
            
            // Create a copy to avoid modification during enumeration
            handlers = new List<Delegate>(handlers);
        }
        finally
        {
            _lock.ExitReadLock();
        }
        
        // Invoke handlers outside of lock to prevent deadlocks
        foreach (var handler in handlers)
        {
            try
            {
                ((Action<T>)handler)(gameEvent);
            }
            catch (Exception ex)
            {
                // Log error but don't let one handler failure stop others
                Console.WriteLine($"Error in event handler for {typeof(T).Name}: {ex.Message}");
            }
        }
    }
```

**Returns:** `void`

**Parameters:**
- `T gameEvent`

### ClearAllSubscribers

```csharp
public void ClearAllSubscribers()
    {
        _lock.EnterWriteLock();
        try
        {
            _subscribers.Clear();
        }
        finally
        {
            _lock.ExitWriteLock();
        }
    }
```

**Returns:** `void`

### GetActiveEventTypes

```csharp
public IEnumerable<Type> GetActiveEventTypes()
    {
        _lock.EnterReadLock();
        try
        {
            return new List<Type>(_subscribers.Keys);
        }
        finally
        {
            _lock.ExitReadLock();
        }
    }
```

**Returns:** `IEnumerable<Type>`

### GetSubscriberCount

```csharp
public int GetSubscriberCount<T>() where T : GameEvent
    {
        _lock.EnterReadLock();
        try
        {
            var eventType = typeof(T);
            return _subscribers.TryGetValue(eventType, out var handlers) ? handlers.Count : 0;
        }
        finally
        {
            _lock.ExitReadLock();
        }
    }
```

**Returns:** `int`

### Dispose

```csharp
public void Dispose()
    {
        _lock.Dispose();
    }
```

**Returns:** `void`

