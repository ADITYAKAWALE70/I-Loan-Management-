# 🏦 I LOAN — LOAN MANAGEMENT SYSTEM
### Admin Dashboard Guide

> **Version**: 1.0 | **Updated**: 2026 | **Theme**: Navy Blue & Gold (Finance & Trust)
> **Stack**: React 18 + Vite + Bootstrap 5 + Chart.js | **Auth**: Basic Auth + SMTP Email

---

## 📑 TABLE OF CONTENTS

1. [Project Overview](#project-overview)
2. [System Architecture](#system-architecture)
3. [Folder Structure](#folder-structure)
4. [Authentication System](#authentication-system)
5. [Admin Dashboard Home](#admin-dashboard-home)
6. [Module 1 — Loan Enquiries](#module-1--loan-enquiries)
7. [Module 2 — Loan Applications](#module-2--loan-applications)
8. [Module 3 — Document Verification](#module-3--document-verification)
9. [Module 4 — Loan Approval](#module-4--loan-approval)
10. [Module 5 — Customer Records](#module-5--customer-records)
11. [Module 6 — Reports & Analytics](#module-6--reports--analytics)
12. [Module 7 — Settings](#module-7--settings)
13. [Email System (SMTP)](#email-system-smtp)
14. [Theme & Design System](#theme--design-system)
15. [Development & Deployment](#development--deployment)
16. [Security & Performance](#security--performance)
17. [Responsive Design](#responsive-design)
18. [Troubleshooting](#troubleshooting)

---

## PROJECT OVERVIEW

### Purpose

A professional single-admin web dashboard for managing the complete loan lifecycle — from initial customer enquiry, document collection & verification, to final loan approval — built as a **Final Year Degree Project** demonstrating real-world fintech workflow.

### Key Features

| Feature | Status |
|---|---|
| Navy Blue & Gold Finance Theme | ✅ |
| Basic Auth (Username + Password) | ✅ |
| SMTP Email Notifications | ✅ |
| Loan Enquiry Management | ✅ |
| Document Upload & Verification | ✅ |
| Loan Approval / Rejection Workflow | ✅ |
| Single Admin Dashboard | ✅ |
| Mobile Responsive Design (MD+) | ✅ |
| Customer Records Management | ✅ |
| Reports & Analytics (Chart.js) | ✅ |

### Technology Stack

```
Frontend:     React 18.2.0, Vite, Bootstrap 5.3.2
Charts:       Chart.js 4.4.0, React-ChartJS-2 5.2.0
Export:       XLSX 0.18.5, jsPDF 4.2.1
UI Helpers:   SweetAlert2 11.7.32
Runtime:      Node.js 18+
Email:        Nodemailer (SMTP — Gmail / Custom SMTP)
Auth:         HTTP Basic Auth (bcryptjs)
```

---

## SYSTEM ARCHITECTURE

```
┌──────────────────────────────────────────────────┐
│                  ADMIN BROWSER                   │
│                                                  │
│   ┌──────────────────────────────────────────┐   │
│   │        I LOAN ADMIN DASHBOARD            │   │
│   │  Header/Navbar → Search, Notifications   │   │
│   │  Sidebar Nav   → All Modules             │   │
│   │  Main Content  → Tables, Charts, Forms   │   │
│   │  Modals        → Verify, Approve, View   │   │
│   └──────────────────────────────────────────┘   │
└──────────────────────────────────────────────────┘
                        │
        ┌───────────────▼───────────────┐
        │   REACT SERVICES & CONTEXT    │
        │  Auth Context, API Services   │
        │  Email (SMTP), File Upload    │
        └───────────────────────────────┘
                        │
        ┌───────────────▼───────────────┐
        │        BACKEND REST API       │
        │  Auth, Loans, Documents,      │
        │  Customers, SMTP Email        │
        └───────────────────────────────┘
                        │
        ┌───────────────▼───────────────┐
        │           DATABASE            │
        │  Admin, Customers, Loans,     │
        │  Documents, Enquiries, Logs   │
        └───────────────────────────────┘
```

---

## FOLDER STRUCTURE

```
src/
├── main.jsx
├── App.jsx
├── config/
│   ├── theme.js
│   ├── constants.js
│   └── api.config.js
├── styles/
│   ├── variables.css
│   ├── global.css
│   ├── dashboard.css
│   ├── tables.css
│   ├── forms.css
│   ├── modal.css
│   ├── responsive.css
│   └── animations.css
├── components/
│   ├── common/          # Header, Sidebar, Footer, Loader, Breadcrumb
│   ├── admin/           # DashboardMetrics, StatCard, Charts, QuickActions
│   ├── tables/          # EnquiryTable, LoanTable, DocumentTable
│   ├── forms/           # LoanForm, SearchFilter, DocumentUpload
│   ├── modals/          # VerifyDocModal, ApproveModal, ViewLoanModal
│   ├── notifications/   # Toast, Alert, NotificationBell
│   └── cards/           # LoanStatusCard, StatsCard, CustomerCard
├── pages/
│   ├── auth/            # Login, ForgotPassword
│   └── admin/
│       ├── AdminDashboard.jsx
│       └── modules/
│           ├── enquiries/    # EnquiriesList, EnquiryDetails
│           ├── applications/ # LoanApplications, ApplicationDetails
│           ├── documents/    # DocumentList, VerifyDocument
│           ├── approval/     # ApprovalQueue, ApproveReject
│           ├── customers/    # CustomersList, CustomerProfile
│           ├── reports/      # LoanReports, ExportReports
│           └── settings/     # GeneralSettings, SMTPSettings
├── hooks/               # useAuth, useEmail, useFetch, useForm, usePagination
├── services/            # api, auth, email, loan, document, report
├── context/             # AuthContext, DashboardContext, NotificationContext
└── utils/               # dateFormatter, validators, formatters, errorHandler
```

---

## AUTHENTICATION SYSTEM            T 

### Login — Basic Auth

**Route**: `/login` | **Component**: `Login.jsx`

Single admin access with username and password stored securely (bcryptjs hashed in DB).

```
┌─────────────────────────────┐
│       🏦 I LOAN             │
│   Loan Management System    │
│                             │
│  Welcome, Admin!            │
│                             │
│  Email:    [____________]   │
│  Password: [___________] 👁 │
│                             │
│  ⚠ Invalid credentials      │
│                             │
│  [      LOGIN      ]        │
│                             │
│  [Forgot Password?]         │
└─────────────────────────────┘
```

**Fields**: Email, Password (show/hide toggle)
**Errors**: Invalid credentials alert, too many attempts lockout

### Forgot Password

- Admin enters registered email → reset link sent via SMTP
- Reset link expires in **1 hour**
- Route: `/reset-password/:token`

---

## ADMIN DASHBOARD HOME

**Route**: `/admin/dashboard` | **Component**: `AdminDashboard.jsx`

### Layout

```
┌──────────────────────────────────────────────────────┐
│ 🏦 I LOAN  │  Search...     │  🔔 Notifications │ 👤 │
├────────────┬─────────────────────────────────────────┤
│            │                                         │
│  SIDEBAR   │  ┌──────────────────────────────────┐   │
│            │  │  KPI Cards (4 columns)            │   │
│ 🏠 Home    │  │  Total Enquiries | Active Loans   │   │
│ 📋 Enquiry │  │  Pending Verify  | Approved Today │   │
│ 📁 Loans   │  └──────────────────────────────────┘   │
│ 📄 Docs    │  ┌─────────────────┐ ┌──────────────┐   │
│ ✅ Approval│  │  Loan Status    │ │ Monthly Apps │   │
│ 👥 Customer│  │  (Pie Chart)    │ │ (Bar Chart)  │   │
│ 📊 Reports │  └─────────────────┘ └──────────────┘   │
│ ⚙ Settings │  ┌──────────────────────────────────┐   │
│            │  │  Recent Enquiries (Last 10)       │   │
│            │  ├──────────────────────────────────┤   │
│            │  │  Pending Document Verifications  │   │
│            │  ├──────────────────────────────────┤   │
│            │  │  Approval Queue (Awaiting Action) │   │
│            │  └──────────────────────────────────┘   │
├────────────┴─────────────────────────────────────────┤
│     © 2026 I Loan Management System — All Rights Reserved │
└──────────────────────────────────────────────────────┘
```

### KPI Metrics

| Card | Value | Trend |
|---|---|---|
| Total Enquiries | Count | vs last month |
| Active Loan Applications | Count | In-progress |
| Pending Document Verifications | Count | Needs action |
| Loans Approved Today | Count | Today's count |

---

## MODULE 1 — LOAN ENQUIRIES

**Route**: `/admin/enquiries` | **Component**: `EnquiriesList.jsx`

Captures all incoming customer loan enquiries (submitted via public form or manually added by admin).

**Fields Captured**: Full Name, Mobile, Email, Loan Type, Loan Amount Required, City, Message, Enquiry Date, Status

**Statuses**: `New` → `In Progress` → `Converted` / `Rejected`

**Features**:
- Paginated table with search and filters (Loan Type, Status, Date Range)
- View full enquiry detail in modal
- Change enquiry status with one click
- Convert enquiry into a formal Loan Application
- Send follow-up email to customer via SMTP
- Export enquiry list (Excel / PDF / CSV)

---

## MODULE 2 — LOAN APPLICATIONS

**Route**: `/admin/applications` | **Component**: `LoanApplications.jsx`

Full loan application records created from enquiries or added directly by admin.

**Application Fields**: Applicant Name, DOB, PAN Number, Aadhaar Number, Address, Employment Type, Monthly Income, Loan Type (Home / Personal / Business / Education / Vehicle), Loan Amount, Tenure (Months), Purpose, Co-Applicant Details (if any), Application Date, Status

**Loan Types Supported**:

| Loan Type | Description |
|---|---|
| Home Loan | Property purchase or construction |
| Personal Loan | Individual personal needs |
| Business Loan | Business setup or expansion |
| Education Loan | Higher education funding |
| Vehicle Loan | Two-wheeler or four-wheeler |

**Application Statuses**: `Draft` → `Submitted` → `Under Review` → `Approved` / `Rejected` / `Disbursed`

**Features**:
- Full application listing with advanced search and filters
- View application detail with all fields
- Edit application before submission
- Attach and link documents from Document module
- Track status history (timeline view)
- Send status update email to applicant via SMTP

---

## MODULE 3 — DOCUMENT VERIFICATION

**Route**: `/admin/documents` | **Component**: `DocumentList.jsx`

Central hub for uploading, viewing, and verifying all KYC and supporting documents for each loan application.

**Document Types**:

| Document | Type |
|---|---|
| Aadhaar Card | KYC — Identity |
| PAN Card | KYC — Identity |
| Passport / Voter ID | KYC — Address Proof |
| Bank Statements (6 months) | Financial |
| Salary Slips (3 months) | Income Proof |
| ITR / Form 16 | Tax Proof |
| Property Documents | Collateral (Home Loan) |
| Business Registration | Business Loan |
| Admission Letter / Fee Receipt | Education Loan |
| Vehicle Quotation | Vehicle Loan |
| Photograph | KYC |

**Document Statuses**: `Pending` → `Uploaded` → `Under Verification` → `Verified` / `Rejected`

**Verification Workflow**:

```
Customer Uploads Doc
        │
        ▼
Admin Reviews Doc
        │
   ┌────┴────┐
   ▼         ▼
Verified   Rejected
   │         │
   │    Send Rejection Email
   │    with Reason (SMTP)
   │
   ▼
All Docs Verified?
        │
        ▼
   Move to Approval Queue
```

**Features**:
- View uploaded document (inline preview for images & PDFs)
- Mark document as Verified or Rejected with reason
- Send email notification to customer on rejection (SMTP)
- Document checklist per loan type (auto-shows required docs)
- Bulk verification status update

---

## MODULE 4 — LOAN APPROVAL

**Route**: `/admin/approval` | **Component**: `ApprovalQueue.jsx`

Final stage where admin reviews fully verified applications and makes the approval or rejection decision.

**Approval Checklist (shown per application)**:

- [ ] All required documents verified
- [ ] CIBIL / credit check noted
- [ ] Loan amount within eligibility
- [ ] Income-to-EMI ratio acceptable
- [ ] Co-applicant details valid (if applicable)

**Actions Available**:

| Action | Description |
|---|---|
| Approve | Approve loan; triggers approval email via SMTP |
| Reject | Reject with reason; triggers rejection email via SMTP |
| Request Info | Ask customer for more information |
| Sanction Letter | Generate and send Sanction Letter (PDF) |
| Mark Disbursed | Mark loan as disbursed after amount transfer |

**Features**:
- Side-by-side view of application + documents during approval
- Add internal remarks / notes per application
- Full audit trail of approval actions with timestamps
- Approved loans automatically move to Customer Records

---

## MODULE 5 — CUSTOMER RECORDS

**Route**: `/admin/customers` | **Component**: `CustomersList.jsx`

Master record of all customers who have submitted loan applications, with their complete loan history.

**Customer Profile Includes**:
- Personal details (Name, DOB, Contact, Address)
- KYC document status
- All loan applications and their statuses
- Approved loan details (Amount, Tenure, EMI, Disbursed Date)
- Document history
- Communication log (emails sent)

**Features**:
- Search and filter customers (Name, Mobile, Loan Type, Status)
- View full customer profile in a detailed modal
- View all loans linked to a customer
- Resend emails from communication log
- Export customer data (Excel / PDF)

---

## MODULE 6 — REPORTS & ANALYTICS

**Route**: `/admin/reports` | **Component**: `ReportsPage.jsx`

Visual analytics and exportable reports for the complete loan operations.

**Charts Available**:

| Chart | Type | Data |
|---|---|---|
| Monthly Applications | Bar Chart | Applications per month |
| Loan Status Breakdown | Pie/Donut | Approved / Rejected / Pending |
| Loan Type Distribution | Donut Chart | Home / Personal / Business etc. |
| Document Verification Rate | Line Chart | Verified over time |
| Approval Turnaround Time | Bar Chart | Days taken to approve |

**Export Options**: Excel (.xlsx), PDF, CSV

**Report Types**:
- Enquiry Report (date range filter)
- Application Status Report
- Document Verification Report
- Approved Loans Report
- Rejected Loans Report with reasons

---

## MODULE 7 — SETTINGS

**Route**: `/admin/settings` | **Component**: `SettingsPage.jsx`

Admin configuration panel for system preferences, SMTP setup, and email templates.

### 7.1 General Settings
- System name, logo upload, contact email
- Default loan interest rate reference
- Currency symbol (₹ INR default)

### 7.2 SMTP Email Settings

```
┌────────────────────────────────────┐
│  SMTP Configuration                │
│                                    │
│  SMTP Host:  [smtp.gmail.com    ]  │
│  SMTP Port:  [587               ]  │
│  Username:   [admin@domain.com  ]  │
│  Password:   [***************   ]  │
│  From Name:  [I Loan System     ]  │
│  From Email: [noreply@iloan.in  ]  │
│                                    │
│  [ Save ]   [ Send Test Email ]    │
└────────────────────────────────────┘
```

### 7.3 Email Templates

Editable templates for each triggered email:

| Template | Trigger |
|---|---|
| Enquiry Received | New enquiry submitted |
| Application Submitted | Loan application created |
| Document Rejected | Document fails verification |
| All Documents Verified | All docs approved |
| Loan Approved | Final approval granted |
| Loan Rejected | Final rejection |
| Sanction Letter | Sent with approval |
| Password Reset | Admin forgot password |

**Template Variables**:
```
{customer_name}    {loan_id}        {loan_amount}
{loan_type}        {status}         {rejection_reason}
{emi_amount}       {tenure}         {disbursement_date}
{reset_link}       {admin_email}    {website_url}
```

---

## EMAIL SYSTEM (SMTP)

All emails are sent through **Nodemailer** using configured SMTP credentials (Gmail App Password or custom SMTP server). No third-party paid email API is required.

### Email Triggers & Templates

#### Enquiry Confirmation
```
Subject: We received your loan enquiry — I Loan

Hello {customer_name},

Thank you for your enquiry for a {loan_type} of ₹{loan_amount}.
Our team will contact you within 24–48 hours.

Regards,
I Loan Management System
```

#### Loan Application Submitted
```
Subject: Loan Application #{loan_id} Submitted — I Loan

Hello {customer_name},

Your loan application (ID: #{loan_id}) has been submitted.
Please upload the required documents to proceed.

Regards,
I Loan Management System
```

#### Document Rejected
```
Subject: Document Rejected — Action Required

Hello {customer_name},

Your document "{document_name}" was rejected.
Reason: {rejection_reason}

Please re-upload the correct document.
```

#### Loan Approved
```
Subject: 🎉 Congratulations! Your Loan is Approved — I Loan

Hello {customer_name},

Your {loan_type} of ₹{loan_amount} has been APPROVED.
EMI Amount: ₹{emi_amount} | Tenure: {tenure} months

Your Sanction Letter is attached.
```

#### Loan Rejected
```
Subject: Loan Application Update — I Loan

Hello {customer_name},

After review, your loan application #{loan_id} could not be approved.
Reason: {rejection_reason}

You may reapply after 90 days.
```

---

## THEME & DESIGN SYSTEM

### Color Palette

```css
/* Primary */
--primary-navy:   #0a1628
--dark-bg:        #0f1f3d
--dark-card:      #162040
--gold:           #c9a84c
--gold-light:     #e0bb6a
--gold-dark:      #a07830

/* Neutral */
--white:          #ffffff
--text-primary:   #e8eaf0
--text-secondary: #8a99b5
--border-color:   #1e3060
--hover-bg:       #1a2f58

/* Status */
--success:        #28a745
--warning:        #ffc107
--danger:         #dc3545
--info:           #17a2b8
--pending:        #fd7e14
```

### Typography

```css
/* Fonts */
Main Font:     'Inter', sans-serif
Heading Font:  'Poppins', sans-serif

/* Sizes */
H1: 2.5rem  H2: 2rem   H3: 1.5rem
H4: 1.25rem H5: 1rem   Body: 1rem
Small: 0.875rem         XSmall: 0.75rem
```

### Spacing & Radius

```css
--spacing-xs: 0.25rem    --radius-sm:   4px
--spacing-sm: 0.5rem     --radius-md:   8px
--spacing-md: 1rem       --radius-lg:   12px
--spacing-lg: 1.5rem     --radius-xl:   16px
--spacing-xl: 2rem       --radius-full: 9999px
```

---

## DEVELOPMENT & DEPLOYMENT

### Installation

```bash
git clone https://github.com/your-repo/i-loan-management.git
cd i-loan-management
npm install
cp .env.example .env.development
npm run dev
# Runs at http://localhost:5173
```

### Environment Variables

```env
VITE_API_BASE_URL=http://localhost:3000/api
VITE_APP_NAME=I Loan Management System

# SMTP
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
SMTP_FROM=noreply@iloan.in

# Auth
JWT_SECRET=your_jwt_secret_here
ADMIN_EMAIL=admin@iloan.in
```

### Vite Config

```js
// vite.config.js
export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    proxy: {
      '/api': { target: 'http://localhost:3000', changeOrigin: true }
    }
  }
})
```

### Build & Deploy

```bash
npm run build       # Production build → /dist
npm run preview     # Preview build locally

# Vercel
npx vercel --prod

# Netlify
npx netlify deploy --prod
```

### Production Checklist

- [ ] All `.env` variables configured
- [ ] SMTP test email verified from Settings
- [ ] API endpoints confirmed and tested
- [ ] File upload path configured (documents storage)
- [ ] SSL / HTTPS enabled on hosting
- [ ] Mobile responsiveness tested (MD, SM breakpoints)
- [ ] Lighthouse score reviewed
- [ ] Error handling in all API calls
- [ ] Loading states on all async operations
- [ ] Basic auth credentials changed from default

---

## SECURITY & PERFORMANCE

### Security Best Practices

- [ ] Basic Auth with bcryptjs password hashing
- [ ] JWT session token with expiry (1 hour + refresh)
- [ ] All form inputs sanitized (XSS prevention)
- [ ] HTTPS enforced on production
- [ ] Secure HTTP headers (CSP, HSTS, X-Frame-Options)
- [ ] API rate limiting on backend
- [ ] File upload validation (type, size limits)
- [ ] Uploaded documents stored securely (not public URL)
- [ ] Audit logs for all admin actions

### Performance Optimization

| Technique | Implementation |
|---|---|
| Code Splitting | React.lazy + Suspense per route |
| Image Optimization | WebP format, lazy loading |
| Debouncing | Search and filter inputs (300ms) |
| Pagination | Server-side, 20 items/page default |
| Memoization | React.memo, useMemo, useCallback |
| Caching | API response caching (React Query) |
| Tree Shaking | Vite default — removes unused code |

---

## RESPONSIVE DESIGN

The dashboard is fully responsive and properly displays on medium (MD) and larger devices.

```css
Mobile:       320px – 767px   (sidebar collapses to hamburger menu)
Tablet (MD):  768px – 1023px  (sidebar icon-only or toggleable)
Desktop:      1024px – 1439px (full sidebar + content layout)
Large Screen: 1440px+         (wide layout, max-content-width: 1400px)
```

**Mobile Behaviour**:
- Sidebar collapses into a hamburger (☰) menu
- KPI cards stack in 2×2 grid
- Tables have horizontal scroll on small screens
- Modals go full-screen on mobile
- Charts scale responsively via Chart.js responsive: true

---

## TROUBLESHOOTING

| Issue | Solution |
|---|---|
| Login not working | Check admin credentials in DB, verify bcrypt hash |
| SMTP email not sending | Verify SMTP config in Settings, enable Gmail App Password |
| Document upload fails | Check file size limit (max 5MB), allowed types (PDF/JPG/PNG) |
| Charts not rendering | Verify Chart.js import, check data format passed as props |
| API connection error | Verify `VITE_API_BASE_URL` in `.env`, check CORS on backend |
| Theme not applying | Check CSS variable definitions, clear browser cache |
| Form validation failing | Check validator functions, review console for JS errors |

---

## SUPPORT & CONTACT

| Channel | Details |
|---|---|
| Project Email | admin@iloan.in |
| Developer | Final Year Project — Computer Science |
| Institution | Your College Name Here |
| Guided By | Prof. / Guide Name Here |

---

*© 2026 I Loan Management System — All Rights Reserved*
*Final Year Degree Project — Computer Science & Engineering*
