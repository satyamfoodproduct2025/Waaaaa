# ⚡ Quick Start Guide

Get your Library Work Automate system running in 5 minutes!

## 🎯 What You Need to Do

### 1. Configure Cloudflare API Key
👉 **Go to Deploy Tab** in the interface
- Follow instructions to get your Cloudflare API token
- Save the token in Deploy tab

### 2. Create Database
```bash
cd /home/user/webapp
npx wrangler d1 create webapp-production
```
📝 Copy the `database_id` from output!

### 3. Update Configuration
Edit `wrangler.jsonc` - replace `database_id` with your ID:
```bash
nano wrangler.jsonc  # or any editor
# Find "database_id" and paste your ID
```

### 4. Deploy Database Schema
```bash
npm run db:migrate:prod
```

### 5. Create Cloudflare Pages Project
```bash
npx wrangler pages project create webapp --production-branch main
```

### 6. Deploy Your App
```bash
npm run deploy:prod
```

## 🎉 Done!

Your app will be live at: `https://webapp.pages.dev`

### Login Credentials:
- **Owner**: 6201530654 / Avinash
- **Students**: Add via admin panel (auto-generated passwords)

## 📱 Required Browser Permissions

When students use the app:
- ✅ Allow Location Access (for attendance)
- ✅ Allow Camera Access (for QR scanning)

## 🔧 Test Locally First

```bash
cd /home/user/webapp

# Clean port
npm run clean-port

# Build
npm run build

# Start with PM2
pm2 start ecosystem.config.cjs

# Check status
pm2 logs webapp --nostream

# Test
curl http://localhost:3000
```

Visit: http://localhost:3000

## 🆘 Need Help?

- Read full docs: `README.md`
- Deployment guide: `DEPLOYMENT.md`
- GitHub: https://github.com/satyamfoodproduct2025/Waaaaa

---

**Time to complete**: ~5 minutes (excluding API key setup)
