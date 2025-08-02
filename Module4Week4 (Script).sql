-- Modulo 4 - Semana 2
-- Creacion de database
SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS module4week2;
USE module4week2;


-- Creacion de tablas
-- Tabla padre cursos
CREATE TABLE cursos (
id_curso INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
nombre_curso VARCHAR(50) NOT NULL, 
codigo VARCHAR(20) UNIQUE NOT NULL 
);

-- Tablas conectadas a cursos
CREATE TABLE creditos ( 
id_credito INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
creditos INT NOT NULL, 
id_curso INT, FOREIGN KEY (id_curso) REFERENCES cursos(id_curso) 
);

CREATE TABLE semestres ( 
id_semestre INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
semestre VARCHAR(10) NOT NULL
);

CREATE TABLE curso_semestre ( 
id_curso_semestre INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
id_curso INT, id_semestre INT, FOREIGN KEY (id_curso) REFERENCES cursos (id_curso), 
FOREIGN KEY (id_semestre) REFERENCES semestres (id_semestre) 
);

CREATE TABLE fecha_inicio_semestre ( 
id_fecha_inicio INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
fecha_inicio DATE NOT NULL, 
id_semestre INT, 
FOREIGN KEY (id_semestre) REFERENCES semestres (id_semestre) 
);

CREATE TABLE fecha_fin_semestre ( 
id_fecha_fin INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
fecha_fin DATE NOT NULL, 
id_semestre INT, 
FOREIGN KEY (id_semestre) REFERENCES semestres (id_semestre) 
);


-- Tabla dija docentes
CREATE TABLE docentes ( 
id_docente INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
nombre1 VARCHAR(30) NOT NULL, 
nombre2 VARCHAR(30), 
apellido1 VARCHAR(30) NOT NULL, 
apellido2 VARCHAR(30) NOT NULL, 
id_curso INT, 
FOREIGN KEY (id_curso) REFERENCES cursos (id_curso) 
);

-- Tablas conectadas a docentes
CREATE TABLE correos_docentes ( 
id_correo_docente INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
correo VARCHAR(50) UNIQUE NOT NULL, 
id_docente INT, 
FOREIGN KEY (id_docente) REFERENCES docentes (id_docente) 
);

CREATE TABLE años_de_experiencia ( 
id_años_de_experiencia INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
años_experiencia INT, 
id_docente INT, 
FOREIGN KEY (id_docente) REFERENCES docentes (id_docente) 
);

CREATE TABLE facultades ( 
id_facultad INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
facultad VARCHAR(100) NOT NULL 
);

CREATE TABLE docente_facultad ( 
id_docente_facultad INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
id_docente INT, 
id_facultad INT, 
FOREIGN KEY (id_docente) REFERENCES docentes (id_docente), 
FOREIGN KEY (id_facultad) REFERENCES facultades (id_facultad) 
);


-- Tabla hija estudiantes
CREATE TABLE estudiantes ( 
id_estudiante INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
nombre1 VARCHAR(30) NOT NULL, 
nombre2 VARCHAR(30), 
apellido1 VARCHAR(30) NOT NULL, 
apellido2 VARCHAR(30) NOT NULL 
);

-- Tablas conectadas a estudiantes
CREATE TABLE correos_estudiantes ( 
id_correo_estudiante INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
correo VARCHAR(50) UNIQUE NOT NULL, 
id_estudiante INT, 
FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante) 
);

CREATE TABLE generos ( 
id_genero INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
genero ENUM('Hombre', 'Mujer') NOT NULL, 
id_estudiante INT, FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante) 
);

CREATE TABLE identificaciones ( 
id_identificacion INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
identificacion INT UNIQUE NOT NULL, 
id_estudiante INT, 
FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante) 
);

CREATE TABLE tipo_identificacion ( 
id_tipo_identificacion INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
tipo_de_documento ENUM('TI', 'CC') NOT NULL, 
id_identificacion INT, 
FOREIGN KEY (id_identificacion) REFERENCES identificaciones (id_identificacion) 
);

CREATE TABLE carreras ( 
id_carrera INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
carrera VARCHAR(75) NOT NULL 
);

CREATE TABLE estudiante_carrera ( 
id_estudiante INT, 
id_carrera INT, 
FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante), 
FOREIGN KEY (id_carrera) REFERENCES carreras (id_carrera) 
);

CREATE TABLE fecha_de_nacimiento ( 
id_fecha_de_nacimiento INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
fecha_de_nacimiento DATE NOT NULL, 
id_estudiante INT, 
FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante) 
);

