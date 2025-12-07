-- Query: All lab results for a specific patient
-- Purpose: Retrieve all laboratory test results for the patient, newest first.

SELECT *
FROM LabResults
WHERE patient_id = 10
ORDER BY result_date DESC;
