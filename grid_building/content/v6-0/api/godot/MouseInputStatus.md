---
title: "MouseInputStatus"
description: "Holds the last mouse input gate/projection snapshot for grid-based input systems.
Provides typed properties and a convenience serializer to Dictionary."
weight: 20
url: "/gridbuilding/v6-0/api/godot/mouseinputstatus/"
---

# MouseInputStatus

```csharp
GridBuilding.Godot.Systems.GridTargeting.GridPositioner
class MouseInputStatus
{
    // Members...
}
```

Holds the last mouse input gate/projection snapshot for grid-based input systems.
Provides typed properties and a convenience serializer to Dictionary.

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridPositioner/MouseInputStatus.cs`  
**Namespace:** `GridBuilding.Godot.Systems.GridTargeting.GridPositioner`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Allowed

```csharp
#region Properties

    /// <summary>
    /// Whether mouse input was allowed through the gate.
    /// </summary>
    public bool Allowed { get; set; } = false;
```

Whether mouse input was allowed through the gate.

### World

```csharp
/// <summary>
    /// World position of the mouse.
    /// </summary>
    public Vector2 World { get; set; } = Vector2.Zero;
```

World position of the mouse.

### Method

```csharp
/// <summary>
    /// Projection method used (int value from ProjectionMethod).
    /// </summary>
    public int Method { get; set; } = 0;
```

Projection method used (int value from ProjectionMethod).

### MethodName

```csharp
/// <summary>
    /// String name of the projection method.
    /// </summary>
    public string MethodName { get; set; } = string.Empty;
```

String name of the projection method.

### Screen

```csharp
/// <summary>
    /// Screen position of the mouse.
    /// </summary>
    public Vector2 Screen { get; set; } = Vector2.Zero;
```

Screen position of the mouse.


## Methods

### SetFromValues

```csharp
#endregion

    #region Public Methods

    /// <summary>
    /// Set values from individual parameters.
    /// </summary>
    /// <param name="allowed">Whether input was allowed</param>
    /// <param name="world">World position</param>
    /// <param name="method">Projection method</param>
    /// <param name="methodName">Method name</param>
    /// <param name="screen">Screen position</param>
    public void SetFromValues(
        bool allowed, 
        Vector2 world, 
        int method, 
        string methodName, 
        Vector2 screen)
    {
        Allowed = allowed;
        World = world;
        Method = method;
        MethodName = methodName;
        Screen = screen;
    }
```

Set values from individual parameters.

**Returns:** `void`

**Parameters:**
- `bool allowed`
- `Vector2 world`
- `int method`
- `string methodName`
- `Vector2 screen`

### ToDict

```csharp
/// <summary>
    /// Convert to Dictionary for serialization.
    /// </summary>
    /// <returns>Dictionary representation of the status</returns>
    public Dictionary<string, Variant> ToDict()
    {
        return new Dictionary<string, Variant>
        {
            ["allowed"] = Allowed,
            ["world"] = World,
            ["method"] = Method,
            ["method_name"] = MethodName,
            ["screen"] = Screen
        };
    }
```

Convert to Dictionary for serialization.

**Returns:** `Dictionary<string, Variant>`

### FromDict

```csharp
/// <summary>
    /// Create from Dictionary for deserialization.
    /// </summary>
    /// <param name="dict">Dictionary containing the status data</param>
    /// <returns>MouseInputStatus instance</returns>
    public static MouseInputStatus FromDict(Dictionary<string, Variant> dict)
    {
        var status = new MouseInputStatus();
        
        if (dict.TryGetValue("allowed", out var allowed))
            status.Allowed = allowed.AsBool();
        
        if (dict.TryGetValue("world", out var world))
            status.World = world.AsVector2();
        
        if (dict.TryGetValue("method", out var method))
            status.Method = method.AsInt32();
        
        if (dict.TryGetValue("method_name", out var methodName))
            status.MethodName = methodName.AsString();
        
        if (dict.TryGetValue("screen", out var screen))
            status.Screen = screen.AsVector2();

        return status;
    }
```

Create from Dictionary for deserialization.

**Returns:** `MouseInputStatus`

**Parameters:**
- `Dictionary<string, Variant> dict`

### CreateAllowed

```csharp
#endregion

    #region Utility Methods

    /// <summary>
    /// Create a status indicating input was allowed.
    /// </summary>
    /// <param name="world">World position</param>
    /// <param name="method">Projection method</param>
    /// <param name="methodName">Method name</param>
    /// <param name="screen">Screen position</param>
    /// <returns>Status with allowed=true</returns>
    public static MouseInputStatus CreateAllowed(
        Vector2 world, 
        int method, 
        string methodName, 
        Vector2 screen)
    {
        return new MouseInputStatus(true, world, method, methodName, screen);
    }
```

Create a status indicating input was allowed.

**Returns:** `MouseInputStatus`

**Parameters:**
- `Vector2 world`
- `int method`
- `string methodName`
- `Vector2 screen`

### CreateBlocked

```csharp
/// <summary>
    /// Create a status indicating input was blocked.
    /// </summary>
    /// <param name="world">World position</param>
    /// <param name="method">Projection method</param>
    /// <param name="methodName">Method name</param>
    /// <param name="screen">Screen position</param>
    /// <returns>Status with allowed=false</returns>
    public static MouseInputStatus CreateBlocked(
        Vector2 world, 
        int method, 
        string methodName, 
        Vector2 screen)
    {
        return new MouseInputStatus(false, world, method, methodName, screen);
    }
```

Create a status indicating input was blocked.

**Returns:** `MouseInputStatus`

**Parameters:**
- `Vector2 world`
- `int method`
- `string methodName`
- `Vector2 screen`

### CreateDefault

```csharp
/// <summary>
    /// Create a default status (blocked).
    /// </summary>
    /// <returns>Default blocked status</returns>
    public static MouseInputStatus CreateDefault()
    {
        return new MouseInputStatus();
    }
```

Create a default status (blocked).

**Returns:** `MouseInputStatus`

### ToString

```csharp
#endregion

    #region Overrides

    /// <summary>
    /// Convert to string representation.
    /// </summary>
    /// <returns>String representation of the status</returns>
    public override string ToString()
    {
        return $"MouseInputStatus(allowed={Allowed}, world={World}, method={Method}({MethodName}), screen={Screen})";
    }
```

Convert to string representation.

**Returns:** `string`

