-----------------------------------------------------------
-- Empresa        :  Clinica Centenario SAC
-- Software       :  Sistema de Control de Citas Médicas
-- DBMS           :  MS SQL Server
-- Base de Datos  :  BD_CITAS_CENTENARIO_v2
-- Script         :  Crea la base de datos BD_CITAS_CENTENARIO
-- Programado por :  NRC1366
---------------------------------------------------------

IF DB_ID ('BD_CITAS_CENTENARIO_v2') IS NOT NULL
BEGIN
	USE master
	DROP DATABASE BD_CITAS_CENTENARIO_v2
END

CREATE DATABASE BD_CITAS_CENTENARIO_v2
GO
USE BD_CITAS_CENTENARIO_v2
GO

-- TABLA PACIENTE
----------------------------
CREATE TABLE PACIENTE(
	ID_paciente						VARCHAR(5) PRIMARY KEY, --Comienza desde el P0001
	nom_paciente					VARCHAR(50) NOT NULL,
	ape_paciente					VARCHAR(50) NOT NULL,
	DNI_paciente					CHAR(8) NOT NULL UNIQUE,
	sexo_paciente                   CHAR(2) NOT NULL,
	fec_nac_paciente				DATE NOT NULL,
	foto_paciente					IMAGE NULL,
	dir_paciente					VARCHAR(100) NOT NULL,
	cel_paciente					CHAR(9) UNIQUE NULL,
	email_paciente					VARCHAR(50) UNIQUE NULL,
	estado_paciente					INT NULL,
	ID_ubigeo						VARCHAR(6) NOT NULL,
	alergias_paciente				VARCHAR(500) NULL,
	peso_paciente					DECIMAL(3,1) NULL,
	talla_paciente                  DECIMAL(3,2) NULL,
	gruposangre_paciente            VARCHAR(6) NULL,
	fecha_registro					DATETIME NOT NULL,
	usu_registro					VARCHAR(20),
	fecha_Ult_Mod					DATETIME,
	usu_Ult_Mod						VARCHAR(20)
	)
GO

-- TABLA MEDICO
----------------------------
CREATE TABLE MEDICO(
	ID_medico						VARCHAR(5) PRIMARY KEY, --Comienza desde el M0001
	nom_medico						VARCHAR(50) NOT NULL,
	ape_medico						VARCHAR(50) NOT NULL,
	DNI_medico						CHAR(8) NOT NULL UNIQUE,
	sexo_medico                     CHAR(1) NOT NULL,
	fec_nac_medico					DATE NOT NULL,
	foto_medico						IMAGE NULL,
	dir_medico						VARCHAR(100) NOT NULL,
	cel_medico						CHAR(9) UNIQUE,
	email_medico					VARCHAR(50) NOT NULL UNIQUE,
	Nro_Colegiatura					VARCHAR(6) NOT NULL,
	estado_medico					INT NOT NULL,
	gruposangre_medico              VARCHAR(6) NULL,
	ID_ubigeo						VARCHAR(6) NOT NULL,
	fecha_registro					DATETIME NOT NULL,
	usu_registro					VARCHAR(20),
	fecha_Ult_Mod					DATETIME,
	usu_Ult_Mod						VARCHAR(20)
	)
GO

-- TABLA ESPECIALIDAD
----------------------------
CREATE TABLE ESPECIALIDAD(
	ID_especialidad					VARCHAR(5) PRIMARY KEY, --Comienza desde el ES001
	nombre_especialidad				VARCHAR(500) NOT NULL,
	precio_especialidad				DECIMAL(10,2) NOT NULL,
	fecha_registro					DATETIME NOT NULL,
	usu_registro					VARCHAR(20),
	fecha_Ult_Mod					DATETIME,
	usu_Ult_Mod						VARCHAR(20)
	)
GO


-- TABLA MEDICO-HORARIO
----------------------------
CREATE TABLE MEDICO_HORARIO(
    ID_horario						VARCHAR(5) PRIMARY KEY, --Comienza desde el H0001
	ID_medico						VARCHAR(5) NOT NULL,
	ID_especialidad	                VARCHAR(5) NOT NULL,
	dia_atencion					VARCHAR(10) NULL,
	hora_inicio                     TIME NULL,
	hora_fin                        TIME NULL,
	fecha_registro					DATETIME NOT NULL,
	usu_registro					VARCHAR(20),
	fecha_Ult_Mod					DATETIME,
	usu_Ult_Mod						VARCHAR(20),
	)
