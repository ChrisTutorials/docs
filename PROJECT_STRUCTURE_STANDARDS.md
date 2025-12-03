# Project Structure Standards - Multi-Engine Architecture

## Overview

This document defines the standard project structure for multi-engine game development projects, ensuring clear separation between engine-specific implementations and shared core logic.

## Recommended Structure

### **Multi-Engine Plugins** (Recommended)
```
PluginName/
├── Core/                    # Engine-agnostic logic
│   ├── Interfaces/         # Shared interfaces
│   ├── Types/              # Shared types/enums
│   ├── Systems/            # Core business logic
│   ├── State/              # State machines
│   └── Services/           # Core services
├── Godot/                  # Godot-specific implementations
│   ├── Systems/            # Godot system implementations
│   ├── Nodes/              # Godot node classes
│   └── Resources/          # Godot resources
├── Unity/                  # Unity-specific implementations (if applicable)
│   ├── Scripts/            # Unity MonoBehaviours
│   ├── Resources/          # Unity assets
│   └── Editor/             # Unity editor tools
├── Tests/                  # Cross-engine tests
├── docs/                   # Documentation
└── PluginName.csproj       # Solution file
```

### **Single-Engine Frameworks** (Alternative)
```
FrameworkName/
├── src/                    # Source code
│   ├── Core/               # Core logic
│   ├── Godot/              # Engine implementations
│   └── Tests/              # Tests
├── docs/                   # Documentation
└── FrameworkName.csproj    # Project file
```

## When to Use Each Structure

### **Use Multi-Engine Structure When:**
- ✅ Building reusable plugins for multiple engines
- ✅ Clear engine separation is required
- ✅ Different deployment targets per engine
- ✅ Team specialization by engine

### **Use Single-Engine Structure When:**
- ✅ Building for a single target engine
- ✅ Simpler organization needed
- ✅ Monolithic architecture preferred
- ✅ Rapid prototyping

## Implementation Examples

### **GridBuilding Plugin** (Multi-Engine - ✅ Correct)
```
GridBuilding/
├── Core/                   # Pure C# logic
├── Godot/                  # Godot implementations  
├── Unity/                  # Unity implementations
└── Tests/                  # Shared tests
```

### **AgentFramework** (Single-Engine - ✅ Correct)
```
AgentFramework/
├── src/                    # All source code
├── tests_temp/             # Tests
└── docs/                   # Documentation
```

### **ItemDrops** (Multi-Engine - ✅ Correct)
```
ItemDrops/
├── Core/                   # Engine-agnostic
├── Godot/                  # Godot-specific
└── Tests/                  # Tests
```

## Project File Standards

### **Multi-Engine Core Projects**
```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <AssemblyName>PluginName.Core</AssemblyName>
    <RootNamespace>PluginName.Core</RootNamespace>
    <Nullable>enable</Nullable>
  </PropertyGroup>
  
  <!-- Exclude engine-specific files only -->
  <ItemGroup>
    <Compile Remove="Godot/**" />
    <Compile Remove="Unity/**" />
  </ItemGroup>
  
  <!-- Tests should be in separate test projects, not excluded -->
  <!-- See: /docs/CENTRALIZED_TESTING_STANDARDS.md -->
</Project>
```

### **Engine-Specific Projects**
```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <AssemblyName>PluginName.Godot</AssemblyName>
    <RootNamespace>PluginName.Godot</RootNamespace>
    <Nullable>enable</Nullable>
  </PropertyGroup>
  
  <!-- Reference Core project -->
  <ItemGroup>
    <ProjectReference Include="Core\PluginName.Core.csproj" />
  </ItemGroup>
</Project>
```

## Migration Guidelines

### **From src/ to Multi-Engine Structure**
1. **Move source files**: `src/Core/` → `Core/`
2. **Move engine files**: `src/Godot/` → `Godot/`
3. **Update project files**: Remove `../` references
4. **Update solution files**: New project paths
5. **Test builds**: Ensure all targets compile

### **From Multi-Engine to src/ Structure**
1. **Create src/ folder**: Top-level source directory
2. **Move all code**: Core/, Godot/, Unity/ → `src/`
3. **Update project files**: Adjust paths
4. **Consolidate tests**: Move to `src/Tests/`
5. **Update documentation**: Reflect new structure

## Benefits of Multi-Engine Structure

### **1. Clear Separation**
- Engine boundaries are obvious
- No cross-contamination of code
- Easy to understand ownership

### **2. Independent Development**
- Teams can work on different engines
- Separate build pipelines
- Independent deployment

### **3. Reusability**
- Core logic shared across engines
- Engine implementations isolated
- Easy to add new engines

### **4. Testing Strategy**
- Cross-engine tests in shared location
- Engine-specific tests with engine code
- Clear test organization

## File Organization Best Practices

### **Core Folder Organization**
```
Core/
├── Interfaces/             # Abstract contracts
├── Types/                  # Data types and enums
├── Systems/                # Business logic
├── State/                  # State machines
├── Services/               # Service implementations
├── Events/                 # Event definitions
├── Extensions/             # Extension methods
└── Utilities/              # Helper classes
```

### **Engine-Specific Organization**
```
Godot/
├── Nodes/                  # Godot node implementations
├── Resources/              # Godot resource classes
├── Systems/                # Godot-specific system implementations
├── Scripts/                # Godot scripts
└── Editor/                 # Godot editor tools
```

## Naming Conventions

### **Projects**
- Core: `{PluginName}.Core.csproj`
- Godot: `{PluginName}.Godot.csproj`
- Unity: `{PluginName}.Unity.csproj`
- Tests: `{PluginName}.Tests.csproj`

### **Namespaces**
- Core: `{PluginName}.Core`
- Godot: `{PluginName}.Godot`
- Unity: `{PluginName}.Unity`

### **Assemblies**
- Match project names for clarity
- Use consistent naming across engines

## Decision Matrix

| Factor | Multi-Engine | Single-Engine |
|--------|--------------|---------------|
| Team Size | Large teams | Small teams |
| Target Platforms | Multiple engines | Single engine |
| Complexity | Higher complexity | Simpler |
| Maintenance | More effort | Less effort |
| Reusability | High | Medium |
| Learning Curve | Steeper | Gentler |

## Conclusion

The **multi-engine structure** (Core/Godot/Unity) is recommended for:
- Plugin development
- Multi-platform deployment
- Team-based development

The **single-engine structure** (src/) is recommended for:
- Single-target applications
- Rapid prototyping
- Simple projects

Choose the structure that best fits your project's requirements and team structure. Both patterns are valid when applied appropriately.

---

**Project Structure Standards**: Clear, Consistent, and Scalable! 🏗️
