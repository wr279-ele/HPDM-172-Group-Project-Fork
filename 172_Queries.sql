1--Adding a new patient and registering them to a doctor 

INSERT into Patients (patient_id, patient_name, patient_dob, patient_address, doctor_id) VALUES  
                     ( 601, 'Anna,Marie', '1998/12/08', '29 fore street, Exeter, EX1 38', 23) ;

2---Modifying address details for an existing customer

       UPDATE Patients   
       SET patient_address = '29 Bonhay  Road, Exeter, EX53 26'  WHERE patient_id=1;

3 ---List of the patients and their address  registered to Oxford District Hospital 

      SELECT  pt.patient_name, pt.patient_address, pt.doctor_id, H.hospital_name
      From Patients as pt 
      JOIN Doctors as D on pt.doctor_id = D.doctor_id
      JOIN  Hospitals as H on D.hospital_id = H.hospital_id
      WHERE hospital_name= 'Oxford District Hospital';

4 ---List of doctors at teaching hospitals, with accreditation between 2015 and 2024

     SELECT D.doctor_name, H.hospital_name, H.hospital_accreditation_status, H.accreditation_date
     FROM Doctors as D
     JOIN Hospitals as H on D.hospital_id=H.hospital_id
     WHERE hospital_type='Teaching' and accreditation_date BETWEEN '2015-01-01' and '2024-12-31' ;

—  5--Listing patients with a particular disease based on their prescribed medication
       SELECT P.patient_id, D.disease_name, MD.medication_name
       FROM Prescriptions as P
       JOIN Medications as MD on P.medication_id=MD.medication_id
       JOIN Disease_Medication as M on MD.medication_id = M.medication_id
       JOIN Diseases as D on M.disease_id=D.disease_id
       WHERE medication_name IN ('Amlodipine', 'Losartan');


6--List of doctors and the disease they specialise in
      SELECT S.doctor_id, Do.doctor_name, D.disease_name
      FROM   Specialists as S
      JOIN Diseases as D on S.disease_id = D.disease_id
      JOIN Doctors as Do on S.doctor_id = Do.doctor_id ;

7--List of lab results for patients over 60 years old

     SELECT L.patient_id, TIMESTAMPDIFF(YEAR, patient_dob, CURDATE()) as Age, L.test_name, L.result_value, L.result_flag
     FROM   Lab_Results as L 
     JOIN   Patients as P on L.patient_id = P.patient_id
     WHERE  TIMESTAMPDIFF(YEAR, patient_dob, CURDATE()) >= 60;

— 8. --List of appointments for patient_id(172)
     SELECT *
     FROM Appointments
     WHERE patient_id= 172;

— 9. --List of appointments for doctor_id(50)
     SELECT *
     FROM Appointments
     WHERE doctor_id= 50;

— 10.  --List of medications from Exeter District Hospital, arranged in alphabetical order 
         With EDH as (
                      Select  patient_id, patient_name, hospital_name,  doctor_name
                      from    Patients as P
                      join Doctors as D on P.doctor_id = D.doctor_id
                      join Hospitals as H on D.hospital_id = H.hospital_id
 )
Select E.doctor_name, E.patient_name, M.medication_name, E.hospital_name
from EDH as E
join Prescriptions as Pr on E.patient_id = Pr.patient_id
join Medications as M on Pr.medication_id = M.medication_id
where hospital_name = 'Exeter District Hospital'
Order by medication_name;

— 11.   --List of lab results from all hospitals that were accredited between 2013 and 2020

        SELECT  H.hospital_name, LR.test_name, LR.result_value, LR.result_flag, H.accreditation_date
        FROM Lab_Results as LR
        JOIN Hospitals as H on LR.hospital_id=H.hospital_id
        WHERE  accreditation_date BETWEEN '2013-01-01' AND '2020-12-31' ;

— 12.  --The doctor with the most Prescriptions
           SELECT Pr.doctor_id, D.doctor_name, count(prescription_id) as Total_Prescription_count
           FROM Prescriptions as Pr
           JOIN Doctors as D on Pr.doctor_id = D.doctor_id
           GROUP BY doctor_id
           ORDER BY count(prescription_id)DESC
           LIMIT 1;

—13. --List of Doctors at the hospital with the most number of beds
        SELECT   D.doctor_id, D.doctor_name, H1.hospital_name, H1.num_beds
        FROM     ( SELECT  hospital_id FROM Hospitals
                 ORDER BY num_beds DESC
                 LIMIT 1) as H
        JOIN     Doctors as D on H.hospital_id = D.hospital_id
        JOIN    Hospitals as H1 on H.hospital_id = H1.hospital_id;

— 14  --List of hospitals accredited prior to 2015 with emergency  service facilities
         SELECT hospital_name, accreditation_date
         FROM   Hospitals
         WHERE  accreditation_date BETWEEN '0001-01-01' AND '2015-01-01' AND emergency_service=1 ;

— 15.  -- List of patients registered with doctors in hospitals with <400beds
          SELECT DISTINCT A.patient_id, A.doctor_id, H.hospital_name, H.num_beds
          FROM Hospitals as H
          JOIN Appointments as A on H.hospital_id = A.hospital_id
          WHERE num_beds < 400;