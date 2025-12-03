# Unity Integration Guide

## 🎮 Overview

This guide covers integrating the ItemDrops plugin into Unity games. The Unity integration provides ScriptableObject-based configuration, MonoBehaviour runtime components, and Unity event system integration.

## 📦 Installation

### Package Setup
1. Copy the `ItemDrops` folder to your Unity project's `Packages/` directory
2. Open Package Manager and select "Add package from disk"
3. Navigate to the `ItemDrops/package.json` file
4. Configure the ItemDrops settings in Project Settings

### Dependencies
- Unity 2022.3 LTS or later
- No external dependencies required
- Compatible with Unity's Entity Component System (ECS)

## 🏗️ Architecture

### Unity-Specific Components
```
ItemDrops.Unity/
├── Assets/
│   ├── DropTableAsset.cs        # ScriptableObject for drop configuration
│   ├── DropData.cs              # ScriptableObject for individual drops
│   └── DropConditionAsset.cs    # ScriptableObject for drop conditions
├── Components/
│   ├── ItemDropComponent.cs     # MonoBehaviour for dropped items
│   ├── EnemyDrops.cs           # Enemy drop component
│   ├── Health.cs                # Health component
│   ├── Level.cs                 # Level component
│   └── EnemyData.cs             # Enemy metadata component
└── Managers/
    └── ItemDropsManager.cs      # Singleton drop manager
```

### Integration Pattern
- **ScriptableObjects**: Configuration data stored as Unity ScriptableObjects
- **MonoBehaviours**: Runtime behavior as Unity components
- **Events**: UnityEvent-based communication
- **Prefabs**: Reusable drop item prefabs

## 🚀 Quick Start

### 1. Create a Drop Table Asset
```csharp
// Create a new DropTableAsset
[CreateAssetMenu(fileName = "EnemyDrops", menuName = "ItemDrops/Drop Table")]
public class DropTableAsset : ScriptableObject
{
    [SerializeField] private List<DropData> drops = new();
    [SerializeField] private int minDrops = 1;
    [SerializeField] private int maxDrops = 3;
    [SerializeField] private float dropChance = 0.8f;
    
    // Methods for drop generation
    public List<GameObject> GenerateDrops(Vector3 position)
    public DropTableValidationResult Validate()
}
```

### 2. Configure Enemy Drops
```csharp
public class Enemy : MonoBehaviour
{
    [SerializeField] private DropTableAsset dropTable;
    [SerializeField] private EnemyDrops enemyDrops;
    
    private void Start()
    {
        // Configure drop behavior
        enemyDrops.DropTable = dropTable;
        enemyDrops.AutoGenerateOnDeath = true;
    }
    
    private void Die()
    {
        // Trigger drop generation
        enemyDrops.GenerateDrops();
    }
}
```

### 3. Handle Drop Events
```csharp
public class Player : MonoBehaviour
{
    private void Start()
    {
        // Subscribe to drop events
        ItemDropsManager.OnDropGenerated += HandleDropGenerated;
        ItemDropsManager.OnDropCollected += HandleDropCollected;
    }
    
    private void HandleDropGenerated(string itemId, Vector3 position)
    {
        Debug.Log($"Drop generated: {itemId} at {position}");
    }
    
    private void HandleDropCollected(string itemId, GameObject collector)
    {
        Debug.Log($"Drop collected: {itemId} by {collector.name}");
    }
}
```

## 📋 Asset Configuration

### DropTableAsset
```csharp
[CreateAssetMenu(fileName = "DropTable", menuName = "ItemDrops/Drop Table")]
public class DropTableAsset : ScriptableObject, IDropTable
{
    [Header("Drop Configuration")]
    [SerializeField] private List<DropData> drops = new();
    [SerializeField] private int minDrops = 1;
    [SerializeField] private int maxDrops = 1;
    [SerializeField, Range(0f, 1f)] private float dropChance = 1f;
    
    [Header("Advanced Settings")]
    [SerializeField] private bool guaranteeRareDrops = false;
    [SerializeField] private float luckMultiplier = 1f;
    
    // Core interface implementation
    public IReadOnlyList<IDrop> Drops => GetCoreDrops();
    public int MinDrops => minDrops;
    public int MaxDrops => maxDrops;
    public float DropChance => dropChance;
    
    // Methods
    public List<GameObject> GenerateDrops(Vector3 position)
    public List<GameObject> GenerateDrops(Vector3 position, LootContext context)
    public DropTableValidationResult Validate()
}
```

