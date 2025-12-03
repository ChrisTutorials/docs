[`< Back`](../)

---

# ILootModifier

Namespace: TestProject

Interface for loot generation modifiers.

```csharp
public interface ILootModifier
```

Attributes [NullableContextAttribute](https://docs.microsoft.com/en-us/dotnet/api/system.runtime.compilerservices.nullablecontextattribute)

## Properties

### **Id**

Gets the unique identifier for this modifier.

```csharp
public abstract string Id { get; }
```

#### Property Value

[String](https://docs.microsoft.com/en-us/dotnet/api/system.string)<br>

## Methods

### **Modify(DropContext)**

Modifies the drop context.

```csharp
void Modify(DropContext context)
```

#### Parameters

`context` [DropContext](./testproject/dropcontext)<br>
The context to modify.

---

[`< Back`](../)
