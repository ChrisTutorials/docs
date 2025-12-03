# Immediate Test Porting Plan

## 🎯 **Phase 1: Fix Vector2 Conflicts & Re-enable Tests**

### **Current Issues**
- ManipulationTransformCalculatorUnitTest.cs - Excluded due to Vector2 conflicts
- CollisionGeometryRotatedObjectsTest.cs - Excluded due to Vector2 conflicts  
- MockManipulationTransformCalculator.cs - Excluded due to Vector2 conflicts

### **Action Items**
1. **Fix MockManipulationTransformCalculator.cs** 
   - Convert System.Numerics.Vector2 ↔ GodotToolkit.Common.Types.Vector2
   - Update method signatures to use Common types
   - Fix array type conversions

2. **Re-enable ManipulationTransformCalculatorUnitTest**
   - Remove from .csproj exclusion list
   - Fix Vector2 type conflicts in test methods
   - Verify all 15+ tests pass

3. **Re-enable CollisionGeometryRotatedObjectsTest**
   - Remove from .csproj exclusion list  
   - Fix Vector2 type conflicts in geometry calculations
   - Verify collision detection tests pass

### **Expected Outcome**
- +15 additional passing tests
- Vector2 type conflicts completely resolved
- Full manipulation system test coverage

---

## 🎯 **Phase 2: Port Missing Manipulation Managers**

### **Target Files** (High Priority)

#### 1. **FlipManagerUnitTest.cs**
```
📁 Source: /godot/addons/grid_building/test/grid_building/systems/manipulation/unit/managers/flip_manager_unit_test.gd
🎯 Purpose: Test flip manipulation functionality
📋 Test Cases:
- Flip with valid manipulatable
- Flip with null manipulatable  
- Flip with invalid settings
- Flip command generation
- Edge cases and error handling

⚡ Implementation:
- Create MockFlipManager
- Use ManipulationTestBase as base class
- Test flip logic and command generation
```

#### 2. **MoveWorkflowManagerUnitTest.cs**
```
📁 Source: /godot/addons/grid_building/test/grid_building/systems/manipulation/unit/managers/move_workflow_manager_unit_test.gd
🎯 Purpose: Test move workflow orchestration
📋 Test Cases:
- Move workflow initialization
- Move workflow execution
- Move workflow cancellation
- State transitions
- Error handling

⚡ Implementation:
- Create MockMoveWorkflowManager
- Test workflow state management
- Verify command generation and execution
```

#### 3. **PhysicsLayerManagerUnitTest.cs**
```
📁 Source: /godot/addons/grid_building/test/grid_building/systems/manipulation/unit/managers/physics_layer_manager_unit_test.gd
🎯 Purpose: Test physics layer management
📋 Test Cases:
- Layer validation
- Layer assignment
- Layer conflict resolution
- Physics interaction rules

⚡ Implementation:
- Create MockPhysicsLayerManager
- Test layer assignment logic
- Verify physics interaction rules
```

#### 4. **PlacementManagerUnitTest.cs**
```
📁 Source: /godot/addons/grid_building/test/grid_building/systems/manipulation/unit/managers/placement_manager_unit_test.gd
🎯 Purpose: Test placement management
📋 Test Cases:
- Placement validation
- Placement execution
- Placement cancellation
- State management
- Error handling

⚡ Implementation:
- Create MockPlacementManager
- Test placement logic and validation
- Verify state transitions
```

### **Implementation Strategy**
1. **Create Mock Classes** - Add to MockTypes.cs or create new files
2. **Use Existing Base Classes** - ManipulationTestBase, CSharpTestHelper
3. **Follow Established Patterns** - Same structure as ManipulationDataUnitTest
4. **Incremental Testing** - Port one manager at a time

---

## 🎯 **Phase 3: Port Advanced Geometry Tests**

### **Target Files** (Foundation Critical)

#### 1. **ConsolidatedGeometryTests.cs**
```
📁 Source: /godot/addons/grid_building/test/grid_building/helpers/utils/geometry/consolidated_geometry_tests.gd (27.8KB)
🎯 Purpose: Comprehensive geometry validation
📋 Test Categories:
- Vector2 operations and transformations
- Rectangle intersection and containment
- Polygon operations and validation
- Tile-based geometry calculations
- Physics matching utilities

⚡ Implementation:
- Use GeometryTestBase as base class
- Port test methods systematically
- Focus on core geometry algorithms
```

#### 2. **EdgeCaseTests.cs**
```
📁 Source: /godot/addons/grid_building/test/grid_building/helpers/utils/geometry/edge_case_tests.gd (7.4KB)
🎯 Purpose: Edge case handling and boundary conditions
📋 Test Categories:
- Zero-length vectors
- Degenerate polygons
- Extreme coordinate values
- Numerical precision issues

⚡ Implementation:
- Test edge cases systematically
- Verify numerical stability
- Use tolerance-based assertions
```

#### 3. **TileOverlapTests.cs**
```
📁 Source: /godot/addons/grid_building/test/grid_building/helpers/utils/geometry/tile_overlap_tests.gd (7.4KB)
🎯 Purpose: Tile overlap detection and resolution
📋 Test Categories:
- Tile intersection detection
- Overlap area calculation
- Overlap resolution strategies
- Performance optimization

⚡ Implementation:
- Test tile-based algorithms
- Verify overlap detection accuracy
- Test performance characteristics
```

