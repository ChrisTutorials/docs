---
title: "DemoTestIsolation"
description: "Provides test isolation mechanisms for GridBuilding test environments
Ensures tests don't interfere with each other by managing state, resources, and cleanup"
weight: 20
url: "/gridbuilding/v6-0/api/godot/demotestisolation/"
---

# DemoTestIsolation

```csharp
GridBuilding.Godot.Tests.Isolation
class DemoTestIsolation
{
    // Members...
}
```

Provides test isolation mechanisms for GridBuilding test environments
Ensures tests don't interfere with each other by managing state, resources, and cleanup

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Tests/Unit/Helpers/DemoTestIsolation.cs`  
**Namespace:** `GridBuilding.Godot.Tests.Isolation`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Config

```csharp
#region Properties
    
    /// <summary>
    /// Configuration for test isolation
    /// </summary>
    public TestIsolationConfig Config { get; set; } = new();
```

Configuration for test isolation

### ActiveSessions

```csharp
/// <summary>
    /// Registry of isolated test sessions
    /// </summary>
    public Dictionary<string, TestSession> ActiveSessions { get; private set; } = new();
```

Registry of isolated test sessions


## Methods

### CreateIsolatedSession

```csharp
#endregion
    
    #region Session Management
    
    /// <summary>
    /// Creates a new isolated test session
    /// </summary>
    /// <param name="sessionName">Name of the test session</param>
    /// <param name="testType">Type of test being isolated</param>
    /// <returns>Created test session</returns>
    public TestSession CreateIsolatedSession(string sessionName, TestType testType)
    {
        var session = new TestSession
        {
            Name = sessionName,
            TestType = testType,
            StartTime = Time.GetUnixTimeFromSystem(),
            IsolationLevel = Config.DefaultIsolationLevel
        };
        
        // Create isolated environment
        session.IsolatedEnvironment = CreateIsolatedEnvironment(sessionName, testType);
        
        // Backup current state if needed
        if (session.IsolationLevel >= IsolationLevel.StateBackup)
        {
            BackupCurrentState(session);
        }
        
        // Register session
        ActiveSessions[sessionName] = session;
        
        GD.Print($"Created isolated test session: {sessionName} ({testType})");
        
        return session;
    }
```

Creates a new isolated test session

**Returns:** `TestSession`

**Parameters:**
- `string sessionName`
- `TestType testType`

### GetSession

```csharp
/// <summary>
    /// Gets an active test session
    /// </summary>
    /// <param name="sessionName">Name of the session</param>
    /// <returns>Test session if found, null otherwise</returns>
    public TestSession? GetSession(string sessionName)
    {
        return ActiveSessions.TryGetValue(sessionName, out var session) ? session : null;
    }
```

Gets an active test session

**Returns:** `TestSession?`

**Parameters:**
- `string sessionName`

### EndSession

```csharp
/// <summary>
    /// Ends a test session and performs cleanup
    /// </summary>
    /// <param name="sessionName">Name of the session to end</param>
    /// <returns>True if session was ended successfully</returns>
    public bool EndSession(string sessionName)
    {
        if (!ActiveSessions.TryGetValue(sessionName, out var session))
        {
            GD.PrintErr($"Test session not found: {sessionName}");
            return false;
        }
        
        try
        {
            // Cleanup isolated environment
            CleanupIsolatedEnvironment(session);
            
            // Restore state if needed
            if (session.IsolationLevel >= IsolationLevel.StateBackup)
            {
                RestoreState(session);
            }
            
            // Generate session report
            var report = GenerateSessionReport(session);
            GD.Print($"Session report for {sessionName}:\n{report}");
            
            // Remove session
            ActiveSessions.Remove(sessionName);
            
            GD.Print($"Ended isolated test session: {sessionName}");
            return true;
        }
        catch (System.Exception ex)
        {
            GD.PrintErr($"Error ending session {sessionName}: {ex.Message}");
            return false;
        }
    }
```

Ends a test session and performs cleanup

**Returns:** `bool`

**Parameters:**
- `string sessionName`

### EndAllSessions

```csharp
/// <summary>
    /// Ends all active test sessions
    /// </summary>
    public void EndAllSessions()
    {
        var sessionNames = new List<string>(ActiveSessions.Keys);
        foreach (var name in sessionNames)
        {
            EndSession(name);
        }
    }
```

Ends all active test sessions

**Returns:** `void`

### MonitorSessions

```csharp
#endregion
    
    #region Monitoring and Reporting
    
    /// <summary>
    /// Monitors all active sessions for issues
    /// </summary>
    public void MonitorSessions()
    {
        var issues = new List<string>();
        
        foreach (var kvp in ActiveSessions)
        {
            var session = kvp.Value;
            var sessionIssues = ValidateSession(session);
            issues.AddRange(sessionIssues.Select(issue => $"{kvp.Key}: {issue}"));
        }
        
        if (issues.Count > 0)
        {
            GD.PrintErr($"Session monitoring issues:\n{string.Join("\n", issues)}");
        }
    }
```

Monitors all active sessions for issues

**Returns:** `void`

### GetSessionStatistics

```csharp
/// <summary>
    /// Gets statistics about all active sessions
    /// </summary>
    public TestSessionStatistics GetSessionStatistics()
    {
        var stats = new TestSessionStatistics();
        
        foreach (var session in ActiveSessions.Values)
        {
            stats.TotalSessions++;
            
            switch (session.TestType)
            {
                case TestType.AllSystems:
                    stats.AllSystemsSessions++;
                    break;
                case TestType.Building:
                    stats.BuildingSessions++;
                    break;
                case TestType.Collision:
                    stats.CollisionSessions++;
                    break;
                case TestType.Demo:
                    stats.DemoSessions++;
                    break;
            }
            
            var duration = Time.GetUnixTimeFromSystem() - session.StartTime;
            stats.TotalDuration += duration;
            
            if (duration > stats.LongestSessionDuration)
            {
                stats.LongestSessionDuration = duration;
            }
        }
        
        stats.AverageSessionDuration = stats.TotalSessions > 0 ? stats.TotalDuration / stats.TotalSessions : 0;
        
        return stats;
    }
```

Gets statistics about all active sessions

**Returns:** `TestSessionStatistics`

### Cleanup

```csharp
#endregion
    
    #region Cleanup
    
    /// <summary>
    /// Cleans up all test isolation resources
    /// </summary>
    public void Cleanup()
    {
        // End all active sessions
        EndAllSessions();
        
        // Clear backups
        _globalContextsBackup = null;
        _sceneTreeBackup.Clear();
        _signalConnectionsBackup.Clear();
    }
```

Cleans up all test isolation resources

**Returns:** `void`

