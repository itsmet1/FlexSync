# Virtual Corporate Workspace — MVP

Goal: Build a standalone virtual corporate office platform supporting multi-company workspaces, hierarchy, internal chat, task management, and dashboards.

Tech stack
- Backend: Node.js + Express + Socket.io (TypeScript)
- DB: PostgreSQL
- Frontend: React (Vite) + TailwindCSS (to be configured)
- Monorepo: workspaces for backend and frontend

Structure
- backend/ — API, auth, realtime (Socket.io)
- frontend/ — React app
- database/ — schema and migrations
- docs/ — ERD and notes

Getting started (later)
- Install Node.js (LTS)
- From root: run npm install in each workspace after package details are finalized
- Backend: npm run dev (after installing deps)
- Frontend: npm run dev (after installing deps)