CREATE TABLE fechas_de_ingreso ( 
id_fecha_de_ingreso INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
fecha_de_ingreso DATE NOT NULL, 
id_estudiante INT, 
FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante) 
);


-- Tabla hija inscripciones
CREATE TABLE inscripciones ( 
id_inscripcion INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
id_estudiante INT, 
id_curso INT, 
FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante), 
FOREIGN KEY (id_curso) REFERENCES cursos (id_curso) 
);

-- Tablas conectadas a inscripciones
CREATE TABLE fecha_de_incripcion ( 
id_fecha_inscripcion INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
fecha_inscripcion DATE NOT NULL, id_inscripcion INT, 
FOREIGN KEY (id_inscripcion) REFERENCES inscripciones (id_inscripcion) 
);

CREATE TABLE calificaciones_finales ( 
id_calificacion_final INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
calificacion_final INT, 
id_inscripcion INT, 
FOREIGN KEY (id_inscripcion) REFERENCES inscripciones (id_inscripcion) 
);


-- Insert de datos a las tablas
-- Tabla padre cursos
INSERT INTO cursos (nombre_curso, codigo) VALUES
('Programación en Python', 'PRG-PYT-101'),
('Programación en Java', 'PRG-JAV-102'),
('Desarrollo Web con JavaScript', 'PRG-JS-103'),
('Bases de Datos con SQL', 'PRG-SQL-104');

-- Conexión con cursos
INSERT INTO creditos (creditos, id_curso) VALUES
(3, 1),
(4, 2),
(3, 3),
(2, 4);

INSERT INTO semestres (semestre) VALUES
('2024-1'),
('2024-2');

INSERT INTO curso_semestre (id_curso, id_semestre) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2);

INSERT INTO fecha_inicio_semestre (fecha_inicio, id_semestre) VALUES
('2024-01-20', 1),
('2024-07-15', 2);

INSERT INTO fecha_fin_semestre (fecha_fin, id_semestre) VALUES
('2024-06-10', 1),
('2024-12-05', 2);


-- Tabla hija docentes
INSERT INTO docentes (nombre1, nombre2, apellido1, apellido2, id_curso) VALUES
('Laura', 'Marcela', 'Rojas', 'Gómez', 1),
('Pedro', NULL, 'López', 'Martínez', 2),
('Sofía', 'Andrea', 'Vargas', 'Quintero', 3);

-- Conexión con docentes
INSERT INTO correos_docentes (correo, id_docente) VALUES
('laura.rojas@uni.edu', 1),
('pedro.lopez@uni.edu', 2),
('sofia.vargas@uni.edu', 3);

INSERT INTO años_de_experiencia (años_experiencia, id_docente) VALUES
(8, 1),
(12, 2),
(5, 3);

INSERT INTO facultades (facultad) VALUES
('Facultad de Ingeniería y Tecnología');

INSERT INTO docente_facultad (id_docente, id_facultad) VALUES
(1, 1),
(2, 1),
(3, 1);


-- Tabla hija estudiantes
INSERT INTO estudiantes (nombre1, nombre2, apellido1, apellido2) VALUES
('Carlos', 'Andrés', 'Martínez', 'López'),
('María', 'Fernanda', 'Gómez', 'Pérez'),
('Juan', NULL, 'Torres', 'Ramírez'),
('Luisa', 'Mariana', 'Castaño', 'Rodríguez'),
('Andrés', 'Felipe', 'Mora', 'García');

-- Conexión con estudiantes
INSERT INTO correos_estudiantes (correo, id_estudiante) VALUES
('carlos.martinez@correo.com', 1),
('maria.gomez@correo.com', 2),
('juan.torres@correo.com', 3),
('luisa.castaño@correo.com', 4),
('andres.mora@correo.com', 5);

INSERT INTO generos (genero, id_estudiante) VALUES
('Hombre', 1),
('Mujer', 2),
('Hombre', 3),
('Mujer', 4),
('Hombre', 5);

INSERT INTO identificaciones (identificacion, id_estudiante) VALUES
(1001, 1),
(1002, 2),
(1003, 3),
(1004, 4),
(1005, 5);

INSERT INTO tipo_identificacion (tipo_de_documento, id_identificacion) VALUES
('CC', 1),
('CC', 2),
('TI', 3),
('TI', 4),
('CC', 5);

INSERT INTO carreras (carrera) VALUES
('Ingeniería en Sistemas'),
('Ingeniería de Software'),
('Tecnología en Desarrollo de Software');

INSERT INTO estudiante_carrera (id_estudiante, id_carrera) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 2);

INSERT INTO fecha_de_nacimiento (fecha_de_nacimiento, id_estudiante) VALUES
('2000-04-15', 1),
('2001-06-20', 2),
('2002-01-10', 3),
('2003-09-12', 4),
('2000-12-05', 5);

