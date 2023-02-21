-- Task 3
-- Створи файл find_max_salary_worker.sql. У ньому напиши SQL, який виведе працівника з найбільшою заробітною платою.
-- Якщо таких працівників декілька - потрібно вивести всіх.

SELECT name,
       salary
FROM worker
WHERE salary = (SELECT max(salary) FROM worker);
