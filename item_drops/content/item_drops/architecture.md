# ItemDrops Architecture

## 🏗️ Overview

The ItemDrops plugin follows a **POCS (Pure Object/Class/System)** architecture pattern, separating engine-agnostic core logic from engine-specific integration layers. This design enables maximum reusability, testability, and maintainability across different game engines.

## 📐 Architecture Principles

### POCS Design Pattern
- **Core**: Pure C# logic without engine dependencies
- **Integration**: Engine-specific runtime code
- **Separation**: Clean boundaries between layers
- **Reusability**: Core logic works across engines

### Type System Strategy
- **Core Types**: POCS implementations of common types
- **Engine Types**: Runtime engine-specific implementations
- **Conversion**: Extension methods for type bridging
- **Testing**: Core types enable unit testing without engines

## 🏛️ Layer Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Application Layer                        │
│                 (Game/Engine Code)                          │
├─────────────────────────────────────────────────────────────┤
│                  Integration Layer                           │
│  ┌─────────────────┐    ┌─────────────────┐                │
│  │   Godot Layer   │    │   Unity Layer   │                │
│  │                 │    │                 │                │
│  │ • Resources     │    │ • ScriptableObjs │                │
│  │ • Nodes         │    │ • MonoBehaviours │                │
│  │ • Signals       │    │ • Events        │                │
│  │ • Scene Tree    │    │ • GameObjects    │                │
│  └─────────────────┘    └─────────────────┘                │
├─────────────────────────────────────────────────────────────┤
│                      Core Layer                             │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │                ItemDrops.Core                            │ │
│  │                                                         │ │
│  │ • Drop System      • Probability System                │ │
│  │ • Generation System • Condition System                  │ │
│  │ • Types & Interfaces • Utilities                        │ │
│  │ • Validation       • Testing Support                   │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## 🧩 Core Components

### Drop System
```csharp
// Core drop abstractions
public interface IDrop
public interface IDropTable
public class ItemDrop
public class DropTable
public class DropCalculator
```

**Responsibilities**:
- Drop definition and configuration
- Drop table management
- Drop generation logic
- Weighted random selection

### Probability System
```csharp
// Probability calculations
public class WeightedRandom
public class DropChance
public class ProbabilityCalculator
```

**Responsibilities**:
- Weighted random selection
- Probability calculations
- Random number generation
- Statistical analysis

### Generation System
```csharp
// Loot generation and modifiers
public interface ILootGenerator
public interface ILootModifier
public class LootGenerator
public class DropStatistics
```

**Responsibilities**:
- Loot generation orchestration
- Drop modification and filtering
- Statistical analysis
- Batch processing

### Condition System
```csharp
// Drop conditions and logic
public interface IDropCondition
public class MinimumLevelCondition
public class EntityTypeCondition
public class LuckCondition
```

**Responsibilities**:
- Conditional drop logic
- Rule evaluation
- Complex condition composition
- Context-aware filtering

## 🔌 Integration Layers

### Godot Integration
```csharp
// Godot-specific implementations
public partial class DropTable : Resource, IDropTable
public partial class ItemDropNode : Node2D
public partial class ItemDropsBus : Resource
public partial class EnemyDrops : Node
```

**Key Features**:
- Resource system integration
- Scene tree compatibility
- Signal-based events
- Visual effects support

### Unity Integration
```csharp
// Unity-specific implementations
public class DropTableAsset : ScriptableObject, IDropTable
public class ItemDropComponent : MonoBehaviour
public class ItemDropsManager : MonoBehaviour
public class EnemyDrops : MonoBehaviour
```

**Key Features**:
- ScriptableObject integration
- Component-based architecture
- Unity event system
- Prefab spawning

## 🔄 Data Flow

### Drop Generation Flow
```
1. Context Creation
   └── LootContext (level, luck, entity type)

2. Table Selection
   └── IDropTable (drops, weights, conditions)

3. Condition Filtering
   └── IDropCondition.Evaluate(context)

4. Weighted Selection
   └── WeightedRandom.Select(available drops)

5. Modifier Application
   └── ILootModifier.Modify(results)

6. Engine Integration
   └── Spawn drops in game world
```

### Configuration Flow
```
1. Designer Configuration
   └── Resources/ScriptableObjects

2. Validation
   └── DropTableValidator.Validate()

3. Registration
   └── ItemDropsBus.RegisterDropTable()

4. Runtime Access
   └── ItemDropsBus.GetDropTable(id)
```

## 🧪 Testing Architecture

### Core Testing Strategy
- **xUnit**: Fast unit tests without engine dependencies
- **POCS Types**: Test with pure C# implementations
- **Mock Objects**: Interface-based testing
- **Parameterized Tests**: Comprehensive coverage

