#!/bin/bash

# Hugo Docs Validator: GDScript to C# Migration (5.0 -> 5.1)
# Validates that all documentation properly reflects GDScript to C# migration context
# Flags inconsistencies and migration mistakes

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCS_DIR="$(dirname "$SCRIPT_DIR")"
CONTENT_DIR="$DOCS_DIR/content"
VALIDATION_ERRORS=()
VALIDATION_WARNINGS=()

echo "🔍 Hugo Docs Validator: GDScript to C# Migration (5.0 -> 5.1)"
echo "=================================================="
echo "Docs Directory: $DOCS_DIR"
echo "Content Directory: $CONTENT_DIR"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Validation functions
add_error() {
    VALIDATION_ERRORS+=("$1")
    echo -e "${RED}❌ ERROR: $1${NC}"
}

add_warning() {
    VALIDATION_WARNINGS+=("$1")
    echo -e "${YELLOW}⚠️  WARNING: $1${NC}"
}

add_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

add_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# 1. Check for proper GDScript obsolete messaging
validate_gdscript_obsolete() {
    add_info "Validating GDScript obsolete messaging..."
    
    local files=$(find "$CONTENT_DIR" -name "*.md" -type f)
    local error_count=0
    
    while read -r file; do
        # Check for GDScript references - must be marked as obsolete
        if grep -qi "gdscript" "$file"; then
            # Must contain "obsolete" for any GDScript mention
            if ! grep -qi "obsolete" "$file"; then
                add_error "GDScript mentioned in $file but not marked as obsolete"
                error_count=$((error_count + 1))
            fi
            
            # Must specify immediate replacement
            if ! grep -qi "immediate.*replace\|replace.*immediate" "$file"; then
                add_error "GDScript in $file must specify immediate replacement"
                error_count=$((error_count + 1))
            fi
        fi
        
        # Check for migration guide references
        if grep -qi "gdscript\|obsolete\|deprecated" "$file"; then
            # Should reference the migration guide
            if ! grep -qi "migration.*guide\|guide.*migration" "$file"; then
                add_warning "GDScript/obsolete content in $file should reference migration guide"
            fi
        fi
        
        # Check for proper migration guide link
        if grep -qi "migration.*guide" "$file"; then
            # Should point to the 5.0 -> 5.1 guide
            if ! grep -q "migration-5-0-to-5-1\|5\.0.*5\.1" "$file"; then
                add_warning "Migration guide reference in $file should point to 5.0 -> 5.1 guide"
            fi
        fi
        
    done <<< "$files"
    
    if [ $error_count -eq 0 ]; then
        add_success "GDScript obsolete validation passed"
    else
        add_error "Found $error_count GDScript obsolete errors"
    fi
}

# 2. Validate 5.0 -> 5.1 migration guide specifically
validate_migration_guide() {
    add_info "Validating 5.0 -> 5.1 migration guide..."
    
    local migration_file="$CONTENT_DIR/v5.1/guides/migration-5-0-to-5-1.md"
    
    if [ ! -f "$migration_file" ]; then
        add_error "Migration guide not found: $migration_file"
        return
    fi
    
    # Check for required sections
    local required_sections=(
        "GDScript.*obsolete"
        "immediate.*replace"
        "Breaking Changes"
        "Migration Steps"
        "BuildingSystem"
        "PlacementService"
        "ManipulationService"
    )
    
    for section in "${required_sections[@]}"; do
        if ! grep -qi "$section" "$migration_file"; then
            add_error "Missing required section '$section' in migration guide"
        fi
    done
    
    # Check for correct migration direction
    if grep -q "5\.0.*5\.1" "$migration_file"; then
        add_success "Migration guide has correct version numbering"
    else
        add_error "Migration guide should specify 5.0 -> 5.1 migration"
    fi
    
    # Validate GDScript is marked as obsolete (not deprecated)
    if grep -qi "obsolete" "$migration_file"; then
        add_success "GDScript properly marked as obsolete"
    else
        add_error "Migration guide must mark GDScript as obsolete"
    fi
    
    # Check for "deprecated" - should not be used for GDScript
    if grep -qi "deprecated.*gdscript\|gdscript.*deprecated" "$migration_file"; then
        add_error "Use 'obsolete' not 'deprecated' for GDScript in migration guide"
    fi
    
    # Validate immediate replacement messaging
    if grep -qi "immediate.*replace\|replace.*immediate\|immediate.*migration" "$migration_file"; then
        add_success "Migration guide emphasizes immediate replacement"
    else
        add_error "Migration guide must emphasize immediate replacement"
    fi
    
    # Check for migration guide self-reference
    if grep -q "\[.*migration.*guide.*\]" "$migration_file"; then
        add_success "Migration guide references itself properly"
    else
        add_warning "Migration guide should include self-reference links"
    fi
}

