# Owner-Based Registration & Multi-Scope Architecture – Goals

**Purpose:** Track the concrete steps required to move GridBuilding to the Owner-based, multi-scope (Process → Session → Owner) architecture described in the v6.0 dependency resolution guide.

---

## 1. Architectural Decisions (Snapshot)

- **Owner as core concept**
  - An Owner can be a human player, AI, neutral/environment, or other controller.
  - Public API uses Owner-centric naming (`OwnerConfig`, `OwnerHandle`, etc.).

- **Lifetimes**
  - **Process:** one per game process.
  - **Session:** one per world/match.
  - **Owner:** one per (session, owner).

- **Modules**
  - Each plugin exposes an `IGameModule` (name TBD) with:
    - `RegisterProcessServices`
    - `RegisterSessionServices`
    - `RegisterOwnerServices`

- **Registration path**
  - There is a single “blessed” way to create Owners, e.g. `session.CreateOwner(OwnerConfig config)`.
  - Godot side should use a provided base/root node (e.g. `OwnerRootBase`) that integrates with this API.

---

## 2. Goals / Tasks (High Level)

### 2.1 Core DI and lifetimes

- [ ] Define **Process/Session/Owner** service builders and scopes.
- [ ] Extend or wrap `ServiceRegistry` to support multiple scopes (session + owner).
- [ ] Implement `IGameModule` (or equivalent) with process/session/owner registration methods.
- [ ] Update the GridBuilding module to use the new registration model.

### 2.2 Owner creation and handles

- [ ] Define `OwnerId`, `OwnerConfig`, and `OwnerHandle` types.
- [ ] Implement `Session.CreateOwner(OwnerConfig config)` (or equivalent central API).
- [ ] Ensure `CreateOwner`:
  - [ ] Creates an Owner scope under the correct Session.
  - [ ] Invokes all modules’ `RegisterOwnerServices`.
  - [ ] Returns a stable handle that can be stored on nodes and services.

### 2.3 Session management

- [ ] Define a `Session` abstraction (if not already present) with:
  - [ ] `CreateSession(SessionConfig config)`.
  - [ ] Lifetime management for Session scopes.
- [ ] Ensure process bootstrap:
  - [ ] Discovers all `IGameModule` instances.
  - [ ] Calls `RegisterProcessServices` once.
  - [ ] Wires session creation so it always goes through the new API.

### 2.4 Godot integration (SessionRoot / OwnerRoot)

- [ ] Design a `SessionRoot` Godot node pattern:
  - [ ] Associates a scene subtree with a Session.
  - [ ] Holds or can resolve the Session scope.
- [ ] Design an `OwnerRoot` (or `OwnerRootBase`) node pattern:
  - [ ] Associates a subtree with a specific Owner.
  - [ ] On `_Ready`, registers itself with the session/owner system (no per-plugin calls).
- [ ] Update key GridBuilding Godot nodes to:
  - [ ] Resolve their dependencies from the appropriate **Owner scope**.
  - [ ] Avoid direct reliance on a single global `ServiceCompositionRoot`.

### 2.5 Plugin integration

- [ ] Implement `IGameModule` for the GridBuilding plugin:
  - [ ] Classifies existing services as process/session/owner.
  - [ ] Moves registrations out of ad-hoc bootstrap code into the module.
- [ ] Define guidance for **other plugins**:
  - [ ] How to implement `IGameModule`.
  - [ ] How to register owner-specific services (e.g. UI controllers, input mapping, per-side state).

### 2.6 Compatibility and migration

- [ ] Audit all usages of `ServiceCompositionRoot.GetGlobalService<T>()`.
  - [ ] Classify them as process/session/owner, and route through scopes.
- [ ] Decide how `CompositionContainer` fits:
  - [ ] Ensure it can still be constructed from a given Session/Owner scope.
  - [ ] Document that it is primarily a compatibility layer.
- [ ] Add tests to verify:
  - [ ] Multiple Owners in one Session do not leak state.
  - [ ] Multiple Sessions in one process do not leak state.
  - [ ] Legacy APIs still function when wired via the new scopes.

---

## 3. Documentation Tasks

- [ ] Keep `content/v6.0/guides/dependency-resolution.md` updated with:
  - [ ] Owner definition and lifetimes.
  - [ ] Owner registration flow.
  - [ ] Example patterns for Godot nodes (SessionRoot, OwnerRoot).
- [ ] Add a short “Owner vs Player vs AI” glossary entry in public docs.

---

## 4. Open Questions / Parking Lot

Use this section to collect decisions that still need design:

- [ ] Exact naming for module interface (`IGameModule` vs `IGridBuildingModule` etc.).
- [ ] Exact naming and types for Owner API (`OwnerId` vs `OwnerKey`, etc.).
- [ ] How much of this is surfaced in the public Godot API vs internal C# only.
