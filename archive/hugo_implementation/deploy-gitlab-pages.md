# Deploy Item Drops to Cloudflare Pages

## 🎯 Option 1: Cloudflare Pages with GitLab CI/CD (Recommended)

This approach uses GitLab CI/CD to build the Hugo site and deploy to Cloudflare Pages via API.

### **Step 1: Create Cloudflare API Token**

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com/profile/api-tokens)
2. Create "Custom Token" with permissions:
   - `Account:Cloudflare Pages:Edit`
   - `Zone:Zone:Read`
   - `User:User Details:Read`

### **Step 2: Set Up GitLab CI/CD Variables**

In GitLab project: `Settings > CI/CD > Variables`:
```bash
CLOUDFLARE_API_TOKEN=your_api_token_here
CLOUDFLARE_ACCOUNT_ID=your_account_id_here
CLOUDFLARE_PROJECT_NAME=item-drops
```

### **Step 3: Create GitLab CI/CD Pipeline**

Create `.gitlab-ci.yml` in your Hugo site:

```yaml
stages:
  - build
  - deploy

variables:
  HUGO_VERSION: "0.146.5"

build:
  stage: build
  image: klakegg/hugo:ext-alpine
  script:
    - hugo --minify
  artifacts:
    paths:
      - public
    expire_in: 1 hour

deploy:
  stage: deploy
  image: curlimages/curl:latest
  script:
    - |
      # Create deployment
      DEPLOYMENT=$(curl -s -X POST \
        "https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/pages/projects/${CLOUDFLARE_PROJECT_NAME}/deployments" \
        -H "Authorization: Bearer ${CLOUDFLARE_API_TOKEN}" \
        -H "Content-Type: application/json" \
        --data-binary @public.tar.gz)
      
      echo "Deployment: $DEPLOYMENT"
  dependencies:
    - build
  only:
    - main
```

### **Step 4: Create Cloudflare Pages Project**

1. Go to Cloudflare Pages dashboard
2. "Create a project" > "Upload assets"
3. Connect to your GitLab repository
4. Set build command: `hugo --minify`
5. Set output directory: `public`

---

## 🎯 Option 2: Direct Cloudflare R2 Upload

Upload directly to Cloudflare R2 storage and serve via Cloudflare CDN.

### **R2 Upload Script**

```bash
#!/bin/bash
# deploy-r2.sh

# Configuration
CLOUDFLARE_ACCOUNT_ID="your_account_id"
R2_BUCKET_NAME="item-drops-site"
R2_ENDPOINT="https://${CLOUDFLARE_ACCOUNT_ID}.r2.cloudflarestorage.com"

# Build site
cd /home/chris/game_dev/docs/item_drops
hugo --minify

# Upload to R2 using rclone or AWS CLI
aws s3 sync ./public/ s3://${R2_BUCKET_NAME}/ \
  --endpoint-url ${R2_ENDPOINT} \
  --no-progress \
  --delete

echo "Deployed to Cloudflare R2!"
```

---

## 🎯 Option 3: GitHub Actions + Cloudflare Pages

If you prefer GitHub over GitLab:

```yaml
name: Deploy to Cloudflare Pages
on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Hugo
      uses: peaceiris/actions-hugo@v2
      with:
        hugo-version: '0.146.5'
        extended: true
    
    - name: Build
      run: hugo --minify
    
    - name: Deploy to Cloudflare Pages
      uses: cloudflare/pages-action@v1
      with:
        apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
        accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
        projectName: item-drops
        directory: public
```

---

## 🎯 Option 4: Simple FTP/SFTP to Cloudflare

Use Cloudflare as reverse proxy for your own server.

---

## 🚀 Recommended Approach

**For your use case, I recommend Option 1 (GitLab CI/CD + Cloudflare Pages API)** because:

✅ **No Wrangler dependency** - Pure curl/bash commands  
✅ **Fast builds** - Hugo builds in milliseconds  
✅ **Automatic deployment** - Triggers on git push  
✅ **Version control** - Full git history  
✅ **Rollback capability** - Cloudflare Pages supports rollbacks  
✅ **Free tier** - Generous free limits for static sites  

Would you like me to set up any of these approaches for the Item Drops site?
