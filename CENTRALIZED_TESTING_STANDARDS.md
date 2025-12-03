# Centralized Testing Standards

## Overview

This document centralizes all testing standards and best practices across the game development workspace. It replaces and consolidates previous scattered testing documentation.

## 🚫 Anti-Patterns Prohibited

### Test Exclusion Anti-Pattern
**NEVER** use `<Compile Remove="Tests/**" />` in Core projects to achieve compilation.

**Why This Is Problematic:**
1. **Test Coverage Loss**: Tests are excluded from compilation, meaning they can't run
2. **False Success**: Build passes but code quality is unknown  
3. **Production Risk**: Unvalidated code deployed to production
4. **CI/CD Breaks**: Automated test pipelines can't function
5. **Technical Debt**: Hides underlying architectural and dependency issues

**Correct Approach:**
- Move tests to separate test projects at plugin level
- Fix underlying compilation issues in test projects
- Ensure proper test project references and dependencies
- Maintain test infrastructure alongside production code

---

## 🏗️ Project Structure Standards

### Multi-Engine Plugin Structure
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
│   ├── Tests/              # Godot-specific tests (GoDotTest)
│   └── Resources/          # Godot resources
├── Unity/                  # Unity-specific implementations (if applicable)
│   ├── Scripts/            # Unity MonoBehaviours
│   ├── Resources/          # Unity assets
│   ├── Tests/              # Unity-specific tests
│   └── Editor/             # Unity editor tools
├── Tests/                  # Cross-engine tests (Xunit)
│   ├── Unit/               # Unit tests
│   ├── Integration/        # Integration tests
│   └── Performance/        # Performance tests
├── docs/                   # Documentation
└── PluginName.csproj       # Solution file
```

### Core Project Configuration
```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <AssemblyName>PluginName.Core</AssemblyName>
    <RootNamespace>PluginName.Core</RootNamespace>
    <Nullable>enable</Nullable>
  </PropertyGroup>
  
  <!-- Exclude engine-specific files ONLY -->
  <ItemGroup>
    <Compile Remove="Godot/**" />
    <Compile Remove="Unity/**" />
  </ItemGroup>
  
  <!-- Tests should be in separate test projects, NEVER excluded -->
</Project>
```

---

## 🧪 Testing Framework Standards

### Xunit Tests (Cross-Engine)
**Use for:**
- Pure C# unit tests
- Business logic validation
- Data structure tests
- Algorithm tests
- Cross-engine compatibility tests

**Location:** `Tests/` directory at plugin level

**Project Template:**
```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <IsPackable>false</IsPackable>
    <IsTestProject>true</IsTestProject>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.NET.Test.Sdk" Version="17.8.0" />
    <PackageReference Include="xunit" Version="2.6.1" />
    <PackageReference Include="xunit.runner.visualstudio" Version="2.5.3" />
    <PackageReference Include="Moq" Version="4.20.69" />
    <PackageReference Include="Shouldly" Version="4.2.1" />
  </ItemGroup>

  <ItemGroup>
    <ProjectReference Include="..\Core\PluginName.Core.csproj" />
  </ItemGroup>
</Project>
```

### GoDotTest Tests (Godot-Specific)
**Use for:**
- Godot scene tree access (`AddChild`, `QueueFree`)
- Godot Node inheritance
- Godot-specific APIs (signals, resources, etc.)
- Scene tree lifecycle management
- Godot runtime environment

**Location:** `Godot/Tests/` directory

**Requirements:**
- Must extend `TestClass` from `Chickensoft.GoDotTest`
- Must use `[SetUp]` and `[TearDown]` attributes
- Must have access to Godot scene tree

**Example:**
```csharp
using Godot;
using Chickensoft.GoDotTest;

namespace GridBuilding.Tests.YourNamespace;

public partial class YourComponentTest : TestClass
{
    public YourComponentTest(Node testScene) : base(testScene) { }
    
    [SetUp]
    public void SetUp() { /* Setup */ }
    
    [TearDown] 
    public void TearDown() { /* Cleanup */ }
    
    [Test]
    public void YourTest() { /* Test implementation */ }
}
```

---

## ⚡ CodeMad Timeout Standards

### Test Execution Timeouts
- **Unit Tests**: 8 seconds maximum
- **Integration Tests**: 15 seconds maximum
- **Full Test Suite**: 30 seconds maximum
- **Complex Test Scenarios**: 60 seconds (rare exception)

### Safe Test Runner
Use the safe test runner for reliable execution:
```bash
# Test current project with default 30s timeout
./toolkits/cs/scripts/test-safe.sh .

