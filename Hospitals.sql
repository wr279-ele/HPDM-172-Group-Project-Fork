CREATE DATABASE IF NOT EXISTS hospitals_db;
USE hospitals_db;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Hospitals;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Lab_Results;
DROP TABLE IF EXISTS Medications;
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Specialists;
DROP TABLE IF EXISTS Diseases;
DROP TABLE IF EXISTS Disease_Medication;


SHOW VARIABLES LIKE 'secure_file_priv';


CREATE TABLE Hospitals(
hospital_id INT PRIMARY KEY,
hospital_name VARCHAR(100),
hospital_address VARCHAR(255),
num_beds INT,
hospital_type VARCHAR(50), 
hospital_accreditation_status VARCHAR(50),
established_date DATE,
emergency_service BOOL,
accreditation_date DATE
);

CREATE TABLE Doctors( 
doctor_id INT PRIMARY KEY,
doctor_name VARCHAR(100),
doctor_dob DATE,
doctor_address VARCHAR(255),
hospital_id INT, 
FOREIGN KEY (hospital_id) REFERENCES Hospitals(hospital_id)
);

CREATE TABLE Patients(
patient_id INT PRIMARY KEY,
patient_name VARCHAR(100),
patient_dob DATE,
patient_address VARCHAR(255),
doctor_id INT,
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Appointments(
appointment_id INT PRIMARY KEY,
patient_id INT, 
doctor_id INT,
hospital_id INT, 
appointment_date DATE, 
appointment_time TIME,
appointment_type VARCHAR(50),
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
FOREIGN KEY (hospital_id) REFERENCES Hospitals(hospital_id)
);

CREATE TABLE Lab_Results (
lab_result_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
hospital_id INT,
test_name VARCHAR(50),
result_value DECIMAL(10,2),
result_unit VARCHAR(50),
result_flag VARCHAR(50),
result_date DATE,
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
FOREIGN KEY (hospital_id) REFERENCES Hospitals(hospital_id)
);

CREATE TABLE Medications (
medication_id INT PRIMARY KEY,
medication_name VARCHAR(50)
);

CREATE TABLE Prescriptions(
prescription_id INT PRIMARY KEY,
patient_id INT,
doctor_id INT,
date_prescribed DATE,
hospital_id INT,
medication_id INT,
FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
FOREIGN KEY (hospital_id) REFERENCES Hospitals(hospital_id),
FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);

CREATE TABLE Specialists (
doctor_id INT,
disease_id INT,
hospital_id INT,
FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
FOREIGN KEY (disease_id) REFERENCES Diseases(disease_id),
FOREIGN KEY (hospital_id) REFERENCES Hospitals(hospital_id)
);

CREATE TABLE Diseases(
disease_id INT PRIMARY KEY, 
disease_name VARCHAR(50)
);

CREATE TABLE Disease_Medication(
medication_id INT,
disease_id INT,
FOREIGN KEY (medication_id) REFERENCES Medications(medication_id),
FOREIGN KEY (disease_id) REFERENCES Diseases(disease_id)
);


LOAD DATA LOCAL INFILE 'Tables/Hospitals.csv'
INTO TABLE Hospitals
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Tables/Doctors.csv'
INTO TABLE Doctors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Tables/Patients.csv'
INTO TABLE Patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Tables/Appointments.csv'
INTO TABLE Appointments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Tables/Lab_Results.csv'
INTO TABLE Lab_Results
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Tables/Medications.csv'
INTO TABLE Medications
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Tables/Prescriptions.csv'
INTO TABLE Prescriptions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Tables/Diseases.csv'
INTO TABLE Diseases
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Tables/Specialist.csv'
INTO TABLE Specialists
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Tables/Disease_Medication.csv'
INTO TABLE Disease_Medication
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SHOW TABLES;






