---
title: "MultiplayerSettings"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/multiplayersettings/"
---

# MultiplayerSettings

```csharp
GridBuilding.Core.Systems.Configuration
class MultiplayerSettings
{
    // Members...
}
```

Multiplayer settings for the GridBuilding plugin.
Provides configuration for multiplayer functionality,
network synchronization, and collaborative building. This is a pure C# implementation for Core use.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Configuration/MultiplayerSettings.cs`  
**Namespace:** `GridBuilding.Core.Systems.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnableMultiplayer

```csharp
/// <summary>
    /// Whether to enable multiplayer functionality
    /// </summary>
    public bool EnableMultiplayer { get; set; } = false;
```

Whether to enable multiplayer functionality

### MaxPlayers

```csharp
/// <summary>
    /// Maximum number of players
    /// </summary>
    public int MaxPlayers { get; set; } = 4;
```

Maximum number of players

### NetworkUpdateRate

```csharp
/// <summary>
    /// Network update rate in Hz
    /// </summary>
    public int NetworkUpdateRate { get; set; } = 30;
```

Network update rate in Hz

### EnableNetworkInterpolation

```csharp
/// <summary>
    /// Whether to enable network interpolation
    /// </summary>
    public bool EnableNetworkInterpolation { get; set; } = true;
```

Whether to enable network interpolation

### NetworkInterpolationDelay

```csharp
/// <summary>
    /// Network interpolation delay in seconds
    /// </summary>
    public float NetworkInterpolationDelay { get; set; } = 0.1f;
```

Network interpolation delay in seconds

### EnableClientSidePrediction

```csharp
/// <summary>
    /// Whether to enable client-side prediction
    /// </summary>
    public bool EnableClientSidePrediction { get; set; } = true;
```

Whether to enable client-side prediction

### EnableServerAuthority

```csharp
/// <summary>
    /// Whether to enable server authority
    /// </summary>
    public bool EnableServerAuthority { get; set; } = true;
```

Whether to enable server authority

### NetworkTimeout

```csharp
/// <summary>
    /// Network timeout in seconds
    /// </summary>
    public float NetworkTimeout { get; set; } = 10.0f;
```

Network timeout in seconds

### ConnectionRetryInterval

```csharp
/// <summary>
    /// Connection retry interval in seconds
    /// </summary>
    public float ConnectionRetryInterval { get; set; } = 5.0f;
```

Connection retry interval in seconds

### MaxConnectionRetryAttempts

```csharp
/// <summary>
    /// Maximum connection retry attempts
    /// </summary>
    public int MaxConnectionRetryAttempts { get; set; } = 3;
```

Maximum connection retry attempts

### EnableVoiceChat

```csharp
/// <summary>
    /// Whether to enable voice chat
    /// </summary>
    public bool EnableVoiceChat { get; set; } = false;
```

Whether to enable voice chat

### VoiceChatQuality

```csharp
/// <summary>
    /// Voice chat quality (0.0 to 1.0)
    /// </summary>
    public float VoiceChatQuality { get; set; } = 0.8f;
```

Voice chat quality (0.0 to 1.0)

### EnableTextChat

```csharp
/// <summary>
    /// Whether to enable text chat
    /// </summary>
    public bool EnableTextChat { get; set; } = true;
```

Whether to enable text chat

### MaxChatMessageLength

```csharp
/// <summary>
    /// Maximum chat message length
    /// </summary>
    public int MaxChatMessageLength { get; set; } = 256;
```

Maximum chat message length

### EnablePlayerIndicators

```csharp
/// <summary>
    /// Whether to enable player indicators
    /// </summary>
    public bool EnablePlayerIndicators { get; set; } = true;
```

Whether to enable player indicators

### PlayerIndicatorColor

```csharp
/// <summary>
    /// Player indicator color
    /// </summary>
    public string PlayerIndicatorColor { get; set; } = "#00FF00";
```

Player indicator color

