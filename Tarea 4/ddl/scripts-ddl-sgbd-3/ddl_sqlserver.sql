-- Script DDL en SQL Server
-- Red Social Estudiantil Pascualina

CREATE DATABASE RedSocialPascualina;
GO
USE RedSocialPascualina;
GO

CREATE TABLE USUARIO (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    correo_inst VARCHAR(120) NOT NULL,
    password VARCHAR(255) NOT NULL,
    fecha_registro DATETIME
);

CREATE TABLE PERFIL_ACAD (
    id_perfil INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    programa VARCHAR(100) NOT NULL,
    semestre TINYINT NOT NULL,
    biografia VARCHAR(MAX),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE HABILIDAD (
    id_habilidad INT IDENTITY(1,1) PRIMARY KEY,
    nombre_hab VARCHAR(80) NOT NULL
);

CREATE TABLE USUARIO_HABILIDAD (
    id_usuario INT NOT NULL,
    id_habilidad INT NOT NULL,
    nivel_dominio VARCHAR(30),
    PRIMARY KEY (id_usuario, id_habilidad),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_habilidad) REFERENCES HABILIDAD(id_habilidad)
);

CREATE TABLE SEGUIDOR (
    id_seguidor INT NOT NULL,
    id_seguido INT NOT NULL,
    fecha_inicio DATETIME,
    PRIMARY KEY (id_seguidor, id_seguido),
    FOREIGN KEY (id_seguidor) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_seguido) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE POST (
    id_post INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    contenido VARCHAR(MAX) NOT NULL,
    categoria VARCHAR(50),
    fecha_post DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE COMENTARIO (
    id_comentario INT IDENTITY(1,1) PRIMARY KEY,
    id_post INT NOT NULL,
    id_usuario INT NOT NULL,
    texto VARCHAR(MAX) NOT NULL,
    fecha_coment DATETIME,
    FOREIGN KEY (id_post) REFERENCES POST(id_post),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE INTERACCION (
    id_interaccion INT IDENTITY(1,1) PRIMARY KEY,
    id_post INT NOT NULL,
    id_usuario INT NOT NULL,
    tipo_reaccion VARCHAR(30),
    FOREIGN KEY (id_post) REFERENCES POST(id_post),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE GRUPO (
    id_grupo INT IDENTITY(1,1) PRIMARY KEY,
    id_creador INT NOT NULL,
    nombre_grupo VARCHAR(100) NOT NULL,
    tematica VARCHAR(80),
    FOREIGN KEY (id_creador) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE USUARIO_GRUPO (
    id_usuario INT NOT NULL,
    id_grupo INT NOT NULL,
    rol_usuario VARCHAR(30),
    PRIMARY KEY (id_usuario, id_grupo),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_grupo) REFERENCES GRUPO(id_grupo)
);

-- En SQL Server el JSON se guarda en un campo NVARCHAR(MAX)
CREATE TABLE EVENTO (
    id_evento INT IDENTITY(1,1) PRIMARY KEY,
    id_grupo INT NOT NULL,
    titulo VARCHAR(120) NOT NULL,
    fecha_evento DATETIME,
    ubicacion VARCHAR(150),
    coordenadas NVARCHAR(MAX),
    FOREIGN KEY (id_grupo) REFERENCES GRUPO(id_grupo)
);

CREATE TABLE ASISTENCIA (
    id_usuario INT NOT NULL,
    id_evento INT NOT NULL,
    estado_asistencia VARCHAR(30),
    PRIMARY KEY (id_usuario, id_evento),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_evento) REFERENCES EVENTO(id_evento)
);