# Test specific project with custom timeout
./toolkits/cs/scripts/test-safe.sh ./plugins/GridBuilding/Core 15

# Ultra-fast 8s timeout (CodeMad standard)
./toolkits/cs/scripts/test-safe.sh ./plugins/GridBuilding/Tests 8
```

---

## 📋 Test Categories and Requirements

### Unit Tests
- **Framework**: Xunit
- **Location**: `Tests/Unit/`
- **Timeout**: 8 seconds
- **Dependencies**: Mock all external dependencies
- **Isolation**: No external system calls

### Integration Tests  
- **Framework**: Xunit or GoDotTest (depending on dependencies)
- **Location**: `Tests/Integration/` or `Godot/Tests/Integration/`
- **Timeout**: 15 seconds
- **Dependencies**: Real dependencies allowed
- **Environment**: Controlled test environment

### Performance Tests
- **Framework**: Xunit with BenchmarkDotNet
- **Location**: `Tests/Performance/`
- **Timeout**: 30 seconds
- **Metrics**: Execution time, memory usage, throughput
- **Baseline**: Must establish performance baselines

### System Tests
- **Framework**: GoDotTest for Godot, Xunit for others
- **Location**: `Tests/System/` or engine-specific test directories
- **Timeout**: 60 seconds
- **Scope**: End-to-end workflows
- **Environment**: Full system environment

---

## 🔧 Best Practices

### Test Organization
1. **One test class per feature**
2. **Descriptive test names** that explain what is being tested
3. **Arrange-Act-Assert pattern** for test structure
4. **Independent tests** that don't rely on other tests
5. **Clean up resources** in tear-down methods

### Test Data Management
1. **Use builders/factories** for complex test objects
2. **Avoid magic strings** - use constants or enums
3. **Parameterized tests** for multiple scenarios
4. **Test data files** for complex input data
5. **Mock external dependencies** consistently

### CI/CD Integration
1. **All tests must pass** before merge
2. **Code coverage reporting** for main projects
3. **Performance regression detection** 
4. **Parallel test execution** where possible
5. **Timeout enforcement** in CI pipelines

---

## 📊 Success Metrics

### Quality Gates
- **100% test pass rate** required
- **>80% code coverage** for Core projects
- **<5 second average** test execution time
- **Zero test exclusions** in production code

### Performance Standards
- **Unit tests**: <100ms average
- **Integration tests**: <1 second average  
- **System tests**: <10 seconds average
- **Full test suite**: <30 seconds total

### Coverage Requirements
- **Core business logic**: 90%+ coverage
- **Utility functions**: 80%+ coverage
- **Error handling**: 85%+ coverage
- **Public APIs**: 95%+ coverage

---

## 🔄 Migration Guidelines

### From Test Exclusion to Proper Structure
1. **Remove** `<Compile Remove="Tests/**" />` from Core projects
2. **Create** separate test project at plugin level
3. **Move** test files to appropriate test directories
4. **Fix** compilation issues in test projects
5. **Add** proper package references and dependencies
6. **Verify** all tests pass without exclusions

### Test Framework Migration
1. **Identify** test dependencies (Godot vs pure C#)
2. **Separate** Xunit tests from GoDotTest tests
3. **Convert** test attributes appropriately
4. **Update** test project configurations
5. **Validate** test discovery and execution

---

## 📚 Related Documentation

- **Godot Integration Testing**: `/docs/GODOT_INTEGRATION_TESTING_STANDARDS.md`
- **Safe Test Runner**: `/docs/SAFE_TEST_RUNNER_GUIDE.md`
- **Project Structure**: `/docs/PROJECT_STRUCTURE_STANDARDS.md`
- **Technical Debt**: `/docs/TECHNICAL_DEBT_STATUS.md`

---

## 🚀 Implementation Checklist

### For New Projects
- [ ] Core project excludes only engine-specific files
- [ ] Tests in separate project at plugin level
- [ ] Proper test framework selected (Xunit vs GoDotTest)
- [ ] CodeMad timeout standards implemented
- [ ] CI/CD integration configured

### For Existing Projects  
- [ ] Remove test exclusions from Core projects
- [ ] Move tests to proper structure
- [ ] Fix compilation issues without exclusions
- [ ] Update documentation
- [ ] Validate test execution

---

**Last Updated**: December 2, 2025  
**Version**: 1.0  
**Status**: Active Standard
