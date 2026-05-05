--- 1. Finding total number of employees
SELECT COUNT(*) AS total_no_OF_emp
FROM employees;

--- 2. Overall attrition rate (% who left)
SELECT COUNT(*) AS emp_count,
	SUM(CAST("Attrition" AS INTEGER)) AS left_count,
	ROUND((AVG(CAST("Attrition" AS FLOAT))*100.0)::NUMERIC,2) AS attrition_pct
FROM employees;	

---3. Top 10 highest-paid leavers (employees who left with highest income)
SELECT "MonthlyIncome", "JobRole", "Age", "YearsAtCompany"
FROM employees
WHERE "Attrition"=1 ORDER BY "MonthlyIncome" DESC LIMIT 10;

---4. Overtime + Low Income danger zone 
--SELECT AVG("MonthlyIncome") from employees;
SELECT COUNT(*) AS emp_in_segment,
ROUND((AVG(CAST("Attrition" AS FLOAT))*100.0)::numeric,1) AS attr_pct,
SUM(CAST("Attrition" AS INTEGER)) AS left_company
FROM employees
WHERE "OverTime"=1 AND "MonthlyIncome"< 5000;


---5. Attrition by department.
SELECT "Department", COUNT(*) AS total,
           SUM(CAST("Attrition" AS INTEGER)) AS left_company,
           ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0)::Numeric, 2) AS attrition_pct,
           ROUND((AVG("MonthlyIncome"))::Numeric, 2) AS avg_income
FROM employees GROUP BY "Department" 
ORDER BY attrition_pct DESC;

---6. Attrition by JobRole
SELECT "JobRole", COUNT(*) AS total,
           ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0)::Numeric, 2) AS attrition_pct,
           ROUND(AVG("MonthlyIncome")::Numeric, 2) AS avg_income
FROM employees 
GROUP BY "JobRole" ORDER BY attrition_pct DESC;

---7. Attrition by MaritalStatus
SELECT "MaritalStatus", COUNT(*) AS total,
     ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0)::Numeric, 1) AS attrition_pct
FROM employees GROUP BY "MaritalStatus" ORDER BY attrition_pct DESC;

---8. Attrition by BusinessTravel
SELECT "BusinessTravel", COUNT(*) AS total,
     ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0)::Numeric, 1) AS attrition_pct
FROM employees GROUP BY "BusinessTravel" ORDER BY attrition_pct DESC;

---9. High-attrition roles with 50+ employees (HAVING)
SELECT "JobRole", COUNT(*) AS total,
           ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0)::numeric, 1) AS attrition_pct
FROM employees GROUP BY "JobRole"
HAVING AVG(CAST("Attrition" AS FLOAT)) > 0.20 AND COUNT(*) >= 50
ORDER BY attrition_pct DESC;

--- 10. Age groups with 100+ employees (HAVING + CASE WHEN)
SELECT
   CASE WHEN "Age" < 25 THEN 'Under 25'
        WHEN "Age" <= 34 THEN '25-34'
        WHEN "Age" <= 44 THEN '35-44'
        ELSE '45+' END AS age_group,
   COUNT(*) AS total,
   ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0)::numeric, 1) AS attrition_pct
FROM employees GROUP BY age_group
HAVING COUNT(*) > 100 ORDER BY attrition_pct DESC;

---11. Departments below company average income (HAVING + Subquery)
SELECT "Department", ROUND((AVG("MonthlyIncome"))::Numeric,2) AS avg_income, COUNT(*) AS employees
FROM employees GROUP BY "Department"
HAVING AVG("MonthlyIncome") < (SELECT AVG("MonthlyIncome") FROM employees)
ORDER BY avg_income ASC;

---12. Risk segments (CASE WHEN)
SELECT
    CASE WHEN "OverTime" = 1 AND "MonthlyIncome" < 5000 THEN 'Extreme Risk'
         WHEN "OverTime" = 1 THEN 'High Risk OT'
         WHEN "MonthlyIncome" < 3000 THEN 'High Risk Pay'
         ELSE 'Normal' END AS risk_segment,
COUNT(*) AS employees,
ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0)::numeric, 1) AS attrition_pct
FROM employees 
GROUP BY risk_segment ORDER BY attrition_pct DESC;

---13. Attrition by income band (CASE WHEN)
SELECT
        CASE WHEN "MonthlyIncome" < 3000  THEN 'Low  (<3k)'
             WHEN "MonthlyIncome" < 6000  THEN 'Mid  (3k-6k)'
             WHEN "MonthlyIncome" < 10000 THEN 'High (6k-10k)'
             ELSE 'Very High (>10k)' END AS income_band,
        COUNT(*) AS employees,  
        ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0)::numeric, 1) AS attrition_pct
    FROM employees GROUP BY income_band ORDER BY attrition_pct DESC;

--- 14. Below-dept-average earners attrition (Subquery in WHERE)
SELECT e."Department", COUNT(*) AS below_avg_count,
           ROUND((AVG(CAST(e."Attrition" AS FLOAT)) * 100.0)::numeric, 1) AS attrition_pct
    FROM employees e
    WHERE e."MonthlyIncome" < (SELECT AVG("MonthlyIncome") FROM employees sub WHERE sub."Department" = e."Department")
    GROUP BY e."Department" ORDER BY attrition_pct DESC;

--- 15. Above-company-average earners (Subquery in WHERE)
SELECT COUNT(*) AS above_avg_count,
           ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0)::numeric, 1) AS attrition_pct
    FROM employees WHERE "MonthlyIncome" > (SELECT AVG("MonthlyIncome") FROM employees);

---16. Income rank within each department (RANK)
SELECT * 
FROM (
    SELECT "EmployeeNumber", "JobRole", "Department", "MonthlyIncome", "Attrition",
           RANK() OVER (PARTITION BY "Department" ORDER BY "MonthlyIncome" DESC) AS income_rank_in_dept
    FROM employees
) t
WHERE income_rank_in_dept <= 5;

--OR
SELECT *
FROM (
    SELECT "EmployeeNumber", "JobRole", "Department", "MonthlyIncome", "Attrition",
           ROW_NUMBER() OVER (PARTITION BY "Department" ORDER BY "MonthlyIncome" DESC) AS rn
    FROM employees
) t
WHERE rn = 5;

---17. Running total by tenure (SUM OVER)
SELECT "YearsAtCompany", COUNT(*) AS employees,
      SUM(COUNT(*)) OVER (ORDER BY "YearsAtCompany") AS running_total,
      ROUND((AVG(CAST("Attrition" AS FLOAT)) * 100.0):: numeric, 1) AS attrition_pct
FROM employees GROUP BY "YearsAtCompany" ORDER BY "YearsAtCompany" LIMIT 10;

--- 18. Lowest-paid employee per department (ROW_NUMBER)
SELECT "Department", "JobRole", "MonthlyIncome", "Attrition"
    FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY "Department" ORDER BY "MonthlyIncome" ASC) AS rn FROM employees) ranked
    WHERE rn = 1;