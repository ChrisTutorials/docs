[`< Back`](../)

---

# DropContext

Namespace: TestProject

Context data for loot generation.

```csharp
public class DropContext
```

Inheritance [Object](https://docs.microsoft.com/en-us/dotnet/api/system.object) → [DropContext](./testproject/dropcontext)<br>
Attributes [NullableContextAttribute](https://docs.microsoft.com/en-us/dotnet/api/system.runtime.compilerservices.nullablecontextattribute), [NullableAttribute](https://docs.microsoft.com/en-us/dotnet/api/system.runtime.compilerservices.nullableattribute)

## Properties

### **PlayerLevel**

Gets or sets the player level.

```csharp
public int PlayerLevel { get; set; }
```

#### Property Value

[Int32](https://docs.microsoft.com/en-us/dotnet/api/system.int32)<br>

### **LuckModifier**

Gets or sets the luck modifier.

```csharp
public float LuckModifier { get; set; }
```

#### Property Value

[Single](https://docs.microsoft.com/en-us/dotnet/api/system.single)<br>

### **Location**

Gets or sets the location.

```csharp
public string Location { get; set; }
```

#### Property Value

[String](https://docs.microsoft.com/en-us/dotnet/api/system.string)<br>

## Constructors

### **DropContext()**

```csharp
public DropContext()
```

## Methods

### **Clone()**

Creates a clone of this context.

```csharp
public DropContext Clone()
```

#### Returns

[DropContext](./testproject/dropcontext)<br>
A new DropContext instance with the same values.

---

[`< Back`](../)
