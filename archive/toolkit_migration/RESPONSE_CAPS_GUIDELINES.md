# Response Length Caps Guidelines

## 🎯 Objective
Limit AI responses to <200 tokens using bullet points and minimal text

## 📋 Response Pattern

### ✅ Correct Format
```markdown
## Status
- Task: Complete
- Files: 3 updated  
- Tokens: 150
- Impact: 75% reduction

## Next Steps
- Add quiet modes
- Update documentation
- Test implementation
```

### ❌ Avoid This Format
```markdown
## Status
I have successfully completed the task of updating the files. The implementation involved modifying three different files to ensure proper functionality. This work resulted in a significant reduction of token usage, approximately 75% less than before, which will help with the overall optimization goals we have set.

## Next Steps  
The next phase of work will involve adding quiet modes to the remaining tools. This will require careful consideration of the existing codebase and ensuring that the new functionality integrates properly with the current architecture...
```

## 🔧 Implementation Rules

### 1. Bullet Points Only
- Use `-` for bullet points
- No paragraphs of explanation
- Maximum 2-3 lines per bullet

### 2. Section Headers
- Use `##` for main sections
- Keep headers minimal
- No explanatory text under headers

### 3. Token Counting
- Target: <200 tokens total
- Count all text including headers
- Use online token counter if needed

### 4. Content Priorities
1. **Status**: What was done
2. **Metrics**: Numbers, counts, percentages
3. **Next Steps**: What's next
4. **Files**: What was changed

## 📊 Examples

### Good Example (120 tokens)
```markdown
## JsonHelper Implementation
- Status: Complete
- Files: BulkPortingModels.cs, ProgramWorking.cs
- Changes: 6 manual JSON calls → JsonHelper
- Benefits: Consistent error handling

## Impact  
- Token reduction: 95%
- Error prevention: 100%
- Code consistency: Improved
```

### Bad Example (350+ tokens)
```markdown
## JsonHelper Implementation Complete

I have successfully implemented the JsonHelper pattern across the toolkit. This involved updating several key files including BulkPortingModels.cs and ProgramWorking.cs. In these files, I replaced a total of 6 manual JSON serialization calls with the standardized JsonHelper methods. The primary benefits of this change include consistent error handling across all tools, automatic camelCase formatting, and elimination of potential parsing errors that were causing issues with the AI agent tools.

The impact has been significant - we've achieved approximately 95% reduction in token usage for JSON operations and completely prevented the parsing errors that were disrupting the workflow. This represents a major improvement in code consistency and maintainability...
```

## 🎯 Quick Reference

### Response Template
```markdown
## [Topic]
- Status: [Complete/In Progress/Pending]
- Files: [count] files
- Changes: [brief description]
- Impact: [key metric]

## Next Steps  
- [Action 1]
- [Action 2]
- [Action 3]
```

### Token Breakdown
- Headers: ~30 tokens
- Bullet points: ~120 tokens (6 points × 20 tokens)
- Total: ~150 tokens (well under 200 limit)

## 📈 Enforcement

### Self-Monitoring
- Count tokens before sending
- Use bullet points exclusively
- Cut explanatory paragraphs

### Quality Check
- Is it under 200 tokens?
- Does it use only bullet points?
- Does it convey essential information?
- Is it actionable?

---

**Target**: <200 tokens per response ✅
