USE labs_sql;

DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS titles;

CREATE TABLE author (
                        author_id INT PRIMARY KEY NOT NULL,
                        author_name VARCHAR (255) NOT NULL
);

CREATE TABLE titles(
                       title_name VARCHAR(255) PRIMARY KEY NOT NULL,
                       author_id INT NOT NULL,
                       word_count INT NOT NULL,
                       views INT NOT NULL,
                       FOREIGN KEY (author_id) REFERENCES author (author_id)
);

INSERT INTO author
VALUES (1, 'Maria Charlotte'),
       (2, 'Juan Perez'),
       (3, 'Gemma Alcocer');

INSERT INTO titles (title_name, author_id, word_count, views)
VALUES ('Best Paint Colors', 1, 814,14),
       ('Small Space Decorating Tips', 2, 1146,221),
       ('Hot Accessories', 1, 986,105),
       ('Mixing Textures', 1, 765,22),
       ('Kitchen Refresh', 2, 1242,307),
       ('Homemade Art Hacks', 1, 1002,193),
       ('Refinishing Wood Floors', 3, 1571,7542);


SELECT * FROM titles;

SELECT t.title_name, a.author_name
FROM titles t
         JOIN author a ON t.author_id = a.author_id;

SELECT title_name, word_count
FROM titles
WHERE word_count > 1000;

SELECT a.author_name, COUNT(*) AS total_titles
FROM author a
         JOIN titles t ON a.author_id = t.author_id
GROUP BY a.author_name
ORDER BY total_titles DESC;