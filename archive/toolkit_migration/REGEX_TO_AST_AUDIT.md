# Toolkit Regex-to-AST Audit Report

**Date:** November 28, 2025  
**Auditor:** AI Assistant  
**Purpose:** Identify tools using regex for code manipulation that should use AST

## Summary

| Category | Files | Status |
|----------|-------|--------|
| ⚠️ **Should migrate to AST** | 3 | Action Required |
| ✅ **Acceptable regex use** | 6 | No action needed |
| ✅ **Already using AST** | 2 | Good |

---

## ⚠️ SHOULD MIGRATE TO AST

These files use regex for **code manipulation/transformation** and should be migrated to use the existing `CSharpAstParser` (Roslyn) or `GDScriptParser`.

### 1. `GodotToolkit.Fixes/PortingFixPatterns.cs` (780 lines) - **HIGH PRIORITY**

**Problem:** Entire file is regex-based C# code transformation.

**Regex Patterns Found:**
- Dictionary literal conversion: `(?<!\w)\{\s*\}(?!\s*\))`
- Array literal conversion: `(?<!\w)\[\s*\]`
- Constructor fixes: `new Vector2`, `new Vector3`
- Constant case fixes: `Vector2.ZERO` → `Vector2.Zero`
- GDScript method calls: `.new()` → constructor

**Impact:** 12+ regex patterns that blindly match text without understanding code context.

**Recommendation:** 
- **DEPRECATE** this file
- Use `AstPortingFixer` (already created) which uses Roslyn AST
- Already migrated: `AddNewKeywordFix`, `ConstantCaseFix`, `GDScriptNewMethodFix`

**Status:** ✅ Replacement exists (`AstPortingFixer.cs`)

---

### 2. `GodotToolkit.Fixes/ConversionFixer.cs` (705 lines) - **MEDIUM PRIORITY**

**Problem:** Uses regex for C#↔GDScript code conversion.

**Problematic Regex Usage (lines):**
- Line 278: `Regex.Match(assertionText, @"\((.*?)\)")` - Extracts assertion parameters
- Line 290: `Regex.Match(assertion, @"Assert\.Equal\((.*?), (.*?), (.*?)\)")` - Parses Assert.Equal
- Line 504: `Regex.Match(trimmedLine, @"var (\w+) = (.+);")` - Matches variable declarations
- Line 513: `Regex.Match(trimmedLine, @"(\w+)\.(\w+)\((.*)\);")` - Matches method calls
- Line 531: `Regex.Replace(converted, @"new (\w+)\((.*?)\)", "$1($2)")` - **CODE TRANSFORMATION**
- Line 537: `Regex.Replace(converted, @"\.([A-Z][a-zA-Z0-9]*)", ...)` - **CODE TRANSFORMATION**

**Risk:** 
- `(.*?)` patterns are greedy and context-blind
- Will break on nested parentheses, string literals, comments
- PascalCase→snake_case conversion can match inside strings

**Recommendation:**
1. For C# parsing: Use `CSharpAstParser` with Roslyn
2. For GDScript parsing: Use `GDScriptParser` (regex-based is acceptable since no GDScript AST lib exists)
3. Add new AST-based rewriters to `AstPortingFixer.cs`

---

### 3. `GodotToolkit.Fixes/ResourceFixer.cs` (456 lines) - **MEDIUM PRIORITY**

**Problem:** Uses regex to match and transform code patterns.

**Problematic Regex Usage:**
- Line 38: `Regex.Match(line, @"const\s+(\w+)\s*=\s*preload\(""([^""]+)""\)")` - Preload extraction
- Line 232: `Regex.Matches(line, @"load\(""([^""]+)""\)")` - Load pattern matching
- Line 289: `Regex.Match(trimmedLine, @"private\s+(\w+)\s+(\w+)\s*=\s*(.+);")` - Field parsing
- Line 312-333: Multiple regex patterns for `GD.Load<T>` parsing

**Risk:**
- Will match patterns inside comments or strings
- Complex patterns like `GD.Load<SomeType<Nested>>` will break

**Recommendation:**
1. For GDScript files: Use `GDScriptParser.ParseFile()` which already extracts preloads
2. For C# files: Use `CSharpAstParser` to extract field assignments

---

## ✅ ACCEPTABLE REGEX USE

These files use regex for **parsing/detection** (read-only) or **log analysis**, which is appropriate.

### 1. `GodotToolkit.LogAnalyzer/LogParser.cs`

**Purpose:** Parse Godot log output (plain text, not code)

**Regex Patterns:** 12 patterns for error/warning extraction
- `ScriptErrorPattern`, `AtLocationPattern`, `ErrorPattern`, etc.

**Verdict:** ✅ **Acceptable** - Log output is unstructured text, not code. Regex is the right tool.

---

### 2. `GodotToolkit.Parsing/GDScriptParser.cs`

**Purpose:** Parse GDScript source code

**Regex Patterns:** 10+ patterns for GDScript structure extraction
- `ClassPattern`, `FunctionPattern`, `VariablePattern`, `PreloadPattern`, etc.

