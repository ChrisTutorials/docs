# Safe Test Runner Guide - CodeMad Timeout Strategy

## Overview

The safe test runner (`test-safe.sh`) provides reliable test execution with CodeMad timeout standards to prevent hanging test commands and ensure fast feedback.

## Location
`/toolkits/cs/scripts/test-safe.sh`

## Usage

### Basic Usage
```bash
# Test current project with default 30s timeout
./toolkits/cs/scripts/test-safe.sh .

# Test specific project with custom timeout
./toolkits/cs/scripts/test-safe.sh ./plugins/GridBuilding/Core 15

# Test with ultra-fast 8s timeout (CodeMad standard)
./toolkits/cs/scripts/test-safe.sh ./plugins/GridBuilding/Core/Tests 8
```

### Parameters
- **PROJECT_PATH**: Path to test project (default: current directory)
- **TIMEOUT_SECONDS**: Timeout in seconds (default: 30)

## CodeMad Timeout Standards

### Recommended Timeouts
- **Unit Tests**: 8 seconds
- **Integration Tests**: 15 seconds  
- **Full Test Suite**: 30 seconds
- **Complex Test Scenarios**: 60 seconds (rare exception)

### Philosophy
- **Fast Fail**: Timeout quickly rather than hanging indefinitely
- **Developer Experience**: No waiting around for slow tests
- **Performance Optimization**: Slow tests should be optimized, not accommodated

## Features

### Pre-Build Validation
```bash
🔨 Pre-build check...
✅ Build successful - Running tests with timeout...
```
- Ensures project builds before running tests
- Prevents test execution on broken builds
- Provides immediate feedback on build failures

### Timeout Protection
```bash
⚡ FAST FAIL: Test execution timed out after 15s - optimize your tests!
💡 Consider:
  • Reducing test complexity
  • Using mocks instead of real dependencies
  • Running tests in parallel
  • Splitting large test classes
```

### Clear Exit Codes
- **0**: All tests passed
- **124**: Timeout occurred (fast fail)
- **1**: Build failed
- **Other**: Test execution failed

## Integration Examples

### GridBuilding Core Tests
```bash
cd /home/chris/game_dev/plugins/GridBuilding/Core
./toolkits/cs/scripts/test-safe.sh . 15
```

### AgentFramework Tests
```bash
cd /home/chris/game_dev/plugins/AgentFramework
./toolkits/cs/scripts/test-safe.sh tests_temp/ 8
```

### Solution-Level Testing
```bash
cd /home/chris/game_dev
./toolkits/cs/scripts/test-safe.sh ./plugins/GridBuilding 30
```

## Troubleshooting

### Common Issues

#### Build Failures
```
❌ BUILD FAILED - Tests cannot run
Last 5 lines of build log:
  /path/to/file.cs(42,15): error CS0246: Type not found
```
**Solution**: Fix build errors before running tests

#### Timeouts
```
⚡ FAST FAIL: Test execution timed out after 15s
```
**Solutions**:
- Use mocks instead of real dependencies
- Split large test classes
- Optimize test data setup
- Run tests in parallel

#### Hanging Commands (No Output)
```
# Command hangs indefinitely with no output
./toolkits/cs/scripts/test-safe.sh . 15
# ^C (user cancels)
```
**Root Cause**: Same underlying issue causing dotnet commands to hang
**Emergency Solutions**:
```bash
# 1. Direct CSC compilation (bypass MSBuild)
csc /target:library /out:GridBuilding.Core.dll src/**/*.cs

# 2. Minimal build pattern
dotnet build --no-restore --verbosity minimal --parallel false

# 3. Clear package cache first
rm -rf ~/.nuget/packages/temp
dotnet nuget locals all --clear
dotnet restore --verbosity minimal

# 4. Test without build
dotnet test --no-build --verbosity normal
```

#### Test Failures
```
❌ Tests failed with exit code: 1
💡 Run with higher verbosity for details:
  dotnet test "/path/to/project" --verbosity normal
```

## Best Practices

### 1. Use Appropriate Timeouts
- **Simple unit tests**: 8 seconds
- **Integration tests**: 15 seconds
- **Complex scenarios**: 30 seconds maximum

### 2. Optimize Slow Tests
- Mock external dependencies
- Use in-memory databases
- Pre-generate test data
- Parallelize independent tests

### 3. CI/CD Integration
```yaml
# GitHub Actions example
- name: Run Tests
  run: ./toolkits/cs/scripts/test-safe.sh ./plugins/GridBuilding/Core 15
```

### 4. Local Development
```bash
# Make it available globally
alias test-safe="./toolkits/cs/scripts/test-safe.sh"

# Quick test with standard timeout
test-safe . 8
```

## Performance Metrics

### Success Indicators
- ✅ Test completion < timeout duration
- ✅ Zero hanging processes
- ✅ Immediate feedback on failures
- ✅ Consistent execution times

### Monitoring
- Track timeout frequency (target: < 5%)
- Monitor average test duration
- Alert on consistently slow tests
- Optimize tests that approach timeout limits

## Emergency Fallback Methods

### When All Else Fails

If dotnet commands continue to hang, use these emergency approaches:

#### 1. Direct CSC Compilation
```bash
# Bypass MSBuild entirely
csc /target:library /out:GridBuilding.Core.dll src/**/*.cs /r:System.Text.Json.dll
```

#### 2. Manual Test Execution
```bash
# Compile tests manually
csc /target:library /out:Tests.dll Tests/**/*.cs /r:GridBuilding.Core.dll /r:xunit.dll

# Run with test runner directly
dotnet xunit Tests.dll
```

#### 3. Isolated Environment
```bash
# Create isolated test environment
mkdir /tmp/test_isolation
cp -r . /tmp/test_isolation/
cd /tmp/test_isolation

# Try with minimal configuration
dotnet new console --force
# Copy source files manually
# Test compilation
```

#### 4. Alternative Build Tools
```bash
# Use MSBuild directly with detailed logging
msbuild GridBuilding.Core.csproj /v:detailed /fl /flp:logfile=build.log

# Or use dotnet with explicit project file
dotnet build GridBuilding.Core.csproj /p:Configuration=Debug /v:minimal
```

## Advanced Usage

### Custom Test Runners
```bash
# Extend for specific test frameworks
./toolkits/cs/scripts/test-safe.sh . 15 -- xunit
./toolkits/cs/scripts/test-safe.sh . 15 -- nunit
```

### Parallel Execution
```bash
# Run multiple test projects in parallel
for project in Core Tests Integration; do
  ./toolkits/cs/scripts/test-safe.sh "./plugins/GridBuilding/$project" 15 &
done
wait
```

## File Structure

```
toolkits/cs/
├── scripts/
│   └── test-safe.sh          # Safe test runner
├── README.md                 # Toolkit documentation
└── ...                       # Other tools
```

## Dependencies

- **bash**: Standard shell interpreter
- **timeout**: GNU coreutils command
- **dotnet**: .NET CLI (test command)

## Related Tools

- **CodeMad Timeout Strategy**: Ultra-fast execution philosophy
- **JsonHelper**: Safe JSON operations
- **CodeAnalysis**: Project metrics and validation

---

**Safe Test Runner**: Fast, Reliable, and Productive Testing! ⚡
