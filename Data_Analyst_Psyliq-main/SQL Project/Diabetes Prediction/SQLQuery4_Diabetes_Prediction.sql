select *
from Diabetes_prediction

exec sp_rename
'Diabetes_prediction.EmployeeName',
'Patient_Name',
'column'

--1. Retrieve the Patient_id and ages of all patients.
select Patient_id,age
from Diabetes_prediction


-- 2. Select all female patients who are older than 40.

select  Patient_name,Patient_id
from Diabetes_prediction
where gender='Female' and age>40

--3.Calculate the average BMI of patients.
select avg(bmi) as Average_BMI
from Diabetes_prediction




--4. List patients in descending order of blood glucose levels.

select Patient_Name
from Diabetes_prediction
order by blood_glucose_level desc



--5. Find patients who have hypertension and diabetes.
select Patient_name
from Diabetes_prediction
where hypertension <> 0 and diabetes<>0


--6. Determine the number of patients with heart disease.
select count(Patient_id) as NO_Of_Patients_having_Heart_Disease
from Diabetes_prediction
where heart_disease<>0



--7. Group patients by smoking history and count how many smokers and nonsmokers there are.SELECT smoking_history, COUNT(*) AS PatientCount
FROM Diabetes_prediction
GROUP BY smoking_history;

--8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.
select Patient_id
from Diabetes_prediction
where bmi>(select avg(bmi) from Diabetes_prediction)


--9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
with high as
	(SELECT TOP 1 Patient_id,patient_name,HbA1c_level,
	case when HbA1c_level=HbA1c_level then 'High'
		 end as Range
	FROM Diabetes_prediction
	ORDER BY HbA1c_level DESC), 
	low as 
	(SELECT TOP 1 Patient_id,patient_name,HbA1c_level,
	case when HbA1c_level=HbA1c_level then 'Low'
		 end as Range
	FROM Diabetes_prediction
	ORDER BY HbA1c_level ASC) 

select * from high
union
select * from low
order by HbA1c_level desc



--11. Rank patients by blood glucose level within each gender group.select patient_name,Patient_id,gender,
rank() over(partition by gender order by blood_glucose_level) as level
from Diabetes_prediction




--12. Update the smoking history of patients who are older than 50 to "Ex-smoker."
update Diabetes_prediction
set smoking_history = 'Ex-Smoker'
where age>50
select*from Diabetes_prediction


--13. Insert a new patient into the database with sample data.insert into Diabetes_prediction
values ('Shalini Kurup','IasdZE','Female',23,0,0,'Current',30,10,300,1)




select * from Diabetes_prediction
where patient_name='Anagha P Kurup'


--14. Delete all patients with heart disease from the database.

delete from Diabetes_prediction
where heart_disease=1


--15. Find patients who have hypertension but not diabetes using the EXCEPT operator.

select Patient_id,Patient_Name
from Diabetes_prediction
where hypertension=1
except
select Patient_id,Patient_Name
from Diabetes_prediction
where diabetes=1




--16. Define a unique constraint on the "patient_id" column to ensure its values are unique.

ALTER TABLE Diabetes_prediction
ADD CONSTRAINT UC_PatientID UNIQUE (patient_id);




--17. Create a view that displays the Patient_ids, ages, and BMI of patients.

create view Display as
	select Patient_id,age,bmi 
	from Diabetes_prediction
select * from Display













































