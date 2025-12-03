# Git LFS Ban Policy

## Policy Statement
**Git LFS is BANNED across all projects** in the game development workspace.

## Rationale

### Complexity Issues
- **Setup Complexity**: Requires LFS server configuration and client setup
- **Sync Issues**: LFS objects can become out of sync with Git history
- **Authentication Problems**: Separate authentication for LFS vs Git
- **Migration Pain**: Moving repositories with LFS is difficult
- **Debugging Complexity**: Hard to troubleshoot LFS vs Git issues

### Performance Issues
- **Clone Performance**: Initial clone requires downloading LFS objects
- **Network Overhead**: Separate requests for Git and LFS data
- **Storage Duplication**: Files stored in both Git pointers and LFS store
- **Backup Complexity**: Need to backup both Git and LFS separately

### Operational Issues
- **CI/CD Integration**: Build systems need LFS support
- **Tool Compatibility**: Not all Git tools support LFS
- **Team Onboarding**: New developers must learn LFS concepts
- **Repository Size**: LFS pointers still count toward repository size

## Alternative Strategy: External Assets

### What Belongs in Git
- Source code (*.cs, *.gd, *.cpp, *.h)
- Configuration files (*.toml, *.json, *.yaml, *.xml)
- Documentation (*.md, *.txt, *.rst)
- Small assets (< 100KB total)
- Build scripts and tooling
- Text-based assets

### What Belongs in External Assets
- Large binary files (> 100KB)
- Images (*.png, *.jpg, *.gif)
- Audio files (*.wav, *.mp3, *.ogg)
- Video files (*.mp4, *.webm)
- 3D models (*.fbx, *.obj, *.gltf)
- Map files (*.tmx, *.json)
- Archives (*.zip, *.tar.gz)
- Tool binaries and packages

### Asset Directory Structure
```
assets/
├── animations/     # GIF, video files
├── audio/         # Sound effects, music
├── images/        # Large PNG/JPG/SVG files
├── maps/          # TMX, level files
├── models/        # 3D models, meshes
├── tools/         # Binary tools, packages
├── diagrams/      # PlantUML, complex diagrams
└── exports/       # Generated reports, archives
```

## Implementation Guidelines

### 1. Repository Setup
```bash
# Add to .gitignore
# Large binary assets (moved to external assets/)
*.gif
*.png
*.jpg
*.jpeg
*.svg
*.mp3
*.wav
*.ogg
*.mp4
*.webm
*.fbx
*.obj
*.gltf
*.tmx
*.zip
*.tar.gz

# External assets directories
assets/animations/
assets/audio/
assets/images/
assets/maps/
assets/models/
assets/tools/
assets/diagrams/
assets/exports/
```

### 2. Migration Process
```bash
# Move large files to assets
mv large_files/* assets/appropriate_directory/

# Remove from Git tracking
git rm --cached large_files/*

# Commit changes
git add .gitignore assets/
git commit -m "Remove large files, move to external assets"
```

### 3. Repository Cleanup
```bash
# Clean Git history (if needed)
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch large_file_pattern' \
  --prune-empty --tag-name-filter cat -- --all

# Optimize repository
git gc --aggressive --prune=now
```

## Benefits of LFS-Free Approach

### Simplicity
- **Single Toolchain**: Only Git needed
- **Standard Workflow**: Familiar Git operations
- **Easy Onboarding**: No LFS concepts to learn
- **Universal Compatibility**: Works with all Git tools

### Performance
- **Faster Clones**: No LFS object downloads
- **Smaller History**: No LFS pointers in history
- **Standard Git Operations**: All commands work normally
- **Better Caching**: Standard Git caching applies

### Reliability
- **No Sync Issues**: Everything in Git history
- **Standard Backups**: Single repository to backup
- **Simple Recovery**: Standard Git recovery tools
- **Predictable Behavior**: No LFS edge cases

## Enforcement

### Pre-commit Hooks
```bash
#!/bin/sh
# .git/hooks/pre-commit
# Check for large files
if git diff --cached --name-only | xargs du -b | awk '$1 > 102400 {print $2}' | grep -q .; then
    echo "Error: Files larger than 100KB detected. Move to assets/ directory."
    exit 1
fi
```

### CI/CD Validation
```yaml
# GitHub Actions / GitLab CI
- name: Check for large files
  run: |
    find . -type f -size +100k -not -path "./assets/*" -exec echo "Large file found: {}" \;
    if [ $? -ne 0 ]; then exit 1; fi
```

### Repository Health Checks
```bash
# Regular repository size monitoring
du -sh .git
git count-objects -vH
```

## Project-Specific Guidelines

### Game Development Projects
- **Textures**: Keep small UI elements, move large textures to assets/
- **Audio**: Move all audio files to assets/audio/
- **Models**: Move 3D models to assets/models/
- **Maps**: Move TMX files to assets/maps/

### Tool Development Projects
- **Binaries**: Move compiled tools to assets/tools/
- **Packages**: Move NuGet/npm packages to assets/tools/
- **Documentation**: Keep small diagrams, move large ones to assets/diagrams/

### Documentation Projects
- **Images**: Move large images to assets/images/
- **Diagrams**: Move complex diagrams to assets/diagrams/
- **Exports**: Move generated reports to assets/exports/

## Migration Checklist

### Before Migration
- [ ] Identify all large files (> 100KB)
- [ ] Create appropriate asset directories
- [ ] Update .gitignore with banned file types
- [ ] Document asset locations in project README

### During Migration
- [ ] Move files to asset directories
- [ ] Update any code references to file paths
- [ ] Remove files from Git tracking
- [ ] Commit changes with clear message

### After Migration
- [ ] Test that all functionality works
- [ ] Verify repository size is reduced
- [ ] Update documentation
- [ ] Communicate changes to team

## Success Metrics

- **Repository Size**: < 100MB .git directory
- **Clone Time**: < 2 minutes for fresh clone
- **No LFS Dependencies**: Zero git-lfs commands needed
- **Team Productivity**: No LFS-related support tickets
- **Build Reliability**: 100% successful CI/CD builds

## Tools for Enforcement

### Repository Analysis
```bash
# Find large files
find . -type f -size +100k -exec ls -lh {} \;

# Check repository composition
git ls-files | awk -F. '{print $NF}' | sort | uniq -c | sort -nr
```

### Automated Cleanup
```bash
# One-time cleanup script
#!/bin/bash
LARGE_FILES=$(find . -type f -size +100k -not -path "./assets/*")
for file in $LARGE_FILES; do
    echo "Moving $file to assets/"
    mv $file assets/
    git rm --cached "$file"
done
```

---

**Policy**: Git LFS is banned. Use external assets directory for large files. Simpler, faster, more reliable.
