---
title: "TimeUtils"
description: "Pure C# time utilities to replace Godot's Time class.
Provides AOT-compatible time operations for iOS/Android."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/timeutils/"
---

# TimeUtils

```csharp
GridBuilding.Core.Time
class TimeUtils
{
    // Members...
}
```

Pure C# time utilities to replace Godot's Time class.
Provides AOT-compatible time operations for iOS/Android.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Time/TimeUtils.cs`  
**Namespace:** `GridBuilding.Core.Time`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetUnixTime

```csharp
/// <summary>
    /// Gets the current Unix timestamp in seconds.
    /// Equivalent to Godot's Time.GetUnixTimeFromSystem().
    /// </summary>
    public static double GetUnixTime()
    {
        return DateTimeOffset.UtcNow.ToUnixTimeSeconds();
    }
```

Gets the current Unix timestamp in seconds.
Equivalent to Godot's Time.GetUnixTimeFromSystem().

**Returns:** `double`

### GetUnixTimeMilliseconds

```csharp
/// <summary>
    /// Gets the current Unix timestamp in milliseconds.
    /// </summary>
    public static long GetUnixTimeMilliseconds()
    {
        return DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();
    }
```

Gets the current Unix timestamp in milliseconds.

**Returns:** `long`

### GetUnixTimePrecise

```csharp
/// <summary>
    /// Gets the current Unix timestamp with fractional seconds.
    /// More precise than GetUnixTime().
    /// </summary>
    public static double GetUnixTimePrecise()
    {
        return DateTimeOffset.UtcNow.ToUnixTimeMilliseconds() / 1000.0;
    }
```

Gets the current Unix timestamp with fractional seconds.
More precise than GetUnixTime().

**Returns:** `double`

### GetDateTimeString

```csharp
/// <summary>
    /// Gets the current time as a formatted string.
    /// </summary>
    public static string GetDateTimeString(string format = "yyyy-MM-dd HH:mm:ss")
    {
        return DateTime.Now.ToString(format);
    }
```

Gets the current time as a formatted string.

**Returns:** `string`

**Parameters:**
- `string format`

### GetDateTimeStringUtc

```csharp
/// <summary>
    /// Gets the current UTC time as a formatted string.
    /// </summary>
    public static string GetDateTimeStringUtc(string format = "yyyy-MM-dd HH:mm:ss")
    {
        return DateTime.UtcNow.ToString(format);
    }
```

Gets the current UTC time as a formatted string.

**Returns:** `string`

**Parameters:**
- `string format`

### FromUnixTime

```csharp
/// <summary>
    /// Converts Unix timestamp to DateTime.
    /// </summary>
    public static DateTime FromUnixTime(double unixTime)
    {
        return DateTimeOffset.FromUnixTimeSeconds((long)unixTime).DateTime;
    }
```

Converts Unix timestamp to DateTime.

**Returns:** `DateTime`

**Parameters:**
- `double unixTime`

### FromUnixTimeMilliseconds

```csharp
/// <summary>
    /// Converts Unix timestamp in milliseconds to DateTime.
    /// </summary>
    public static DateTime FromUnixTimeMilliseconds(long unixTimeMs)
    {
        return DateTimeOffset.FromUnixTimeMilliseconds(unixTimeMs).DateTime;
    }
```

Converts Unix timestamp in milliseconds to DateTime.

**Returns:** `DateTime`

**Parameters:**
- `long unixTimeMs`

### GetElapsedSeconds

```csharp
/// <summary>
    /// Gets elapsed time in seconds between two Unix timestamps.
    /// </summary>
    public static double GetElapsedSeconds(double startTime, double endTime)
    {
        return endTime - startTime;
    }
```

Gets elapsed time in seconds between two Unix timestamps.

**Returns:** `double`

**Parameters:**
- `double startTime`
- `double endTime`

### GetElapsedSecondsSince

```csharp
/// <summary>
    /// Gets elapsed time in seconds since a Unix timestamp.
    /// </summary>
    public static double GetElapsedSecondsSince(double startTime)
    {
        return GetUnixTimePrecise() - startTime;
    }
```

Gets elapsed time in seconds since a Unix timestamp.

**Returns:** `double`

**Parameters:**
- `double startTime`

### HasDurationPassed

```csharp
/// <summary>
    /// Checks if a duration has passed since a given timestamp.
    /// </summary>
    public static bool HasDurationPassed(double startTime, double durationSeconds)
    {
        return GetElapsedSecondsSince(startTime) >= durationSeconds;
    }
```

Checks if a duration has passed since a given timestamp.

**Returns:** `bool`

**Parameters:**
- `double startTime`
- `double durationSeconds`

