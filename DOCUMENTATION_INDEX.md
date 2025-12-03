# Documentation Index - Game Development Workspace

## 📚 Core Documentation Standards

### 🏗️ Architecture & Structure
- **[PROJECT_STRUCTURE_STANDARDS.md](PROJECT_STRUCTURE_STANDARDS.md)** - Multi-engine project organization and file structure standards
- **[CENTRALIZED_TESTING_STANDARDS.md](CENTRALIZED_TESTING_STANDARDS.md)** - **NEW**: Comprehensive testing standards and anti-pattern prevention

### 🧪 Testing & Quality
- **[GODOT_INTEGRATION_TESTING_STANDARDS.md](GODOT_INTEGRATION_TESTING_STANDARDS.md)** - Godot-specific testing with GoDotTest framework
- **[SAFE_TEST_RUNNER_GUIDE.md](SAFE_TEST_RUNNER_GUIDE.md)** - CodeMad timeout standards and safe test execution

### 📝 Documentation & Process
- **[DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)** - ⭐ **START HERE** - Comprehensive documentation index
- **[DOCUMENTATION_CLEANUP_REPORT.md](DOCUMENTATION_CLEANUP_REPORT.md)** - Documentation cleanup summary and improvements made
- **[DOCUMENTATION_MAINTENANCE_GUIDE.md](DOCUMENTATION_MAINTENANCE_GUIDE.md)** - Guide for maintaining documentation
- **[GIT_COMMIT_MESSAGE_STANDARDS.md](GIT_COMMIT_MESSAGE_STANDARDS.md)** - Comprehensive Git commit message standards for traceability

### � Status & Tracking
- **[TECHNICAL_DEBT_STATUS.md](TECHNICAL_DEBT_STATUS.md)** - Active technical debt tracking and resolution status
- **[PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)** - Overall workspace structure and organization

---

## 🚫 Key Anti-Patterns Eliminated

### Test Exclusion Anti-Pattern ❌
**Problem**: Using `<Compile Remove="Tests/**" />` to achieve compilation
**Solution**: Move tests to separate test projects, fix underlying compilation issues
**Status**: ✅ **RESOLVED** - See CENTRALIZED_TESTING_STANDARDS.md

### Documentation Inconsistencies ❌
**Problem**: Scattered testing standards across multiple files
**Solution**: Centralized in CENTRALIZED_TESTING_STANDARDS.md
**Status**: ✅ **RESOLVED** - All testing standards now consolidated

---

## 📋 Quick Reference

### Project Structure (Multi-Engine)
```
PluginName/
├── Core/           # Engine-agnostic logic
├── Godot/          # Godot implementations (+ Tests/)
├── Unity/          # Unity implementations (+ Tests/)
├── Tests/          # Cross-engine Xunit tests
└── docs/           # Documentation
```

### Core Project Configuration
```xml
<!-- Exclude ONLY engine-specific files -->
<ItemGroup>
  <Compile Remove="Godot/**" />
  <Compile Remove="Unity/**" />
</ItemGroup>
<!-- NEVER exclude Tests/** -->
```

### Testing Framework Selection
- **Xunit**: Pure C# unit/integration tests
- **GoDotTest**: Godot-specific tests requiring scene tree
- **NEVER**: Mix frameworks in same project

### CodeMad Timeouts
- **Unit Tests**: 8 seconds
- **Integration Tests**: 15 seconds
- **Full Suite**: 30 seconds

---

## 📂 Additional Documentation

### Git & Repository Management
- **[GIT_CLEANUP_FINAL_SOLUTION.md](GIT_CLEANUP_FINAL_SOLUTION.md)** - Git repository cleanup strategies
- **[GIT_REPOSITORY_CLEANUP_STRATEGY.md](GIT_REPOSITORY_CLEANUP_STRATEGY.md)** - Repository cleanup approach
- **[GIT_LFS_BAN_POLICY.md](GIT_LFS_BAN_POLICY.md)** - Git LFS usage policy
- **[GIT_LFS_SELECTIVE_POLICY.md](GIT_LFS_SELECTIVE_POLICY.md)** - Selective Git LFS policy
- **[SYNC_UPSTREAM_GUIDE.md](SYNC_UPSTREAM_GUIDE.md)** - Syncing with upstream repositories
- **[PRE_COMMIT.md](PRE_COMMIT.md)** - Pre-commit hook configuration

