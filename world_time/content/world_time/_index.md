---
title: "WorldTime Plugin"
description: "Professional time and calendar system for Godot games"
date: 2025-12-01T00:00:00Z
draft: false
weight: 1
categories:
  - "worldtime"
  - "documentation"
tags:
  - "godot"
  - "time"
  - "calendar"
  - "day-night"
  - "plugin"
  - "csharp"
---


A powerful, flexible time and calendar system for Godot games. Built with C# for maximum performance and reliability.

## 🎯 Quick Start

### Installation
```bash
# Add to your Godot project
cp -r WorldTime /path/to/your/godot/project/addons/
```

### Basic Usage
```csharp
// Add to your scene
var worldTime = new WorldTimeNode();
AddChild(worldTime);

// Configure time system
worldTime.TimeScale = 60.0f; // 1 real second = 1 game minute
worldTime.StartTime = new TimeSpan(6, 0, 0); // Start at 6 AM

// Get current time
var currentTime = worldTime.CurrentTime;
var isDaytime = worldTime.IsDaytime;
var season = worldTime.CurrentSeason;
```

## 📚 Documentation

### 🚀 **For Users**
- **[Getting Started](getting-started/)** - Step-by-step tutorial
- **[API Reference](api-reference/)** - Complete API documentation
- **[Examples](examples/)** - Practical examples
- **[Configuration](configuration/)** - Time system setup

### 🏗️ **For Developers**
- **[Architecture](architecture/)** - System architecture and design
- **[Extending](extending-the-ageing-system/)** - Extending the system
- **[Implementation](implementation/)** - Implementation details

## ✨ Features

- **📅 Calendar Systems** - Custom time tracking and calendars
- **🌙 Day/Night Cycles** - Realistic time progression
- **⏰ Event Scheduling** - Time-based events and triggers
- **🌍 Seasonal Changes** - Dynamic environment and weather
- **⚡ High Performance** - Optimized for real-time games
- **🧪 Well Tested** - Comprehensive test coverage

## 🎮 Use Cases

- **Simulation Games** - Time management and progression
- **RPG Games** - Day/night mechanics and events
- **Strategy Games** - Time-based gameplay elements
- **Farming Games** - Seasonal systems and growth cycles
- **Adventure Games** - Time-locked content and events

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Godot Layer   │    │  Service Layer  │    │   State Layer   │
│                 │    │                 │    │                 │
│ • WorldTime     │◄──►│ • Time Service  │◄──►│ • TimeState     │
│   Node          │    │ • Calendar      │◄──►│ • CalendarState │
│ • UI Components │    │   Service       │    │ • EventConfig   │
│ • Environment   │    │ • Event Service │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🚀 Getting Help

- **[GitHub Repository](https://github.com/your-repo/worldtime)** - Source code and issues
- **[Discussions](https://github.com/your-repo/worldtime/discussions)** - Community discussions
- **[Troubleshooting](troubleshooting/)** - Common issues and solutions

---

**Ready to add time systems to your game?** Check out our [Getting Started](getting-started/) guide!
