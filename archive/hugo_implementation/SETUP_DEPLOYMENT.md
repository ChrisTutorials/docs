# Item Drops Deployment Setup

## 🚀 Quick Setup for Cloudflare Pages (No Wrangler)

### **Step 1: Get Cloudflare Credentials**

1. **Get Account ID**:
   - Go to [Cloudflare Dashboard](https://dash.cloudflare.com)
   - Right sidebar → "Account ID" → copy

2. **Create API Token**:
   - Go to [API Tokens](https://dash.cloudflare.com/profile/api-tokens)
   - "Create Token" → "Custom token"
   - Permissions:
     ```
     Account:Cloudflare Pages:Edit
     Zone:Zone:Read  
     User:User Details:Read
     ```
   - Account Resources: "All accounts"
   - Copy the token

### **Step 2: Set Environment Variables**

```bash
# Add to your ~/.bashrc or set temporarily
export CLOUDFLARE_API_TOKEN="your_token_here"
export CLOUDFLARE_ACCOUNT_ID="your_account_id_here"
```

### **Step 3: Create Cloudflare Pages Project**

1. Go to [Cloudflare Pages](https://dash.cloudflare.com/pages)
2. "Create a project" → "Upload assets"
3. Project name: `item-drops`
4. Production branch: `main`
5. Build command: `hugo --minify`
6. Build output directory: `public`

### **Step 4: Deploy!**

#### **Option A: Manual Deployment**
```bash
cd /home/chris/game_dev/docs/item_drops
./deploy.sh
```

#### **Option B: GitLab CI/CD**
```bash
# Push to main branch
git add .
git commit -m "Deploy Item Drops site"
git push origin main
```

## 🎯 Alternative: Direct R2 Upload

If you prefer direct file storage:

### **Setup R2 Bucket**
```bash
# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure for R2
aws configure
# AWS Access Key ID: your_r2_access_key
# AWS Secret Access Key: your_r2_secret_key  
# Default region name: auto
# Default output format: json

# Upload site
cd /home/chris/game_dev/docs/item_drops
hugo --minify

aws s3 sync ./public/ s3://item-drops-site/ \
  --endpoint-url https://your_account_id.r2.cloudflarestorage.com \
  --delete
```

## 🔧 Troubleshooting

### **Common Issues**

**❌ "Missing required environment variables"**
```bash
# Check variables are set
echo $CLOUDFLARE_API_TOKEN
echo $CLOUDFLARE_ACCOUNT_ID

# Set them if missing
export CLOUDFLARE_API_TOKEN="your_token"
export CLOUDFLARE_ACCOUNT_ID="your_id"
```

**❌ "Hugo build failed"**
```bash
# Check Hugo installation
hugo version

# Clean build
rm -rf public
hugo --minify --gc --verbose
```

**❌ "Deployment failed"**
```bash
# Test API connection
curl -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  "https://api.cloudflare.com/client/v4/user/tokens/verify"
```

### **Get Help**

- **Cloudflare API docs**: https://developers.cloudflare.com/pages/api/
- **Hugo docs**: https://gohugo.io/
- **GitLab CI/CD**: https://docs.gitlab.com/ee/ci/

---

## 🎉 Success!

When deployed successfully:
- **Production**: https://item-drops.pages.dev
- **Staging**: https://item-drops-staging.pages.dev (if configured)

Your Item Drops documentation will be live with:
- ✅ Fast Cloudflare CDN
- ✅ SSL certificate included  
- ✅ Global distribution
- ✅ No Wrangler dependencies!
