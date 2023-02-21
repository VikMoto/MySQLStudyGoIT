-- Task 6
-- Створи файл find_youngest_eldest_workers.sql. У ньому напиши SQL, який вибере наймолодшого
-- та найстаршого працівників, та виведе їх у форматі таблиці з наступними полями:
--
-- TYPE - тип (може бути YOUNGEST або OLDEST)
-- NAME - ім'я працівника
-- BIRTHDAY - дата народження працівника
-- Якщо є декілька наймолодших/найстарших працівників - то необхідно вивести їх всіх.
--
-- Приклад таблиці:
--
-- TYPE	NAME	BIRTHDAY
-- YOUNGEST	John Doe	2000-01-07
-- YOUNGEST	John Doe	2000-01-07
-- ELDEST	Maxim	1980-06-17

SELECT
    CASE
        WHEN age(birthday) = (SELECT max(age(birthday)) FROM worker) THEN 'OLDEST'
        WHEN age(birthday) = (SELECT min(age(birthday)) FROM worker) THEN 'YOUNGEST'
        ELSE ''
    END AS TYPE,
    name,
    birthday

FROM worker
WHERE age(birthday) = (SELECT max(age(birthday)) FROM worker) OR
      age(birthday) = (SELECT min(age(birthday)) FROM worker)
ORDER BY TYPE
;