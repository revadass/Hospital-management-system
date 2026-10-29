-- CarePoint Hospital Management System - MySQL schema
CREATE DATABASE IF NOT EXISTS carepoint_hospital;
USE carepoint_hospital;

CREATE TABLE IF NOT EXISTS patients (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  age INT NOT NULL,
  gender VARCHAR(20),
  phone VARCHAR(20),
  diagnosis VARCHAR(150),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS doctors (
  doctor_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  specialization VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  consultation_fee DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

CREATE TABLE IF NOT EXISTS appointments (
  appointment_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_date DATE NOT NULL,
  appointment_time TIME,
  status ENUM('Scheduled','Completed','Cancelled') NOT NULL DEFAULT 'Scheduled',
  notes VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE IF NOT EXISTS bills (
  bill_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  appointment_id INT NULL,
  consultation_charge DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  other_charges DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  total_amount DECIMAL(10,2) GENERATED ALWAYS AS (consultation_charge + other_charges) STORED,
  payment_status ENUM('Paid','Unpaid','Partial') NOT NULL DEFAULT 'Unpaid',
  bill_date DATE NOT NULL DEFAULT (CURRENT_DATE),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Demo records (optional)
INSERT INTO patients (full_name, age, gender, phone, diagnosis) VALUES
('Aarav Sharma', 28, 'Male', '9000000001', 'Fever'),
('Meera Singh', 35, 'Female', '9000000002', 'Migraine');

INSERT INTO doctors (full_name, specialization, phone, consultation_fee) VALUES
('Dr. Ananya Kapoor', 'General Physician', '9000000011', 500.00),
('Dr. Rohan Mehta', 'Cardiologist', '9000000012', 800.00);
