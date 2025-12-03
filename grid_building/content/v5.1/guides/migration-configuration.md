---
title: "Migration Configuration Guide"
description: "Complete guide to configuring the enhanced migration tool for Grid Building 5.0.0 to 5.1.0 migration"
date: 2025-11-30T10:19:00-05:00
weight: 30
draft: false
type: "docs"
layout: "docs"
url: "/v5.1/guides/migration-configuration/"
icon: "fas fa-cog"
tags: ["migration", "configuration", "toml", "json", "yaml"]
---

# Enhanced Migration Configuration System

The enhanced migration tool supports flexible configuration through TOML, JSON, and YAML files, allowing you to customize every aspect of the migration process.

## Configuration Files

### Supported Formats
- **TOML** (recommended): `migration_config.toml`
- **JSON**: `migration_config.json`
- **YAML**: `migration_config.yaml`

### Loading Configuration
Configuration is loaded automatically from `migration_config.toml` in the current directory, or you can specify a custom path:

```bash
# Use default configuration file
./enhanced_migration --source ./godot/addons/grid_building --target ./output

# Use custom configuration file
./enhanced_migration --config ./custom_config.toml --source ./godot/addons/grid_building --target ./output

# Use JSON configuration
./enhanced_migration --config ./migration_config.json --source ./godot/addons/grid_building --target ./output
```

## Configuration Sections

### [migration] - Core Migration Settings
- `enable_code_analysis`: Enable advanced code analysis using Roslyn
- `update_scene_references`: Update script references in scene files
- `preserve_uids`: Preserve Godot UIDs during migration
- `generate_documentation`: Generate XML documentation for C# classes

### [output] -- Output Generation
- `target_language`: Target programming language ( `csharp`)
- `namespace_prefix`: Prefix for generated C# namespaces
- `class_suffix`: Suffix to add to generated class names
- `indent_style`: Code indentation style (`spaces` or `tabs`)
- `indent_size`: Number of spaces for indentation
- `line_ending`: Line ending style (`lf`, `crlf`, or `cr`)

### [backups] - Backup and Recovery
- `create_backups`: Create backup files before modifying
- `backup_directory`: Directory to store backup files ( `../migration_backups`)
- `backup_format`: Backup naming format (`timestamp` or `simple`)
- `compress_backups`: Compress backup files to save space
- `max_backup_age_days`: Automatically delete backups older than this many days

### [logging] -- Logging Configuration
- `level`: Log level (`trace`, `debug`, `information`, `warning`, `error`, `critical`)
- `enable_file_logging`: Enable logging to files
- `log_directory`: Directory for log files
- `log_retention_days`: Keep log files for this many days
- `include_performance_metrics`: Include timing and memory usage metrics

### [validation] -- Code Validation
- `enable_syntax_validation`: Validate generated C# syntax
- `enable_semantic_validation`: Validate semantic correctness
- `check_godot_compatibility`: Ensure compatibility with Godot C# API
- `validate_export_properties`: Validate exported property mappings
- `check_naming_conventions`: Enforce C# naming conventions

### [performance] -- Performance Optimization
- `parallel_processing`: Process multiple files simultaneously
- `max_concurrent_files`: Maximum number of files to process at once
- `enable_caching`: Cache parsed ASTs for faster re-migration
- `cache_directory`: Directory for migration cache
- `memory_limit_mb`: Memory usage limit in megabytes

### [code_generation] -- C# Code Generation
- `auto_properties`: Use C# auto-properties where possible
- `use_nullable_types`: Use nullable reference types
- `generate_xml_docs`: Generate XML documentation comments
- `convert_snake_to_pascal`: Convert snake_case to PascalCase
- `add_region_comments`: Add `#region` comments to organize code
- `include_debug_attributes`: Include debug attributes for testing

### [scene_handling] -- Scene File Processing
- `process_scene_files`: Process `.tscn` scene files
- `update_script_references`: Update GDScript references in scenes
- `preserve_node_paths`: Preserve original node paths
- `handle_resource_references`: Update resource references
- `validate_scene_structure`: Validate scene file integrity

