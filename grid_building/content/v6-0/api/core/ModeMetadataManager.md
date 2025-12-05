---
title: "ModeMetadataManager"
description: "Manages mode metadata configuration.
Handles default metadata creation and mode-specific configuration.
For full settings management, use ModeSettings from Types/ModeSettings.cs."
weight: 10
url: "/gridbuilding/v6-0/api/core/modemetadatamanager/"
---

# ModeMetadataManager

```csharp
GridBuilding.Core.State.Mode
class ModeMetadataManager
{
    // Members...
}
```

Manages mode metadata configuration.
Handles default metadata creation and mode-specific configuration.
For full settings management, use ModeSettings from Types/ModeSettings.cs.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/Mode/ModeSettingsManager.cs`  
**Namespace:** `GridBuilding.Core.State.Mode`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetModeMetadata

```csharp
/// <summary>
        /// Gets mode metadata for a specific mode type
        /// </summary>
        public ModeMetadata GetModeMetadata<T>(T mode) where T : System.Enum
        {
            return mode switch
            {
                ApplicationMode appMode => _applicationModeMetadata.GetValueOrDefault(appMode, new ModeMetadata()),
                UIMode uiMode => _uiModeMetadata.GetValueOrDefault(uiMode, new ModeMetadata()),
                EditMode editMode => _editModeMetadata.GetValueOrDefault(editMode, new ModeMetadata()),
                ViewMode viewMode => _viewModeMetadata.GetValueOrDefault(viewMode, new ModeMetadata()),
                GameMode gameMode => _gameModeMetadata.GetValueOrDefault(gameMode, new ModeMetadata()),
                _ => new ModeMetadata()
            };
        }
```

Gets mode metadata for a specific mode type

**Returns:** `ModeMetadata`

**Parameters:**
- `T mode`

### SetModeMetadata

```csharp
/// <summary>
        /// Sets mode metadata for a specific mode type
        /// </summary>
        public void SetModeMetadata<T>(T mode, ModeMetadata metadata) where T : System.Enum
        {
            if (metadata == null)
                return;
                
            switch (mode)
            {
                case ApplicationMode appMode:
                    _applicationModeMetadata[appMode] = metadata;
                    break;
                case UIMode uiMode:
                    _uiModeMetadata[uiMode] = metadata;
                    break;
                case EditMode editMode:
                    _editModeMetadata[editMode] = metadata;
                    break;
                case ViewMode viewMode:
                    _viewModeMetadata[viewMode] = metadata;
                    break;
                case GameMode gameMode:
                    _gameModeMetadata[gameMode] = metadata;
                    break;
            }
        }
```

Sets mode metadata for a specific mode type

**Returns:** `void`

**Parameters:**
- `T mode`
- `ModeMetadata metadata`

### GetModeSettings

```csharp
#region Deprecated API - Use new naming
        
        [Obsolete("Use GetModeMetadata instead")]
        public ModeMetadata GetModeSettings<T>(T mode) where T : System.Enum => GetModeMetadata(mode);
```

**Returns:** `ModeMetadata`

**Parameters:**
- `T mode`

### SetModeSettings

```csharp
[Obsolete("Use SetModeMetadata instead")]
        public void SetModeSettings<T>(T mode, ModeMetadata metadata) where T : System.Enum => SetModeMetadata(mode, metadata);
```

**Returns:** `void`

**Parameters:**
- `T mode`
- `ModeMetadata metadata`

