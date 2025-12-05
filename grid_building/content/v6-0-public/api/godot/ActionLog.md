---
title: "ActionLog"
description: ""
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/actionlog/"
---

# ActionLog

```csharp
GridBuilding.Godot.UI
class ActionLog
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/UI/ActionLog.cs`  
**Namespace:** `GridBuilding.Godot.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### MaxEntries

```csharp
[Export] public int MaxEntries 
        { 
            get => _maxEntries; 
            set => SetMaxEntries(value);
        }
```

### AutoScroll

```csharp
[Export] public bool AutoScroll 
        { 
            get => _autoScroll; 
            set => SetAutoScroll(value);
        }
```

### ShowTimestamps

```csharp
[Export] public bool ShowTimestamps 
        { 
            get => _showTimestamps; 
            set => SetShowTimestamps(value);
        }
```

### ShowPositions

```csharp
[Export] public bool ShowPositions 
        { 
            get => _showPositions; 
            set => SetShowPositions(value);
        }
```

### ActionColor

```csharp
[Export] public Color ActionColor { get; set; } = Colors.White;
```

### ErrorColor

```csharp
[Export] public Color ErrorColor { get; set; } = Colors.Red;
```

### WarningColor

```csharp
[Export] public Color WarningColor { get; set; } = Colors.Yellow;
```

### InfoColor

```csharp
[Export] public Color InfoColor { get; set; } = Colors.LightBlue;
```

### EntryCount

```csharp
public int EntryCount => _logEntries?.Count ?? 0;
```


## Methods

### _Ready

```csharp
public override void _Ready()
        {
            base._Ready();
            
            _logEntries = new List<LogEntry>();
            
            // Set up initial styling
            SetupStyling();
            
            // Log initial message
            LogInfo("Action log initialized");
        }
```

**Returns:** `void`

### LogAction

```csharp
/// <summary>
        /// Logs an action
        /// </summary>
        /// <param name="action">Action description</param>
        /// <param name="position">Position where action occurred</param>
        public void LogAction(string action, Vector2 position)
        {
            var entry = new LogEntry(action, position, LogType.Action);
            AddLogEntry(entry);
            
            EmitSignal(SignalName.ActionLogged, action, position);
        }
```

Logs an action

**Returns:** `void`

**Parameters:**
- `string action`
- `Vector2 position`

### LogError

```csharp
/// <summary>
        /// Logs an error
        /// </summary>
        /// <param name="error">Error message</param>
        public void LogError(string error)
        {
            var entry = new LogEntry(error, Vector2.Zero, LogType.Error);
            AddLogEntry(entry);
            
            EmitSignal(SignalName.ErrorLogged, error);
        }
```

Logs an error

**Returns:** `void`

**Parameters:**
- `string error`

### LogWarning

```csharp
/// <summary>
        /// Logs a warning
        /// </summary>
        /// <param name="warning">Warning message</param>
        public void LogWarning(string warning)
        {
            var entry = new LogEntry(warning, Vector2.Zero, LogType.Warning);
            AddLogEntry(entry);
        }
```

Logs a warning

**Returns:** `void`

**Parameters:**
- `string warning`

### LogInfo

```csharp
/// <summary>
        /// Logs an info message
        /// </summary>
        /// <param name="info">Info message</param>
        public void LogInfo(string info)
        {
            var entry = new LogEntry(info, Vector2.Zero, LogType.Info);
            AddLogEntry(entry);
        }
```

Logs an info message

**Returns:** `void`

**Parameters:**
- `string info`

### ClearLog

```csharp
/// <summary>
        /// Clears all log entries
        /// </summary>
        public void ClearLog()
        {
            _logEntries.Clear();
            Clear();
            
            EmitSignal(SignalName.LogCleared);
        }
```

Clears all log entries

**Returns:** `void`

### GetEntriesByType

```csharp
/// <summary>
        /// Gets log entries by type
        /// </summary>
        /// <param name="type">Log type to filter by</param>
        /// <returns>List of log entries of the specified type</returns>
        public List<LogEntry> GetEntriesByType(LogType type)
        {
            var entries = new List<LogEntry>();
            
            foreach (var entry in _logEntries)
            {
                if (entry.Type == type)
                {
                    entries.Add(entry);
                }
            }
            
            return entries;
        }
```

Gets log entries by type

**Returns:** `List<LogEntry>`

**Parameters:**
- `LogType type`

### GetEntriesByTimeRange

```csharp
/// <summary>
        /// Gets log entries in a time range
        /// </summary>
        /// <param name="startTime">Start time</param>
        /// <param name="endTime">End time</param>
        /// <returns>List of log entries in the time range</returns>
        public List<LogEntry> GetEntriesByTimeRange(DateTime startTime, DateTime endTime)
        {
            var entries = new List<LogEntry>();
            
            foreach (var entry in _logEntries)
            {
                if (entry.Timestamp >= startTime && entry.Timestamp <= endTime)
                {
                    entries.Add(entry);
                }
            }
            
            return entries;
        }
