SET search_path TO github;

Create Table EmployeeDetail
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
);

Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
);

Insert into EmployeeDetail VALUES
(101, 'Mayur', 'Jivani', 30, 'Male'),
(102, 'Dixita', 'Patel', 30, 'Female'),
(103, 'Milan', 'JIvani', 29, 'Male'),
(104, 'Jemika', 'Vanani', 31, 'Female'),
(105, 'Tilak', 'Patel', 32, 'Male'),
(106, 'Meet', 'Jivani', 35, 'Male'),
(107, 'Jeni', 'Rahi', 32, 'Female'),
(108, 'Axar', 'Chaklasiya', 38, 'Male'),
(109, 'Kevin', 'Patel', 31, 'Male');

Insert Into EmployeeSalary VALUES
(101, 'Salesman', 45000),
(102, 'Receptionist', 36000),
(103, 'Salesman', 63000),
(104, 'Accountant', 47000),
(105, 'HR', 50000),
(106, 'Regional Manager', 65000),
(107, 'Supplier Relations', 41000),
(108, 'Salesman', 48000),
(109, 'Accountant', 42000);

SELECT * FROM EmployeeDetail;
SELECT * FROM EmployeeSalary;

SELECT * FROM EmployeeSalary
WHERE Salary>60000;

SELECT * FROM EmployeeSalary LIMIT 3;

SELECT DISTINCT (Gender)  FROM EmployeeDetail;

SELECT COUNT(LastName) FROM  EmployeeDetail; 

SELECT Gender, COUNT(Gender) AS Number FROM EmployeeDetail
WHERE Age>30
GROUP BY Gender
ORDER BY Number DESC;

SELECT EmployeeDetail.Gender, MAX(EmployeeSalary.Salary) as MaximumSalary FROM EmployeeDetail LEFT OUTER JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID
Group by EmployeeDetail.Gender
Order by MaximumSalary DESC;

SELECT EmployeeDetail.Gender, AVG(EmployeeSalary.Salary) as AverageSalary FROM EmployeeDetail 
LEFT OUTER JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID
Group by EmployeeDetail.Gender
Order by AverageSalary DESC;

SELECT * FROM EmployeeDetail as emp LEFT OUTER JOIN EmployeeSalary as sal
ON emp.EmployeeID = sal.EmployeeID
ORDER BY emp.EmployeeID ASC;

SELECT sal.JobTitle, AVG(sal.Salary) as AvgSalary FROM EmployeeDetail as emp LEFT OUTER JOIN EmployeeSalary as sal
ON emp.EmployeeID = sal.EmployeeID
GROUP BY sal.JobTitle;

/*Intermediate Querying*/

Insert into EmployeeDetail VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly','Flax', NULL, 'Male'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

Insert into EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL, 'Salesman', 43000)

SELECT * FROM EmployeeDetail;
SELECT * FROM EmployeeSalary;

SELECT * FROM EmployeeDetail INNER JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID;

SELECT * FROM EmployeeDetail LEFT JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID;

SELECT * FROM EmployeeDetail RIGHT JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID;

SELECT * FROM EmployeeDetail FULL OUTER JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID;

/*Exploring unions by adding a new table*/

Insert into EmployeeDetail VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

Create Table WareHouseEmployeeDetail 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Insert into WareHouseEmployeeDetail VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

SELECT * FROM EmployeeDetail;
SELECT * FROM EmployeeSalary;
SELECT * FROM WareHouseEmployeeDetail;

DELETE FROM EmployeeDetail
WHERE EmployeeDetail.FirstName IN ('Ryan','Holly','Darryl') ;

SELECT * FROM EmployeeDetail;

Insert into EmployeeDetail VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

SELECT * FROM EmployeeDetail
UNION
SELECT * FROM WareHouseEmployeeDetail;

SELECT * FROM EmployeeDetail FULL OUTER JOIN WareHouseEmployeeDetail
ON EmployeeDetail.EmployeeID=WareHouseEmployeeDetail.EmployeeID;

SELECT * FROM EmployeeDetail
UNION ALL
SELECT * FROM WareHouseEmployeeDetail;

SELECT EmployeeDetail.FirstName,EmployeeDetail.LastName,EmployeeSalary.JobTitle,EmployeeSalary.Salary,
CASE
	WHEN Salary>60000 THEN 'High'
	WHEN Salary BETWEEN 50000 AND 60000 THEN 'Medium'
	WHEN Salary BETWEEN 40000 AND 50000 THEN 'Low'
	ELSE 'Very low'
END AS SalaryBand
FROM EmployeeDetail INNER JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID
ORDER BY SalaryBand DESC;

SELECT JobTitle, AVG(Salary) as AVGSAL FROM EmployeeDetail INNER JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID
GROUP BY JobTitle;

/*Using CTE's*/

WITH salary_per_title(Title,Average_Salary)
AS 
(SELECT JobTitle, AVG(Salary) as AVGSAL FROM EmployeeDetail INNER JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID
GROUP BY JobTitle)
SELECT * FROM salary_per_title
WHERE Title IN ('HR','Salesman');

/*Using temp tables*/

CREATE TEMPORARY TABLE salary_per_title (Title varchar(50) ,Salary_avg int)

INSERT INTO salary_per_title 
SELECT JobTitle, AVG(Salary) as AVGSAL FROM EmployeeDetail INNER JOIN EmployeeSalary
ON EmployeeDetail.EmployeeID=EmployeeSalary.EmployeeID
GROUP BY JobTitle;

SELECT Title from salary_per_title;

/* Exploring STRING functions using Error data table */

--Drop Table EmployeeErrors;

CREATE TABLE EmpErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmpErrors Values 
('1001  ', 'Jimbo', 'Halbert'),
('1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson - Fired')

-- Using Trim, LTRIM, RTRIM

Select * FROM EmpErrors;
Select EmployeeID, TRIM(employeeID) AS IDTRIM FROM EmpErrors;

-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed FROM EmpErrors

-- Using Substring

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmpErrors err
JOIN EmployeeDetail dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

-- Using UPPER and lower

Select firstname, LOWER(firstname) from EmpErrors
Select Firstname, UPPER(FirstName) from EmpErrors

/* Using Subqueries */

Select EmployeeID, JobTitle, Salary From EmployeeSalary

-- Subquery in Select
	
Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary

-- Using Partition By
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary

-- Using Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
order by EmployeeID

-- Subquery in From

Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
Order by a.EmployeeID

-- Subquery in Where

Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDetail
	where Age > 30)











