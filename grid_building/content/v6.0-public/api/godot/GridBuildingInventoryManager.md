---
title: "GridBuildingInventoryManager"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/gridbuildinginventorymanager/"
---

# GridBuildingInventoryManager

```csharp
GridBuilding.Godot.Core.Systems
class GridBuildingInventoryManager
{
    // Members...
}
```

GridBuilding Inventory Manager - Godot Integration Layer
Bridges the C# inventory system with Godot plugin architecture
Provides cross-platform compatibility and ZSharp integration support

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/GridBuildingInventoryManager.cs`  
**Namespace:** `GridBuilding.Godot.Core.Systems`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### MaxInventorySlots

```csharp
#endregion

        #region Exported Properties

        [Export]
        public int MaxInventorySlots { get; set; } = 100;
```

### MaxInventoryWeight

```csharp
[Export]
        public float MaxInventoryWeight { get; set; } = 1000.0f;
```

### EnableAutoSave

```csharp
[Export]
        public bool EnableAutoSave { get; set; } = true;
```

### AutoSavePath

```csharp
[Export]
        public string AutoSavePath { get; set; } = "user://grid_building_inventory.json";
```

### EnableCrossPlatformCompatibility

```csharp
[Export]
        public bool EnableCrossPlatformCompatibility { get; set; } = true;
```

### CrossPlatformConfigPath

```csharp
[Export(PropertyHint.File, "*.json")]
        public string CrossPlatformConfigPath { get; set; } = "res://config/cross_platform_config.json";
```

### CoreInventory

```csharp
#endregion

        #region Public Properties

        public GridBuildingInventory CoreInventory => _coreInventory;
```

### IsInitialized

```csharp
public bool IsInitialized => _isInitialized;
```

### GridBuildingWrapper

```csharp
public GridBuildingWrapper GridBuildingWrapper => _gridBuildingWrapper;
```


## Methods

### _Ready

```csharp
#endregion

        #region Godot Lifecycle

        public override void _Ready()
        {
            GD.Print("GridBuildingInventoryManager: Initializing...");
            
            InitializeInventorySystem();
            SetupAutoSave();
            LoadCrossPlatformConfiguration();
            
            _isInitialized = true;
            EmitSignal(SignalName.InventorySystemReady);
            
            GD.Print("GridBuildingInventoryManager: Ready!");
        }
```

**Returns:** `void`

### _ExitTree

```csharp
public override void _ExitTree()
        {
            if (EnableAutoSave && _coreInventory != null)
            {
                SaveInventory();
            }
            
            Cleanup();
        }
```

**Returns:** `void`

### AddInventoryItem

```csharp
#endregion

        #region Inventory Operations

        /// <summary>
        /// Add an item to the inventory with optional grid position
        /// </summary>
        public bool AddInventoryItem(InventoryItem item, Vector2I? gridPosition = null)
        {
            if (!_isInitialized || item == null) return false;

            var result = _coreInventory.AddItem(item);
            
            if (result && gridPosition.HasValue)
            {
                EmitSignal(SignalName.InventoryItemAdded, item, gridPosition.Value);
            }

            return result;
        }
```

Add an item to the inventory with optional grid position

**Returns:** `bool`

**Parameters:**
- `InventoryItem item`
- `Vector2I? gridPosition`

### RemoveInventoryItem

```csharp
/// <summary>
        /// Remove an item from the inventory with optional grid position
        /// </summary>
        public bool RemoveInventoryItem(InventoryItem item, Vector2I? gridPosition = null)
        {
            if (!_isInitialized || item == null) return false;

            var result = _coreInventory.RemoveItem(item);
            
            if (result && gridPosition.HasValue)
            {
                EmitSignal(SignalName.InventoryItemRemoved, item, gridPosition.Value);
            }

            return result;
        }
```

Remove an item from the inventory with optional grid position

**Returns:** `bool`

**Parameters:**
- `InventoryItem item`
- `Vector2I? gridPosition`

### GetInventoryItemsByType

```csharp
/// <summary>
        /// Get inventory items filtered by type
        /// </summary>
        public global::Godot.Collections.Array<InventoryItem> GetInventoryItemsByType(string itemType)
        {
            if (!_isInitialized) return new global::Godot.Collections.Array<InventoryItem>();
            return _coreInventory.GetItemsByType(itemType);
        }
```

Get inventory items filtered by type

**Returns:** `global::Godot.Collections.Array<InventoryItem>`

**Parameters:**
- `string itemType`

### HasInventoryCapacity

```csharp
/// <summary>
        /// Check if inventory has capacity for an item
        /// </summary>
        public bool HasInventoryCapacity(InventoryItem item)
        {
            if (!_isInitialized || item == null) return false;
            return _coreInventory.HasCapacityFor(item);
        }
```

Check if inventory has capacity for an item

**Returns:** `bool`

**Parameters:**
- `InventoryItem item`

### GetInventoryData

```csharp
/// <summary>
        /// Get complete inventory data
        /// </summary>
        public global::Godot.Collections.Dictionary GetInventoryData()
        {
            if (!_isInitialized) return new global::Godot.Collections.Dictionary();
            
            var data = _coreInventory.GetInventoryData();
            
            // Add Godot-specific metadata
            data["godot_version"] = Engine.GetVersionInfo();
            data["platform"] = OS.GetName();
            data["cross_platform_compatible"] = EnableCrossPlatformCompatibility;
            
            return data;
        }
