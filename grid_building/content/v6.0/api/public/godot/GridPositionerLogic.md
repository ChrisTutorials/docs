---
title: "GridPositionerLogic"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/gridpositionerlogic/"
---

# GridPositionerLogic

```csharp
GridBuilding.Godot.Systems.GridTargeting.GridPositioner
class GridPositionerLogic
{
    // Members...
}
```

Static utility class for GridPositioner logic (visibility and decision helpers).
This class contains static functions for computing visibility decisions
and diagnostic traces, making them easily unit testable without requiring
a full GridPositioner2D instance.
All functions are pure and depend only on their input parameters.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridPositioner/GridPositionerLogic.cs`  
**Namespace:** `GridBuilding.Godot.Systems.GridTargeting.GridPositioner`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ShouldBeVisible

```csharp
#endregion
    #region Visibility Logic
    /// Computes whether the positioner should be visible based on mode and settings.
    /// 
    /// Visibility is determined by the following priority order:
    /// 1. Mode-based visibility: OFF mode respects remain_active_in_off_mode, INFO mode is always hidden
    /// 2. Recent allowed input: If mouse input was recently allowed, show positioner
    /// 3. Cached mouse world override: If mouse world position exists and mouse input enabled, show positioner (overrides hide_on_handled)
    /// 4. Hide on handled: If mouse input enabled + hide_on_handled=true + input blocked, hide positioner
    /// 5. Default: Show positioner for active modes (BUILD, MOVE, etc.)
    /// Hide on handled behavior:
    /// - Only applies when targeting_settings.enable_mouse_input is true
    /// - When mouse input is disabled, hide_on_handled setting is ignored
    /// - Cached mouse world position takes precedence over hide_on_handled logic
    /// <param name="mode">The current building mode (BuildingMode)</param>
    /// <param name="targetingSettings">The targeting settings object</param>
    /// <param name="lastMouseInputStatus">Dictionary with last mouse input gate status</param>
    /// <param name="hasMouseWorld">Whether cached mouse world position exists</param>
    /// <returns>True if the positioner should be visible</returns>
    public static bool ShouldBeVisible(
        BuildingMode mode,
        GridTargetingSettings targetingSettings,
        MouseInputStatus lastMouseInputStatus,
        bool hasMouseWorld)
    {
        switch (mode)
        {
            case BuildingMode.Off:
                // Respect remain_active_in_off_mode setting
                return targetingSettings != null && targetingSettings.RemainActiveInOffMode;
            
            default:
                // If mouse input was recently allowed (we handled an InputEvent), always show
                if (lastMouseInputStatus != null && lastMouseInputStatus.Allowed)
                    return true;
                
                // Cached mouse world takes precedence over hide_on_handled blocking
                // This ensures retention behavior when we have valid cached position
                if (hasMouseWorld && targetingSettings != null && targetingSettings.EnableMouseInput)
                    return true;
                
                // hide_on_handled check comes after cached mouse world override
                // Only hide if input is blocked AND we don't have cached mouse world
                if (targetingSettings != null &&
                    targetingSettings.HideOnHandled &&
                    targetingSettings.EnableMouseInput)
                {
                    if (lastMouseInputStatus != null && !lastMouseInputStatus.Allowed)
                        return false;
                }
                return true;
        }
    }
```

**Returns:** `bool`

**Parameters:**
- `BuildingMode mode`
- `GridTargetingSettings targetingSettings`
- `MouseInputStatus lastMouseInputStatus`
- `bool hasMouseWorld`

### ShouldBeVisibleForMode

```csharp
/// Computes visibility for a specific mode value.
    /// <param name="mode">The mode to check</param>
    /// <param name="targetingSettings">The targeting settings</param>
    /// <returns>True if visible in this mode</returns>
    public static bool ShouldBeVisibleForMode(
        BuildingMode mode, 
        GridTargetingSettings targetingSettings)
    {
        switch (mode)
        {
            case BuildingMode.Info:
                return false;
            default:
                return true;
        }
    }
