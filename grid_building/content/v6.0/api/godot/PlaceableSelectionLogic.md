---
title: "PlaceableSelectionLogic"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/placeableselectionlogic/"
---

# PlaceableSelectionLogic

```csharp
GridBuilding.Godot.Systems.UI.Placeable
class PlaceableSelectionLogic
{
    // Members...
}
```

Shared logic for placeable selection style UIs (grid or sequence list variants).
Provides dependency resolution, mode visibility toggling, validation helpers.
MIGRATED: Now uses IInjectable interface instead of Injectable base class.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/UI/Placeable/PlaceableSelectionLogic.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI.Placeable`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### BuildingSystem

```csharp
#endregion

        #region Public Properties
        /// <summary>
        /// Gets the current building system.
        /// </summary>
        public BuildingSystem BuildingSystem => _buildingSystem;
```

Gets the current building system.

### ModeState

```csharp
/// <summary>
        /// Gets the current mode state.
        /// </summary>
        public ModeState ModeState => _modeState;
```

Gets the current mode state.

### SystemsContext

```csharp
/// <summary>
        /// Gets the systems context.
        /// </summary>
        public GBSystemsContext SystemsContext => _systemsContext;
```

Gets the systems context.


## Methods

### ResolveGBDependencies

```csharp
#endregion

        #region Dependency Resolution
        /// <summary>
        /// Sources injectable dependencies from the container so that this Injectable
        /// can operate at runtime.
        /// </summary>
        /// <param name="container">Container with dependencies</param>
        /// <returns>True if dependencies were resolved successfully</returns>
        public bool ResolveGBDependencies(GBCompositionContainer container)
        {
            _systemsContext = container.GetSystemsContext();
            _buildingSystem = _systemsContext?.GetBuildingSystem();
            
            // Guard against duplicate signal connections
            if (_systemsContext != null && !_systemsContext.BuildingSystemChanged.IsConnected(_OnBuildingSystemChanged))
            {
                _systemsContext.BuildingSystemChanged += _OnBuildingSystemChanged;
            }
            
            _modeState = container.GetModeState();
            return true;
        }
```

Sources injectable dependencies from the container so that this Injectable
can operate at runtime.

**Returns:** `bool`

**Parameters:**
- `GBCompositionContainer container`

### SetModeState

```csharp
/// <summary>
        /// Sets the mode state manually.
        /// </summary>
        /// <param name="modeState">The mode state to set</param>
        public void SetModeState(ModeState modeState)
        {
            _modeState = modeState;
        }
```

Sets the mode state manually.

**Returns:** `void`

**Parameters:**
- `ModeState modeState`

### GetBuildingSystem

```csharp
/// <summary>
        /// Gets the current building system.
        /// </summary>
        /// <returns>BuildingSystem instance</returns>
        public BuildingSystem GetBuildingSystem()
        {
            return _buildingSystem;
        }
```

Gets the current building system.

**Returns:** `BuildingSystem`

### ValidateBasic

```csharp
/// <summary>
        /// Validates basic dependencies.
        /// </summary>
        /// <returns>List of validation issues</returns>
        public List<string> ValidateBasic()
        {
            return GBValidation.CheckNotNull(this, new string[] { "_buildingSystem" });
        }
```

Validates basic dependencies.

**Returns:** `List<string>`

### HandleUIHidden

```csharp
#endregion

        #region UI State Management
        /// <summary>
        /// Handles UI hidden events - switches to OFF mode if currently in BUILD mode.
        /// </summary>
        /// <param name="uiRoot">The UI root control</param>
        public void HandleUIHidden(Control uiRoot)
        {
            if (_modeState != null && _modeState.Current == BuildingMode.Build)
            {
                _modeState.Current = BuildingMode.Off;
            }
        }
```

Handles UI hidden events - switches to OFF mode if currently in BUILD mode.

**Returns:** `void`

**Parameters:**
- `Control uiRoot`

### HandleModeChanged

```csharp
/// <summary>
        /// Handles mode changes by showing/hiding the UI appropriately.
        /// </summary>
        /// <param name="mode">The new mode</param>
        /// <param name="uiRoot">The UI root control</param>
        public void HandleModeChanged(BuildingMode mode, Control uiRoot)
        {
            switch (mode)
            {
                case BuildingMode.Build:
                    uiRoot?.Show();
                    break;
                default:
                    uiRoot?.Hide();
                    break;
            }
        }
```

Handles mode changes by showing/hiding the UI appropriately.

**Returns:** `void`

**Parameters:**
- `BuildingMode mode`
- `Control uiRoot`

### InjectDependencies

```csharp
#endregion

        #region Injectable Implementation

        /// <summary>
        /// Injects dependencies from the composition container.
        /// Implements modern IInjectable pattern.
        /// </summary>
        /// <param name="container">The composition container to get dependencies from</param>
        public void InjectDependencies(ICompositionContainer container)
        {
            // TODO: Implement proper service resolution when services are available
            // For now, dependencies are set via constructor or properties
        }
```

Injects dependencies from the composition container.
Implements modern IInjectable pattern.

**Returns:** `void`

**Parameters:**
- `ICompositionContainer container`

### ValidateDependencies

```csharp
/// <summary>
        /// Validates that all required dependencies are available.
        /// </summary>
        /// <param name="container">The composition container to validate against</param>
        /// <returns>Validation result indicating if dependencies are satisfied</returns>
        public ValidationResult ValidateDependencies(ICompositionContainer container)
        {
            var result = new ValidationResult();

            if (_modeState == null)
            {
                result.AddError("[mode_state] not set.");
            }
            if (_systemsContext == null)
            {
                result.AddError("[_systems_context] not set.");
            }
            if (_buildingSystem == null)
            {
                result.AddError("[_building_system] not set");
            }

            return result;
        }
```

Validates that all required dependencies are available.

**Returns:** `ValidationResult`

**Parameters:**
- `ICompositionContainer container`

### ResolveGbDependencies

```csharp
/// <summary>
        /// Legacy compatibility method.
        /// OBSOLETE: Use InjectDependencies instead.
        /// </summary>
        [Obsolete("Use InjectDependencies(ICompositionContainer) instead.")]
        public override bool ResolveGbDependencies(CompositionContainer container)
        {
            InjectDependencies(container);
            return ValidateDependencies(container).IsValid;
        }
```

Legacy compatibility method.
OBSOLETE: Use InjectDependencies instead.

**Returns:** `bool`

**Parameters:**
- `CompositionContainer container`

### GetRuntimeIssues

```csharp
/// <summary>
        /// Legacy compatibility method.
        /// OBSOLETE: Use ValidateDependencies instead.
        /// </summary>
        [Obsolete("Use ValidateDependencies(ICompositionContainer) instead.")]
        public global::Godot.Collections.Array<string> GetRuntimeIssues()
        {
            var validation = ValidateDependencies(CompositionContainer.Instance ?? throw new InvalidOperationException("CompositionContainer not initialized"));
            var issues = new global::Godot.Collections.Array<string>();
            
            foreach (var error in validation.Errors)
            {
                issues.Add(error);
            }
            
            return issues;
        }
```

Legacy compatibility method.
OBSOLETE: Use ValidateDependencies instead.

**Returns:** `global::Godot.Collections.Array<string>`

