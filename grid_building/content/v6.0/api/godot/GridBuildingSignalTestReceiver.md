---
title: "GridBuildingSignalTestReceiver"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/gridbuildingsignaltestreceiver/"
---

# GridBuildingSignalTestReceiver

```csharp
GridBuilding.Tests
class GridBuildingSignalTestReceiver
{
    // Members...
}
```

Helper class for testing GridBuilding signal reception

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/GridBuildingSignalTests.cs`  
**Namespace:** `GridBuilding.Tests`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### ReceivedSignals

```csharp
public List<string> ReceivedSignals { get; } = new List<string>();
```

### SignalData

```csharp
public Dictionary<string, object> SignalData { get; } = new Dictionary<string, object>();
```


## Methods

### RecordSignal

```csharp
public void RecordSignal(string signalName)
        {
            ReceivedSignals.Add(signalName);
            GD.Print($"GridBuilding signal received: {signalName}");
        }
```

**Returns:** `void`

**Parameters:**
- `string signalName`

### ClearRecordings

```csharp
public void ClearRecordings()
        {
            ReceivedSignals.Clear();
            SignalData.Clear();
        }
```

**Returns:** `void`

