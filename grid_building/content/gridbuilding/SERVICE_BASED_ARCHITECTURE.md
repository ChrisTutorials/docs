---
title: "Service-Based Architecture"
description: "Understanding the service-based architecture pattern used in GridBuilding plugin"
date: 2025-12-01T00:00:00Z
draft: false
weight: 50
categories:
  - "gridbuilding"
  - "documentation"
tags:
  - "godot"
  - "grid"
  - "architecture"
  - "services"
  - "pattern"
---


## 🎯 Overview

This document describes the refined service-based architecture that separates **state data** from **business logic** and **event handling**. This creates a cleaner separation of concerns and improves testability.

## 🏗️ Architecture Principles

### 1. **State = Pure Data Only**
- State classes contain ONLY data (no logic, no events)
- Serializable and testable in isolation
- No engine dependencies
- No business logic or validation

### 2. **Services = Business Logic + Events**
- Services contain all business logic
- Services handle state validation and transitions
- Services dispatch events and signals
- Services coordinate between multiple state objects

### 3. **Clear Data Flow**
- **Godot** ↔ **Services** ↔ **State**
- Godot never directly accesses State
- All communication goes through Services
- Events flow from Services to Godot

## 📊 New Folder Structure

```text
Core/
├── State/                    # PURE DATA ONLY
│   ├── Building/
│   │   └── BuildingState.cs
│   ├── Manipulation/
│   │   └── ManipulationState.cs
│   ├── Targeting/
│   │   └── TargetingState.cs
│   ├── User/
│   │   └── UserState.cs
│   ├── Mode/
│   │   └── ModeState.cs
│   └── IState.cs            # Base state interface
│
├── Services/                   # SERVICES: Business logic + events
│   ├── Building/              # Building operations and events
│   │   ├── IBuildingService.cs
│   │   ├── BuildingService.cs
│   │   └── BuildingEvents.cs
│   ├── Manipulation/          # Manipulation operations and events
│   │   ├── IManipulationService.cs
│   │   ├── ManipulationService.cs
│   │   └── ManipulationEvents.cs
│   ├── Targeting/             # Targeting operations and events
│   │   ├── ITargetingService.cs
│   │   ├── TargetingService.cs
│   │   └── TargetingEvents.cs
│   ├── Input/                 # Input processing and events
│   │   ├── IInputService.cs
│   │   ├── InputService.cs
│   │   └── InputEvents.cs
│   ├── EventDispatcher.cs     # Central event coordination
│   ├── ICalculator.cs         # Calculator interfaces
│   └── IGeometryCalculator.cs # Geometry calculation interfaces
│
├── Systems/                  # CORE SYSTEMS (unchanged)
│   ├── Building/
│   ├── Collision/
│   ├── Components/
│   ├── Configuration/
│   ├── Data/
│   ├── Geometry/
│   ├── Grid/
│   ├── Input/
│   ├── InputManager.cs        # Input management system
│   ├── Logging/
│   ├── Manipulation/
│   ├── Placement/
│   ├── State/
│   ├── Targeting/
│   └── Validation/
│
├── Grid/                     # GRID INTEGRATION (unchanged)
├── Interfaces/               # INTERFACES (unchanged)
└── Common/                   # UTILITIES (unchanged)
```

## 🔄 Data Flow Architecture

### **Godot → Core → Godot Flow**

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Godot Layer   │    │  Service Layer  │    │   State Layer   │
│                 │    │                 │    │                 │
│ User Input      │───▶│ InputService   │───▶│ UserState       │
│ Mouse Click     │    │                 │    │                 │
│ Key Press       │    │                 │    │                 │
│                 │    │                 │    │                 │
│ UI Updates      │◀───│ BuildingEvents │◀───│ BuildingState   │
│ Visual Changes  │    │ Manipulation   │    │                 │
│ Audio Feedback  │    │ Events         │    │                 │
│                 │    │                 │    │                 │
│ Godot Nodes     │───▶│ BuildingService│───▶│ BuildingState   │
│ Scene Objects   │    │ Manipulation   │    │                 │
│ Components      │    │ Service        │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### **Detailed Flow Examples**

#### **1. Building Placement Flow**

