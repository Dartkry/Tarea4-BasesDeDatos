-- Script DDL en MySQL
-- Red Social Estudiantil Pascualina

CREATE DATABASE IF NOT EXISTS red_social_pascualina;
USE red_social_pascualina;

CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    correo_inst VARCHAR(120) NOT NULL,
    password VARCHAR(255) NOT NULL,
    fecha_registro DATETIME
);

CREATE TABLE PERFIL_ACAD (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    programa VARCHAR(100) NOT NULL,
    semestre TINYINT NOT NULL,
    biografia TEXT,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE HABILIDAD (
    id_habilidad INT AUTO_INCREMENT PRIMARY KEY,
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
    id_post INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    contenido TEXT NOT NULL,
    categoria VARCHAR(50),
    fecha_post DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE COMENTARIO (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_post INT NOT NULL,
    id_usuario INT NOT NULL,
    texto TEXT NOT NULL,
    fecha_coment DATETIME,
    FOREIGN KEY (id_post) REFERENCES POST(id_post),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE INTERACCION (
    id_interaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_post INT NOT NULL,
    id_usuario INT NOT NULL,
    tipo_reaccion VARCHAR(30),
    FOREIGN KEY (id_post) REFERENCES POST(id_post),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE GRUPO (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
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

-- Incluye campo coordenadas de tipo JSON (NoSQL) para guardar latitud y longitud
CREATE TABLE EVENTO (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_grupo INT NOT NULL,
    titulo VARCHAR(120) NOT NULL,
    fecha_evento DATETIME,
    ubicacion VARCHAR(150),
    coordenadas JSON,
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