```

**Returns:** `bool`

**Parameters:**
- `BuildingMode mode`
- `GridTargetingSettings targetingSettings`

### IsPositionerActive

```csharp
/// Returns whether the positioner is considered active for the given mode/settings.
    /// <param name="mode">The current mode</param>
    /// <returns>True if positioner is active</returns>
    public static bool IsPositionerActive(
        BuildingMode mode, 
        GridTargetingSettings targetingSettings)
    {
        if (mode == BuildingMode.Off)
            return targetingSettings != null && targetingSettings.RemainActiveInOffMode;
        
        return true;
    }
```

**Returns:** `bool`

**Parameters:**
- `BuildingMode mode`
- `GridTargetingSettings targetingSettings`

### VisibilityReconcile

```csharp
#region Visibility Reconciliation
    /// Visibility reconciliation logic for process tick.
    /// <param name="mode">Current mode</param>
    /// <param name="targetingSettings">Targeting settings</param>
    /// <param name="currentVisible">Current visibility state</param>
    /// <param name="lastMouseInputStatus">Last mouse input status</param>
    /// <param name="hasMouseWorld">Whether mouse world position is cached</param>
    /// <returns>Visibility result with reason</returns>
    public static MouseEventVisibilityResult VisibilityReconcile(
        BuildingMode mode,
        GridTargetingSettings targetingSettings,
        bool currentVisible,
        MouseInputStatus lastMouseInputStatus,
        bool hasMouseWorld)
    {
        var shouldShow = ShouldBeVisible(mode, targetingSettings, lastMouseInputStatus, hasMouseWorld);
        var reason = shouldShow ? "reconcile_show" : "reconcile_hide";
        return new MouseEventVisibilityResult
        {
            Visible = shouldShow,
            Reason = reason
        };
    }
```

**Returns:** `MouseEventVisibilityResult`

**Parameters:**
- `BuildingMode mode`
- `GridTargetingSettings targetingSettings`
- `bool currentVisible`
- `MouseInputStatus lastMouseInputStatus`
- `bool hasMouseWorld`

### VisibilityOnProcessTick

```csharp
/// Visibility logic for process tick handling.
    /// <param name="inputReady">Whether input is ready</param>
    /// <param name="targetingSettings">Targeting settings</param>
    /// <param name="lastMouseInputStatus">Last mouse input status</param>
    /// <param name="hasMouseWorld">Whether mouse world position is cached</param>
    /// <returns>Visibility result with reason</returns>
    public static MouseEventVisibilityResult VisibilityOnProcessTick(
        bool inputReady,
        GridTargetingSettings targetingSettings,
        MouseInputStatus lastMouseInputStatus,
        bool hasMouseWorld)
    {
        // For process tick, we primarily handle hide_on_handled behavior
        if (targetingSettings != null &&
            targetingSettings.HideOnHandled &&
            targetingSettings.EnableMouseInput &&
            lastMouseInputStatus != null &&
            !lastMouseInputStatus.Allowed &&
            !hasMouseWorld)
        {
            return new MouseEventVisibilityResult
            {
                Visible = false,
                Reason = "hide_on_handled"
            };
        }
        
        // Otherwise, maintain current visibility based on base logic
        var shouldShow = ShouldBeVisible(BuildingMode.Build, targetingSettings, lastMouseInputStatus, hasMouseWorld);
        var reason = shouldShow ? "tick_show" : "tick_hide";
        return new MouseEventVisibilityResult
        {
            Visible = shouldShow,
            Reason = reason
        };
    }
