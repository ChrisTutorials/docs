---
title: "VirtualItemContainer"
description: "Virtual container for managing building items in a virtual space
Provides functionality for organizing, storing, and managing virtual building components
without actual Godot scene tree instantiation
Ported from: godot/addons/grid_building/systems/building/virtual/virtual_item_container.gd"
weight: 20
url: "/gridbuilding/v6-0-public/api/godot/virtualitemcontainer/"
---

# VirtualItemContainer

```csharp
GridBuilding.Godot.Systems.Building.Virtual
class VirtualItemContainer
{
    // Members...
}
```

Virtual container for managing building items in a virtual space
Provides functionality for organizing, storing, and managing virtual building components
without actual Godot scene tree instantiation
Ported from: godot/addons/grid_building/systems/building/virtual/virtual_item_container.gd

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Virtual/VirtualItemContainer.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Building.Virtual`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Capacity

```csharp
#endregion

        #region Exported Properties

        /// <summary>
        /// Maximum capacity of the container (-1 for unlimited)
        /// </summary>
        [Export]
        public int Capacity
        {
            get => _capacity;
            set => SetCapacity(value);
        }
```

Maximum capacity of the container (-1 for unlimited)

### AutoOrganize

```csharp
/// <summary>
        /// Whether to automatically organize items by category
        /// </summary>
        [Export]
        public bool AutoOrganize { get; set; } = true;
```

Whether to automatically organize items by category

### AllowDuplicates

```csharp
/// <summary>
        /// Whether to allow duplicate items
        /// </summary>
        [Export]
        public bool AllowDuplicates { get; set; } = false;
```

Whether to allow duplicate items

### ValidateItems

```csharp
/// <summary>
        /// Whether to validate items on addition
        /// </summary>
        [Export]
        public bool ValidateItems { get; set; } = true;
```

Whether to validate items on addition

### MaxCategories

```csharp
/// <summary>
        /// Maximum number of categories
        /// </summary>
        [Export]
        public int MaxCategories { get; set; } = 50;
```

Maximum number of categories

### ItemCount

```csharp
#endregion

        #region Public Properties

        /// <summary>
        /// Current number of items in the container
        /// </summary>
        public int ItemCount => _itemCount;
```

Current number of items in the container

### IsAtCapacity

```csharp
/// <summary>
        /// Whether the container is at capacity
        /// </summary>
        public bool IsAtCapacity => _capacity >= 0 && _itemCount >= _capacity;
```

Whether the container is at capacity

### IsEmpty

```csharp
/// <summary>
        /// Whether the container is empty
        /// </summary>
        public bool IsEmpty => _itemCount == 0;
```

Whether the container is empty

### CategoryCount

```csharp
/// <summary>
        /// Number of categories
        /// </summary>
        public int CategoryCount => _categories.Count;
```

Number of categories

### IsInitialized

```csharp
/// <summary>
        /// Whether the container is initialized
        /// </summary>
        public bool IsInitialized => _isInitialized;
```

Whether the container is initialized


## Methods

### _Ready

```csharp
#endregion

        #region Godot Methods

        public override void _Ready()
        {
            InitializeContainer();
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            CleanupContainer();
        }
```

**Returns:** `void`

### AddItem

```csharp
#endregion

        #region Item Management

        /// <summary>
        /// Adds an item to the container
        /// </summary>
        /// <param name="item">Item to add</param>
        /// <returns>True if item was added successfully</returns>
        public bool AddItem(VirtualItem item)
        {
            if (!_isInitialized)
            {
                GD.PrintErr("Container not initialized");
                return false;
            }

            if (item == null)
            {
                GD.PrintErr("Cannot add null item");
                return false;
            }

            // Validate item
            if (ValidateItems && !ValidateItem(item))
            {
                GD.PrintErr($"Item validation failed: {item.Id}");
                return false;
            }

            // Check capacity
            if (IsAtCapacity)
            {
                GD.PrintErr("Container is at capacity");
                return false;
            }

            // Check for duplicates
            if (!AllowDuplicates && _items.ContainsKey(item.Id))
            {
                GD.PrintErr($"Item with ID '{item.Id}' already exists");
                return false;
            }

            // Add item
            _items[item.Id] = item;
            _itemCount++;

            // Organize into categories
            if (AutoOrganize && !string.IsNullOrWhiteSpace(item.Category))
            {
                AddToCategory(item.Category, item.Id);
            }

            // Notify listeners
            NotifyItemAdded(item.Id, item);

            // Emit signal
            EmitSignal(SignalName.ItemAdded, item.Id, item);

            GD.Print($"Added item: {item.Id}");
            return true;
        }