### **Implementation Strategy**
1. **Extend GeometryTestBase** - Add geometry-specific helpers
2. **Use Common Types** - Ensure Vector2I, Rect2I consistency  
3. **Focus on Algorithms** - Port core geometry logic
4. **Performance Testing** - Verify algorithm efficiency

---

## 🎯 **Phase 4: Port Building System Tests**

### **Target Files** (Building Validation)

#### 1. **PlacementReportUnitTest.cs**
```
📁 Source: /godot/addons/grid_building/test/grid_building/systems/building/unit/validators/placement_report_unit_test.gd (7.9KB)
🎯 Purpose: Building placement reporting and validation
📋 Test Categories:
- Placement report generation
- Validation error reporting
- Success condition reporting
- Report formatting and display

⚡ Implementation:
- Create BuildingTestBase class
- Mock building system components
- Test report generation logic
```

#### 2. **Rect4x2BoundsValidationUnitTest.cs**
```
📁 Source: /godot/addons/grid_building/test/grid_building/systems/building/unit/validators/rect4x2_bounds_validation_unit_test.gd (12.5KB)
🎯 Purpose: Bounds validation for 4x2 rectangle placement
📋 Test Categories:
- Boundary condition testing
- Safe tile calculation
- Map area validation
- Pre-validation logic

⚡ Implementation:
- Create bounds validation tests
- Test boundary edge cases
- Verify safe tile algorithms
```

### **Implementation Strategy**
1. **Create BuildingTestBase** - Extend from GBTestBase
2. **Mock Building System** - Create necessary building mocks
3. **Test Validation Logic** - Focus on validation algorithms
4. **Integration Testing** - Test with building system components

---

## 🚀 **Phase 1: COMPLETED**

### ✅ **Tasks Completed**
1. **Fixed MockManipulationTransformCalculator.cs**
   - ✅ Converted System.Numerics.Vector2 → GodotToolkit.Common.Types.Vector2
   - ✅ Updated method signatures and distance calculations
   - ✅ Fixed TransformData class properties

2. **Fixed ManipulationTransformCalculatorUnitTest.cs**
   - ✅ Added using directive for GodotToolkit.Common.Types
   - ✅ Converted all Vector2 references throughout the file
   - ✅ Fixed test data creation and assertions

3. **Fixed CollisionGeometryRotatedObjectsTest.cs**
   - ✅ Converted remaining System.Numerics.Vector2 references
   - ✅ Fixed transform origin assignments

4. **Re-enabled Test Files**
   - ✅ Removed MockManipulationTransformCalculator.cs from exclusion
   - ✅ Removed ManipulationTransformCalculatorUnitTest.cs from exclusion
   - ✅ Removed CollisionGeometryRotatedObjectsTest.cs from exclusion

### ⚠️ **Blocking Issues**
- **Common Library Vector2 Conflicts**: The GodotToolkit.Common library has deeper Vector2 type conflicts that prevent compilation
- **69 compilation errors** in Common library related to Vector2 ambiguity
- **Obsolete Vector2 warnings**: GridTypes.cs and other files using deprecated Vector2 types
- **Tests ready to run** once Common library issues are resolved

### 🎯 **Technical Debt Identified**
- **Lint Warnings**: `Vector2 is obsolete: Use System.Numerics.Vector2 instead` in Common library
- **Migration Required**: Common library needs coordinated Vector2 type migration
- **Scope**: Affects GridTypes.cs, GodotTypes.cs, and other core Common types

### 📊 **Expected Impact (Once Common Library Fixed)**
- **+15 additional passing tests** from ManipulationTransformCalculatorUnitTest
- **+8 additional passing tests** from CollisionGeometryRotatedObjectsTest
- **Total**: 168 → 191+ passing tests

### **Week 2: Manipulation Managers**  
- **Day 1-2**: Port FlipManagerUnitTest
- **Day 3-4**: Port MoveWorkflowManagerUnitTest
- **Day 5**: Port PhysicsLayerManagerUnitTest
- **Target**: 200+ passing tests

### **Week 3: Geometry Advanced**
- **Day 1-3**: Port ConsolidatedGeometryTests
- **Day 4-5**: Port EdgeCaseTests and TileOverlapTests
- **Target**: 220+ passing tests

### **Week 4: Building System**
- **Day 1-3**: Port PlacementReportUnitTest  
- **Day 4-5**: Port Rect4x2BoundsValidationUnitTest
- **Target**: 235+ passing tests

---

## 📊 **Success Metrics**

### **Quantitative Goals**
- **Test Count**: 168 → 235+ passing tests
- **Coverage**: Manipulation 95%, Geometry 90%, Building 80%
- **Build Time**: <3s for full test suite
- **Success Rate**: 100% tests passing

### **Qualitative Goals**
- **Type Safety**: 100% C#-first patterns
- **Code Quality**: Follow established conventions
- **Maintainability**: Clear test structure and documentation
- **Reliability**: No flaky or integration-dependent tests

---

## 🛠 **Technical Requirements**

### **Development Environment**
- C# 8.0+ with nullable reference types
- xUnit testing framework
- Mock libraries (Moq or custom mocks)
- Global using directives for Common types

### **Code Standards**
- Follow existing C# naming conventions
- Use established base classes and helpers
- Maintain test isolation and independence
- Add comprehensive assertions and error messages

### **Documentation**
- Update CSPORTING_REMAINING_TASKS.md
- Document new test classes and patterns
- Maintain test coverage metrics
- Track progress against goals

This plan provides a clear, actionable roadmap for significantly expanding C# test coverage while maintaining the high quality standards already established.
