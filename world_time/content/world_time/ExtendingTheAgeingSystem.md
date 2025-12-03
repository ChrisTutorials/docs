# Making Things Age: A Simple Guide

Want to make crops grow, characters get older, or buildings fall apart? The AgeingSystem handles the "passing time" part - you just need to tell it what should happen at different ages.

## 🎯 The Basic Idea

The AgeingSystem is like a **timer that counts up forever**. You decide what happens when the timer reaches certain numbers.

**Think of it like this:**
- Age 0-1: Seed
- Age 1-3: Sprout  
- Age 3-5: Growing plant
- Age 5-8: Ready to harvest
- Age 8+: Dead plant

The system handles the counting. You handle the "what happens at each age" part.

## 🌱 Making Crops Grow (The Easy Way)

Here's how to make a simple crop that grows through different stages:

```csharp
// Create a crop component
public partial class WheatCrop : Node2D
{
    private AgeingComponent _ageing;
    private Sprite2D _sprite;
    
    public override void _Ready()
    {
        _sprite = GetNode<Sprite2D>("Sprite");
        
        // Create the aging component
        _ageing = new AgeingComponent();
        _ageing.AgeStateChanged += OnCropAged;
        
        AddChild(_ageing);
    }
    
    // This is called whenever the crop gets older
    private void OnCropAged(object sender, AgeStateChangedEventArgs e)
    {
        if (e.NewState == null) return;
        
        float age = e.NewState.Current;
        
        // Change what the crop looks like based on age
        if (age < 1) 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/seed.png");
        else if (age < 3) 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/sprout.png");
        else if (age < 5) 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/growing.png");
        else if (age < 8) 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/mature.png");
        else 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/dead.png");
    }
}
```

That's it! Your wheat crop will now automatically change appearance as it ages.

## 🌾 Adding Growth Factors

Want water and seasons to affect growth? Just add some modifiers:

```csharp
public partial class WheatCrop : Node2D
{
    private AgeingComponent _ageing;
    private Sprite2D _sprite;
    private float _waterLevel = 1.0f;  // How much water the crop has
    private float _growthSpeed = 1.0f; // How fast it grows
    
    public override void _Ready()
    {
        _sprite = GetNode<Sprite2D>("Sprite");
        
        _ageing = new AgeingComponent();
        _ageing.AgeStateChanged += OnCropAged;
        
        AddChild(_ageing);
    }
    
    // Call this when the player waters the crop
    public void WaterCrop()
    {
        _waterLevel = Mathf.Min(1.0f, _waterLevel + 0.3f);
        _growthSpeed = 0.5f + _waterLevel; // More water = faster growth
    }
    
    // Call this every day to simulate water evaporation
    public void DailyUpdate()
    {
        _waterLevel = Mathf.Max(0.0f, _waterLevel - 0.1f);
        _growthSpeed = 0.5f + _waterLevel;
        
        // Apply growth speed to age
        float effectiveAge = _ageing.AgeState.Current * _growthSpeed;
        UpdateCropAppearance(effectiveAge);
    }
    
    private void UpdateCropAppearance(float age)
    {
        if (age < 1) 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/seed.png");
        else if (age < 3) 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/sprout.png");
        else if (age < 5) 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/growing.png");
        else if (age < 8) 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/mature.png");
        else 
            _sprite.Texture = GD.Load<Texture2D>("res://crops/wheat/dead.png");
    }
    
    private void OnCropAged(object sender, AgeStateChangedEventArgs e)
    {
        DailyUpdate(); // Update growth factors when age changes
    }
}
```

## 👶 Making Characters Age

Want NPCs to get older and change appearance over time?

