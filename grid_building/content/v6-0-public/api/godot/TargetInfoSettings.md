---
title: "TargetInfoSettings"
description: "Settings that define what properties and display formats should be used
for showing information of a TargetInformer object."
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/targetinfosettings/"
---

# TargetInfoSettings

```csharp
GridBuilding.Godot.Systems.UI
class TargetInfoSettings
{
    // Members...
}
```

Settings that define what properties and display formats should be used
for showing information of a TargetInformer object.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/UI/TargetInfoSettings.cs`  
**Namespace:** `GridBuilding.Godot.Systems.UI`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### PositionDecimals

```csharp
#region Exported Properties
        /// <summary>
        /// How many decimals to show in position strings.
        /// </summary>
        [Export]
        public int PositionDecimals
        {
            get => _positionDecimals;
            set
            {
                if (value >= 0)
                {
                    _positionDecimals = value;
                }
            }
        }
```

How many decimals to show in position strings.

### PositionFormat

```csharp
/// <summary>
        /// String for displaying the X, Y position of the object.
        /// Must contain at least one %s placeholder.
        /// </summary>
        [Export]
        public string PositionFormat
        {
            get => _positionFormat;
            set
            {
                if (!string.IsNullOrEmpty(value) && value.Contains("%s"))
                {
                    _positionFormat = value;
                }
            }
        }
```

String for displaying the X, Y position of the object.
Must contain at least one %s placeholder.


## Methods

### GetEditorIssues

```csharp
#endregion

        #region Validation
        /// <summary>
        /// Returns a list of issues found during editor validation.
        /// </summary>
        /// <returns>List of validation issues</returns>
        public List<string> GetEditorIssues()
        {
            var issues = new List<string>();

            if (_positionDecimals < 0)
            {
                issues.Add("TargetInfoSettings position_decimals cannot be negative");
            }

            if (string.IsNullOrEmpty(_positionFormat) || !_positionFormat.Contains("%s"))
            {
                issues.Add("TargetInfoSettings position_format must contain at least one %s placeholder");
            }

            return issues;
        }
```

Returns a list of issues found during editor validation.

**Returns:** `List<string>`

### GetRuntimeIssues

```csharp
/// <summary>
        /// Returns a list of issues found during runtime validation.
        /// </summary>
        /// <returns>List of validation issues</returns>
        public List<string> GetRuntimeIssues()
        {
            var issues = new List<string>();
            issues.AddRange(GetEditorIssues());
            return issues;
        }
```

Returns a list of issues found during runtime validation.

**Returns:** `List<string>`

### IsValid

```csharp
/// <summary>
        /// Validates the current settings and returns true if they are valid.
        /// </summary>
        /// <returns>True if settings are valid</returns>
        public bool IsValid()
        {
            return GetRuntimeIssues().Count == 0;
        }
```

Validates the current settings and returns true if they are valid.

**Returns:** `bool`

### CreateDefault

```csharp
#endregion

        #region Public API
        /// <summary>
        /// Creates a new instance with default settings.
        /// </summary>
        /// <returns>Default TargetInfoSettings</returns>
        public static TargetInfoSettings CreateDefault()
        {
            return new TargetInfoSettings
            {
                PositionDecimals = 0,
                PositionFormat = "(%s, %s)"
            };
        }
```

Creates a new instance with default settings.

**Returns:** `TargetInfoSettings`

### Duplicate

```csharp
/// <summary>
        /// Creates a copy of this settings instance.
        /// </summary>
        /// <returns>Duplicate settings</returns>
        public TargetInfoSettings Duplicate()
        {
            return new TargetInfoSettings
            {
                PositionDecimals = _positionDecimals,
                PositionFormat = _positionFormat
            };
        }
```

Creates a copy of this settings instance.

**Returns:** `TargetInfoSettings`

### ApplyFrom

```csharp
/// <summary>
        /// Applies settings from another instance.
        /// </summary>
        /// <param name="other">Settings to copy from</param>
        public void ApplyFrom(TargetInfoSettings other)
        {
            if (other != null)
            {
                _positionDecimals = other.PositionDecimals;
                _positionFormat = other.PositionFormat;
            }
        }
