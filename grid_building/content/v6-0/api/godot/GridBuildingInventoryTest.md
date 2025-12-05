---
title: "GridBuildingInventoryTest"
description: "Cross-platform compatibility tests for GridBuilding Inventory system
Tests the pure C# implementation for platform independence and proper integration"
weight: 20
url: "/gridbuilding/v6-0/api/godot/gridbuildinginventorytest/"
---

# GridBuildingInventoryTest

```csharp
GridBuilding.Godot.Tests.Inventory
class GridBuildingInventoryTest
{
    // Members...
}
```

Cross-platform compatibility tests for GridBuilding Inventory system
Tests the pure C# implementation for platform independence and proper integration

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/GridBuildingInventoryTest.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Inventory`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### Setup

```csharp
[TestInitialize]
        public void Setup()
        {
            _inventory = new GridBuildingInventory();
            _testItem = new InventoryItem
            {
                Id = "test_item_001",
                Name = "Test Item",
                Description = "A test item for cross-platform compatibility",
                Weight = 1.5f,
                StackSize = 10,
                CurrentStack = 1,
                ItemType = "material",
                Properties = new Godot.Collections.Dictionary
                {
                    ["category"] = "building",
                    ["rarity"] = "common"
                }
            };
        }
```

**Returns:** `void`

### InventoryInitialization_CrossPlatform

```csharp
[TestMethod]
        public void InventoryInitialization_CrossPlatform()
        {
            // Test that inventory initializes correctly across platforms
            ;
            ;
            ;
            ;
            ;
        }
```

**Returns:** `void`

### AddItem_SingleItem_WorksAcrossPlatforms

```csharp
[TestMethod]
        public void AddItem_SingleItem_WorksAcrossPlatforms()
        {
            // Test basic item addition functionality
            var result = _inventory.AddItem(_testItem);
            
            ;
            ;
            ;
        }
```

**Returns:** `void`

### AddItem_Stacking_WorksAcrossPlatforms

```csharp
[TestMethod]
        public void AddItem_Stacking_WorksAcrossPlatforms()
        {
            // Create multiple items of same type for stacking
            var item1 = CreateTestItem("stack_test", 5);
            var item2 = CreateTestItem("stack_test", 3);
            var item3 = CreateTestItem("stack_test", 8); // Should exceed stack size

            var result1 = _inventory.AddItem(item1);
            var result2 = _inventory.AddItem(item2);
            var result3 = _inventory.AddItem(item3);

            ;
            ;
            ;

            ;
            ;
        }
```

**Returns:** `void`

### RemoveItem_CrossPlatformConsistency

```csharp
[TestMethod]
        public void RemoveItem_CrossPlatformConsistency()
        {
            _inventory.AddItem(_testItem);
            
            var result = _inventory.RemoveItem(_testItem);
            
            ;
            ;
            ;
        }
```

**Returns:** `void`

### RemoveItemQuantity_PartialRemoval_WorksAcrossPlatforms

```csharp
[TestMethod]
        public void RemoveItemQuantity_PartialRemoval_WorksAcrossPlatforms()
        {
            var stackedItem = CreateTestItem("partial_test", 10);
            _inventory.AddItem(stackedItem);

            var result = _inventory.RemoveItemQuantity(stackedItem, 3);

            ;
            ;
            ;
        }
```

**Returns:** `void`

### GetItemsByType_CrossPlatformFiltering

```csharp
[TestMethod]
        public void GetItemsByType_CrossPlatformFiltering()
        {
            var woodItem = CreateTestItem("wood", 5, "material");
            var stoneItem = CreateTestItem("stone", 3, "material");
            var toolItem = CreateTestItem("hammer", 1, "tool");

            _inventory.AddItem(woodItem);
            _inventory.AddItem(stoneItem);
            _inventory.AddItem(toolItem);

            var materials = _inventory.GetItemsByType("material");
            var tools = _inventory.GetItemsByType("tool");

            ;
            ;
        }
```

**Returns:** `void`

### InventoryDataSerialization_CrossPlatform

```csharp
[TestMethod]
        public void InventoryDataSerialization_CrossPlatform()
        {
            _inventory.AddItem(_testItem);
            
            var data = _inventory.GetInventoryData();
            
            ;
            ;
            ;
            ;
            ;
            ;

            // Test that data can be round-tripped
            var itemsArray = data["items"].AsGodotArray();
            ;
        }