```csharp
public partial class NPC : Node2D
{
    private AgeingComponent _ageing;
    private Sprite2D _sprite;
    private float _moveSpeed = 100.0f;
    
    public override void _Ready()
    {
        _sprite = GetNode<Sprite2D>("Sprite");
        
        _ageing = new AgeingComponent();
        _ageing.AgeStateChanged += OnCharacterAged;
        
        AddChild(_ageing);
    }
    
    private void OnCharacterAged(object sender, AgeStateChangedEventArgs e)
    {
        if (e.NewState == null) return;
        
        float age = e.NewState.Current;
        
        // Change appearance based on age
        if (age < 18)
        {
            _sprite.Texture = GD.Load<Texture2D>("res://characters/child.png");
            _moveSpeed = 120.0f; // Kids run faster
        }
        else if (age < 30)
        {
            _sprite.Texture = GD.Load<Texture2D>("res://characters/young_adult.png");
            _moveSpeed = 100.0f;
        }
        else if (age < 50)
        {
            _sprite.Texture = GD.Load<Texture2D>("res://characters/adult.png");
            _moveSpeed = 90.0f;
        }
        else if (age < 70)
        {
            _sprite.Texture = GD.Load<Texture2D>("res://characters/elder.png");
            _moveSpeed = 70.0f;
        }
        else
        {
            _sprite.Texture = GD.Load<Texture2D>("res://characters/senior.png");
            _moveSpeed = 50.0f; // Seniors move slower
        }
    }
    
    public float GetMoveSpeed() => _moveSpeed;
}
```

## 🏠 Making Buildings Deteriorate

Want buildings to fall apart over time if not maintained?

```csharp
public partial class Building : Node2D
{
    private AgeingComponent _ageing;
    private Sprite2D _sprite;
    private float _condition = 100.0f;
    
    public override void _Ready()
    {
        _sprite = GetNode<Sprite2D>("Sprite");
        
        _ageing = new AgeingComponent();
        _ageing.AgeStateChanged += OnBuildingAged;
        
        AddChild(_ageing);
    }
    
    private void OnBuildingAged(object sender, AgeStateChangedEventArgs e)
    {
        if (e.NewState == null) return;
        
        float age = e.NewState.Current;
        
        // Buildings lose condition over time
        _condition = Mathf.Max(0, 100.0f - (age * 5.0f));
        
        // Change appearance based on condition
        if (_condition > 80)
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_new.png");
        else if (_condition > 60)
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_good.png");
        else if (_condition > 40)
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_fair.png");
        else if (_condition > 20)
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_poor.png");
        else
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_ruined.png");
    }
    
    // Player can repair buildings
    public void Repair(float amount)
    {
        _condition = Mathf.Min(100.0f, _condition + amount);
        UpdateAppearance();
    }
    
    private void UpdateAppearance()
    {
        if (_condition > 80)
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_new.png");
        else if (_condition > 60)
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_good.png");
        else if (_condition > 40)
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_fair.png");
        else if (_condition > 20)
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_poor.png");
        else
            _sprite.Texture = GD.Load<Texture2D>("res://buildings/house_ruined.png");
    }
    
    public bool IsRuined() => _condition <= 20;
}
```

## 🎮 Quick Tips for Game Development

### Making It Work in Your Game

```csharp
// In your main game scene
public partial class GameManager : Node
{
    public override void _Ready()
    {
        // Connect to world time system
        var worldTime = GetNode<TimeManagerNode>("TimeManager");
        worldTime.DayChanged += OnNewDay;
    }
    
    private void OnNewDay(int newDay)
    {
        // Make all crops age by 1 day
        var crops = GetTree().GetNodesInGroup("crops");
        foreach (Node crop in crops)
        {
            if (crop is WheatCrop wheatCrop)
            {
                wheatCrop.DailyUpdate();
            }
        }
    }
}
```

### Using Resources for Easy Configuration

```csharp
// Create a resource file for different crop types
[Resource]
public class CropData : Resource
{
    [Export] public string CropName { get; set; }
    [Export] public float[] GrowthStages { get; set; } = { 1, 3, 5, 8 };
    [Export] public string[] StageSprites { get; set; } = { "seed", "sprout", "growing", "mature", "dead" };
    [Export] public float BaseGrowthSpeed { get; set; } = 1.0f;
}

// Use it in your crop
public partial class GenericCrop : Node2D
{
    [Export] public CropData? CropData { get; set; }
    
    private void UpdateAppearance(float age)
    {
        if (CropData == null) return;
        
        for (int i = 0; i < CropData.GrowthStages.Length; i++)
        {
            if (age < CropData.GrowthStages[i])
            {
                _sprite.Texture = GD.Load<Texture2D>($"res://crops/{CropData.StageSprites[i]}.png");
                break;
            }
        }
    }
}
```

### Saving and Loading

The AgeingSystem automatically handles saving and loading:

```csharp
// Save the game
public void SaveGame()
{
    var saveData = new Dictionary<string, string>();
    
    // Save all aging objects
    var crops = GetTree().GetNodesInGroup("crops");
    foreach (Node crop in crops)
    {
        if (crop is WheatCrop wheatCrop)
        {
            var cropData = wheatCrop._ageing.ToDict();
            saveData[$"crop_{wheatCrop.Name}"] = Json.Stringify(cropData);
        }
    }
    
    // Write to file
    var file = FileAccess.Open("user://savegame.json", FileAccess.ModeFlags.Write);
    file.StoreString(Json.Stringify(saveData));
    file.Close();
}

// Load the game
public void LoadGame()
{
    var file = FileAccess.Open("user://savegame.json", FileAccess.ModeFlags.Read);
    var saveData = Json.ParseString(file.GetAsText()).AsGodotDictionary();
    file.Close();
    
    // Restore all aging objects
    foreach (var key in saveData.Keys)
    {
        if (key.ToString().StartsWith("crop_"))
        {
            var cropName = key.ToString().Replace("crop_", "");
            var cropData = Json.ParseString(saveData[key].ToString()).AsGodotDictionary();
            
            var crop = GetNode<WheatCrop>(cropName);
            if (crop != null)
            {
                crop._ageing.FromDict(cropData);
            }
        }
    }
}
```

## 📚 Common Patterns

### 1. Different Growth Speeds for Different Crops

```csharp
public partial class CornCrop : WheatCrop  // Reuse wheat crop code
{
    public override void _Ready()
    {
        base._Ready();
        
        // Corn grows slower than wheat
        _growthSpeed = 0.7f;  // 70% of normal speed
    }
}
```

### 2. Seasonal Effects

```csharp
public partial class SeasonalCrop : WheatCrop
{
    protected override void DailyUpdate()
    {
        base.DailyUpdate();
        
        // Get current season from your world time system
        var season = GetCurrentSeason();
        
        // Adjust growth based on season
        switch (season)
        {
            case Season.Spring:
                _growthSpeed = 1.2f;  // Spring bonus
                break;
            case Season.Summer:
                _growthSpeed = 1.5f;  // Summer bonus
                break;
            case Season.Fall:
                _growthSpeed = 0.8f;  // Fall penalty
                break;
            case Season.Winter:
                _growthSpeed = 0.3f;  // Winter penalty
                break;
        }
    }
}
```

### 3. Random Variations

```csharp
public partial class RandomCrop : WheatCrop
{
    public override void _Ready()
    {
        base._Ready();
        
        // Add some randomness to make each crop unique
        _growthSpeed *= GD.RandfRange(0.8f, 1.2f);
    }
}
```

## 🐛 Common Problems and Solutions

### Problem: My crops aren't aging!
**Solution:** Make sure your TimeManager is running and connected to the aging system.

```csharp
// In your TimeManager
public override void _Process(double delta)
{
    base._Process(delta);
    
    // Update aging system
    var worldAgeSystem = GetNode<WorldAgeSystemNode>("WorldAgeSystem");
    worldAgeSystem.Update((float)delta);
}
```

### Problem: Crops age too fast/slow
**Solution:** Adjust the time scale in your TimeManager settings.

```csharp
// Make time pass slower
timeScale.DeltaMultiplier = 500.0f;  // Default is 1000.0f

// Make time pass faster  
timeScale.DeltaMultiplier = 2000.0f;
```

### Problem: Crops don't save their age
**Solution:** Make sure you're calling the save/load methods correctly.

```csharp
// Save
var cropData = crop._ageing.ToDict();

// Load
crop._ageing.FromDict(cropData);
```

## 🎯 What to Build Next?

Now that you know the basics, try these ideas:

1. **Fruit Trees** - Trees that produce fruit every season
2. **Animal Aging** - Animals that grow up and eventually die
3. **Tool Wear** - Tools that break after use and need repair
4. **World Events** - Special things that happen at certain world ages
5. **Character Relationships** - NPCs that form relationships over time

## 📖 Summary

The AgeingSystem is simple:
1. **Add AgeingComponent** to anything that should age
2. **Listen for AgeStateChanged** events
3. **Change appearance/behavior** based on the age
4. **Save/load** automatically works

That's it! You now have everything you need to make crops grow, characters age, buildings deteriorate, and anything else you can imagine.

**Remember:** The system handles the counting, you handle what happens at each age. Keep it simple and have fun building your game!