```

Get complete inventory data

**Returns:** `global::Godot.Collections.Dictionary`

### SaveInventory

```csharp
public bool SaveInventory()
        {
            if (!_isInitialized || _coreInventory == null) return false;

            try
            {
                var inventoryData = GetInventoryData();
                var jsonString = Json.Stringify(inventoryData);
                
                var file = FileAccess.Open(AutoSavePath, FileAccess.ModeFlags.Write);
                if (file != null)
                {
                    file.StoreString(jsonString);
                    file.Close();
                    
                    GD.Print($"GridBuildingInventoryManager: Inventory saved to {AutoSavePath}");
                    return true;
                }
                else
                {
                    GD.PrintErr($"GridBuildingInventoryManager: Failed to save inventory to {AutoSavePath}");
                    return false;
                }
            }
            catch (System.Exception ex)
            {
                GD.PrintErr($"GridBuildingInventoryManager: Save error - {ex.Message}");
                return false;
            }
        }
```

**Returns:** `bool`

### LoadInventory

```csharp
public bool LoadInventory()
        {
            if (!_isInitialized) return false;

            try
            {
                var file = FileAccess.Open(AutoSavePath, FileAccess.ModeFlags.Read);
                if (file != null)
                {
                    var jsonString = file.GetAsText();
                    file.Close();
                    
                    var data = Json.ParseString(jsonString).AsGodotDictionary();
                    return LoadInventoryFromData(data);
                }
                else
                {
                    GD.Print($"GridBuildingInventoryManager: No saved inventory found at {AutoSavePath}");
                    return false;
                }
            }
            catch (System.Exception ex)
            {
                GD.PrintErr($"GridBuildingInventoryManager: Load error - {ex.Message}");
                return false;
            }
        }
```

**Returns:** `bool`

### GetCrossPlatformInventoryData

```csharp
/// <summary>
        /// Get cross-platform compatible inventory data
        /// </summary>
        public global::Godot.Collections.Dictionary GetCrossPlatformInventoryData()
        {
            if (!_isInitialized || !EnableCrossPlatformCompatibility) 
                return new global::Godot.Collections.Dictionary();

            var data = GetInventoryData();
            
            // Add cross-platform metadata
            data["cross_platform_metadata"] = new global::Godot.Collections.Dictionary
            {
                ["compatible"] = true,
                ["version"] = _crossPlatformConfig?.Get("version", "1.0.0").AsString() ?? "1.0.0",
                ["platform"] = OS.GetName(),
                ["serialization_format"] = _crossPlatformConfig?.Get("serialization_format", "json").AsString() ?? "json"
            };

            return data;
        }
```

Get cross-platform compatible inventory data

**Returns:** `global::Godot.Collections.Dictionary`

### GetPlatformPath

```csharp
#endregion

        #region Utility Methods

        /// <summary>
        /// Get platform-specific file path handling
        /// </summary>
        public string GetPlatformPath(string relativePath)
        {
            if (EnableCrossPlatformCompatibility && _crossPlatformConfig != null)
            {
                var platformConfig = _crossPlatformConfig.Get("platform_specific", new global::Godot.Collections.Dictionary())
                    .AsGodotDictionary().Get(OS.GetName().ToLower(), new global::Godot.Collections.Dictionary()).AsGodotDictionary();
                
                if (platformConfig.Get("use_forward_slashes", false).AsBool() && OS.GetName() == "Windows")
                {
                    return relativePath.Replace("\\", "/");
                }
            }

            return relativePath;
        }
```

Get platform-specific file path handling

**Returns:** `string`

**Parameters:**
- `string relativePath`

### ValidateCrossPlatformCompatibility

```csharp
/// <summary>
        /// Validate cross-platform compatibility
        /// </summary>
        public bool ValidateCrossPlatformCompatibility()
        {
            var issues = new System.Collections.Generic.List<string>();

            // Check file paths
            var testPath = GetPlatformPath("test/path/file.json");
            if (testPath.Contains("\\") && OS.GetName() == "Windows")
            {
                issues.Add("Windows path contains backslashes - may cause issues in shell environments");
            }

            // Check inventory capacity
            if (MaxInventorySlots <= 0 || MaxInventoryWeight <= 0)
            {
                issues.Add("Invalid inventory capacity settings");
            }

            // Check cross-platform config
            if (EnableCrossPlatformCompatibility && _crossPlatformConfig == null)
            {
                issues.Add("Cross-platform compatibility enabled but configuration not loaded");
            }

            if (issues.Count > 0)
            {
                GD.PrintErr("Cross-platform compatibility issues found:");
                foreach (var issue in issues)
                {
                    GD.PrintErr($"  - {issue}");
                }
                return false;
            }

            GD.Print("✅ Cross-platform compatibility validation passed");
            return true;
        }
```

Validate cross-platform compatibility

**Returns:** `bool`

