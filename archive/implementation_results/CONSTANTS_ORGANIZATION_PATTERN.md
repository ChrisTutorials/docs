# Constants Organization Pattern

## Overview
Domain-specific constants should be organized into separate files by logical groups rather than consolidated into single large files.

## Pattern Structure

### Directory Organization
```
ProjectName/Core/Data/Constants/
├── FileExtensions.cs    # File extension constants
├── Paths.cs             # Directory and path constants  
├── StrategyNames.cs     # Strategy/operation names
├── Defaults.cs          # Default configuration values
├── ErrorMessages.cs     # Error message templates
├── ManifestKeys.cs      # JSON/manifest field keys
└── FileTypeGroups.cs    # Pre-defined file type arrays
```

### File Naming Convention
- **PascalCase** file names (C# convention)
- **Singular** names (FileExtensions, not FileExtension)
- **Descriptive** names that clearly indicate purpose

### Class Structure
```csharp
namespace ProjectName.Core.Data.Constants;

/// <summary>
/// Brief description of constant group purpose
/// </summary>
public static class FileExtensions
{
    public const string PNG = "png";
    public const string JPG = "jpg";
    // ... grouped by logical categories
}
```

## Usage Pattern

### Import Strategy
```csharp
// Use static imports for clean access
using static ProjectName.Core.Data.Constants.FileExtensions;
using static ProjectName.Core.Data.Constants.Paths;
using static ProjectName.Core.Data.Constants.ErrorMessages;
```

### Cross-Reference Groups
```csharp
// FileTypeGroups can reference other constant files
public static class FileTypeGroups
{
    public static readonly string[] IMAGE_EXTENSIONS = {
        FileExtensions.PNG, FileExtensions.JPG, FileExtensions.JPEG
    };
}
```

## Benefits

### 1. **Maintainability**
- Single location for each type of constant
- Easy to find and update specific values
- Clear separation of concerns

### 2. **Discoverability**
- IDE can suggest relevant constants by file
- Smaller files are easier to navigate
- Logical grouping aids understanding

### 3. **Scalability**
- Easy to add new constant groups
- No single file becomes too large
- Clear extension points for new domains

### 4. **Team Development**
- Reduced merge conflicts (smaller files)
- Clear ownership boundaries
- Easier code reviews

## Migration Strategy

### Phase 1: Extract Constants
1. Identify magic strings in existing code
2. Group by logical domain
3. Create separate constant files

### Phase 2: Update References
1. Add static using statements
2. Replace magic strings with constants
3. Update all consuming code

### Phase 3: Validation
1. Compile and test all changes
2. Verify no magic strings remain
3. Update documentation

## Implementation Examples

### AssetLoader Plugin (Reference Implementation)
```
/plugins/domains/gameplay/AssetLoader/Core/Data/Constants/
├── FileExtensions.cs    # png, jpg, json, toml, etc.
├── Paths.cs             # res://, user://, asset directories
├── StrategyNames.cs     # Local, Remote, Hybrid, Configuration
├── Defaults.cs          # Timeouts, cache sizes, versions
├── ErrorMessages.cs     # Formatted error templates
├── ManifestKeys.cs      # JSON manifest field names
└── FileTypeGroups.cs    # Arrays of related extensions
```

### GridBuilding Plugin (Future Implementation)
```
/plugins/GridBuilding/Core/Data/Constants/
├── BuildingTypes.cs     # Residential, Commercial, Industrial
├── GridDimensions.cs    # Default grid sizes, cell dimensions
├── PlacementRules.cs    # Valid placement patterns
├── ResourcePaths.cs     # Asset directories, resource locations
└── ValidationMessages.cs # Error messages for placement validation
```

## Anti-Patterns to Avoid

### ❌ Consolidated Constants File
```csharp
// AVOID: Large file with mixed concerns
public static class AllConstants
{
    // File extensions
    public const string PNG = "png";
    
    // Error messages  
    public const string ASSET_NOT_FOUND = "Asset not found: {0}";
    
    // Default values
    public const int DEFAULT_TIMEOUT = 30;
    
    // Paths
    public const string ASSETS_PATH = "res://assets/";
}
```

### ❌ Mixed Domain Constants
```csharp
// AVOID: Constants from different domains in same file
public static class AssetLoaderConstants
{
    // File extensions (domain: file formats)
    public const string PNG = "png";
    
    // Error messages (domain: user communication)  
    public const string ASSET_NOT_FOUND = "Asset not found: {0}";
    
    // Strategy names (domain: architecture)
    public const string LOCAL_STRATEGY = "Local";
}
```

## Quality Checklist

### ✅ Good Implementation
- [ ] Constants grouped by logical domain
- [ ] Each file has single responsibility
- [ ] File names clearly indicate purpose
- [ ] XML documentation for each class
- [ ] Static using statements in consuming code
- [ ] No magic strings remain in codebase

### ❌ Issues to Fix
- [ ] Mixed domain constants in same file
- [ ] Large consolidated constant files
- [ ] Unclear file naming
- [ ] Missing documentation
- [ ] Direct string literals in code

## Tooling Support

### IDE Integration
- **Visual Studio**: Navigate To (Ctrl+T) works well with small files
- **Rider**: Structure view shows clear constant organization
- **VS Code**: IntelliSense suggests relevant constants by file

### Build Validation
Consider adding a build step that checks for magic strings:
```bash
# Example: Check for hardcoded file extensions
grep -r "\.png\|\.jpg\|\.json" --include="*.cs" src/ | grep -v "FileExtensions\."
```

## Conclusion

This pattern provides excellent long-term maintainability by:
- Separating concerns logically
- Making constants discoverable and manageable
- Supporting team development workflows
- Scaling well with project growth

**Adopt this pattern for all new projects and migrate existing code incrementally.**
