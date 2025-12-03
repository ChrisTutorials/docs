---
title: Running Tests (Optional)
description: Guide for developers who want to run the plugin test suite
---


---




{{< gb-note >}}
Testing is optional. The plugin is fully validated before each release.
{{< /gb-note >}}

The Grid Building plugin includes a comprehensive test suite for developers who want to validate functionality or contribute to development.

## Test Coverage

<TestCoverage testCount="1540" version="5.0.0" ></TestCoverage>

## Accessing the Test Suite

<TestAccessInfo ></TestAccessInfo>

### Prerequisites

<TestingPrerequisites ></TestingPrerequisites>

### Running Tests via GUI

1. Extract the `.tar` export containing the plugin and tests
2. Open the project in Godot 4.5
3. Install and enable the GdUnit4 plugin (available from Godot Asset Library)
4. Open the GdUnit4 panel (usually docked at bottom of editor)
5. Navigate to `res://test/` to see all test suites
6. Click "Run All" to execute the complete test suite

### Running Tests via Command Line

For automated testing or CI:

```bash
# Run all tests
./scripts/testing/run_tests.sh

# Run specific test file
./scripts/testing/run_tests.sh --individual test/systems/manipulation/unit/managers/demolish_manager_unit_test.gd

# Show only failures
./scripts/testing/run_tests.sh --failures-only
```

## Test Organization

Tests are organized by system and type:
- `test/systems/` - System-level integration tests
- `test/utilities/` - Utility and helper tests  
- `test/rules/` - Rule validation tests
- `test/unit/` - Isolated unit tests

## For Contributors

If you're contributing to plugin development, please run the test suite before submitting changes to ensure all existing functionality remains intact.
