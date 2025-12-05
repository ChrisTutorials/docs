---
title: "CursorSettings"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/cursorsettings/"
---

# CursorSettings

```csharp
GridBuilding.Godot.Tests.Resources.Visual
class CursorSettings
{
    // Members...
}
```

Set of cursor textures for use with grid builder plugin.
In C#, textures are represented as string paths or null.
In Godot, these would be actual Texture references.
Ported from: godot/addons/grid_building/shared/components/ui_controls/cursor_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Visual/CursorSettings.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Resources.Visual`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### InfoCursor

```csharp
/// <summary>
    /// Cursor for info mode
    /// </summary>
    public string? InfoCursor { get; set; }
```

Cursor for info mode

### BuildCursor

```csharp
/// <summary>
    /// Cursor for build mode
    /// </summary>
    public string? BuildCursor { get; set; }
```

Cursor for build mode

### MoveCursor

```csharp
/// <summary>
    /// Cursor for move mode
    /// </summary>
    public string? MoveCursor { get; set; }
```

Cursor for move mode

### DemolishCursor

```csharp
/// <summary>
    /// Cursor for demolish mode
    /// </summary>
    public string? DemolishCursor { get; set; }
```

Cursor for demolish mode


## Methods

### GetEditorIssues

```csharp
/// <summary>
    /// Returns an array of issues found during editor validation
    /// </summary>
    public List<string> GetEditorIssues()
    {
        var issues = new List<string>();

        if (InfoCursor == null)
        {
            issues.Add("CursorSettings info texture is not set");
        }

        if (BuildCursor == null)
        {
            issues.Add("CursorSettings build texture is not set");
        }

        if (MoveCursor == null)
        {
            issues.Add("CursorSettings move texture is not set");
        }

        if (DemolishCursor == null)
        {
            issues.Add("CursorSettings demolish texture is not set");
        }

        return issues;
    }
```

Returns an array of issues found during editor validation

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
    /// Returns an array of issues found during runtime validation
    /// </summary>
    public List<string> GetRuntimeIssues()
    {
        var issues = new List<string>();
        issues.AddRange(GetEditorIssues());
        return issues;
    }
```

Returns an array of issues found during runtime validation

**Returns:** `List<string>`

