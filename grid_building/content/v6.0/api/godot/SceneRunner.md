---
title: "SceneRunner"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/scenerunner/"
---

# SceneRunner

```csharp
GridBuilding.Godot.Test.Infrastructure
class SceneRunner
{
    // Members...
}
```

C# implementation of SceneRunner for test scene management and simulation
Provides frame simulation, input processing, and scene lifecycle management
Ported from: godot/addons/grid_building/test/grid_building/helpers/godot_test_factory.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/SceneRunner.cs`  
**Namespace:** `GridBuilding.Godot.Test.Infrastructure`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### InitializeAsync

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Initializes the scene runner
    /// </summary>
    public async Task InitializeAsync()
    {
        if (_isInitialized)
            return;

        try
        {
            // Instantiate the scene
            _instantiatedScene = _scene.Instantiate();
            AddChild(_instantiatedScene);

            // Wait for scene to be ready
            await ToSignal(GetTree(), SceneTree.SignalName.ProcessFrame);

            // Validate initialization
            await ValidateSceneInitializationAsync();

            _isInitialized = true;
            EmitSignal(SignalName.SceneReady);
        }
        catch (Exception ex)
        {
            GD.PrintErr($"Failed to initialize SceneRunner: {ex.Message}");
            throw;
        }
    }
```

Initializes the scene runner

**Returns:** `Task`

### SimulateFramesAsync

```csharp
/// <summary>
    /// Simulates a specified number of frames
    /// </summary>
    /// <param name="frameCount">Number of frames to simulate</param>
    /// <param name="delta">Delta time for each frame (default: 1/60th second)</param>
    public async Task SimulateFramesAsync(int frameCount, double delta = 1.0 / 60.0)
    {
        if (!_isInitialized)
            throw new InvalidOperationException("SceneRunner not initialized. Call InitializeAsync() first.");

        for (int i = 0; i < frameCount; i++)
        {
            await SimulateSingleFrameAsync(delta);
            _frameCount++;
        }

        EmitSignal(SignalName.FrameSimulated, frameCount);
    }
```

Simulates a specified number of frames

**Returns:** `Task`

**Parameters:**
- `int frameCount`
- `double delta`

### ProcessInputAsync

```csharp
/// <summary>
    /// Processes input events
    /// </summary>
    /// <param name="inputEvent">Input event to process</param>
    public async Task ProcessInputAsync(InputEvent inputEvent)
    {
        if (!_isInitialized)
            throw new InvalidOperationException("SceneRunner not initialized. Call InitializeAsync() first.");

        _pendingInputs.Add(inputEvent);

        // Process the input
        Input.ParseInputEvent(inputEvent);
        
        // Wait for input to be processed
        await ToSignal(GetTree(), SceneTree.SignalName.ProcessFrame);

        _pendingInputs.Clear();
        EmitSignal(SignalName.InputProcessed, inputEvent);
    }
```

Processes input events

**Returns:** `Task`

**Parameters:**
- `InputEvent inputEvent`

### WaitForSignalAsync

```csharp
/// <summary>
    /// Waits for a specific signal to be emitted
    /// </summary>
    /// <param name="targetNode">Node that will emit the signal</param>
    /// <param name="signalName">Name of the signal to wait for</param>
    /// <param name="timeout">Maximum time to wait (in seconds)</param>
    public async Task WaitForSignalAsync(Node targetNode, StringName signalName, double timeout = 5.0)
    {
        if (!_isInitialized)
            throw new InvalidOperationException("SceneRunner not initialized. Call InitializeAsync() first.");

        var timeoutTask = CreateTimeoutTaskAsync(timeout);
        var signalTask = ToSignal(targetNode, signalName);

        var completedTask = await Task.WhenAny(signalTask, timeoutTask);

        if (completedTask == timeoutTask)
        {
            throw new TimeoutException($"Signal {signalName} not received within {timeout} seconds");
        }
    }
```

Waits for a specific signal to be emitted

**Returns:** `Task`

**Parameters:**
- `Node targetNode`
- `StringName signalName`
- `double timeout`

### GetSceneNode

```csharp
/// <summary>
    /// Gets a typed node from the instantiated scene
    /// </summary>
    public T GetSceneNode<T>(string path) where T : class
    {
        if (!_isInitialized)
            throw new InvalidOperationException("SceneRunner not initialized. Call InitializeAsync() first.");

        var node = _instantiatedScene.GetNode(path);
        return node as T ?? throw new InvalidOperationException($"Node at path '{path}' is not of type {typeof(T).Name}");
    }
```

Gets a typed node from the instantiated scene

**Returns:** `T`

**Parameters:**
- `string path`

### GetScene

```csharp
/// <summary>
    /// Gets the instantiated scene
    /// </summary>
    public Node GetScene() => _instantiatedScene;
```

Gets the instantiated scene

**Returns:** `Node`

### GetFrameCount

