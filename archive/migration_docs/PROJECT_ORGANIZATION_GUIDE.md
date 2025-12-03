# Game Dev Project Directory Organization

> **📋 Architecture Guide:** This document defines the organizational structure and routing rules for the entire game development project directory.

---

## 🎯 Overview

Our game development project uses a **separation of concerns** approach where different types of code and tools live in their proper places. This prevents runtime bloat and maintains clean architecture.

---

## 📁 Directory Structure & Responsibilities

### **🎮 `/projects/` - Runtime Game Projects**
**Purpose**: Actual game code that gets exported to players
**Contents**: Game-specific implementations, scenes, assets
**Examples**: `Thistletide/`, `DemoGame/`

**Rules:**
- ✅ Game-specific code
- ✅ Scene files (.tscn, .cs)
- ✅ Game assets
- ❌ Development tools
- ❌ Analysis utilities

---

### **🔧 `/toolkits/` - Development Tools & Kits**
**Purpose**: Development-time tools, analyzers, utilities
**Contents**: Code analysis, build tools, migration utilities
**Examples**: `cs/`, `rust/`, `migration/`

**Rules:**
- ✅ Code analysis tools (SonarAnalyzer, custom analyzers)
- ✅ Build utilities
- ✅ Migration tools
- ✅ Development kits
- ❌ Runtime game code
- ❌ Player-facing assets

---

### **🔌 `/plugins/` - Reusable Runtime Components**
**Purpose**: Shareable game components that can be used across multiple projects
**Contents**: GridBuilding, ItemDrops, inventory systems
**Examples**: `GridBuilding/`, `ItemDrops/`, `GridBuildingInventory/`

**Rules:**
- ✅ Reusable game systems
- ✅ Runtime components
- ✅ Plugin interfaces
- ❌ Development tools
- ❌ Project-specific code

---

### **🛠️ `/scripts/` - Project Management Scripts**
**Purpose**: Build scripts, maintenance, project automation
**Contents**: Shell scripts, automation, CI/CD
**Examples**: `hooks/`, `maintenance/`, `project/`

**Rules:**
- ✅ Build automation
- ✅ Maintenance scripts
- ✅ Git hooks
- ❌ Runtime code
- ❌ Development tools

---

### **📚 `/docs/` - Documentation**
**Purpose**: Project documentation, guides, architecture docs
**Contents**: Markdown files, diagrams, guides
**Examples**: Migration guides, architecture docs

**Rules:**
- ✅ Documentation
- ✅ Architecture guides
- ✅ User guides
- ❌ Code files
- ❌ Tools

---

## 🔄 Code Flow & Dependencies

### **Development Workflow**
```
1. Developer writes code in /projects/ or /plugins/
2. /toolkits/ analyze code quality and architecture
3. /scripts/ handle build and deployment
4. /docs/ document the architecture
```

### **Dependency Direction**
```
Runtime Code (/projects/) → Plugins (/plugins/) → Tools (/toolkits/) → Scripts (/scripts/)
```

**Key Principle**: **Never import development tools into runtime code**

---

## 🎯 Specific Tool Placements

### **Code Analysis Tools**
**Location**: `/toolkits/cs/CodeAnalysis/`
**Contents**:
- SonarAnalyzer configurations
- Custom Roslyn analyzers
- Metrics collection tools
- Architecture validation rules

**Why Here**: Development-time only, shouldn't be in runtime builds

---

### **Migration Tools**
**Location**: `/toolkits/cs/Migration/`
**Contents**:
- GDScript to C# migration utilities
- Code transformation tools
- Validation scripts

**Why Here**: One-time development tools, not runtime dependencies

---

### **Build Utilities**
**Location**: `/toolkits/cs/Build/`
**Contents**:
- Custom MSBuild tasks
- Project templates
- Build automation

**Why Here**: Build-time infrastructure, not runtime code

---

## 🚫 What NOT To Put Where

### **❌ Wrong: Tools in Plugins**
```
/plugins/GridBuilding/
├── Directory.Build.props          # ❌ Development tool
├── code-analysis.ruleset         # ❌ Development tool
└── MetricsCollector.cs          # ❌ Development tool
```

### **✅ Correct: Tools in Toolkit**
```
/toolkits/cs/CodeAnalysis/
├── Directory.Build.props          # ✅ Development tool
├── code-analysis.ruleset         # ✅ Development tool
└── MetricsCollector.cs          # ✅ Development tool
```

---

### **❌ Wrong: Runtime Code in Toolkit**
```
/toolkits/cs/
└── BuildingSystem.cs             # ❌ Runtime game code
```

### **✅ Correct: Runtime Code in Plugin**
```
/plugins/GridBuilding/
└── BuildingSystem.cs             # ✅ Runtime game code
```

---

## 📋 Decision Matrix

| Code Type | Location | Reason |
|-----------|----------|--------|
| **Game Logic** | `/projects/` | Game-specific runtime code |
| **Reusable Systems** | `/plugins/` | Shared runtime components |
| **Code Analysis** | `/toolkits/` | Development-time tools |
| **Build Scripts** | `/scripts/` | Project automation |
| **Documentation** | `/docs/` | Information and guides |

---

## 🔗 Cross-Directory Communication

### **Plugins → Toolkit**
```csharp
// Plugin can reference toolkit for build-time analysis
// But toolkit should never be in runtime build
#if DEBUG
using Toolkit.CodeAnalysis; // Debug-only development tools
#endif
```

### **Projects → Plugins**
```csharp
// Projects use plugins at runtime
using GridBuilding.Core; // Runtime dependency
```

### **Toolkit → Scripts**
```bash
# Scripts can use toolkit tools
dotnet run --project /toolkits/cs/CodeAnalysis/ --project /projects/Thistletide/
```

---

## 🎯 Benefits of This Organization

### **Clean Runtime Builds**
- No development tools in player builds
- Smaller deployment packages
- Faster load times

### **Clear Development Workflow**
- Tools where developers expect them
- Runtime code properly isolated
- Easy to find what you need

### **Maintainable Architecture**
- Clear separation of concerns
- No circular dependencies
- Scalable organization

---

## 📁 Quick Reference

```
/game_dev/
├── projects/          # 🎮 Runtime games
├── plugins/           # 🔌 Reusable components  
├── toolkits/          # 🔧 Development tools
├── scripts/           # 🛠️ Project automation
├── docs/              # 📚 Documentation
└── assets/            # 🎨 Shared assets
```

---

## 🚀 Getting Started

### **For New Development Tools**
1. Create in `/toolkits/cs/[Category]/`
2. Add to appropriate toolkit project
3. Document in `/docs/`

### **For New Runtime Components**
1. Create in `/plugins/[PluginName]/`
2. Follow plugin architecture
3. Reference from projects as needed

### **For New Games**
1. Create in `/projects/[GameName]/`
2. Reference required plugins
3. Use toolkit tools for analysis

---

## 🎯 Conclusion

This organization ensures that:
- **Players get clean, fast game builds**
- **Developers have powerful tools**
- **Code stays maintainable and organized**
- **Architecture remains clean and scalable**

Remember: **Tools in toolkits, runtime in plugins, games in projects!**
