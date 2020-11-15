/*Task 2
База данных "Сотрудники":
1. Выбрать среднюю зарплату по отделам.
2. Выбрать максимальную зарплату у сотрудника.
3. Удалить одного сотрудника, у которого максимальная зарплата.
4. Посчитать количество сотрудников во всех отделах.
5. Найти колтчество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
*/
-- 1. Выбрать среднюю зарплату по отделам.
/*
выводим наименование отдела (из таблицы отделы) и среднее значение по зарплате (из таблицы зарплата)
из таблицы сотрудники
склеиваем таблицу "зарплаты" по строке № сотрудника из таблицы "сотрудники"
склеиваем таблицу "отделы_сотрудники" по строке № сотрудника из таблицы "отделы_сотрудники"
склеиваем таблицу "отделы" по строке № отдела из таблицы "отделы"
ГДЕ дата_начало меньше или равна текущей дате И дата_окончания больше текущей даты
ГРУППИРУЕМ ПО наименованию отдела;
*/
SELECT 
    employees.departments.dept_name, AVG(employees.salaries)
FROM
    employees.employees
        JOIN
    employees.salaries ON employees.employees.emp_no = employees.salaries.emp_no
        JOIN
    employees.dept_emp ON employees.dept_emp.emp_no = employees.employees.emp_no
        JOIN
    employees.departments ON employees.departments.dept_no = employees.dept_no
WHERE
    employees.salaries.from_date <= CURRENT_DATE()
        AND employees.salaries.to_date > CURRENT_DATE()
GROUP BY employees.departments.dept_name;



        
