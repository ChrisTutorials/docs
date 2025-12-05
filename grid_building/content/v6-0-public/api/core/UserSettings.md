---
title: "UserSettings"
description: "User settings configuration"
weight: 10
url: "/gridbuilding/v6-0-public/api/core/usersettings/"
---

# UserSettings

```csharp
GridBuilding.Core.State.User
class UserSettings
{
    // Members...
}
```

User settings configuration

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/State/User/UserState.cs`  
**Namespace:** `GridBuilding.Core.State.User`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### MusicVolume

```csharp
public float MusicVolume { get; set; } = 0.8f;
```

### SoundVolume

```csharp
public float SoundVolume { get; set; } = 0.9f;
```

### CameraSpeed

```csharp
public float CameraSpeed { get; set; } = 1.0f;
```

### AutoSaveInterval

```csharp
public int AutoSaveInterval { get; set; } = 300; // seconds
```

### ShowGrid

```csharp
public bool ShowGrid { get; set; } = true;
```

### ShowBuildingInfo

```csharp
public bool ShowBuildingInfo { get; set; } = true;
```

### UIScale

```csharp
public float UIScale { get; set; } = 1.0f;
```

### Language

```csharp
public string Language { get; set; } = "en";
```

### EnableNotifications

```csharp
public bool EnableNotifications { get; set; } = true;
```

### EnableTooltips

```csharp
public bool EnableTooltips { get; set; } = true;
```

### EnableAutoSave

```csharp
public bool EnableAutoSave { get; set; } = true;
```


## Methods

### Clone

```csharp
public UserSettings Clone()
        {
            return new UserSettings
            {
                MusicVolume = MusicVolume,
                SoundVolume = SoundVolume,
                CameraSpeed = CameraSpeed,
                AutoSaveInterval = AutoSaveInterval,
                ShowGrid = ShowGrid,
                ShowBuildingInfo = ShowBuildingInfo,
                UIScale = UIScale,
                Language = Language,
                EnableNotifications = EnableNotifications,
                EnableTooltips = EnableTooltips,
                EnableAutoSave = EnableAutoSave
            };
        }
```

**Returns:** `UserSettings`