**Verdict:** ✅ **Acceptable** - No C# AST library exists for GDScript. Regex is necessary.
The parser is **read-only** (extracts info, doesn't transform code).

---

### 3. `GodotToolkit.UidManagement/UidValidator.cs` and `UidFixer.cs`

**Purpose:** Find and fix UID patterns in resource files

**Regex Patterns:**
- `uid\s*=\s*([^,\s]+)` - Extract UIDs from .tres/.tscn files
- `preload\s*\(\s*""res://([^""]+)""\s*\)` - Find res:// paths

**Verdict:** ✅ **Acceptable** - These files work with Godot resource files (.tres, .tscn), not code.
Resource files are structured text (TOML-like), regex is appropriate.

---

### 4. `GodotToolkit.TestOrchestrator/Services/GDScriptSafetyChecker.cs`

**Purpose:** Detect dangerous patterns in GDScript tests

**Regex Patterns:**
- `InfiniteLoopPattern`, `UnboundedWhilePattern`, `RecursionWithoutBaseCase`
- `MissingPreloadPattern`, `AwaitInTestPattern`, `PrintPattern`

**Verdict:** ✅ **Acceptable** - Detection/linting, not transformation. Read-only analysis.

---

### 5. `GridBuilding.ProjectIntegrity/Detectors/*.cs`

**Purpose:** Detect code smells and violations

**Regex Patterns:**
- `ProjectStructureDetector`: Filename pattern matching
- `EnhancedSuffixDetector`: Detect `*_enhanced.gd` patterns
- `UIDViolationDetector`: Detect `preload("res://...")` patterns
- `TypeSafetyDetector`: Detect untyped patterns

**Verdict:** ✅ **Acceptable** - Detection only, no code transformation.

---

### 6. `GodotToolkit.TestOrchestrator/Services/TestPairLocator.cs`

**Purpose:** Match test files to source files

**Regex Patterns:**
- Line 97: `Regex.Replace(fileName, @"(Unit)?Tests?$", "")` - Strip test suffix
- Line 185-188: PascalCase → snake_case conversion for filename matching

**Verdict:** ✅ **Acceptable** - Filename manipulation, not code transformation.

---

## ✅ ALREADY USING AST

### 1. `GodotToolkit.Parsing/CSharpAstParser.cs`

**Technology:** Roslyn (`Microsoft.CodeAnalysis.CSharp`)

**Capabilities:**
- Class extraction with inheritance
- Method extraction with parameters
- Property extraction
- Namespace/import extraction
- Full syntax tree access

**Status:** Available for reuse by other tools.

---

### 2. `GodotToolkit.Fixes/AstPortingFixer.cs` (NEW)

**Technology:** Roslyn SyntaxRewriter

**Capabilities:**
- `AddNewKeywordFix`: `Vector2(x,y)` → `new Vector2(x,y)`
- `ConstantCaseFix`: `Vector2.ZERO` → `Vector2.Zero`
- `GDScriptNewMethodFix`: `SomeClass.new()` → `new SomeClass()`
- `TypeAnnotationFix`: (placeholder for type conversions)

**Design:** Uses minimal pre-processing regex ONLY for syntax normalization (`.new()` → `.@new()`), then full AST transformation.

---

## Recommendations

### Immediate Actions

1. **Mark `PortingFixPatterns.cs` as deprecated**
   - Add `[Obsolete("Use AstPortingFixer instead")]` attribute
   - Update all callers to use `AstPortingFixer`

2. **Add more fixes to `AstPortingFixer.cs`**
   - Dictionary literal fix: `{}` → `new Dictionary<K,V>()`
   - Array literal fix: `[]` → `new List<T>()`
   - Assert conversion (use Roslyn to parse Assert calls properly)

3. **Refactor `ConversionFixer.cs`**
   - Create `AstConversionFixer` using Roslyn
   - Reuse `CSharpAstParser` for C# parsing
   - Keep `GDScriptParser` for GDScript (regex is acceptable)

### Long-term Migration

| File | Priority | Estimated Effort | Replacement |
|------|----------|------------------|-------------|
| `PortingFixPatterns.cs` | HIGH | Low (replacement exists) | `AstPortingFixer.cs` |
| `ConversionFixer.cs` | MEDIUM | Medium (new rewriters) | `AstConversionFixer.cs` (to create) |
| `ResourceFixer.cs` | MEDIUM | Low (use existing parsers) | Refactor to use parsers |

---

## Appendix: Existing AST Infrastructure

### CSharpAstParser Usage

```csharp
using GodotToolkit.Parsing;

var parser = new CSharpAstParser();
var tree = parser.ParseFile("MyFile.cs");

// Access parsed data
foreach (var cls in tree.Classes)
{
    Console.WriteLine($"Class: {cls.Name}");
    foreach (var method in cls.Methods)
    {
        Console.WriteLine($"  Method: {method.Name}");
    }
}

// Access raw Roslyn syntax tree for transformation
var root = tree.Root;
var rewriter = new MyCustomRewriter();
var newRoot = rewriter.Visit(root);
```

### AstPortingFixer Usage

```csharp
using GodotToolkit.Fixes;

var fixer = new AstPortingFixer();
var result = fixer.ApplyFixes(csharpCode);

if (result.Success)
{
    Console.WriteLine($"Applied {result.FixCount} fixes:");
    foreach (var fix in result.AppliedFixes)
    {
        Console.WriteLine($"  - {fix}");
    }
}
```
