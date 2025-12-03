# Code Block Optimization Plan

## 🎯 Objective
Reduce token usage by limiting code blocks to maximum 20 lines

## 📊 Current Status

### Files with Large Code Blocks
1. **FunctionSynchronizer.md**: 3896 lines (largest)
2. **ASTFunctionSynchronizer.md**: 1136 lines  
3. **IntegratedFixResult.md**: 1047 lines
4. **AutoPortingOrchestrator.md**: 968 lines
5. **StaticTypingEnhancer.md**: 911 lines

### Analysis
- Most code blocks are already small (1-5 lines)
- Large files contain many small code blocks, not few large ones
- Total line counts include all content, not just code blocks

## 📋 Optimization Strategy

### Phase 1: Identify Problematic Blocks
- Scan files for code blocks > 20 lines
- Focus on actual long code blocks, not total file length

### Phase 2: Apply Truncation Pattern
```markdown
// Before: 50+ line code block
```csharp
public class VeryLongClass
{
    // ... 50 lines of code
    public void Method1() { /* ... */ }
    public void Method2() { /* ... */ }
    // ... many more methods
}
```

// After: 20 lines + truncation
```csharp
public class VeryLongClass
{
    // ... 20 lines shown
    public void Method1() { /* ... */ }
    public void Method2() { /* ... */ }
    // ... (30+ lines truncated)
}
```

### Phase 3: Alternative Approaches
- Use file paths instead of full code
- Show only relevant snippets
- Reference external files

## 🔧 Implementation Pattern

### For Documentation
```markdown
// Instead of full implementation
See: `/toolkits/cs/src/FunctionSynchronizer.cs`

// Or show key pattern only
```csharp
public class FunctionSynchronizer
{
    // Key method signature
    public async Task SyncFunctions() { /* implementation */ }
    // ... (full implementation in source file)
}
```

### For Examples
- Show only the pattern being demonstrated
- Use "..." to indicate omitted code
- Focus on essential parts only

## 📈 Expected Impact

### Token Reduction
- **Current**: Some code blocks 50+ lines
- **Target**: Maximum 20 lines per block
- **Savings**: 60% reduction in code block tokens

### Benefits
- Faster AI processing
- Lower token costs
- Better focus on relevant code
- Easier documentation maintenance

## 🎯 Success Metrics

### Quantitative
- Code blocks > 20 lines: 0
- Average code block size: < 10 lines
- Token reduction: 60% in code sections

### Qualitative
- Documentation remains useful
- Key patterns still visible
- External references work effectively

## 📅 Next Steps

1. **Audit**: Scan for actual long code blocks
2. **Prioritize**: Start with largest files
3. **Implement**: Apply truncation pattern
4. **Validate**: Ensure documentation remains useful

---

**Status**: Ready to begin implementation ✅
