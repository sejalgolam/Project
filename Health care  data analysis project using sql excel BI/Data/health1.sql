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
 group by 1
 order by 2;

# -- 3. Number of people diagnosed with OCD MoM

 ALTER TABLE ocd_patient_dataset 
 MODIFY `OCD Diagnosis Date` DATE;

UPDATE ocd_patient_dataset
SET `OCD Diagnosis Date` = STR_TO_DATE(`OCD Diagnosis Date`, '%d-%m-%Y');

select
date_format(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
 -- `OCD Diagnosis Date`
count(`Patient ID`) patient_count
from ocd_patient_dataset
group by 1
Order by 1
;

# -- 4. What is the most common Obsession Type (Count) & it's respective Average Obsession Score

Select
`Obsession Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from ocd_patient_dataset
group by 1
Order by 2
;

# -- 5. What is the most common Compulsion type (Count) & it's respective Average Obsession Score

Select
`Compulsion Type`, 
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from ocd_patient_dataset
group by 1
Order by 2
;