```csharp
/// <summary>
    /// Gets the current frame count
    /// </summary>
    public int GetFrameCount() => _frameCount;
```

Gets the current frame count

**Returns:** `int`

### IsInitialized

```csharp
/// <summary>
    /// Checks if the runner is initialized
    /// </summary>
    public bool IsInitialized() => _isInitialized;
```

Checks if the runner is initialized

**Returns:** `bool`

### Cleanup

```csharp
/// <summary>
    /// Cleans up the scene runner
    /// </summary>
    public void Cleanup()
    {
        if (_instantiatedScene != null && _instantiatedScene.IsInsideTree())
        {
            _instantiatedScene.GetParent().RemoveChild(_instantiatedScene);
            _instantiatedScene.QueueFree();
            _instantiatedScene = null;
        }

        _pendingInputs.Clear();
        _frameCount = 0;
        _isInitialized = false;
    }
```

Cleans up the scene runner

**Returns:** `void`

### CreateGridBuildingRunnerAsync

```csharp
#endregion

    #region Factory Methods

    /// <summary>
    /// Creates a SceneRunner for a GridBuilding test environment
    /// </summary>
    /// <param name="scenePath">Path to the scene file</param>
    public static async Task<SceneRunner> CreateGridBuildingRunnerAsync(string scenePath)
    {
        var scene = GD.Load<PackedScene>(scenePath);
        if (scene == null)
            throw new ArgumentException($"Failed to load scene: {scenePath}");

        var runner = new SceneRunner(scene);
        await runner.InitializeAsync();
        
        return runner;
    }
```

Creates a SceneRunner for a GridBuilding test environment

**Returns:** `Task<SceneRunner>`

**Parameters:**
- `string scenePath`

### CreateWorldTimeRunnerAsync

```csharp
/// <summary>
    /// Creates a SceneRunner for a WorldTime test environment
    /// </summary>
    /// <param name="scenePath">Path to the scene file</param>
    public static async Task<SceneRunner> CreateWorldTimeRunnerAsync(string scenePath)
    {
        var scene = GD.Load<PackedScene>(scenePath);
        if (scene == null)
            throw new ArgumentException($"Failed to load scene: {scenePath}");

        var runner = new SceneRunner(scene);
        await runner.InitializeAsync();
        
        return runner;
    }
```

Creates a SceneRunner for a WorldTime test environment

**Returns:** `Task<SceneRunner>`

**Parameters:**
- `string scenePath`

### CreateItemDropsRunnerAsync

```csharp
/// <summary>
    /// Creates a SceneRunner for an ItemDrops test environment
    /// </summary>
    /// <param name="scenePath">Path to the scene file</param>
    public static async Task<SceneRunner> CreateItemDropsRunnerAsync(string scenePath)
    {
        var scene = GD.Load<PackedScene>(scenePath);
        if (scene == null)
            throw new ArgumentException($"Failed to load scene: {scenePath}");

        var runner = new SceneRunner(scene);
        await runner.InitializeAsync();
        
        return runner;
    }
```

Creates a SceneRunner for an ItemDrops test environment

**Returns:** `Task<SceneRunner>`

**Parameters:**
- `string scenePath`

### SimulateMouseClickAsync

```csharp
#endregion

    #region Input Helpers

    /// <summary>
    /// Simulates a mouse click at the specified position
    /// </summary>
    public async Task SimulateMouseClickAsync(Vector2 position, MouseButton button = MouseButton.Left)
    {
        var pressEvent = new InputEventMouseButton
        {
            Position = position,
            ButtonIndex = button,
            Pressed = true
        };

        var releaseEvent = new InputEventMouseButton
        {
            Position = position,
            ButtonIndex = button,
            Pressed = false
        };

        await ProcessInputAsync(pressEvent);
        await Task.Delay(50); // Small delay between press and release
        await ProcessInputAsync(releaseEvent);
    }
```

Simulates a mouse click at the specified position

**Returns:** `Task`

**Parameters:**
- `Vector2 position`
- `MouseButton button`

### SimulateKeyPressAsync

```csharp
/// <summary>
    /// Simulates a key press
    /// </summary>
    public async Task SimulateKeyPressAsync(Key key, bool pressed = true)
    {
        var keyEvent = new InputEventKey
        {
            Keycode = key,
            Pressed = pressed
        };

        await ProcessInputAsync(keyEvent);
    }
```

Simulates a key press

**Returns:** `Task`

**Parameters:**
- `Key key`
- `bool pressed`

### SimulateMouseMoveAsync

```csharp
/// <summary>
    /// Simulates mouse movement
    /// </summary>
    public async Task SimulateMouseMoveAsync(Vector2 position)
    {
        var moveEvent = new InputEventMouseMotion
        {
            Position = position
        };

        await ProcessInputAsync(moveEvent);
    }
```

Simulates mouse movement

**Returns:** `Task`

**Parameters:**
- `Vector2 position`

