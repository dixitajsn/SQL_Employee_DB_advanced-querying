SET search_path to demo,public;

-- table of employees
CREATE TABLE emp
(emp_id INTEGER NOT NULL CHECK (emp_id > 99 AND emp_id < 1000),
 name VARCHAR(20) NOT NULL UNIQUE,
 title VARCHAR(15) NOT NULL
 CHECK (title IN ('Programmer', 'Analyst','Sr Programmer', 'Project Leader','Consultant', 'Systems Eng')),
 hourly_rate DECIMAL(6,2) DEFAULT 50.00 NOT NULL CHECK (hourly_rate >= 10.00 AND hourly_rate <= 100.00),
 manager_id  INTEGER CHECK (manager_id IS NULL OR (manager_id > 99 AND manager_id < 1000)),
 CONSTRAINT emp_pk PRIMARY KEY (emp_id)
);

-- table of people dependent on employees
CREATE TABLE dependent
(emp_id INTEGER NOT NULL,
 depname VARCHAR(15) NOT NULL,
 birth DATE NOT NULL,
 CONSTRAINT dependent_pk PRIMARY KEY (emp_id, depname),
 CONSTRAINT dependent_fk1 FOREIGN KEY (emp_id) REFERENCES emp
 ON DELETE CASCADE
);

-- projects being undertaken a strong entity
CREATE TABLE project
(project_id CHAR(4) NOT NULL,
 description VARCHAR(22) NOT NULL,
 dept CHAR(8) NOT NULL,
 budget DECIMAL(10,2) NOT NULL CHECK (budget > 10000),
 due_date DATE NOT NULL,
 CONSTRAINT project_pk PRIMARY KEY (project_id)
);

-- table showing work done by an employee on a project a strong entity related emp and to project
CREATE TABLE task
(emp_id INTEGER NOT NULL,
 project_id CHAR(4) NOT NULL,
 task_name VARCHAR(9) NOT NULL,
 hours INTEGER NOT NULL,
 CONSTRAINT task_pk PRIMARY KEY (emp_id, project_id, task_name),
 CONSTRAINT task_fk1 FOREIGN KEY(emp_id) REFERENCES emp,
 CONSTRAINT task_fk2 FOREIGN KEY(project_id) REFERENCES project
);

--  Grant statements if needed
--  comment out all the grant statements
GRANT SELECT ON dependent TO PUBLIC;
GRANT SELECT ON emp TO PUBLIC;
GRANT SELECT ON project TO PUBLIC;
GRANT SELECT ON task TO PUBLIC;

-- Indexes on foreign keys
CREATE INDEX dependent_fkey1 ON dependent (emp_id);
CREATE INDEX task_fkey1 ON task (emp_id);
CREATE INDEX task_fkey2 ON task (project_id);

-- Other indexes, for example
CREATE INDEX emp_title_idx ON emp (title);
CREATE INDEX task_name_idx ON task (task_name);

-- A sample view and shows the average number of hours worked on each project
CREATE VIEW  project_hours AS
    SELECT project.project_id, description, avg(hours) AS avg_hours
    FROM task, project
    WHERE task.project_id = project.project_id
    GROUP BY project.project_id, description;

-- may want to grant access to the view otherwise comment out
GRANT SELECT ON project_hours TO PUBLIC;

-- populate employee table

INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (612, 'Bee, Charles', 'Sr Programmer', 43.00, 802);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (635, 'Fine, Laurence', 'Sr Programmer', 42.00, 653);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (638, 'Bluff, Clarence', 'Programmer', 24.00, 652);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (642, 'Chung, Arthur', 'Programmer', 21.00, 686);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (652, 'Jones, Ashley', 'Sr Programmer', 49.00, 716);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (653, 'Jones, Betty', 'Project Leader', 66.00, NULL);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (656, 'King, Richard', 'Sr Programmer', 39.00, 808);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (660, 'Smith, Chester', 'Programmer', 22.00, 612);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (661, 'Stein, Frank', 'Programmer', 27.00, 856);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (662, 'Moore, Holly', 'Programmer', 36.00, 856);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (663, 'Wolfe, Neal', 'Project Leader', 65.00, NULL);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (671, 'O''Foote, Suzanne', 'Programmer', 40.00, 748);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (673, 'Smith, Peggy', 'Consultant', 32.00, 856);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (682, 'Rolls, Richard', 'Programmer', 28.00, 656);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (683, 'Belter, Kris', 'Programmer', 33.00, 691);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (686, 'Ortega, Julio', 'Sr Programmer', 50.00, 663);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (691, 'Alcott, Scott', 'Sr Programmer', 50.00, 663);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (693, 'Noonan, Brad', 'Programmer', 25.00, 652);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (698, 'Hilton, Connie', 'Programmer', 37.00, 748);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (716, 'Turner, Russell', 'Project Leader', 53.00, 653);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (746, 'Randall, David', 'Programmer', 34.00, 691);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (748, 'Bridges, Debra', 'Sr Programmer', 48.00, 786);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (770, 'Downing, Susan', 'Programmer', 29.00, 612);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (782, 'Walters, Lindsay', 'Analyst', 44.00, 635);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (786, 'Parsons, Carol', 'Project Leader', 55.00, 663);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (789, 'Lorenzo, Sue', 'Consultant', 52.00, 786);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (802, 'Fielding, Wallace', 'Project Leader', 47.00, 653);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (808, 'Beveridge, Fern', 'Project Leader', 57.00, 663);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (814, 'Beringer, Tom', 'Programmer', 41.00, 656);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (815, 'Applegate, Donald', 'Analyst', 51.00, 663);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (848, 'Peterson, Jean', 'Analyst', 32.00, 691);
INSERT INTO emp(emp_id, name, title, hourly_rate, manager_id)
    VALUES (856, 'Thompson, Howard', 'Sr Programmer', 45.00, 653);

-- constraint future inserts to have a manager already in table
ALTER TABLE emp ADD
     CONSTRAINT emp_fk1 FOREIGN KEY (manager_id) REFERENCES emp
         ON DELETE SET NULL;

-- populate the dependent table

INSERT INTO dependent(emp_id, depname, birth)
    VALUES (612, 'Chester', '2019-08-05');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (612, 'Tom', '2020-06-10');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (635, 'Patricia', '2009-06-10');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (638, 'Marvin', '2010-05-10');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (652, 'Marvin', '2010-05-31');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (660, 'Avery', '2009-03-28');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (661, 'Annette', '2018-04-12');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (663, 'Bruce', '2014-06-01');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (663, 'Ernest', '2018-04-15');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (671, 'Walter', '2012-08-24');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (673, 'Brent', '2019-04-07');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (682, 'Alfred', '2019-09-26');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (682, 'Janet', '2016-09-25');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (682, 'Jennifer', '2019-06-08');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (691, 'Deborah', '2017-05-05');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (691, 'Jason', '2012-01-08');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (693, 'Carol', '2010-05-31');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (693, 'Patricia', '2014-09-10');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (693, 'Stephen', '2010-09-14');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (746, 'Lynn', '2012-06-06');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (746, 'Michele', '2018-04-12');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (748, 'Daphne', '2019-09-04');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (770, 'Tom', '2019-06-08');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (782, 'George', '2012-08-24');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (789, 'Aaron', '2011-04-07');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (789, 'Daphne', '2010-05-27');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (848, 'James', '2018-07-07');
INSERT INTO dependent(emp_id, depname, birth)
    VALUES (856, 'Raquel', '2019-09-15');

-- populate the project table
INSERT INTO project(project_id, description, dept, budget, due_date)
    VALUES ('ADV ', 'Advertising Analysis', 'Sales   ', 95000.00, '2021-03-02');
INSERT INTO project(project_id, description, dept, budget, due_date)
    VALUES ('ASS ', 'Asset Management', 'Account ', 117000.00, '2021-10-20');
INSERT INTO project(project_id, description, dept, budget, due_date)
    VALUES ('EBEN', 'Employee Benefits', 'Admin   ', 200000.00, '2021-09-15');
INSERT INTO project(project_id, description, dept, budget, due_date)
    VALUES ('EXP ', 'Expense Account System', 'Sales   ', 125000.00, '2021-04-01');
