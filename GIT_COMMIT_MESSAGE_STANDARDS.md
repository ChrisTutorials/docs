# Git Commit Message Standards

## Overview

This document establishes standards for reasonably verbose Git commit messages to ensure traceability of changes, especially for commits affecting many files or complex refactoring operations.

## 🎯 Purpose

- **Traceability**: Easy to understand what changed and why
- **Context**: Future developers can understand the reasoning
- **Debugging**: Quick identification of when issues were introduced
- **Documentation**: Self-documenting commit history

---

## 📝 Commit Message Structure

### Basic Format
```
<type>(<scope>): <subject>

<reasoning>

<changes-made>

<impact-verification>

<technical-details>
```

### Field Descriptions

#### **Type** (Required)
- `feat`: New feature or functionality
- `fix`: Bug fix or issue resolution  
- `refactor`: Code restructuring without functional changes
- `docs`: Documentation updates
- `test`: Test-related changes (adding, fixing, moving tests)
- `chore`: Maintenance, cleanup, dependency updates
- `perf`: Performance improvements
- `style`: Code formatting, style fixes (no functional change)
- `build`: Build system, dependency management changes

#### **Scope** (Required)
- Specific area of the codebase affected
- Examples: `GridBuilding`, `AgentFramework`, `Documentation`, `CI/CD`
- Use PascalCase for consistency

#### **Subject** (Required)
- 50-72 character limit
- Present tense, imperative mood ("Add feature" not "Added feature")
- No period at end
- Clear and concise what was done

#### **Reasoning** (Required)
- **Why** this change was necessary
- What problem was being solved
- Business or technical justification
- Reference to issues/discussions if applicable

#### **Changes Made** (Required for large commits)
- High-level summary of what was changed
- For commits touching >10 files, use bullet points
- Include file counts and directories affected
- Mention any architectural shifts

#### **Impact Verification** (Required)
- How the change was tested/verified
- What metrics or tests confirm success
- Performance impact if measurable
- Any breaking changes noted

#### **Technical Details** (Optional)
- Specific implementation notes
- Dependencies added/removed
- Configuration changes
- Migration steps needed

---

## 📋 Templates

### Small Commit (<10 files)
```
feat(GridBuilding): Add collision detection optimization

Reasoning:
The previous collision detection algorithm was O(n²) and causing performance issues
in scenarios with >100 objects. This was identified in issue #123.

Changes Made:
- Implemented spatial hashing algorithm
- Added CollisionGrid class with O(1) lookup
- Updated existing collision methods to use grid
- Added performance benchmarks

Impact Verification:
- Unit tests: 15 new tests, all passing
- Performance: 95% improvement in 100+ object scenarios
- Backward compatibility: All existing APIs preserved
- Memory usage: 15% increase in grid storage
```

### Large Commit (10+ files)
```
refactor(GridBuilding): Eliminate test exclusion anti-pattern and centralize documentation

Reasoning:
The project was using <Compile Remove="Tests/**" /> in Core projects to achieve compilation,
which violated testing best practices and hid 726 working tests from execution. This created
false build success and prevented proper CI/CD test coverage. Additionally, testing standards
were scattered across 8+ documentation files with inconsistencies.

Changes Made:
• GridBuilding Core: Removed test exclusion from GridBuilding.Core.csproj
• Test Structure: Moved 726 Xunit tests to plugin-level Tests/ directory
• Documentation: Created CENTRALIZED_TESTING_STANDARDS.md (542 lines)
• Documentation: Updated PROJECT_STRUCTURE_STANDARDS.md to remove anti-pattern
• Documentation: Updated TECHNICAL_DEBT_STATUS.md with completed fixes
• Documentation: Updated HEALTH_ASSESSMENT.md with corrected structure
• Documentation: Created DOCUMENTATION_INDEX.md for centralized navigation
• File Impact: 11 files changed, 552 insertions(+), 22 deletions(-)
• Test Impact: 726 tests now passing without exclusions
• Godot Tests: 291 GoDotTest tests properly separated

Impact Verification:
- Build Success: GridBuilding.Core compiles without test exclusions
- Test Execution: 726 Xunit tests pass, 291 Godot tests pass
- Documentation: All inconsistencies resolved, centralized standards created
- Performance: No regression in build or test execution time
- Breaking Changes: None - all existing functionality preserved

Technical Details:
- Xunit tests moved from Core/Tests/ to Tests/ at plugin level
- GoDotTest tests remain in Godot/Tests/ (proper framework separation)
- Core projects now exclude only engine-specific files (Godot/**, Unity/**)
- Documentation follows CodeMad timeout standards and anti-pattern prevention
- Git LFS objects: No changes to binary assets
```