```

**Returns:** `MouseEventVisibilityResult`

**Parameters:**
- `bool inputReady`
- `GridTargetingSettings targetingSettings`
- `MouseInputStatus lastMouseInputStatus`
- `bool hasMouseWorld`

### ProjectionMethodToString

```csharp
#endregion
    
    #region Utility Methods
    /// Converts projection method to string.
    /// <param name="method">The projection method</param>
    /// <returns>String representation</returns>
    public static string ProjectionMethodToString(ProjectionMethod method)
    {
        return method switch
        {
            ProjectionMethod.Manual => "Manual",
            ProjectionMethod.Automatic => "Automatic",
            ProjectionMethod.Hybrid => "Hybrid",
            _ => "Unknown"
        };
    }
```

**Returns:** `string`

**Parameters:**
- `ProjectionMethod method`

### ComputeRecenterDecision

```csharp
/// Computes recenter decision based on settings and current state.
    /// <param name="targetingSettings">Targeting settings</param>
    /// <param name="hasMouseWorld">Whether mouse world position is cached</param>
    /// <param name="lastShownPosition">Last known shown position</param>
    /// <returns>Recenter decision</returns>
    public static RecenterDecision ComputeRecenterDecision(
        GridTargetingSettings targetingSettings,
        bool hasMouseWorld,
        Vector2 lastShownPosition)
    {
        if (targetingSettings == null)
            return RecenterDecision.None;
        
        switch (targetingSettings.ManualRecenterMode)
        {
            case CenteringMode.CenterOnScreen:
                return RecenterDecision.ViewCenter;
            case CenteringMode.CenterOnMouse:
                return hasMouseWorld ? RecenterDecision.MouseCursor : RecenterDecision.ViewCenter;
            case CenteringMode.LastShown:
                if (lastShownPosition != Vector2.Zero)
                    return RecenterDecision.LastShown;
                return RecenterDecision.None;
            default:
                return RecenterDecision.None;
        }
    }
```

**Returns:** `RecenterDecision`

**Parameters:**
- `GridTargetingSettings targetingSettings`
- `bool hasMouseWorld`
- `Vector2 lastShownPosition`

### ShouldHandleInput

```csharp
/// Determines if the positioner should handle input events.
    /// <param name="mode">Current building mode</param>
    /// <param name="targetingSettings">Targeting settings</param>
    /// <param name="inputReady">Whether input is ready</param>
    /// <returns>True if should handle input</returns>
    public static bool ShouldHandleInput(
        BuildingMode mode,
        GridTargetingSettings targetingSettings,
        bool inputReady)
    {
        if (!inputReady)
            return false;
        return IsPositionerActive(mode, targetingSettings);
    }
```

**Returns:** `bool`

**Parameters:**
- `BuildingMode mode`
- `GridTargetingSettings targetingSettings`
- `bool inputReady`

### CreateVisibilityDiagnostic

```csharp
/// Creates diagnostic string for visibility state.
    /// <param name="visible">Current visibility state</param>
    /// <returns>Diagnostic string</returns>
    public static string CreateVisibilityDiagnostic(
        BuildingMode mode,
        GridTargetingSettings targetingSettings,
        MouseInputStatus lastMouseInputStatus,
        bool hasMouseWorld,
        bool visible)
    {
        var parts = new System.Text.StringBuilder();
        parts.Append($"mode={mode}");
        parts.Append($", visible={visible}");
        parts.Append($", input_ready={targetingSettings != null}");
        if (targetingSettings != null)
        {
            parts.Append($", mouse_enabled={targetingSettings.EnableMouseInput}");
            parts.Append($", hide_on_handled={targetingSettings.HideOnHandled}");
            parts.Append($", remain_active_off={targetingSettings.RemainActiveInOffMode}");
        }
        parts.Append($", mouse_allowed={lastMouseInputStatus?.Allowed ?? false}");
        parts.Append($", has_mouse_world={hasMouseWorld}");
        return parts.ToString();
    }
```

**Returns:** `string`

**Parameters:**
- `BuildingMode mode`
- `GridTargetingSettings targetingSettings`
- `MouseInputStatus lastMouseInputStatus`
- `bool hasMouseWorld`
- `bool visible`

