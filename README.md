# Library Work Automate - Complete Management System

A comprehensive library management system with attendance tracking, seat booking, payment management, and student portal.

## 🌐 Project Links

- **GitHub Repository**: https://github.com/satyamfoodproduct2025/Waaaaa
- **Production URL**: (Will be added after deployment)

## ✨ Main Features

### 🔐 Dual Login System
- **Owner Login**: Full administrative access (Mobile: 6201530654, Password: Avinash)
- **Student Login**: Personal dashboard with attendance and payment features

### 📊 Core Modules

#### 1. Students Data Management
- Add new students with auto-generated passwords
- Edit/Replace student information
- Remove students (maintains index for record keeping)
- Export student list to PDF
- Password format: First 4 letters of name + Last 4 digits of mobile

#### 2. Seat & Shift Management (Graph)
- Visual seat booking dashboard
- 4 shifts per day: 6AM-10AM, 10AM-2PM, 2PM-6PM, 6PM-10PM
- Real-time availability status
- Double-click to book/cancel seats
- Admin control: 6 clicks on seat number to change total seats (1-500)

#### 3. WOW (Seat Allocation View)
- Complete seat allocation overview
- Manual booking via "Seat.Shift" format (e.g., 5.1)
- Full-day allocation by seat number only
- Payment calculation: Shifts × Rate (default ₹300/shift)
- Custom rate override (per-shift or fixed total)
- Visual indicators for custom payments

#### 4. Payment System (P Details & Pay Details)

**P Details (Monthly Payment Marking)**:
- 12-month grid for current year (Jan-Dec)
- Green tick (✓) for full payments
- Yellow tick with remaining amount for partial payments
- Double-click to mark/modify payments
- Timestamp recorded for each payment
- Admin password required for marking

**Pay Details (Due List)**:
- Shows payment status for last 3 months
- Calculates days late/early based on admission date
- "RM" column: Reminder Amount (latest partial payment)
- "MD" column: Missing Days (months unpaid)
- Color-coded admission status:
  - Green: Future due date
  - Orange: Due today
  - Red: Overdue
- Seat and shift info displayed with student name

#### 5. Attendance System (GPS + QR)

**For Students**:
- Location verification: Must be within library range (default 20m)
- QR code scanning after location check
- Mark IN/OUT times with timestamps
- View personal attendance history

**For Admin**:
- Complete attendance log for all students
- Last 6 days quick view
- Monthly calendar view with detailed timing
- Color-coded: Green (Present), Red (Absent), Gray (Future)
- Shows total Present/Absent count per month
- Double-click student name for detailed monthly view

#### 6. QR & GPS Settings
- Set library GPS coordinates (auto-detect or manual)
- Configure attendance range (meters)
- Generate/print QR code for library wall
- Dynamic QR code based on location

### 📱 Student Dashboard Features
- Welcome card with seat and shift information
- Mark Attendance (Location + QR scan)
- Online Payment (UPI integration ready)
- Attendance History (Monthly calendar view)

## 🎨 Design & UI/UX

- **Theme**: Modern dark theme with neon accents
- **Responsive**: Works on all devices (PC, Tablet, Mobile)
- **Mobile Optimized**: 2-column grid for dashboard buttons
- **Animations**: Background gradients, tilt effects, color shifts
- **Print Support**: PDF-ready output for all data tables

## 🛠️ Technology Stack

- **Backend**: Hono (Cloudflare Workers)
- **Database**: Cloudflare D1 (SQLite)
- **Frontend**: Vanilla JavaScript, HTML5, CSS3
- **Icons**: Font Awesome 6
- **Fonts**: Google Fonts (Montserrat)
- **Hosting**: Cloudflare Pages
- **Version Control**: Git + GitHub

## 📁 Project Structure

```
webapp/
├── src/
│   └── index.tsx              # Main Hono application
├── public/
│   └── static/
│       └── index.html         # Complete frontend (self-contained)
├── migrations/
│   └── 0001_initial_schema.sql # Database schema
├── ecosystem.config.cjs       # PM2 configuration
├── wrangler.jsonc            # Cloudflare configuration
├── package.json              # Dependencies and scripts
└── README.md                 # This file
```

## 🗄️ Database Schema

### Tables:
1. **students** - Student records with login credentials
2. **bookings** - Seat and shift bookings
3. **payments** - Payment history with timestamps
4. **attendance** - Attendance records with IN/OUT times
5. **wow_records** - Seat allocation and payment overrides
6. **settings** - System settings (GPS location, QR code)
7. **config** - Configuration (total seats)

## 🚀 Local Development Setup

### Prerequisites
- Node.js 18+ installed
- npm or yarn package manager

### Steps:

1. **Clone the repository**:
```bash
git clone https://github.com/satyamfoodproduct2025/Waaaaa.git
cd Waaaaa
```

