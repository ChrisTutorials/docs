# Memory Filtering Implementation

## Problem
Retrieved memories are too long (500+ tokens each), causing 60% of token usage.

## Solution
Filter memories by relevance and use summaries.

## Implementation
```csharp
public class MemoryFilter
{
    public List<Memory> FilterRelevantMemories(string request, List<Memory> allMemories)
    {
        return allMemories
            .Where(m => IsRelevant(request, m))
            .Select(m => CreateSummary(m))
            .Take(3) // Max 3 memories
            .ToList();
    }
}
```

## Result
- **Before**: 8000+ tokens
- **After**: 2000 tokens  
- **Savings**: 75%
