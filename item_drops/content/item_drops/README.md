# ItemDrops Documentation

Welcome to the documentation for the ItemDrops plugin. This folder contains comprehensive documentation for developers using and extending the ItemDrops system.

## 📚 Documentation Structure

### **Getting Started** ⭐ **New Users Start Here**
- **[Quick Start Guide](./getting-started/quick-start.md)** - 5-minute setup and first drops
- **[Installation & Setup](./getting-started/installation.md)** - Detailed installation instructions
- **[Basic Concepts](./getting-started/basic-concepts.md)** - Core concepts and terminology

### **Configuration Guides** 🔧 **Essential Reading**
- **[Data-Driven Drop Tables](./configuration/data-driven.md)** ⭐ **Recommended Approach**
- **[Resource-Based Configuration](./configuration/resource-based.md)** ⚠️ Legacy Support
- **[Migration Guide](./configuration/migration.md)** - Converting from Resources to Data-Driven
- **[Configuration Schema](./reference/schema.md)** - Complete JSON/YAML reference

### **Integration Guides**
- **[Godot Integration](./godot-integration.md)** - Godot-specific implementation guide
- **[Unity Integration](./unity-integration.md)** - Unity-specific implementation guide

### **Advanced Topics** 🚀 **For Power Users**
- **[Conditions & Modifiers](./advanced/conditions.md)** - Advanced drop logic
- **[Custom Drop Logic](./advanced/custom-logic.md)** - Extending the system
- **[Performance Optimization](./advanced/performance.md)** - Best practices and benchmarks
- **[Testing & Validation](./advanced/testing.md)** - Comprehensive testing strategies

### **API Reference**
- **[Core API](./reference/core-api.md)** - Pure C# library reference
- **[Godot API](./reference/godot-api.md)** - Godot integration API
- **[Unity API](./reference/unity-api.md)** - Unity integration API

### **Architecture & Design**
- **[Architecture Overview](./architecture.md)** - POCS design and decisions
- **[Testing Guide](./testing-guide.md)** - Testing strategies and guidelines
- **[Performance Guide](./performance-guide.md)** - Performance optimization

### **Examples & Tutorials**
- **[Examples](./examples/)** - Working code examples
- **[Tutorials](./tutorials/)** - Step-by-step tutorials
- **[Benchmarks](./benchmarks/)** - Performance data and analysis

### **Maintenance**
- **[Improvements](./improvements.md)** - Planned enhancements and roadmap
- **[Troubleshooting](./reference/troubleshooting.md)** - Common issues and solutions

---

## 🎯 Quick Recommendations

### **For New Projects**
👉 **Use Data-Driven Configuration** with JSON/YAML files
- ✅ Superior editor experience with custom plugin
- ✅ Better maintainability and version control
- ✅ Runtime performance benefits
- ✅ Centralized configuration management

**Start here:** [Data-Driven Drop Tables](./configuration/data-driven.md)

### **For Existing Projects**
👉 **Use HybridDropTable** for gradual migration
- ✅ Backward compatibility with existing Resources
- ✅ Conversion tools for smooth transition
- ✅ No breaking changes

**Start here:** [Migration Guide](./configuration/migration.md)

---

## 🔥 Why Data-Driven is Superior

| Aspect | Resource Arrays | Data-Driven |
|--------|-----------------|-------------|
| **Editor Experience** | ❌ Click-heavy, scattered files | ✅ Single view, searchable |
| **Validation** | ❌ Runtime only | ✅ Compile-time + runtime |
| **Performance** | ❌ Multiple resource loads | ✅ Single parse, cached |
| **Maintainability** | ❌ File fragmentation | ✅ Centralized configuration |
| **Version Control** | ❌ Noisy diffs | ✅ Clean, meaningful changes |
| **Backup/Export** | ❌ Complex file collection | ✅ Single file export |

---

## 🚀 Quick Start (5 Minutes)

### 1. Create a Drop Table
```json
{
  "minDrops": 1,
  "maxDrops": 3,
  "dropChance": 0.8,
  "drops": [
    {
      "itemId": "health_potion",
      "weight": 50,
      "minQuantity": 1,
      "maxQuantity": 2
    },
    {
      "itemId": "gold_coin",
      "weight": 100,
      "minQuantity": 10,
      "maxQuantity": 50
    }
  ]
}
```

### 2. Use in Code
```csharp
// Load the drop table
var dropTable = DataDrivenDropTable.LoadFromJson("res://data/drops/goblin_loot.json");

// Generate drops
var context = new LootContext { Level = 10, Luck = 0.5f };
var drops = new DropCalculator().GenerateDrops(dropTable, context);

// Spawn in world
foreach (var drop in drops)
{
    var node = SpawnDrop(drop, globalPosition);
    AddChild(node);
}
```

**Next:** Read the [Quick Start Guide](./getting-started/quick-start.md) for complete setup instructions.

---

## 📖 Documentation Philosophy

### Principles
- **Living Documents** - Regularly updated with new features
- **Example-Driven** - Working code examples for every concept
- **Engine-Specific** - Separate guides for Godot and Unity
- **Performance-Focused** - Optimization guides and benchmarks
- **Migration-Friendly** - Clear upgrade paths from legacy approaches

### Conventions
- **Code Examples** - All examples are tested and functional
- **Version Tracking** - Each document notes compatibility versions
- **Priority Marking** - Features marked by implementation priority
- **Status Indicators** - Current status of each feature/improvement

---

## 🔍 Finding Information

### By Experience Level
- **🟢 Beginners**: Quick Start → Basic Concepts → Data-Driven Configuration
- **🟡 Intermediate**: Advanced Topics → API Reference → Examples
- **🔴 Advanced**: Architecture → Performance → Custom Logic

### By Use Case
- **🎮 Game Developers**: Integration guides → Examples → Troubleshooting
- **🔧 Plugin Developers**: API reference → Architecture → Testing
- **🏗️ System Architects**: Design decisions → Performance → Migration

---

## 📞 Support & Feedback

### Getting Help
- **Issues**: Report bugs and feature requests in the main repository
- **Discussions**: Use GitHub Discussions for questions and ideas
- **Documentation Issues**: Report documentation problems separately

### Contributing Feedback
- **Documentation Errors**: Create issue with "Documentation" label
- **Missing Information**: Suggest additions via discussions
- **Example Requests**: Request specific examples or tutorials
- **Improvement Ideas**: Add suggestions to improvements document

---

*Documentation maintained alongside plugin development*  
*Last Updated: November 2025*  
*Plugin Version: 1.0*  
*Recommended: Data-Driven Configuration*
