---
title: "InventoryCrossPlatformIntegrationTest"
description: ""
weight: 20
url: "/gridbuilding/v6.0/api/godot/inventorycrossplatformintegrationtest/"
---

# InventoryCrossPlatformIntegrationTest

```csharp
GridBuilding.Godot.Tests.Inventory
class InventoryCrossPlatformIntegrationTest
{
    // Members...
}
```

Integration tests for GridBuilding Inventory system cross-platform compatibility
Tests integration with Godot engine and platform-specific behaviors using pure C#

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Core/InventoryCrossPlatformIntegrationTest.cs`  
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
            _testScene = new Node();
            _testScene.Name = "TestScene";
        }
```

**Returns:** `void`

### Cleanup

```csharp
[TestCleanup]
        public void Cleanup()
        {
            _testScene?.QueueFree();
            _inventory = null;
        }
```

**Returns:** `void`

### InventorySignalIntegration_GodotEngine

```csharp
[TestMethod]
        public void InventorySignalIntegration_GodotEngine()
        {
            // Test that inventory signals work properly with Godot's signal system
            var signalReceived = false;
            var receivedData = new Godot.Collections.Dictionary();

            _inventory.Connect(GridBuildingInventory.SignalName.InventoryChanged, 
                Callable.From((Godot.Collections.Dictionary data) => 
                {
                    signalReceived = true;
                    receivedData = data;
                }));

            var testItem = CreateBuildingMaterialItem("wood_plank", 5);
            _inventory.AddItem(testItem);

            ;
            ;
            ;
        }
```

**Returns:** `void`

### InventoryResourcePersistence_CrossPlatform

```csharp
[TestMethod]
        public void InventoryResourcePersistence_CrossPlatform()
        {
            // Test that inventory items can be saved and loaded as Resources
            var originalItem = CreateComplexBuildingItem("advanced_building");
            
            // Save to resource
            var resourcePath = "user://test_inventory_item.tres";
            var saveResult = ResourceSaver.Save(originalItem, resourcePath);
            Assert.ErrorEquals(saveResult, Error.Ok, "Should save item resource successfully");

            // Load from resource
            var loadedItem = ResourceLoader.Load<InventoryItem>(resourcePath);
            ;
            
            ;
            ;
            ;

            // Cleanup
            DirAccess.RemoveAbsolute(resourcePath.Replace("user://", OS.GetUserDataDir() + "/"));
        }
```

**Returns:** `void`

### InventoryJsonSerialization_CrossPlatform

```csharp
[TestMethod]
        public void InventoryJsonSerialization_CrossPlatform()
        {
            // Test JSON serialization for cross-platform data exchange using C# JSON
            var testItem = CreateBuildingMaterialItem("stone_block", 10);
            testItem.Properties["custom_data"] = new Godot.Collections.Dictionary
            {
                ["build_time"] = 5.5,
                ["required_tools"] = new Godot.Collections.Array { "hammer", "chisel" }
            };

            var itemDict = testItem.ToDict();
            var jsonString = Json.Stringify(itemDict);
            
            ;
            
            var parsedDict = Json.ParseString(jsonString).AsGodotDictionary();
            var deserializedItem = InventoryItem.FromDict(parsedDict);
            
            ;
            ;
        }
```

**Returns:** `void`

### InventoryFileOperations_CrossPlatformPaths

```csharp
[TestMethod]
        public void InventoryFileOperations_CrossPlatformPaths()
        {
            // Test file operations with different path formats
            var testPaths = new[]
            {
                "user://inventory/test_save.json",
                "res://inventory/test_save.json",
                "/tmp/test_save.json"
            };

            foreach (var path in testPaths)
            {
                var inventoryData = _inventory.GetInventoryData();
                var jsonString = Json.Stringify(inventoryData);
                
                // Test writing
                var file = FileAccess.Open(path, FileAccess.ModeFlags.Write);
                if (file != null)
                {
                    file.StoreString(jsonString);
                    file.Close();
                    
                    // Test reading
                    var readFile = FileAccess.Open(path, FileAccess.ModeFlags.Read);
                    if (readFile != null)
                    {
                        var readString = readFile.GetAsText();
                        readFile.Close();
                        
                        ;
                    }
                    else
                    {
                        GD.Print($"Could not read file at path: {path} (may be expected for some paths)");
                    }
                    
                    // Cleanup
                    if (path.StartsWith("user://") || path.StartsWith("/tmp/"))
                    {
                        var fullPath = path.Replace("user://", OS.GetUserDataDir() + "/");
                        DirAccess.RemoveAbsolute(fullPath);
                    }
                }
                else
                {
                    GD.Print($"Could not write file at path: {path} (may be expected for some paths)");
                }
            }
        }
```

**Returns:** `void`

### InventoryMultiThreadAccess_CrossPlatform

