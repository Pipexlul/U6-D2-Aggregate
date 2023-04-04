-- Create database
CREATE DATABASE "desafio2-Felipe-Guajardo-117";

-- Connect to database
\c "desafio2-Felipe-Guajardo-117"

-- Create table and insert test data
CREATE TABLE IF NOT EXISTS inscritos (cantidad INT, fecha DATE, fuente VARCHAR);
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO inscritos (cantidad, fecha, fuente) VALUES ( 99, '01/08/2021', 'Página' );

-- Bonus: Modify table to add a primary key serial column
ALTER TABLE inscritos ADD COLUMN id SERIAL PRIMARY KEY;

-- Consulta 1: ¿Cuantos registros hay?
SELECT COUNT(*) AS total_registros FROM inscritos;

-- Consulta 2: ¿Cuantos inscritos hay en total?
SELECT SUM(cantidad) AS total_inscritos FROM inscritos;

-- Consulta 3: ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT * FROM inscritos WHERE (fecha = (SELECT MIN(fecha) FROM inscritos));

-- Consulta 4: ¿Cuántos inscritos hay por día? Pequeño bonus de ordenar por fecha en order ascendente para que los datos fueran mas ordenados
SELECT fecha, SUM(cantidad) AS total_inscritos FROM inscritos GROUP BY fecha ORDER BY fecha ASC;

-- Consulta 5: ¿Cuántos inscritos hay por fuente?
SELECT fuente, SUM(cantidad) AS total_inscritos FROM inscritos GROUP BY fuente;

-- Consulta 6: ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?
SELECT fecha, SUM(cantidad) AS total_inscritos FROM inscritos GROUP BY fecha ORDER BY total_inscritos DESC LIMIT 1;

-- Consulta 7: ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas personas fueron?
SELECT fecha, fuente, SUM(cantidad) AS total_inscritos_blog FROM inscritos WHERE (fuente = 'Blog') GROUP BY fecha, fuente ORDER BY total_inscritos_blog DESC LIMIT 1;

-- Consulta 8: ¿Cuántas personas en promedio se inscriben en un día?
SELECT ROUND(AVG(inscritos_por_dia), 2) AS promedio_inscritos_por_dia FROM (SELECT fecha, SUM(cantidad) AS inscritos_por_dia FROM inscritos GROUP BY fecha) AS inscritos_diarios; 

-- Consulta 9: ¿Qué días se inscribieron más de 50 personas?
SELECT fecha, SUM(cantidad) AS total_inscritos FROM inscritos GROUP BY fecha HAVING (SUM(cantidad) > 50);

-- Consulta 10: ¿Cuántas personas se registraron en promedio cada día a partir del tercer día?
SELECT ROUND(AVG(inscritos_por_dia), 2) AS promedio_inscritos_por_dia FROM (SELECT fecha, SUM(cantidad) AS inscritos_por_dia FROM inscritos WHERE (fecha >= '2021-01-03') GROUP BY fecha) AS inscritos_diarios;

-- Exit psql
\q