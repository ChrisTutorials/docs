---
title: "EnumsTest"
description: "Unit tests for Enums.
PORTED FROM: addons/grid_building/core/resources/gb_enums.gd (inline tests)
GDSCRIPT TEST COUNT: 29
BEHAVIORAL CONTRACTS:
1. Enum integer values MUST match GDScript values exactly
2. String conversions MUST produce identical output
3. All enum members from GDScript MUST be present"
weight: 20
url: "/gridbuilding/v6-0/api/godot/enumstest/"
---

# EnumsTest

```csharp
GridBuilding.Godot.Tests.Core.Base
class EnumsTest
{
    // Members...
}
```

Unit tests for Enums.
PORTED FROM: addons/grid_building/core/resources/gb_enums.gd (inline tests)
GDSCRIPT TEST COUNT: 29
BEHAVIORAL CONTRACTS:
1. Enum integer values MUST match GDScript values exactly
2. String conversions MUST produce identical output
3. All enum members from GDScript MUST be present

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/EnumsTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Base`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Mode_HasAllExpectedValues

```csharp
#region Mode Enum Tests

    [Fact]
    public void Mode_HasAllExpectedValues()
    {
        // Verify all mode values exist and have correct integer values
        BuildingMode.Off.ShouldBe((BuildingMode)0);
        BuildingMode.Info.ShouldBe((BuildingMode)1);
        BuildingMode.Build.ShouldBe((BuildingMode)2);
        BuildingMode.Move.ShouldBe((BuildingMode)3);
        BuildingMode.Demolish.ShouldBe((BuildingMode)4);
    }
