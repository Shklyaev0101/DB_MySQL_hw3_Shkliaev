/*Task 2
//Выполняя задания необходимо использовать предоставленную Базу данных "Сотрудники"//
/////////////////////////////////////////////////////////////////////////////////////
*/

/*
// 1. Выбрать среднюю зарплату по отделам.//
////////////////////////////////////////////
выводим ID отдела (из таблицы отделы), наименование отдела (из таблицы отделы) и среднее значение по зарплате (из таблицы зарплата и из столбца зарплата)
из таблицы сотрудники
склеиваем таблицу "зарплаты" по строке № сотрудника из таблицы "сотрудники"
склеиваем таблицу "отделы_сотрудники" по строке № сотрудника из таблицы "отделы_сотрудники"
склеиваем таблицу "отделы" по строке № отдела из таблицы "отделы"
ГДЕ дата_начало меньше или равна текущей дате И дата_окончания больше текущей даты
ГРУППИРУЕМ ПО ID отделу и наименованию отдела;
*/
SELECT 
    employees.departments.dept_no, employees.departments.dept_name, AVG(employees.salaries.salary)
FROM
    employees.employees
        JOIN
    employees.salaries ON employees.employees.emp_no = employees.salaries.emp_no
        JOIN
    employees.dept_emp ON employees.dept_emp.emp_no = employees.employees.emp_no
        JOIN
    employees.departments ON employees.departments.dept_no = employees.dept_emp.dept_no
WHERE
    employees.salaries.from_date <= CURRENT_DATE()
        AND employees.salaries.to_date > CURRENT_DATE()
GROUP BY employees.departments.dept_no, employees.departments.dept_name;

/*
//2. Выбрать максимальную зарплату у сотрудника.//
//////////////////////////////////////////////////
выводим имя сотрудника (из таблицы отделы), фамилию сотрудника (из таблицы отделы) и максимальное значение по зарплате (из таблицы зарплата и из столбца зарплата)
из таблицы сотрудники
склеиваем таблицу "зарплаты" по строке № сотрудника из таблицы "сотрудники"
ГРУППИРУЕМ ПО ID сотрудника;
*/
SELECT 
    employees.employees.first_name,
	employees.employees.last_name,
    MAX(employees.salaries.salary)
   FROM
    employees.employees
        JOIN
    employees.salaries ON employees.employees.emp_no = employees.salaries.emp_no
GROUP BY employees.employees.emp_no;

/*
//3. Удалить одного сотрудника, у которого максимальная зарплата.//
///////////////////////////////////////////////////////////////////
Удаляем из таблицы сотрудники, где ID сотрудника равен:
выводим ID сотрудника, имя сотрудника (из таблицы отделы), фамилию сотрудника (из таблицы отделы) и максимальное значение по зарплате (из таблицы зарплата и из столбца зарплата)
из таблицы сотрудники
склеиваем таблицу "зарплаты" по строке № сотрудника из таблицы "сотрудники"
склеиваем таблицу "отделы_сотрудники" по строке № сотрудника из таблицы "отделы_сотрудники"
сортируем по максимальной зарплате;
*/
DELETE FROM employees.employees
WHERE emp_no =
(SELECT 
	employees.employees.emp_no,
    employees.employees.first_name,
    employees.employees.last_name,
    MAX(employees.salaries.salary)
FROM
    employees.employees
        JOIN
    employees.salaries ON employees.employees.emp_no = employees.salaries.emp_no
        JOIN
    employees.dept_emp ON employees.dept_emp.emp_no = employees.employees.emp_no
ORDER BY MAX(employees.salaries.salary)
);

/*
//4. Посчитать количество сотрудников во всех отделах.//
////////////////////////////////////////////////////////

*/        
SELECT 
    employees.dept_emp.dept_no, COUNT(dept_no)
FROM
    employees.dept_emp
WHERE
    employees.dept_emp.from_date <= CURRENT_DATE()
        AND employees.dept_emp.to_date > CURRENT_DATE()
GROUP BY employees.dept_emp.dept_no;

/*
//5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.//
///////////////////////////////////////////////////////////////////////////////////////////////

*/
SELECT 
    employees.dept_emp.dept_no, COUNT(employees.dept_emp.emp_no), SUM(employees.salaries.salary)
FROM
    employees.salaries
        JOIN
    employees.dept_emp ON employees.dept_emp.emp_no = employees.salaries.emp_no
        JOIN
    employees.departments ON employees.departments.dept_no = employees.dept_emp.dept_no
WHERE
    employees.dept_emp.from_date <= CURRENT_DATE()
        AND employees.dept_emp.to_date > CURRENT_DATE()
GROUP BY employees.departments.dept_no;