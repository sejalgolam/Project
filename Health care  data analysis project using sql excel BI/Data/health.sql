USE health;

SELECT * FROM ocd_patient_dataset;

-- Q1. Count & Pct of F vs M that have OCD & Average Obsession Score by Gender
-- Create the Common Table Expression (CTE)
WITH data AS (
    SELECT
        Gender,
        COUNT(`Patient ID`) AS Patient_count,
        ROUND(AVG(`Y-BOCS Score (Obsessions)`), 2) AS avg_obs_score
    FROM ocd_patient_dataset
    GROUP BY Gender
    ORDER BY Patient_count
)

-- Select from the CTE
SELECT 
    SUM(CASE WHEN Gender = 'Female' THEN Patient_count ELSE 0 END) AS count_female, 
    SUM(CASE WHEN Gender = 'Male' THEN Patient_count ELSE 0 END) AS count_Male,
    
   round(SUM(CASE WHEN Gender = 'Female' THEN Patient_count ELSE 0 END)/
    (SUM(CASE WHEN Gender = 'Female' THEN Patient_count ELSE 0 END)+ SUM(CASE WHEN Gender = 'Male' THEN Patient_count ELSE 0 END)) *100,2)
    as pct_female,
    
   round(SUM(CASE WHEN Gender = 'Male' THEN Patient_count ELSE 0 END)/
    (SUM(CASE WHEN Gender = 'Female' THEN Patient_count ELSE 0 END)+ SUM(CASE WHEN Gender = 'Male' THEN Patient_count ELSE 0 END)) *100,2)
    as pct_Male
    
    FROM data;
    
# -- Q2. Count of Patients by Ethnicity and their respective Average Obsession Score

select
Ethnicity,
count(`Patient ID`) as patinet_count,
avg(`Y-BOCS Score (Obsessions)`) as obs_score
 FROM ocd_patient_dataset


