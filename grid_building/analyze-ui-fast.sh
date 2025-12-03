#!/bin/bash

# Fast, Secure UI/UX Analyzer using Firefox Headless + curl
# No Node.js, Python, or external dependencies required

set -e

# Configuration
BASE_URL="https://staging.gridbuilding.pages.dev"
OUTPUT_DIR="analysis"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create output directories
mkdir -p "$OUTPUT_DIR/screenshots"
mkdir -p "$OUTPUT_DIR/reports"
mkdir -p "$OUTPUT_DIR/html"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Fast UI/UX Analysis Starting...${NC}"
echo "Base URL: $BASE_URL"
echo "Timestamp: $TIMESTAMP"
echo

# Function to analyze a single page
analyze_page() {
    local url="$1"
    local page_name="$2"
    local viewport="$3" # "desktop" or "mobile"
    
    echo -e "${YELLOW}🔍 Analyzing: $url ($viewport)${NC}"
    
    # Set viewport for Firefox
    local viewport_width="1920"
    local viewport_height="1080"
    
    if [[ "$viewport" == "mobile" ]]; then
        viewport_width="375"
        viewport_height="667"
    fi
    
    # Take screenshot using Firefox headless
    local screenshot_file="$OUTPUT_DIR/screenshots/${page_name}-${viewport}.png"
    
    firefox --headless --screenshot="$screenshot_file" \
            --window-size="${viewport_width},${viewport_height}" \
            "$url" 2>/dev/null || {
        echo -e "${RED}❌ Failed to screenshot: $url${NC}"
        return 1
    }
    
    if [[ -f "$screenshot_file" ]]; then
        echo -e "${GREEN}📸 Screenshot saved: $screenshot_file${NC}"
    else
        echo -e "${RED}❌ Screenshot not created${NC}"
        return 1
    fi
    
    # Download HTML for analysis
    local html_file="$OUTPUT_DIR/html/${page_name}-${viewport}.html"
    curl -s -L "$url" -o "$html_file" --user-agent "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/119.0"
    
    # Analyze HTML structure using built-in tools
    echo -e "${BLUE}📊 Analyzing HTML structure...${NC}"
    
    local analysis_file="$OUTPUT_DIR/reports/${page_name}-${viewport}-analysis.txt"
    
    # Extract key metrics using grep and sed
    {
        echo "=== PAGE ANALYSIS: $url ($viewport) ==="
        echo "Timestamp: $(date)"
        echo "Viewport: ${viewport_width}x${viewport_height}"
        echo
        
        # Basic HTML structure
        echo "=== HTML STRUCTURE ==="
        echo "Total elements: $(grep -o '<[^>]*>' "$html_file" | wc -l)"
        echo "Headings: $(grep -o '<h[1-6]' "$html_file" | wc -l)"
        echo "Images: $(grep -o '<img' "$html_file" | wc -l)"
        echo "Links: $(grep -o '<a' "$html_file" | wc -l)"
        echo "Forms: $(grep -o '<form' "$html_file" | wc -l)"
        echo "Buttons: $(grep -o '<button\|<input.*type.*submit\|<input.*type.*button' "$html_file" | wc -l)"
        echo
        
        # Semantic HTML
        echo "=== SEMANTIC HTML ==="
        echo "Has header: $(grep -c '<header' "$html_file" || echo "0")"
        echo "Has nav: $(grep -c '<nav' "$html_file" || echo "0")"
        echo "Has main: $(grep -c '<main' "$html_file" || echo "0")"
        echo "Has footer: $(grep -c '<footer' "$html_file" || echo "0")"
        echo "Has article: $(grep -c '<article' "$html_file" || echo "0")"
        echo "Has section: $(grep -c '<section' "$html_file" || echo "0")"
        echo
        
        # Accessibility checks
        echo "=== ACCESSIBILITY ==="
        local images_without_alt=$(grep -o '<img[^>]*>' "$html_file" | grep -v 'alt=' | wc -l)
        echo "Images without alt: $images_without_alt"
        
        local empty_links=$(grep -o '<a[^>]*></a>' "$html_file" | wc -l)
        echo "Empty links: $empty_links"
        
        local has_lang=$(grep -c 'html lang=' "$html_file" || echo "0")
        echo "Has lang attribute: $has_lang"
        
        local has_meta_desc=$(grep -c 'meta.*description' "$html_file" || echo "0")
        echo "Has meta description: $has_meta_desc"
        
        local has_viewport=$(grep -c 'meta.*viewport' "$html_file" || echo "0")
        echo "Has viewport meta: $has_viewport"
        echo
        
        # CSS and styling
        echo "=== STYLING ==="
        echo "External stylesheets: $(grep -o '<link.*stylesheet' "$html_file" | wc -l)"
        echo "Inline styles: $(grep -o '<style' "$html_file" | wc -l)"
        echo "Inline style attributes: $(grep -o 'style=' "$html_file" | wc -l)"
        
        # Check for CSS variables (design system)
        local css_vars=$(grep -o 'var(--[^)]*)' "$html_file" | wc -l)
        echo "CSS variables: $css_vars"
        echo
        
        # Performance indicators
        echo "=== PERFORMANCE INDICATORS ==="
        local page_size=$(wc -c < "$html_file")
        echo "HTML size: ${page_size} bytes"
        
        local script_count=$(grep -o '<script' "$html_file" | wc -l)
        echo "Script tags: $script_count"
        
        local external_resources=$(grep -o 'href=.*http\|src=.*http' "$html_file" | wc -l)
        echo "External resources: $external_resources"
        echo
        
        # Mobile-specific checks
        if [[ "$viewport" == "mobile" ]]; then
            echo "=== MOBILE SPECIFIC ==="
            local has_mobile_nav=$(grep -c 'mobile-nav\|hamburger\|menu-toggle' "$html_file" || echo "0")
            echo "Has mobile navigation: $has_mobile_nav"
            
            local has_responsive=$(grep -c '@media\|viewport\|responsive' "$html_file" || echo "0")
            echo "Responsive CSS: $has_responsive"
            echo
        fi
        
        # Content analysis
        echo "=== CONTENT ANALYSIS ==="
        local word_count=$(sed 's/<[^>]*>//g' "$html_file" | wc -w)
        echo "Word count: $word_count"
        
        local has_code_blocks=$(grep -c '<pre\|<code' "$html_file" || echo "0")
        echo "Code blocks: $has_code_blocks"
        
        local has_tables=$(grep -c '<table' "$html_file" || echo "0")
        echo "Tables: $has_tables"
        echo
        
        # Potential issues
        echo "=== POTENTIAL ISSUES ==="
        local h1_count=$(grep -o '<h1' "$html_file" | wc -l)
        if [[ $h1_count -gt 1 ]]; then
            echo "⚠️  Multiple H1 tags: $h1_count"
        fi
        
        if [[ $images_without_alt -gt 0 ]]; then
            echo "⚠️  Images missing alt text: $images_without_alt"
        fi
        
        if [[ $empty_links -gt 0 ]]; then
            echo "⚠️  Empty links: $empty_links"
        fi
        
        if [[ $has_lang -eq 0 ]]; then
            echo "⚠️  Missing lang attribute"
        fi
        
        if [[ $has_meta_desc -eq 0 ]]; then
            echo "⚠️  Missing meta description"
        fi
        
        if [[ $has_viewport -eq 0 ]]; then
            echo "⚠️  Missing viewport meta tag"
        fi
        
        echo
        echo "=== ANALYSIS COMPLETE ==="
        
    } > "$analysis_file"
    
    echo -e "${GREEN}✅ Analysis saved: $analysis_file${NC}"
}

