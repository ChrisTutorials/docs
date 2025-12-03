# Hugo Documentation Best Practices - Living Document

## 📋 **Document Status**
**Last Updated**: 2025-11-28  
**Version**: 1.0  
**Maintainer**: Documentation Team  
**Review Schedule**: Monthly  

---

## 🎯 **Executive Summary**

This document outlines best practices for maintaining a versioned API documentation site using Hugo, specifically tailored for developer-focused documentation like the Grid Building Plugin. It covers technical implementation, content organization, user experience, and maintenance workflows.

---

## 🏗️ **Technical Architecture Best Practices**

### **1. Hugo Configuration Structure**

#### **Required Files & Organization**
```
docs-hugo/
├── hugo.yaml                 # Main configuration
├── go.mod                   # Hugo module dependencies
├── layouts/                 # Template system
│   ├── _default/           # Base templates
│   ├── partials/           # Reusable components
│   └── shortcodes/         # Content shortcodes
├── content/                # Markdown content
│   ├── v5.0/              # Versioned content
│   ├── v5.1/              # Versioned content
│   └── community.md        # Static pages
├── assets/                 # CSS, JS, images
├── static/                 # Static assets
└── archetypes/             # Content templates
```

#### **Hugo.yaml Best Practices**
```yaml
# Essential configuration blocks
baseURL: "https://docs.gridbuilding.dev"
languageCode: "en-us"
title: "Grid Building Plugin Documentation"

# SEO & Social
params:
  description: "Comprehensive documentation for the Grid Building Plugin"
  author: "Chris Tutorials"
  images: ["/images/og-image.png"]

# Navigation Structure
menu:
  main:
    - name: "Documentation"
      url: "/v5.1/overview/"
      weight: 20
      params:
        icon: "fas fa-book"
    - name: "API Reference"
      url: "/v5.1/api/"
      weight: 30
      params:
        icon: "fas fa-code"
    - name: "Community"
      url: "/community/"
      weight: 50
      params:
        icon: "fas fa-users"

  # Version navigation (dropdown only)
  versions:
    - name: "v5.1 (Development)"
      url: "/v5.1/"
      weight: 10
      params:
        status: development
        latest: true
    - name: "v5.0 (Stable)"
      url: "/v5.0/"
      weight: 20
      params:
        status: stable

# Build optimization
build:
  writeStats: true
  useResourceCacheWhen: "never"

# Performance settings
minify:
  minifyOutput: true
  removeComments: true
```

### **2. Version Management Strategy**

#### **Directory Structure**
```
content/
├── v5.0/                    # Stable version
│   ├── overview/
│   ├── guides/
│   ├── api/
│   └── examples/
├── v5.1/                    # Development version
│   ├── overview/
│   ├── guides/
│   ├── api/
│   └── examples/
├── community.md             # Version-independent
├── license.md               # Version-independent
└── index.md                 # Landing page
```

#### **Version Navigation Implementation**
```html
<!-- In layouts/_default/baseof.html -->
<div class="version-selector">
    <button class="version-toggle" onclick="toggleVersionMenu()">
        <i class="fas fa-code-branch"></i>
        {{ if .IsPage }}
            {{ if .Params.version }}
                {{ .Params.version }}
            {{ else if strings.HasPrefix .RelPermalink "/v5.1/" }}
                v5.1
            {{ else if strings.HasPrefix .RelPermalink "/v5.0/" }}
                v5.0
            {{ else }}
                v5.1
            {{ end }}
        {{ else }}
            v5.1
        {{ end }}
        <i class="fas fa-chevron-down"></i>
    </button>
    <div class="version-menu" id="version-menu">
        <div class="version-header">Select Version</div>
        {{ range .Site.Menus.versions }}
        <a href="{{ .URL }}" class="version-option">
            {{ if eq .Params.status "development" }}
            <span class="version-badge version-badge-dev">DEV</span>
            {{ else if eq .Params.status "stable" }}
            <span class="version-badge version-badge-stable">STABLE</span>
            {{ end }}
            {{ .Name }}
        </a>
        {{ end }}
    </div>
</div>
```

### **3. Component-Based Architecture**