### Documentation Commit
```
docs(Testing): Centralize testing standards and eliminate anti-patterns

Reasoning:
Testing standards were scattered across PROJECT_STRUCTURE_STANDARDS.md,
GODOT_INTEGRATION_TESTING_STANDARDS.md, SAFE_TEST_RUNNER_GUIDE.md, and
various project-specific documentation. This created inconsistencies and the
test exclusion anti-pattern was documented as "standard practice" in
PROJECT_STRUCTURE_STANDARDS.md.

Changes Made:
- Created CENTRALIZED_TESTING_STANDARDS.md (comprehensive 285-line guide)
- Updated PROJECT_STRUCTURE_STANDARDS.md to remove test exclusion recommendation
- Created DOCUMENTATION_INDEX.md for centralized navigation
- Updated TECHNICAL_DEBT_STATUS.md with completed anti-pattern fixes
- Updated HEALTH_ASSESSMENT.md to reflect corrected test structure
- Consolidated all testing framework standards (Xunit, GoDotTest)
- Added CodeMad timeout standards and performance requirements
- Established quality gates and success metrics

Impact Verification:
- Documentation Review: All inconsistencies identified and resolved
- Cross-Reference: DOCUMENTATION_INDEX.md links to all relevant docs
- Standards Compliance: Anti-patterns explicitly prohibited
- Implementation: GridBuilding successfully migrated to new standards
- Traceability: Clear change history and decision rationale documented

Technical Details:
- Anti-Pattern Section: Explicit prohibition of <Compile Remove="Tests/**" />
- Framework Separation: Clear guidelines for Xunit vs GoDotTest usage
- Timeout Standards: CodeMad compliance (8s unit, 15s integration, 30s suite)
- Project Structure: Updated multi-engine standards with proper test placement
- Migration Guidelines: Step-by-step instructions for existing projects
```

---

## 🚫 Anti-Patterns to Avoid

### Poor Subject Lines
```
❌ "fixed stuff"
❌ "update" 
❌ "wip"
❌ "bug fix"
❌ "docs update"

✅ "fix(GridBuilding): Resolve null reference in collision detection"
✅ "docs(API): Add authentication flow documentation"
✅ "refactor(Tests): Move test files to plugin-level structure"
```

### Missing Reasoning
```
❌ "Add new tests"

✅ "Add comprehensive test coverage for collision detection

Reasoning:
Previous collision detection had only 30% test coverage and several edge cases
were causing production issues. This was identified in incident report #456."
```

### No Impact Verification
```
❌ "Refactor service locator pattern"

✅ "Refactor service locator pattern

Impact Verification:
- Unit tests: All 45 existing tests pass
- Performance: 20% improvement in service resolution
- Memory usage: 10% reduction in object allocations
- Breaking changes: None - all public APIs preserved"
```

---

## 📊 Large Commit Guidelines

### When to Use Detailed Messages
- **10+ files changed**
- **Multiple directories affected**
- **Architectural changes**
- **Breaking changes**
- **Performance optimizations**
- **Major refactoring**

### Required Elements for Large Commits
1. **File Count**: Always include number of files/directories affected
2. **Test Coverage**: Mention test impact and verification
3. **Performance**: Include measurable impact if applicable
4. **Breaking Changes**: Explicitly call out any breaking changes
5. **Dependencies**: Note any dependency additions/removals

