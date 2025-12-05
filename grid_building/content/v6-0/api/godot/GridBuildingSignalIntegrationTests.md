---
title: "GridBuildingSignalIntegrationTests"
description: "Pure C# GridBuilding signal tests
Note: GDScript integration tests removed as plugin is now pure C#"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridbuildingsignalintegrationtests/"
---

# GridBuildingSignalIntegrationTests

```csharp
GridBuilding.Tests
class GridBuildingSignalIntegrationTests
{
    // Members...
}
```

Pure C# GridBuilding signal tests
Note: GDScript integration tests removed as plugin is now pure C#

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/GridBuildingSignalTests.cs`  
**Namespace:** `GridBuilding.Tests`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GridBuildingSignals_ShouldWork_InPureCSharpEnvironment

```csharp
[Fact]
        public void GridBuildingSignals_ShouldWork_InPureCSharpEnvironment()
        {
            // Test that GridBuilding C# signals work in pure C# environment
            
            // Arrange
            var csharpEmitter = new GridBuildingSignalEmitter();
            var csharpReceiver = new GridBuildingSignalTestReceiver();
            
            // Act
            csharpEmitter.Connect(GridBuildingSignalEmitter.SignalName.BuildingStateChanged, 
                Callable.From(() => csharpReceiver.RecordSignal("BuildingStateChanged")));
            csharpEmitter.EmitBuildingStateChanged(csharpEmitter.TestBuildingState);
            
            // Assert
            Assert.Contains("BuildingStateChanged", csharpReceiver.ReceivedSignals);
        }
```

**Returns:** `void`

### BuildingPlacementSignal_ShouldMaintainDataIntegrity_InCSharp

```csharp
[Fact]
        public void BuildingPlacementSignal_ShouldMaintainDataIntegrity_InCSharp()
        {
            // Test building placement signal with complex data in pure C#
            
            // Arrange
            var csharpEmitter = new GridBuildingSignalEmitter();
            var csharpReceiver = new GridBuildingSignalTestReceiver();
            
            var expectedBuilding = csharpEmitter.TestBuildingData;
            var expectedPosition = new Vector2I(15, 10);
            
            // Act
            csharpEmitter.Connect(GridBuildingSignalEmitter.SignalName.BuildingPlaced,
                Callable.From(() => csharpReceiver.RecordSignal("BuildingPlaced")));
            csharpEmitter.EmitBuildingPlaced(expectedBuilding, expectedPosition);
            
            // Assert
            Assert.Contains("BuildingPlaced", csharpReceiver.ReceivedSignals);
        }
```

**Returns:** `void`

### StateMachineSignals_ShouldPropagateCorrectly_InCSharp

```csharp
[Fact]
        public void StateMachineSignals_ShouldPropagateCorrectly_InCSharp()
        {
            // Test state machine signal flow in pure C#
            
            // Arrange
            var csharpEmitter = new GridBuildingSignalEmitter();
            var csharpReceiver = new GridBuildingSignalTestReceiver();
            
            // Act
            csharpEmitter.Connect(GridBuildingSignalEmitter.SignalName.StateChanged,
                Callable.From(() => csharpReceiver.RecordSignal("StateChanged")));
            csharpEmitter.EmitStateChanged("Idle", "Placing");
            
            // Assert
            Assert.Contains("StateChanged", csharpReceiver.ReceivedSignals);
        }
```

**Returns:** `void`

