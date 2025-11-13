# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

Virtual Corporate Workspace (MVP) - A standalone virtual corporate office platform supporting multi-company workspaces, hierarchical structures, internal chat, task management, and dashboards.

**Tech Stack:**
- Backend: Node.js + Express + Socket.io (TypeScript)
- Frontend: React (Vite) + TailwindCSS (planned)
- Database: PostgreSQL
- Monorepo: npm workspaces

## Development Commands

### Setup
```powershell
# Install dependencies (run from root)
npm install
```

### Backend
```powershell
# Development mode with hot reload
cd backend
npm run dev

# Build TypeScript
npm run build

# Run production server
npm start
```

Backend runs on `http://localhost:4000` (or PORT env variable)

### Frontend
```powershell
# Development mode with hot reload
cd frontend
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

### Running Both Services
Since this is a monorepo, you'll typically need two terminal sessions:
- Terminal 1: `cd backend && npm run dev`
- Terminal 2: `cd frontend && npm run dev`

## Architecture

### Monorepo Structure
- **backend/** - Express API + Socket.io realtime server
- **frontend/** - React SPA
- **database/** - PostgreSQL schema definitions
- **docs/** - ERD and architectural notes

### Backend Architecture

**Entry Point:** `backend/src/server.ts`

The backend is a single-file Express + Socket.io server with:
- REST API endpoints for resources (companies, departments, users, tasks)
- WebSocket connections for realtime features (chat messages, task updates, announcements)
- CORS enabled for frontend communication

**Socket.io Events:**
- `message_sent` - Chat messages (broadcast to others)
- `task_updated` - Task status changes (broadcast to others)
- `announcement_posted` - Company-wide announcements (emit to all)

**API Routes (placeholder implementations):**
- `GET /health` - Health check
- `GET /api/companies` - List companies
- `GET /api/departments` - List departments
- `GET /api/users` - List users
- `GET /api/tasks` - List tasks

### Frontend Architecture

**Entry Point:** `frontend/src/main.tsx`

Minimal React setup using Vite:
- `main.tsx` - React root initialization
- `App.tsx` - Main app component
- TailwindCSS integration is planned but not yet configured

### Database Schema

**Core Entities:** `database/schema.sql`

Multi-tenant design with company isolation:

1. **companies** - Top-level organization
2. **departments** - Hierarchical structure (self-referencing parent_id)
3. **users** - Employee hierarchy (reports_to relationship), role-based (CEO, Manager, Employee)
4. **tasks** - Work items with status tracking (Pending, In Progress, Completed)
5. **messages** - Internal chat system

**Key Relationships:**
- All entities cascade delete from companies (multi-tenant isolation)
- Departments can have parent departments (organizational hierarchy)
- Users report to other users (management hierarchy)
- Tasks link assignees and creators to users
- Indexes on company_id for all tables (performance)

## Project Status

This is an early-stage MVP scaffold:
- ✅ Monorepo structure established
- ✅ Backend server with Socket.io
- ✅ Database schema designed
- ✅ Frontend React scaffold
- ⏳ TailwindCSS not yet configured
- ⏳ Database connection not yet implemented
- ⏳ Authentication not yet implemented
- ⏳ API endpoints return empty arrays (placeholders)

## Important Notes

- Backend uses ES modules (`"type": "module"`)
- TypeScript strict mode enabled
- Socket.io CORS allows all origins (needs restriction for production)
- No database connection yet - API endpoints return mock data
- No authentication/authorization implemented
- Environment variables supported via `.env` (add to root/backend as needed)
