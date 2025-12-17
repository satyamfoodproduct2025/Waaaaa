# 🚀 Cloudflare Deployment Guide

Complete guide for deploying Library Work Automate to Cloudflare Pages.

## 📋 Prerequisites

1. **Cloudflare Account**: Sign up at https://dash.cloudflare.com
2. **Cloudflare API Token**: Required for deployment
3. **GitHub Repository**: Code already pushed to https://github.com/satyamfoodproduct2025/Waaaaa

## 🔧 Step-by-Step Deployment

### Step 1: Configure Cloudflare API Key

1. Go to the **Deploy** tab in this interface
2. Follow instructions to create Cloudflare API token:
   - Login to Cloudflare Dashboard
   - Go to "My Profile" > "API Tokens"
   - Click "Create Token"
   - Use "Edit Cloudflare Workers" template
   - Copy the generated token
3. Paste the token in Deploy tab and save

### Step 2: Create D1 Database

```bash
cd /home/user/webapp

# Create production D1 database
npx wrangler d1 create webapp-production
```

**Important**: Copy the `database_id` from the output!

Output will look like:
```
✅ Successfully created DB 'webapp-production'

[[d1_databases]]
binding = "DB"
database_name = "webapp-production"
database_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

### Step 3: Update Configuration

Edit `wrangler.jsonc` and replace `database_id`:

```jsonc
{
  "d1_databases": [
    {
      "binding": "DB",
      "database_name": "webapp-production",
      "database_id": "paste-your-database-id-here"
    }
  ]
}
```

Save and commit:
```bash
git add wrangler.jsonc
git commit -m "Update D1 database ID"
git push origin main
```

### Step 4: Apply Database Migrations

```bash
# Apply migrations to production database
npm run db:migrate:prod
```

Verify migration:
```bash
npx wrangler d1 execute webapp-production --command="SELECT COUNT(*) FROM students"
```

### Step 5: Create Cloudflare Pages Project

```bash
# Create project with main branch as production
npx wrangler pages project create webapp --production-branch main
```

### Step 6: Build and Deploy

```bash
# Build the project
npm run build

# Deploy to Cloudflare Pages
npx wrangler pages deploy dist --project-name webapp
```

### Step 7: Access Your Application

After successful deployment, you'll receive URLs:

- **Production**: `https://webapp.pages.dev`
- **Branch URL**: `https://main.webapp.pages.dev`

## 🎯 Quick Deploy Commands

After initial setup, use these commands for future deployments:

```bash
# Full deployment
cd /home/user/webapp
npm run deploy:prod

# Or step by step
npm run build
npx wrangler pages deploy dist --project-name webapp
```

## 🔍 Verify Deployment

### 1. Test Health Endpoint
```bash
curl https://webapp.pages.dev/health
```

Expected response:
```json
{"status":"healthy","timestamp":"2025-01-XX..."}
```

### 2. Test Main Page
Visit: https://webapp.pages.dev

Should show the Library Work Automate login page.

### 3. Test Database Connection
Try logging in with owner credentials:
- Mobile: 6201530654
- Password: Avinash

## 🐛 Common Issues & Solutions

### Issue 1: "Module not found" error
**Solution**: Make sure you ran `npm run build` before deploying.

### Issue 2: Database connection error
**Solution**: 
1. Verify database_id in wrangler.jsonc
2. Check migrations were applied: `npm run db:migrate:prod`
3. Test database: `npx wrangler d1 execute webapp-production --command="SELECT 1"`

### Issue 3: 404 on static files
**Solution**: Ensure `public/static/index.html` exists and is included in build.

### Issue 4: "Authentication error"
**Solution**: Re-run `setup_cloudflare_api_key` tool or manually configure:
```bash
export CLOUDFLARE_API_TOKEN="your-token-here"
npx wrangler whoami  # Verify
```

### Issue 5: "Project name already taken"
**Solution**: Use a different project name:
```bash
npx wrangler pages project create webapp-library --production-branch main
# Then update all deploy commands to use new name
```

## 🔐 Environment Variables

For production, you may want to set environment variables:

```bash
# Set via Cloudflare Dashboard:
# Dashboard > Pages > webapp > Settings > Environment Variables

# Or via CLI:
npx wrangler pages secret put OWNER_PASSWORD --project-name webapp
# When prompted, enter: Avinash
```

## 📊 Monitor Your Deployment

### View Logs
```bash
# Real-time logs
npx wrangler pages deployment tail --project-name webapp

# Or view in dashboard:
# Dashboard > Pages > webapp > Deployments
```

### Check Analytics
Visit: https://dash.cloudflare.com
- Pages > webapp > Analytics
- View requests, bandwidth, errors

## 🔄 Update Workflow

When you make changes:

```bash
cd /home/user/webapp

# Make your changes...

# Test locally
npm run build
pm2 start ecosystem.config.cjs

# Commit and push
git add .
git commit -m "Your changes"
git push origin main

# Deploy to production
npm run deploy:prod
```

## 🌐 Custom Domain (Optional)

To use your own domain:

1. Go to Cloudflare Dashboard
2. Pages > webapp > Custom domains
3. Click "Set up a custom domain"
4. Enter your domain (e.g., library.yourdomain.com)
5. Follow DNS configuration instructions

```bash
# Or via CLI:
npx wrangler pages domain add library.yourdomain.com --project-name webapp
```

## 📈 Performance Tips

1. **Enable Cloudflare Cache**: Automatically enabled for static assets
2. **Use D1 Prepared Statements**: Already implemented in code
3. **Monitor Database Size**: Keep under D1 limits
4. **Optimize Images**: Compress images in public/static/

## 🔒 Security Checklist

- [x] HTTPS enabled (automatic with Cloudflare)
- [x] Admin password required for sensitive operations
- [x] Database access restricted to backend only
- [x] CORS configured for API endpoints
- [ ] Consider adding rate limiting for production
- [ ] Set up security headers via Cloudflare

## 📞 Need Help?

- Cloudflare Docs: https://developers.cloudflare.com/pages/
- Cloudflare Community: https://community.cloudflare.com/
- GitHub Issues: https://github.com/satyamfoodproduct2025/Waaaaa/issues

---

**Happy Deploying! 🎉**
