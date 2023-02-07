
CREATE VIEW VIEW_DEMO 
AS
SELECT em.employee_id, CONCAT(em.first_name , ' ' ,em.last_name) 
as full_name, em.hire_date, dep.department_name 
FROM employees em JOIN departments dep
ON em.department_id = dep.department_id

SELECT * FROM VIEW_DEMO