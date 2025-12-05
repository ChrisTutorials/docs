---
title: "StringExtensionsTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/stringextensionstest/"
---

# StringExtensionsTest

```csharp
GridBuilding.Godot.Tests.Core.Utils
class StringExtensionsTest
{
    // Members...
}
```



**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/Utils/GBStringTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Core.Utils`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GetSeparatorString_ReturnsCorrectSeparator

```csharp
#region GetSeparatorString Tests

    [Theory]
    [InlineData(StringExtensions.SeparatorType.None, "")]
    [InlineData(StringExtensions.SeparatorType.Space, " ")]
    [InlineData(StringExtensions.SeparatorType.Underscore, "_")]
    [InlineData(StringExtensions.SeparatorType.Dash, "-")]
    public void GetSeparatorString_ReturnsCorrectSeparator(StringExtensions.SeparatorType type, string expected)
    {
        var result = StringExtensions.GetSeparatorString(type);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `StringExtensions.SeparatorType type`
- `string expected`

### GetSeparatorString_IntOverload_ReturnsCorrectSeparator

```csharp
[Theory]
    [InlineData(0, "")]
    [InlineData(1, " ")]
    [InlineData(2, "_")]
    [InlineData(3, "-")]
    public void GetSeparatorString_IntOverload_ReturnsCorrectSeparator(int type, string expected)
    {
        var result = StringExtensions.GetSeparatorString(type);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `int type`
- `string expected`

### GetSeparatorString_InvalidInt_Throws

```csharp
[Fact]
    public void GetSeparatorString_InvalidInt_Throws()
    {
        Should.Throw<ArgumentOutOfRangeException>(() => StringExtensions.GetSeparatorString(99));
    }
```

**Returns:** `void`

### MatchNumSeparator_MatchesCorrectly

```csharp
#endregion

    #region MatchNumSeparator Tests

    [Theory]
    [InlineData(' ', StringExtensions.SeparatorType.Space, true)]
    [InlineData('_', StringExtensions.SeparatorType.Underscore, true)]
    [InlineData('-', StringExtensions.SeparatorType.Dash, true)]
    [InlineData('a', StringExtensions.SeparatorType.None, false)]
    [InlineData('_', StringExtensions.SeparatorType.Space, false)]
    [InlineData(' ', StringExtensions.SeparatorType.Underscore, false)]
    public void MatchNumSeparator_MatchesCorrectly(char c, StringExtensions.SeparatorType type, bool expected)
    {
        var result = StringExtensions.MatchNumSeparator(c, type);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `char c`
- `StringExtensions.SeparatorType type`
- `bool expected`

### MatchNumSeparator_None_AlwaysReturnsFalse

```csharp
[Fact]
    public void MatchNumSeparator_None_AlwaysReturnsFalse()
    {
        StringExtensions.MatchNumSeparator(' ', StringExtensions.SeparatorType.None).ShouldBeFalse();
        StringExtensions.MatchNumSeparator('_', StringExtensions.SeparatorType.None).ShouldBeFalse();
        StringExtensions.MatchNumSeparator('-', StringExtensions.SeparatorType.None).ShouldBeFalse();
        StringExtensions.MatchNumSeparator('a', StringExtensions.SeparatorType.None).ShouldBeFalse();
    }
```

**Returns:** `void`

### ConvertNameToReadable_ConvertsPascalCase

```csharp
#endregion

    #region ConvertNameToReadable Tests

    [Theory]
    [InlineData("PlayerCharacter", "Player Character")]
    [InlineData("EnemyAI", "Enemy A I")]
    [InlineData("simple", "simple")]
    [InlineData("A", "A")]
    [InlineData("", "")]
    public void ConvertNameToReadable_ConvertsPascalCase(string input, string expected)
    {
        var result = StringExtensions.ConvertNameToReadable(input);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `string input`
- `string expected`

### ConvertNameToReadable_StopsAtSeparator

```csharp
[Fact]
    public void ConvertNameToReadable_StopsAtSeparator()
    {
        var result = StringExtensions.ConvertNameToReadable("Player_123", StringExtensions.SeparatorType.Underscore);
        result.ShouldBe("Player");
    }
```

**Returns:** `void`

### ConvertNameToReadable_SpaceSeparator_StopsAtSpace

```csharp
[Fact]
    public void ConvertNameToReadable_SpaceSeparator_StopsAtSpace()
    {
        var result = StringExtensions.ConvertNameToReadable("Player 123", StringExtensions.SeparatorType.Space);
        result.ShouldBe("Player");
    }
```

**Returns:** `void`

### ConvertNameToReadable_DashSeparator_StopsAtDash

```csharp
[Fact]
    public void ConvertNameToReadable_DashSeparator_StopsAtDash()
    {
        var result = StringExtensions.ConvertNameToReadable("Player-123", StringExtensions.SeparatorType.Dash);
        result.ShouldBe("Player");
    }
```

**Returns:** `void`

### ConvertNameToReadable_NoSeparator_ProcessesFullName

```csharp
[Fact]
    public void ConvertNameToReadable_NoSeparator_ProcessesFullName()
    {
        var result = StringExtensions.ConvertNameToReadable("PlayerCharacter_123", StringExtensions.SeparatorType.None);
        result.ShouldBe("Player Character_123");
    }
```

**Returns:** `void`

### ToSnakeCase_ConvertsCorrectly

```csharp
#endregion

    #region ToSnakeCase Tests

    [Theory]
    [InlineData("PlayerCharacter", "player_character")]
    [InlineData("EnemyAI", "enemy_a_i")]
    [InlineData("simple", "simple")]
    [InlineData("A", "a")]
    [InlineData("", "")]
    [InlineData("XMLParser", "x_m_l_parser")]
    [InlineData("getHTTPResponse", "get_h_t_t_p_response")]
    public void ToSnakeCase_ConvertsCorrectly(string input, string expected)
    {
        var result = StringExtensions.ToSnakeCase(input);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `string input`
- `string expected`

### ToPascalCase_ConvertsCorrectly

```csharp
#endregion

    #region ToPascalCase Tests

    [Theory]
    [InlineData("player_character", "PlayerCharacter")]
    [InlineData("enemy_ai", "EnemyAi")]
    [InlineData("simple", "Simple")]
    [InlineData("a", "A")]
    [InlineData("", "")]
    [InlineData("_leading", "Leading")]
    [InlineData("trailing_", "Trailing")]
    [InlineData("double__underscore", "DoubleUnderscore")]
    public void ToPascalCase_ConvertsCorrectly(string input, string expected)
    {
        var result = StringExtensions.ToPascalCase(input);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `string input`
- `string expected`

### ToCamelCase_ConvertsCorrectly

```csharp
#endregion

    #region ToCamelCase Tests

    [Theory]
    [InlineData("player_character", "playerCharacter")]
    [InlineData("enemy_ai", "enemyAi")]
    [InlineData("simple", "simple")]
    [InlineData("a", "a")]
    [InlineData("", "")]
    public void ToCamelCase_ConvertsCorrectly(string input, string expected)
    {
        var result = StringExtensions.ToCamelCase(input);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `string input`
- `string expected`

### RemoveNumericSuffix_NoSeparator_RemovesTrailingDigits

```csharp
#endregion

    #region RemoveNumericSuffix Tests

    [Theory]
    [InlineData("Node2", "Node")]
    [InlineData("Enemy123", "Enemy")]
    [InlineData("Player", "Player")]
    [InlineData("", "")]
    [InlineData("123", "")]
    public void RemoveNumericSuffix_NoSeparator_RemovesTrailingDigits(string input, string expected)
    {
        var result = StringExtensions.RemoveNumericSuffix(input);
        result.ShouldBe(expected);
    }
```

**Returns:** `void`

**Parameters:**
- `string input`
- `string expected`

### RemoveNumericSuffix_WithUnderscore_RemovesAfterSeparator

```csharp
[Fact]
    public void RemoveNumericSuffix_WithUnderscore_RemovesAfterSeparator()
    {
        var result = StringExtensions.RemoveNumericSuffix("Enemy_3", StringExtensions.SeparatorType.Underscore);
        result.ShouldBe("Enemy");
    }
```

**Returns:** `void`

### RemoveNumericSuffix_WithDash_RemovesAfterSeparator

```csharp
[Fact]
    public void RemoveNumericSuffix_WithDash_RemovesAfterSeparator()
    {
        var result = StringExtensions.RemoveNumericSuffix("Node-42", StringExtensions.SeparatorType.Dash);
        result.ShouldBe("Node");
    }
```

**Returns:** `void`

### RemoveNumericSuffix_NonNumericAfterSeparator_KeepsOriginal

```csharp
[Fact]
    public void RemoveNumericSuffix_NonNumericAfterSeparator_KeepsOriginal()
    {
        var result = StringExtensions.RemoveNumericSuffix("Enemy_Boss", StringExtensions.SeparatorType.Underscore);
        result.ShouldBe("Enemy_Boss");
    }
```

**Returns:** `void`

### RemoveNumericSuffix_MixedAfterSeparator_KeepsOriginal

```csharp
[Fact]
    public void RemoveNumericSuffix_MixedAfterSeparator_KeepsOriginal()
    {
        var result = StringExtensions.RemoveNumericSuffix("Enemy_3a", StringExtensions.SeparatorType.Underscore);
        result.ShouldBe("Enemy_3a");
    }
```

**Returns:** `void`

### SnakeToPascalToSnake_Roundtrips

```csharp
#endregion

    #region Roundtrip Tests

    [Theory]
    [InlineData("player_character")]
    [InlineData("enemy_ai")]
    [InlineData("grid_building_system")]
    public void SnakeToPascalToSnake_Roundtrips(string original)
    {
        var pascal = StringExtensions.ToPascalCase(original);
        var backToSnake = StringExtensions.ToSnakeCase(pascal);
        backToSnake.ShouldBe(original);
    }
```

**Returns:** `void`

**Parameters:**
- `string original`

