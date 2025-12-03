[`< Back`](../)

---

# LootGenerator

Namespace: TestProject

Main class for generating loot based on drop tables and context.
 This is the primary entry point for the loot generation system.

```csharp
public class LootGenerator
```

Inheritance [Object](https://docs.microsoft.com/en-us/dotnet/api/system.object) → [LootGenerator](./testproject/lootgenerator)<br>
Attributes [NullableContextAttribute](https://docs.microsoft.com/en-us/dotnet/api/system.runtime.compilerservices.nullablecontextattribute), [NullableAttribute](https://docs.microsoft.com/en-us/dotnet/api/system.runtime.compilerservices.nullableattribute)

**Remarks:**

This class applies all registered modifiers before generating drops.

## Properties

### **Id**

Gets the unique identifier for this generator.

```csharp
public string Id { get; set; }
```

#### Property Value

[String](https://docs.microsoft.com/en-us/dotnet/api/system.string)<br>

### **Seed**

Gets or sets the seed for random number generation.

```csharp
public Nullable<int> Seed { get; set; }
```

#### Property Value

[Nullable&lt;Int32&gt;](https://docs.microsoft.com/en-us/dotnet/api/system.nullable-1)<br>

## Constructors

### **LootGenerator()**

Initializes a new instance of the [LootGenerator](./testproject/lootgenerator) class.

```csharp
public LootGenerator()
```

### **LootGenerator(Int32)**

Initializes a new instance of the [LootGenerator](./testproject/lootgenerator) class with a specific seed.

```csharp
public LootGenerator(int seed)
```

#### Parameters

`seed` [Int32](https://docs.microsoft.com/en-us/dotnet/api/system.int32)<br>
The seed for random number generation.

## Methods

### **AddModifier(ILootModifier)**

Adds a modifier to the loot generation process.

```csharp
public void AddModifier(ILootModifier modifier)
```

#### Parameters

`modifier` [ILootModifier](./testproject/ilootmodifier)<br>
The modifier to add.

#### Exceptions

[ArgumentNullException](https://docs.microsoft.com/en-us/dotnet/api/system.argumentnullexception)<br>
Thrown when modifier is null.

### **GenerateLoot(IDropTable, DropContext)**

Generates loot based on the provided drop table and context.

```csharp
public List<DropResult> GenerateLoot(IDropTable dropTable, DropContext context)
```

#### Parameters

`dropTable` [IDropTable](./testproject/idroptable)<br>
The drop table to use for generation.

`context` [DropContext](./testproject/dropcontext)<br>
The context for loot generation.

#### Returns

[List&lt;DropResult&gt;](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1)<br>
A list of generated drop results.

---

[`< Back`](../)
