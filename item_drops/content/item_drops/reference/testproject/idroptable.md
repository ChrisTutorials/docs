[`< Back`](../)

---

# IDropTable

Namespace: TestProject

Interface for drop tables.

```csharp
public interface IDropTable
```

Attributes [NullableContextAttribute](https://docs.microsoft.com/en-us/dotnet/api/system.runtime.compilerservices.nullablecontextattribute)

## Properties

### **Id**

Gets the unique identifier for this drop table.

```csharp
public abstract string Id { get; }
```

#### Property Value

[String](https://docs.microsoft.com/en-us/dotnet/api/system.string)<br>

### **MinDrops**

Gets the minimum number of drops that can be generated.

```csharp
public abstract int MinDrops { get; }
```

#### Property Value

[Int32](https://docs.microsoft.com/en-us/dotnet/api/system.int32)<br>

### **MaxDrops**

Gets the maximum number of drops that can be generated.

```csharp
public abstract int MaxDrops { get; }
```

#### Property Value

[Int32](https://docs.microsoft.com/en-us/dotnet/api/system.int32)<br>

### **DropChance**

Gets the drop chance (0.0 to 1.0).

```csharp
public abstract float DropChance { get; }
```

#### Property Value

[Single](https://docs.microsoft.com/en-us/dotnet/api/system.single)<br>

---

[`< Back`](../)
