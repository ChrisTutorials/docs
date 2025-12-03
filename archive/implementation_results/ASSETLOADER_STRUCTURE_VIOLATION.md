# AssetLoader Structure Violation Analysis

## Problem Identified

The AssetLoader plugin is currently located in the wrong directory structure, violating our established project organization standards.

## Current (Incorrect) Structure
```
plugins/AssetLoader/
├── AssetLoader.csproj
├── Core/
├── Tests/
├── configs/
└── scripts/
```

## Required (Correct) Structure
According to PROJECT_STRUCTURE_STANDARDS.md, plugins should follow the multi-engine structure:

```
plugins/domains/gameplay-mechanics/AssetLoader/
├── Core/                    # Engine-agnostic logic
│   ├── Data/               # Configuration and data structures
│   ├── Interfaces/         # Strategy and cache interfaces
│   ├── Strategies/         # Loading strategy implementations
│   ├── Cache/              # Caching system
│   └── Utilities/          # Helper functions
├── Godot/                  # Godot-specific implementations
│   ├── AssetLoader.gd      # Godot entry point
│   ├── plugin.cfg          # Godot plugin configuration
│   └── Resources/          # Godot resources
├── Unity/                  # Unity-specific implementations (future)
│   └── AssetLoader.cs      # Unity MonoBehaviour
├── Tests/                  # Cross-engine tests
│   ├── Core/               # Core logic tests
│   ├── CrossEngine/        # Cross-engine compatibility
│   ├── Godot/              # Godot-specific tests
│   └── Unity/              # Unity-specific tests
├── configs/                # Configuration files
├── scripts/                # Build and export scripts
├── docs/                   # Documentation
└── AssetLoader.csproj      # Project file
```

## Violation Details

### 1. Directory Structure Violation
- **Issue**: Located at `plugins/AssetLoader/` instead of `plugins/domains/gameplay-mechanics/AssetLoader/`
- **Impact**: Breaks consistent organization with other plugins
- **Standard**: Multi-engine plugins should be under `domains/` with proper categorization

### 2. Engine Separation Violation
- **Issue**: Godot-specific files mixed with Core files
- **Impact**: Unclear separation between engine-agnostic and engine-specific code
- **Standard**: Core/ should contain only engine-agnostic logic

### 3. Missing Unity Structure
- **Issue**: No Unity/ directory prepared for future Unity implementation
- **Impact**: Limits cross-engine compatibility
- **Standard**: Multi-engine structure should support both Godot and Unity

## Resolution Plan

### Phase 1: Directory Restructuring
1. Create correct directory structure under `domains/gameplay-mechanics/`
2. Move Core/ to new location maintaining internal structure
3. Create Godot/ directory and move Godot-specific files
4. Create Unity/ directory for future implementation
5. Move Tests/ to new location with proper subdirectories

### Phase 2: File Organization
1. Move Godot-specific files:
   - `AssetLoader.gd` → `Godot/AssetLoader.gd`
   - `plugin.cfg` → `Godot/plugin.cfg`
   - Core UI resources → `Godot/Resources/`

2. Keep Core files in Core/:
   - `Core/Data/` → `Core/Data/`
   - `Core/Interfaces/` → `Core/Interfaces/`
   - `Core/Strategies/` → `Core/Strategies/`
   - `Core/Cache/` → `Core/Cache/`
   - `Core/Utilities/` → `Core/Utilities/`

3. Reorganize Tests/:
   - `Tests/Core/` → `Tests/Core/`
   - `Tests/CrossEngine/` → `Tests/CrossEngine/`
   - `Tests/Godot/` → `Tests/Godot/`
   - `Tests/Unity/` → `Tests/Unity/`

### Phase 3: Configuration Updates
1. Update export-config.json with new path
2. Update AssetLoader.csproj if needed
3. Update any import statements or references
4. Update documentation with new structure

### Phase 4: Validation
1. Verify all files are correctly placed
2. Test that export process works with new structure
3. Run tests to ensure no broken references
4. Update documentation to reflect correct structure

## Benefits of Fixing

### 1. Consistency
- Aligns with established project structure standards
- Matches organization of other plugins (GridBuilding, ItemDrops, WorldTime)
- Provides predictable location for developers

### 2. Maintainability
- Clear separation between engine-agnostic and engine-specific code
- Easier to add Unity implementation in future
- Better organization for cross-engine development

### 3. Scalability
- Supports multiple engine targets
- Clear expansion path for new features
- Proper categorization under gameplay-mechanics domain

## Implementation Commands

```bash
# Create new structure
mkdir -p plugins/domains/gameplay-mechanics/AssetLoader
mkdir -p plugins/domains/gameplay-mechanics/AssetLoader/Core
mkdir -p plugins/domains/gameplay-mechanics/AssetLoader/Godot
mkdir -p plugins/domains/gameplay-mechanics/AssetLoader/Unity
mkdir -p plugins/domains/gameplay-mechanics/AssetLoader/Tests/Core
mkdir -p plugins/domains/gameplay-mechanics/AssetLoader/Tests/CrossEngine
mkdir -p plugins/domains/gameplay-mechanics/AssetLoader/Tests/Godot
mkdir -p plugins/domains/gameplay-mechanics/AssetLoader/Tests/Unity
mkdir -p plugins/domains/gameplay-mechanics/AssetLoader/Godot/Resources

# Move Core files
cp -r plugins/AssetLoader/Core/* plugins/domains/gameplay-mechanics/AssetLoader/Core/

# Move Godot files
cp plugins/AssetLoader/AssetLoader.gd plugins/domains/gameplay-mechanics/AssetLoader/Godot/
cp plugins/AssetLoader/plugin.cfg plugins/domains/gameplay-mechanics/AssetLoader/Godot/

# Move Tests
cp -r plugins/AssetLoader/Tests/* plugins/domains/gameplay-mechanics/AssetLoader/Tests/

# Move other files
cp plugins/AssetLoader/AssetLoader.csproj plugins/domains/gameplay-mechanics/AssetLoader/
cp -r plugins/AssetLoader/configs plugins/domains/gameplay-mechanics/AssetLoader/
cp -r plugins/AssetLoader/scripts plugins/domains/gameplay-mechanics/AssetLoader/
cp plugins/AssetLoader/README.md plugins/domains/gameplay-mechanics/AssetLoader/
cp plugins/AssetLoader/LICENSE plugins/domains/gameplay-mechanics/AssetLoader/

# Update export configuration
# (Manual edit required for export-config.json)
```

## Status

- [ ] Phase 1: Directory restructuring
- [ ] Phase 2: File organization  
- [ ] Phase 3: Configuration updates
- [ ] Phase 4: Validation

## Priority

This violation should be fixed as **HIGH PRIORITY** because:
1. Breaks established project structure standards
2. Causes confusion for developers expecting consistent organization
3. Limits future cross-engine development
4. Affects export process and automation

## Related Documents

- PROJECT_STRUCTURE_STANDARDS.md - Defines correct structure
- export-config.json - Needs path updates
- AssetLoader documentation - Needs structure updates