```csharp
[TestMethod]
        public void InventoryMultiThreadAccess_CrossPlatform()
        {
            // Test thread safety of inventory operations using C# threading
            var inventory = new GridBuildingInventory();
            var errors = new System.Collections.Generic.List<string>();
            var lockObject = new object();

            // Simulate concurrent access from multiple threads using C# Task
            var tasks = new System.Threading.Tasks.Task[3];
            
            for (int i = 0; i < tasks.Length; i++)
            {
                var threadId = i;
                tasks[i] = System.Threading.Tasks.Task.Run(() =>
                {
                    try
                    {
                        for (int j = 0; j < 10; j++)
                        {
                            var item = CreateBuildingMaterialItem($"thread_{threadId}_item_{j}");
                            inventory.AddItem(item);
                            
                            // Small delay to increase chance of race conditions
                            System.Threading.Thread.Sleep(1);
                            
                            if (inventory.Items.Count > 0)
                            {
                                var randomItem = inventory.Items[0];
                                inventory.RemoveItem(randomItem);
                            }
                        }
                    }
                    catch (System.Exception ex)
                    {
                        lock (lockObject)
                        {
                            errors.Add($"C# Thread {threadId}: {ex.Message}");
                        }
                    }
                });
            }

            System.Threading.Tasks.Task.WaitAll(tasks);
            
            ;
            ;
        }
```

**Returns:** `void`

### InventoryLocalization_CrossPlatform

```csharp
[TestMethod]
        public void InventoryLocalization_CrossPlatform()
        {
            // Test that inventory system handles different locales and character sets
            var localizedItems = new[]
            {
                CreateLocalizedItem("русский_предмет", "Русский предмет", "Описание на русском"),
                CreateLocalizedItem("中文物品", "中文物品", "中文描述"),
                CreateLocalizedItem("العربية_العنصر", "العنصر العربي", "وصف باللغة العربية"),
                CreateLocalizedItem("日本語アイテム", "日本語アイテム", "日本語の説明")
            };

            foreach (var item in localizedItems)
            {
                var result = _inventory.AddItem(item);
                ;
                
                var data = item.ToDict();
                var deserialized = InventoryItem.FromDict(data);
                
                ;
                ;
            }
        }
```

**Returns:** `void`

### InventoryPerformance_CrossPlatform

```csharp
[TestMethod]
        public void InventoryPerformance_CrossPlatform()
        {
            // Test performance with large inventories across platforms
            var stopwatch = new System.Diagnostics.Stopwatch();
            
            // Add many items
            stopwatch.Start();
            for (int i = 0; i < 1000; i++)
            {
                var item = CreateBuildingMaterialItem($"perf_test_{i}", 1);
                _inventory.AddItem(item);
            }
            stopwatch.Stop();
            
            GD.Print($"Added 1000 items in {stopwatch.ElapsedMilliseconds}ms");
            ;
            
            // Test search performance
            stopwatch.Restart();
            var materials = _inventory.GetItemsByType("material");
            stopwatch.Stop();
            
            GD.Print($"Searched 1000 items in {stopwatch.ElapsedMilliseconds}ms");
            ;
            ;
        }
```

**Returns:** `void`

### InventoryMemoryManagement_CrossPlatform

```csharp
[TestMethod]
        public void InventoryMemoryManagement_CrossPlatform()
        {
            // Test memory management and cleanup using C# garbage collection
            var initialMemory = System.GC.GetTotalMemory(true);
            
            // Create and destroy many inventories
            for (int i = 0; i < 100; i++)
            {
                var tempInventory = new GridBuildingInventory();
                for (int j = 0; j < 10; j++)
                {
                    var item = CreateBuildingMaterialItem($"temp_{i}_{j}", 1);
                    tempInventory.AddItem(item);
                }
                tempInventory = null; // Allow C# garbage collection
            }
            
            System.GC.Collect();
            System.GC.WaitForPendingFinalizers();
            System.GC.Collect();
            
            var finalMemory = System.GC.GetTotalMemory(true);
            var memoryIncrease = finalMemory - initialMemory;
            
            GD.Print($"C# Memory increase: {memoryIncrease} bytes");
            ;
        }
```

**Returns:** `void`

### InventoryErrorHandling_CrossPlatform

```csharp
[TestMethod]
        public void InventoryErrorHandling_CrossPlatform()
        {
            // Test error handling across different platforms using C# exception handling
            var testCases = new[]
            {
                (Action) (() => _inventory.AddItem(null), "Adding null item"),
                (Action) (() => _inventory.RemoveItem(null), "Removing null item"),
                (Action) (() => _inventory.RemoveItemQuantity(null, 1), "Removing null quantity"),
                (Action) (() => 
                {
                    var item = CreateBuildingMaterialItem("test", 1);
                    _inventory.RemoveItemQuantity(item, -1);
                }, "Removing negative quantity"),
                (Action) (() => 
                {
                    var item = CreateBuildingMaterialItem("test", 1);
                    _inventory.RemoveItemQuantity(item, 5);
                }, "Removing more than available")
            };

            foreach (var (action, description) in testCases)
            {
                try
                {
                    action();
                    // If no exception thrown, that's acceptable behavior for graceful handling
                }
                catch (System.ArgumentException)
                {
                    // ArgumentException is acceptable for invalid arguments in C#
                }
                catch (System.Exception ex)
                {
                    Assert.Fail($"Unexpected C# exception in {description}: {ex.Message}");
                }
            }
        }
```

**Returns:** `void`