### DropData
```csharp
[Serializable]
public class DropData
{
    [Header("Item Configuration")]
    public string itemId;
    public float weight = 1f;
    public ItemRarity rarity = ItemRarity.Common;
    
    [Header("Quantity")]
    public int minQuantity = 1;
    public int maxQuantity = 1;
    
    [Header("Conditions")]
    public List<DropConditionAsset> conditions = new();
    
    [Header("Prefab")]
    public GameObject itemPrefab;
}
```

### DropConditionAsset
```csharp
[CreateAssetMenu(fileName = "DropCondition", menuName = "ItemDrops/Drop Condition")]
public class DropConditionAsset : ScriptableObject
{
    [Header("Condition Type")]
    public DropConditionType conditionType;
    
    [Header("Parameters")]
    public string stringValue;
    public int intValue;
    public int intValue2;
    public float floatValue;
    
    public IDropCondition CreateCondition()
    {
        return conditionType switch
        {
            DropConditionType.MinimumLevel => new MinimumLevelCondition(intValue),
            DropConditionType.LevelRange => new LevelRangeCondition(intValue, intValue2),
            DropConditionType.EntityType => new EntityTypeCondition(stringValue),
            DropConditionType.Luck => new LuckCondition(floatValue),
            DropConditionType.RandomChance => new RandomChanceCondition(floatValue),
            _ => null
        };
    }
}
```

## 🎯 Runtime Components

### ItemDropsManager (Singleton)
```csharp
public class ItemDropsManager : MonoBehaviour
{
    public static ItemDropsManager Instance { get; private set; }
    
    [Header("Default Tables")]
    [SerializeField] private DropTableAsset defaultEnemyDrops;
    [SerializeField] private DropTableAsset defaultBossDrops;
    [SerializeField] private DropTableAsset defaultChestDrops;
    
    [Header("Global Settings")]
    [SerializeField] private float globalLuckModifier = 1f;
    [SerializeField] private bool enableLogging = true;
    
    // Events
    public static UnityEvent<string, Vector3> OnDropGenerated = new();
    public static UnityEvent<string, GameObject> OnDropCollected = new();
    public static UnityEvent<string, bool> OnDropTableValidated = new();
    
    // Methods
    public void RegisterDropTable(string id, DropTableAsset dropTable)
    public DropTableAsset GetDropTable(string id)
    public List<GameObject> GenerateDrops(string tableId, Vector3 position)
    public DropStatistics GetStatistics(string tableId, LootContext context = null)
}
```

### EnemyDrops Component
```csharp
public class EnemyDrops : MonoBehaviour
{
    [Header("Drop Configuration")]
    [SerializeField] private DropTableAsset dropTable;
    [SerializeField] private int levelOverride = 0;
    [SerializeField] private string entityTypeOverride = "";
    
    [Header("Behavior")]
    [SerializeField] private float luckModifier = 1f;
    [SerializeField] private bool autoGenerateOnDeath = true;
    [SerializeField] private float dropDelay = 0.5f;
    [SerializeField] private bool randomOffset = true;
    [SerializeField] private float maxOffsetDistance = 2f;
    
    [Header("Effects")]
    [SerializeField] private GameObject deathEffect;
    [SerializeField] private AudioClip deathSound;
    
    // Methods
    public List<GameObject> GenerateDrops()
    public void GenerateDropsWithDelay()
    public DropStatistics GetStatistics()
    public void SetDropTable(DropTableAsset newDropTable)
    
    // Events
    public UnityEvent<List<GameObject>> OnDropsGenerated = new();
}
```

### ItemDropComponent
```csharp
public class ItemDropComponent : MonoBehaviour
{
    [Header("Item Data")]
    [SerializeField] private string itemId;
    [SerializeField] private ItemRarity rarity = ItemRarity.Common;
    [SerializeField] private int quantity = 1;
    
    [Header("Visual Settings")]
    [SerializeField] private bool showRarityGlow = true;
    [SerializeField] private Color glowColor = Color.white;
    [SerializeField] private float glowIntensity = 1f;
    
    [Header("Pickup Settings")]
    [SerializeField] private bool autoCollect = false;
    [SerializeField] private float collectionRange = 2f;
    [SerializeField] private LayerMask collectableLayers = -1;
    
    [Header("Effects")]
    [SerializeField] private GameObject pickupEffect;
    [SerializeField] private AudioClip pickupSound;
    [SerializeField] private float rotationSpeed = 50f;
    
    // Methods
    public void Configure(DropResult dropResult)
    public void Collect(GameObject collector)
    public void PlayCollectionEffects()
    
    // Events
    public UnityEvent<string, GameObject> OnCollected = new();
    public UnityEvent<string> OnHoverStart = new();
    public UnityEvent<string> OnHoverEnd = new();
}
```

## 🎨 Visual Effects

