# HPDM172 Hospital Database Project

This repository contains the group project for the **HPDM172 – Computational Skills for Health and Life Sciences** module.  
The aim of this project is to design, build, and query a realistic **hospital information system database** using MySQL.  
The system includes hospitals, doctors, patients, prescriptions, diseases, medications, appointments, and lab results.

The project includes:
- Entity Relationship Diagrams (ERDs)
- SQL table creation scripts
- Synthetic data generation
- Required SQL queries (1–19)
- A teamwork portfolio

---

# 🏥 Database Overview

The database models a complete hospital information management system with the following core tables:

### **Hospitals**
- hospital_id (PK)
- name
- address
- size (number of beds)
- type
- accreditation_year
- emergency_service (Y/N)

### **Doctors**
- doctor_id (PK)
- name
- date_of_birth
- address
- hospital_id (FK → Hospitals)
- speciality

### **Patients**
- patient_id (PK)
- name
- date_of_birth
- address
- doctor_id (FK → Doctors)

### **Medications**
- medication_id (PK)
- medication_name


### **Prescriptions**
- prescription_id (PK)
- doctor_id (FK)
- patient_id (FK)
- medication_id (FK)
- prescription_date

### **Diseases**
- disease_id (PK)
- disease_name
- medication_id (FK → Medications)
- specialist_doctor_id (FK → Doctors)

### **Appointments**
- appointment_id (PK)
- patient_id (FK → Patients)
- doctor_id (FK → Doctors)
- hospital_id (FK → Hospitals)
- appointment_date
- appointment_time
- appointment_type
n

### **LabResults**
- lab_result_id (PK)
- patient_id (FK → Patients)
- doctor_id (FK → Doctors)
- hospital_id (FK → Hospitals)
- test_name
- result_value
- result_unit
- result_flag
- result_date


---

# 🧪 SQL Queries & Their Purpose

Each SQL file in the `/queries` folder corresponds to a required task.

### Query 1 — Doctors working at a specific hospital
Lists all doctors assigned to a chosen hospital.

### Query 2 — All prescriptions for a particular patient
Shows all prescriptions ordered by most recent.

### Query 3 — All prescriptions prescribed by a particular doctor
Displays all prescriptions written by a specific doctor.

### Query 4 — All prescriptions ordered alphabetically by patient name
Outputs an alphabetically sorted prescription list.

### Query 5 — Add a new patient & register them with a doctor
Demonstrates INSERT commands with foreign keys.

### Query 6 — Modify an existing patient’s address
Updates the address of a selected patient.

### Query 7 — Patients registered to doctors at a particular hospital
Used for administrative or mailing list purposes.

### Query 8 — Doctors at teaching hospitals accredited 2015–2024
Filters by hospital type and accreditation year.

### Query 9 — Patients who may have a particular disease
Identifies patients based on medications linked to diseases.

### Query 10 — Doctors specialising in a specific disease
Finds specialists based on disease mappings.

### Query 11 — Lab results for all patients over age 60
Uses joins and age filtering.

### Query 12 — All appointments for a given patient
Retrieves appointment history.

### Query 13 — All appointments for a given doctor
Shows all appointments for one doctor.

### Query 14 — Prescriptions from a specific hospital
Outputs:
- medication name  
- doctor name  
- patient name  
- hospital name  

### Query 15 — Lab results from hospitals accredited 2013–2020
Filters lab results using accreditation criteria.

### Query 16 — Doctor with the most prescriptions
Uses COUNT and GROUP BY.

### Query 17 — Doctors at the largest hospital
Finds doctors working at the hospital with the most beds.

### Query 18 — Hospitals accredited before 2015 with emergency services
Filters by accreditation year and emergency availability.

### Query 19 — Patients registered with doctors at hospitals < 400 beds
Uses multi-table join filtering.

---
## 💾 Additional Queries Implemented for This Project

The following SQL files are included in the `/queries` folder and work with the  
Appointments, LabResults, and Medications tables:

- `query_appointments_by_patient.sql`  
  Returns all appointments for a specific patient, ordered by date and time.

- `query_labresults_by_patient.sql`  
  Returns all lab test results for a specific patient, newest test first.

- `query_doctor_appointments_at_hospital.sql`  
  Lists all appointments for a specific doctor at a chosen hospital.

- `query_all_medications.sql`  
  Lists all medications from the Medications table in alphabetical order.


```md
# ▶️ How to Use the Files

### **STEP 1 — Create the Database**

Open MySQL and create the main project database:

CREATE DATABASE hospital_db;
USE hospital_db;

---

### **STEP 2 — Create the Tables**

Run all required CREATE TABLE statements for your tables  
(Hospitals, Doctors, Patients, Appointments, LabResults, Medications, etc.)

These definitions are included in the project documentation.

---

### **STEP 3 — Import the CSV Data (First-Time Setup Only)**

Use LOAD DATA LOCAL INFILE to load each dataset.

-- Import Appointments  
LOAD DATA LOCAL INFILE 'C:/mysql_data/Appointments.csv'  
INTO TABLE Appointments  
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS  
(appointment_id, patient_id, doctor_id, hospital_id, @date, @time, appointment_type)  
SET appointment_date = STR_TO_DATE(@date, '%d/%m/%Y'),  
    appointment_time = STR_TO_DATE(@time, '%H:%i');

-- Import Lab Results  
LOAD DATA LOCAL INFILE 'C:/mysql_data/Lab_Results.csv'  
INTO TABLE LabResults  
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS  
(lab_result_id, patient_id, doctor_id, hospital_id, test_name, @value, result_unit, result_flag, @date)  
SET result_value = CAST(@value AS DECIMAL(10,2)),  
    result_date = STR_TO_DATE(@date, '%d/%m/%Y');

-- Import Medications  
LOAD DATA LOCAL INFILE 'C:/mysql_data/Medications.csv'  
INTO TABLE Medications  
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS  
(@dummy, medication_id, @raw_name)  
SET medication_name = TRIM(@raw_name);

> Note: Only run these commands once on an empty database.  
> Running them again will skip rows if primary keys already exist.

---

### **STEP 4 — Run SQL Queries from the /queries folder**

Example:

mysql -u root -p hospital_db < queries/query_appointments_by_patient.sql

---

### **STEP 5 — Export the Final Database**

Use mysqldump to generate the final project export file:

mysqldump -u root -p hospital_db > database/hospital_db_export.sql
```


