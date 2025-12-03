# Shared Hugo Theme

This directory contains the shared Hugo theme used across all plugin documentation sites.

## 🏗️ Structure

```
shared/
├── README.md                   # This file
├── theme.yaml                  # Shared theme configuration
├── go.mod                      # Hugo module configuration
├── layouts/                    # Hugo templates
│   ├── _default/
│   ├── partials/
│   └── shortcodes/
├── static/                     # Static assets
│   ├── css/
│   ├── js/
│   └── images/
└── assets/                     # Processed assets
```

## 🎨 Theme Features

### **Shared Components**
- **Consistent navigation** - Same menu structure across all sites
- **Unified styling** - Professional appearance
- **SEO optimization** - Meta tags, Open Graph, Twitter Cards
- **Responsive design** - Works on all devices
- **Syntax highlighting** - Code examples with proper styling

### **Customizable Elements**
Each site can override:
- **Site title and description** - Plugin-specific branding
- **Menu items** - Custom navigation for each plugin
- **Features list** - Plugin-specific features
- **SEO metadata** - Site-specific keywords and descriptions

## 🔧 Usage

### **For New Plugin Sites**
1. **Copy shared theme**:
   ```bash
   cd docs/new_plugin
   ln -s ../shared/layouts layouts
   ln -s ../shared/static static
   ```

2. **Configure hugo.yaml**:
   ```yaml
   # Site-specific configuration
   baseURL: 'https://new-plugin.pages.dev'
   title: 'New Plugin'
   description: 'Plugin description'
   
   params:
     # Override shared parameters as needed
     features:
       - "Custom feature 1"
       - "Custom feature 2"
   
   menu:
     main:
       - name: "Getting Started"
         url: "/new_plugin/getting-started/"
         weight: 10
   ```

### **Theme Customization**
- **Layouts**: Modify files in `shared/layouts/`
- **Styles**: Update CSS in `shared/static/css/`
- **Scripts**: Add JavaScript in `shared/static/js/`
- **Images**: Add assets in `shared/static/images/`

## 🎯 Design Principles

### **Consistency**
- **Same look and feel** across all plugin sites
- **Familiar navigation** for users
- **Professional branding** for Chris Tutorials

### **Flexibility**
- **Site-specific customization** where needed
- **Plugin-specific features** and documentation
- **Independent deployment** of each site

### **Performance**
- **Shared assets** reduce duplication
- **Optimized loading** across sites
- **Consistent caching** strategy

## 🚀 Benefits

### **For Users**
- **Familiar experience** - Same navigation and styling
- **Professional appearance** - Consistent branding
- **Easy navigation** - Predictable structure

### **For Developers**
- **Single theme to maintain** - Changes apply to all sites
- **Consistent patterns** - Same templates and components
- **Easy setup** - Symlinks to shared theme

### **For Business**
- **Professional branding** - Unified company image
- **Scalable** - Easy to add new plugins
- **Cost-effective** - Shared maintenance

## 📋 Current Sites Using This Theme

- **GridBuilding** - `https://gridbuilding.pages.dev`
- **Item Drops** - `https://item-drops.pages.dev`
- **World Time** - `https://world-time.pages.dev`

---

**Last updated: December 1, 2025**
