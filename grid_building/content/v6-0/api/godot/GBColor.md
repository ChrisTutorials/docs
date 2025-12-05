---
title: "GBColor"
description: "Color representation for settings (Godot-independent)"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gbcolor/"
---

# GBColor

```csharp
GridBuilding.Godot.Tests.Resources.Settings
struct GBColor
{
    // Members...
}
```

Color representation for settings (Godot-independent)

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Resources/Settings/ActionLogSettings.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Resources.Settings`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### R

```csharp
public float R { get; }
```

### G

```csharp
public float G { get; }
```

### B

```csharp
public float B { get; }
```

### A

```csharp
public float A { get; }
```

### LightCoral

```csharp
/// <summary>Common color preset: Light Coral (#F08080)</summary>
    public static GBColor LightCoral => new(0.94f, 0.5f, 0.5f);
```

Common color preset: Light Coral (#F08080)

### LightBlue

```csharp
/// <summary>Common color preset: Light Blue (#ADD8E6)</summary>
    public static GBColor LightBlue => new(0.68f, 0.85f, 0.9f);
```

Common color preset: Light Blue (#ADD8E6)

### White

```csharp
/// <summary>Common color preset: White</summary>
    public static GBColor White => new(1.0f, 1.0f, 1.0f);
```

Common color preset: White

### Black

```csharp
/// <summary>Common color preset: Black</summary>
    public static GBColor Black => new(0.0f, 0.0f, 0.0f);
```

Common color preset: Black


## Methods

### ToString

```csharp
public override string ToString() => $"Color({R:F2}, {G:F2}, {B:F2}, {A:F2})";
```

**Returns:** `string`

