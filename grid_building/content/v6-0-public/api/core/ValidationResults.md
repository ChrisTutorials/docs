---
title: "ValidationResults"
description: "Results of validation operations on game objects or manipulations.
Pure C# implementation without Godot dependencies."
weight: 10
url: "/gridbuilding/v6-0-public/api/core/validationresults/"
---

# ValidationResults

```csharp
GridBuilding.Core.Results
class ValidationResults
{
    // Members...
}
```

Results of validation operations on game objects or manipulations.
Pure C# implementation without Godot dependencies.

**Project:** GridBuilding v6.0  
**Layer:** Core  
**Source:** `Core/Results/ValidationResults.cs`  
**Namespace:** `GridBuilding.Core.Results`  
**Parsing Method:** AST-based (Roslyn) - NOT regex

**⚠️ IMPORTANT**: This documentation was generated using AST parsing, not regex.


## Properties

### IsValid

```csharp
#region Properties

        /// <summary>
        /// Overall validation result.
        /// </summary>
        public bool IsValid { get; private set; }
```

Overall validation result.

### Errors

```csharp
/// <summary>
        /// List of validation errors.
        /// </summary>
        public List<ValidationError> Errors { get; private set; }
```

List of validation errors.

### Warnings

```csharp
/// <summary>
        /// List of validation warnings.
        /// </summary>
        public List<ValidationWarning> Warnings { get; private set; }
```

List of validation warnings.

### Info

```csharp
/// <summary>
        /// List of informational messages.
        /// </summary>
        public List<ValidationInfo> Info { get; private set; }
```

List of informational messages.

### ValidatedAt

```csharp
/// <summary>
        /// Timestamp when validation was performed.
        /// </summary>
        public DateTime ValidatedAt { get; private set; }
```

Timestamp when validation was performed.

### Context

```csharp
/// <summary>
        /// Optional context for the validation.
        /// </summary>
        public Dictionary<string, object> Context { get; set; } = new();
```

Optional context for the validation.

### HasErrors

```csharp
/// <summary>
        /// Checks if there are any errors.
        /// </summary>
        public bool HasErrors => Errors.Count > 0;
```

Checks if there are any errors.

### HasWarnings

```csharp
/// <summary>
        /// Checks if there are any warnings.
        /// </summary>
        public bool HasWarnings => Warnings.Count > 0;
```

Checks if there are any warnings.

### HasInfo

```csharp
/// <summary>
        /// Checks if there are any info messages.
        /// </summary>
        public bool HasInfo => Info.Count > 0;
```

Checks if there are any info messages.


## Methods

### Success

```csharp
#endregion

        #region Static Factory Methods

        /// <summary>
        /// Creates a successful validation result.
        /// </summary>
        public static ValidationResults Success()
        {
            return new ValidationResults(true);
        }
```

Creates a successful validation result.

**Returns:** `ValidationResults`

### Failure

```csharp
/// <summary>
        /// Creates a failed validation result with errors.
        /// </summary>
        public static ValidationResults Failure(params string[] errorMessages)
        {
            var result = new ValidationResults(false);
            foreach (var error in errorMessages)
            {
                result.AddError(error);
            }
            return result;
        }
```

Creates a failed validation result with errors.

**Returns:** `ValidationResults`

**Parameters:**
- `string[] errorMessages`

### Mixed

```csharp
/// <summary>
        /// Creates a validation result with mixed results.
        /// </summary>
        public static ValidationResults Mixed(params string[] errorMessages)
        {
            var result = new ValidationResults(false); // Mixed results are considered invalid
            foreach (var error in errorMessages)
            {
                result.AddError(error);
            }
            return result;
        }
```

Creates a validation result with mixed results.

**Returns:** `ValidationResults`

**Parameters:**
- `string[] errorMessages`

### AddError

```csharp
#endregion

        #region Error Management

        /// <summary>
        /// Adds an error to the validation results.
        /// </summary>
        public void AddError(string message, string? code = null, string? context = null)
        {
            Errors.Add(new ValidationError
            {
                Message = message,
                Code = code ?? "VALIDATION_ERROR",
                Context = context,
                Timestamp = DateTime.UtcNow
            });
            IsValid = false;
        }
```

Adds an error to the validation results.

**Returns:** `void`

**Parameters:**
- `string message`
- `string? code`
- `string? context`

### AddError

```csharp
/// <summary>
        /// Adds an error with detailed information.
        /// </summary>
        public void AddError(ValidationError error)
        {
            Errors.Add(error);
            IsValid = false;
        }
```

Adds an error with detailed information.

**Returns:** `void`

**Parameters:**
- `ValidationError error`

### GetErrorSummary

