---
title: "GridBuilding 6.0 Readiness Status"
description: "Current readiness and test status for the GridBuilding 6.0 Core library and supporting tooling."
date: 2025-12-05T11:40:00-05:00
weight: 5
draft: false
type: "docs"
layout: "docs"
url: "/v6.0/guides/6-0-readiness-status/"
aliases: ["/latest/guides/6-0-readiness-status/", "/gridbuilding/latest/guides/6-0-readiness-status/"]
tags: ["status", "testing", "gridbuilding", "v6.0"]
---

# GridBuilding 6.0 Readiness Status

## Readiness Scores (0–10)

- **Core Library (C#)**: 9/10 — all tests enabled and green; only documentation warnings remain.
- **Godot Layer (C# + Godot 4.x)**: 2/10 — test projects do not currently restore; most Godot tests are quarantined or offline.

## Core Library (C#)

- **Target framework**: `net8.0`
- **Package management**:
  - Uses shared dependencies from `Directory.Build.props` (including `System.Text.Json` 9.x).
  - No duplicate `System.Text.Json` references in `Core/GridBuilding.Core.csproj`.

### Core Test Suite

- **Test project**: `Tests/Core/GridBuilding.Core.Tests.csproj`
- **Framework**: xUnit + Shouldly
- **Command**:
  - `dotnet test Tests/Core/GridBuilding.Core.Tests.csproj --verbosity minimal`
- **Status (as of 6.0)**:
  - Total tests: **639**
  - Failed: **0**
  - Skipped: **0**
  - All tests are green on .NET 8.0.

### Exclusions, Skips, and Quarantine Policy

- **Compile exclusions**:
  - `GridBuilding.Core.Tests.csproj` only excludes:
    - `bin/**`, `obj/**`, and `_incomplete/**`.
  - There are **no** `<Compile Remove="Tests/**" />` or similar patterns that would hide failing tests.
- **Skip attributes**:
  - `Tests/Core/Main` contains **no** `[Fact]`/`[Theory]` tests marked with `Skip = ...`.
- **Quarantine structure**:
  - Core tests follow the `Main/` vs `Quarantine/` pattern:
    - `Tests/Core/Main` → stable, always-green tests.
    - `Tests/Core/Quarantine` → isolation / experimental tests.
    - `Tests/Core/Quarantine/_TODO` → staging area for noisy/broken tests.
  - As of this readiness check:
    - `Tests/Core/Quarantine/_TODO` is **empty**.
    - `SimpleCoreTests.cs` exists but is currently an **empty file** (no active tests).

**Conclusion**: The **Core test suite is fully enabled and passing**, with no hidden exclusions and no tests parked in quarantine/TODO.

## How to Re‑Verify Locally

From the `GridBuilding` repository root:

```bash
dotnet test Tests/Core/GridBuilding.Core.Tests.csproj --verbosity minimal
```

You should see:

- Build succeeds on .NET 8.0.
- Test summary reports **639 succeeded**, **0 failed**, **0 skipped**.

## Godot Layer (C# + Godot 4.x)

### Current Status

- **Test project**: `Tests/Godot/GridBuilding.Godot.Tests.csproj`
- **Framework**: Chickensoft.GoDotTest + Chickensoft.GodotTestDriver
- **Command**:
  - `dotnet test Tests/Godot/GridBuilding.Godot.Tests.csproj --verbosity minimal`
- **Status**:
  - Restore currently **fails** with `NU1605` package downgrade errors:
    - `Godot.SourceGenerators`: test driver requires `>= 4.5.1`, project is on `4.4.0`.
    - `GodotSharp`: test driver requires `>= 4.5.1`, project is on `4.4.0`.
  - As a result, **0 tests execute**:
    - **Succeeded**: 0 (tests cannot run).
    - **Failed**: 0 (blocked before execution).

### Architecture Notes (6.0)

- The legacy `StateBridge` Godot node has been **removed** in 6.0.
- The canonical C#↔Godot integration boundary is now:
  - Core **services** and **domain events** on the C# side.
  - Godot **services/wrappers** (e.g. building, targeting) and **signals** directly from those services/nodes.
- No C# backwards‑compatibility layer is required for 6.0, since no C# release shipped with StateBridge.

### Test Inventory

- **Main suite**:
  - `Tests/Godot/Main/Integration/Types/AssetResolverTest.cs` — ~11 `[Test]` cases.
- **Quarantine / isolation (`Quarantine/_Legacy`)**:
  - `PlaceableEndToEndTest.cs` — ~a dozen `[Test]` cases (JSON/TOML/YAML → Core Placeable → Godot node flow).
  - `PlaceablePOCSLoadingTest.cs` — 25 `[Test]` cases (path handling and scene loading).
  - `PlaceablePOCSLoadingIsolationTest.cs` — 6 `[Test]` cases (focused isolation of the above).
- **Quarantine docs (`STATUS.md`) highlight**:
  - Namespace confusion between `GridBuilding.Core` and Godot layers.
  - API mismatches between Core and Godot types.
  - Missing fixture files and package dependencies (YamlDotNet, Tomlyn, etc.).

### Additional Risk Factors

- `Godot/GridBuilding.Godot.csproj` currently uses:
  - `<Compile Remove="Tests/**" />`, `<Compile Remove="*Test.cs" />`, `<Compile Remove="*Test*.cs" />`
  - This keeps Godot-side tests out of the main build, masking test regressions in the shipping assembly.

**Conclusion**: The **Godot test layer is not yet runnable** on 6.0 — all tests are effectively offline behind restore and API issues. This pulls the **Godot readiness score** down to **2/10** despite a rich test inventory.

## Scope of This Document

- This page tracks **Core library** and **Godot layer** readiness for GridBuilding 6.0.
- Other engine-specific layers (e.g. Unity) and their test suites are tracked separately and may have additional readiness criteria.

As new subsystems reach 6.0-ready status (API stability, tests green, docs updated), they should be added or linked from this page.
