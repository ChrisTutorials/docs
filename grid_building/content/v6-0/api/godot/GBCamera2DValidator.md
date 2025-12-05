---
title: "GBCamera2DValidator"
description: "Camera2D Setup Validator for Grid Building Plugin
This validation tool helps developers verify that their Camera2D setup meets
the requirements for the Grid Building plugin's coordinate conversion system.
Ported from: godot/addons/grid_building/shared/utils/validation/gb_camera2d_validator.gd"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbcamera2dvalidator/"
---

# GBCamera2DValidator

```csharp
GridBuilding.Godot.Shared.Utils.Validation
class GBCamera2DValidator
{
    // Members...
}
```

Camera2D Setup Validator for Grid Building Plugin
This validation tool helps developers verify that their Camera2D setup meets
the requirements for the Grid Building plugin's coordinate conversion system.
Ported from: godot/addons/grid_building/shared/utils/validation/gb_camera2d_validator.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Utilities/Camera2DValidator.cs`  
**Namespace:** `GridBuilding.Godot.Shared.Utils.Validation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ValidateSceneSetup

```csharp
#region Public Methods

    /// <summary>
    /// Validates Camera2D setup for a given scene tree.
    /// </summary>
    /// <param name="sceneRoot">The root node to validate (typically your main scene)</param>
    /// <returns>True if setup is valid, false if issues found</returns>
    public static bool ValidateSceneSetup(Node sceneRoot)
    {
        GD.Print("🔍 Grid Building Camera2D Validation Starting...");
        GD.Print($"   Scene: {sceneRoot.Name}");

        var issues = new List<string>();
        var warnings = new List<string>();

        // Find viewport
        var viewport = sceneRoot.GetViewport();
        if (viewport == null)
        {
            issues.Add("No viewport found for scene root");
            PrintResults(new List<string>(), new List<string>(), issues);
            return false;
        }

        // Check for Camera2D
        var camera = viewport.GetCamera2D();
        if (camera == null)
        {
            issues.Add("❌ CRITICAL: No Camera2D found in viewport");
            issues.Add("   Solution: Add Camera2D node to your scene hierarchy");
            PrintResults(new List<string>(), new List<string>(), issues);
            return false;
        }

        var successes = new List<string>();

        // Validate Camera2D configuration
        successes.Add($"✅ Camera2D found: {camera.Name}");

        // Check enabled state
        if (!camera.Enabled)
        {
            issues.Add("❌ Camera2D is disabled (enabled = false)");
            issues.Add("   Solution: Set camera.enabled = true");
        }
        else
        {
            successes.Add("✅ Camera2D is enabled");
        }

        // Check if current
        if (!camera.IsCurrent())
        {
            issues.Add("❌ Camera2D is not current");
            issues.Add("   Solution: Call camera.make_current()");
        }
        else
        {
            successes.Add("✅ Camera2D is current camera");
        }

        // Check zoom settings
        var zoom = camera.Zoom;
        if (zoom.X <= 0 || zoom.Y <= 0)
        {
            issues.Add($"❌ Invalid zoom settings: {zoom}");
            issues.Add("   Solution: Set positive zoom values (e.g., Vector2(2, 2))");
        }
        else
        {
            successes.Add($"✅ Camera2D zoom: {zoom}");

            // Check if zoom is power of 2 (recommended for pixel-perfect)
            var zoomXLog2 = Mathf.Log(zoom.X) / Mathf.Log(2.0f);
            var zoomYLog2 = Mathf.Log(zoom.Y) / Mathf.Log(2.0f);
            if (Math.Abs(zoomXLog2 - Mathf.Round(zoomXLog2)) > 0.01 ||
                Math.Abs(zoomYLog2 - Mathf.Round(zoomYLog2)) > 0.01)
            {
                warnings.Add("⚠️ Zoom is not power of 2 - may affect pixel-perfect rendering");
                warnings.Add("   Recommendation: Use powers of 2 (0.25, 0.5, 1, 2, 4, 8)");
            }
        }

        // Test coordinate conversion
        var testResult = TestCoordinateConversion(viewport, camera);
        if (testResult.Success)
        {
            successes.Add("✅ Coordinate conversion test passed");
            successes.Add($"   Test accuracy: {testResult.Accuracy:F3} pixels");
        }
        else
        {
            issues.Add("❌ Coordinate conversion test failed");
            issues.Add($"   Error: {testResult.Error}");
        }

        // Check for multiple cameras (potential conflict)
        var allCameras = FindAllCamera2DNodes(sceneRoot);
        if (allCameras.Count > 1)
        {
            var enabledCameras = allCameras.FindAll(cam => cam.Enabled);
            if (enabledCameras.Count > 1)
            {
                warnings.Add($"⚠️ Multiple enabled Camera2D nodes found ({enabledCameras.Count})");
                warnings.Add("   This may cause coordinate conversion conflicts");
                foreach (var cam in enabledCameras)
                {
                    warnings.Add($"     - {cam.Name} (path: {cam.GetPath()})");
                }
            }
        }

        PrintResults(successes, warnings, issues);

        return issues.Count == 0;
    }
```

Validates Camera2D setup for a given scene tree.

**Returns:** `bool`

**Parameters:**
- `Node sceneRoot`

### ValidateCurrentScene

```csharp
/// <summary>
    /// Quick validation function for editor scripts
    /// Call this from an [Tool] script in the editor to validate current scene
    /// </summary>
    /// <returns>True if validation passes</returns>
    public static bool ValidateCurrentScene()
    {
        if (!Engine.IsEditorHint())
        {
            GD.PushWarning("validate_current_scene() should only be called in editor");
            return false;
        }

        var editedScene = Engine.IsEditorHint() ? EditorInterface.Singleton.GetEditedSceneRoot() : null;
        if (editedScene == null)
        {
            GD.Print("❌ No scene currently open in editor");
            return false;
        }

        return ValidateSceneSetup(editedScene);
    }
```

Quick validation function for editor scripts
Call this from an [Tool] script in the editor to validate current scene

**Returns:** `bool`

### ValidateRuntimeSetup

```csharp
/// <summary>
    /// Runtime validation for game startup
    /// Call this during game initialization to verify setup
    /// </summary>
    /// <param name="mainScene">Main scene node</param>
    /// <returns>True if validation passes</returns>
    public static bool ValidateRuntimeSetup(Node mainScene)
    {
        if (Engine.IsEditorHint())
        {
            GD.PushWarning("validate_runtime_setup() should only be called at runtime");
            return false;
        }

        return ValidateSceneSetup(mainScene);
    }
```

Runtime validation for game startup
Call this during game initialization to verify setup

**Returns:** `bool`

**Parameters:**
- `Node mainScene`