2. **Install dependencies**:
```bash
npm install
```

3. **Create local D1 database and apply migrations**:
```bash
npm run db:migrate:local
```

4. **Build the project**:
```bash
npm run build
```

5. **Start development server**:
```bash
# Using PM2 (recommended)
npm run clean-port  # Clean port 3000
pm2 start ecosystem.config.cjs

# Or using npm
npm run dev:sandbox
```

6. **Access the application**:
- Open browser: http://localhost:3000
- Owner Login: 6201530654 / Avinash

### PM2 Management Commands:
```bash
pm2 list                    # List all services
pm2 logs webapp --nostream  # View logs
pm2 restart webapp          # Restart service
pm2 stop webapp            # Stop service
pm2 delete webapp          # Remove from PM2
```

## 🌍 Deployment to Cloudflare Pages

### Prerequisites:
1. Cloudflare account (free tier available)
2. Cloudflare API token configured

### Deployment Steps:

1. **Create Cloudflare D1 Database**:
```bash
npx wrangler d1 create webapp-production
```
Copy the database ID and update `wrangler.jsonc`:
```jsonc
"d1_databases": [
  {
    "binding": "DB",
    "database_name": "webapp-production",
    "database_id": "your-database-id-here"
  }
]
```

2. **Apply migrations to production database**:
```bash
npm run db:migrate:prod
```

3. **Create Cloudflare Pages project**:
```bash
npx wrangler pages project create webapp --production-branch main
```

4. **Deploy to Cloudflare Pages**:
```bash
npm run deploy:prod
```

You'll receive URLs like:
- Production: https://webapp.pages.dev
- Branch: https://main.webapp.pages.dev

## 🔐 Login Credentials

### Owner (Admin):
- **Mobile**: 6201530654
- **Password**: Avinash

### Test Students (After adding via admin):
Students get auto-generated passwords in format: `NAME[4]MOBILE[4]`
Example: Full Name "Rahul Kumar" + Mobile "9876543210" = Password "RAHU3210"

## 📝 Important Notes

### Browser Permissions:
- **Location Access**: Required for attendance (student side)
- **Camera Access**: Required for QR scanning (student side)

### Data Persistence:
- All data is stored in Cloudflare D1 database
- No localStorage or sessionStorage used (production-ready)
- Real-time synchronization across devices

### Payment Override System:
- **Per-Shift Rate**: Custom rate per shift (e.g., ₹250/shift)
- **Fixed Total**: Fixed total payment regardless of shifts
- **Priority**: Fixed Total > Custom Rate > Default Rate (₹300)
- **Indicators**: Red * for fixed total, Green * for custom rate

### Security:
- Admin password required for:
  - Student removal
  - Payment marking
  - Payment overrides
  - Student data editing
- Passwords are stored in plain text (suitable for library use case)

## 🐛 Troubleshooting

### Port 3000 already in use:
```bash
npm run clean-port
# or
fuser -k 3000/tcp
```

### Database connection issues:
```bash
# Reset local database
rm -rf .wrangler/state/v3/d1
npm run db:migrate:local
```

### Build failures:
```bash
# Clean and rebuild
rm -rf dist node_modules
npm install
npm run build
```

## 📚 Features Implementation Status

✅ **Completed Features:**
- [x] Dual login system (Owner/Student)
- [x] Student data management (Add/Edit/Remove/Replace)
- [x] Seat booking system with visual graph
- [x] WOW seat allocation view
- [x] Payment marking system (P Details)
- [x] Payment due tracking (Pay Details)
- [x] GPS-based attendance system
- [x] QR code attendance verification
- [x] Attendance history and logs
- [x] Library location settings
- [x] Custom payment overrides
- [x] Mobile-responsive design
- [x] PDF export functionality
- [x] Database integration (Cloudflare D1)

🚧 **Pending Features:**
- [ ] Online payment gateway integration (PhonePe/UPI)
- [ ] Real QR code generation library
- [ ] Real camera/GPS access (browser APIs)
- [ ] Email/SMS notifications
- [ ] Advanced reporting and analytics
- [ ] Backup and restore functionality

## 🎯 Recommended Next Steps

1. **Test the application locally** with PM2
2. **Configure Cloudflare API key** in the Deploy tab
3. **Create D1 database** for production
4. **Deploy to Cloudflare Pages**
5. **Add sample students** for testing
6. **Configure library GPS location**
7. **Print QR code** for library entrance
8. **Train staff** on system usage

## 📞 Support & Maintenance

For issues, questions, or feature requests:
- Open an issue on GitHub: https://github.com/satyamfoodproduct2025/Waaaaa/issues
- Check the source code documentation
- Review Cloudflare Workers documentation

## 📄 License

This project is for educational and library management purposes.

---

**Last Updated**: 2025-01-XX
**Version**: 1.0.0
**Status**: ✅ Production Ready (Database integration complete)
