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
- type (e.g., Teaching, General)
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
- name

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
- doctor_id (FK)
- patient_id (FK)
- appointment_date
- appointment_reason

### **LabResults**
- labresult_id (PK)
- doctor_id (FK)
- patient_id (FK)
- test_type
- result_value
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

# ▶️ How to Use the Files

```bash
STEP 1 — CREATE THE DATABASE
Run the following command to create all tables and relationships using schema.sql:
    mysql -u root -p < database/schema.sql


STEP 2 — INSERT SYNTHETIC DATA
Populate all tables with the generated dataset:
    mysql -u root -p < database/insert_data.sql


STEP 3 — RUN ANY QUERY
Execute any SQL query from the /queries/ folder, for example:
    mysql -u root -p < queries/query1_doctors_by_hospital.sql


STEP 4 — EXPORT THE FINAL DATABASE (REQUIRED FOR SUBMISSION)
Create a final MySQL dump file of the completed database:
    mysqldump -u root -p hospital_db > database/exported_db.sql
```
