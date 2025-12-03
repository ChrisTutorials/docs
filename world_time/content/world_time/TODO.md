# WorldTime C# Porting TODO

This document outlines the tasks and priorities for porting WorldTime functionality from demo projects into the unified plugin structure.

## 🎯 Current Status

**Phase**: Initial Setup - Core library foundation needed
**Priority**: High - Time management is fundamental to most games

## 📋 Porting Tasks

### Core Library (Priority: 🔴 High)

#### [ ] Core Time Types
- **File**: `Core/Types/`
- **Tasks**:
  - [ ] Create `TimeSpan` struct (engine-agnostic)
  - [ ] Create `DateTime` struct (engine-agnostic)
  - [ ] Create `TimeOfDay` enum (Morning, Afternoon, Evening, Night)
  - [ ] Create `Season` enum (Spring, Summer, Fall, Winter)
  - [ ] Create `CalendarDate` struct (day, month, year)
  - [ ] Add type conversion utilities

#### [ ] Time Management System
- **File**: `Core/Time/`
- **Tasks**:
  - [ ] Create `TimeManager` class
  - [ ] Implement `UpdateTime()` method
  - [ ] Add time scaling (speed up/slow down)
  - [ ] Create pause/resume functionality
  - [ ] Add time events system

#### [ ] Calendar System
- **File**: `Core/Calendar/`
- **Tasks**:
  - [ ] Create `Calendar` class
  - [ ] Implement date progression
  - [ ] Add month/year tracking
  - [ ] Create season detection
  - [ ] Add holiday/event system

#### [ ] Time Utilities
- **File**: `Core/Utilities/`
- **Tasks**:
  - [ ] Create `TimeUtils` static class
  - [ ] Add time formatting functions
  - [ ] Create time calculation helpers
  - [ ] Add timezone support (if needed)
  - [ ] Create time validation methods

### Godot Integration (Priority: 🟡 Medium)

#### [ ] Godot Time Manager
- **File**: `Godot/Time/`
- **Tasks**:
  - [ ] Create `GodotTimeManager` Node
  - [ ] Integrate with Godot's `_process()` loop
  - [ ] Add Godot signal system for time events
  - [ ] Create time-based node behaviors

#### [ ] Resource Integration
- **File**: `Godot/Resources/`
- **Tasks**:
  - [ ] Create `TimeSettings` Resource
  - [ ] Create `CalendarSettings` Resource
  - [ ] Add Godot inspector properties
  - [ ] Create resource validation

#### [ ] Visual Components
- **File**: `Godot/UI/`
- **Tasks**:
  - [ ] Create time display UI components
  - [ ] Add calendar widget
  - [ ] Create time control panel
  - [ ] Add visual time indicators

### Unity Integration (Priority: 🟢 Low - Placeholder)

#### [ ] Unity Time Manager
- **File**: `Unity/Time/`
- **Tasks**:
  - [ ] Create `UnityTimeManager` MonoBehaviour
  - [ ] Integrate with Unity's `Update()` loop
  - [ ] Add Unity Event system for time events
  - [ ] Create time-based MonoBehaviour behaviors

#### [ ] ScriptableObject Integration
- **File**: `Unity/ScriptableObjects/`
- **Tasks**:
  - [ ] Create `TimeSettings` ScriptableObject
  - [ ] Create `CalendarSettings` ScriptableObject
  - [ ] Add Unity inspector properties
  - [ ] Create ScriptableObject validation

## 🎮 Demo Project Integration

### From `projects/item_drops_demo/docs/examples.md`

#### [ ] Time-Based Drop Systems
- **Reference**: Conditional drops based on time of day
- **Implementation**: Time-aware drop tables
- **Priority**: Medium (connects WorldTime with ItemDrops)

