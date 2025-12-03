[`< Back`](../)

---

# DropResult

Namespace: TestProject

Represents a generated drop result.

```csharp
public class DropResult
```

Inheritance [Object](https://docs.microsoft.com/en-us/dotnet/api/system.object) → [DropResult](./testproject/dropresult)<br>
Attributes [NullableContextAttribute](https://docs.microsoft.com/en-us/dotnet/api/system.runtime.compilerservices.nullablecontextattribute), [NullableAttribute](https://docs.microsoft.com/en-us/dotnet/api/system.runtime.compilerservices.nullableattribute)

## Properties

### **ItemId**

Gets the unique identifier of the dropped item.

```csharp
public string ItemId { get; }
```

#### Property Value

[String](https://docs.microsoft.com/en-us/dotnet/api/system.string)<br>

### **Quantity**

Gets the quantity of the dropped item.

```csharp
public int Quantity { get; }
```

#### Property Value

[Int32](https://docs.microsoft.com/en-us/dotnet/api/system.int32)<br>

### **Rarity**

Gets the rarity of the dropped item.

```csharp
public DropRarity Rarity { get; }
```

#### Property Value

[DropRarity](./testproject/droprarity)<br>

## Constructors

### **DropResult(String, Int32, DropRarity)**

Initializes a new instance of the [DropResult](./testproject/dropresult) class.

```csharp
public DropResult(string itemId, int quantity, DropRarity rarity)
```

#### Parameters

`itemId` [String](https://docs.microsoft.com/en-us/dotnet/api/system.string)<br>
The unique identifier of the item.

`quantity` [Int32](https://docs.microsoft.com/en-us/dotnet/api/system.int32)<br>
The quantity of the item.

`rarity` [DropRarity](./testproject/droprarity)<br>
The rarity of the item.

---

[`< Back`](../)
