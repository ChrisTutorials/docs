---
title: "VirtualItem"
description: "Virtual item representation"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/virtualitem/"
---

# VirtualItem

```csharp
GridBuilding.Godot.Systems.Building.Virtual
class VirtualItem
{
    // Members...
}
```

Virtual item representation

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Virtual/VirtualItemContainer.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Building.Virtual`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Id

```csharp
public string Id { get; set; } = string.Empty;
```

### Name

```csharp
public string Name { get; set; } = string.Empty;
```

### Description

```csharp
public string Description { get; set; } = string.Empty;
```

### Category

```csharp
public string Category { get; set; } = string.Empty;
```

### Tags

```csharp
public List<string> Tags { get; set; } = new List<string>();
```

### Data

```csharp
public Dictionary<string, object> Data { get; set; } = new Dictionary<string, object>();
```

### CreatedAt

```csharp
public DateTime CreatedAt { get; set; } = DateTime.Now;
```

### ModifiedAt

```csharp
public DateTime ModifiedAt { get; set; } = DateTime.Now;
```


## Methods

### Serialize

```csharp
/// <summary>
        /// Serializes item to dictionary
        /// </summary>
        public Dictionary<string, object> Serialize()
        {
            return new Dictionary<string, object>
            {
                ["id"] = Id,
                ["name"] = Name,
                ["description"] = Description,
                ["category"] = Category,
                ["tags"] = Tags,
                ["data"] = Data,
                ["created_at"] = CreatedAt.ToString("O"),
                ["modified_at"] = ModifiedAt.ToString("O")
            };
        }
```

Serializes item to dictionary

**Returns:** `Dictionary<string, object>`

### Deserialize

```csharp
/// <summary>
        /// Deserializes item from dictionary
        /// </summary>
        public static VirtualItem Deserialize(Dictionary<string, object> data)
        {
            if (data == null)
                return null;

            var item = new VirtualItem();

            if (data.TryGetValue("id", out var id) && id is string idStr)
                item.Id = idStr;

            if (data.TryGetValue("name", out var name) && name is string nameStr)
                item.Name = nameStr;

            if (data.TryGetValue("description", out var desc) && desc is string descStr)
                item.Description = descStr;

            if (data.TryGetValue("category", out var cat) && cat is string catStr)
                item.Category = catStr;

            if (data.TryGetValue("tags", out var tags) && tags is List<object> tagsList)
            {
                item.Tags = new List<string>();
                foreach (var tag in tagsList)
                {
                    if (tag is string tagStr)
                        item.Tags.Add(tagStr);
                }
            }

            if (data.TryGetValue("data", out var itemData) && itemData is Dictionary<string, object> dataDict)
                item.Data = dataDict;

            if (data.TryGetValue("created_at", out var created) && created is string createdStr &&
                DateTime.TryParse(createdStr, out var createdDt))
                item.CreatedAt = createdDt;

            if (data.TryGetValue("modified_at", out var modified) && modified is string modifiedStr &&
                DateTime.TryParse(modifiedStr, out var modifiedDt))
                item.ModifiedAt = modifiedDt;

            return item;
        }
```

Deserializes item from dictionary

**Returns:** `VirtualItem`

**Parameters:**
- `Dictionary<string, object> data`

