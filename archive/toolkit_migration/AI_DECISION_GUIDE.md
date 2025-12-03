# AI Agent Decision Guide - C# Toolkit

## 🚯 First Decision Tree for AI Agents

When working with JSON in C# toolkit projects, follow this decision tree:

```
Need to handle JSON data?
├─ YES → Use JsonHelper from GodotToolkit.Common
│  ├─ Need to serialize object?
│  │  ├─ To string? → JsonHelper.SerializeToString(obj, indented: true)
│  │  └─ To file? → JsonHelper.SerializeToFile(obj, "path.json")
│  └─ Need to deserialize?
│     ├─ From string? → JsonHelper.DeserializeFromString<T>(json)
│     └─ From file? → JsonHelper.TryDeserializeFromFile<T>("path.json", out var result)
└─ NO → Proceed with other operations
```

## 🔍 Tool Selection Guide

### For Code Analysis
```bash
# AI-friendly output (single line)
dotnet run -- /path/to/project --quiet

# Full analysis (verbose)
dotnet run -- /path/to/project
```

### For API Validation
```bash
# Critical issues only
dotnet run -- /path/to/api --quiet

# Full validation report
dotnet run -- /path/to/api
```

### For Production Readiness
```bash
# Score + critical issues
dotnet run -- analyze --project /path/to/project --quiet

# Full readiness report
dotnet run -- analyze --project /path/to/project
```

## ⚠️ Common Pitfalls to Avoid

### ❌ NEVER Do This
```csharp
// Manual JSON parsing (causes errors)
var json = JsonSerializer.Serialize(obj, new JsonSerializerOptions { 
    WriteIndented = true,
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase 
});
```

### ✅ ALWAYS Do This
```csharp
// Safe JSON operations
var json = JsonHelper.SerializeToString(obj, indented: true);
```

## 🎯 Quick Reference

| Operation | Command | Output | Tokens |
|-----------|---------|--------|--------|
| Project stats | `ai-stats [dir]` | File counts | ~50 |
| Build errors | `ai-build [proj]` | Top 5 errors | ~150 |
| Test results | `ai-test [proj]` | Top 5 failures | ~200 |
| Code metrics | `CodeAnalysis --quiet` | Single line | ~30 |
| API check | `ApiValidation --quiet` | Critical issues | ~100 |
| Production check | `ProductionReadiness --quiet` | Score + issues | ~100 |

## 📝 Memory Update Pattern

When using tools, update memory with:
```markdown
## Tool Usage
- Used: CodeAnalysis --quiet
- Result: Type: Plugin | Files: 846 | Lines: 219803 | Classes: 1492 | Methods: 9982 | Violations: 0
- Tokens: ~30
- Status: ✅ SUCCESS
```

This ensures future AI agents know what works and what doesn't.