```

Adds an item to the container

**Returns:** `bool`

**Parameters:**
- `VirtualItem item`

### RemoveItem

```csharp
/// <summary>
        /// Removes an item from the container
        /// </summary>
        /// <param name="itemId">ID of item to remove</param>
        /// <returns>True if item was removed successfully</returns>
        public bool RemoveItem(string itemId)
        {
            if (!_isInitialized)
            {
                GD.PrintErr("Container not initialized");
                return false;
            }

            if (string.IsNullOrWhiteSpace(itemId))
            {
                GD.PrintErr("Item ID cannot be null or empty");
                return false;
            }

            if (!_items.TryGetValue(itemId, out var item))
            {
                GD.PrintErr($"Item with ID '{itemId}' not found");
                return false;
            }

            // Remove from categories
            if (AutoOrganize && !string.IsNullOrWhiteSpace(item.Category))
            {
                RemoveFromCategory(item.Category, itemId);
            }

            // Remove item
            _items.Remove(itemId);
            _itemCount--;

            // Notify listeners
            NotifyItemRemoved(itemId, item);

            // Emit signal
            EmitSignal(SignalName.ItemRemoved, itemId, item);

            GD.Print($"Removed item: {itemId}");
            return true;
        }
```

Removes an item from the container

**Returns:** `bool`

**Parameters:**
- `string itemId`

### GetItem

```csharp
/// <summary>
        /// Gets an item by ID
        /// </summary>
        /// <param name="itemId">Item ID</param>
        /// <returns>Item or null if not found</returns>
        public VirtualItem GetItem(string itemId)
        {
            if (!_isInitialized)
                return null;

            return _items.TryGetValue(itemId, out var item) ? item : null;
        }
```

Gets an item by ID

**Returns:** `VirtualItem`

**Parameters:**
- `string itemId`

### HasItem

```csharp
/// <summary>
        /// Checks if an item exists in the container
        /// </summary>
        /// <param name="itemId">Item ID</param>
        /// <returns>True if item exists</returns>
        public bool HasItem(string itemId)
        {
            if (!_isInitialized)
                return false;

            return _items.ContainsKey(itemId);
        }
```

Checks if an item exists in the container

**Returns:** `bool`

**Parameters:**
- `string itemId`

### GetAllItems

```csharp
/// <summary>
        /// Gets all items in the container
        /// </summary>
        /// <returns>Dictionary of all items</returns>
        public Dictionary<string, VirtualItem> GetAllItems()
        {
            if (!_isInitialized)
                return new Dictionary<string, VirtualItem>();

            return new Dictionary<string, VirtualItem>(_items);
        }
```

Gets all items in the container

**Returns:** `Dictionary<string, VirtualItem>`

### Clear

```csharp
/// <summary>
        /// Clears all items from the container
        /// </summary>
        public void Clear()
        {
            if (!_isInitialized)
                return;

            // Clear all data
            _items.Clear();
            _categories.Clear();
            _itemCount = 0;

            // Notify listeners
            NotifyContainerCleared();

            // Emit signal
            EmitSignal(SignalName.ContainerCleared);

            GD.Print("Container cleared");
        }
```

Clears all items from the container

**Returns:** `void`

### GetItemsInCategory

```csharp
/// <summary>
        /// Gets all items in a category
        /// </summary>
        /// <param name="category">Category name</param>
        /// <returns>List of item IDs in category</returns>
        public List<string> GetItemsInCategory(string category)
        {
            if (!_isInitialized)
                return new List<string>();

            return _categories.TryGetValue(category, out var items) ? new List<string>(items) : new List<string>();
        }
```

Gets all items in a category

**Returns:** `List<string>`

**Parameters:**
- `string category`

### GetAllCategories

```csharp
/// <summary>
        /// Gets all categories
        /// </summary>
        /// <returns>List of category names</returns>
        public List<string> GetAllCategories()
        {
            if (!_isInitialized)
                return new List<string>();

            return new List<string>(_categories.Keys);
        }
```

Gets all categories

**Returns:** `List<string>`

### GetCategoryItemCount

```csharp
/// <summary>
        /// Gets the count of items in a category
        /// </summary>
        /// <param name="category">Category name</param>
        /// <returns>Number of items in category</returns>
        public int GetCategoryItemCount(string category)
        {
            if (!_isInitialized)
                return 0;

            return _categories.TryGetValue(category, out var items) ? items.Count : 0;
        }
