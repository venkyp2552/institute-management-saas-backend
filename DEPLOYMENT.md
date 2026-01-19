# Deployment Guide

## Vercel Deployment (Recommended)

### Prerequisites
- GitHub account
- Vercel account
- Supabase project set up

### Step 1: Prepare Repository
1. Push your code to GitHub
2. Ensure `.env.local` is in `.gitignore` (already done)
3. Create production Supabase project (or use existing)

### Step 2: Deploy to Vercel
1. Go to [vercel.com](https://vercel.com)
2. Click "New Project"
3. Import your GitHub repository
4. Configure project settings:
   - Framework Preset: Next.js
   - Root Directory: `./` (default)
   - Build Command: `npm run build` (default)
   - Output Directory: `.next` (default)

### Step 3: Environment Variables
Add these environment variables in Vercel dashboard:

```env
NEXT_PUBLIC_SUPABASE_URL=your_production_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_production_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_production_service_role_key
```

### Step 4: Deploy
1. Click "Deploy"
2. Wait for build to complete
3. Visit your deployed URL

### Step 5: Configure Custom Domain (Optional)
1. Go to Project Settings → Domains
2. Add your custom domain
3. Configure DNS records as instructed

## Alternative Deployment Options

### Netlify
1. Connect GitHub repository
2. Build command: `npm run build`
3. Publish directory: `.next`
4. Add environment variables

### Railway
1. Connect GitHub repository
2. Add environment variables
3. Deploy automatically

### Docker Deployment

Create `Dockerfile`:
```dockerfile
FROM node:18-alpine

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]
```

Build and run:
```bash
docker build -t institute-saas .
docker run -p 3000:3000 institute-saas
```

## Production Checklist

### Security
- [ ] Environment variables are secure
- [ ] Supabase RLS policies are enabled
- [ ] API keys are not exposed in client code
- [ ] HTTPS is enabled

### Performance
- [ ] Images are optimized
- [ ] Database queries are efficient
- [ ] Caching is configured
- [ ] CDN is set up (Vercel handles this)

### Monitoring
- [ ] Error tracking (Sentry, LogRocket)
- [ ] Analytics (Google Analytics, Vercel Analytics)
- [ ] Uptime monitoring
- [ ] Performance monitoring

### Backup
- [ ] Database backups are automated (Supabase handles this)
- [ ] Code is backed up in version control
- [ ] Environment variables are documented

## Post-Deployment Setup

### 1. Create Platform Admin
```sql
-- Run in Supabase SQL Editor
INSERT INTO platform_admins (user_id, email, full_name) 
VALUES ('your-user-id', 'admin@yourdomain.com', 'Platform Admin');
```

### 2. Configure Email Templates
1. Go to Supabase → Authentication → Email Templates
2. Customize signup confirmation email
3. Customize password reset email

### 3. Set Up Custom SMTP (Optional)
1. Go to Supabase → Authentication → Settings
2. Configure custom SMTP settings
3. Test email delivery

### 4. Configure Storage (If using file uploads)
1. Go to Supabase → Storage
2. Create buckets for file uploads
3. Set up RLS policies for storage

## Maintenance

### Regular Tasks
- Monitor application performance
- Check error logs
- Update dependencies
- Backup database (automated by Supabase)
- Monitor user feedback

### Updates
1. Test changes locally
2. Deploy to staging environment (optional)
3. Deploy to production
4. Monitor for issues

## Scaling Considerations

### Database
- Monitor query performance
- Add indexes as needed
- Consider read replicas for high traffic

### Application
- Use Vercel's edge functions for better performance
- Implement caching strategies
- Consider CDN for static assets

### Monitoring
- Set up alerts for downtime
- Monitor response times
- Track user engagement metrics

## Troubleshooting

### Common Production Issues

**1. Build Failures**
- Check build logs in Vercel
- Ensure all dependencies are in package.json
- Verify TypeScript compilation

**2. Environment Variable Issues**
- Double-check variable names
- Ensure no trailing spaces
- Verify Supabase project settings

**3. Database Connection Issues**
- Check Supabase project status
- Verify RLS policies
- Check network connectivity

**4. Authentication Problems**
- Verify Supabase Auth configuration
- Check redirect URLs
- Ensure middleware is working

### Getting Help
- Check Vercel deployment logs
- Monitor Supabase logs
- Use browser dev tools for client-side issues
- Check application performance metrics

---

🚀 **Your Institute Management SaaS is now live in production!**