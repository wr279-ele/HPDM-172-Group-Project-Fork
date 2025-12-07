-- Query: List all medications
-- Purpose: Retrieve a clean alphabetical list of all medications in the database.

SELECT *
FROM Medications
ORDER BY medication_name ASC;