```

**Returns:** `void`

### CapacityConstraints_CrossPlatformValidation

```csharp
[TestMethod]
        public void CapacityConstraints_CrossPlatformValidation()
        {
            // Test weight capacity
            var heavyItem = CreateTestItem("heavy", 1, "material");
            heavyItem.Weight = 2000.0f; // Exceeds default max weight

            var result = _inventory.AddItem(heavyItem);
            ;

            // Test slot capacity
            _inventory.MaxSlots = 2;
            var item1 = CreateTestItem("slot1", 1, "test");
            var item2 = CreateTestItem("slot2", 1, "test");
            var item3 = CreateTestItem("slot3", 1, "test");

            _inventory.AddItem(item1);
            _inventory.AddItem(item2);
            var result3 = _inventory.AddItem(item3);

            ;
        }
```

**Returns:** `void`

### SignalEmission_CrossPlatformConsistency

```csharp
[TestMethod]
        public void SignalEmission_CrossPlatformConsistency()
        {
            var signalReceived = false;
            var itemAddedSignal = false;
            var itemRemovedSignal = false;

            _inventory.Connect(GridBuildingInventory.SignalName.InventoryChanged, Callable.From(() => signalReceived = true));
            _inventory.Connect(GridBuildingInventory.SignalName.ItemAdded, Callable.From(() => itemAddedSignal = true));
            _inventory.Connect(GridBuildingInventory.SignalName.ItemRemoved, Callable.From(() => itemRemovedSignal = true));

            _inventory.AddItem(_testItem);
            ;
            ;

            signalReceived = false;
            _inventory.RemoveItem(_testItem);
            ;
            ;
        }
```

**Returns:** `void`

### ClearInventory_CrossPlatformBehavior

```csharp
[TestMethod]
        public void ClearInventory_CrossPlatformBehavior()
        {
            // Add multiple items
            for (int i = 0; i < 5; i++)
            {
                var item = CreateTestItem($"item_{i}", 1, "test");
                _inventory.AddItem(item);
            }

            ;

            _inventory.ClearInventory();

            ;
            ;
        }
```

**Returns:** `void`

### HasCapacityFor_CrossPlatformLogic

```csharp
[TestMethod]
        public void HasCapacityFor_CrossPlatformLogic()
        {
            var normalItem = CreateTestItem("normal", 1, "test");
            var heavyItem = CreateTestItem("heavy", 1, "test");
            heavyItem.Weight = 1500.0f;

            ;
            ;

            // Fill up slots
            _inventory.MaxSlots = 1;
            _inventory.AddItem(normalItem);

            var anotherItem = CreateTestItem("another", 1, "test");
            ;
        }
```

**Returns:** `void`

### ItemSerialization_CrossPlatform

```csharp
[TestMethod]
        public void ItemSerialization_CrossPlatform()
        {
            // Test that items can be serialized to dict and back
            var originalItem = CreateTestItem("serialize_test", 5, "material");
            originalItem.Properties["custom"] = "value";
            originalItem.Properties["number"] = 42;

            var dict = originalItem.ToDict();
            var deserializedItem = InventoryItem.FromDict(dict);

            ;
            ;
            ;
            ;
            ;
            ;
        }
```

**Returns:** `void`

### PathHandling_CrossPlatformCompatibility

```csharp
[TestMethod]
        public void PathHandling_CrossPlatformCompatibility()
        {
            // Test that inventory system handles paths correctly across platforms
            var testPaths = new[]
            {
                "C:/Users/test/Documents/game",
                "/home/user/game",
                "relative/path/to/game",
                "C:\\Users\\test\\Documents\\game" // Windows backslash format
            };

            foreach (var path in testPaths)
            {
                var item = CreateTestItem("path_test", 1, "resource");
                item.Properties["resource_path"] = path;
                
                var result = _inventory.AddItem(item);
                ;
                
                var data = item.ToDict();
                var deserialized = InventoryItem.FromDict(data);
                ;
            }
        }
```

**Returns:** `void`

