# Vector2 Type Deprecation Plan

## Overview
This document outlines the deprecation and removal plan for custom Vector2 types and wrappers that were created specifically for GDScript-to-C# backporting compatibility. Since we're moving to a pure C# approach, these types are no longer needed.

## 🚫 **Types to Deprecate**

### 1. **Primary Vector2 Implementation**
- **File**: `src/GodotToolkit.Common/Types/GodotTypes.cs`
- **Type**: `public readonly struct Vector2`
- **Lines**: ~9-400 (entire implementation)
- **Reason**: Replaced by `System.Numerics.Vector2`
- **Migration**: Use `System.Numerics.Vector2` directly

### 2. **Vector2 Conversion Utilities**
- **File**: `src/GodotToolkit.Common/Types/GodotTypes.cs`
- **Type**: `public static class Vector2Conversions`
- **Lines**: ~605-638
- **Reason**: Temporary migration helpers
- **Migration**: Use conversion methods only during transition period

### 3. **MockTransform2D Vector2 Usage**
- **File**: `src/Tests/GodotToolkit.Tests/Helpers/Mocks/MockTypes.cs`
- **Type**: MockTransform2D class properties
- **Properties**: `Origin`, `Scale` 
- **Reason**: Uses Common.Vector2 instead of System.Numerics.Vector2
- **Migration**: Already updated to use System.Numerics.Vector2

### 4. **MockNode2D Vector2 Usage**
- **File**: `src/Tests/GodotToolkit.Tests/Helpers/Mocks/MockNode.cs`
- **Type**: MockNode2D class properties
- **Properties**: `Position`, `Scale`, `GlobalPosition`, `GlobalScale`
- **Reason**: Uses Common.Vector2 instead of System.Numerics.Vector2
- **Migration**: Already updated to use System.Numerics.Vector2

### 5. **MockCollision Vector2 Usage**
- **File**: `src/Tests/GodotToolkit.Tests/Helpers/Mocks/MockCollision.cs`
- **Type**: MockRectangleShape2D, MockTileRange classes
- **Properties**: `Size`, `MinPosition`, `MaxPosition`
- **Reason**: Uses Common.Vector2 instead of System.Numerics.Vector2
- **Migration**: Update to use System.Numerics.Vector2

## 🔄 **Global Using Statements to Update**

### Files Requiring Updates:
1. **`src/Tests/GodotToolkit.Tests/Base/GBTestConstants.cs`**
   - Current: `global using Vector2 = GodotToolkit.Common.Types.Vector2;`
   - Target: `global using Vector2 = System.Numerics.Vector2;` ✅ **DONE**

2. **Potential other files with global Vector2 aliases**
   - Need to search for additional global using statements

## 📋 **Deprecation Timeline**

### Phase 1: Immediate (Current Sprint)
- ✅ **Add deprecation attributes** to Common.Vector2
- ✅ **Create migration documentation** 
- ✅ **Update global using statements**
- 🔄 **Update remaining mock classes** to use System.Numerics.Vector2

### Phase 2: Next Sprint
- ⏳ **Add Obsolete attributes** with warnings
- ⏳ **Update all core logic** to use System.Numerics.Vector2
- ⏳ **Run comprehensive tests** to ensure compatibility

### Phase 3: Future Release (2-3 sprints)
- ⏳ **Remove Common.Vector2** entirely
- ⏳ **Remove Vector2Conversions** class
- ⏳ **Clean up any remaining references**

## 🛠️ **Migration Guide**

### Before (Common.Vector2):
```csharp
using GodotToolkit.Common.Types;

public Vector2 CalculatePosition()
{
    return new Vector2(100, 200);
}
```

### After (System.Numerics.Vector2):
```csharp
using System.Numerics;

public Vector2 CalculatePosition()
{
    return new Vector2(100, 200);
}
```

### For Godot API Interactions:
```csharp
// When calling Godot API
var godotVector = systemVector.ToGodotVector2();

// When receiving from Godot API  
var systemVector = godotVector.ToSystemVector2();
```

## ⚠️ **Breaking Changes**

### Core Logic Updates Required:
1. **GridPosition.cs** - Update Vector2 usage
2. **GridMath.cs** - Update Vector2 usage  
3. **PlacementShapeUtils.cs** - Update Vector2 usage
4. **PlacementContext.cs** - Update Vector2 usage
5. **ValidationResults.cs** - Update Vector2 usage
6. **RuleResult.cs** - Update Vector2 usage

### Test Updates Required:
1. All test files using Common.Vector2
2. Mock classes and factories
3. Assertion helpers

## 🎯 **Success Criteria**

- [ ] All Common.Vector2 references replaced with System.Numerics.Vector2
- [ ] All tests pass with System.Numerics.Vector2
- [ ] No compilation errors related to Vector2 types
- [ ] Performance benchmarks show no regression
- [ ] Godot API interactions work correctly with conversion utilities

## 📝 **Notes**

- The `Vector2I` and `Rect2I` types from Common should be **kept** as they don't have direct System.Numerics equivalents
- The `Color` type from Common should be **kept** as it's different from System.Drawing.Color
- Conversion utilities should remain during transition but be marked obsolete
- Some core logic may need careful updates due to API differences between the implementations

## 🔍 **Verification Commands**

```bash
# Find remaining Common.Vector2 usage
find src -name "*.cs" -exec grep -l "GodotToolkit\.Common\.Types\.Vector2" {} \;

# Find System.Numerics.Vector2 usage  
find src -name "*.cs" -exec grep -l "System\.Numerics\.Vector2" {} \;

# Build to verify no errors
dotnet build src/GodotToolkit.Common/GodotToolkit.Common.csproj
dotnet build src/Tests/GodotToolkit.Tests/GodotToolkit.Tests.csproj
```

---

**Created**: Nov 28, 2025  
**Status**: In Progress  
**Next Review**: End of current sprint