```csharp
/// <summary>
        /// Gets all error messages as a single string.
        /// </summary>
        public string GetErrorSummary()
        {
            return string.Join("; ", Errors.Select(e => e.Message));
        }
```

Gets all error messages as a single string.

**Returns:** `string`

### AddWarning

```csharp
#endregion

        #region Warning Management

        /// <summary>
        /// Adds a warning to the validation results.
        /// </summary>
        public void AddWarning(string message, string? code = null, string? context = null)
        {
            Warnings.Add(new ValidationWarning
            {
                Message = message,
                Code = code ?? "VALIDATION_WARNING",
                Context = context,
                Timestamp = DateTime.UtcNow
            });
        }
```

Adds a warning to the validation results.

**Returns:** `void`

**Parameters:**
- `string message`
- `string? code`
- `string? context`

### AddWarning

```csharp
/// <summary>
        /// Adds a warning with detailed information.
        /// </summary>
        public void AddWarning(ValidationWarning warning)
        {
            Warnings.Add(warning);
        }
```

Adds a warning with detailed information.

**Returns:** `void`

**Parameters:**
- `ValidationWarning warning`

### GetWarningSummary

```csharp
/// <summary>
        /// Gets all warning messages as a single string.
        /// </summary>
        public string GetWarningSummary()
        {
            return string.Join("; ", Warnings.Select(e => e.Message));
        }
```

Gets all warning messages as a single string.

**Returns:** `string`

### AddInfo

```csharp
#endregion

        #region Info Management

        /// <summary>
        /// Adds an informational message to the validation results.
        /// </summary>
        public void AddInfo(string message, string? code = null, string? context = null)
        {
            Info.Add(new ValidationInfo
            {
                Message = message,
                Code = code ?? "VALIDATION_INFO",
                Context = context,
                Timestamp = DateTime.UtcNow
            });
        }
```

Adds an informational message to the validation results.

**Returns:** `void`

**Parameters:**
- `string message`
- `string? code`
- `string? context`

### AddInfo

```csharp
/// <summary>
        /// Adds an informational message with detailed information.
        /// </summary>
        public void AddInfo(ValidationInfo info)
        {
            Info.Add(info);
        }
```

Adds an informational message with detailed information.

**Returns:** `void`

**Parameters:**
- `ValidationInfo info`

### GetInfoSummary

```csharp
/// <summary>
        /// Gets all info messages as a single string.
        /// </summary>
        public string GetInfoSummary()
        {
            return string.Join("; ", Info.Select(e => e.Message));
        }
```

Gets all info messages as a single string.

**Returns:** `string`

### Clone

```csharp
#endregion

        #region Utility Methods

        /// <summary>
        /// Creates a deep copy of these validation results.
        /// </summary>
        public ValidationResults Clone()
        {
            var clone = new ValidationResults(IsValid)
            {
                ValidatedAt = ValidatedAt,
                Context = new Dictionary<string, object>(Context)
            };

            clone.Errors.AddRange(Errors);
            clone.Warnings.AddRange(Warnings);
            clone.Info.AddRange(Info);

            return clone;
        }
```

Creates a deep copy of these validation results.

**Returns:** `ValidationResults`

### Merge

```csharp
/// <summary>
        /// Merges another validation result into this one.
        /// </summary>
        public void Merge(ValidationResults other)
        {
            if (other == null) return;

            Errors.AddRange(other.Errors);
            Warnings.AddRange(other.Warnings);
            Info.AddRange(other.Info);

            // If either result is invalid, this result is invalid
            if (!other.IsValid)
            {
                IsValid = false;
            }

            // Merge context
            foreach (var kvp in other.Context)
            {
                Context[kvp.Key] = kvp.Value;
            }
        }
```

Merges another validation result into this one.

**Returns:** `void`

**Parameters:**
- `ValidationResults other`

### GetFullSummary

```csharp
/// <summary>
        /// Gets a summary of all messages.
        /// </summary>
        public string GetFullSummary()
        {
            var parts = new List<string>();

            if (HasErrors)
                parts.Add($"Errors: {GetErrorSummary()}");

            if (HasWarnings)
                parts.Add($"Warnings: {GetWarningSummary()}");

            if (HasInfo)
                parts.Add($"Info: {GetInfoSummary()}");

            return string.Join(" | ", parts);
        }
```

Gets a summary of all messages.

**Returns:** `string`

### ToString

```csharp
#endregion

        #region Object Overrides

        public override string ToString()
        {
            return $"ValidationResults({(IsValid ? "Valid" : "Invalid")}, Errors: {Errors.Count}, Warnings: {Warnings.Count})";
        }
```

**Returns:** `string`

