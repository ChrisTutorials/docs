# Git LFS Policy - Selective Usage for Game Assets

## Policy Statement
**Git LFS is BANNED for development tools and plugins, but ALLOWED for game projects, demos, and assets.**

## Usage Rules

### ❌ **Git LFS BANNED** (No Exceptions)
- **`/toolkits/`** - Development tools and utilities
- **`/plugins/`** - Reusable runtime components  
- **`/scripts/`** - Automation and build scripts
- **`/docs/`** - Documentation and guides

### ✅ **Git LFS ALLOWED** (Game Assets Only)
- **`/projects/`** - Game projects with art assets
- **`/demos/`** - Demo projects and examples
- **`/assets/`** - External asset directories
- **Any `art/` folders** - Game art and graphics
- **Any `audio/` folders** - Sound effects and music

## Rationale

### Why LFS for Game Assets?
- **Large Binary Files**: Art assets (PNG, GIF, audio, 3D models) are essential to games
- **Version Control Needed**: Game assets change with development and need tracking
- **Team Collaboration**: Artists need to version control their work
- **Build Integration**: Game engines need access to versioned assets

### Why No LFS for Development Tools?
- **Code-Only**: Toolkits and plugins are primarily source code
- **Build Performance**: LFS slows down compilation and CI/CD
- **Complexity**: Development tools should be simple to clone and build
- **External Assets**: Tools can reference external asset locations

## Implementation Guidelines

### For Game Projects (`/projects/`)
```bash
# Enable LFS for game projects
cd projects/Thistletide
git lfs install
git lfs track "*.png"
git lfs track "*.gif" 
git lfs track "*.wav"
git lfs track "*.mp3"
git lfs track "*.fbx"
git lfs track "*.tmx"
```

### For Demos (`/demos/`)
```bash
# Enable LFS for demo assets
cd demos/grid_building_dev
git lfs install
git lfs track "*.png"
git lfs track "*.gif"
git lfs track "*.wav"
```

### For Toolkits and Plugins (`/toolkits/`, `/plugins/`)
```bash
# NO LFS - Use external assets directory
# Large files go in assets/ and are .gitignored
git lfs uninstall  # Remove any LFS setup
```

## File Type Guidelines

### **Use LFS For** (Game Assets Only)
- **Images**: `*.png`, `*.jpg`, `*.gif`, `*.svg` (in game projects)
- **Audio**: `*.wav`, `*.mp3`, `*.ogg`, `*.m4a`
- **3D Models**: `*.fbx`, `*.obj`, `*.gltf`, `*.dae`
- **Maps**: `*.tmx`, `*.json` (in game projects)
- **Video**: `*.mp4`, `*.webm`, `*.avi`
- **Fonts**: `*.ttf`, `*.otf` (in game projects)

### **Never Use LFS For** (Any Category)
- **Source Code**: `*.cs`, `*.gd`, `*.cpp`, `*.h`
- **Configuration**: `*.toml`, `*.json`, `*.yaml`, `*.xml`
- **Documentation**: `*.md`, `*.txt`, `*.rst`
- **Build Artifacts**: `*.dll`, `*.exe`, `*.so`
- **Packages**: `*.zip`, `*.tar.gz` (use external assets)

## Repository Structure Examples

### **Game Project** (LFS Allowed)
```
projects/Thistletide/
├── .gitattributes     # LFS patterns for art assets
├── .gitignore         # Ignore build artifacts
├── src/               # Source code (no LFS)
├── assets/            # Game assets (LFS tracked)
│   ├── sprites/
│   ├── audio/
│   └── models/
└── docs/              # Documentation (no LFS)
```

### **Development Toolkit** (No LFS)
```
toolkits/cs/CodeAnalysis/
├── .gitignore         # Ignore build artifacts
├── src/               # Source code only
├── assets/            # External assets (gitignored)
│   └── samples/       # Test data, not LFS tracked
└── docs/              # Documentation (no LFS)
```

### **Plugin** (No LFS)
```
plugins/GridBuilding/
├── .gitignore         # Ignore build artifacts
├── Core/              # Engine-agnostic code
├── Godot/             # Godot-specific code
├── assets/            # External assets (gitignored)
└── docs/              # Documentation (no LFS)
```

## Git Repository Validator Updates

The `GitRepositoryValidator` tool now supports this selective policy:

```bash
# Validate toolkit (should fail if LFS found)
dotnet run --project GitRepositoryValidator -- --path toolkits/cs/CodeAnalysis --check-lfs

# Validate game project (should pass with LFS)
dotnet run --project GitRepositoryValidator -- --path projects/Thistletide --check-lfs --allow-lfs

# Validate entire workspace with context awareness
dotnet run --project GitRepositoryValidator -- --path . --context-aware
```