GO

-- TABLA UBIGEO
----------------------------
CREATE TABLE UBIGEO(
	ID_ubigeo						VARCHAR(6) PRIMARY KEY,
	ID_Depar						VARCHAR(2) NOT NULL,
	ID_Prov							VARCHAR(2) NOT NULL,
	ID_Distr						VARCHAR(2) NOT NULL,
	Departamento					VARCHAR(50) NOT NULL,
	Provincia						VARCHAR(50) NOT NULL,
	Distrito						VARCHAR(50) NOT NULL
)
GO

-- TABLA CITA
----------------------------
CREATE TABLE CITA(
	ID_cita							VARCHAR (5) PRIMARY KEY,  --Comienza desde el C0001
	ID_medico						VARCHAR (5) NOT NULL,
	ID_especialidad					VARCHAR (5) NOT NULL,
    ID_paciente						VARCHAR (5) NOT NULL,
	fecha_atencion_cita				DATETIME NOT NULL,
	observaciones_cita				VARCHAR(500) NULL,
	estado_cita					    INT NOT NULL,
	fecha_registro					DATETIME NOT NULL,
	usu_registro					VARCHAR(20),
	fecha_Ult_Mod					DATETIME,
	usu_Ult_Mod						VARCHAR(20)
	)
GO


-- TABLA USUARIO
----------------------------
CREATE TABLE USUARIO(
	Login_usuario					VARCHAR (20) PRIMARY KEY,
	Pass_usuario					VARCHAR (20) NOT NULL,
	Niv_usuario						INT NOT NULL,
	Est_usuario						INT NOT NULL,
	Fecha_registro					DATETIME NOT NULL,
	Usu_registro					VARCHAR (20) NULL
	)
GO


----------------------------
-- Relaciones
----------------------------

-- TABLA PACIENTE
----------------------------
ALTER TABLE PACIENTE
	ADD FOREIGN KEY (ID_ubigeo)
	REFERENCES UBIGEO
GO

ALTER TABLE PACIENTE
	ADD CONSTRAINT [fecha_registro_paciente]  
	DEFAULT (GETDATE()) FOR fecha_registro
GO

ALTER TABLE PACIENTE 
	ADD CONSTRAINT [def_estado_paciente]
	DEFAULT ((1)) FOR [estado_paciente]
GO

-- TABLA MEDICO
----------------------------

ALTER TABLE MEDICO
	ADD FOREIGN KEY (ID_ubigeo)
	REFERENCES UBIGEO
GO

ALTER TABLE MEDICO 
	ADD CONSTRAINT [fecha_registro_medico]
	DEFAULT (GETDATE()) FOR [fecha_registro]
GO

ALTER TABLE MEDICO
	ADD CONSTRAINT [def_estado_medico]
	DEFAULT ((1)) FOR [estado_medico]
GO

-- TABLA MEDICO-HORARIO
----------------------------
ALTER TABLE MEDICO_HORARIO
	ADD FOREIGN KEY (ID_medico)
	REFERENCES MEDICO
GO

ALTER TABLE MEDICO_HORARIO
    ADD FOREIGN KEY (ID_especialidad)
	REFERENCES ESPECIALIDAD
GO

ALTER TABLE MEDICO_HORARIO
	ADD CONSTRAINT [def_fecha_registro_med]
	DEFAULT (GETDATE()) FOR [fecha_registro]
GO

-- TABLA CITA
----------------------------
ALTER TABLE CITA
	ADD FOREIGN KEY (ID_medico)
	REFERENCES MEDICO
GO

ALTER TABLE CITA
	ADD FOREIGN KEY (ID_paciente)
	REFERENCES PACIENTE
GO

ALTER TABLE CITA
	ADD FOREIGN KEY (ID_especialidad)
	REFERENCES ESPECIALIDAD
GO

ALTER TABLE CITA
	ADD CONSTRAINT [fecha_registro_cit]
	DEFAULT (GETDATE()) FOR [fecha_registro]
GO

ALTER TABLE CITA
	ADD CONSTRAINT [def_estado_cita]
	DEFAULT ((0)) FOR [estado_cita]
GO