---
title: "DatabaseSchemaGenerator"
description: ""
weight: 10
url: "/gridbuilding/v6.0-public/api/core/databaseschemagenerator/"
---

# DatabaseSchemaGenerator

```csharp
GridBuilding.Core.Integration
class DatabaseSchemaGenerator
{
    // Members...
}
```

Database schema generator for placeable data persistence

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/_incomplete/Integration/DatabaseSchemaGenerator.cs`  
**Namespace:** `GridBuilding.Core.Integration`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Methods

### GenerateSchema

```csharp
/// <summary>
        /// Generates database schema for specified database type
        /// </summary>
        public static Result<string> GenerateSchema(string databaseType, SchemaOptions options = null)
        {
            try
            {
                options ??= new SchemaOptions();

                switch (databaseType.ToLower())
                {
                    case "sqlite":
                        return GenerateSqliteSchema(options);
                    
                    case "postgresql":
                        return GeneratePostgreSqlSchema(options);
                    
                    case "mysql":
                        return GenerateMySqlSchema(options);
                    
                    case "mongodb":
                        return GenerateMongoDbSchema(options);
                    
                    default:
                        return Result<string>.Failure($"Database type not supported: {databaseType}");
                }
            }
            catch (Exception ex)
            {
                return Result<string>.Failure($"Schema generation failed: {ex.Message}");
            }
        }
```

Generates database schema for specified database type

**Returns:** `Result<string>`

**Parameters:**
- `string databaseType`
- `SchemaOptions options`

### GenerateMigration

```csharp
/// <summary>
        /// Generates migration scripts
        /// </summary>
        public static Result<string> GenerateMigration(string databaseType, int fromVersion, int toVersion)
        {
            try
            {
                var migration = new StringBuilder();

                switch (databaseType.ToLower())
                {
                    case "sqlite":
                        migration.AppendLine($"-- SQLite Migration: {fromVersion} -> {toVersion}");
                        migration.AppendLine($"BEGIN TRANSACTION;");
                        
                        if (fromVersion < 1 && toVersion >= 1)
                        {
                            migration.AppendLine("-- Add version column");
                            migration.AppendLine($"ALTER TABLE placeables ADD COLUMN version INTEGER NOT NULL DEFAULT 1;");
                        }
                        
                        if (fromVersion < 2 && toVersion >= 2)
                        {
                            migration.AppendLine("-- Add external references column");
                            migration.AppendLine($"ALTER TABLE placeables ADD COLUMN external_references TEXT;");
                        }
                        
                        migration.AppendLine($"COMMIT;");
                        break;

                    case "postgresql":
                        migration.AppendLine($"-- PostgreSQL Migration: {fromVersion} -> {toVersion}");
                        
                        if (fromVersion < 1 && toVersion >= 1)
                        {
                            migration.AppendLine($"ALTER TABLE placeables ADD COLUMN IF NOT EXISTS version INTEGER NOT NULL DEFAULT 1;");
                        }
                        
                        if (fromVersion < 2 && toVersion >= 2)
                        {
                            migration.AppendLine($"ALTER TABLE placeables ADD COLUMN IF NOT EXISTS external_references JSONB;");
                        }
                        break;

                    default:
                        return Result<string>.Failure($"Migration not supported for database type: {databaseType}");
                }

                return Result<string>.Success(migration.ToString());
            }
            catch (Exception ex)
            {
                return Result<string>.Failure($"Migration generation failed: {ex.Message}");
            }
        }
```

Generates migration scripts

**Returns:** `Result<string>`

**Parameters:**
- `string databaseType`
- `int fromVersion`
- `int toVersion`