## Migration Strategy

### Phase 1: Current State Assessment
```bash
# Scan workspace for LFS usage
find . -name ".gitattributes" -exec grep -l "filter=lfs" {} \;

# Identify which repositories need LFS vs external assets
for dir in projects/* demos/* plugins/* toolkits/*; do
    echo "=== $dir ==="
    dotnet run --project GitRepositoryValidator -- --path "$dir" --check-lfs --quiet
done
```

### Phase 2: Apply Selective Policy
```bash
# Remove LFS from toolkits and plugins
for dir in plugins/* toolkits/*; do
    cd "$dir"
    git lfs uninstall
    rm -f .gitattributes
    cd - > /dev/null
done

# Ensure LFS is properly configured for game projects
for dir in projects/* demos/*; do
    cd "$dir"
    if [ ! -f .gitattributes ]; then
        git lfs install
        git lfs track "*.png *.gif *.wav *.mp3 *.fbx *.tmx"
    fi
    cd - > /dev/null
done
```

### Phase 3: Validation
```bash
# Validate the selective policy implementation
dotnet run --project GitRepositoryValidator -- --path . --context-aware --detailed
```

## CI/CD Integration

### **Game Projects** (Allow LFS)
```yaml
# GitHub Actions for game projects
- name: Checkout with LFS
  uses: actions/checkout@v3
  with:
    lfs: true
    
- name: Validate LFS usage
  run: |
    dotnet run --project GitRepositoryValidator -- \
      --path . \
      --check-lfs \
      --allow-lfs \
      --quiet
```

### **Development Tools** (No LFS)
```yaml
# GitHub Actions for toolkits
- name: Checkout
  uses: actions/checkout@v3
  
- name: Validate no LFS
  run: |
    dotnet run --project GitRepositoryValidator -- \
      --path . \
      --check-lfs \
      --quiet
```

## Benefits of Selective Policy

### **Game Development**
- ✅ **Art Version Control**: Artists can track their work
- ✅ **Team Collaboration**: Designers and developers work together
- ✅ **Build Integration**: Game engines get versioned assets
- ✅ **Release Management**: Releases include correct asset versions

### **Development Tools**
- ✅ **Fast Clones**: No LFS overhead for tool development
- ✅ **Simple CI/CD**: No LFS setup for build pipelines
- ✅ **Easy Onboarding**: New developers start coding immediately
- ✅ **Clean History**: No LFS pointer pollution in tool repositories

## Enforcement

### **Automated Validation**
```bash
# Pre-commit hook
#!/bin/sh
REPO_PATH=$(git rev-parse --show-toplevel)

# Check if this is a toolkit/plugin (no LFS allowed)
if [[ "$REPO_PATH" == *"toolkits"* || "$REPO_PATH" == *"plugins"* ]]; then
    dotnet run --project GitRepositoryValidator -- \
      --path "$REPO_PATH" \
      --check-lfs \
      --quiet
    if [ $? -ne 0 ]; then
        echo "❌ LFS not allowed in toolkits/plugins"
        exit 1
    fi
fi

# For game projects, LFS is allowed but should be properly configured
if [[ "$REPO_PATH" == *"projects"* || "$REPO_PATH" == *"demos"* ]]; then
    dotnet run --project GitRepositoryValidator -- \
      --path "$REPO_PATH" \
      --check-lfs \
      --allow-lfs \
      --quiet
fi
```

### **Repository Health Monitoring**
```bash
# Weekly workspace validation
dotnet run --project GitRepositoryValidator -- \
  --path . \
  --context-aware \
  --detailed \
  --report workspace-health.json
```

## Troubleshooting

### **Common Issues**

**LFS detected in toolkit:**
```bash
# Remove LFS from toolkit
cd toolkits/SomeToolkit
git lfs uninstall
git rm --cached .gitattributes
git add .gitignore
git commit -m "Remove LFS from toolkit"
```

**Missing LFS in game project:**
```bash
# Add LFS to game project
cd projects/SomeGame
git lfs install
git lfs track "*.png *.gif *.wav *.mp3"
git add .gitattributes
git commit -m "Add LFS for game assets"
```

**Mixed repository types:**
```bash
# Use context-aware validation
dotnet run --project GitRepositoryValidator -- \
  --path . \
  --context-aware \
  --fix
```

---

**Selective Git LFS Policy**: Right tool for the right job - LFS for game assets, simplicity for development tools. 🎮🛠️
