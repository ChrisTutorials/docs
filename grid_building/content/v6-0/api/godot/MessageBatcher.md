---
title: "MessageBatcher"
description: "Utility for batching print statements to reduce console spam.
Collects messages and outputs them in a single print call."
weight: 20
url: "/gridbuilding/v6-0/api/godot/messagebatcher/"
---

# MessageBatcher

```csharp
GridBuilding.Godot.Shared.Utils.Logging
class MessageBatcher
{
    // Members...
}
```

Utility for batching print statements to reduce console spam.
Collects messages and outputs them in a single print call.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/MessageBatcher.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Logging`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Instance

```csharp
/// <summary>
    /// Get or create singleton instance.
    /// </summary>
    public static MessageBatcher Instance => _instance ??= new MessageBatcher();
```

Get or create singleton instance.

### MaxMessages

```csharp
#endregion

    #region Public Properties

    /// <summary>
    /// Maximum number of messages before auto-flush.
    /// </summary>
    public int MaxMessages { get; set; } = DefaultMaxMessages;
```

Maximum number of messages before auto-flush.

### Enabled

```csharp
/// <summary>
    /// Whether batching is enabled.
    /// </summary>
    public bool Enabled
    {
        get => _enabled;
        set => _enabled = value;
    }
```

Whether batching is enabled.

### Prefix

```csharp
/// <summary>
    /// Prefix for all messages.
    /// </summary>
    public string Prefix
    {
        get => _prefix;
        set => _prefix = value ?? string.Empty;
    }
```

Prefix for all messages.

### Count

```csharp
/// <summary>
    /// Count of buffered messages.
    /// </summary>
    public int Count => _messages.Count;
```

Count of buffered messages.

### HasMessages

```csharp
/// <summary>
    /// Whether there are buffered messages.
    /// </summary>
    public bool HasMessages => _messages.Count > 0;
```

Whether there are buffered messages.


## Methods

### SetEnabled

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Enable/disable batching.
    /// </summary>
    /// <param name="value">Whether to enable batching</param>
    public void SetEnabled(bool value)
    {
        _enabled = value;
    }
```

Enable/disable batching.

**Returns:** `void`

**Parameters:**
- `bool value`

### SetPrefix

```csharp
/// <summary>
    /// Set prefix for all messages.
    /// </summary>
    /// <param name="text">Prefix text</param>
    public void SetPrefix(string text)
    {
        _prefix = text ?? string.Empty;
    }
```

Set prefix for all messages.

**Returns:** `void`

**Parameters:**
- `string text`

### Add

```csharp
/// <summary>
    /// Add a message to the batch.
    /// </summary>
    /// <param name="message">Message to add</param>
    public void Add(string message)
    {
        if (!_enabled)
        {
            GD.Print(_prefix + message);
            return;
        }

        _messages.Add(message);

        // Auto-flush if too many messages
        if (_messages.Count >= MaxMessages)
        {
            Flush();
        }
    }
```

Add a message to the batch.

**Returns:** `void`

**Parameters:**
- `string message`

### AddFormatted

```csharp
/// <summary>
    /// Add formatted message (like print with multiple arguments).
    /// </summary>
    /// <param name="message">Message format string with %s placeholders</param>
    /// <param name="args">Arguments to format into the message</param>
    public void AddFormatted(string message, params object[] args)
    {
        if (args.Length == 0)
        {
            Add(message);
            return;
        }

        var formatted = message;
        foreach (var arg in args)
        {
            // Replace first occurrence of %s
            var pos = formatted.IndexOf("%s", StringComparison.Ordinal);
            if (pos >= 0)
            {
                formatted = formatted.Substring(0, pos) + arg + formatted.Substring(pos + 2);
            }
        }
        Add(formatted);
    }
```

Add formatted message (like print with multiple arguments).

**Returns:** `void`

**Parameters:**
- `string message`
- `object[] args`

### Flush

```csharp
/// <summary>
    /// Flush all buffered messages.
    /// </summary>
    public void Flush()
    {
        if (_messages.Count == 0)
            return;

        if (_enabled)
        {
            var output = _prefix + string.Join("\n", _messages);
            GD.Print(output);
        }

        _messages.Clear();
    }
```

Flush all buffered messages.

**Returns:** `void`

### Clear

```csharp
/// <summary>
    /// Clear all buffered messages without output.
    /// </summary>
    public void Clear()
    {
        _messages.Clear();
    }
```

Clear all buffered messages without output.

**Returns:** `void`

### CreateScope

```csharp
/// <summary>
    /// Create a scoped batcher that auto-flushes on exit.
    /// </summary>
    /// <param name="enabled">Whether to enable batching in the scope</param>
    /// <returns>A ScopedBatcher that will auto-fllush when disposed</returns>
    public ScopedBatcher CreateScope(bool enabled = true)
    {
        return new ScopedBatcher(this, enabled);
    }
```

Create a scoped batcher that auto-flushes on exit.

**Returns:** `ScopedBatcher`

**Parameters:**
- `bool enabled`

