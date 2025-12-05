---
title: "ConfirmationDialog"
description: ""
weight: 20
url: "/gridbuilding/v6.0-public/api/godot/confirmationdialog/"
---

# ConfirmationDialog

```csharp
GridBuilding.Godot.Systems.Manipulation.Managers
class ConfirmationDialog
{
    // Members...
}
```

Simple confirmation dialog for demolition

**Project:** GridBuilding v6.0  
**Layer:** Godot  
**Source:** `Godot/Systems/Manipulation/Managers/DemolishManager.cs`  
**Namespace:** `GridBuilding.Godot.Systems.Manipulation.Managers`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### Message

```csharp
#endregion
    
    #region Properties
    
    public string Message { get; set; } = string.Empty;
```

### ConfirmText

```csharp
public string ConfirmText { get; set; } = "Confirm";
```

### CancelText

```csharp
public string CancelText { get; set; } = "Cancel";
```


## Methods

### _Ready

```csharp
#endregion
    
    #region Godot Lifecycle
    
    public override void _Ready()
    {
        // Configure dialog
        DialogText = Message;
        
        // Get or create buttons
        var okButton = GetOkButton();
        var cancelButton = GetCancelButton();
        
        if (okButton != null)
        {
            okButton.Text = ConfirmText;
        }
        
        if (cancelButton != null)
        {
            cancelButton.Text = CancelText;
        }
        
        // Connect signals
        Confirmed += OnDialogConfirmed;
        Canceled += OnDialogCancelled;
    }
```

**Returns:** `void`

