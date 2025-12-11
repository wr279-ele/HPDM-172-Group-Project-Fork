# HPDM172 Hospital Database Project

This repository contains the group project for the HPDM172 – Computational Skills for Health and Life Sciences module.  
The aim is to design, build, and query a realistic hospital information system database using MySQL.  
The system includes hospitals, doctors, patients, prescriptions, diseases, medications, appointments, specialists, and lab results.

The project includes:
- Entity Relationship Diagrams (ERDs)
- SQL table creation scripts
- Synthetic data generation
- Required SQL queries (1–19)
- Additional single-query files
- A teamwork portfolio

---

# Database Structure

The project directory is organised as follows:

```
HPDM-172-Group-Project--main/
│
├── Hospitals.sql              ← Full database build script (tables + CSV loading)
├── 172_Queries.sql            ← Queries 1–19
├── queries/                   ← Additional standalone queries
└── Tables/                    ← All .csv data files
      ├── Hospitals.csv
      ├── Doctors.csv
      ├── Patients.csv
      ├── Appointments.csv
      ├── Lab_Results.csv
      ├── Medications.csv
      ├── Prescriptions.csv
      ├── Diseases.csv
      ├── Specialist.csv
      └── Disease_Medication.csv
```

---

# CSV Data Dictionary

Below are the attributes of each CSV file used in this project.

---

## Hospitals.csv
- hospital_id — Unique ID for the hospital (Primary key)
- hospital_name — Name of the hospital
- hospital_address — Full address
- num_beds — Number of beds
- hospital_type — General / Teaching / Specialist
- hospital_accreditation_status — Accreditation status
- established_date — Date hospital was established
- emergency_service — Boolean (0/1)
- accreditation_date — Date accreditation was granted

---

## Doctors.csv
- doctor_id — Unique doctor ID (Primary key)
- doctor_name — Full name
- doctor_dob — Date of birth
- doctor_address — Address
- hospital_id — Hospital the doctor works at (Foreign key referencing Hospitals.hospital_id)

---

## Patients.csv
- patient_id — Unique patient ID (Primary key)
- patient_name — Full name
- patient_dob — Date of birth
- patient_address — Address
- doctor_id — Assigned primary doctor (Foreign key referencing Doctors.doctor_id)

---

## Medications.csv
- medication_id — Unique ID for medication (Primary key)
- medication_name — Name of the medication

---

## Prescriptions.csv
- prescription_id — Unique ID (Primary key)
- patient_id — Patient receiving medication (Foreign key → Patients.patient_id)
- doctor_id — Prescribing doctor (Foreign key → Doctors.doctor_id)
- date_prescribed — Date the prescription was issued
- hospital_id — Hospital where prescription occurred (Foreign key → Hospitals.hospital_id)
- medication_id — Medication prescribed (Foreign key → Medications.medication_id)

---

## Diseases.csv
- disease_id — Unique disease ID (Primary key)
- disease_name — Name of disease

---

## Disease_Medication.csv
- disease_id — Foreign key referencing Diseases.disease_id
- medication_id — Foreign key referencing Medications.medication_id

---

## Specialist.csv
- doctor_id — Foreign key referencing Doctors.doctor_id
- disease_id — Foreign key referencing Diseases.disease_id
- hospital_id — Hospital where the specialist practices  
  (This field required updating in SQL table definition and is now correctly supported.)

---

## Appointments.csv
- appointment_id — Unique ID (Primary key)
- patient_id — Patient attending (Foreign key → Patients.patient_id)
- doctor_id — Doctor conducting the appointment (Foreign key → Doctors.doctor_id)
- hospital_id — Hospital where appointment occurs (Foreign key → Hospitals.hospital_id)
- appointment_date — Date
- appointment_time — Time
- appointment_type — Type such as Checkup, Follow-up, Surgery

---

## Lab_Results.csv
- lab_result_id — Unique ID (Primary key)
- patient_id — Patient tested (Foreign key → Patients.patient_id)
- doctor_id — Ordering doctor (Foreign key → Doctors.doctor_id)
- hospital_id — Hospital where the test occurred (Foreign key → Hospitals.hospital_id)
- test_name — Name of test
- result_value — Numeric result value
- result_unit — Unit of measurement
- result_flag — Interpretation (Normal, High, Low)
- result_date — Date of the result

---

# How to Use

## 1. Navigate to the project folder

```bash
cd /path/to/HPDM-172-Group-Project--main
```

---

## 2. Start MySQL with file loading enabled

```bash
mysql --local-infile=1 -u root -p
```

Inside MySQL:

```sql
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
```

This ensures both client and server allow CSV loading.

---

## 3. Build the database and load all CSV files

Inside MySQL:

```sql
SOURCE Hospitals.sql;
```

This script will:
- Create the database `hospitals_db`
- Switch into it
- Create all tables
- Load all CSV data

Verify successful loading:

```sql
SHOW TABLES;
SELECT COUNT(*) FROM Hospitals;
SELECT COUNT(*) FROM Patients;
```

If counts show 0 rows, CSV loading did not occur correctly.

---

# Running Queries

To run queries 1–19:

```sql
USE hospitals_db;
SOURCE 172_Queries.sql;
```

To run an individual query:

```sql
SOURCE queries/<filename>.sql;
```

---

# Summary of Required Queries (1–19)

1. Doctors working at a specific hospital  
2. All prescriptions for a particular patient  
3. Prescriptions written by a particular doctor  
4. Prescriptions sorted alphabetically by patient name  
5. Add a new patient and assign them a doctor  
6. Update a patient’s address  
7. Patients registered to doctors at a specific hospital  
8. Doctors at teaching hospitals accredited between 2015 and 2024  
9. Patients who may have a disease based on medication  
10. Doctors specialising in a specific disease  
11. Lab results for patients over age 60  
12. All appointments for a given patient  
13. All appointments for a given doctor  
14. Prescriptions from a specific hospital  
15. Lab results from hospitals accredited between 2013 and 2020  
16. Doctor with the most prescriptions  
17. Doctors at the hospital with the most beds  
18. Hospitals accredited before 2015 that have emergency services  
19. Patients registered with doctors at hospitals with fewer than 400 beds  

---

# Additional Queries

Provided in the `queries/` folder:

- query_appointments_by_patient.sql  
- query_labresults_by_patient.sql  
- query_doctor_appointments_at_hospital.sql  
- query_all_medications.sql  

---

# Exporting the Final Database

Exit MySQL:

```sql
EXIT;
```

Export using mysqldump:

```bash
mysqldump -u root -p hospitals_db > final_export.sql
```

---

# End of README
