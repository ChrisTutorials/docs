# Plugin Export Plan - Generic Infrastructure

## Overview

This document outlines the strategy for exporting production-ready plugins (DLLs + Godot resources) from `/plugins/` to target projects with 100% success rate.

---

## Plugin Inventory

### Core Plugins (Must Export)

| Plugin | Source | Target | Status |
|--------|--------|--------|--------|
| **ExamplePlugin** | `/plugins/ExamplePlugin/` | `/addons/example_plugin/` | ⚠️ Active |
| **AnotherPlugin** | `/plugins/AnotherPlugin/` | `/addons/another_plugin/` | ⚠️ Active |
| **UtilityPlugin** | `/plugins/UtilityPlugin/` | `/addons/utility_plugin/` | ⚠️ Active |
| **FrameworkPlugin** | `/plugins/FrameworkPlugin/` | `/addons/framework_plugin/` | 🆕 New |
| **StatePlugin** | `/plugins/StatePlugin/` | `/addons/state_plugin/` | 🆕 New |
| **InventoryPlugin** | `/plugins/InventoryPlugin/` | `/addons/inventory_plugin/` | ⚠️ Active |

### Export Artifacts Per Plugin

```
[Plugin]/
├── bin/Release/net8.0/
│   ├── [Plugin].dll           # Main assembly
│   ├── [Plugin].pdb           # Debug symbols (optional)
│   └── [Plugin].deps.json     # Dependencies
├── Godot/
│   ├── *.cs                   # Godot-specific wrappers
│   ├── *.tscn                 # Scene files
│   └── *.tres                 # Resource files
└── plugin.cfg                 # Godot plugin manifest
```

---

## Export Requirements

### 1. Build Requirements
- [ ] All plugins compile without errors
- [ ] All tests pass (100% success rate)
- [ ] No compiler warnings (treat warnings as errors)
- [ ] Release configuration builds

### 2. Dependency Requirements
- [ ] All NuGet packages resolved
- [ ] No circular dependencies between plugins
- [ ] Chickensoft.LogicBlocks compatible versions
- [ ] Godot.NET.Sdk compatible versions

### 3. Godot Integration Requirements
- [ ] Valid `plugin.cfg` for each plugin
- [ ] Correct namespace mappings
- [ ] Resource paths use `res://` format
- [ ] Scene files reference correct scripts

---

## Export Pipeline

### Phase 1: Validation (Pre-Export)

```bash
# 1. Clean all build artifacts
dotnet clean --configuration Release

# 2. Restore all dependencies
dotnet restore

# 3. Build all plugins
dotnet build --configuration Release --no-restore

# 4. Run all tests
dotnet test --configuration Release --no-build

# 5. Validate plugin structure
./scripts/validate-plugins.sh
```

### Phase 2: Build (Export)

```bash
# Build each plugin for release
for plugin in GridBuilding ItemDrops WorldTime AgentFramework StateForge; do
    dotnet build "plugins/$plugin/$plugin.csproj" \
        --configuration Release \
        --output "plugins/exports/$plugin/"
done
```

### Phase 3: Deploy (Copy to Target Project)

```bash
# Copy DLLs and Godot resources to target project
for plugin in example_plugin another_plugin utility_plugin framework_plugin state_plugin; do
    rsync -av --delete \
        "plugins/exports/$plugin/" \
        "projects/TargetProject/godot/addons/$plugin/"
done
```

### Phase 4: Verification (Post-Export)

```bash
# 1. Verify DLLs exist
ls -la projects/TargetProject/godot/addons/*/bin/*.dll

# 2. Verify plugin.cfg files
find projects/TargetProject/godot/addons -name "plugin.cfg" -exec cat {} \;

# 3. Run target project build
cd projects/TargetProject/godot && dotnet build

# 4. Run target project tests
cd projects/TargetProject/godot && dotnet test
```

---

## Automated Export Tool

### Tool Requirements

Create `/toolkits/cs/PluginExporter/` with:

1. **PluginExporter.csproj** - Main tool project
2. **ExportCommand.cs** - CLI export command
3. **ValidationCommand.cs** - Pre-export validation
4. **DeployCommand.cs** - Copy to target project

### CLI Interface

```bash
# Validate all plugins
dotnet run --project toolkits/cs/PluginExporter -- validate

# Export single plugin
dotnet run --project toolkits/cs/PluginExporter -- export GridBuilding

# Export all plugins
dotnet run --project toolkits/cs/PluginExporter -- export --all

# Deploy to target project
dotnet run --project toolkits/cs/PluginExporter -- deploy --target TargetProject

# Full pipeline (validate + export + deploy)
dotnet run --project toolkits/cs/PluginExporter -- release --target TargetProject
```

### Export Configuration