```csharp
// Example to implement
public class TimeAwareDropTable : DropTable
{
    public Dictionary<TimeOfDay, float> TimeModifiers { get; set; }
    
    public override List<ItemDrop> GenerateDrops(DropContext context)
    {
        var currentTime = TimeManager.CurrentTimeOfDay;
        var drops = base.GenerateDrops(context);
        
        // Apply time-based modifiers
        if (TimeModifiers.ContainsKey(currentTime))
        {
            ApplyTimeModifier(drops, TimeModifiers[currentTime]);
        }
        
        return drops;
    }
}
```

#### [ ] Seasonal Content
- **Reference**: Seasonal item availability
- **Implementation**: Season-aware content systems
- **Priority**: Low (nice-to-have feature)

## 🧪 Testing Strategy

### Core Tests (Priority: 🔴 High)
- [ ] Create `TimeManagerTest.cs`
- [ ] Create `CalendarTest.cs`
- [ ] Create `TimeUtilsTest.cs`
- [ ] Create `TypeConversionTest.cs`

### Integration Tests (Priority: 🟡 Medium)
- [ ] Create `GodotTimeManagerTest.cs`
- [ ] Create `TimeEventsTest.cs`
- [ ] Create `TimeScalingTest.cs`

### Performance Tests (Priority: 🟢 Low)
- [ ] Create `TimePerformanceTest.cs`
- [ ] Create `CalendarPerformanceTest.cs`

## 📁 File Structure to Create

```
WorldTime/
├── Core/
│   ├── Types/
│   │   ├── TimeTypes.cs
│   │   ├── CalendarTypes.cs
│   │   └── TypeExtensions.cs
│   ├── Time/
│   │   ├── TimeManager.cs
│   │   ├── TimeEvents.cs
│   │   └── TimeScaling.cs
│   ├── Calendar/
│   │   ├── Calendar.cs
│   │   ├── DateProgression.cs
│   │   └── SeasonDetection.cs
│   ├── Utilities/
│   │   ├── TimeUtils.cs
│   │   ├── TimeFormatting.cs
│   │   └── TimeValidation.cs
│   └── tests/
│       ├── TimeManagerTest.cs
│       ├── CalendarTest.cs
│       └── TimeUtilsTest.cs
├── Godot/
│   ├── Time/
│   │   ├── GodotTimeManager.cs
│   │   └── TimeNode.cs
│   ├── Resources/
│   │   ├── TimeSettings.cs
│   │   └── CalendarSettings.cs
│   ├── UI/
│   │   ├── TimeDisplay.cs
│   │   └── CalendarWidget.cs
│   └── tests/
│       └── GodotTimeManagerTest.cs
└── Unity/
    ├── Time/
    │   └── UnityTimeManager.cs
    ├── ScriptableObjects/
    │   ├── TimeSettings.cs
    │   └── CalendarSettings.cs
    └── tests/
        └── UnityTimeManagerTest.cs
```

## 🚀 Implementation Order

1. **Core Types** (Foundation)
2. **TimeManager** (Core functionality)
3. **Calendar System** (Extended functionality)
4. **Time Utilities** (Helper functions)
5. **Godot Integration** (Engine-specific)
6. **Testing** (Validation)
7. **Unity Integration** (Future)

## 📋 Dependencies

- **None for Core** - Pure C# implementation
- **Godot**: Godot 4.x
- **Unity**: Unity 2022.3+
- **Testing**: xUnit for Core, GoDotTest for Godot

## 🎯 Success Criteria

- [ ] Core time system works without engine dependencies
- [ ] Godot integration provides seamless time management
- [ ] All time calculations are deterministic and testable
- [ ] Performance suitable for real-time games
- [ ] Clean separation between Core and engine-specific code
- [ ] Comprehensive test coverage
- [ ] Integration with ItemDrops demo scenarios

## 📝 Notes

- Follow POCS architecture pattern from GridBuilding
- Keep Core library engine-agnostic
- Use Godot's signal system for time events
- Consider performance for long-running simulations
- Document all public APIs thoroughly