#### **Shortcode System**
```html
<!-- layouts/shortcodes/components/card.html -->
<div class="component-card">
    <div class="card-header">
        {{ if .Get "icon" }}
        <div class="card-icon">
            <i class="{{ .Get "icon" }}"></i>
        </div>
        {{ end }}
        <h3 class="card-title">{{ .Get "title" }}</h3>
    </div>
    <div class="card-content">
        {{ .Inner }}
    </div>
    {{ if .Get "link" }}
    <div class="card-actions">
        <a href="{{ .Get "link" }}" class="btn btn-primary">
            {{ .Get "link-text" | default "Learn More" }}
        </a>
    </div>
    {{ end }}
</div>
```

#### **Content Usage**
```markdown
{{< components/card 
    title="Getting Started" 
    icon="fas fa-rocket"
    link="/v5.1/guides/"
    link-text="Start Building"
>}}
Complete guide to setting up and using the Grid Building Plugin.
{{< /components/card >}}
```

---

## 📚 **Content Organization Best Practices**

### **1. API Documentation Structure**

#### **Class Documentation Template**
```markdown
---
title: "GridBuilder"
description: "Main orchestrator for grid operations"
weight: 10
layout: "api/single"
---

# GridBuilder

## Overview
The main class responsible for coordinating all grid building operations.

## Properties

| Property | Type | Description |
|-----------|------|-------------|
| `GridSize` | `Vector2I` | Size of the building grid |
| `CellSize` | `int` | Size of each grid cell in pixels |
| `ActiveLayer` | `int` | Current building layer |

## Methods

### `PlaceBuilding(building: BuildingData, position: Vector2I) -> bool`
Places a building at the specified grid position.

**Parameters:**
- `building`: Building data to place
- `position`: Grid coordinates for placement

**Returns:** `true` if placement was successful

**Example:**
```gdscript
var grid_builder = GridBuilder.new()
var success = grid_builder.PlaceBuilding(my_building, Vector2I(5, 3))
```

## Signals

### `building_placed(building: BuildingData, position: Vector2I)`
Emitted when a building is successfully placed.

## Related Classes
- [BuildingData](/v5.1/api/BuildingData/)
- [GridValidator](/v5.1/api/GridValidator/)
```

### **2. Guide Documentation Structure**

#### **Guide Template**
```markdown
---
title: "Getting Started Guide"
description: "Complete setup and first building tutorial"
weight: 10
layout: "guide/single"
estimated_time: "15 minutes"
difficulty: "beginner"
prerequisites: ["Godot 4.x", "Basic GDScript"]
---

# Getting Started

## Prerequisites
- Godot 4.x installed
- Basic understanding of GDScript
- Grid Building Plugin added to project

## Step 1: Installation

1. Download the plugin from [itch.io](https://chris-tutorials.itch.io/grid-building-godot)
2. Extract to your project's `addons/` folder
3. Enable the plugin in Project Settings

## Step 2: Basic Setup

```gdscript
# In your main scene script
extends Node2D

@onready var grid_builder = $GridBuilder

func _ready():
    grid_builder.initialize_grid(Vector2I(20, 15))
```

## Next Steps
- [Building Placement Guide](/v5.1/guides/building-placement/)
- [Validation Rules](/v5.1/guides/validation/)
```

### **3. Content Front Matter Standards**

#### **Required Fields**
```yaml
---
title: "Page Title"                    # Human-readable title
description: "Brief description"       # SEO meta description
weight: 10                             # Navigation ordering
layout: "default/single"                # Template to use
---

# Optional but recommended fields:
menu:
  main:
    weight: 20
    params:
      icon: "fas fa-icon"
      description: "Navigation description"

# API-specific:
class_name: "GridBuilder"
namespace: "GridBuilding.Core"
api_version: "5.1"

# Guide-specific:
estimated_time: "15 minutes"
difficulty: "beginner|intermediate|advanced"
prerequisites: ["Godot 4.x", "Basic GDScript"]
related: ["/v5.1/guides/next-topic/"]

# Version-specific:
version: "5.1"
status: "development|stable|deprecated"
last_updated: "2025-11-28"
```

---

## 🎨 **Design & UX Best Practices**

### **1. Responsive Design Requirements**

#### **Breakpoint System**
```css
/* Mobile-first approach */
@media (max-width: 768px) {
    /* Mobile styles */
    .gb-card-grid {
        grid-template-columns: 1fr;
    }
}

@media (min-width: 769px) and (max-width: 1024px) {
    /* Tablet styles */
    .gb-card-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (min-width: 1025px) {
    /* Desktop styles */
    .gb-card-grid {
        grid-template-columns: repeat(3, 1fr);
    }
}
```