# Function to generate summary report
generate_summary() {
    echo -e "${BLUE}📊 Generating summary report...${NC}"
    
    local summary_file="$OUTPUT_DIR/reports/summary-$TIMESTAMP.md"
    
    {
        echo "# UI/UX Analysis Summary"
        echo
        echo "**Date:** $(date)"
        echo "**Base URL:** $BASE_URL"
        echo "**Analysis Tool:** Firefox Headless + curl"
        echo
        echo "## 📊 Overview"
        echo
        
        # Count analyzed pages
        local analyzed_count=$(find "$OUTPUT_DIR/reports" -name "*-analysis.txt" | wc -l)
        echo "- **Pages Analyzed:** $analyzed_count"
        echo "- **Screenshots Taken:** $(find "$OUTPUT_DIR/screenshots" -name "*.png" | wc -l)"
        echo "- **Analysis Files:** $(find "$OUTPUT_DIR/reports" -name "*-analysis.txt" | wc -l)"
        echo
        
        echo "## 🔍 Key Findings"
        echo
        
        # Aggregate findings from all analysis files
        for analysis_file in "$OUTPUT_DIR/reports"/*-analysis.txt; do
            if [[ -f "$analysis_file" ]]; then
                local page_name=$(basename "$analysis_file" | sed 's/-analysis.txt//')
                echo "### $page_name"
                echo
                
                # Extract key metrics
                local total_elements=$(grep "Total elements:" "$analysis_file" | awk '{print $3}')
                local headings=$(grep "Headings:" "$analysis_file" | awk '{print $2}')
                local images=$(grep "Images:" "$analysis_file" | awk '{print $2}')
                local links=$(grep "Links:" "$analysis_file" | awk '{print $2}')
                
                echo "| Metric | Value |"
                echo "|--------|-------|"
                echo "| Total Elements | $total_elements |"
                echo "| Headings | $headings |"
                echo "| Images | $images |"
                echo "| Links | $links |"
                echo
                
                # Extract issues
                echo "**Issues Found:**"
                grep "⚠️" "$analysis_file" | sed 's/^⚠️  /- /' || echo "- None detected"
                echo
            fi
        done
        
        echo "## 🎯 Recommendations"
        echo
        echo "### Immediate Actions (High Priority)"
        echo
        echo "1. **Fix Accessibility Issues**"
        echo "   - Add alt text to all images"
        echo "   - Ensure proper heading hierarchy (single H1 per page)"
        echo "   - Add lang attribute to HTML element"
        echo "   - Include meta description and viewport meta tag"
        echo
        echo "2. **Improve Mobile Experience**"
        echo "   - Implement mobile navigation if missing"
        echo "   - Ensure touch targets are 44px minimum"
        echo "   - Test for horizontal scrolling issues"
        echo
        echo "3. **Performance Optimization**"
        echo "   - Reduce number of external resources"
        echo "   - Minimize HTML size"
        echo "   - Optimize image loading"
        echo
        echo "### Design System Improvements (Medium Priority)"
        echo
        echo "1. **CSS Custom Properties**"
        echo "   - Define consistent color palette"
        echo "   - Create typography scale"
        echo "   - Implement spacing system"
        echo
        echo "2. **Component Structure**"
        echo "   - Use semantic HTML5 elements"
        echo "   - Implement consistent component patterns"
        echo "   - Add proper ARIA labels"
        echo
        echo "### Long-term Enhancements (Low Priority)"
        echo
        echo "1. **Advanced Features**"
        echo "   - Add dark mode support"
        echo "   - Implement search functionality"
        echo "   - Add interactive elements"
        echo
        echo "2. **Analytics & Monitoring**"
        echo "   - Set up Core Web Vitals monitoring"
        echo "   - Implement user feedback collection"
        echo "   - Create automated testing pipeline"
        echo
        echo "---"
        echo
        echo "*Report generated by Fast UI/UX Analyzer*"
        echo "*Timestamp: $TIMESTAMP*"
        
    } > "$summary_file"
    
    echo -e "${GREEN}📝 Summary report saved: $summary_file${NC}"
}

# Main execution
main() {
    echo -e "${BLUE}🎯 Starting Fast UI/UX Analysis${NC}"
    echo "This tool uses Firefox headless mode - extremely fast and secure!"
    echo
    
    # Pages to analyze
    declare -A pages=(
        ["home"]="$BASE_URL/"
        ["overview"]="$BASE_URL/v5.1/overview/"
        ["api"]="$BASE_URL/v5.1/api/"
        ["community"]="$BASE_URL/community/"
    )
    
    # Analyze each page for both desktop and mobile
    for page_name in "${!pages[@]}"; do
        url="${pages[$page_name]}"
        
        # Desktop analysis
        analyze_page "$url" "$page_name" "desktop"
        
        # Mobile analysis
        analyze_page "$url" "$page_name" "mobile"
        
        echo
    done
    
    # Generate summary report
    generate_summary
    
    echo -e "${GREEN}🎉 Analysis Complete!${NC}"
    echo
    echo "📁 Results saved in: $OUTPUT_DIR/"
    echo "📸 Screenshots: $OUTPUT_DIR/screenshots/"
    echo "📊 Reports: $OUTPUT_DIR/reports/"
    echo "🌐 HTML files: $OUTPUT_DIR/html/"
    echo
    echo "📋 View the summary report: $OUTPUT_DIR/reports/summary-$TIMESTAMP.md"
    echo
    echo -e "${BLUE}💡 Next Steps:${NC}"
    echo "1. Review the screenshots for visual issues"
    echo "2. Check the analysis files for specific problems"
    echo "3. Implement the recommendations in the summary"
    echo
}

# Run the analysis
main "$@"