```

Gets the count of items in a category

**Returns:** `int`

**Parameters:**
- `string category`

### FindItemsByName

```csharp
#endregion

        #region Search and Filtering

        /// <summary>
        /// Finds items by name
        /// </summary>
        /// <param name="name">Name to search for</param>
        /// <param name="exactMatch">Whether to require exact match</param>
        /// <returns>List of matching items</returns>
        public List<VirtualItem> FindItemsByName(string name, bool exactMatch = false)
        {
            if (!_isInitialized)
                return new List<VirtualItem>();

            var results = new List<VirtualItem>();

            foreach (var item in _items.Values)
            {
                if (exactMatch)
                {
                    if (item.Name == name)
                        results.Add(item);
                }
                else
                {
                    if (item.Name.Contains(name))
                        results.Add(item);
                }
            }

            return results;
        }
```

Finds items by name

**Returns:** `List<VirtualItem>`

**Parameters:**
- `string name`
- `bool exactMatch`

### FindItemsByCategory

```csharp
/// <summary>
        /// Finds items by category
        /// </summary>
        /// <param name="category">Category to search in</param>
        /// <returns>List of matching items</returns>
        public List<VirtualItem> FindItemsByCategory(string category)
        {
            if (!_isInitialized)
                return new List<VirtualItem>();

            var results = new List<VirtualItem>();
            var itemIds = GetItemsInCategory(category);

            foreach (var itemId in itemIds)
            {
                if (_items.TryGetValue(itemId, out var item))
                {
                    results.Add(item);
                }
            }

            return results;
        }
```

Finds items by category

**Returns:** `List<VirtualItem>`

**Parameters:**
- `string category`

### FindItemsByTag

```csharp
/// <summary>
        /// Finds items by tag
        /// </summary>
        /// <param name="tag">Tag to search for</param>
        /// <returns>List of matching items</returns>
        public List<VirtualItem> FindItemsByTag(string tag)
        {
            if (!_isInitialized)
                return new List<VirtualItem>();

            var results = new List<VirtualItem>();

            foreach (var item in _items.Values)
            {
                if (item.Tags.Contains(tag))
                    results.Add(item);
            }

            return results;
        }
```

Finds items by tag

**Returns:** `List<VirtualItem>`

**Parameters:**
- `string tag`

### FilterItems

```csharp
/// <summary>
        /// Filters items by custom criteria
        /// </summary>
        /// <param name="predicate">Filter predicate</param>
        /// <returns>List of filtered items</returns>
        public List<VirtualItem> FilterItems(Func<VirtualItem, bool> predicate)
        {
            if (!_isInitialized)
                return new List<VirtualItem>();

            var results = new List<VirtualItem>();

            foreach (var item in _items.Values)
            {
                if (predicate(item))
                    results.Add(item);
            }

            return results;
        }
```

Filters items by custom criteria

**Returns:** `List<VirtualItem>`

**Parameters:**
- `Func<VirtualItem, bool> predicate`

### AddListener

```csharp
#endregion

        #region Listener Management

        /// <summary>
        /// Adds a container listener
        /// </summary>
        /// <param name="listener">Listener to add</param>
        public void AddListener(IVirtualContainerListener listener)
        {
            if (listener == null)
                return;

            if (!_listeners.Contains(listener))
            {
                _listeners.Add(listener);
            }
        }
```

Adds a container listener

**Returns:** `void`

**Parameters:**
- `IVirtualContainerListener listener`

### RemoveListener

```csharp
/// <summary>
        /// Removes a container listener
        /// </summary>
        /// <param name="listener">Listener to remove</param>
        public void RemoveListener(IVirtualContainerListener listener)
        {
            _listeners.Remove(listener);
        }
```

Removes a container listener

**Returns:** `void`

**Parameters:**
- `IVirtualContainerListener listener`

### GetDebugInfo

```csharp
#endregion

        #region Debug and Diagnostics

        /// <summary>
        /// Gets debug information about the container
        /// </summary>
        public string GetDebugInfo()
        {
            var info = $"VirtualItemContainer Debug Info:\n";
            info += $"Initialized: {_isInitialized}\n";
            info += $"Item Count: {_itemCount}\n";
            info += $"Capacity: {_capacity}\n";
            info += $"Is At Capacity: {IsAtCapacity}\n";
            info += $"Category Count: {_categories.Count}\n";
            info += $"Auto Organize: {AutoOrganize}\n";
            info += $"Allow Duplicates: {AllowDuplicates}\n";
            info += $"Validate Items: {ValidateItems}\n";
            info += $"Listeners: {_listeners.Count}\n";

            if (_categories.Count > 0)
            {
                info += "\nCategories:\n";
                foreach (var category in _categories)
                {
                    info += $"  {category.Key}: {category.Value.Count} items\n";
                }
            }

            return info;
        }
```

Gets debug information about the container

**Returns:** `string`

### PrintDebugInfo

```csharp
/// <summary>
        /// Prints debug information to the console
        /// </summary>
        public void PrintDebugInfo()
        {
            GD.Print(GetDebugInfo());
        }
```

Prints debug information to the console

**Returns:** `void`

### GetStatistics

```csharp
/// <summary>
        /// Gets container statistics
        /// </summary>
        public Dictionary<string, object> GetStatistics()
        {
            var stats = new Dictionary<string, object>
            {
                ["item_count"] = _itemCount,
                ["capacity"] = _capacity,
                ["is_at_capacity"] = IsAtCapacity,
                ["is_empty"] = IsEmpty,
                ["category_count"] = _categories.Count,
                ["listener_count"] = _listeners.Count,
                ["auto_organize"] = AutoOrganize,
                ["allow_duplicates"] = AllowDuplicates,
                ["validate_items"] = ValidateItems
            };

            // Category statistics
            var categoryStats = new Dictionary<string, int>();
            foreach (var category in _categories)
            {
                categoryStats[category.Key] = category.Value.Count;
            }
            stats["category_statistics"] = categoryStats;

            return stats;
        }
```

Gets container statistics

**Returns:** `Dictionary<string, object>`

### Serialize

```csharp
#endregion

        #region Serialization

        /// <summary>
        /// Serializes container data to dictionary
        /// </summary>
        public Dictionary<string, object> Serialize()
        {
            var data = new Dictionary<string, object>
            {
                ["capacity"] = _capacity,
                ["auto_organize"] = AutoOrganize,
                ["allow_duplicates"] = AllowDuplicates,
                ["validate_items"] = ValidateItems,
                ["max_categories"] = MaxCategories
            };

            // Serialize items
            var itemsData = new Dictionary<string, object>();
            foreach (var item in _items)
            {
                itemsData[item.Key] = item.Value.Serialize();
            }
            data["items"] = itemsData;

            // Serialize categories
            data["categories"] = new Dictionary<string, object>(_categories);

            return data;
        }
```

Serializes container data to dictionary

**Returns:** `Dictionary<string, object>`

### Deserialize

```csharp
/// <summary>
        /// Deserializes container data from dictionary
        /// </summary>
        public void Deserialize(Dictionary<string, object> data)
        {
            if (data == null)
                return;

            // Clear current data
            Clear();

            // Load properties
            if (data.TryGetValue("capacity", out var capacity) && capacity is int cap)
                _capacity = cap;

            if (data.TryGetValue("auto_organize", out var autoOrg) && autoOrg is bool auto)
                AutoOrganize = auto;

            if (data.TryGetValue("allow_duplicates", out var allowDup) && allowDup is bool allow)
                AllowDuplicates = allow;

            if (data.TryGetValue("validate_items", out var validate) && validate is bool val)
                ValidateItems = val;

            if (data.TryGetValue("max_categories", out var maxCat) && maxCat is int max)
                MaxCategories = max;

            // Load items
            if (data.TryGetValue("items", out var items) && items is Dictionary<string, object> itemsDict)
            {
                foreach (var itemData in itemsDict)
                {
                    if (itemData.Value is Dictionary<string, object> itemDict)
                    {
                        var item = VirtualItem.Deserialize(itemDict);
                        if (item != null)
                        {
                            _items[item.Id] = item;
                            _itemCount++;
                        }
                    }
                }
            }

            // Load categories
            if (data.TryGetValue("categories", out var categories) && categories is Dictionary<string, object> catDict)
            {
                foreach (var category in catDict)
                {
                    if (category.Value is List<object> itemList)
                    {
                        var categoryItems = new List<string>();
                        foreach (var itemId in itemList)
                        {
                            if (itemId is string id)
                                categoryItems.Add(id);
                        }
                        _categories[category.Key] = categoryItems;
                    }
                }
            }
        }
```

Deserializes container data from dictionary

**Returns:** `void`

**Parameters:**
- `Dictionary<string, object> data`