```

Gets log entries in a time range

**Returns:** `List<LogEntry>`

**Parameters:**
- `DateTime startTime`
- `DateTime endTime`

### GetLastEntry

```csharp
/// <summary>
        /// Gets the most recent log entry
        /// </summary>
        /// <returns>Most recent log entry</returns>
        public LogEntry? GetLastEntry()
        {
            return _logEntries.Count > 0 ? _logEntries[_logEntries.Count - 1] : null;
        }
```

Gets the most recent log entry

**Returns:** `LogEntry?`

### SearchEntries

```csharp
/// <summary>
        /// Gets log entries containing specific text
        /// </summary>
        /// <param name="searchText">Text to search for</param>
        /// <param name="caseSensitive">Whether search is case sensitive</param>
        /// <returns>List of matching log entries</returns>
        public List<LogEntry> SearchEntries(string searchText, bool caseSensitive = false)
        {
            var entries = new List<LogEntry>();
            var comparison = caseSensitive ? StringComparison.Ordinal : StringComparison.OrdinalIgnoreCase;
            
            foreach (var entry in _logEntries)
            {
                if (entry.Message.Contains(searchText, comparison))
                {
                    entries.Add(entry);
                }
            }
            
            return entries;
        }
```

Gets log entries containing specific text

**Returns:** `List<LogEntry>`

**Parameters:**
- `string searchText`
- `bool caseSensitive`

### ExportLog

```csharp
/// <summary>
        /// Exports log entries to a string
        /// </summary>
        /// <param name="includeTimestamps">Whether to include timestamps</param>
        /// <param name="includePositions">Whether to include positions</param>
        /// <returns>Exported log string</returns>
        public string ExportLog(bool includeTimestamps = true, bool includePositions = true)
        {
            var export = new System.Text.StringBuilder();
            
            foreach (var entry in _logEntries)
            {
                var line = "";
                
                // Add timestamp if requested
                if (includeTimestamps)
                {
                    line += $"{entry.Timestamp:yyyy-MM-dd HH:mm:ss} ";
                }
                
                // Add log type
                line += $"[{entry.Type}] ";
                
                // Add message
                line += entry.Message;
                
                // Add position if requested and valid
                if (includePositions && entry.Position != Vector2.Zero)
                {
                    line += $" (at {entry.Position.X:F1}, {entry.Position.Y:F1})";
                }
                
                export.AppendLine(line);
            }
            
            return export.ToString();
        }
```

Exports log entries to a string

**Returns:** `string`

**Parameters:**
- `bool includeTimestamps`
- `bool includePositions`

### SetMaxEntries

```csharp
/// <summary>
        /// Sets the maximum number of entries
        /// </summary>
        /// <param name="maxEntries">Maximum number of entries</param>
        public void SetMaxEntries(int maxEntries)
        {
            _maxEntries = Mathf.Max(1, maxEntries);
            
            // Remove excess entries if needed
            while (_logEntries.Count > _maxEntries)
            {
                _logEntries.RemoveAt(0);
            }
            
            UpdateDisplay();
        }
```

Sets the maximum number of entries

**Returns:** `void`

**Parameters:**
- `int maxEntries`

### SetAutoScroll

```csharp
/// <summary>
        /// Sets auto-scroll behavior
        /// </summary>
        /// <param name="autoScroll">Whether to auto-scroll</param>
        public void SetAutoScroll(bool autoScroll)
        {
            _autoScroll = autoScroll;
            ScrollFollowing = autoScroll;
        }
```

Sets auto-scroll behavior

**Returns:** `void`

**Parameters:**
- `bool autoScroll`

### SetShowTimestamps

```csharp
/// <summary>
        /// Sets whether to show timestamps
        /// </summary>
        /// <param name="showTimestamps">Whether to show timestamps</param>
        public void SetShowTimestamps(bool showTimestamps)
        {
            _showTimestamps = showTimestamps;
            UpdateDisplay();
        }
```

Sets whether to show timestamps

**Returns:** `void`

**Parameters:**
- `bool showTimestamps`

### SetShowPositions

```csharp
/// <summary>
        /// Sets whether to show positions
        /// </summary>
        /// <param name="showPositions">Whether to show positions</param>
        public void SetShowPositions(bool showPositions)
        {
            _showPositions = showPositions;
            UpdateDisplay();
        }
```

Sets whether to show positions

**Returns:** `void`

**Parameters:**
- `bool showPositions`

### SetLogTypeColor

```csharp
/// <summary>
        /// Sets the color for a log type
        /// </summary>
        /// <param name="type">Log type</param>
        /// <param name="color">Color to set</param>
        public void SetLogTypeColor(LogType type, Color color)
        {
            switch (type)
            {
                case LogType.Action:
                    ActionColor = color;
                    break;
                case LogType.Error:
                    ErrorColor = color;
                    break;
                case LogType.Warning:
                    WarningColor = color;
                    break;
                case LogType.Info:
                    InfoColor = color;
                    break;
            }
            
            UpdateDisplay();
        }
```

Sets the color for a log type

**Returns:** `void`

**Parameters:**
- `LogType type`
- `Color color`

### ScrollToEnd

```csharp
/// <summary>
        /// Scrolls to the end of the log
        /// </summary>
        public void ScrollToEnd()
        {
            ScrollToLine(GetLineCount() - 1);
        }
```

Scrolls to the end of the log

**Returns:** `void`