### Example Large Commit Template
```
<type>(<scope>): <subject>

Reasoning:
<Why this change was necessary - business/technical justification>

Changes Made:
• <High-level summary of changes>
• <File counts and directories affected>
• <Architectural shifts if any>
• <Key components modified>

Impact Verification:
- <How change was tested/verified>
- <Performance impact if measurable>
- <Test coverage impact>
- <Breaking changes if any>

Technical Details:
- <Implementation notes>
- <Dependencies added/removed>
- <Configuration changes>
- <Migration steps if needed>

Files Changed: <number> files, <insertions> insertions(+), <deletions> deletions(-)
```

---

## 🔍 Verification Checklist

Before committing, verify your message includes:

### For All Commits
- [ ] Type and scope are correct
- [ ] Subject is clear and under 72 characters
- [ ] Reasoning explains WHY the change was made
- [ ] Impact verification is included

### For Large Commits (10+ files)
- [ ] File counts and directories listed
- [ ] Architectural changes explained
- [ ] Test impact described
- [ ] Performance impact measured (if applicable)
- [ ] Breaking changes explicitly noted

### For Documentation Commits
- [ ] Documents referenced are linked
- [ ] Inconsistencies resolved are mentioned
- [ ] New standards are clearly explained
- [ ] Implementation examples provided

---

## 📚 Examples Repository

### Feature Addition
```
feat(AgentFramework): Add configuration validation with error reporting

Reasoning:
Configuration files were silently accepting invalid values, causing runtime errors
that were difficult to debug. Users requested better validation and clear error
messages in issue #789.

Changes Made:
- Added ConfigurationValidator class with rule-based validation
- Implemented ValidationError with detailed error reporting
- Added validation to all configuration loading methods
- Created comprehensive unit tests for validation scenarios
- Updated error handling to provide actionable error messages

Impact Verification:
- Unit Tests: 23 new tests, all passing
- Error Reporting: Clear validation errors with line numbers
- Backward Compatibility: Existing configurations continue to work
- Performance: 5ms validation overhead on config load

Technical Details:
- Validation rules defined in ConfigurationRules.cs
- Error messages include file path, line number, and specific issue
- Validation can be bypassed with ValidateOnLoad=false flag
- Added Shouldly assertions for test readability
```

### Bug Fix
```
fix(GridBuilding): Resolve memory leak in collision detection cleanup

Reasoning:
CollisionDetectionManager was not disposing IDisposable objects in the
Dispose() method, causing memory leaks in long-running sessions. This was
identified through memory profiling in issue #234.

Changes Made:
- Fixed CollisionDetectionManager.Dispose() to properly dispose all objects
- Added unit tests to verify proper disposal
- Updated object lifecycle documentation
- Added memory usage validation in performance tests

Impact Verification:
- Memory Profiling: No more memory leaks in 24-hour stress test
- Unit Tests: 8 new disposal tests, all passing
- Performance: No regression in collision detection performance
- Backward Compatibility: No API changes

Technical Details:
- Added using statements for all IDisposable fields
- Implemented proper disposal pattern with Dispose(bool)
- Added GC.Collect() in tests to verify memory cleanup
- Memory usage reduced from 150MB to 45MB in stress test
```

---

## 🎯 Implementation Guidelines

### Writing Style
- **Present tense**: "Add feature" not "Added feature"
- **Imperative mood**: "Fix bug" not "Fixes bug"
- **Clear language**: Avoid jargon and abbreviations
- **Specific details**: Include numbers, measurements, file counts

### Review Process
1. **Self-review**: Read message aloud to check clarity
2. **Peer review**: Have team member review for large commits
3. **Automated checks**: Ensure commit message follows format
4. **Documentation**: Update relevant documentation if needed

### Tools and Integration
- **Git Hooks**: Enforce message format in pre-commit hooks
- **CI/CD**: Validate commit message structure in pipelines
- **IDE Integration**: Use commit message templates in IDE
- **Code Review**: Include commit message review in PR process

---

**Last Updated**: December 2, 2025  
**Version**: 1.0  
**Status**: Active Standard