```csharp
// Godot Layer
public class GridBuildingNode : Node
{
    private IBuildingService _buildingService;
    
    public override void _Ready()
    {
        // Connect to SERVICE events, not state
        _buildingService.BuildingPlaced += OnBuildingPlaced;
        _buildingService.BuildingFailed += OnBuildingFailed;
    }
    
    public void OnUserClick(Vector2I gridPos)
    {
        // Call SERVICE method
        _buildingService.PlaceBuilding(gridPos, "house");
    }
    
    private void OnBuildingPlaced(BuildingPlacedEvent args)
    {
        // Update visuals based on event data
        SpawnBuildingVisual(args.BuildingState);
    }
}

// Service Layer
public class BuildingService : IBuildingService
{
    private readonly BuildingState _state;
    private readonly IEventDispatcher _events;
    
    public event EventHandler<BuildingPlacedEvent> BuildingPlaced;
    public event EventHandler<BuildingFailedEvent> BuildingFailed;
    
    public void PlaceBuilding(Vector2I position, string buildingType)
    {
        // Business logic here
        if (!CanPlaceBuilding(position, buildingType))
        {
            BuildingFailed?.Invoke(this, new BuildingFailedEvent(...));
            return;
        }
        
        // Update STATE (pure data)
        _state.Position = position;
        _state.BuildingType = buildingType;
        _state.Status = BuildingStatus.Placed;
        
        // Dispatch EVENT
        BuildingPlaced?.Invoke(this, new BuildingPlacedEvent(_state));
    }
}

// State Layer (PURE DATA)
public class BuildingState
{
    public Vector2I Position { get; set; }
    public string BuildingType { get; set; }
    public BuildingStatus Status { get; set; }
    // NO EVENTS, NO LOGIC
}
```

#### **2. Manipulation Flow**

```csharp
// Godot Layer
public class ManipulationController : Node
{
    private IManipulationService _manipulationService;
    
    public override void _Ready()
    {
        // Connect to service events
        _manipulationService.ManipulationStarted += OnManipulationStarted;
        _manipulationService.ManipulationUpdated += OnManipulationUpdated;
        _manipulationService.ManipulationCompleted += OnManipulationCompleted;
    }
    
    public void StartManipulation(Vector2I startPos)
    {
        _manipulationService.StartManipulation(ManipulationMode.Move, startPos);
    }
}

// Service Layer
public class ManipulationService : IManipulationService
{
    private readonly ManipulationState _state;
    private readonly ITargetingService _targetingService;
    
    public event EventHandler<ManipulationStartedEvent> ManipulationStarted;
    public event EventHandler<ManipulationUpdatedEvent> ManipulationUpdated;
    public event EventHandler<ManipulationCompletedEvent> ManipulationCompleted;
    
    public void StartManipulation(ManipulationMode mode, Vector2I origin)
    {
        // Business logic
        _state.CurrentMode = mode;
        _state.GridOrigin = origin;
        _state.Phase = ManipulationPhase.Active;
        _state.IsActive = true;
        
        // Event dispatch
        ManipulationStarted?.Invoke(this, new ManipulationStartedEvent(_state));
    }
    
    public void UpdateManipulation(Vector2I targetPosition)
    {
        // Update state
        _state.GridTarget = targetPosition;
        _state.AffectedTiles = CalculateAffectedTiles(origin, targetPosition);
        
        // Event dispatch
        ManipulationUpdated?.Invoke(this, new ManipulationUpdatedEvent(_state));
    }
}

// State Layer (PURE DATA)
public class ManipulationState
{
    public ManipulationMode CurrentMode { get; set; }
    public Vector2I GridOrigin { get; set; }
    public Vector2I GridTarget { get; set; }
    public List<Vector2I> AffectedTiles { get; set; }
    public ManipulationPhase Phase { get; set; }
    public bool IsActive { get; set; }
    // NO EVENTS, NO LOGIC
}
```

## 🔌 Service Interface Design

### **Standard Service Pattern**

```csharp
public interface IBuildingService
{
    // Events
    event EventHandler<BuildingPlacedEvent> BuildingPlaced;
    event EventHandler<BuildingFailedEvent> BuildingFailed;
    event EventHandler<BuildingRemovedEvent> BuildingRemoved;
    
    // Commands (state-changing operations)
    void PlaceBuilding(Vector2I position, string buildingType);
    void RemoveBuilding(string buildingId);
    void MoveBuilding(string buildingId, Vector2I newPosition);
    
    // Queries (read-only operations)
    bool CanPlaceBuilding(Vector2I position, string buildingType);
    BuildingState GetBuilding(string buildingId);
    IEnumerable<BuildingState> GetAllBuildings();
}
```