```

**Returns:** `void`

### Mode_ToString_ReturnsCorrectValue

```csharp
[Theory]
    [InlineData(BuildingMode.Off, "Off")]
    [InlineData(BuildingMode.Info, "Info")]
    [InlineData(BuildingMode.Build, "Build")]
    [InlineData(BuildingMode.Move, "Move")]
    [InlineData(BuildingMode.Demolish, "Demolish")]
    public void Mode_ToString_ReturnsCorrectValue(BuildingMode mode, string expected)
    {
        mode.ToString().ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `BuildingMode mode`
- `string expected`

### LogLevel_HasAllExpectedValues

```csharp
#endregion

    #region LogLevel Enum Tests

    [Fact]
    public void LogLevel_HasAllExpectedValues()
    {
        // Verify all log level values exist and have correct integer values
        LogLevel.Error.ShouldBe((LogLevel)0);
        LogLevel.Warning.ShouldBe((LogLevel)1);
        LogLevel.Info.ShouldBe((LogLevel)2);
        LogLevel.Debug.ShouldBe((LogLevel)3);
        LogLevel.Verbose.ShouldBe((LogLevel)4);
    }
```

**Returns:** `void`

### LogLevel_ToString_ReturnsCorrectValue

```csharp
[Theory]
    [InlineData(LogLevel.Error, "Error")]
    [InlineData(LogLevel.Warning, "Warning")]
    [InlineData(LogLevel.Info, "Info")]
    [InlineData(LogLevel.Debug, "Debug")]
    [InlineData(LogLevel.Verbose, "Verbose")]
    public void LogLevel_ToString_ReturnsCorrectValue(LogLevel level, string expected)
    {
        level.ToString().ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `LogLevel level`
- `string expected`

### ValidationLevel_HasAllExpectedValues

```csharp
#endregion

    #region ValidationLevel Enum Tests

    [Fact]
    public void ValidationLevel_HasAllExpectedValues()
    {
        // Verify all validation level values exist and have correct integer values
        ValidationLevel.None.ShouldBe((ValidationLevel)0);
        ValidationLevel.Basic.ShouldBe((ValidationLevel)1);
        ValidationLevel.Strict.ShouldBe((ValidationLevel)2);
    }
```

**Returns:** `void`

### ValidationLevel_ToString_ReturnsCorrectValue

```csharp
[Theory]
    [InlineData(ValidationLevel.None, "None")]
    [InlineData(ValidationLevel.Basic, "Basic")]
    [InlineData(ValidationLevel.Strict, "Strict")]
    public void ValidationLevel_ToString_ReturnsCorrectValue(ValidationLevel level, string expected)
    {
        level.ToString().ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `ValidationLevel level`
- `string expected`

### StringToMode_ReturnsCorrectValue

```csharp
#endregion

    #region String Conversion Tests

    [Theory]
    [InlineData("Off", BuildingMode.Off)]
    [InlineData("Info", BuildingMode.Info)]
    [InlineData("Build", BuildingMode.Build)]
    [InlineData("Move", BuildingMode.Move)]
    [InlineData("Demolish", BuildingMode.Demolish)]
    [InlineData("InvalidMode", (BuildingMode)(-1))] // Should handle invalid values
    public void StringToMode_ReturnsCorrectValue(string input, BuildingMode expected)
    {
        var result = EnumHelpers.StringToMode(input);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `string input`
- `BuildingMode expected`

### StringToLogLevel_ReturnsCorrectValue

```csharp
[Theory]
    [InlineData("Error", LogLevel.Error)]
    [InlineData("Warning", LogLevel.Warning)]
    [InlineData("Info", LogLevel.Info)]
    [InlineData("Debug", LogLevel.Debug)]
    [InlineData("Verbose", LogLevel.Verbose)]
    [InlineData("InvalidLevel", (LogLevel)(-1))] // Should handle invalid values
    public void StringToLogLevel_ReturnsCorrectValue(string input, LogLevel expected)
    {
        var result = EnumHelpers.StringToLogLevel(input);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `string input`
- `LogLevel expected`

### StringToMode_NullInput_ReturnsDefault

```csharp
#endregion

    #region Edge Cases and Error Handling

    [Fact]
    public void StringToMode_NullInput_ReturnsDefault()
    {
        var result = EnumHelpers.StringToMode(null!);
        result.ShouldBe((BuildingMode)(-1)); // Invalid value for null/empty
    }
```

**Returns:** `void`

### StringToMode_EmptyInput_ReturnsDefault

```csharp
[Fact]
    public void StringToMode_EmptyInput_ReturnsDefault()
    {
        var result = EnumHelpers.StringToMode(string.Empty);
        result.ShouldBe((BuildingMode)(-1)); // Invalid value for null/empty
    }
```

**Returns:** `void`

### StringToLogLevel_NullInput_ReturnsDefault

```csharp
[Fact]
    public void StringToLogLevel_NullInput_ReturnsDefault()
    {
        var result = EnumHelpers.StringToLogLevel(null!);
        result.ShouldBe((LogLevel)(-1)); // Invalid value for null/empty
    }
```

**Returns:** `void`

### StringToLogLevel_EmptyInput_ReturnsDefault

```csharp
[Fact]
    public void StringToLogLevel_EmptyInput_ReturnsDefault()
    {
        var result = EnumHelpers.StringToLogLevel(string.Empty);
        result.ShouldBe((LogLevel)(-1)); // Invalid value for null/empty
    }
```

**Returns:** `void`

### StringToMode_PerformanceTest

```csharp
#endregion

    #region Performance Tests

    [Fact]
    public void StringToMode_PerformanceTest()
    {
        // Performance test for string to enum conversion
        var input = "Build";
        var iterations = 10000;
        
        var start = System.DateTime.UtcNow;
        for (int i = 0; i < iterations; i++)
        {
            var result = EnumHelpers.StringToMode(input);
            result.ShouldBe(BuildingMode.Build);
        }
        var end = System.DateTime.UtcNow;
        
        // Should complete quickly (less than 1 second for 10k iterations)
        (end - start).TotalMilliseconds.ShouldBeLessThan(1000);
    }
```

**Returns:** `void`

