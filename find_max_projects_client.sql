-- Task 4
-- Створи файл find_max_projects_client.sql. У ньому напиши SQL, який виведе клієнта з
-- найбільшою кількістю проєктів. Якщо таких клієнтів декілька - потрібно вивести всіх.





SELECT nameCl c_lient,
       cl.cnt client_max
FROM (SELECT (SELECT name FROM client WHERE id = p.client_id) nameCl,
                count(*) cnt
         FROM project p
         GROUP BY client_id) cl
WHERE  cnt = (SELECT max(cnt) FROM (SELECT client_id,
                                           count(*) cnt
                                    FROM project p
                                    GROUP BY client_id) cll)
GROUP BY nameCl,cl.cnt;



SELECT c.name c_lient,
       count(*) client_max
FROM project
         INNER JOIN client c
                    ON project.client_id = c.id
GROUP BY c.name
HAVING count(*) = (
    SELECT max(p_c)
    FROM (   SELECT c.id,
                    count(*) AS p_c
             FROM project
                      INNER JOIN client c
                                 ON project.client_id = c.id
             GROUP BY c.id
         ) cts
    );
