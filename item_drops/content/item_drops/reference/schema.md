# Configuration Schema Reference

## Complete JSON/YAML Schema

This document provides the complete schema reference for data-driven drop table configuration.

## Root Schema

```json
{
  "minDrops": "integer (1)",
  "maxDrops": "integer (1)",
  "dropChance": "float (0.0-1.0)",
  "drops": "array of DropConfiguration",
  "inherits": "string (optional)",
  "metadata": "object (optional)"
}
```

## Drop Configuration Schema

```json
{
  "itemId": "string (required)",
  "weight": "float (1.0)",
  "rarity": "string ('Common'|'Uncommon'|'Rare'|'Epic'|'Legendary')",
  "minQuantity": "integer (1)",
  "maxQuantity": "integer (1)",
  "conditions": "array of ConditionConfiguration",
  "metadata": "object (optional)"
}
```

## Condition Configuration Schema

```json
{
  "type": "string (required)",
  "value": "integer",
  "value2": "integer",
  "stringValue": "string",
  "floatValue": "float"
}
```

## Detailed Property Reference

### Drop Table Properties

#### `minDrops` (integer)
- **Default:** `1`
- **Range:** `0` to `1000`
- **Description:** Minimum number of drops to generate
- **Example:** `"minDrops": 2`

#### `maxDrops` (integer)
- **Default:** `1`
- **Range:** `0` to `1000`
- **Description:** Maximum number of drops to generate
- **Constraint:** Must be >= `minDrops`
- **Example:** `"maxDrops": 5`

#### `dropChance` (float)
- **Default:** `1.0`
- **Range:** `0.0` to `1.0`
- **Description:** Overall probability that any drops occur
- **Example:** `"dropChance": 0.8` (80% chance)

#### `drops` (array)
- **Required:** Yes
- **Description:** Array of possible drops
- **Empty:** Valid (no drops will be generated)
- **Example:** See Drop Configuration below

#### `inherits` (string)
- **Required:** No
- **Description:** Path to parent drop table to inherit from
- **Format:** Relative path without extension
- **Example:** `"inherits": "base_enemy_loot"`

#### `metadata` (object)
- **Required:** No
- **Description:** Custom metadata for the drop table
- **Format:** Key-value pairs
- **Example:**
```json
"metadata": {
  "author": "Game Designer",
  "version": "1.2",
  "notes": "Balanced for level 10-15",
  "tags": ["enemy", "goblin", "level_10"]
}
```

### Drop Configuration Properties

#### `itemId` (string)
- **Required:** Yes
- **Format:** String identifier matching your item database
- **Characters:** Alphanumeric, underscore, hyphen
- **Example:** `"itemId": "health_potion_small"`

#### `weight` (float)
- **Default:** `1.0`
- **Range:** `0.001` to `1000.0`
- **Description:** Selection weight in weighted random selection
- **Higher values** = more likely to be selected
- **Example:** `"weight": 50.0`

#### `rarity` (string)
- **Default:** `"Common"`
- **Values:** `"Common"`, `"Uncommon"`, `"Rare"`, `"Epic"`, `"Legendary"`
- **Case-insensitive:** `"common"` and `"Common"` both valid
- **Description:** Item rarity tier (for display and filtering)
- **Example:** `"rarity": "Rare"`

#### `minQuantity` (integer)
- **Default:** `1`
- **Range:** `0` to `1000`
- **Description:** Minimum quantity of this item to drop
- **Constraint:** Must be <= `maxQuantity`
- **Example:** `"minQuantity": 2`

#### `maxQuantity` (integer)
- **Default:** `1`
- **Range:** `0` to `1000`
- **Description:** Maximum quantity of this item to drop
- **Constraint:** Must be >= `minQuantity`
- **Example:** `"maxQuantity": 5`

#### `conditions` (array)
- **Required:** No
- **Description:** Array of conditions that must be met for this drop to occur
- **Logic:** All conditions must be satisfied (AND logic)
- **Empty:** Always satisfied
- **Example:** See Condition Configuration below

#### `metadata` (object)
- **Required:** No
- **Description:** Custom metadata for this specific drop
- **Example:**
```json
"metadata": {
  "source": "boss_drop",
  "tooltip": "Rare item from the dragon boss",
  "sellPrice": 1000,
  "customTags": ["fire", "magic"]
}
```

### Condition Configuration Properties

#### `type` (string)
- **Required:** Yes
- **Values:** See Condition Types below
- **Case-sensitive:** Use exact type names
- **Description:** Type of condition to check

#### `value` (integer)
- **Default:** `0`
- **Description:** Integer value for the condition
- **Used by:** `minimumLevel`, `levelRange`

#### `value2` (integer)
- **Default:** `0`
- **Description:** Second integer value for range conditions
- **Used by:** `levelRange`

#### `stringValue` (string)
- **Default:** `""`
- **Description:** String value for the condition
- **Used by:** `entityType`, `timeOfDay`, `customData`

#### `floatValue` (float)
- **Default:** `0.0`
- **Description:** Float value for the condition
- **Used by:** `luck`, `randomChance`, `customData`

## Condition Types

### `minimumLevel`
Requires the context to have a minimum level.

**Properties:**
- `value`: Minimum level required

**Example:**
```json
{
  "type": "minimumLevel",
  "value": 10
}
```

### `levelRange`
Requires the context level to be within a range.

**Properties:**
- `value`: Minimum level (inclusive)
- `value2`: Maximum level (inclusive)

**Example:**
```json
{
  "type": "levelRange",
  "value": 5,
  "value2": 15
}
```

### `entityType`
Requires a specific entity type.

**Properties:**
- `stringValue`: Entity type identifier

**Example:**
```json
{
  "type": "entityType",
  "stringValue": "goblin"
}
```

