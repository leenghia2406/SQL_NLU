USE hr
/* A. Câu lệnh DML */
-- 1. Cập nhật tên của nhân viên có mã 3 thành “Drexler‟.
UPDATE employees
SET last_name = 'Drexler'
WHERE employee_id = 3;
-- 2. Tăng thêm 100$ cho những nhân viên có lương nhỏ hơn 900$
UPDATE employees
SET salary = salary + 100
WHERE salary < 900;
-- 3. Xóa phòng ban 500.
DELETE FROM departments
WHERE department_id = 500;
-- 4. Xóa phòng ban nào chưa có nhân viên
DELETE FROM departments
WHERE NOT EXISTS (
    SELECT 1
    FROM employees
    WHERE employees.department_id = departments.department_id
);

/* B. Câu lệnh SQL */
-- 5. Liệt kê tên (last_name) và lương (salary) của những nhân viên có lương lớn hơn 12000$
SELECT last_name, salary 
FROM employees
WHERE salary > 12000;
-- 6. Liệt kê tên và lương của những nhân viên có lương thấp hơn 5000$ hoặc lớn hơn 12000$.
SELECT last_name, salary 
FROM employees
WHERE salary < 5000 OR salary > 12000;
/* 7. Cho biết thông tin tên nhân viên (last_name), mã công việc (job_id) , ngày thuê (hire_date)
của những nhân viên được thuê từ ngày 20/02/1998 đến ngày 1/05/1998. Thông tin được
hiển thị tăng dần theo ngày thuê */
SELECT last_name, job_id, hire_date 
FROM employees
WHERE hire_date BETWEEN '1998-02-20' AND '1998-05-01'
ORDER BY hire_date ASC;
/* 8. Liệt kê danh sách nhân viên làm việc cho phòng 20 và 50. Thông tin hiển thị gồm: last_name,
department_id, trong đó tên nhân viên được sắp xếp theo thứ tự tăng dần */
SELECT last_name, department_id 
FROM employees
WHERE department_id IN (20, 50)
ORDER BY last_name ASC;
-- 9. Liệt kê danh sách nhân viên được thuê năm 1994
SELECT * FROM employees
WHERE YEAR(hire_date) = 1994;
-- 10. Liệt kê tên nhân viên (last_name), mã công việc (job_id) của những nhân viên không có người quản lý
SELECT last_name, job_id FROM employees
WHERE manager_id = NULL;
/* 11. Cho biết thông tin tất cả nhân viên được hưởng hoa hồng (commission_pct), kết quả được 
sắp xếp giảm dần theo lương và hoa hồng. */
SELECT * FROM employees
WHERE commission_pct NOT NULL
ORDER BY salary DESC, commission_pct DESC;
-- 12. Liệt kê danh sách nhân viên mà có kí tự thứ 3 trong tên là “a”.
SELECT * FROM employees
WHERE last_name LIKE '__a%';
-- 13. Liệt kê danh sách nhân viên mà trong tên có chứa ít nhất một chữ “a” hoặc một chữ “e”.
SELECT * FROM employees
WHERE last_name LIKE '%a%' OR last_name LIKE '%e%';
/* 14. Cho biết tên (last_name), mã công việc (job_id), lương (salary) của những nhân viên làm
“Sales representative” hoặc “Stock clert” và có mức lương khác 2500$, 3500$, 7000$. */
SELECT last_name, job_id, salary 
FROM employees
WHERE job_id IN (SELECT job_id FROM jobs WHERE job_title IN ('Sales representative', 'Stock clert'))
AND salary NOT IN (2500, 3500, 7000);
/* 15. Cho biết mã nhân viên (employee_id), tên nhân viên (last_name), lương sau khi tang thêm
15% so với lương ban đầu, được làm tròn đến hàng đơn vị và đặt lại tên cột là “New Salary”. */
SELECT employee_id, last_name, CAST(ROUND(salary*1.15, 1) AS INT) AS "New Salary" FROM employees
/* 16. Liệt kê tên nhân viên, mức hoa hồng nhân viên đó nhận được. Trường hợp nhân viên nào
không được hưởng hoa hồng thì hiển thị “No commission”. */
SELECT last_name,
	CASE WHEN commission_pct IS NOT NULL THEN commission_pct
	ELSE 'No commission'
	END AS commission
FROM employees;
 /* 17. Thực hiện câu truy vấn cho kết quả như sau:
JOB_ID GRADE
AD_PRES A
ST_MAN B
IT_PROG C
SA_REP D
ST_CLERK E
Không thuộc 0 */
SELECT 
    CASE job_id
        WHEN 5 THEN 'AD_PRES'
        WHEN 19 THEN 'ST_MAN'
        WHEN 9 THEN 'IT_PROG'
        WHEN 16 THEN 'SA_REP'
        WHEN 18 THEN 'ST_CLERK'
        ELSE 'Không thuộc'
    END AS job_name,
    CASE job_id
        WHEN 5 THEN 'A'
        WHEN 19 THEN 'B'
        WHEN 9 THEN 'C'
        WHEN 16 THEN 'D'
        WHEN 18 THEN 'E'
        ELSE '0'
    END AS grade