#### **Touch-Friendly Components**
```css
/* Minimum touch targets: 44px × 44px */
.gb-button {
    min-height: 44px;
    min-width: 44px;
    padding: 0.75rem 1.5rem;
}

.gb-card {
    min-height: 44px;
    padding: 1rem;
}
```

### **2. Accessibility Standards**

#### **WCAG 2.1 AA Compliance**
```html
<!-- Semantic HTML structure -->
<header role="banner">
    <nav role="navigation" aria-label="Main navigation">
        <a href="/" aria-label="Home">
            <img src="/logo.svg" alt="Grid Building Plugin Logo">
        </a>
        <button aria-expanded="false" aria-controls="mobile-menu">
            <span class="sr-only">Toggle navigation</span>
        </button>
    </nav>
</header>

<main role="main" id="main-content">
    <!-- Page content -->
</main>

<!-- Skip to main content link -->
<a href="#main-content" class="skip-link">Skip to main content</a>
```

#### **Keyboard Navigation**
```javascript
// Keyboard navigation support
document.addEventListener('keydown', function(e) {
    if (e.key === 'Tab') {
        // Handle focus management
    }
    if (e.key === 'Escape') {
        // Close modals/menus
    }
    if (e.key === 'Enter' || e.key === ' ') {
        // Activate focused elements
    }
});
```

### **3. Performance Optimization**

#### **Image Optimization**
```yaml
# hugo.yaml
markup:
  goldmark:
    renderer:
      unsafe: true
  image:
    resampleFilter: "Lanczos"
    quality: 85
    anchor: "smart"
```

#### **CSS Optimization**
```css
/* Use CSS custom properties for theming */
:root {
    --primary: #1e40af;
    --primary-50: #eff6ff;
    /* ... */
}

/* Optimize animations */
.gb-card {
    will-change: transform;
    transition: transform 0.2s ease;
}

.gb-card:hover {
    transform: translateY(-4px);
}
```

---

## 🔍 **SEO & Analytics Best Practices**

### **1. Structured Data Implementation**

#### **Schema.org for Documentation**
```html
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "SoftwareDocumentation",
    "name": "Grid Building Plugin Documentation",
    "description": "Comprehensive API documentation for the Grid Building Plugin",
    "url": "https://docs.gridbuilding.dev/",
    "author": {
        "@type": "Person",
        "name": "Chris Tutorials"
    },
    "about": {
        "@type": "SoftwareApplication",
        "name": "Grid Building Plugin",
        "applicationCategory": "DeveloperApplication",
        "operatingSystem": "Windows, macOS, Linux, iOS, Android, Web"
    },
    "dateModified": "{{ now.Format "2006-01-02" }}"
}
</script>
```

#### **Breadcrumb Schema**
```html
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
        {
            "@type": "ListItem",
            "position": 1,
            "name": "Documentation",
            "item": "https://docs.gridbuilding.dev/v5.1/"
        },
        {
            "@type": "ListItem",
            "position": 2,
            "name": "API Reference",
            "item": "https://docs.gridbuilding.dev/v5.1/api/"
        }
    ]
}
</script>
```

### **2. Search Engine Optimization**

#### **Meta Tags**
```html
<!-- In layouts/_default/baseof.html head -->
<title>{{ if .Title }}{{ .Title }}{{ else }}{{ .Site.Title }}{{ end }}</title>
<meta name="description" content="{{ if .Description }}{{ .Description }}{{ else }}{{ .Site.Params.description }}{{ end }}">
<meta name="keywords" content="{{ if .Params.keywords }}{{ delimit .Params.keywords ", " }}{{ end }}">

<!-- Open Graph -->
<meta property="og:title" content="{{ .Title }}">
<meta property="og:description" content="{{ .Description }}">
<meta property="og:image" content="{{ .Params.og_image | default "/images/og-default.png" }}">
<meta property="og:url" content="{{ .Permalink }}">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{{ .Title }}">
<meta name="twitter:description" content="{{ .Description }}">
```

#### **Sitemap Configuration**
```yaml
# hugo.yaml
sitemap:
  changefreq: "weekly"
  priority: 0.8
  filename: "sitemap.xml"
```

---

