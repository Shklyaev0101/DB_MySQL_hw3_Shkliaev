/*Task 1
База данных "Страны и города мира":
1. Сделать запрос, в котором мы выберем все данные о городе - регион, страна.
2. Выбрать все города из Московской области.
*/
SELECT 
    _countries.title, _regions.title, _cities.title
FROM
    geodata._cities
        LEFT JOIN
    geodata._regions ON _cities.region_id = _regions.id
        LEFT JOIN
    geodata._countries ON _regions.country_id = _countries.id;
