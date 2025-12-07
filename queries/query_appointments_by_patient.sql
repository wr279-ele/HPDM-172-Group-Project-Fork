-- Query: All appointments for a specific patient
-- Purpose: Retrieve all appointments for one patient in chronological order.

SELECT *
FROM Appointments
WHERE patient_id = 10
ORDER BY appointment_date, appointment_time;