### Rarity-Based Visuals
```csharp
public static class RarityVisuals
{
    public static Color GetColor(ItemRarity rarity)
    {
        return rarity switch
        {
            ItemRarity.Common => Color.white,
            ItemRarity.Uncommon => Color.green,
            ItemRarity.Rare => Color.blue,
            ItemRarity.Epic => Color.magenta,
            ItemRarity.Legendary => Color.yellow,
            _ => Color.white
        };
    }
    
    public static float GetGlowIntensity(ItemRarity rarity)
    {
        return rarity switch
        {
            ItemRarity.Common => 0.5f,
            ItemRarity.Uncommon => 0.7f,
            ItemRarity.Rare => 1.0f,
            ItemRarity.Epic => 1.2f,
            ItemRarity.Legendary => 1.5f,
            _ => 0.5f
        };
    }
}
```

### Particle Effects
```csharp
public class DropEffects : MonoBehaviour
{
    [Header("Particle Systems")]
    [SerializeField] private ParticleSystem commonEffect;
    [SerializeField] private ParticleSystem uncommonEffect;
    [SerializeField] private ParticleSystem rareEffect;
    [SerializeField] private ParticleSystem epicEffect;
    [SerializeField] private ParticleSystem legendaryEffect;
    
    [Header("Audio")]
    [SerializeField] private AudioSource audioSource;
    [SerializeField] private AudioClip[] pickupSounds;
    
    public void PlayDropEffect(Vector3 position, ItemRarity rarity)
    {
        var effect = GetEffectForRarity(rarity);
        if (effect != null)
        {
            var instance = Instantiate(effect, position, Quaternion.identity);
            Destroy(instance, effect.main.duration);
        }
    }
    
    private ParticleSystem GetEffectForRarity(ItemRarity rarity)
    {
        return rarity switch
        {
            ItemRarity.Common => commonEffect,
            ItemRarity.Uncommon => uncommonEffect,
            ItemRarity.Rare => rareEffect,
            ItemRarity.Epic => epicEffect,
            ItemRarity.Legendary => legendaryEffect,
            _ => commonEffect
        };
    }
}
```

## 📊 Advanced Usage

### Conditional Drops
```csharp
// Create level-based condition
var levelCondition = ScriptableObject.CreateInstance<DropConditionAsset>();
levelCondition.conditionType = DropConditionType.MinimumLevel;
levelCondition.intValue = 10;

// Create entity type condition
var entityCondition = ScriptableObject.CreateInstance<DropConditionAsset>();
entityCondition.conditionType = DropConditionType.EntityType;
entityCondition.stringValue = "dragon";

// Add to drop data
dropData.conditions.Add(levelCondition);
dropData.conditions.Add(entityCondition);
```

### Custom Drop Generation
```csharp
public class CustomDropGenerator : MonoBehaviour
{
    [SerializeField] private DropTableAsset dropTable;
    
    private void Start()
    {
        // Generate drops with custom context
        var context = new LootContext
        {
            Level = 25,
            EntityType = "boss",
            LuckModifier = 2.0f
        };
        
        var drops = dropTable.GenerateDrops(transform.position, context);
        
        foreach (var drop in drops)
        {
            // Parent drops to this object
            drop.transform.parent = transform;
        }
    }
}
```

### Loot Generation with Modifiers
```csharp
// Create custom loot generator
var generator = new LootGenerator();
generator.AddModifier(new LuckModifier(1.5f));
generator.AddModifier(new LevelBonusModifier(20, 2.0f));
generator.AddModifier(new RarityFilterModifier(ItemRarity.Rare));

// Generate enhanced loot
var settings = new LootGenerationSettings
{
    DropTable = dropTable,
    Context = context
};

var dropResults = generator.GenerateLoot(settings);
var gameObjects = ItemDropsManager.Instance.SpawnDrops(dropResults, transform.position);
```

## 🧪 Testing in Unity

### Unit Tests with Unity Test Framework
```csharp
[Test]
public void TestDropGeneration()
{
    // Create test drop table asset
    var dropTable = ScriptableObject.CreateInstance<DropTableAsset>();
    dropTable.drops.Add(new DropData { itemId = "test_item", weight = 1.0f });
    
    // Generate drops
    var drops = dropTable.GenerateDrops(Vector3.zero);
    
    // Assert results
    Assert.AreEqual(1, drops.Count);
    Assert.AreEqual("test_item", drops[0].GetComponent<ItemDropComponent>().ItemId);
}
```

### Integration Tests
```csharp
[UnityTest]
public IEnumerator TestEnemyDropGeneration()
{
    // Create test enemy
    var enemy = new GameObject("TestEnemy");
    enemy.AddComponent<Enemy>();
    var enemyDrops = enemy.AddComponent<EnemyDrops>();
    enemyDrops.DropTable = LoadDropTable("TestEnemy");
    
    // Simulate death
    enemyDrops.GenerateDrops();
    
    // Wait for drop generation
    yield return new WaitForSeconds(0.1f);
    
    // Verify drops generated
    var drops = GameObject.FindGameObjectsWithTag("ItemDrop");
    Assert.IsTrue(drops.Length > 0);
}
```

