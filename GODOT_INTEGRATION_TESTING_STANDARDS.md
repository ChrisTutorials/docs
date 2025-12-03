# Godot Integration Testing Standards

## Overview

All Godot integration tests that require Godot dependencies **must use the GoDotTest framework**. This ensures proper test discovery, CI/CD compatibility, and standardized test execution.

## When to Use GoDotTest

### **Required for Godot Dependencies**
Use GoDotTest when your test needs:
- Godot scene tree access (`AddChild`, `QueueFree`)
- Godot Node inheritance
- Godot-specific APIs (signals, resources, etc.)
- Scene tree lifecycle management
- Godot runtime environment

### **Test Categories**
- **Integration Tests**: Test Godot bridge functionality
- **System Tests**: Test complete Godot workflows
- **UI Tests**: Test Godot UI components
- **Scene Tests**: Test Godot scene behavior

## GoDotTest Implementation Pattern

### **Basic Structure**
```csharp
using Godot;
using Chickensoft.GoDotTest;

namespace GridBuilding.Tests.YourNamespace;

/// <summary>
/// Integration tests for YourComponent.
/// Uses GoDotTest framework for proper Godot integration testing.
/// </summary>
public partial class YourComponentTest : TestClass
{
    public YourComponentTest(Node testScene) : base(testScene) { }
    
    [SetUp]
    public void SetUp()
    {
        // Test setup logic
    }
    
    [TearDown]
    public void TearDown()
    {
        // Test cleanup logic
    }
    
    [Test]
    public void YourTestMethod()
    {
        // Test implementation
    }
}
```

### **Key Requirements**
1. **Package Reference**: Include `Chickensoft.GoDotTest` in test project
2. **TestClass Inheritance**: Replace `Node` with `TestClass`
3. **Constructor**: `public YourTest(Node testScene) : base(testScene)`
4. **Standard Attributes**: Use `[Test]`, `[SetUp]`, `[TearDown]`
5. **Score Documentation**: Include migration score in class XML docs

## Migration from Node Tests

### **Before (Incorrect)**
```csharp
public partial class YourTest : Node
{
    public override void _Ready() { }
    
    [Test]
    public void TestMethod() { }
}
```

### **After (Correct)**
```csharp
public partial class YourTest : TestClass
{
    public YourTest(Node testScene) : base(testScene) { }
    
    [Test]
    public void TestMethod() { }
}
```

## Test Scoring System

### **GoDotTest Integration Tests**
- **Characteristics**: Requires Godot scene tree, Node inheritance
- **Score**: 7/10 - Purpose-built for Godot integration testing
- **Framework**: GoDotTest for proper test discovery and execution
- **Keep as Integration Test**: Cannot be pure C# due to Godot dependencies

### **Score 8-10/10 - Pure C# Tests**
- **Characteristics**: No Godot dependencies, pure logic testing
- **Migrate to Core**: Move to `Core/Tests/Unit/`
- **Use NUnit**: Standard .NET testing framework

## Project Configuration

### **Package Reference**
```xml
<PackageReference Include="Chickensoft.GoDotTest" Version="1.4.0" />
```

### **Test Project Location**
```
GridBuilding/
├── Godot/Tests/Integration/     # GoDotTest integration tests
├── Core/Tests/Unit/            # Pure C# unit tests (NUnit)
└── Unity/Tests/Integration/     # Unity-specific tests
```

## CI/CD Integration

### **Command Line Execution**
```bash
# Run all Godot integration tests
cd plugins/GridBuilding/Godot/Tests
dotnet test --filter "TestClass"

# Run specific test class
dotnet test --filter "TestClass=YourComponentTest"

# Run with verbosity
dotnet test --filter "TestClass" --verbosity normal
```

### **Pipeline Configuration**
```yaml
- name: Run Godot Integration Tests
  run: |
    cd plugins/GridBuilding/Godot/Tests
    dotnet test --filter "TestClass" --logger trx
```

## Best Practices

### **Test Organization**
- **Namespace**: `GridBuilding.Tests.YourNamespace`
- **File Location**: Mirror source structure in `Godot/Tests/Integration/`
- **Naming**: `YourComponentTest.cs`
- **Documentation**: Include score and purpose in XML comments

### **Resource Management**
- Use `[SetUp]`/`[TearDown]` for Godot resource lifecycle
- Always `QueueFree()` Nodes in teardown
- Clean up scene tree modifications
- Use `AddChild()` for proper scene tree integration

### **Test Isolation**
- Each test should be independent
- Don't share state between tests
- Clean up resources in `[TearDown]`
- Use fresh instances for each test

## Examples

### **System Integration Test**
```csharp
/// <summary>
/// Integration tests for ManipulationSystem with Godot scene tree.
/// Score: 3/10 - Requires Godot runtime for Node lifecycle testing.
/// </summary>
public partial class ManipulationSystemTest : TestClass
{
    private ManipulationSystem? _system;
    
    public ManipulationSystemTest(Node testScene) : base(testScene) { }
    
    [SetUp]
    public void SetUp()
    {
        _system = new ManipulationSystem();
        AddChild(_system);
    }
    
    [TearDown]
    public void TearDown()
    {
        _system?.QueueFree();
    }
    
    [Test]
    public void ManipulationSystem_WithSceneTree_ShouldHandleEvents()
    {
        Assert.That(_system.IsInsideTree, Is.True);
    }
}
```

### **Component Integration Test**
```csharp
/// <summary>
/// Integration tests for IndicatorManager Godot bridge.
/// Score: 3/10 - Tests Godot-specific indicator visualization.
/// </summary>
public partial class IndicatorManagerTest : TestClass
{
    public IndicatorManagerTest(Node testScene) : base(testScene) { }
    
    [Test]
    public void IndicatorManager_CreateIndicators_ShouldAddToSceneTree()
    {
        var manager = new IndicatorManager();
        AddChild(manager);
        
        // Test indicator creation and scene tree integration
        
        manager.QueueFree();
    }
}
```

## Troubleshooting

### **Common Issues**
1. **Missing Package**: Ensure `Chickensoft.GoDotTest` is installed
2. **Constructor Error**: Verify `TestClass` constructor pattern
3. **Test Discovery**: Check `TestClass` inheritance
4. **Scene Tree Issues**: Validate `AddChild`/`QueueFree` usage

### **Solutions**
- Install GoDotTest package: `dotnet add package Chickensoft.GoDotTest`
- Use correct constructor: `public YourTest(Node testScene) : base(testScene)`
- Verify test discovery: `dotnet test --filter "TestClass"`
- Check scene tree state: `Assert.That(node.IsInsideTree, Is.True)`

## Migration Checklist

### **For New Tests**
- [ ] Determine if Godot dependencies are required
- [ ] Add GoDotTest package if needed
- [ ] Use TestClass inheritance pattern
- [ ] Include score in documentation
- [ ] Place in appropriate test directory

### **For Existing Tests**
- [ ] Identify Godot dependencies
- [ ] Add GoDotTest package
- [ ] Migrate from Node to TestClass
- [ ] Update constructor pattern
- [ ] Verify test discovery

---

**Status**: GoDotTest framework standardized for all Godot integration tests requiring Godot dependencies.
