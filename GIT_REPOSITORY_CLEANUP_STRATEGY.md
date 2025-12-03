# Git Repository Cleanup Strategy

## Problem
Git repository has grown to include large binary files that trigger Git LFS requirements, causing push failures and complexity.

## Root Cause Analysis
Large files (GIFs, TMX maps, SVGs, PlantUML files) were committed directly to the repository, making it bloated and requiring LFS handling.

## Solution: Repository Cleanup
Instead of implementing Git LFS, we'll clean up the repository by:

1. **Identify Large Files**: Find files > 1MB that should be moved to assets
2. **Remove from Git History**: Use `git filter-branch` or `git-filter-repo` to remove large files
3. **Move to Assets**: Relocate large files to proper asset directories
4. **Document Asset Strategy**: Establish clear guidelines for asset management

## Large Files Identified
From `git lfs ls-files`, the problematic files include:
- Animated GIFs (16x16 farm animations) - ~70MB total
- TMX map files - ~5MB total  
- SVG icons and PlantUML diagrams - ~2MB total
- Other binary assets

## Cleanup Strategy

### Phase 1: Assessment
```bash
# Find largest files in repository
git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort -nk2 | tail -20

# Check current repository size
du -sh .git
```

### Phase 2: Move Large Files to Assets
```bash
# Create proper asset directories
mkdir -p assets/animations
mkdir -p assets/maps  
mkdir -p assets/icons
mkdir -p assets/diagrams

# Move files out of repository tracking
git rm --cached projects/Thistletide/godot/assets/modern_farm/art/Animated_16x16/**/*.gif
git rm --cached projects/Thistletide/godot/assets/tiled/*.tmx
git rm --cached projects/Thistletide/godot/assets/tiled/*.svg
git rm --cached **/*.puml

# Move to proper asset locations
mv projects/Thistletide/godot/assets/modern_farm/art/Animated_16x16/**/*.gif assets/animations/
mv projects/Thistletide/godot/assets/tiled/*.tmx assets/maps/
mv projects/Thistletide/godot/assets/tiled/*.svg assets/icons/
mv **/*.puml assets/diagrams/
```

### Phase 3: Clean Git History
```bash
# Remove large files from history
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch projects/Thistletide/godot/assets/modern_farm/art/Animated_16x16/**/*.gif' \
  --prune-empty --tag-name-filter cat -- --all

# Alternative: Use git-filter-repo (recommended)
pip3 install git-filter-repo
git filter-repo --path projects/Thistletide/godot/assets/modern_farm/art/Animated_16x16/**/*.gif --invert-paths
```

### Phase 4: Repository Optimization
```bash
# Compress and clean up
git gc --aggressive --prune=now
git repack -ad

# Check final size
du -sh .git
```

## Asset Management Guidelines

### What Belongs in Git Repository
- Source code (*.cs, *.gd, *.csproj)
- Configuration files (*.toml, *.json, *.yaml)
- Documentation (*.md, *.txt)
- Small assets (< 100KB)
- Build scripts and tooling

### What Belongs in External Assets
- Large animations (> 1MB)
- Map files (> 500KB)
- Audio files
- Video content
- Large image assets
- Binary distributions

### Asset Directory Structure
```
assets/
├── animations/     # GIF, video files
├── maps/          # TMX, level files
├── audio/         # Sound effects, music
├── images/        # Large PNG/JPG files
├── models/        # 3D models, meshes
└── diagrams/      # PlantUML, complex diagrams
```

## Benefits of This Approach

1. **Simpler Repository**: No LFS complexity
2. **Faster Clones**: Smaller repository size
3. **Clear Separation**: Code vs assets properly organized
4. **Better Performance**: Git operations faster
5. **Easier Backup**: Assets can be backed up separately

## Implementation Timeline

### Day 1: Assessment and Planning
- Identify all large files
- Create asset directory structure
- Document the strategy

### Day 2: File Migration
- Move large files to asset directories
- Update any references in code
- Test that everything still works

### Day 3: Repository Cleanup
- Remove files from Git history
- Run repository optimization
- Test clone/push operations

## Success Metrics

- Repository size < 100MB
- No LFS requirements
- All assets accessible in proper locations
- Git operations (clone, push, pull) working normally
- No broken references in code

## Rollback Plan

If anything goes wrong during cleanup:
1. Create backup branch before starting
2. Use `git reflog` to restore if needed
3. Keep original files until verification complete

## Tools Required

- `git-filter-repo` (preferred over `git filter-branch`)
- `du`, `sort`, `tail` for file analysis
- Asset directory structure planning

## Documentation Updates

After cleanup, update:
- README.md with new asset structure
- CONTRIBUTING.md with asset guidelines
- Build scripts to reference asset locations
- Development documentation

---

**Strategy**: Clean repository + external assets = simpler, faster, more maintainable