# 3. Check for proper C# service naming
validate_service_naming() {
    add_info "Validating C# service naming consistency..."
    
    local files=$(find "$CONTENT_DIR" -name "*.md" -type f)
    
    while read -r file; do
        # Check for proper C# service names
        if grep -q "PlacementService\|ManipulationService" "$file"; then
            # Should be capitalized (C# convention)
            if grep -q "placementservice\|manipulationservice" "$file"; then
                add_error "Found lowercase service names in $file - should be capitalized (C#)"
            fi
        fi
        
        # Check for GDScript naming in old system references
        if grep -q "place_building\|remove_building\|move_building" "$file"; then
            if ! grep -q "GDScript" "$file"; then
                add_warning "Found GDScript method names without GDScript context in $file"
            fi
        fi
    done <<< "$files"
    
    add_success "Service naming validation completed"
}

# 4. Validate code examples
validate_code_examples() {
    add_info "Validating code examples consistency..."
    
    local files=$(find "$CONTENT_DIR" -name "*.md" -type f)
    
    while read -r file; do
        # Check C# code blocks have proper language specification
        if grep -q "```csharp" "$file"; then
            # Should contain C# service calls
            if grep -A 5 "```csharp" "$file" | grep -q "BuildingService\|BuildingSystem"; then
                add_warning "C# example in $file shows old GDScript classes"
            fi
        fi
        
        # Check for proper Obsolete attributes
        if grep -q "\[Obsolete" "$file"; then
            if ! grep -q "GDScript.*obsolete.*C#" "$file"; then
                add_error "Obsolete attribute in $file should mention GDScript to C# migration"
            fi
        fi
    done <<< "$files"
    
    add_success "Code examples validation completed"
}

# 5. Check for version consistency
validate_version_consistency() {
    add_info "Validating version consistency..."
    
    local files=$(find "$CONTENT_DIR" -name "*.md" -type f)
    
    while read -r file; do
        # Check for version 5.0 references in migration context
        if grep -q "5\.0" "$file" && grep -q "migration" "$file"; then
            if ! grep -q "5\.1" "$file"; then
                add_warning "Found 5.0 migration reference without 5.1 in $file"
            fi
        fi
        
        # Check for breaking change notices
        if grep -q "breaking" "$file"; then
            if ! grep -q "GDScript.*C#" "$file" && ! grep -q "C#.*GDScript" "$file"; then
                add_warning "Breaking change notice in $file should specify GDScript to C#"
            fi
        fi
    done <<< "$files"
    
    add_success "Version consistency validation completed"
}

# 6. Validate file structure and naming
validate_file_structure() {
    add_info "Validating file structure..."
    
    # Check for migration guide in correct location
    local migration_guide="$CONTENT_DIR/v5.1/guides/migration-5-0-to-5-1.md"
    if [ -f "$migration_guide" ]; then
        add_success "Migration guide found in correct location"
    else
        add_error "Migration guide not found at v5.1/guides/migration-5-0-to-5-1.md"
    fi
    
    # Check for deprecation files
    local deprecation_file="$DOCS_DIR/../plugins/domains/gameplay/GridBuilding/docs/BUILDING_SYSTEM_DEPRECATION_MIGRATION.md"
    if [ -f "$deprecation_file" ]; then
        add_success "Deprecation migration file found"
    else
        add_warning "Deprecation migration file not found"
    fi
}

# 7. Generate validation report
generate_report() {
    echo ""
    echo "=================================================="
    echo "📊 VALIDATION REPORT"
    echo "=================================================="
    
    local total_errors=${#VALIDATION_ERRORS[@]}
    local total_warnings=${#VALIDATION_WARNINGS[@]}
    
    if [ $total_errors -eq 0 ]; then
        echo -e "${GREEN}✅ NO ERRORS FOUND${NC}"
    else
        echo -e "${RED}❌ $total_errors ERRORS FOUND:${NC}"
        for i in "${!VALIDATION_ERRORS[@]}"; do
            echo "  $((i+1)). ${VALIDATION_ERRORS[i]}"
        done
    fi
    
    echo ""
    
    if [ $total_warnings -eq 0 ]; then
        echo -e "${GREEN}✅ NO WARNINGS FOUND${NC}"
    else
        echo -e "${YELLOW}⚠️  $total_warnings WARNINGS:${NC}"
        for i in "${!VALIDATION_WARNINGS[@]}"; do
            echo "  $((i+1)). ${VALIDATION_WARNINGS[i]}"
        done
    fi
    
    echo ""
    
    # Exit with error code if errors found
    if [ $total_errors -gt 0 ]; then
        echo -e "${RED}🚨 VALIDATION FAILED - Fix errors before proceeding${NC}"
        exit 1
    else
        echo -e "${GREEN}🎉 VALIDATION PASSED - Documentation is consistent${NC}"
        exit 0
    fi
}

# Main execution
main() {
    echo "Starting validation..."
    echo ""
    
    validate_gdscript_obsolete
    echo ""
    
    validate_migration_guide
    echo ""
    
    validate_service_naming
    echo ""
    
    validate_code_examples
    echo ""
    
    validate_version_consistency
    echo ""
    
    validate_file_structure
    echo ""
    
    generate_report
}

# Run if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi