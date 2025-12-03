# Documentation Maintenance Guide

**Purpose**: Guide for maintaining clean, organized, and actionable documentation  
**Last Updated**: December 3, 2025  
**Version**: 1.0

---

## 🎯 Documentation Philosophy

### Core Principles
1. **Active vs Archived** - Clear separation between current and historical docs
2. **Actionable Content** - All active docs should guide current work
3. **Minimal Duplication** - One source of truth per topic
4. **Easy Navigation** - Comprehensive index with clear paths
5. **Historical Value** - Archive completed work, don't delete

---

## 📂 Documentation Structure

### Root Level (`/`)
**Only essential top-level documentation:**
- `README.md` - Repository overview
- `PROJECT_STRUCTURE.md` - Overall workspace structure
- `SETUP.md` - Initial setup instructions

**Rule**: Keep root minimal. Most docs belong in `/docs/` or subdirectories.

---

### Main Documentation (`/docs/`)

#### Active Core Docs
**Standards & Guidelines:**
- Architecture standards
- Testing standards
- Git commit standards
- Process guidelines

**Status & Tracking:**
- Technical debt status
- Documentation index
- Troubleshooting guides

**Rule**: Only docs actively referenced for current work

#### Archive (`/docs/archive/`)
**Categories:**
- `/plans/` - Completed planning documents
- `/implementation_results/` - Implementation summaries
- `/toolkit_migration/` - Toolkit development artifacts
- `/hugo_implementation/` - Hugo site setup docs
- `/migration_docs/` - Migration documentation

**Rule**: Archive completed initiatives, keep for historical reference

---

### Plugin Documentation

#### Structure Per Plugin:
```
plugins/[PluginName]/
├── docs/              # Implementation documentation
│   ├── architecture/
│   ├── migration/
│   └── decisions/
└── README.md          # Plugin overview
```

**Hugo Sites** (User-Facing):
```
docs/[plugin_name]/
├── content/          # Documentation content
├── hugo.yaml         # Hugo configuration
└── public/           # Built site (excluded from git)
```

**Rule**: Implementation docs with plugin code, user docs in Hugo sites

---

### Toolkit Documentation

```
toolkits/[toolkit_name]/docs/
├── README.md         # Toolkit overview
├── guides/           # User guides
├── api/              # API documentation
└── troubleshooting/  # Common issues
```

**Rule**: Keep active development docs, archive completed initiatives

---

## ✅ When to Archive Documentation

### Archive When:
1. **Project/Initiative Completed**
   - Implementation finished
   - Plan fully executed
   - Feature shipped

2. **Superseded by Newer Docs**
   - New version of guide created
   - Standards updated
   - Process changed

3. **No Longer Relevant**
   - Technology deprecated
   - Approach abandoned
   - Tool replaced

### Keep Active When:
1. **Currently Referenced**
   - Standards still in use
   - Guides actively followed
   - Tools still used

2. **Under Active Development**
   - Features being built
   - Documentation being updated
   - Continuous relevance

---

## 📝 Adding New Documentation

### Step 1: Determine Location

**Is it a standard/guideline?** → `/docs/`  
**Is it plugin-specific?** → `plugins/[name]/docs/`  
**Is it toolkit-specific?** → `toolkits/[name]/docs/`  
**Is it user-facing?** → Hugo site in `/docs/[plugin_name]/`

### Step 2: Create Clear Filename

**Good Examples:**
- `GIT_COMMIT_MESSAGE_STANDARDS.md`
- `CENTRALIZED_TESTING_STANDARDS.md`
- `GRID_TARGETING_ARCHITECTURE.md`

**Bad Examples:**
- `notes.md`
- `temp_doc.md`
- `IMPLEMENTATION_1.md`

**Rules:**
- Use SCREAMING_SNAKE_CASE for standards/important docs
- Be descriptive and specific
- Avoid generic names

### Step 3: Add to Index

**If it's a core standard:**
- Add to `docs/DOCUMENTATION_INDEX.md`
- Include brief description
- Categorize appropriately

**If it's plugin/toolkit specific:**
- Add to local README.md
- Ensure navigation is clear

### Step 4: Include Front Matter

```markdown
# Document Title

**Purpose**: Clear one-line purpose  
**Last Updated**: YYYY-MM-DD  
**Status**: Active/In Progress/Draft  

---

[Content here]
```

---

## 🗄️ Archiving Documentation

### Step 1: Identify Candidates

Run monthly check:
```bash
# Find old documents
find docs/ -name "*.md" -type f -mtime +90
```

Review each for:
- Is this still actively used?
- Is this plan/project completed?
- Has this been superseded?

### Step 2: Choose Archive Category

| Document Type | Archive Location |
|--------------|------------------|
| Completed plans | `docs/archive/plans/` |
| Implementation results | `docs/archive/implementation_results/` |
| Toolkit dev artifacts | `docs/archive/toolkit_migration/` |
| Hugo implementation | `docs/archive/hugo_implementation/` |
| Migration docs | `docs/archive/migration_docs/` |

### Step 3: Move to Archive

```bash
# Move document
mv docs/OLD_DOCUMENT.md docs/archive/[category]/

# Update any links in other docs
grep -r "OLD_DOCUMENT.md" docs/

# Update DOCUMENTATION_INDEX.md if needed
```

### Step 4: Update Archive README

Add to `docs/archive/README.md` if it's a new category or significant document.

---

## 🔍 Monthly Maintenance Checklist