## 🚀 **Deployment & CI/CD Best Practices**

### **1. Build Optimization**

#### **Hugo Build Script**
```bash
#!/bin/bash
# build.sh

echo "Building Hugo documentation site..."

# Clean previous build
rm -rf public/

# Build with optimizations
hugo build \
  --minify \
  --gc \
  --enableRobotsTXT \
  --templateMetrics \
  --templateMetricsHints

# Check build success
if [ $? -eq 0 ]; then
    echo "✅ Build successful"
    echo "📊 Build statistics:"
    du -sh public/
else
    echo "❌ Build failed"
    exit 1
fi
```

#### **Performance Testing**
```bash
#!/bin/bash
# performance-test.sh

# Install dependencies
npm install -g lighthouse

# Run Lighthouse audit
lighthouse http://localhost:1313 \
  --output=json \
  --output-path=./lighthouse-report.json \
  --chrome-flags="--headless"

# Check scores
performance=$(cat lighthouse-report.json | jq '.categories.performance.score * 100')
accessibility=$(cat lighthouse-report.json | jq '.categories.accessibility.score * 100')

echo "Performance: $performance%"
echo "Accessibility: $accessibility%"

# Fail if scores below threshold
if (( $(echo "$performance < 90" | bc -l) )); then
    echo "❌ Performance score below 90%"
    exit 1
fi
```

### **2. GitHub Actions Workflow**

#### **.github/workflows/docs.yml**
```yaml
name: Documentation

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
      with:
        submodules: recursive
    
    - name: Setup Hugo
      uses: peaceiris/actions-hugo@v2
      with:
        hugo-version: 'latest'
        extended: true
    
    - name: Install Node.js dependencies
      run: npm ci
    
    - name: Build documentation
      run: ./scripts/build.sh
    
    - name: Run performance tests
      run: ./scripts/performance-test.sh
    
    - name: Deploy to staging
      if: github.ref == 'refs/heads/develop'
      run: |
        # Deploy to staging environment
        echo "Deploying to staging..."
    
    - name: Deploy to production
      if: github.ref == 'refs/heads/main'
      run: |
        # Deploy to production environment
        echo "Deploying to production..."
```

---

## 📊 **Monitoring & Analytics**

### **1. Essential Metrics to Track**

#### **Performance Metrics**
- Page load time (< 2 seconds target)
- First Contentful Paint (< 1.5 seconds)
- Largest Contentful Paint (< 2.5 seconds)
- Cumulative Layout Shift (< 0.1)

#### **User Engagement Metrics**
- Time on page
- Bounce rate
- Pages per session
- Search query analysis

#### **Technical Metrics**
- 404 errors
- Broken links
- Mobile vs desktop usage
- Browser compatibility

### **2. Analytics Implementation**

#### **Google Analytics 4**
```html
<!-- In layouts/_default/baseof.html -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

#### **Custom Event Tracking**
```javascript
// Track documentation interactions
function trackDocumentationEvent(action, category, label) {
    gtag('event', action, {
        'event_category': category,
        'event_label': label
    });
}

// Example usage
trackDocumentationEvent('api_method_click', 'api_documentation', 'GridBuilder.PlaceBuilding');
```

---

## 🔄 **Maintenance Workflow**

### **1. Content Review Process**

#### **Monthly Review Checklist**
- [ ] Check for broken links
- [ ] Update outdated information
- [ ] Review analytics for popular pages
- [ ] Update version badges
- [ ] Check mobile responsiveness
- [ ] Validate HTML/CSS
- [ ] Test keyboard navigation
- [ ] Review search functionality

#### **Version Release Process**
1. **Pre-release (1 week before)**
   - Update version navigation
   - Add version badges to new content
   - Update changelog
   - Test all links

2. **Release Day**
   - Update stable version links
   - Deploy to production
   - Monitor for errors
   - Announce to community

3. **Post-release (1 week after)**
   - Monitor analytics
   - Fix any issues found
   - Update documentation based on feedback

### **2. Automated Maintenance**

#### **Link Checking Script**
```bash
#!/bin/bash
# check-links.sh

echo "Checking for broken links..."

# Install html-proofer
gem install html-proofer

# Run link checker
htmlproofer ./public \
  --check-html \
  --check-opengraph \
  --report-time \
  --log-level :debug

