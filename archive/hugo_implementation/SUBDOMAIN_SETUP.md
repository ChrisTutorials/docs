# Subdomain Staging Setup Guide

## 🎯 **True Subdomain Staging: staging.item-drops.pages.dev**

You're absolutely right! Subdomain staging looks much more professional. Here's how to set it up properly.

---

## 🚀 **Option 1: Custom Domain with Single Pages Project (Recommended)**

### **URL Structure**
```bash
Production: https://item-drops.pages.dev
Staging:    https://staging.item-drops.pages.dev
Development: https://dev.item-drops.pages.dev
```

### **Setup Steps**

#### **Step 1: Create Single Pages Project**
1. Go to [Cloudflare Pages](https://dash.cloudflare.com/pages)
2. "Create a project" → "Upload assets"
3. Project name: `item-drops`
4. Production branch: `main`
5. Build command: `hugo --minify`
6. Build output directory: `public`

#### **Step 2: Add Custom Domains**
1. In Pages project settings → "Custom domains"
2. Add: `staging.item-drops.pages.dev`
3. Add: `dev.item-drops.pages.dev` (optional)
4. Wait for DNS propagation

#### **Step 3: Deploy with Subdomain Script**
```bash
cd /home/chris/game_dev/docs/item_drops

# Deploy to staging
./deploy-subdomain.sh staging
# URL: https://staging.item-drops.pages.dev

# Deploy to production
./deploy-subdomain.sh production  
# URL: https://item-drops.pages.dev

# Deploy to development
./deploy-subdomain.sh dev
# URL: https://dev.item-drops.pages.dev
```

---

## 🌐 **Option 2: Multiple Pages Projects (Alternative)**

### **URL Structure**
```bash
Production: https://item-drops.pages.dev
Staging:    https://staging-item-drops.pages.dev
Development: https://dev-item-drops.pages.dev
```

*Note: This uses the older pattern - Option 1 is recommended for cleaner URLs*

---

## 🌐 **Option 2: Custom Domain (Professional Setup)**

### **URL Structure**
```bash
Production: https://docs.itemdrops.com
Staging:    https://staging.docs.itemdrops.com
Development: https://dev.docs.itemdrops.com
```

### **Setup Steps**

#### **Step 1: Get Custom Domain**
1. Purchase domain: `itemdrops.com`
2. Go to Cloudflare → Add site
3. Configure DNS settings

#### **Step 2: Set Up Pages with Custom Domain**
1. In Pages project settings → "Custom domains"
2. Add: `docs.itemdrops.com`
3. Add: `staging.docs.itemdrops.com`
4. Add: `dev.docs.itemdrops.com`

#### **Step 3: Deploy Script Update**
```bash
# Update URLs in deploy-subdomain.sh
Production: https://docs.itemdrops.com
Staging:    https://staging.docs.itemdrops.com
Development: https://dev.docs.itemdrops.com
```

---

## 🎯 **Option 3: R2 Storage + Workers (Full Control)**

### **URL Structure**
```bash
Production: https://itemdrops.com/docs/latest/
Staging:    https://staging.itemdrops.com/
Development: https://dev.itemdrops.com/
```

### **Setup Steps**

#### **Step 1: Set Up R2 Buckets**
```bash
# Production bucket
aws s3 mb s3://itemdrops-prod

# Staging bucket  
aws s3 mb s3://itemdrops-staging

# Development bucket
aws s3 mb s3://itemdrops-dev
```

#### **Step 2: Deploy to R2**
```bash
# Deploy to staging
aws s3 sync ./public/ s3://itemdrops-staging/ \
  --endpoint-url https://your_account_id.r2.cloudflarestorage.com

# Deploy to production
aws s3 sync ./public/ s3://itemdrops-prod/ \
  --endpoint-url https://your_account_id.r2.cloudflarestorage.com
```

#### **Step 3: Set Up Cloudflare Workers for Routing**
```javascript
// Worker script for routing
export default {
  async fetch(request) {
    const url = new URL(request.url);
    const hostname = url.hostname;
    
    if (hostname === 'staging.itemdrops.com') {
      // Route to staging bucket
      return fetch('https://itemdrops-staging.workers.dev' + url.pathname);
    } else if (hostname === 'itemdrops.com') {
      // Route to production bucket
      return fetch('https://itemdrops-prod.workers.dev' + url.pathname);
    }
  }
};
```

---

## 📊 **Comparison of Subdomain Approaches**

| Approach | Setup Time | Cost | Control | Professional URL | Score |
|----------|------------|------|---------|------------------|-------|
| **Custom Domain + Single Project** | 15 min | Free | Good | ✅ staging.item-drops.pages.dev | **10/10** |
| **Multiple Projects** | 30 min | Free | Limited | ✅ staging-item-drops.pages.dev | **8/10** |
| **R2 + Workers** | 60 min | Storage cost | Full | ✅ staging.item-drops.com | **7/10** |

---

## 🎯 **Recommendation: Custom Domain with Single Project**

### **Why This is Best for You**
- ✅ **Perfect subdomains** - staging.item-drops.pages.dev
- ✅ **Free** - No additional costs
- ✅ **Simple setup** - Single project + custom domains
- ✅ **Zero maintenance** - Cloudflare handles everything
- ✅ **Professional appearance** - Clean URL structure

### **URL Examples**
```bash
# Your plugin sites
Production: https://item-drops.pages.dev
Staging:    https://staging.item-drops.pages.dev

# GridBuilding  
Production: https://gridbuilding.pages.dev
Staging:    https://staging.grid-building.pages.dev

# World Time
Production: https://world-time.pages.dev  
Staging:    https://staging.world-time.pages.dev

# Company site
Production: https://chris-tutorials.pages.dev
Staging:    https://staging.chris-tutorials.pages.dev
```

---

## 🚀 **Quick Setup Steps**

### **1. Create Pages Project (5 minutes)**
1. Go to Cloudflare Pages
2. Create project: `item-drops`
3. Connect to Git repository
4. Set production branch: `main`
5. Build command: `hugo --minify`

### **2. Add Custom Domains (2 minutes)**
1. In project settings → "Custom domains"
2. Add: `staging.item-drops.pages.dev`
3. Add: `dev.item-drops.pages.dev` (optional)
4. Wait for DNS to propagate

### **3. Deploy to Staging (1 minute)**
```bash
export CLOUDFLARE_API_TOKEN="your_token"
export CLOUDFLARE_ACCOUNT_ID="your_id"

cd /home/chris/game_dev/docs/item_drops
./deploy-subdomain.sh staging
```

### **4. Test Staging Site**
Visit: https://staging.item-drops.pages.dev

### **5. Deploy to Production**
```bash
./deploy-subdomain.sh production
```

---

## 🎉 **Result**

You now have professional subdomain staging:
- **Production**: https://item-drops.pages.dev
- **Staging**: https://staging.item-drops.pages.dev
- **Development**: https://dev.item-drops.pages.dev

This looks much more professional than the suffix approach and gives you true environment separation!

**Ready to set up the custom domains?** 🚀
