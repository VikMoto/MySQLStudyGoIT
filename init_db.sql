CREATE DATABASE megasoft;

-- ID - ідентифікатор працівника, ціле число, сурогатний первинний ключ.
-- NAME - ім'я працівника, рядок. Обмеження - не має бути NULL, довжина має бути від 2 до 1000 символів включно.
-- BIRTHDAY - дата народження. Рік у цій даті має бути більшим за 1900
-- LEVEL - рівень технічного розвитку працівника. Має бути обмеження - це поле не може бути NULL, значення поля може бути одним з - Trainee, Junior, Middle, Senior
-- SALARY - заробітна плата працівника за 1 місяць. Обмеження - ціле число, не менше 100 і не більше 100 000

CREATE TYPE level_worker AS ENUM ('Trainee', 'Junior', 'Middle', 'Senior');

CREATE TABLE worker
(
    id SERIAL PRIMARY KEY ,
    name VARCHAR(1000) NOT NULL CHECK ( LENGTH(name) >=2 AND LENGTH(name) <=1000 ),
    birthday DATE NOT NULL CHECK ( birthday > '1900-12-31'),
    level level_worker  NOT NULL ,
    salary INT CHECK ( salary >= 100 AND salary <=100000 )
);

-- - таблиця для проєктів. Мають бути наступні поля:
-- ID - ідентифікатор проєкту, ціле число, сурогатний первинний ключ.
-- CLIENT_ID - ідентифікатор клієнта, що замовив цей проєкт
-- START_DATE - дата початку виконання проєкту
-- FINISH_DATE - дата кінця виконання проєкту

CREATE TABLE project
(
    id SERIAL PRIMARY KEY ,
    client_id INT REFERENCES client (id),
    start_date DATE,
    finish_date DATE
);

--  таблиця для клієнтів. Мають бути наступні поля:
-- ID - ідентифікатор клієнта, ціле число, сурогатний первинний ключ.
-- NAME - ім'я працівника, рядок. Обмеження - не має бути NULL, довжина має бути від 2 до 1000 символів включно.

CREATE TABLE client
(
    id SERIAL PRIMARY KEY ,
    name VARCHAR(1000) NOT NULL CHECK ( LENGTH(name) >= 2 AND LENGTH(name) <= 1000 )
);

-- project_worker - таблиця, що показує, які працівники над якими проєктами працюють. Поля таблиці:
-- PROJECT_ID - ідентифікатор проєкту. Зовнішній ключ для таблиці project(id)
-- WORKER_ID - ідентифікатор клієнту. Зовнішній ключ для таблиці worker(id)
-- первинний ключ для цієї таблиці - складений, пара (PROJECT_ID, WORKER_ID)

CREATE TABLE project_worker
(
    project_id INT REFERENCES project(id),
    worker_id INT REFERENCES worker,
    PRIMARY KEY (project_id, worker_id)

);