### [resource_handling] -- Resource File Processing
- `process_resource_files`: Process `.tres` resource files
- `update_resource_paths`: Update resource file paths
- `preserve_custom_properties`: Preserve custom resource properties
- `handle_import_files`: Process `.import` files
- `validate_resource_integrity`: Validate resource file integrity

### [advanced] -- Experimental Features
- `enable_ai_assistance`: Enable AI-powered code improvements
- `use_type_inference`: Use type inference for better type mapping
- `generate_unit_tests`: Generate basic unit tests
- `create_migration_report`: Generate detailed migration report
- `enable_incremental_migration`: Only migrate changed files

### [filters] -- File Filtering
- `include_patterns`: File patterns to include in migration
- `exclude_patterns`: File patterns to exclude from migration
- `exclude_directories`: Directories to exclude from migration

### [custom_properties] -- Custom Mappings
- `type_mappings`: Custom GDScript to C# type mappings
- `attribute_mappings`: Custom GDScript attribute to C# attribute mappings

## Command Line Override

Command line arguments override configuration file settings:

```bash
# Configuration enables code analysis, but command line disables it
./enhanced_migration --config migration_config.toml --no-analysis

# Configuration sets namespace to "GridBuilding", but command line overrides
./enhanced_migration --config migration_config.toml --namespace "MyProject.Generated"
```

## Configuration Priority

1. **Command line arguments** (highest priority)
2. **Configuration file** (TOML/JSON/YAML)
3. **Default values** (lowest priority)

## Example Usage

### Basic Migration with Default Config
```bash
./enhanced_migration --source ./godot/addons/grid_building --target ./csharp_output
```

### Custom Configuration with Overrides
```bash
./enhanced_migration \
  --config ./production_config.toml \
  --source ./godot/addons/grid_building \
  --target ./csharp_output \
  --namespace "MyGame.GridBuilding" \
  --dry-run
```

### High-Performance Migration
```toml
[performance]
parallel_processing = true
max_concurrent_files = 16
enable_caching = true
memory_limit_mb = 2048

[logging]
level = "warning"
include_performance_metrics = true
```

```bash
./enhanced_migration --config ./performance_config.toml --source ./godot/addons/grid_building --target ./csharp_output
```

## Validation

Configuration files are automatically validated for:
- Required fields
- Valid values
- Path existence
- Numeric ranges

Invalid configurations will fall back to defaults with warnings logged.

## Creating Custom Configurations

### Minimal Configuration
```toml
[migration]
enable_code_analysis = true

[output]
namespace_prefix = "MyProject"
```

### Development Configuration
```toml
[migration]
enable_code_analysis = true
generate_documentation = true

[output]
indent_size = 2

[logging]
level = "debug"
include_performance_metrics = true

[validation]
enable_syntax_validation = true
check_godot_compatibility = true

[performance]
parallel_processing = false  # Easier debugging
```

### Production Configuration
```toml
[migration]
enable_code_analysis = true
update_scene_references = true

[backups]
create_backups = true
compress_backups = true

[logging]
level = "information"
enable_file_logging = true

[validation]
enable_syntax_validation = true
enable_semantic_validation = true

[performance]
parallel_processing = true
max_concurrent_files = 8
enable_caching = true
```

## Integration with Code

You can also use the configuration system programmatically:

```csharp
// Load from file
var options = EnhancedMigrationOptions.FromConfiguration("migration_config.toml");

// Validate configuration
var validation = options.Validate();
if (!validation.IsValid)
{
    foreach (var error in validation.Errors)
        Console.WriteLine($"Error: {error}");
}

// Override specific settings
options.TargetNamespace = "MyProject.Generated";
options.DryRun = true;

// Save configuration
options.SaveToConfiguration("updated_config.toml");
```

## Troubleshooting

### Configuration Not Found
```
Warning: Configuration file not found at custom_config.toml, using defaults
```
Solution: Check file path and ensure the configuration file exists.

### Invalid Configuration
```
Warning: Failed to parse TOML configuration, using defaults
```
Solution: Validate TOML syntax using an online validator or text editor with TOML support.

### Invalid Values
```
Error: Indent size must be positive
```
Solution: Check configuration values against the documentation above.