INSERT INTO project(project_id, description, dept, budget, due_date)
    VALUES ('GRD ', 'Graphic Design', 'Comms   ', 180000.00, '2021-11-10');
INSERT INTO project(project_id, description, dept, budget, due_date)
    VALUES ('PORT', 'Portfolio Analysis', 'Account ', 112000.00, '2022-05-15');
INSERT INTO project(project_id, description, dept, budget, due_date)
    VALUES ('SF  ', 'Sales Forecasting', 'Sales   ', 99000.00, '2022-06-01');
INSERT INTO project(project_id, description, dept, budget, due_date)
    VALUES ('TP  ', 'Text Processing', 'Admin   ', 140000.00, '2022-09-09');

-- populate the task table
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (612, 'PORT', 'Design', 10);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (612, 'PORT', 'Implement', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (635, 'SF  ', 'Design', 22);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (635, 'SF  ', 'Implement', 36);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (638, 'EBEN', 'Implement', 38);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (638, 'EBEN', 'Test', 32);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (638, 'PORT', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (642, 'ADV ', 'Debug', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (642, 'TP  ', 'Debug', 48);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (642, 'TP  ', 'Implement', 48);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (652, 'EBEN', 'Design', 44);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (652, 'EBEN', 'Implement', 32);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (653, 'EXP ', 'Design', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (653, 'EXP ', 'Implement', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (653, 'EXP ', 'Manage', 5);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (653, 'SF  ', 'Design', 16);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (653, 'SF  ', 'Implement', 6);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (653, 'SF  ', 'Manage', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (656, 'ASS ', 'Design', 15);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (656, 'ASS ', 'Implement', 32);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (660, 'ADV ', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (660, 'ASS ', 'Test', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (660, 'PORT', 'Debug', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (660, 'PORT', 'Implement', 36);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (661, 'EXP ', 'Debug', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (661, 'EXP ', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (662, 'EXP ', 'Debug', 18);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (662, 'EXP ', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (662, 'SF  ', 'Debug', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (663, 'ADV ', 'Design', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (663, 'ADV ', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (663, 'ADV ', 'Manage', 6);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (663, 'TP  ', 'Implement', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (663, 'TP  ', 'Manage', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (663, 'TP  ', 'Test', 16);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (671, 'GRD ', 'Debug', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (671, 'GRD ', 'Test', 26);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (671, 'TP  ', 'Test', 10);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (673, 'EBEN', 'Design', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (673, 'EXP ', 'Design', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (673, 'EXP ', 'Implement', 5);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (673, 'PORT', 'Design', 10);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (673, 'SF  ', 'Design', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (682, 'ADV ', 'Implement', 16);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (682, 'TP  ', 'Debug', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (682, 'TP  ', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (683, 'ASS ', 'Debug', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (683, 'ASS ', 'Implement', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (686, 'TP  ', 'Design', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (686, 'TP  ', 'Implement', 48);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (691, 'ADV ', 'Implement', 5);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (691, 'ADV ', 'Test', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (693, 'EBEN', 'Debug', 18);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (693, 'EBEN', 'Implement', 32);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (693, 'SF  ', 'Implement', 20);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (698, 'GRD ', 'Implement', 48);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (698, 'GRD ', 'Test', 36);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (698, 'TP  ', 'Debug', 10);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (698, 'TP  ', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (716, 'EBEN', 'Design', 32);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (716, 'EBEN', 'Manage', 22);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (716, 'EBEN', 'Test', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (746, 'ADV ', 'Implement', 14);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (746, 'ADV ', 'Test', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (748, 'GRD ', 'Design', 42);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (748, 'GRD ', 'Implement', 18);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (770, 'EXP ', 'Implement', 16);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (770, 'PORT', 'Debug', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (770, 'PORT', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (770, 'SF  ', 'Implement', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (782, 'GRD ', 'Design', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (782, 'PORT', 'Design', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (782, 'SF  ', 'Design', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (782, 'SF  ', 'Test', 36);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (782, 'TP  ', 'Design', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (786, 'GRD ', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (786, 'GRD ', 'Manage', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (786, 'GRD ', 'Test', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (789, 'ADV ', 'Design', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (789, 'GRD ', 'Design', 32);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (789, 'GRD ', 'Implement', 52);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (789, 'TP  ', 'Design', 18);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (789, 'TP  ', 'Test', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (802, 'PORT', 'Design', 16);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (802, 'PORT', 'Manage', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (802, 'PORT', 'Test', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (808, 'ASS ', 'Design', 24);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (808, 'ASS ', 'Manage', 10);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (808, 'ASS ', 'Test', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (814, 'ADV ', 'Debug', 18);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (814, 'ASS ', 'Debug', 16);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (814, 'ASS ', 'Implement', 32);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (815, 'ADV ', 'Test', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (815, 'GRD ', 'Design', 16);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (815, 'TP  ', 'Design', 10);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (815, 'TP  ', 'Implement', 10);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (848, 'ADV ', 'Design', 16);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (848, 'ADV ', 'Implement', 12);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (856, 'EXP ', 'Design', 8);
INSERT INTO task(emp_id, project_id, task_name, hours)
    VALUES (856, 'EXP ', 'Test', 24);

-- check the contents should be 32, 28, 8, 100
(SELECT 1, 'emp', COUNT(*) FROM emp
UNION
SELECT 2, 'dependent', COUNT(*) FROM dependent
UNION
SELECT 3, 'project', COUNT(*) FROM project
UNION
SELECT 4, 'task', COUNT(*) FROM task)
ORDER BY 1;

--a)	List all employee details.
select * from emp;

--b)	List all employee names and titles.
select name, title from emp;

--c)	List all employee titles, eliminating duplicates.
select distinct title from emp;

--d)	List employee names and the total cost of each employee for a 40 hour week (use the hourly rate).
select name, hourly_rate*40 from emp;

--e)	As (d) but label the total cost column 'Weekly_Cost'.
select name, hourly_rate*40 as Weekly_Cost from emp;

--f)	As (e) but insert, on every row,  ' is charged at Â£' between the two columns.
select name, 'is charged at Â£', hourly_rate*40 as Weekly_cost from emp;

--g)	Display the total number of employees.
select count (*)AS "EMPLOYEE TOTAL" from emp;

--h)	Display the minimum, maximum and average hourly rate for the employees.
select MIN(HOURLY_RATE) AS MIN,MAX (HOURLY_RATE)AS MAX,AVG(HOURLY_RATE) AS AVG FROM emp;

--i)	How many separate hourly rates are currently in use?
select count( distinct hourly_rate) as No_Hourly_Rates from emp;

--j)	List the title, name and hourly rate of each employee, sorted by title and within similar titles by name.
select title, name, hourly_rate from emp order by title,name;

--k)	List the names of all employees with job title 'Analyst'.
    select  name from emp 	
    where title like 'Analyst';

--l)	List the names of all employees with 'Richard' as part of their name.
select  name from emp 
     where name like '%Richard%';

--m)	List the names and hourly rates of all employees with hourly rates over 30 and with titles contain 'Programmer'.
select  name, hourly_rate from emp 
where hourly_rate>30 and title like '%Programmer%';

--n)	List the names of all employees who are analysts, Consultants or Project Leaders.
select  name, title from emp 
where title='Analyst' or title='Consultant' or title = 'Project Leader';

--o)	Display the titles currently used in the emp table and a count of the employees with each title.
select  title, count(*) AS TOTAL from emp 
group by title;

--p)	As (o) but only include title used by more than 5 employees and present the results sorted by title.
select  title, count(*) AS TOTAL from emp 
          group by title
     HAVING COUNT(*)>5
     ORDER BY TITLE;

--q)	List names, titles, and project id for all employees.

SELECT DISTINCT NAME,TITLE,PROJECT_ID FROM EMP JOIN TASK ON EMP.EMP_ID=TASK.EMP_ID;

--r)	As for (q), but list name, title and project description and sort it by name and title.

SELECT DISTINCT NAME,TITLE,DESCRIPTION
FROM EMP JOIN TASK ON EMP.EMP_ID=TASK.EMP_ID 
JOIN PROJECT ON TASK.PROJECT_ID=PROJECT.PROJECT_ID
ORDER BY NAME,title;

--s)	List names and total hours worked for each analyst.  Display results in name order.

SELECT name, sum(hours) As "Total Hours"
	FROM EMP LEFT JOIN TASK ON EMP.EMP_ID=TASK.EMP_ID 
	where emp.title='Analyst'
	group by name,title
ORDER BY NAME;

--t)	A list of all employees with their dependents, if any, showing employee id, employee name 
-- and dependent name in employee name order.

SELECT name,EMP.emp_id,depname 
FROM EMP LEFT JOIN DEPENDENT ON EMP.EMP_ID=DEPENDENT.EMP_ID
ORDER BY NAME;

--u)	List all employees with the total number of dependents for each.  Display the results in employee name order
SELECT name, COUNT (depname) 
	FROM EMP LEFT JOIN DEPENDENT ON EMP.EMP_ID=DEPENDENT.EMP_ID
	GROUP BY NAME
ORDER BY NAME;

--v)	For each project, calculate the surplus money available in the budget 
--(i.e. the amount of money that has not already been allocated through the different tasks) and produce a list in project_id order.	

SELECT PROJECT.PROJECT_ID,(BUDGET - SUM(hourly_rate*hours)) AS "TOTAL SURPLUS"
FROM emp join task on task.emp_id=emp.emp_id
JOIN PROJECT ON TASK.PROJECT_ID=PROJECT.PROJECT_ID
GROUP BY PROJECT.PROJECT_ID
ORDER BY PROJECT.PROJECT_ID;

--a.	Peter Brown is looking for a new job and has been hired as a consultant; his hourly rate is 55 and his manager is Carol Parsons. 
-- Insert his record into the emp table.

INSERT INTO emp 
VALUES (901,'Peter, Brown','Consultant',55, 
(SELECT emp_id FROM emp where name LIKE 'Parsons, C%'));

--b.	 Who else is managed by Carol Parsons?

SELECT e.emp_id, e.name
    FROM emp e, emp m
    WHERE e.manager_id = m.emp_id
    AND   e.name != 'Peter, Brown'
    AND   m.name = 'Parsons, Carol';

--c.	Give all employees (except Peter Brown) a 10% pay rise as compensation for having to work with Peter Brown. Check the emp table for the updated pay.

update emp set hourly_rate=hourly_rate*1.1 
WHERE emp_id in((SELECT emp_id from emp) except (select emp_id from emp where name LIKE 'Peter, Brown%'));

--d.	Give Carol Parsons a further 10% pay rise as compensation for the extra responsibility of managing Peter Brown.

update emp set hourly_rate=hourly_rate *1.1 where emp.name like 'Parsons, Carol';

--e.	Which employees have dependents born after 1st Jan 2018 and what are the dependents' names and dates of birth?

select distinct name, depname, birth from emp, dependent
where
dependent.emp_id=emp.emp_id and
birth>'01/01/2018'
order by name;

--f.	By how much would it increase the hourly costs to give each of the employees
-- with dependents born after 1st Jan 2017 a 5% pay rise? Initial approach may be

select cast(sum(0.05 * emp.hourly_rate)as decimal(5,2)) AS total_rise from emp, dependent
where
dependent.emp_id=emp.emp_id and
birth>'01/01/2017';

-- but that may not work because of duplicates (those with more than one dependant are counted more than once).  
--To remove duplicates

select cast(sum(0.05 * emp.hourly_rate)as decimal(5,2)) AS total_rise from emp
WHERE emp_id in 
       	 (select distinct emp.emp_id from emp, dependent
	where dependent.emp_id=emp.emp_id and birth>'01/01/2017');

--g.	The company opts to terminate all its consultants. 
--Create a report by generating a table containing tuples related to consultant tasks within the task table.
-- how many tuples associated with consultants?

SELECT count(*) FROM demo.task
WHERE emp_id  in
(SELECT emp_id FROM emp WHERE title = 'Consultant');

--h.	h)	Remove all consultant tasks. Check task table to ensure deletions. 
-- Now delete the Consultants from the emp table to keep this table consistent with your tasks table. 
--(Use 'transaction' for this task)

BEGIN;
Delete FROM demo. task
           WHERE emp_id in
               (SELECT emp_id
                   FROM emp
                   WHERE title = 'Consultant');
DELETE FROM demo.emp
   WHERE title = 'Consultant';
COMMIT;