### `luck`
Requires minimum luck value.

**Properties:**
- `floatValue`: Minimum luck required (0.0-1.0)

**Example:**
```json
{
  "type": "luck",
  "floatValue": 0.5
}
```

### `randomChance`
Passes with a random probability.

**Properties:**
- `floatValue`: Probability of passing (0.0-1.0)

**Example:**
```json
{
  "type": "randomChance",
  "floatValue": 0.1
}
```

### `timeOfDay`
Requires specific time of day.

**Properties:**
- `stringValue`: Time identifier ("day", "night", "dawn", "dusk")

**Example:**
```json
{
  "type": "timeOfDay",
  "stringValue": "night"
}
```

### `customData`
Custom condition based on context data.

**Properties:**
- `stringValue`: Data key to check
- `floatValue`: Required value

**Example:**
```json
{
  "type": "customData",
  "stringValue": "player_faction_reputation",
  "floatValue": 0.8
}
```

## Complete Examples

### Simple Drop Table
```json
{
  "minDrops": 1,
  "maxDrops": 2,
  "dropChance": 0.9,
  "drops": [
    {
      "itemId": "gold_coin",
      "weight": 100,
      "rarity": "Common",
      "minQuantity": 5,
      "maxQuantity": 20
    },
    {
      "itemId": "health_potion",
      "weight": 30,
      "rarity": "Common",
      "minQuantity": 1,
      "maxQuantity": 2
    }
  ]
}
```

### Complex Drop Table with Conditions
```json
{
  "minDrops": 2,
  "maxDrops": 4,
  "dropChance": 0.8,
  "metadata": {
    "author": "Lead Designer",
    "difficulty": "medium",
    "levelRange": "10-20"
  },
  "drops": [
    {
      "itemId": "health_potion",
      "weight": 50,
      "rarity": "Common",
      "minQuantity": 1,
      "maxQuantity": 3,
      "conditions": [
        {
          "type": "minimumLevel",
          "value": 5
        }
      ]
    },
    {
      "itemId": "magic_sword",
      "weight": 5,
      "rarity": "Rare",
      "minQuantity": 1,
      "maxQuantity": 1,
      "conditions": [
        {
          "type": "minimumLevel",
          "value": 10
        },
        {
          "type": "randomChance",
          "floatValue": 0.2
        }
      ],
      "metadata": {
        "damage": 15,
        "element": "fire"
      }
    },
    {
      "itemId": "legendary_artifact",
      "weight": 1,
      "rarity": "Legendary",
      "minQuantity": 1,
      "maxQuantity": 1,
      "conditions": [
        {
          "type": "levelRange",
          "value": 20,
          "value2": 30
        },
        {
          "type": "luck",
          "floatValue": 0.9
        },
        {
          "type": "timeOfDay",
          "stringValue": "night"
        }
      ]
    }
  ]
}
```

### Inheritance Example

#### Base Table (`base_enemy_loot.json`)
```json
{
  "minDrops": 1,
  "maxDrops": 2,
  "dropChance": 0.7,
  "drops": [
    {
      "itemId": "gold_coin",
      "weight": 100,
      "rarity": "Common",
      "minQuantity": 5,
      "maxQuantity": 15
    }
  ]
}
```

#### Derived Table (`goblin_loot.json`)
```json
{
  "inherits": "base_enemy_loot",
  "minDrops": 2,
  "drops": [
    {
      "itemId": "goblin_ear",
      "weight": 30,
      "rarity": "Common",
      "minQuantity": 1,
      "maxQuantity": 2
    },
    {
      "itemId": "rusty_dagger",
      "weight": 10,
      "rarity": "Uncommon",
      "minQuantity": 1,
      "maxQuantity": 1,
      "conditions": [
        {
          "type": "minimumLevel",
          "value": 3
        }
      ]
    }
  ]
}
```

## YAML Format

The same schema works with YAML (coming soon):

```yaml
minDrops: 1
maxDrops: 3
dropChance: 0.8
drops:
  - itemId: health_potion
    weight: 50
    rarity: Common
    minQuantity: 1
    maxQuantity: 2
    conditions:
      - type: minimumLevel
        value: 1
metadata:
  author: Game Designer
  version: 1.0
```

## Validation Rules

### Required Fields
- `drops` array cannot be empty if `dropChance` > 0
- Each drop must have `itemId`
- Each condition must have `type`

### Value Constraints
- `minDrops` <= `maxDrops`
- `minQuantity` <= `maxQuantity`
- `dropChance` must be between 0.0 and 1.0
- `weight` must be > 0

### Type Validation
- `rarity` must be one of the allowed values
- `type` must be a valid condition type
- Numeric values must be within reasonable ranges

### Inheritance Rules
- Circular inheritance is not allowed
- Inherited properties are overridden by local properties
- Drops are merged with local drops taking precedence

## Error Messages

Common validation errors and their meanings:

| Error | Cause | Solution |
|-------|-------|----------|
| "Minimum drops cannot be negative" | `minDrops` < 0 | Set to 0 or positive value |
| "Maximum drops cannot be less than minimum" | `maxDrops` < `minDrops` | Increase `maxDrops` or decrease `minDrops` |
| "Drop chance must be between 0 and 1" | `dropChance` outside 0-1 range | Set to value between 0.0 and 1.0 |
| "Duplicate item ID found" | Same `itemId` appears multiple times | Remove duplicates or use different IDs |
| "Unknown condition type" | Invalid `type` in condition | Check condition type spelling |
| "No drops configured" | Empty `drops` array with `dropChance` > 0 | Add drops or set `dropChance` to 0 |

---

**Next:** [Data-Driven Configuration](./data-driven.md) | [Migration Guide](./migration.md) | [Advanced Topics](../advanced/conditions.md)