## 🔧 Performance Optimization

### Object Pooling
```csharp
public class DropObjectPool : MonoBehaviour
{
    [SerializeField] private GameObject dropPrefab;
    [SerializeField] private int poolSize = 50;
    
    private readonly Queue<GameObject> _pool = new();
    
    private void Start()
    {
        // Pre-populate pool
        for (int i = 0; i < poolSize; i++)
        {
            var drop = Instantiate(dropPrefab);
            drop.SetActive(false);
            _pool.Enqueue(drop);
        }
    }
    
    public GameObject Get()
    {
        if (_pool.Count > 0)
        {
            var drop = _pool.Dequeue();
            drop.SetActive(true);
            return drop;
        }
        
        return Instantiate(dropPrefab);
    }
    
    public void Return(GameObject drop)
    {
        drop.SetActive(false);
        _pool.Enqueue(drop);
    }
}
```

### Batch Processing
```csharp
public class DropBatchProcessor : MonoBehaviour
{
    [SerializeField] private int batchSize = 10;
    private readonly List<ItemDropComponent> _pendingDrops = new();
    
    private void Update()
    {
        if (_pendingDrops.Count >= batchSize)
        {
            ProcessBatch();
        }
    }
    
    private void ProcessBatch()
    {
        foreach (var drop in _pendingDrops)
        {
            // Process drop physics, effects, etc.
            drop.ProcessPhysics();
        }
        
        _pendingDrops.Clear();
    }
}
```

## 🐛 Common Issues & Solutions

### Drop Generation Not Working
**Problem**: Drops not appearing when expected
**Solution**:
1. Verify drop table asset is properly configured
2. Check that prefabs are assigned correctly
3. Ensure ItemDropsManager is in scene
4. Verify event subscriptions

### Performance Issues
**Problem**: Lag when many drops are generated
**Solution**:
1. Use object pooling for drop prefabs
2. Limit simultaneous active drops
3. Optimize particle effects
4. Use spatial partitioning for collision detection

### Prefab Loading Issues
**Problem**: Drop prefabs not instantiating correctly
**Solution**:
1. Check prefab references in DropData
2. Ensure prefabs have ItemDropComponent
3. Verify prefab settings and layers
4. Check for missing components

### Serialization Issues
**Problem**: ScriptableObject data not saving
**Solution**:
1. Use [SerializeField] on all fields
2. Mark classes as [Serializable]
3. Ensure proper field types
4. Check for circular references

## 📚 Best Practices

### Asset Management
- Organize drop tables in dedicated folders
- Use consistent naming conventions
- Create template assets for common configurations
- Use addressable assets for large projects

### Component Design
- Keep components focused on single responsibilities
- Use proper Unity component lifecycle
- Implement proper cleanup in OnDestroy
- Use events for loose coupling

### Performance
- Pool frequently instantiated objects
- Use object pooling for drops and effects
- Optimize collision detection with layers
- Use coroutines for delayed operations

### Debugging
- Enable debug logging in ItemDropsManager
- Use Unity's Profiler for performance analysis
- Create debug visualization tools
- Test with different drop rates and quantities

## 🎨 Editor Integration

### Custom Editors
```csharp
[CustomEditor(typeof(DropTableAsset))]
public class DropTableAssetEditor : Editor
{
    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();
        
        var dropTable = (DropTableAsset)target;
        
        if (GUILayout.Button("Validate"))
        {
            var result = dropTable.Validate();
            if (!result.IsValid)
            {
                foreach (var error in result.Errors)
                {
                    EditorGUILayout.HelpBox(error, MessageType.Error);
                }
            }
            else
            {
                EditorGUILayout.HelpBox("Drop table is valid!", MessageType.Info);
            }
        }
        
        if (GUILayout.Button("Generate Test Drops"))
        {
            var drops = dropTable.GenerateDrops(Vector3.zero);
            Debug.Log($"Generated {drops.Count} test drops");
        }
    }
}
```

### Property Drawers
```csharp
[CustomPropertyDrawer(typeof(ItemRarity))]
public class ItemRarityPropertyDrawer : PropertyDrawer
{
    public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
    {
        property.enumValueIndex = EditorGUI.Popup(position, label.text, property.enumValueIndex, property.enumDisplayNames);
    }
}
```

---

*This guide evolves with the Unity integration development*  
*Last Updated: November 2025*  
*Unity Version: 2022.3 LTS+*
