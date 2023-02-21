Створи файл print_project_prices.sql. У ньому напиши SQL, який виведе список проєктів та вартість кожного проєкту.

Вартість проєкту - це сума заробітних плат працівників, що працюють над цим проєктом, помножених на тривалість у місяцях проєкту.

Наприклад, над проєктом Project A працюють працівники Max (заробітна плата 1000) та Joe (заробітна плата 1500). Проєкт триває 17 місяців. Тоді вартість проєкту Project A = 17 * (1000 + 1500) = 42500

Відсортуй проєкти по спаданню - спочатку виведи найдорожчі проєкти.

Приклад таблиці:

NAME	PRICE
Project A	42500
Project B	18000


WITH tempTable(client_name, pr_id, costing) AS
         (SELECT c.name,
                 p.id,
                 w.id,
                 w.name,
                 w.salary,
                 (date_part('year', finish_date::date) - date_part('year', start_date::date)) * 12 +
                 (date_part('month', finish_date::date) - date_part('month', start_date::date)) AS interval_month

          FROM project AS p
                   JOIN client AS c on c.id = p.client_id
                   JOIN project_worker pw ON p.id = pw.project_id
                   JOIN worker w ON pw.worker_id = w.id)

SELECT client_name,
       pr_id,
       salary,
       interval_month,
       salary * interval_month                                AS PRICE,
       count(pr_id) OVER (PARTITION BY pr_id),
       sum(salary * interval_month) OVER (PARTITION BY pr_id),
       count(pr_id) OVER (PARTITION BY pr_id) *
       sum(salary * interval_month) OVER (PARTITION BY pr_id) AS TOTAL


FROM tempTable;