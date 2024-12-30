Portfolio Project SQL Queries

USE portfolio_project;

-- 1. Finding the Details of the Doctor who Treated 'Diabetes' --
SELECT 
    d.Doctor_ID,
    d.d_Worker_ID,
    fname,
    lname,
    Illness,
    Patient_ID
FROM
    doctor d,
    worker w,
    diagnosis di
WHERE
    d.d_Worker_id = w.Worker_id
        AND d.doctor_id = di.doctor_id
        AND illness = 'diabetes';
-- ANS: 51235, 123456, Tilda, White, Diabetes, 193258 --

-- 2. Details of Patients Who Have Been Prescribed 'B205' --
SELECT 
    p.Patient_ID,
    fname,
    lname,
    telephone,
    Gender,
    Age,
    Blood_Type,
    Prescription_ID,
    m.Medication_ID,
    Doses,
    Expiration_Date
FROM
    patient AS p,
    medication_p AS mp,
    medication m
WHERE
    p.patient_id = mp.Patient_id
        AND m.medication_id = 'B205'
        AND mp.medication_id = m.medication_id;
-- ANS: 975913, Harry, Sax, (643)764-1256, M, 21, O-, 102, B205, 5, 2026-09-20 --

-- 3. Total Number of Doctors in Each Department --
SELECT 
    d.Department_ID, COUNT(doctor_id)
FROM
    department d,
    doctor doc
WHERE
    d.department_id = doc.department_id
GROUP BY 1;
-- Ans: 1, 2, 1, 1, 1 --

-- 4. Names and Phone Numbers of All Patients with 'Diabetes' --
SELECT 
    fname, lname, telephone, illness
FROM
    patient p,
    diagnosis d
WHERE
    p.patient_id = d.patient_id
        AND illness = 'diabetes';
-- ANS: Jenny, Tayla, (642)176-7421, Diabetes --

-- 5. Names and IDs of Doctors Who Work in the ER Department --
SELECT 
    Doctor_ID, CONCAT(fname, ' ', lname) AS Full_Name
FROM
    doctor d,
    worker w
WHERE
    d.D_Worker_ID = w.Worker_ID
        AND department_id = 'er';

-- 6. Total Salary Expenditure --
SELECT 
    SUM(salary) AS Total_Salary_Expenditure
FROM
    worker;

-- 7. Cafeteria Staff with Job Position and Food Type --
SELECT 
    s.Staff_ID, s.job_title, Position, Food_Type
FROM
    cafeteria c,
    cafeteria_staff cs,
    staff s
WHERE
    c.cafeteria_id = cs.cafeteria_id
        AND s.staff_id = cs.staff_id;

-- 8. Average Age of Patients Diagnosed with the 'Flu' --
SELECT 
    *, AVG(age) AS Average_Age
FROM
    diagnosis d,
    patient p
WHERE
    d.patient_id = p.patient_id
        AND illness = 'flu';
 








 
