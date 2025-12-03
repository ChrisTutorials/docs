# Sync-Upstream Guide

## Overview
The `sync-upstream.sh` script updates local directories with the latest changes from their upstream GitHub repositories. This maintains the flat structure while keeping components synchronized with their sources.

## Quick Start

### Sync All Repositories
```bash
./scripts/sync-upstream.sh
```

### Sync Specific Repository
```bash
./scripts/sync-upstream.sh gridbuilding
./scripts/sync-upstream.sh assetloader
./scripts/sync-upstream.sh grid_building_dev
```

### Preview Changes (Dry Run)
```bash
./scripts/sync-upstream.sh --dry-run all
```

## Configuration

### Sync Configuration File
Location: `.sync-config` (auto-created on first run)

```bash
# Format: REMOTE_NAME|LOCAL_PATH|UPSTREAM_URL|BRANCH

# Plugins
gridbuilding|plugins/domains/gameplay/GridBuilding|https://github.com/ChrisTutorials/grid_building.git|main
assetloader|plugins/domains/gameplay/AssetLoader|https://github.com/ChrisTutorials/AssetLoader.git|main

# Demos  
grid_building_dev|demos/grid_building_dev|https://github.com/ChrisTutorials/grid_building_dev.git|main
world_time_dev|demos/world_time_dev|https://github.com/ChrisTutorials/world_time_dev.git|main
```

### Adding New Repositories
1. Edit `.sync-config`
2. Add new line: `repo_name|local/path|https://github.com/user/repo.git|main`
3. Run sync script

## Command Options

| Option | Description |
|--------|-------------|
| `-h, --help` | Show help message |
| `-d, --dry-run` | Preview changes without executing |
| `-v, --verbose` | Show detailed output |
| `-f, --force` | Force sync despite local changes |
| `-c, --config FILE` | Use custom config file |

## Usage Examples

### Basic Usage
```bash
# Sync everything
./scripts/sync-upstream.sh

# Sync specific repos
./scripts/sync-upstream.sh gridbuilding assetloader

# Verbose output
./scripts/sync-upstream.sh --verbose gridbuilding
```

### Safe Operations
```bash
# Check what would change
./scripts/sync-upstream.sh --dry-run all

# Force sync (overwrites local changes)
./scripts/sync-upstream.sh --force gridbuilding
```

### Advanced Usage
```bash
# Custom config file
./scripts/sync-upstream.sh --config /path/to/custom-config all

# Verbose dry run
./scripts/sync-upstream.sh --dry-run --verbose all
```

## Safety Features

### Local Change Detection
The script detects and protects against overwriting local changes:
- Uncommitted modifications
- Staged changes  
- Untracked files

**Error**: `Local changes detected in path. Use --force to override or commit changes first.`

### Dry Run Mode
Preview what would happen without making changes:
```bash
./scripts/sync-upstream.sh --dry-run all
```

### Force Override
When necessary, force sync despite local changes:
```bash
./scripts/sync-upstream.sh --force gridbuilding
```

## Workflow Integration

### Daily Development
```bash
# Start of day - sync all repos
./scripts/sync-upstream.sh

# Work on code...

# End of day - check for updates
./scripts/sync-upstream.sh --dry-run all
```

### Before Major Changes
```bash
# Ensure up-to-date before big changes
./scripts/sync-upstream.sh --verbose all

# Make your changes...
```

### CI/CD Integration
```bash
# In CI pipeline
./scripts/sync-upstream.sh --dry-run all
if [ $? -eq 0 ]; then
    echo "All repos up to date"
else
    echo "Updates available, consider syncing"
fi
```

## Troubleshooting

### Common Issues

#### "Local changes detected"
```bash
# Solution 1: Commit changes first
git add .
git commit -m "Save local changes"

# Solution 2: Stash changes
git stash
./scripts/sync-upstream.sh gridbuilding
git stash pop

# Solution 3: Force sync (caution: overwrites changes)
./scripts/sync-upstream.sh --force gridbuilding
```

#### "Repository not found in configuration"
```bash
# Check available repos
grep -v '^#' .sync-config | cut -d'|' -f1

# Add missing repo to .sync-config
echo "new_repo|path/to/repo|https://github.com/user/repo.git|main" >> .sync-config
```

#### "Local directory does not exist"
```bash
# Create directory first
mkdir -p path/to/repo
cd path/to/repo
git clone https://github.com/user/repo.git .
cd ../../..
./scripts/sync-upstream.sh new_repo
```

### Debug Mode
Use verbose output for detailed information:
```bash
./scripts/sync-upstream.sh --verbose --dry-run all
```

## Best Practices

### 1. Regular Syncing
- Sync daily to stay current
- Use dry run before major changes
- Check sync status before releases

### 2. Change Management
- Commit local changes before syncing
- Use branches for experimental work
- Review upstream changes before merging

### 3. Configuration Management
- Keep `.sync-config` under version control
- Document any custom configurations
- Test new repos before adding to main config

### 4. Team Collaboration
- Communicate upstream changes to team
- Coordinate sync timing to avoid conflicts
- Use consistent branch names across repos

## Advanced Configuration

### Custom Branch Mapping
```bash
# Different branches per repo
feature_branch|plugins/Feature|https://github.com/user/feature.git|develop
main_branch|plugins/Main|https://github.com/user/main.git|main
```

### Multiple Config Files
```bash
# Development config
./scripts/sync-upstream.sh --config .sync-dev.sh

# Production config  
./scripts/sync-upstream.sh --config .sync-prod.sh
```

### Selective Syncing
```bash
# Only sync plugins
grep "plugins/" .sync-config | cut -d'|' -f1 | xargs ./scripts/sync-upstream.sh

# Only sync demos
grep "demos/" .sync-config | cut -d'|' -f1 | xargs ./scripts/sync-upstream.sh
```

## Migration from Subtrees/Submodules

### From Subtrees
```bash
# Remove subtree (if exists)
git subtree remove --prefix=plugins/GridBuilding gridbuilding main

# Add to sync config
echo "gridbuilding|plugins/domains/gameplay/GridBuilding|https://github.com/ChrisTutorials/grid_building.git|main" >> .sync-config

# Sync using new script
./scripts/sync-upstream.sh gridbuilding
```

### From Submodules
```bash
# Remove submodule
git submodule deinit -f plugins/GridBuilding
git rm -f plugins/GridBuilding
rm -rf .git/modules/plugins/GridBuilding

# Clone as regular directory
git clone https://github.com/ChrisTutorials/grid_building.git plugins/domains/gameplay/GridBuilding

# Add to sync config
echo "gridbuilding|plugins/domains/gameplay/GridBuilding|https://github.com/ChrisTutorials/grid_building.git|main" >> .sync-config
```

## Performance

### Sync Speed
- **Single repo**: 2-5 seconds
- **All repos**: 10-30 seconds
- **Dry run**: 1-3 seconds

### Optimization Tips
- Use `--dry-run` for quick checks
- Sync only needed repositories
- Use verbose mode only when debugging

---

## Support

For issues or questions:
1. Check this guide first
2. Use `--verbose --dry-run` for debugging
3. Review the script's help: `./scripts/sync-upstream.sh --help`

*This script maintains the benefits of a flat structure while providing easy synchronization with upstream repositories.*
