-- PostgreSQL schema for Virtual Corporate Workspace MVP

CREATE TABLE companies (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  description TEXT
);

CREATE TABLE departments (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  parent_id INT REFERENCES departments(id) ON DELETE SET NULL,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('CEO','Manager','Employee')),
  reports_to INT REFERENCES users(id) ON DELETE SET NULL,
  department_id INT REFERENCES departments(id) ON DELETE SET NULL,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE
);

CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  assignee_id INT REFERENCES users(id) ON DELETE SET NULL,
  creator_id INT REFERENCES users(id) ON DELETE SET NULL,
  status TEXT NOT NULL DEFAULT 'Pending' CHECK (status IN ('Pending','In Progress','Completed')),
  deadline TIMESTAMP WITH TIME ZONE,
  department_id INT REFERENCES departments(id) ON DELETE SET NULL,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  sender_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  receiver_id INT REFERENCES users(id) ON DELETE SET NULL,
  content TEXT NOT NULL,
  timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  department_id INT REFERENCES departments(id) ON DELETE SET NULL,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE
);

CREATE INDEX idx_departments_company ON departments(company_id);
CREATE INDEX idx_users_company ON users(company_id);
CREATE INDEX idx_tasks_company ON tasks(company_id);
CREATE INDEX idx_messages_company ON messages(company_id);
