---
title: "GridBuilding 6.0 Mode Architecture"
description: "How global modes are managed in GridBuilding 6.0 using a dedicated Mode Service."
date: 2025-12-05T14:30:00-05:00
weight: 15
draft: false
type: "docs"
layout: "docs"
url: "/v6.0/guides/mode-architecture/"
aliases: ["/latest/guides/mode-architecture/", "/gridbuilding/latest/guides/mode-architecture/"]
tags: ["architecture", "modes", "gridbuilding", "v6.0"]
---

> **Note:** The v6.0 documentation tracks the in-progress **Grid Placement 6.0 (C#)** line.
> It is an internal roadmap/preview and should not be treated as a promised public release or timeline.
> The current GDScript release line is **v5.1**.

# GridBuilding 6.0 Mode Architecture

## What is the Mode Service?

In GridBuilding 6.0, global modes are managed by a dedicated **Mode Service** instead of being exposed directly to UI or gameplay scripts.

- **ModeState** is an internal data object that tracks:
  - Application mode (e.g. building vs playing).
  - UI mode.
  - Edit mode.
  - View mode.
  - Game mode.
- **IModeService** is the public C# interface that owns a single `ModeState` instance and exposes:
  - Methods to change modes (e.g. `SetApplicationMode`, `SetModes`).
  - Events that fire when modes change.

This keeps all mode logic concentrated in one place and makes it easier to test, reason about, and extend.

## Why We Changed It in 6.0

Earlier prototypes allowed Godot nodes and other systems to talk directly to a shared `ModeState` object or legacy injector containers. This created several issues:

- UI elements were tightly coupled to an implementation detail (`ModeState`).
- There was no single place to coordinate cross‑system behavior when modes change.
- Tests had to build ad‑hoc mocks for mode handling.

6.0 replaces that with a **service‑oriented design**:

- Core mode data lives in `ModeState`.
- All reads and writes go through `IModeService`.
- Engine layers (Godot, Unity, etc.) receive a **clean service boundary** instead of raw state.

## How the Mode Service Fits the Overall Architecture

GridBuilding 6.0 uses a consistent pattern for core gameplay services:

- Placement: `IPlacementService`
- Manipulation: `IManipulationService`
- Targeting: `IGridTargetingService`
- **Modes: `IModeService`**

All of these are registered in the GridBuilding **Service Registry** and wired by a Godot‑side `ServiceCompositionRoot` node.

From an engine's point of view:

- The engine layer resolves services from the registry.
- Systems and UI components listen to service events and call service methods.
- Core logic remains engine‑agnostic and testable on pure .NET.

## Typical Usage (High Level)

When running inside Godot, the workflow looks like this:

1. A `ServiceCompositionRoot` node starts up and registers all core services, including `IModeService`.
2. Systems or UI nodes resolve `IModeService` from the shared `ServiceRegistry`.
3. To **change** modes, they call methods like:
   - `modeService.SetApplicationMode(ApplicationMode.Building)`
   - or `modeService.SetModes(appMode: ApplicationMode.Building, uiMode: UIMode.Normal)`
4. To **react** to changes, they subscribe to events on `IModeService` instead of wiring directly to internal state.

From the perspective of a game integrator, you interact with modes by:

- Listening to mode change events (to update your own UI or gameplay scripts).
- Invoking clearly named service methods when you want to change how the system behaves.

## Backwards Compatibility and Migration Notes

- The new Mode Service is part of the **6.0** architecture and is the recommended way to work with modes.
- Older Godot‑specific patterns that mutated `ModeState` directly or used legacy injector containers are being migrated to use `IModeService` internally.
- No public C# API was previously shipped that requires a direct `ModeState` reference, so game code should not need breaking changes.

If you are upgrading from an internal prototype that used direct `ModeState` access:

- Replace any code that sets fields on a shared `ModeState` with calls to `IModeService`.
- Replace direct subscriptions on `ModeState` with `IModeService` events.

## Where to Learn More

- **Internal contributors** can find a detailed technical design in the C# plugin repository under:
  - `docs/reports/MODE_SERVICE_ARCHITECTURE.md`
- For a broader view of 6.0 readiness and test status, see:
  - [GridBuilding 6.0 Readiness Status](/v6.0/guides/6-0-readiness-status/)