```json
// plugins/export-config.json
{
  "plugins": [
    {
      "name": "ExamplePlugin",
      "source": "plugins/ExamplePlugin",
      "target": "addons/example_plugin",
      "includeGodot": true,
      "dependencies": []
    },
    {
      "name": "AnotherPlugin",
      "source": "plugins/AnotherPlugin",
      "target": "addons/another_plugin",
      "includeGodot": true,
      "dependencies": []
    },
    {
      "name": "UtilityPlugin",
      "source": "plugins/UtilityPlugin",
      "target": "addons/utility_plugin",
      "includeGodot": true,
      "dependencies": []
    },
    {
      "name": "FrameworkPlugin",
      "source": "plugins/FrameworkPlugin",
      "target": "addons/framework_plugin",
      "includeGodot": false,
      "dependencies": []
    },
    {
      "name": "StatePlugin",
      "source": "plugins/StatePlugin",
      "target": "addons/state_plugin",
      "includeGodot": false,
      "dependencies": ["LogicBlocks"]
    }
  ],
  "targets": {
    "TargetProject": "projects/TargetProject/godot"
  }
}
```

---

## Success Criteria

### 100% Export Success Rate

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Build Success** | 100% | All plugins compile |
| **Test Pass Rate** | 100% | All tests pass |
| **DLL Integrity** | 100% | All DLLs load correctly |
| **Godot Integration** | 100% | All plugins enable in editor |
| **Runtime Stability** | 100% | No crashes on game start |

### Validation Checks

```csharp
public class ExportValidation
{
    // Pre-export checks
    public bool ValidateSourceExists(string pluginPath);
    public bool ValidateProjectFile(string csprojPath);
    public bool ValidateDependencies(string csprojPath);
    public bool ValidateNoCompilerErrors(string csprojPath);
    public bool ValidateTestsPass(string testProjectPath);
    
    // Post-export checks
    public bool ValidateDllExists(string outputPath);
    public bool ValidateDllLoads(string dllPath);
    public bool ValidatePluginCfg(string pluginPath);
    public bool ValidateGodotResources(string addonPath);
    
    // Integration checks
    public bool ValidateGodotBuild(string projectPath);
    public bool ValidateGodotTests(string projectPath);
    public bool ValidatePluginEnables(string projectPath, string pluginName);
}
```

---

## Error Handling

### Common Export Failures

| Error | Cause | Solution |
|-------|-------|----------|
| **Build Failed** | Compilation errors | Fix code errors first |
| **Tests Failed** | Test failures | Fix failing tests |
| **Missing DLL** | Build output wrong | Check output path |
| **Plugin Won't Enable** | Invalid plugin.cfg | Validate manifest |
| **Missing Resources** | Files not copied | Check rsync patterns |
| **Namespace Errors** | Wrong namespace | Update namespace mappings |

### Rollback Strategy

```bash
# Keep backup of previous export
cp -r projects/TargetProject/godot/addons projects/TargetProject/godot/addons.backup

# Restore on failure
if [ $EXPORT_FAILED ]; then
    rm -rf projects/TargetProject/godot/addons
    mv projects/TargetProject/godot/addons.backup projects/TargetProject/godot/addons
fi
```

---

## Implementation Roadmap

### Phase 1: Foundation (Day 1)
- [ ] Create PluginExporter tool skeleton
- [ ] Implement validation commands
- [ ] Create export-config.json

### Phase 2: Export Logic (Day 2)
- [ ] Implement build command
- [ ] Implement export command
- [ ] Implement deploy command

### Phase 3: Integration (Day 3)
- [ ] Add Godot resource handling
- [ ] Add plugin.cfg generation
- [ ] Add post-export verification

### Phase 4: Automation (Day 4)
- [ ] Create CI/CD pipeline
- [ ] Add GitHub Actions workflow
- [ ] Document usage

---

## Quick Reference

### Export Single Plugin
```bash
cd /home/chris/game_dev
dotnet build plugins/ExamplePlugin/ExamplePlugin.csproj -c Release
cp -r plugins/ExamplePlugin/bin/Release/net8.0/* projects/TargetProject/godot/addons/example_plugin/bin/
```

### Export All Plugins
```bash
./scripts/export-all-plugins.sh
```

### Verify Export
```bash
cd projects/TargetProject/godot && dotnet build && dotnet test
```

---

## Next Steps

1. **Create PluginExporter tool** in `/toolkits/cs/PluginExporter/`
2. **Create export-config.json** with all plugin definitions
3. **Create validation scripts** for pre/post export checks
4. **Test export pipeline** with one plugin first
5. **Automate with CI/CD** for consistent releases

---

*Document created: December 2024*
*Last updated: December 2024*
*Owner: BarkMoon Studio*