echo "Link check complete"
```

#### **Content Validation Script**
```bash
#!/bin/bash
# validate-content.sh

echo "Validating content structure..."

# Check for required front matter fields
find content/ -name "*.md" -exec grep -L "title:" {} \;

# Check for broken internal links
hugo server --buildDrafts --disableFastRender &
SERVER_PID=$!

# Wait for server to start
sleep 5

# Check internal links
curl -s http://localhost:1313/ | grep -o 'href="[^"]*"' | while read link; do
    url=$(echo $link | sed 's/href="//' | sed 's/"//')
    if [[ $url == /* ]]; then
        curl -s -o /dev/null -w "%{http_code}" http://localhost:1313$url
    fi
done

kill $SERVER_PID
```

---

## 🎯 **Quality Standards**

### **1. Content Quality Guidelines**

#### **Writing Standards**
- Use clear, concise language
- Provide code examples for all APIs
- Include prerequisites for guides
- Use consistent terminology
- Add troubleshooting sections

#### **Code Example Standards**
```gdscript
# Good example - Complete and runnable
extends Node2D

@onready var grid_builder = $GridBuilder

func _ready():
    # Initialize the grid with 20x15 cells
    grid_builder.initialize_grid(Vector2I(20, 15))
    
    # Create a simple building
    var building_data = BuildingData.new()
    building_data.name = "House"
    building_data.size = Vector2I(2, 2)
    
    # Place the building at position (5, 5)
    var success = grid_builder.PlaceBuilding(building_data, Vector2I(5, 5))
    
    if success:
        print("Building placed successfully!")
    else:
        print("Failed to place building")
```

### **2. Technical Quality Standards**

#### **Performance Requirements**
- Page load time < 2 seconds
- Mobile score > 90/100
- Accessibility score > 95/100
- SEO score > 95/100

#### **Browser Support**
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

#### **Device Support**
- Mobile (320px+)
- Tablet (768px+)
- Desktop (1024px+)

---

## 📈 **Improvement Roadmap**

### **Phase 1: Foundation (Current)**
- [x] Implement versioned navigation
- [x] Create component system
- [x] Establish design system
- [x] Fix navigation structure
- [ ] Add search functionality
- [ ] Implement dark mode toggle

### **Phase 2: Enhancement (Next 3 months)**
- [ ] Interactive code examples
- [ ] API explorer tool
- [ ] User feedback system
- [ ] Advanced search with filters
- [ ] Multi-language support
- [ ] Offline documentation support

### **Phase 3: Advanced (6+ months)**
- [ ] AI-powered search
- [ ] Interactive tutorials
- [ ] Video integration
- [ ] Community contributions
- [ ] API testing playground
- [ ] Custom documentation themes

---

## 📞 **Support & Resources**

### **Helpful Resources**
- [Hugo Documentation](https://gohugo.io/documentation/)
- [Web.dev Best Practices](https://web.dev/learn/)
- [MDN Web Docs](https://developer.mozilla.org/)
- [Schema.org Documentation](https://schema.org/)

### **Tools & Services**
- **Analytics**: Google Analytics 4
- **Performance**: Lighthouse, PageSpeed Insights
- **SEO**: Google Search Console
- **Accessibility**: axe DevTools, WAVE
- **Testing**: BrowserStack, Responsive Design Checker

### **Community Support**
- [GitHub Discussions](https://github.com/ChrisTutorials/grid_building_dev/discussions)
- [Documentation Issues](https://github.com/ChrisTutorials/grid_building_dev/issues)
- [Community Discord](https://discord.gg/)

---

## 📝 **Change Log**

### **Version 1.0 (2025-11-28)**
- Initial document creation
- Hugo configuration best practices
- Version management strategy
- Component architecture guidelines
- SEO and performance standards
- Deployment workflows

---

## 🔄 **Review Process**

This document follows a **monthly review cycle**:

1. **Monthly Review** - Check for outdated information
2. **Quarterly Update** - Major revisions based on feedback
3. **Annual Overhaul** - Complete restructuring if needed

### **Review Checklist**
- [ ] Technical accuracy
- [ ] Current best practices
- [ ] Link validity
- [ ] Example relevance
- [ ] Tool recommendations
- [ ] Performance standards

---

*This living document is maintained by the documentation team and updated regularly to reflect current best practices and community feedback. For questions or suggestions, please open an issue on the GitHub repository.*