FROM employees;
-- 18. Cho biết tên nhân viên, mã phòng, tên phòng của những nhân viên làm việc ở thành phố Toronto.
SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Toronto';
/* 19. Liệt kê thông tin nhân viên cùng với người quản lý của nhân viên đó. Kết quả hiển thị: mã
nhân viên, tên nhân viên, mã người quản lý, tên người quản lý. */
SELECT e.employee_id AS "employee id", e.last_name AS "employee name",
m.employee_id AS "manager id", m.last_name AS "manager name"
FROM employees e JOIN employees m ON e.manager_id = m.employee_id;
-- 20. Liệt kê danh sách những nhân viên làm việc cùng phòng
SELECT e.*
FROM employees e 
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_id
-- 21. Liệt kê danh sách nhân viên được thuê sau nhân viên “Davies‟
SELECT * FROM employees
WHERE hire_date > (
	SELECT hire_date FROM employees 
	WHERE last_name = 'Davies'
);
-- 22. Liệt kê danh sách nhân viên được thuê vào làm trước người quản lý của họ
SELECT e.*
FROM employees e JOIN employees m ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;
-- 23. Cho biết lương thấp nhất, lương cao nhất, lương trung bình, tổng lương của từng loại công việc
SELECT 
    e.job_id, j.job_title,    
	j.min_salary AS min_salary,
    j.max_salary AS max_salary,
    AVG(e.salary) AS avg_salary,
    SUM(e.salary) AS total_salary
FROM employees e JOIN jobs j ON e.job_id = j.job_id
GROUP BY e.job_id, j.job_title, j.min_salary, j.max_salary;
-- 24. Cho biết mã phòng, tên phòng, số lượng nhân viên của từng phòng ban.
SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS "SO LUONG NHAN VIEN"
FROM departments d JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;
-- 25. Cho biết tổng số nhân viên, tổng nhân viên được thuê từng năm 1995, 1996, 1997, 1998.
WITH hired_employees AS (
    SELECT COUNT(employee_id) AS "TONG NHAN VIEN DUOC THUE", YEAR(hire_date) AS "NAM"
    FROM employees
    WHERE YEAR(hire_date) IN (1995, 1996, 1997, 1998)
    GROUP BY YEAR(hire_date)
), total_employees AS (
	SELECT COUNT(*) AS "TONG NHAN VIEN" FROM employees
)
SELECT * FROM total_employees CROSS JOIN hired_employees;
-- 26. Liệt kê tên, ngày thuê của những nhân viên làm việc cùng phòng với nhân viên “Zlotkey‟.
SELECT o.last_name, o.hire_date
FROM employees e JOIN employees o ON e.department_id = o.department_id
WHERE e.last_name = 'Zlotkey' and o.last_name <> 'Zlotkey';
SELECT last_name, hire_date FROM employees 
WHERE department_id IN (SELECT department_id FROM employees WHERE last_name = 'Zlotkey');
/* 27. Liệt kê tên nhân viên, mã phòng ban, mã công việc của những nhân viên làm việc cho phòng
ban đặt tại vị trí (location_id) 1700. */
SELECT e.last_name, d.department_id, e.job_id
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id
WHERE l.location_id = 1700;
-- 28. Liệt kê danh sách nhân viên có người quản lý tên “King‟.
SELECT e.*
FROM employees e JOIN employees m ON e.manager_id = m.employee_id
WHERE m.last_name = 'King';
/* 29. Liệt kê danh sách nhân viên có lương cao hơn mức lương trung bình và làm việc cùng phòng
với nhân viên có tên kết thúc bởi “n‟. */
SELECT DISTINCT e.employee_id, e.last_name, e.salary, e.department_id
FROM employees e JOIN (
    SELECT AVG(salary) AS average_salary
    FROM employees
) AS avg_salary ON e.salary > avg_salary.average_salary
JOIN (
    SELECT employee_id, last_name, department_id
    FROM employees
    WHERE last_name LIKE '%n'
) AS n_employees ON e.department_id = n_employees.department_id;
-- 30. Liệt kê danh sách mã phòng ban, tên phòng ban có ít hơn 3 nhân viên.
-- Sub query
SELECT department_id, department_name FROM departments
WHERE department_id IN (
    SELECT department_id FROM employees
    GROUP BY department_id
    HAVING COUNT(*) < 3
);
-- JOIN
SELECT d.department_id, d.department_name FROM departments d
JOIN (
    SELECT department_id, COUNT(*) AS num_employees
    FROM employees
    GROUP BY department_id
) AS emp_count ON d.department_id = emp_count.department_id
WHERE emp_count.num_employees < 3;
-- 31. Cho biết phòng ban nào có đông nhân viên nhất, phòng ban nào có ít nhân viên nhất.
-- Đông nhân viên nhất
SELECT TOP 1 d.department_id, d.department_name, COUNT(*) AS num_employees 
FROM departments d JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY num_employees DESC;
-- Ít nhân viên nhất
SELECT TOP 1 d.department_id, d.department_name, COUNT(*) AS num_employees 
FROM departments d JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY num_employees ASC;
-- 32. Liệt kê thông tin 3 nhân viên có lương cao nhất
SELECT TOP 3 * FROM employees
ORDER BY salary DESC;
-- 33. Liệt kê danh sách nhân viên đang làm việc ở tiểu bang “California‟.
SELECT e.*
FROM employees e 
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id
WHERE state_province = 'California';
-- 34. Liệt kê danh sách nhân viên có mức lương thấp hơn mức lương trung bình của phòng ban mà nhân viên đó làm việc.
SELECT * FROM employees e1 
WHERE salary < (
	SELECT AVG(e2.salary) AS average_salary
	FROM employees e2 JOIN departments d ON e2.department_id = d.department_id
	WHERE e1.department_id = e2.department_id
)













