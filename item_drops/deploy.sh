#!/bin/bash

# Item Drops Hugo Site Deployment Script
# Deploys to Cloudflare Pages using direct API calls (no Wrangler)

set -e

# Configuration
HUGO_SOURCE_DIR="/home/chris/game_dev/docs/item_drops"
BUILD_DIR="${HUGO_SOURCE_DIR}/public"

# Cloudflare Configuration (set these as environment variables)
CLOUDFLARE_API_TOKEN="${CLOUDFLARE_API_TOKEN:-}"
CLOUDFLARE_ACCOUNT_ID="${CLOUDFLARE_ACCOUNT_ID:-}"
CLOUDFLARE_PROJECT_NAME="${CLOUDFLARE_PROJECT_NAME:-item-drops}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Starting Item Drops deployment...${NC}"

# Check required environment variables
if [[ -z "$CLOUDFLARE_API_TOKEN" || -z "$CLOUDFLARE_ACCOUNT_ID" ]]; then
    echo -e "${RED}❌ Missing required environment variables:${NC}"
    echo -e "${RED}   CLOUDFLARE_API_TOKEN${NC}"
    echo -e "${RED}   CLOUDFLARE_ACCOUNT_ID${NC}"
    echo ""
    echo -e "${YELLOW}Set them with:${NC}"
    echo "export CLOUDFLARE_API_TOKEN='your_token_here'"
    echo "export CLOUDFLARE_ACCOUNT_ID='your_account_id_here'"
    exit 1
fi

# Build the Hugo site
echo -e "${YELLOW}🔨 Building Hugo site...${NC}"
cd "$HUGO_SOURCE_DIR"

# Clean previous build
if [[ -d "$BUILD_DIR" ]]; then
    rm -rf "$BUILD_DIR"
fi

# Build with minification
hugo --minify --gc

if [[ ! -d "$BUILD_DIR" ]]; then
    echo -e "${RED}❌ Hugo build failed - no public directory created${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Hugo build completed${NC}"
echo -e "${YELLOW}📦 Build size: $(du -sh "$BUILD_DIR" | cut -f1)${NC}"

# Create tar.gz for upload
echo -e "${YELLOW}📦 Creating deployment package...${NC}"
cd "$BUILD_DIR"
tar -czf ../deployment.tar.gz .

# Deploy to Cloudflare Pages
echo -e "${YELLOW}🌐 Deploying to Cloudflare Pages...${NC}"

# Create deployment via Cloudflare API
DEPLOYMENT_RESPONSE=$(curl -s -X POST \
  "https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/pages/projects/${CLOUDFLARE_PROJECT_NAME}/deployments" \
  -H "Authorization: Bearer ${CLOUDFLARE_API_TOKEN}" \
  -H "Content-Type: application/octet-stream" \
  --data-binary @"../deployment.tar.gz")

# Check deployment response
if echo "$DEPLOYMENT_RESPONSE" | grep -q '"success":true'; then
    DEPLOYMENT_URL=$(echo "$DEPLOYMENT_RESPONSE" | grep -o '"url":"[^"]*"' | cut -d'"' -f4)
    echo -e "${GREEN}✅ Deployment successful!${NC}"
    echo -e "${GREEN}🌐 Site will be available at: https://item-drops.pages.dev${NC}"
    echo -e "${GREEN}📊 Deployment details: ${DEPLOYMENT_URL}${NC}"
else
    echo -e "${RED}❌ Deployment failed:${NC}"
    echo "$DEPLOYMENT_RESPONSE"
    exit 1
fi

# Cleanup
rm -f ../deployment.tar.gz

echo -e "${GREEN}🎉 Item Drops deployment completed successfully!${NC}"
