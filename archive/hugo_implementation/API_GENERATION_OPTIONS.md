# C# XML Documentation to Hugo Generation Options

## 🎯 Problem Statement

We need to automatically generate API documentation from C# XML comments and integrate them into our Hugo documentation sites. This will ensure our API reference stays up-to-date with the actual code.

## 🛠️ Recommended Solutions

### **Option 1: XMLDoc2Markdown (Recommended for Hugo)**

**Tool**: [XMLDoc2Markdown](https://github.com/charlesdevandiere/xmldoc2md)

**Why it's great for Hugo**:
- ✅ **Direct Markdown Output** - Generates Hugo-compatible Markdown files
- ✅ **Hugo-Friendly Structure** - Creates flat or tree structure for Hugo content
- ✅ **GitHub Pages Ready** - Has built-in GitHub Pages support
- ✅ **Command-Line Tool** - Easy to integrate into CI/CD pipelines

**Installation**:
```bash
dotnet tool install -g XMLDoc2Markdown
```

**Usage**:
```bash
# Generate documentation for ItemDrops.Core.dll
dotnet xmldoc2md ItemDrops.Core.dll --output docs/reference --github-pages --back-button

# With custom structure
dotnet xmldoc2md ItemDrops.Core.dll --output content/item_drops/reference --structure tree
```

**Features**:
- Table of contents generation
- Code highlighting
- Member accessibility filtering
- GitHub Pages/GitLab Wiki modes
- Back button navigation

---

### **Option 2: Vsxmd (Visual Studio Integration)**

**Tool**: [Vsxmd](https://github.com/lijunle/Vsxmd)

**Why it's great**:
- ✅ **Visual Studio Integration** - Automatic build-time generation
- ✅ **NuGet Package** - Easy to add to projects
- ✅ **Rich Formatting** - Parameter tables, tooltips, MSDN links
- ✅ **Table of Contents** - Auto-generated navigation

**Installation**:
```bash
# Via NuGet
dotnet add package Vsxmd
```

**Project Setup** (.csproj):
```xml
<PropertyGroup>
  <GenerateDocumentationFile>true</GenerateDocumentationFile>
  <DocumentationMarkdown>$(MSBuildProjectDirectory)\docs.md</DocumentationMarkdown>
</PropertyGroup>
```

**Usage**:
```bash
# Build project to generate documentation
dotnet build
```

---

### **Option 3: DocFX (Full-Featured Documentation Generator)**

**Tool**: [DocFX](https://dotnet.github.io/docfx/)

**Why it's great**:
- ✅ **Microsoft Supported** - Official .NET documentation tool
- ✅ **Comprehensive** - Supports both API docs and conceptual content
- ✅ **Multiple Output Formats** - HTML, PDF, and Markdown
- ✅ **Advanced Features** - Search, cross-references, themes

**Installation**:
```bash
# Download DocFX executable or use via .NET tool
dotnet tool install -g docfx
```

**Usage**:
```bash
# Initialize DocFX project
docfx init

# Generate documentation
docfx build
```

**Hugo Integration**: DocFX can generate Markdown output that can be imported into Hugo.

---

## 🚀 Recommended Implementation for ItemDrops

### **Phase 1: Quick Implementation with XMLDoc2Markdown**

1. **Set up ItemDrops.Core for XML documentation**:
```xml
<!-- ItemDrops.Core.csproj -->
<PropertyGroup>
  <GenerateDocumentationFile>true</GenerateDocumentationFile>
  <DocumentationFile>bin\$(Configuration)\$(TargetFramework)\ItemDrops.Core.xml</DocumentationFile>
</PropertyGroup>
```

2. **Create API generation script**:
```bash
#!/bin/bash
# generate-api-docs.sh

# Build the project to generate XML documentation
cd /home/chris/game_dev/plugins/ItemDrops/Core
dotnet build --configuration Release

# Generate Markdown documentation
dotnet xmldoc2md bin/Release/net8.0/ItemDrops.Core.dll \
  --output /home/chris/game_dev/docs/item_drops/content/item_drops/reference/auto \
  --structure tree \
  --github-pages \
  --member-accessibility-level public

# Rebuild Hugo site
cd /home/chris/game_dev/docs/item_drops
hugo --minify
```

3. **Integrate into CI/CD**:
```yaml
# .gitlab-ci.yml (API documentation generation)
generate-api-docs:
  stage: build
  script:
    - dotnet tool install -g XMLDoc2Markdown
    - ./scripts/generate-api-docs.sh
  artifacts:
    paths:
      - public/
  only:
    - main
    - develop
```

### **Phase 2: Enhanced Documentation**

1. **Add XML comments to all public APIs**:
```csharp
/// <summary>
/// Generates loot based on the provided context and modifiers.
/// </summary>
/// <param name="settings">The settings for loot generation.</param>
/// <returns>A list of generated drop results.</returns>
/// <example>
/// <code>
/// var generator = new LootGenerator();
/// var settings = new LootGenerationSettings { DropTable = table, Context = context };
/// var drops = generator.GenerateLoot(settings);
/// </code>
/// </example>
/// <remarks>
/// This method applies all registered modifiers before generating drops.
/// </remarks>
public List<DropResult> GenerateLoot(LootGenerationSettings settings)
{
    // Implementation
}
```

2. **Customize Hugo templates** for API documentation styling
3. **Add search functionality** for API references
4. **Version the API documentation** alongside plugin releases

---

## 📊 Comparison Matrix

| Feature | XMLDoc2Markdown | Vsxmd | DocFX |
|---------|----------------|-------|-------|
| **Hugo Compatibility** | ✅ Excellent | ✅ Good | ⚠️ Requires conversion |
| **Setup Complexity** | ✅ Low | ✅ Low | ⚠️ Medium |
| **Visual Studio Integration** | ❌ No | ✅ Yes | ⚠️ Limited |
| **CI/CD Friendly** | ✅ Excellent | ✅ Good | ✅ Good |
| **Output Quality** | ✅ Good | ✅ Excellent | ✅ Excellent |
| **Customization** | ✅ Good | ⚠️ Limited | ✅ Excellent |
| **Maintenance** | ✅ Low | ✅ Low | ⚠️ Medium |

---

## 🎯 Next Steps

### **Immediate Actions (This Week)**
1. **Install XMLDoc2Markdown** and test with ItemDrops.Core
2. **Add XML documentation** to key public APIs
3. **Create generation script** and test locally
4. **Update API Reference section** to include generated docs

### **Short-term Goals (Next 2 Weeks)**
1. **Add comprehensive XML comments** to all public APIs
2. **Integrate into CI/CD pipeline** for automatic generation
3. **Customize Hugo styling** for API documentation
4. **Test with other plugins** (GridBuilding, WorldTime)

### **Long-term Goals (Next Month)**
1. **Version API documentation** with plugin releases
2. **Add search functionality** for API references
3. **Create custom Hugo shortcodes** for API elements
4. **Establish documentation standards** for all plugins

---

## 🔧 Implementation Example

### **Generated API Structure**:
```
content/item_drops/reference/auto/
├── _index.md                    # Main API reference page
├── ItemDrops.Core.Generation/
│   ├── LootGenerator.md         # LootGenerator class
│   └── ILootGenerator.md        # ILootGenerator interface
├── ItemDrops.Core.Types/
│   ├── DropContext.md           # DropContext class
│   ├── DropResult.md            # DropResult class
│   └── ItemDrop.md              # ItemDrop class
└── ItemDrops.Core.Modifiers/
    ├── LuckModifier.md          # LuckModifier class
    └── IModifier.md             # IModifier interface
```

### **Generated Content Example**:
```markdown
# LootGenerator

Generates loot based on various criteria and modifiers.

## Methods

### GenerateLoot(LootGenerationSettings)

Generates loot based on the provided configuration.

**Parameters**:
- `settings` (LootGenerationSettings): The settings for loot generation

**Returns**: `List<DropResult>` - A list of generated drop results

**Example**:
```csharp
var generator = new LootGenerator();
var settings = new LootGenerationSettings { DropTable = table, Context = context };
var drops = generator.GenerateLoot(settings);
```
```

---

**This approach will give us automatically generated, always-up-to-date API documentation that integrates seamlessly with our Hugo sites!**