INSERT INTO fechas_de_ingreso (fecha_de_ingreso, id_estudiante) VALUES
('2020-01-20', 1),
('2021-02-15', 2),
('2021-02-15', 3),
('2022-01-10', 4),
('2020-08-01', 5);


-- Tabla hija inscripciones
INSERT INTO inscripciones (id_estudiante, id_curso) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4),
(3, 1),
(3, 2),
(4, 3),
(5, 4);

-- Conexión con inscripciones
INSERT INTO fecha_de_incripcion (fecha_inscripcion, id_inscripcion) VALUES
('2024-01-15', 1),
('2024-07-10', 2),
('2024-01-18', 3),
('2024-07-12', 4),
('2024-01-19', 5),
('2024-01-20', 6),
('2024-07-13', 7),
('2024-07-14', 8);

INSERT INTO calificaciones_finales (calificacion_final, id_inscripcion) VALUES
(85, 1),
(90, 2),
(78, 3),
(88, 4),
(80, 5),
(75, 6),
(92, 7),
(89, 8);


-- Visualización de las tablas:
-- 1. Cursos
SELECT * FROM cursos;

-- 2. Créditos
SELECT * FROM creditos;

-- 3. Semestres
SELECT * FROM semestres;

-- 4. Curso-Semestre
SELECT * FROM curso_semestre;

-- 5. Fecha de inicio del semestre
SELECT * FROM fecha_inicio_semestre;

-- 6. Fecha de fin del semestre
SELECT * FROM fecha_fin_semestre;

-- 7. Docentes
SELECT * FROM docentes;

-- 8. Correos de docentes
SELECT * FROM correos_docentes;

-- 9. Años de experiencia de docentes
SELECT * FROM años_de_experiencia;

-- 10. Facultades
SELECT * FROM facultades;

-- 11. Relación docente-facultad
SELECT * FROM docente_facultad;

-- 12. Estudiantes
SELECT * FROM estudiantes;

-- 13. Correos de estudiantes
SELECT * FROM correos_estudiantes;

-- 14. Géneros
SELECT * FROM generos;

-- 15. Identificaciones
SELECT * FROM identificaciones;

-- 16. Tipo de identificación
SELECT * FROM tipo_identificacion;

-- 17. Carreras
SELECT * FROM carreras;

-- 18. Relación estudiante-carrera
SELECT * FROM estudiante_carrera;

-- 19. Fecha de nacimiento de estudiantes
SELECT * FROM fecha_de_nacimiento;

-- 20. Fecha de ingreso de estudiantes
SELECT * FROM fechas_de_ingreso;

-- 21. Inscripciones
SELECT * FROM inscripciones;

-- 22 Fecha de inscripción
SELECT * FROM fecha_de_incripcion;

-- 23 Calificaciones finales
SELECT * FROM calificaciones_finales;


-- Ejecuciones:
-- 1. Obtener los estudiantes con promedio superior al general
-- Primero saco el promedio general
SELECT ROUND(AVG(calificacion_final), 0) AS promedio_general
FROM calificaciones_finales; -- El promedio redondeado es de 85

-- Vista del promedio mayor a 85
CREATE VIEW promedio_mayor_a_85 AS
-- Ahora el promedio por estudiante mayor a 85
SELECT
e.id_estudiante, e.nombre1, e.apellido1, e.apellido2,
ROUND(AVG(calificacion_final), 0) AS promedio_estudiante
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN calificaciones_finales cF ON i.id_inscripcion = cF.id_inscripcion
GROUP BY e.id_estudiante
HAVING promedio_estudiante >= 85
ORDER BY promedio_estudiante DESC;

-- Vista
SELECT * FROM promedio_mayor_a_85;



-- 2. Calcular promedios y sumatorias utilizando funciones de agregación como AVG(), SUM(), COUNT(), MAX() y MIN().
-- Ya use AVG para los promedio por estudiantes y general
-- SUM() Para saber el total de totas las calificaciones
SELECT SUM(calificacion_final) AS suma_total_calificaciones
FROM calificaciones_finales;

-- COUNT() Para ver el total de estudiantes registrados
SELECT COUNT(*) AS total_estudiantes
FROM estudiantes;

-- Vista del estudiante con la nota mas alta
CREATE VIEW estudiante_nota_mas_alta AS
-- MAX() Para calificación mas alta por algún estudiante
SELECT 
e.id_estudiante, e.nombre1, e.apellido1, e.apellido2,
c.nombre_curso,
cF.calificacion_final
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN cursos c ON c.id_curso = i.id_curso
JOIN calificaciones_finales cF ON i.id_inscripcion = cF.id_inscripcion
WHERE cF.calificacion_final = (
	SELECT MAX(calificacion_final)
    FROM calificaciones_finales
    );

