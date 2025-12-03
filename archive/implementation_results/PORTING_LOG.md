# Porting Log

## Session: RefCounted Objects Porting

### ManipulationData
- **Source**: `godot/addons/grid_building/systems/manipulation/manipulation_data.gd`
- **Destination**: `toolkit_cs/src/GodotToolkit.Common/Systems/Manipulation/ManipulationData.cs`
- **Changes**:
  - Converted to C# POCO.
  - Created `IManipulatable` interface to abstract `Manipulatable` node.
  - Properties are nullable to match GDScript runtime behavior (where references can be null).
  - Uses `ValidationResults` (POCO) instead of `MockValidationResults`.
  - Uses `GodotToolkit.Common.Types.GBEnums`.

### GBEnums
- **Status**: Consolidated.
- **Action**: Moved `GBEnums` from `GodotToolkit.Tests.Base` to `GodotToolkit.Common.Types` to be shared.
- **Update**: Updated `GodotToolkit.Tests` to use global using alias.

### MockManipulationData
- **Status**: Refactored.
- **Changes**: Now inherits from `ManipulationData`. Logic delegated to base class. `MockValidationResults` replaced with `ValidationResults`.

### Future Work
- **GeometryUtils**: `MockCollisionGeometryUtils` and related tests need to be updated to use `GodotToolkit.Common.Geometry.GeometryMath` and `Shape2D`/`Transform2D` types instead of mocks.
- **DemolishManagerUnitTest**: Fix nullable warnings due to `ManipulationData` properties becoming nullable.
