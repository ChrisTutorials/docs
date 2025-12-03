#!/bin/bash

# Item Drops Hugo Site Deployment Script with Subdomain Staging
# Uses multiple Cloudflare Pages projects for true subdomain staging

set -e

# Configuration
HUGO_SOURCE_DIR="/home/chris/game_dev/docs/item_drops"
BUILD_DIR="${HUGO_SOURCE_DIR}/public"

# Cloudflare Configuration (set these as environment variables)
CLOUDFLARE_API_TOKEN="${CLOUDFLARE_API_TOKEN:-}"
CLOUDFLARE_ACCOUNT_ID="${CLOUDFLARE_ACCOUNT_ID:-}"

# Deployment Target (production, staging, or custom)
DEPLOY_TARGET="${1:-staging}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Item Drops Subdomain Deployment${NC}"
echo -e "${YELLOW}📍 Target: ${DEPLOY_TARGET}${NC}"
echo ""

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

# Configure project and URL based on target
case "$DEPLOY_TARGET" in
    "production"|"prod")
        CLOUDFLARE_PROJECT_NAME="item-drops"
        ENVIRONMENT="production"
        URL="https://item-drops.pages.dev"
        BRANCH="main"
        ;;
    "staging"|"stage")
        CLOUDFLARE_PROJECT_NAME="item-drops"
        ENVIRONMENT="staging"
        URL="https://staging.item-drops.pages.dev"
        BRANCH="staging"
        ;;
    "dev"|"development")
        CLOUDFLARE_PROJECT_NAME="item-drops"
        ENVIRONMENT="development"
        URL="https://dev.item-drops.pages.dev"
        BRANCH="develop"
        ;;
    *)
        echo -e "${RED}❌ Invalid deployment target: ${DEPLOY_TARGET}${NC}"
        echo -e "${YELLOW}Valid options: production, staging, dev${NC}"
        exit 1
        ;;
esac

# Show deployment info
echo -e "${YELLOW}📋 Deployment Configuration:${NC}"
echo -e "${YELLOW}   Environment: ${ENVIRONMENT}${NC}"
echo -e "${YELLOW}   Project: ${CLOUDFLARE_PROJECT_NAME}${NC}"
echo -e "${YELLOW}   Branch: ${BRANCH}${NC}"
echo -e "${YELLOW}   URL: ${URL}${NC}"
echo ""

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
echo -e "${YELLOW}🌐 Deploying to Cloudflare Pages (${ENVIRONMENT})...${NC}"

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
    echo -e "${GREEN}🌐 Environment: ${ENVIRONMENT}${NC}"
    echo -e "${GREEN}🔗 URL: ${URL}${NC}"
    echo -e "${GREEN}📊 Deployment details: ${DEPLOYMENT_URL}${NC}"
    
    # Show next steps based on environment
    case "$ENVIRONMENT" in
        "staging")
            echo ""
            echo -e "${BLUE}👀 Staging deployed! Test it at: ${URL}${NC}"
            echo -e "${BLUE}🔄 Ready for review before production deployment${NC}"
            ;;
        "production")
            echo ""
            echo -e "${GREEN}🎉 Production deployment complete!${NC}"
            echo -e "${GREEN}🌐 Live at: ${URL}${NC}"
            ;;
        "development")
            echo ""
            echo -e "${BLUE}👀 Development deployed! Test at: ${URL}${NC}"
            echo -e "${BLUE}🔄 Quick iteration environment${NC}"
            ;;
    esac
else
    echo -e "${RED}❌ Deployment failed:${NC}"
    echo "$DEPLOYMENT_RESPONSE"
    exit 1
fi

# Cleanup
rm -f ../deployment.tar.gz

echo ""
echo -e "${GREEN}🎉 Item Drops deployment completed successfully!${NC}"

# Show available environments
echo ""
echo -e "${YELLOW}📍 Available Environments:${NC}"
echo -e "${YELLOW}   Production: ./deploy-subdomain.sh production${NC}"
echo -e "${YELLOW}   Staging:    ./deploy-subdomain.sh staging${NC}"
echo -e "${YELLOW}   Development: ./deploy-subdomain.sh dev${NC}"
