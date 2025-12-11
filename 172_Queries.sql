-- 1. Adding a new patient and registering them to a doctor
INSERT INTO Patients (patient_id, patient_name, patient_dob, patient_address, doctor_id) VALUES
(601, 'Anna,Marie', '1998/12/08', '29 fore street, Exeter, EX1 38', 23);


-- 2. Modifying address details for an existing customer
UPDATE Patients
SET patient_address = '29 Bonhay Road, Exeter, EX53 26'
WHERE patient_id = 1;


-- 3. List of the patients and their address registered to Oxford District Hospital
SELECT P.patient_id, P.patient_name, P.patient_address, H.hospital_name
FROM Patients AS P
JOIN Doctors AS D ON P.doctor_id = D.doctor_id
JOIN Hospitals AS H ON D.hospital_id = H.hospital_id
WHERE hospital_name = 'Oxford District Hospital'
ORDER BY patient_name;


-- 4. Retrieve the list of patients who visited the hospital on a specific date (2023-01-07)
SELECT P.patient_id, P.patient_name, A.appointment_date
FROM Patients AS P
JOIN Appointments AS A ON P.patient_id = A.patient_id
WHERE appointment_date = '2023-01-07'
ORDER BY patient_name;


-- 5. Listing patients with a particular disease based on their prescribed medication
SELECT DISTINCT P.patient_id, P.patient_name, D.disease_name
FROM Patients AS P
JOIN Prescriptions AS S ON P.patient_id = S.patient_id
JOIN Disease_Medication AS DM ON S.medication_id = DM.medication_id
JOIN Diseases AS D ON DM.disease_id = D.disease_id
ORDER BY disease_name;


-- 6. Retrieve the number of appointments made by each patient
SELECT P.patient_id, P.patient_name, COUNT(A.appointment_id) AS total_appointments
FROM Patients AS P
JOIN Appointments AS A ON P.patient_id = A.patient_id
GROUP BY P.patient_id, P.patient_name
ORDER BY total_appointments DESC;


-- 7. List all doctors who work in hospitals with more than 300 beds
SELECT D.doctor_id, D.doctor_name, H.hospital_name, H.num_beds
FROM Doctors AS D
JOIN Hospitals AS H ON D.hospital_id = H.hospital_id
WHERE H.num_beds > 300
ORDER BY doctor_name;


-- 8. List of appointments for patient_id = 172
SELECT A.appointment_id, A.appointment_date, A.appointment_time, D.doctor_name
FROM Appointments AS A
JOIN Doctors AS D ON A.doctor_id = D.doctor_id
WHERE patient_id = 172
ORDER BY appointment_date, appointment_time;


-- 9. Listing doctors with a particular specialist qualification
SELECT DISTINCT D.doctor_id, D.doctor_name, DI.disease_name
FROM Doctors AS D
JOIN Specialists AS S ON D.doctor_id = S.doctor_id
JOIN Diseases AS DI ON S.disease_id = DI.disease_id
ORDER BY doctor_name;


-- 10. Retrieve all lab results of a patient (patient_id = 300)
SELECT L.lab_result_id, L.test_name, L.result_value, L.result_unit, L.result_flag, L.result_date
FROM Lab_Results AS L
WHERE patient_id = 300
ORDER BY result_date DESC;


-- 11. Retrieve all prescriptions made by doctor_id = 47
SELECT P.prescription_id, P.patient_id, M.medication_name, P.date_prescribed
FROM Prescriptions AS P
JOIN Medications AS M ON P.medication_id = M.medication_id
WHERE doctor_id = 47
ORDER BY date_prescribed DESC;


-- 12. Retrieve the number of patients assigned to each doctor
SELECT D.doctor_id, D.doctor_name, COUNT(P.patient_id) AS total_patients
FROM Doctors AS D
LEFT JOIN Patients AS P ON D.doctor_id = P.doctor_id
GROUP BY D.doctor_id, D.doctor_name
ORDER BY total_patients DESC;


-- 13. Retrieve appointments occurring at Taunton Community Hospital
SELECT A.appointment_id, A.appointment_date, A.appointment_time, P.patient_name
FROM Appointments AS A
JOIN Patients AS P ON A.patient_id = P.patient_id
JOIN Hospitals AS H ON A.hospital_id = H.hospital_id
WHERE H.hospital_name = 'Taunton Community Hospital'
ORDER BY appointment_date;


-- 14. Retrieve the list of diseases treated at Exeter Central Hospital
SELECT DISTINCT DI.disease_name
FROM Diseases AS DI
JOIN Disease_Medication AS DM ON DI.disease_id = DM.disease_id
JOIN Medications AS M ON DM.medication_id = M.medication_id
JOIN Prescriptions AS P ON M.medication_id = P.medication_id
JOIN Hospitals AS H ON P.hospital_id = H.hospital_id
WHERE H.hospital_name = 'Exeter Central Hospital'
ORDER BY disease_name;


-- 15. Retrieve all patients whose address contains 'London'
SELECT patient_id, patient_name, patient_address
FROM Patients
WHERE patient_address LIKE '%London%'
ORDER BY patient_name;


-- 16. List of all doctors at Taunton Community Hospital
SELECT D.doctor_id, D.doctor_name
FROM Doctors AS D
JOIN Hospitals AS H ON D.hospital_id = H.hospital_id
WHERE H.hospital_name = 'Taunton Community Hospital'
ORDER BY doctor_name;


-- 17. List of all prescriptions for patient_id = 30, ordered by prescription_date
SELECT P.prescription_id, M.medication_name, P.date_prescribed
FROM Prescriptions AS P
JOIN Medications AS M ON P.medication_id = M.medication_id
WHERE patient_id = 30
ORDER BY date_prescribed DESC;


-- 18. List of all prescriptions made by doctor_id = 47
SELECT P.prescription_id, P.patient_id, M.medication_name, P.date_prescribed
FROM Prescriptions AS P
JOIN Medications AS M ON P.medication_id = M.medication_id
WHERE doctor_id = 47
ORDER BY date_prescribed DESC;


-- 19. List of prescriptions ordered by patient_id = 200
SELECT P.patient_id, P.prescription_id, M.medication_name
FROM Prescriptions AS P
JOIN Medications AS M ON P.medication_id = M.medication_id
WHERE patient_id = 200
ORDER BY medication_name;