```

Applies settings from another instance.

**Returns:** `void`

**Parameters:**
- `TargetInfoSettings other`

### FormatPosition

```csharp
/// <summary>
        /// Formats position values according to the current settings.
        /// </summary>
        /// <param name="x">X coordinate</param>
        /// <param name="y">Y coordinate</param>
        /// <returns>Formatted position string</returns>
        public string FormatPosition(float x, float y)
        {
            string xStr = x.ToString().PadDecimals(_positionDecimals);
            string yStr = y.ToString().PadDecimals(_positionDecimals);

            return string.Format(_positionFormat, xStr, yStr);
        }
```

Formats position values according to the current settings.

**Returns:** `string`

**Parameters:**
- `float x`
- `float y`

### FormatPosition

```csharp
/// <summary>
        /// Formats position vector according to the current settings.
        /// </summary>
        /// <param name="position">Position vector</param>
        /// <returns>Formatted position string</returns>
        public string FormatPosition(Vector2 position)
        {
            return FormatPosition(position.X, position.Y);
        }
```

Formats position vector according to the current settings.

**Returns:** `string`

**Parameters:**
- `Vector2 position`

### FormatPosition

```csharp
/// <summary>
        /// Formats position vector according to the current settings.
        /// </summary>
        /// <param name="position">Position vector</param>
        /// <returns>Formatted position string</returns>
        public string FormatPosition(Vector3 position)
        {
            return FormatPosition(position.X, position.Y);
        }
```

Formats position vector according to the current settings.

**Returns:** `string`

**Parameters:**
- `Vector3 position`

### CreateInteger

```csharp
#endregion

        #region Presets
        /// <summary>
        /// Creates settings for integer positions (no decimals).
        /// </summary>
        /// <returns>Integer position settings</returns>
        public static TargetInfoSettings CreateInteger()
        {
            return new TargetInfoSettings
            {
                PositionDecimals = 0,
                PositionFormat = DefaultPositionFormat2D
            };
        }
```

Creates settings for integer positions (no decimals).

**Returns:** `TargetInfoSettings`

### CreatePrecise

```csharp
/// <summary>
        /// Creates settings for precise positions with 2 decimal places.
        /// </summary>
        /// <returns>Precise position settings</returns>
        public static TargetInfoSettings CreatePrecise()
        {
            return new TargetInfoSettings
            {
                PositionDecimals = 2,
                PositionFormat = DefaultPositionFormat2D
            };
        }
```

Creates settings for precise positions with 2 decimal places.

**Returns:** `TargetInfoSettings`

### CreateVeryPrecise

```csharp
/// <summary>
        /// Creates settings for very precise positions with 3 decimal places.
        /// </summary>
        /// <returns>Very precise position settings</returns>
        public static TargetInfoSettings CreateVeryPrecise()
        {
            return new TargetInfoSettings
            {
                PositionDecimals = 3,
                PositionFormat = DefaultPositionFormat2D
            };
        }
```

Creates settings for very precise positions with 3 decimal places.

**Returns:** `TargetInfoSettings`

### CreateLabeled

```csharp
/// <summary>
        /// Creates settings with labeled position format.
        /// </summary>
        /// <returns>Labeled position settings</returns>
        public static TargetInfoSettings CreateLabeled()
        {
            return new TargetInfoSettings
            {
                PositionDecimals = 1,
                PositionFormat = LabeledPositionFormat2D
            };
        }
```

Creates settings with labeled position format.

**Returns:** `TargetInfoSettings`

### CreateBracketed

```csharp
/// <summary>
        /// Creates settings with bracketed position format.
        /// </summary>
        /// <returns>Bracketed position settings</returns>
        public static TargetInfoSettings CreateBracketed()
        {
            return new TargetInfoSettings
            {
                PositionDecimals = 1,
                PositionFormat = BracketedPositionFormat2D
            };
        }
```

Creates settings with bracketed position format.

**Returns:** `TargetInfoSettings`

### _Validate

```csharp
#endregion

        #region Godot Lifecycle
        public override void _Validate()
        {
            base._Validate();
            
            // Auto-correct invalid values during validation
            if (_positionDecimals < 0)
            {
                _positionDecimals = 0;
                GD.PrintErr("TargetInfoSettings: position_decimals cannot be negative, reset to 0");
            }

            if (string.IsNullOrEmpty(_positionFormat) || !_positionFormat.Contains("%s"))
            {
                _positionFormat = DefaultPositionFormat2D;
                GD.PrintErr("TargetInfoSettings: position_format must contain %s, reset to default");
            }
        }
```

**Returns:** `void`