### Documentation Review (First Monday of Month)

- [ ] **Review root directory**
  - Remove any temporary files
  - Check for misplaced docs
  - Ensure only essential files remain

- [ ] **Review active docs**
  - Verify links still work
  - Check for outdated information
  - Update "Last Updated" dates

- [ ] **Identify archive candidates**
  - Find documents > 90 days old
  - Review completed plans/projects
  - Check for superseded docs

- [ ] **Update DOCUMENTATION_INDEX.md**
  - Add new active documents
  - Remove archived documents
  - Fix broken links
  - Update health status

- [ ] **Verify Hugo sites**
  - Check site builds work
  - Verify deployment successful
  - Test navigation

- [ ] **Review plugin docs**
  - Check for outdated architecture docs
  - Verify implementation docs current
  - Update migration guides if needed

- [ ] **Review toolkit docs**
  - Verify guides are current
  - Update API docs if changed
  - Check troubleshooting relevance

---

## 🚫 What NOT to Do

### Don't:
1. **Delete historical documentation** - Archive instead
2. **Create duplicate documentation** - Update existing or consolidate
3. **Use generic filenames** - Be specific and descriptive
4. **Skip the index** - Always update DOCUMENTATION_INDEX.md
5. **Leave temporary files** - Clean up test results and temp docs
6. **Mix active and archived** - Keep clear separation
7. **Create deep nesting** - Keep structure flat and navigable
8. **Forget dates** - Always include "Last Updated"

---

## 📊 Documentation Health Metrics

### Good Health Indicators:
- ✅ < 30 active docs in `/docs/` root
- ✅ All docs in index or locally referenced
- ✅ Archive organized by category
- ✅ No root-level temp files
- ✅ Links work (run link checker)
- ✅ Updated within last 3 months

### Poor Health Indicators:
- ❌ > 50 files in `/docs/` root
- ❌ Temp/test files in root
- ❌ Duplicate documentation
- ❌ Broken links
- ❌ Outdated standards (> 6 months old)
- ❌ Mixed active and archived content

---

## 🛠️ Tools and Scripts

### Link Checking
```bash
# Check for broken links (if lychee installed)
cd docs && lychee **/*.md
```

### Find Old Files
```bash
# Files not modified in 90 days
find docs/ -name "*.md" -type f -mtime +90
```

### Check Documentation Structure
```bash
# Count files per directory
find docs/ -maxdepth 2 -type d -exec sh -c 'echo "$(find "$1" -maxdepth 1 -name "*.md" | wc -l) files: $1"' _ {} \;
```

### Verify No Temp Files
```bash
# Find potential temp files
find . -name "*temp*.md" -o -name "*test*.md" -o -name "*backup*.md" | grep -v archive
```

---

## 📚 Example Workflows

### Completing a Feature
```bash
# 1. Move implementation docs to archive
mv docs/FEATURE_IMPLEMENTATION.md docs/archive/implementation_results/

# 2. Update index
# Edit docs/DOCUMENTATION_INDEX.md
# Remove reference to FEATURE_IMPLEMENTATION.md

# 3. Update relevant active docs
# Edit standards/guides that reference the feature

# 4. Commit
git add docs/
git commit -m "docs: archive completed feature implementation"
```

### Creating New Standard
```bash
# 1. Create document
vim docs/NEW_STANDARD.md

# 2. Add front matter
# Include Purpose, Last Updated, Status

# 3. Update index
# Add to docs/DOCUMENTATION_INDEX.md under appropriate category

# 4. Announce
# Update relevant READMEs to reference new standard

# 5. Commit
git add docs/
git commit -m "docs: add new standard for [topic]"
```

### Monthly Cleanup
```bash
# 1. Find candidates
find docs/ -name "*.md" -type f -mtime +90 > /tmp/old_docs.txt

# 2. Review each
# Decide: Keep active, Archive, or Update

# 3. Archive completed docs
# Move to appropriate archive category

# 4. Update index
# Edit docs/DOCUMENTATION_INDEX.md

# 5. Commit
git add docs/
git commit -m "docs: monthly cleanup - archived N completed documents"
```

---

## 🎓 Best Practices

### Writing Documentation
1. **Start with why** - Purpose at the top
2. **Use clear headers** - Hierarchical structure
3. **Include examples** - Show, don't just tell
4. **Link related docs** - Build documentation web
5. **Keep it current** - Update or archive
6. **Be concise** - Respect reader's time

### Organizing Documentation
1. **Flat is better** - Avoid deep nesting
2. **Categories matter** - Group logically
3. **One topic, one doc** - Avoid mega-documents
4. **Index everything** - Make it discoverable
5. **Archive regularly** - Keep active docs clean

### Maintaining Documentation
1. **Monthly reviews** - Schedule regular cleanups
2. **Update dates** - Track freshness
3. **Fix broken links** - Test regularly
4. **Remove duplicates** - Consolidate content
5. **Preserve history** - Archive, don't delete

---

## 📞 Questions or Issues?

**Can't find a document?**  
→ Check `docs/DOCUMENTATION_INDEX.md` first  
→ Check `docs/archive/README.md` for historical docs

**Where should I add documentation?**  
→ See "Adding New Documentation" section above

**Should I archive this?**  
→ See "When to Archive Documentation" section above

**How do I maintain docs?**  
→ Follow "Monthly Maintenance Checklist"

---

**Guide Maintained By**: Documentation Team  
**Last Updated**: December 3, 2025  
**Next Review**: January 3, 2026
