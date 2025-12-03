# Item Drops Quick Start Guide

## 🚀 **5-Minute Setup for Staging + Production**

### **Step 1: Get Cloudflare Credentials (2 minutes)**

1. **Account ID**: Go to [Cloudflare Dashboard](https://dash.cloudflare.com) → copy "Account ID"
2. **API Token**: Go to [API Tokens](https://dash.cloudflare.com/profile/api-tokens) → "Create Token" → "Custom token" with:
   - `Account:Cloudflare Pages:Edit`
   - `Zone:Zone:Read`
   - `User:User Details:Read`

### **Step 2: Set Environment Variables (1 minute)**

```bash
export CLOUDFLARE_API_TOKEN="your_token_here"
export CLOUDFLARE_ACCOUNT_ID="your_account_id_here"
```

### **Step 3: Create Cloudflare Pages Project (2 minutes)**

1. Go to [Cloudflare Pages](https://dash.cloudflare.com/pages)
2. "Create a project" → "Upload assets"  
3. Project name: `item-drops`
4. Production branch: `main`
5. Build command: `hugo --minify`
6. Build output directory: `public`

### **Step 4: Deploy! (30 seconds)**

```bash
cd /home/chris/game_dev/docs/item_drops

# Deploy to staging for testing
./deploy-staging.sh staging

# Deploy to production when ready
./deploy-staging.sh production
```

---

## 🎯 **Your URLs**

| Environment | URL | When to Use |
|-------------|-----|-------------|
| **Staging** | https://item-drops-staging.pages.dev | Test changes before going live |
| **Production** | https://item-drops.pages.dev | Live site for users |
| **Preview** | https://item-drops-feature-name.pages.dev | Share with team for review |

---

## 🔄 **Typical Workflow**

### **Development → Staging → Production**
```bash
# 1. Make changes to docs
# 2. Deploy to staging for testing
./deploy-staging.sh staging

# 3. Test staging site
# 4. Deploy to production
./deploy-staging.sh production
```

### **Feature Branch Workflow**
```bash
# 1. Create feature branch
git checkout -b feature/new-api-docs

# 2. Make changes
# 3. Deploy preview for team review
./deploy-staging.sh preview new-api-docs

# 4. Share preview URL with team
# 5. Merge to main when approved
git checkout main
git merge feature/new-api-docs

# 6. Deploy to production
./deploy-staging.sh production
```

---

## 🛠️ **Advanced Options**

### **GitLab CI/CD Integration**
```bash
# Push to staging branch → auto-deploy to staging
git push origin staging

# Push to main branch → auto-deploy to production  
git push origin main
```

### **Manual Deployment Commands**
```bash
# Deploy to specific environment
./deploy-staging.sh production
./deploy-staging.sh staging
./deploy-staging.sh preview feature-name
```

---

## 🎉 **Success!**

When deployed successfully:
- ✅ **Staging**: Test changes at https://item-drops-staging.pages.dev
- ✅ **Production**: Live at https://item-drops.pages.dev
- ✅ **Preview**: Share feature URLs with team
- ✅ **Zero Wrangler**: Pure bash/curl deployment
- ✅ **Fast builds**: Hugo builds in milliseconds
- ✅ **Global CDN**: Fast loading worldwide

---

## 📚 **More Information**

- **[Deployment Comparison](DEPLOYMENT_COMPARISON.md)** - Pages vs R2 vs Hybrid
- **[Setup Guide](SETUP_DEPLOYMENT.md)** - Detailed setup instructions
- **[GitLab CI/CD](.gitlab-ci.yml)** - Automated deployment pipeline

**Ready to deploy your Item Drops documentation!** 🚀
