import express from 'express';
import http from 'http';
import cors from 'cors';
import { Server as SocketIOServer } from 'socket.io';

const app = express();
app.use(cors());
app.use(express.json());

// Health check
app.get('/health', (_req, res) => {
  res.json({ status: 'ok' });
});

// Placeholder routes
app.get('/api/companies', (_req, res) => res.json([]));
app.get('/api/departments', (_req, res) => res.json([]));
app.get('/api/users', (_req, res) => res.json([]));
app.get('/api/tasks', (_req, res) => res.json([]));

const server = http.createServer(app);
const io = new SocketIOServer(server, { cors: { origin: '*' } });

io.on('connection', (socket) => {
  console.log('Client connected', socket.id);

  socket.on('message_sent', (payload) => {
    socket.broadcast.emit('message_sent', payload);
  });

  socket.on('task_updated', (payload) => {
    socket.broadcast.emit('task_updated', payload);
  });

  socket.on('announcement_posted', (payload) => {
    io.emit('announcement_posted', payload);
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected', socket.id);
  });
});

const PORT = process.env.PORT || 4000;
server.listen(PORT, () => {
  console.log(`Backend running on http://localhost:${PORT}`);
});
