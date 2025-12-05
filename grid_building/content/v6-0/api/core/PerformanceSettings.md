---
title: "PerformanceSettings"
description: "Performance settings for the GridBuilding plugin.
Provides configuration for performance optimization,
rendering settings, and resource management. This is a pure C# implementation for Core use."
weight: 10
url: "/gridbuilding/v6-0/api/core/performancesettings/"
---

# PerformanceSettings

```csharp
GridBuilding.Core.Systems.Configuration
class PerformanceSettings
{
    // Members...
}
```

Performance settings for the GridBuilding plugin.
Provides configuration for performance optimization,
rendering settings, and resource management. This is a pure C# implementation for Core use.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Systems/Configuration/PerformanceSettings.cs`  
**Namespace:** `GridBuilding.Core.Systems.Configuration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### EnablePerformanceMonitoring

```csharp
/// <summary>
    /// Whether to enable performance monitoring
    /// </summary>
    public bool EnablePerformanceMonitoring { get; set; } = false;
```

Whether to enable performance monitoring

### MaxFPS

```csharp
/// <summary>
    /// Maximum FPS for the grid system
    /// </summary>
    public int MaxFPS { get; set; } = 60;
```

Maximum FPS for the grid system

### EnableVSync

```csharp
/// <summary>
    /// Whether to enable VSync
    /// </summary>
    public bool EnableVSync { get; set; } = true;
```

Whether to enable VSync

### MaxRenderableObjects

```csharp
/// <summary>
    /// Maximum number of objects to render
    /// </summary>
    public int MaxRenderableObjects { get; set; } = 1000;
```

Maximum number of objects to render

### EnableObjectPooling

```csharp
/// <summary>
    /// Whether to enable object pooling
    /// </summary>
    public bool EnableObjectPooling { get; set; } = true;
```

Whether to enable object pooling

### ObjectPoolSize

```csharp
/// <summary>
    /// Object pool size
    /// </summary>
    public int ObjectPoolSize { get; set; } = 100;
```

Object pool size

### EnableLOD

```csharp
/// <summary>
    /// Whether to enable LOD (Level of Detail)
    /// </summary>
    public bool EnableLOD { get; set; } = false;
```

Whether to enable LOD (Level of Detail)

### LODDistanceThreshold

```csharp
/// <summary>
    /// LOD distance threshold
    /// </summary>
    public float LODDistanceThreshold { get; set; } = 50.0f;
```

LOD distance threshold

### EnableFrustumCulling

```csharp
/// <summary>
    /// Whether to enable frustum culling
    /// </summary>
    public bool EnableFrustumCulling { get; set; } = true;
```

Whether to enable frustum culling

### EnableOcclusionCulling

```csharp
/// <summary>
    /// Whether to enable occlusion culling
    /// </summary>
    public bool EnableOcclusionCulling { get; set; } = false;
```

Whether to enable occlusion culling

### PerformanceUpdateInterval

```csharp
/// <summary>
    /// Update interval for performance monitoring in seconds
    /// </summary>
    public float PerformanceUpdateInterval { get; set; } = 1.0f;
```

Update interval for performance monitoring in seconds

### EnableMultiThreading

```csharp
/// <summary>
    /// Whether to enable multi-threading
    /// </summary>
    public bool EnableMultiThreading { get; set; } = true;
```

Whether to enable multi-threading

### MaxWorkerThreads

```csharp
/// <summary>
    /// Maximum number of worker threads
    /// </summary>
    public int MaxWorkerThreads { get; set; } = 4;
```

Maximum number of worker threads

### EnableAsyncLoading

```csharp
/// <summary>
    /// Whether to enable async loading
    /// </summary>
    public bool EnableAsyncLoading { get; set; } = true;
```

Whether to enable async loading

### AsyncLoadingBatchSize

```csharp
/// <summary>
    /// Async loading batch size
    /// </summary>
    public int AsyncLoadingBatchSize { get; set; } = 10;
```

Async loading batch size

