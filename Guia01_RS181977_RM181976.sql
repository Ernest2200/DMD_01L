-- Guia 1 DMD 01L

--           Nombre                      Carnet
-- Carlos Jose Ruiz Saz					RS181977
-- Patrick Ernesto Rosales Mendoza      RM181976

 
-- I) Creacion de la base de datos

USE master
GO




CREATE DATABASE Control_de_libros_RS181977_RM181976 
GO

USE Control_de_libros_RS181977_RM181976 
GO

CREATE TABLE Libro(
Codigo varchar(4) NOT NULL,
Titulo VARCHAR(50) NOT NULL,
ISBN VARCHAR(20) NOT NULL,
Descripcion varchar(50),
Resumen varchar(60),
Año_edicion varchar(4) NOT NULL,
Cod_editorial varchar(4) NOT NULL,
--Restricciones
CONSTRAINT PK_Libro PRIMARY KEY(Codigo),
CONSTRAINT FK_Libro_Editorial FOREIGN KEY(Cod_editorial) REFERENCES Editorial(Codigo),
)


CREATE TABLE Editorial(
Codigo varchar(4) NOT NULL,
Nombre VARCHAR(50) NOT NULL,
Pais VARCHAR(20)NOT NULL,
--Restricciones
CONSTRAINT PK_Editorial PRIMARY KEY(Codigo)
)


CREATE TABLE Autor(
Codigo varchar(4) NOT NULL,
Nombres VARCHAR(20) NOT NULL,
Apellidos VARCHAR(20) NOT NULL,
Nacionalidad VARCHAR(20) NOT NULL,
--Restricciones
CONSTRAINT PK_Autor PRIMARY KEY(Codigo)
)

CREATE TABLE Ejemplar(
Cod_libro varchar(4) NOT NULL,
Ubicacion varchar(10) NOT NULL,
Estado varchar(20) Not null,
--Restricciones
CONSTRAINT FK_Ejemplar_Libro FOREIGN KEY(Cod_libro) REFERENCES Libro(Codigo),
)

CREATE TABLE Autor_Libro(
Cod_libro varchar(4) NOT NULL,
Cod_autor varchar(4) NOT NULL,
--restricciones
CONSTRAINT FK_Autor_Libro_Libro FOREIGN KEY(Cod_libro) REFERENCES Libro(Codigo),
CONSTRAINT FK_Autor_Libro_Autor FOREIGN KEY(Cod_Autor) REFERENCES Autor(Codigo),
)


INSERT INTO Editorial VALUES
('ED01','Thomson internacional','España'),
('ED02','Omega','Mexico'),
('ED03','La fuente de la sabiduria ','Colombia'),
('ED04','Siglo XV','España')



INSERT INTO Autor VALUES
('AU01','JOSE PEDRO','ALVARAO','ESPAÑOLA'),
('AU02','MARIA TERESA','RIVAS','MEXICANO'),
('AU03','JULIO CARLOS','FERNANDEZ','COLOMBIANO'),
('AU04','ALEXANDER','RODRIGUEZ','MEXICANO'),
('AU05','JUAN MANUEL','ARTIGA','COLOMBIANO')


INSERT INTO Ejemplar VALUES
('LB01','Estante 1','Prestado'),
('LB02','Estante 2','Disponible'),
('LB02','Estante 2','Reservado'),
('LB03','Estante 3','Prestado'),
('LB04','Estante 4','Disponible'),
('LB02','Estante 2','Reservado'),
('LB04','Estante 4','Prestado'),
('LB01','Estante 1','Disponible'),
('LB02','Estante 2','Reservado'),
('LB03','Estante 3','Prestado'),
('LB01','Estante 1','Disponible'),
('LB05','Estante 5','Disponible'),
('LB06','Estante 5','Prestado'),
('LB06','Estante 5','Disponible')

INSERT INTO Autor_Libro VALUES
('LB01','AU02'),
('LB01','AU04'),
('LB02','AU01'),
('LB03','AU05'),
('LB03','AU03'),
('LB04','AU02'),
('LB04','AU04')


INSERT INTO Libro VALUES
('LB01','Metodologia de la programacion','123-335-456','Sintaxis basicas de la programacion','204 paginas','2000','ED02'),
('LB02','SQL Server 2005','345-678-076','Explicacion de las consultas SQL','798 paginas','2005','ED03'),
('LB03','Como programar en C/C++','153-567-345','Diferencias entre c y c++','156 paginas','1997','ED02'),
('LB04','Aprender PHP en 30 dias','234-345-987','Sintaxis PHP para crear paginas web dinamicas','200 paginas','2005','ED01'),
('LB05','SQL Server 2008','789-255-487','Administracion de base de datos','150 paginas','2008','ED03'),
('LB06','CSS y HTML','652-414-111','Creacion de paginas web y hojas de estilo','350 paginas','2007','ED01')

 
-- II) Crear las siguientes consultas SQL: 

--a.Se desea mostrar los datos de los autores junto con los títulos de libros que han escrito.
--Ordenarlos en forma descendente por el nombre del autor.

SELECT a.Codigo,a.Nombres,a.Apellidos,a.Nacionalidad,al.Cod_libro,l.Titulo
FROM Autor a
INNER JOIN Autor_Libro al ON a.Codigo = al.Cod_autor
INNER JOIN Libro l ON l.Codigo = al.Cod_libro

--b. Se desea conocer todos los autores que tienen libros que han sido publicados por la
--editorial 'Omega'.
SELECT a.Codigo,a.Nombres,a.Apellidos,a.Nacionalidad,al.Cod_libro,l.Titulo,l.Cod_editorial
FROM Autor a
INNER JOIN Autor_Libro al ON a.Codigo = al.Cod_autor
INNER JOIN Libro l ON l.Codigo = al.Cod_libro
Where l.Cod_editorial = 'ED02'

--c. Mostrar cuántos ejemplares hay por cada libro. Titulo, ejemplar
select l.Titulo,COUNT(e.Cod_libro) as ' # Ejemplares'
from Libro l
inner join Ejemplar e on l.Codigo =e.Cod_libro
group by l.Titulo
--d. Mostrar los títulos de los libros donde el estado sea Prestado.

SELECT l.Titulo,e.Estado
FROM Libro l
INNER JOIN Ejemplar e
ON l.Codigo = e.Cod_libro
Where e.Estado = 'Prestado'

--e. Se desea mostrar los libros que se han editados entre el 2000 y 2007. Ordenarlos en
--forma ascendente
SELECT *
FROM Libro
WHERE Año_edicion BETWEEN '2000' AND '2007'
order by Año_edicion asc

--f. Mostrar cuántos libros que se han prestado y agruparlos por el estante
select e.Ubicacion,COUNT(e.Cod_libro) as 'Ejemplares'
from Libro l
inner join Ejemplar e on l.Codigo =e.Cod_libro
where e.Estado='Prestado'
group by e.Ubicacion
union all
SELECT '# libros prestados' name, COUNT(Cod_libro) FROM ejemplar
where Estado='Prestado'


