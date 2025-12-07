-- Query: All appointments for a given doctor at a given hospital
-- Purpose: View a doctor’s schedule limited to one hospital location.

SELECT *
FROM Appointments
WHERE doctor_id = 3
  AND hospital_id = 1
ORDER BY appointment_date, appointment_time;