### Integration Testing Strategy
- **GoDotTest**: Godot runtime integration tests
- **Unity Test Framework**: Unity component tests
- **Scene Tests**: Full pipeline validation
- **Performance Tests**: Benchmark validation

### Test Organization
```
tests/
├── Core/
│   ├── Drops/
│   ├── Probability/
│   ├── Generation/
│   └── Conditions/
├── Godot/
│   ├── Resources/
│   ├── Systems/
│   └── Integration/
└── Unity/
    ├── Assets/
    ├── Components/
    └── Integration/
```

## 🚀 Performance Considerations

### Core Performance
- **Object Pooling**: Reuse DropResult objects
- **Caching**: Cache expensive calculations
- **Lazy Loading**: Load drop tables on demand
- **Batch Processing**: Efficient bulk operations

### Integration Performance
- **Scene Management**: Efficient node/prefab spawning
- **Event Handling**: Optimized signal/event systems
- **Memory Management**: Proper resource cleanup
- **Threading**: Thread-safe operations where needed

### Optimization Strategies
```csharp
// Example: Cached drop calculator
public class CachedDropCalculator : DropCalculator
{
    private readonly LRUCache<(string, int), List<DropResult>> _cache;
    
    public override List<DropResult> GenerateDrops(IDropTable table, LootContext context)
    {
        var key = (GetTableHash(table), context.Level);
        return _cache.GetOrAdd(key, () => base.GenerateDrops(table, context));
    }
}
```

## 🔧 Extensibility Points

### Plugin Architecture
```csharp
public interface IDropPlugin
{
    string Name { get; }
    void Initialize(IItemDropsContext context);
    void RegisterDropTypes(IDropTypeRegistry registry);
}
```

### Custom Drop Types
```csharp
public interface IDropType
{
    string TypeId { get; }
    bool CanDrop(LootContext context);
    DropResult GenerateDrop(LootContext context);
}
```

### Custom Conditions
```csharp
public interface IDropCondition
{
    bool Evaluate(LootContext context);
    string Description { get; }
}
```

### Custom Modifiers
```csharp
public interface ILootModifier
{
    IEnumerable<DropResult> Modify(IEnumerable<DropResult> drops, LootContext context);
}
```

## 📊 Design Metrics

### Complexity Metrics
- **Cyclomatic Complexity**: < 10 per method
- **Class Coupling**: < 5 dependencies per class
- **Inheritance Depth**: < 3 levels
- **Interface Count**: 1-2 interfaces per class

### Quality Metrics
- **Test Coverage**: > 90% for Core library
- **Documentation Coverage**: > 80%
- **Maintainability Index**: > 80
- **Technical Debt**: < 1 day

## 🎯 Design Decisions

### Why POCS Architecture?
1. **Testability**: Unit tests without engine dependencies
2. **Reusability**: Core logic works across engines
3. **Performance**: Pure C# calculations are faster
4. **Maintainability**: Clean separation of concerns

### Why Interface-Heavy Design?
1. **Extensibility**: Easy to add new implementations
2. **Testing**: Simple mocking and stubbing
3. **Flexibility**: Runtime implementation swapping
4. **Documentation**: Clear contracts

### Why Separate Integration Layers?
1. **Engine Optimization**: Engine-specific optimizations
2. **API Consistency**: Engine-idiomatic APIs
3. **Feature Parity**: Equal features across engines
4. **Maintenance**: Independent engine updates

## 🔄 Evolution Strategy

### Phase 1: Foundation
- Core drop system
- Basic probability calculations
- Simple generation logic
- Basic engine integration

### Phase 2: Enhancement
- Advanced condition system
- Modifier framework
- Performance optimizations
- Comprehensive testing

### Phase 3: Ecosystem
- Plugin architecture
- Advanced diagnostics
- Community extensions
- Performance benchmarking

## 📚 Best Practices

### Core Development
- **POCS Principles**: No engine dependencies in Core
- **Interface Design**: Small, focused interfaces
- **Error Handling**: Result pattern for operations
- **Performance**: Object pooling and caching

### Integration Development
- **Engine Idioms**: Follow engine conventions
- **Resource Management**: Proper cleanup
- **Event Systems**: Engine-appropriate events
- **Documentation**: Engine-specific examples

### Testing
- **Unit Tests**: Fast, isolated Core tests
- **Integration Tests**: Full pipeline validation
- **Performance Tests**: Benchmark regression testing
- **Documentation**: Test-driven development

---

*This architecture document evolves with the plugin development*  
*Last Updated: November 2025*  
*Architecture Version: 1.0*
