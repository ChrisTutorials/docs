---
title: "ActionLogSettings"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/actionlogsettings/"
---

# ActionLogSettings

```csharp
GridBuilding.Godot.Tests.Resources.Settings
class ActionLogSettings
{
    // Members...
}
```

Settings that define what and how the build log UI displays gameplay messaging content.
Ported from: godot/addons/grid_building/core/resources/settings/action_log_settings.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Settings/ActionLogSettings.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Resources.Settings`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### OnReadyMessage

```csharp
#region Message Log Settings
    
    /// <summary>
    /// If set, will show this when the build log starts
    /// </summary>
    public string OnReadyMessage { get; set; } = "";
```

If set, will show this when the build log starts

### BulletStyle

```csharp
/// <summary>
    /// List bullet style
    /// </summary>
    public string BulletStyle { get; set; } = "•";
```

List bullet style

### FailedColor

```csharp
/// <summary>
    /// Color for failed messages
    /// </summary>
    public GBColor FailedColor { get; set; } = GBColor.LightCoral;
```

Color for failed messages

### SuccessColor

```csharp
/// <summary>
    /// Color for success messages
    /// </summary>
    public GBColor SuccessColor { get; set; } = GBColor.LightBlue;
```

Color for success messages

### ShowValidationMessage

```csharp
#endregion

    #region Validation Results
    
    /// <summary>
    /// Show the base messages from ValidationResults
    /// </summary>
    public bool ShowValidationMessage { get; set; } = false;
```

Show the base messages from ValidationResults

### PrintFailedReasons

```csharp
/// <summary>
    /// Show the reasons for a build failing
    /// </summary>
    public bool PrintFailedReasons { get; set; } = true;
```

Show the reasons for a build failing

### PrintOnDragBuild

```csharp
/// <summary>
    /// Should printing still happen for drag build. 
    /// Warning: This may generate a lot of messages
    /// </summary>
    public bool PrintOnDragBuild { get; set; } = false;
```

Should printing still happen for drag build.
Warning: This may generate a lot of messages

### PrintSuccessReasons

```csharp
/// <summary>
    /// When a build validation succeeds, print all of the success reason messages to the log
    /// </summary>
    public bool PrintSuccessReasons { get; set; } = false;
```

When a build validation succeeds, print all of the success reason messages to the log

### ShowDemolish

```csharp
#endregion

    #region Action Messages
    
    /// <summary>
    /// Print message on successful demolish
    /// </summary>
    public bool ShowDemolish { get; set; } = true;
```

Print message on successful demolish

### ShowMoveStarted

```csharp
/// <summary>
    /// Print message when move starts (pickup)
    /// </summary>
    public bool ShowMoveStarted { get; set; } = false;
```

Print message when move starts (pickup)

### ShowMoveFinished

```csharp
/// <summary>
    /// Print message when move finishes (placement/cancel)
    /// </summary>
    public bool ShowMoveFinished { get; set; } = true;
```

Print message when move finishes (placement/cancel)

### ShowModeChanges

```csharp
/// <summary>
    /// Print message when mode changes
    /// </summary>
    public bool ShowModeChanges { get; set; } = true;
```

Print message when mode changes

### ModeChangeMessage

```csharp
/// <summary>
    /// Message format for mode changes (use {0} for mode name)
    /// </summary>
    public string ModeChangeMessage { get; set; } = "Mode changed to: {0}";
```

Message format for mode changes (use {0} for mode name)

### BuiltMessage

```csharp
/// <summary>
    /// Message on successful build
    /// </summary>
    public string BuiltMessage { get; set; } = "Built {0}.";
```

Message on successful build

### FailBuildMessage

```csharp
/// <summary>
    /// Message on failed build
    /// </summary>
    public string FailBuildMessage { get; set; } = "Unable to build a {0}.";
```

Message on failed build

### ManipulationMessage

```csharp
/// <summary>
    /// Message format for manipulation operations
    /// </summary>
    public string ManipulationMessage { get; set; } = "Manipulation: {0}";
```

Message format for manipulation operations

### MaxFailureReasons

```csharp
#endregion

    #region Display Formatting
    
    /// <summary>
    /// Maximum number of failure reasons to display before truncation
    /// </summary>
    public int MaxFailureReasons { get; set; } = 5;
```

Maximum number of failure reasons to display before truncation

### IssueBulletPrefix

```csharp
/// <summary>
    /// Bullet prefix for issue lists
    /// </summary>
    public string IssueBulletPrefix { get; set; } = "- ";
```

Bullet prefix for issue lists


## Methods

### GetEditorIssues

```csharp
#endregion

    #region Validation

    /// <summary>
    /// Returns an array of issues found during editor validation
    /// </summary>
    public List<string> GetEditorIssues()
    {
        var issues = new List<string>();

        if (string.IsNullOrEmpty(BulletStyle))
        {
            issues.Add("ActionLogSettings bullet_style is empty");
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

