-- Students table
CREATE TABLE IF NOT EXISTS students (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mobile_number TEXT UNIQUE NOT NULL,
  full_name TEXT,
  father_name TEXT,
  address TEXT,
  admission_date TEXT,
  user_name TEXT,
  password TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Seat bookings table
CREATE TABLE IF NOT EXISTS bookings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  seat_number INTEGER NOT NULL,
  shift_number INTEGER NOT NULL,
  mobile_number TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(seat_number, shift_number),
  FOREIGN KEY (mobile_number) REFERENCES students(mobile_number) ON DELETE CASCADE
);

-- Payment records table
CREATE TABLE IF NOT EXISTS payments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mobile_number TEXT NOT NULL,
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  required_amount INTEGER NOT NULL,
  paid_amount INTEGER NOT NULL,
  payment_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(mobile_number, year, month),
  FOREIGN KEY (mobile_number) REFERENCES students(mobile_number) ON DELETE CASCADE
);

-- Attendance records table
CREATE TABLE IF NOT EXISTS attendance (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mobile_number TEXT NOT NULL,
  date TEXT NOT NULL,
  in_time TEXT,
  out_time TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (mobile_number) REFERENCES students(mobile_number) ON DELETE CASCADE
);

-- WOW records (seat allocation info)
CREATE TABLE IF NOT EXISTS wow_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mobile_number TEXT UNIQUE NOT NULL,
  seat_no TEXT DEFAULT '',
  custom_rate INTEGER DEFAULT 0,
  fixed_total_payment INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (mobile_number) REFERENCES students(mobile_number) ON DELETE CASCADE
);

-- Library settings table
CREATE TABLE IF NOT EXISTS settings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  key TEXT UNIQUE NOT NULL,
  value TEXT NOT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- System configuration
CREATE TABLE IF NOT EXISTS config (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  total_seats INTEGER DEFAULT 50,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert default config
INSERT OR IGNORE INTO config (id, total_seats) VALUES (1, 50);

-- Insert default library location (not set initially)
INSERT OR IGNORE INTO settings (key, value) VALUES ('library_lat', '25.6127');
INSERT OR IGNORE INTO settings (key, value) VALUES ('library_lng', '85.1589');
INSERT OR IGNORE INTO settings (key, value) VALUES ('library_range', '20');
INSERT OR IGNORE INTO settings (key, value) VALUES ('library_location_set', 'false');

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_students_mobile ON students(mobile_number);
CREATE INDEX IF NOT EXISTS idx_bookings_mobile ON bookings(mobile_number);
CREATE INDEX IF NOT EXISTS idx_bookings_seat_shift ON bookings(seat_number, shift_number);
CREATE INDEX IF NOT EXISTS idx_payments_mobile ON payments(mobile_number);
CREATE INDEX IF NOT EXISTS idx_payments_year_month ON payments(year, month);
CREATE INDEX IF NOT EXISTS idx_attendance_mobile ON attendance(mobile_number);
CREATE INDEX IF NOT EXISTS idx_attendance_date ON attendance(date);
CREATE INDEX IF NOT EXISTS idx_wow_mobile ON wow_records(mobile_number);