### **Event Design Pattern**

```csharp
// Base event class
public abstract class GameEvent
{
    public DateTime Timestamp { get; }
    public string Source { get; }
    
    protected GameEvent(string source)
    {
        Timestamp = DateTime.Now;
        Source = source;
    }
}

// Specific event classes
public class BuildingPlacedEvent : GameEvent
{
    public BuildingState BuildingState { get; }
    
    public BuildingPlacedEvent(BuildingState buildingState) 
        : base("BuildingService")
    {
        BuildingState = buildingState;
    }
}

public class ManipulationUpdatedEvent : GameEvent
{
    public ManipulationState ManipulationState { get; }
    public Vector2I CurrentPosition { get; }
    
    public ManipulationUpdatedEvent(ManipulationState state) 
        : base("ManipulationService")
    {
        ManipulationState = state;
        CurrentPosition = state.GridTarget;
    }
}
```

## 🎯 Godot Implementation Changes

### **Before (State-Based)**
```csharp
// ❌ Direct state access
public class GridBuildingNode : Node
{
    private BuildingState _buildingState;
    
    public override void _Ready()
    {
        // Connect directly to state events
        _buildingState.PropertyChanged += OnBuildingStateChanged;
    }
}
```

### **After (Service-Based)**
```csharp
// ✅ Service-based access
public class GridBuildingNode : Node
{
    private IBuildingService _buildingService;
    private IManipulationService _manipulationService;
    private IInputService _inputService;
    
    public override void _Ready()
    {
        // Connect to service events
        _buildingService.BuildingPlaced += OnBuildingPlaced;
        _manipulationService.ManipulationUpdated += OnManipulationUpdated;
        _inputService.InputReceived += OnInputReceived;
    }
    
    public void OnUserInput(InputEvent inputEvent)
    {
        // Send to service, not state
        _inputService.ProcessInput(inputEvent);
    }
}
```

## 🧪 Testing Benefits

### **State Testing (Pure Data)**
```csharp
[Test]
public void BuildingState_ShouldStorePosition()
{
    // Arrange
    var state = new BuildingState();
    
    // Act
    state.Position = new Vector2I(5, 3);
    
    // Assert
    Assert.AreEqual(new Vector2I(5, 3), state.Position);
}
```

### **Service Testing (Business Logic)**
```csharp
[Test]
public void BuildingService_ShouldFailPlacement_WhenInvalidPosition()
{
    // Arrange
    var mockValidator = new Mock<IPlacementValidator>();
    mockValidator.Setup(x => x.CanPlace(It.IsAny<Vector2I>())).Returns(false);
    
    var service = new BuildingService(mockValidator.Object);
    
    // Act & Assert
    Assert.Throws<PlacementException>(() => 
        service.PlaceBuilding(new Vector2I(5, 3), "house"));
}
```

## 📋 Migration Steps

### **Phase 1: Create Service Interfaces**
1. Define `IBuildingService`, `IManipulationService`, etc.
2. Define event classes
3. Create service interfaces in `Services/` folder

### **Phase 2: Implement Services**
1. Move business logic from state classes to service classes
2. Remove events from state classes
3. Add event dispatching to service classes

### **Phase 3: Update Godot Layer**
1. Change Godot classes to use services instead of state
2. Update event subscriptions to use service events
3. Update method calls to use service methods

### **Phase 4: Clean Up**
1. Remove old event code from state classes
2. Remove context objects that are now services
3. Update documentation

## 🎯 Benefits Summary

### **Before (Mixed State/Services)**
- ❌ State contains business logic
- ❌ State dispatches events
- ❌ Hard to test (mixed concerns)
- ❌ Godot directly accesses state
- ❌ Confusing data flow

### **After (Separated)**
- ✅ State is pure data (easily testable)
- ✅ Services handle business logic
- ✅ Services dispatch events
- ✅ Clear data flow: Godot ↔ Services ↔ State
- ✅ Better separation of concerns
- ✅ Easier unit testing
- ✅ More maintainable code

## 🔄 Event Flow Diagram

```
User Input (Godot)
       ↓
InputService.ProcessInput()
       ↓
[Business Logic in Services]
       ↓
State Objects Updated (Pure Data)
       ↓
Events Dispatched (Services)
       ↓
Godot Updates Visuals
```

This architecture provides a **clean separation of concerns** while maintaining **clear data flow** and **excellent testability**.