-- Vista
SELECT * FROM estudiante_nota_mas_alta;


-- Vista del estudiante con la nota mas baja
CREATE VIEW estudiante_nota_mas_baja AS
-- MIN() Para calificación mas baja por algún estudiante
SELECT 
e.id_estudiante, e.nombre1, e.apellido1, e.apellido2,
c.nombre_curso,
cF.calificacion_final
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN cursos c ON c.id_curso = i.id_curso
JOIN calificaciones_finales cF ON i.id_inscripcion = cF.id_inscripcion
WHERE cF.calificacion_final = (
	SELECT MIN(calificacion_final)
    FROM calificaciones_finales
    );

-- Vista
SELECT * FROM estudiante_nota_mas_baja;



-- 3.  Usar cláusulas como WHERE, ORDER BY, BETWEEN, IN, LIKE e IS NULL para refinar las búsquedas.
-- Ya use tanto WHERE como ORDER BY, asi que aqui solo utilizare las otra que no he usado

-- Vista de estudiantes con nota entre 80 y 90
CREATE VIEW estudiantes_nota_80_a_90 AS
-- BETWEEM para saber estudiantes con notas entre 80 y 90
SELECT 
e.id_estudiante, e.nombre1, e.apellido1, 
c.nombre_curso,
cF.calificacion_final
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN cursos c ON c.id_curso = i.id_curso
JOIN calificaciones_finales cF ON i.id_inscripcion = cF.id_inscripcion
WHERE cf.calificacion_final BETWEEN 80 AND 90;

-- Vista
SELECT * FROM estudiantes_nota_80_a_90;


-- Vista de estudiantes en Java
CREATE VIEW estudiantes_en_java AS
-- IN para ver estudiantes en Java
SELECT 
e.id_estudiante, e.nombre1, e.apellido1, e.apellido2, 
c.nombre_curso
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
WHERE c.nombre_curso IN ('Programacion en Java');

-- Vista
SELECT * FROM estudiantes_en_java;


-- LIKE para buscar nombres con 'S' en docentes
SELECT
id_docente, nombre1, apellido1, apellido2
FROM docentes
WHERE nombre1 LIKE 'S%';

-- IS NULL para ver que estudiantes y docenten no tiene apellido
SELECT id_estudiante, nombre1, nombre2, apellido1, apellido2 
FROM estudiantes
WHERE nombre2 IS NULL;

SELECT id_docente, nombre1, nombre2, apellido1, apellido2
FROM docentes
WHERE nombre2 IS NULL;


-- 4. Agrupar datos por carrera o curso utilizando GROUP BY y filtrar los resultados con HAVING.
-- Vista para ver estudiantes por carreara
CREATE VIEW estudiantes_por_carrera AS
SELECT 
ca.id_carrera, ca.carrera,
COUNT(eC.id_estudiante) AS cantidad_estudiantes
FROM carreras ca
JOIN estudiante_carrera eC ON ca.id_carrera = eC.id_carrera
GROUP BY ca.id_carrera
HAVING cantidad_estudiantes >= 1;

-- Vista
SELECT * FROM estudiantes_por_carrera;



-- 5. Crear subconsultas para filtrar información con base en otras consultas.
-- Subconsulta para ver a los estudiantes en python
-- Vista para ver los estudiantes de Python
CREATE VIEW estudiantes_de_python AS
SELECT 
e.id_estudiante, e.nombre1, e.apellido1, e.apellido2
FROM estudiantes e
WHERE e.id_estudiante IN (
    SELECT i.id_estudiante
    FROM inscripciones i
    JOIN cursos c ON i.id_curso = c.id_curso
    WHERE c.nombre_curso = 'Programación en Python'
);

-- Vista
SELECT * FROM estudiantes_de_python;


-- 6. Utilizar JOINs para combinar la información de estudiantes, docentes, cursos e inscripciones.
-- Vista para acceder rapido a esta informacion
CREATE VIEW estudiantes_cursos_docentes AS
SELECT
e.nombre1 AS nombre_estudiante, e.apellido1 AS apellido1_estudiante, e.apellido2 AS apellido2_estudiante,
c.nombre_curso,
d.nombre1 AS nombre_docente, d.apellido1 AS apellido1_docente, d.apellido2 AS apellido2_docente
FROM estudiantes e
JOIN inscripciones i ON e.id_estudiante = i.id_estudiante
JOIN cursos c ON i.id_curso = c.id_curso
JOIN docentes d ON c.id_curso = d.id_curso;

-- Vista
SELECT * FROM estudiantes_cursos_docentes;