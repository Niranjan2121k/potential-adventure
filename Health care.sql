Portfolio Project: Hospital Database Analysis

Project Objective

The objective of this project is to analyze hospital data using SQL queries to extract meaningful insights about patient care, staff operations, and resource allocation. The analysis aids in improving healthcare delivery, optimizing departmental efficiency, and understanding patient demographics.

Dataset Overview

The project involves the following datasets with key columns:
	1.	doctor: Contains doctor details such as doctor_id, d_worker_id, and department information.
	2.	worker: Includes worker details like worker_id, fname, lname, and salary.
	3.	diagnosis: Tracks patient diagnoses with columns such as illness, doctor_id, and patient_id.
	4.	patient: Records patient details, including patient_id, fname, lname, telephone, age, and blood_type.
	5.	medication: Provides medication details such as medication_id, expiration_date, and doses.
	6.	medication_p: Links medications to patients via patient_id and medication_id.
	7.	department: Stores departmental information like department_id and associated doctors.
	8.	cafeteria, cafeteria_staff, staff: Track cafeteria operations, staff details, and job roles.

Analysis Breakdown

1. Doctor Treating Diabetes
	•	Objective: Identify the doctor who treated patients diagnosed with diabetes.
	•	Key Steps:
	•	Joined the doctor, worker, and diagnosis tables using common IDs.
	•	Filtered for rows where the illness is ‘diabetes’.
	•	Insight: Identifies specific doctors for targeted performance evaluation or training.

2. Patients Prescribed Specific Medication
	•	Objective: Retrieve details of patients prescribed medication ID ‘B205’.
	•	Key Steps:
	•	Joined patient, medication_p, and medication tables.
	•	Filtered for medication ID ‘B205’.
	•	Impact: Enables tracking of medication effectiveness or potential recalls.

3. Total Doctors per Department
	•	Objective: Count the number of doctors in each department.
	•	Key Steps:
	•	Joined the department and doctor tables.
	•	Grouped by department ID and counted doctor IDs.
	•	Insight: Helps assess staffing distribution across departments.

4. Contact Information for Diabetes Patients
	•	Objective: Retrieve names and phone numbers of patients diagnosed with diabetes.
	•	Key Steps:
	•	Joined patient and diagnosis tables.
	•	Filtered for rows with illness as ‘diabetes’.
	•	Impact: Facilitates follow-up communication for ongoing care or research studies.

5. ER Department Doctors
	•	Objective: List names and IDs of doctors working in the ER department.
	•	Key Steps:
	•	Joined doctor and worker tables.
	•	Filtered for department ID associated with ER.
	•	Insight: Helps in planning for emergency staffing and resource allocation.

6. Total Salary Expenditure
	•	Objective: Calculate the total salary expenditure for all workers.
	•	Key Steps:
	•	Aggregated the salary column from the worker table.
	•	Impact: Provides financial insight for budget planning and cost control.

7. Cafeteria Staff Details
	•	Objective: Retrieve cafeteria staff details, including job titles and food types handled.
	•	Key Steps:
	•	Joined cafeteria, cafeteria_staff, and staff tables.
	•	Insight: Helps in managing cafeteria operations and staff assignments.

8. Average Age of Patients with Flu
	•	Objective: Calculate the average age of patients diagnosed with the flu.
	•	Key Steps:
	•	Joined diagnosis and patient tables.
	•	Filtered for rows where illness is ‘flu’.
	•	Calculated the average age.
	•	Impact: Assists in demographic profiling for common illnesses.

Key Skills and Tools
	•	SQL Techniques: Joins, filtering, aggregation, and grouping.
	•	Data Analysis: Insights into patient demographics, staff distribution, and financial metrics.
	•	Healthcare Insights: Understanding patient care patterns, resource allocation, and operational efficiency.

Deliverables
	1.	SQL Scripts: Full set of SQL queries for hospital data analysis.
	2.	Insights Report: Summary of findings for healthcare administrators and decision-makers.
	3.	Actionable Recommendations:
	•	Address staffing gaps in underrepresented departments.
	•	Allocate resources based on illness demographics.
	•	Optimize financial expenditure for salaries and operations.

Potential Extensions
	1.	Real-Time Dashboards:
	•	Create live dashboards to track patient admissions, staff performance, and resource utilization.
	2.	Predictive Analytics:
	•	Use machine learning to predict patient admission rates or medication demand.
	3.	Enhanced Patient Care:
	•	Develop a system for personalized patient care based on illness patterns and demographics.

This project highlights proficiency in SQL and demonstrates the ability to derive actionable insights from complex healthcare datasets, making it a strong addition to a portfolio in data analytics or healthcare management.Portfolio Project SQL Queries

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
