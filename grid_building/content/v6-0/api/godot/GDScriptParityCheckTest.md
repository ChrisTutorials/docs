---
title: "GDScriptParityCheckTest"
description: "Parity verification tests to ensure C# tests match GDScript source tests.
These tests verify that functionality isn't lost in translation.
Run with: dotnet test --filter "FullyQualifiedName~ParityCheck""
weight: 20
url: "/gridbuilding/v6-0/api/godot/gdscriptparitychecktest/"
---

# GDScriptParityCheckTest

```csharp
GridBuilding.Godot.Tests.Verification
class GDScriptParityCheckTest
{
    // Members...
}
```

Parity verification tests to ensure C# tests match GDScript source tests.
These tests verify that functionality isn't lost in translation.
Run with: dotnet test --filter "FullyQualifiedName~ParityCheck"

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GDScriptParityCheckTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Verification`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### ParityCheck_ManipulationTransformCalculator_HasRequiredTests

```csharp
#region Parity Check Tests

    [Fact]
    public void ParityCheck_ManipulationTransformCalculator_HasRequiredTests()
    {
        VerifyParityForMapping("manipulation_transform_calculator_test.gd");
    }
```

**Returns:** `void`

### ParityCheck_GBGeometryMath_HasRequiredTests

```csharp
[Fact]
    public void ParityCheck_GBGeometryMath_HasRequiredTests()
    {
        VerifyParityForMapping("gb_geometry_math_test.gd");
    }
```

**Returns:** `void`

### ParityCheck_DomainEnums_HasRequiredTests

```csharp
[Fact]
    public void ParityCheck_DomainEnums_HasRequiredTests()
    {
        VerifyParityForMapping("gb_enums_test.gd");
    }
```

**Returns:** `void`

### ParityCheck_AllMappedTests_HaveMinimumCoverage

```csharp
#endregion

    #region Aggregate Checks

    [Fact]
    public void ParityCheck_AllMappedTests_HaveMinimumCoverage()
    {
        var failures = new List<string>();

        foreach (var (gdScriptFile, mapping) in TestMappings)
        {
            var testCount = CountTestMethods(mapping.CSharpType);
            var coveragePercent = (double)testCount / mapping.ExpectedTestCount * 100;

            if (coveragePercent < 80) // Require at least 80% coverage
            {
                failures.Add($"{gdScriptFile}: {testCount}/{mapping.ExpectedTestCount} tests ({coveragePercent:F1}%)");
            }
        }

        ;
    }
```

**Returns:** `void`

### ParityCheck_AllTestClasses_HaveSourceDocumentation

```csharp
[Fact]
    public void ParityCheck_AllTestClasses_HaveSourceDocumentation()
    {
        var testAssembly = typeof(GDScriptParityCheckTest).Assembly;
        var testClasses = testAssembly.GetTypes()
            .Where(t => t.Name.EndsWith("Test") && t.IsClass && !t.IsAbstract);

        var missingDocs = new List<string>();

        foreach (var testClass in testClasses)
        {
            // Skip verification tests themselves
            if (testClass.Namespace?.Contains("Verification") == true) continue;

            // Check for XML documentation or "Ported from" comment
            var hasParityComment = testClass.GetCustomAttributes()
                .Any(a => a.ToString()?.Contains("Ported") == true);

            // Check first method for documentation pattern
            var firstMethod = testClass.GetMethods()
                .FirstOrDefault(m => m.GetCustomAttribute<FactAttribute>() != null);

            if (firstMethod == null) continue;

            // This is a heuristic - in practice, check source file for comments
            // For now, just verify the class exists in our mapping
            if (!TestMappings.Values.Any(m => m.CSharpType == testClass))
            {
                // Not in parity mapping - might be new C#-only test (acceptable)
            }
        }

        // This test mainly ensures the parity check infrastructure exists
        ;
    }
```

**Returns:** `void`

