import { Hono } from 'hono'
import { serveStatic } from 'hono/cloudflare-workers'

const app = new Hono()

// Serve static files from public directory
app.use('/static/*', serveStatic({ root: './public' }))

// Main route - serve the index.html
app.get('/', serveStatic({ path: './public/static/index.html' }))

// Health check
app.get('/health', (c) => {
  return c.json({ status: 'healthy', timestamp: new Date().toISOString() })
})

export default app