### Architecture & Patterns
- **[ASSET_INTEGRATION_ARCHITECTURE.md](ASSET_INTEGRATION_ARCHITECTURE.md)** - Asset integration patterns
- **[GAME_DEVELOPMENT_PATTERN.md](GAME_DEVELOPMENT_PATTERN.md)** - Game development patterns and practices
- **[POCS_ARCHITECTURE_INTERNAL.md](POCS_ARCHITECTURE_INTERNAL.md)** - Plain Old C# Structs architecture
- **[PROJECT_ORGANIZATION_GUIDE.md](PROJECT_ORGANIZATION_GUIDE.md)** - Project organization guidelines

### Cost & Prioritization
- **[AI_COST_PRIORITIZATION.md](AI_COST_PRIORITIZATION.md)** - AI cost management and prioritization

### Troubleshooting
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - General troubleshooting guide

---

## 🗂️ Archived Documentation

**Historical and completed documentation** has been moved to [`archive/`](archive/README.md):
- Completed plans and strategies
- Implementation results and reports
- Hugo site implementation docs
- GDScript to C# migration docs
- Toolkit development artifacts

See [Archive README](archive/README.md) for details.

---

## 🔍 Documentation Health

### Recently Updated (December 3, 2025)
- ✅ **Documentation Cleanup** - Archived 40+ outdated documents
- ✅ **Removed Root-Level Test Results** - 9 temporary test result files removed
- ✅ **Organized Archive** - Created structured archive with clear categories
- ✅ **Updated Index** - Comprehensive documentation index with active docs
- ✅ **CENTRALIZED_TESTING_STANDARDS.md** - Created new comprehensive testing guide
- ✅ **GIT_COMMIT_MESSAGE_STANDARDS.md** - Created comprehensive commit message standards

### Standards Compliance
- ✅ **No test exclusions** in Core projects
- ✅ **Proper test separation** by framework
- ✅ **Centralized documentation** with no inconsistencies
- ✅ **CodeMad timeout standards** implemented
- ✅ **Clean documentation structure** - Active vs archived
- ✅ **No outdated root files** - Test results properly archived

---

## 🎯 Implementation Checklist

### For New Projects
- [ ] Follow PROJECT_STRUCTURE_STANDARDS.md
- [ ] Use CENTRALIZED_TESTING_STANDARDS.md for testing
- [ ] Implement CodeMad timeouts
- [ ] Exclude only engine-specific files from Core

### For Existing Projects  
- [ ] Remove any `<Compile Remove="Tests/**" />` exclusions
- [ ] Move tests to proper structure
- [ ] Update to centralized standards
- [ ] Validate all tests pass

---

## 📞 Support & Questions

**Documentation Maintainers**: DevOps Team  
**Standards Questions**: Architecture Team  
**Implementation Issues**: Plugin Teams  

---

## 🌐 Plugin-Specific Documentation

### Grid Building
- **[Grid Building Hugo Site](grid_building/)** - GridBuilding plugin documentation site
- **[Plugin Implementation Docs](../plugins/domains/gameplay/GridBuilding/docs/)** - GridBuilding architecture docs
- **[Test Suite Docs](../plugins/domains/tools/grid_building/docs/)** - GridBuilding test documentation

### Item Drops
- **[Item Drops Hugo Site](item_drops/)** - ItemDrops plugin documentation site

### World Time
- **[World Time Hugo Site](world_time/)** - WorldTime plugin documentation site

---

## 🛠️ Toolkit Documentation

### C# Toolkit
- **[README](../toolkits/cs/docs/README.md)** - C# toolkit overview
- **[Migration Guide](../toolkits/cs/docs/GDScript_To_CSharp_Migration_Guide.md)** - GDScript to C# migration
- **[Test Orchestrator](../toolkits/cs/docs/TestOrchestrator_README.md)** - Test orchestration tool
- **[Troubleshooting](../toolkits/cs/docs/Troubleshooting_Guide.md)** - C# toolkit troubleshooting

### Rust Toolkit
- **[Migration Guide](../toolkits/rust/docs/MIGRATION_GUIDE.md)** - Rust toolkit migration guide
- **[Export Tools](../toolkits/rust/docs/RUST_EXPORT_TOOLS.md)** - Rust export tools

---

**Last Updated**: December 3, 2025  
**Version**: 2.0  
**Next Review**: December 10, 2025
