
# Скрипт создания и наполнения БД.
DROP DATABASE IF EXISTS katatest;
CREATE DATABASE katatest;
use katatest;

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    id         bigint not null auto_increment,
    email      varchar(255),
    name       varchar(255),
    password   varchar(255),
    surname    varchar(255),
    username   varchar(255) unique,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    is_deleted bit(1),
    primary key (id)

) COMMENT 'юзеры';

CREATE TABLE roles
(
    id   bigint not null auto_increment,
    name varchar(255),
    primary key (id)
) COMMENT 'роли'
;
CREATE TABLE users_roles
(
    user_id bigint not null,
    role_id bigint not null,
    primary key (user_id, role_id),
    FOREIGN KEY (role_id) REFERENCES roles (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
) COMMENT 'роли'
;
-- admin@mail.ru pass - 101, user@mail.ru pass - 101. Ниже можно инжектить и все заработает.
INSERT INTO katatest.users (email, name, surname, password, username)
VALUES ('admin@mail.ru', 'admin', 'admin@mail.ru', '$2a$12$dohLOIX7xj0pSF294.dkf.u0D1/Rv7N6232W2vlhNy4TqThJ6Zt16', 'admin');

INSERT INTO katatest.users (email, name, surname, password, username)
VALUES ('user@mail.ru', 'user', 'user@mail.ru', '$2a$12$dohLOIX7xj0pSF294.dkf.u0D1/Rv7N6232W2vlhNy4TqThJ6Zt16', 'user');

INSERT INTO katatest.roles (id, name) VALUE (1,'ROLE_ADMIN');
INSERT INTO katatest.roles (id, name) VALUE (2,'ROLE_USER');

INSERT INTO katatest.users_roles (user_id, role_id)
VALUES (1, 1);

INSERT INTO katatest.users_roles (user_id, role_id)
VALUES (1, 2);

INSERT INTO katatest.users_roles (user_id, role_id)
VALUES (2, 1);