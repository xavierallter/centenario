-----------------------------------------------------------
-- Empresa        :  Cl�nica Centenario SAC
-- Software       :  Sistema de Control de Citas M�dicas
-- DBMS           :  MS SQL Server
-- Base de Datos  :  BD_CITAS_CENTENARIO
-- Script         :  Crea la base de datos BD_CITAS_CENTENARIO
-- Programado por :  NRC1366
---------------------------------------------------------

IF DB_ID ('BD_CITAS_CENTENARIO') IS NOT NULL
BEGIN
	USE master
	DROP DATABASE BD_CITAS_CENTENARIO
END

CREATE DATABASE BD_CITAS_CENTENARIO
GO
USE BD_CITAS_CENTENARIO
GO

-- TABLA PACIENTE
----------------------------
CREATE TABLE PACIENTE(
	ID_paciente						VARCHAR(5) PRIMARY KEY, --Comienza desde el 10001
	nom_pac							VARCHAR(50) NOT NULL,
	ape_pac							VARCHAR(50) NOT NULL,
	DNI_pac							CHAR(8) NOT NULL UNIQUE,
	sexo_pac                        CHAR(2) NOT NULL,
	fec_nac_pac						DATE NOT NULL,
	foto_pac						IMAGE NULL,
	dir_pac							VARCHAR(100) NOT NULL,
	cel_pac							CHAR(9) UNIQUE NULL,
	email_pac						VARCHAR(50) UNIQUE NULL,
	fecha_registro					DATETIME NOT NULL,
	usu_registro					VARCHAR(20),
	fecha_Ult_Mod					DATETIME NULL,
	usu_Ult_Mod						VARCHAR(20) NULL,
	estado_pac						INT NULL,
	ID_ubigeo						VARCHAR(6) NOT NULL,
	alergias						VARCHAR(500) NULL,
	peso							NUMERIC(7,1) NULL,
	talla                           DECIMAL(10,2) NULL,
	gruposangre_pac                 VARCHAR(6) NULL
	)
GO

-- TABLA MEDICO
----------------------------
CREATE TABLE MEDICO(
	ID_medico						VARCHAR(5) PRIMARY KEY, --Comienza desde el M0001
	nom_med							VARCHAR(50) NOT NULL,
	ape_med							VARCHAR(50) NOT NULL,
	DNI_med							CHAR(8) NOT NULL UNIQUE,
	sexo_med                        CHAR(1) NOT NULL,
	fec_nac_med						DATE NOT NULL,
	foto_med						IMAGE NULL,
	dir_med							VARCHAR(100) NOT NULL,
	cel_med							CHAR(9) UNIQUE,
	email_med						VARCHAR(50) NOT NULL UNIQUE,
	Nro_Colegiatura					VARCHAR(6) NOT NULL,
	fecha_registro					DATETIME NOT NULL,
	usu_registro					VARCHAR(20),
	fecha_Ult_Mod					DATETIME,
	usu_Ult_Mod						VARCHAR(20),
	estado_med						INT NOT NULL,
	gruposangre_med                 VARCHAR(6) NULL,
	ID_ubigeo						VARCHAR(6) NOT NULL
	)
GO

-- TABLA ESPECIALIDAD
----------------------------
CREATE TABLE ESPECIALIDAD(
	ID_especialidad					VARCHAR(5) PRIMARY KEY, --Comienza desde el ES001
	nombre_especialidad				VARCHAR(500) NOT NULL,
	fecha_registro_esp              DATETIME NOT NULL,
	Usu_Registro                    VARCHAR(50) NULL,
	ultima_modificacion             VARCHAR(50) NULL
	)
GO


-- TABLA MEDICO-HORARIO
----------------------------
CREATE TABLE MEDICO_HORARIO(
    ID_horario						VARCHAR(4) NOT NULL,
	ID_medico						VARCHAR(5) NOT NULL,
	ID_especialidad	                VARCHAR(5) NOT NULL,
	precio							DECIMAL(10,2) NOT NULL,
	fecha_inicio                    DATE NOT NULL,
	fecha_fin                       DATE NOT NULL,
	hora_inicio                     TIME NULL,
	hora_fin                        TIME NULL,
    fecha_registro_med          DATETIME NOT NULL,
	Usu_Registro                    VARCHAR(50) NULL,
	ultima_modificacion             VARCHAR(50) NULL
					
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
	fecha_atencion					DATETIME NOT NULL,
	fecha_registro                  DATETIME NOT NULL,
	observaciones_cita				VARCHAR(500) NULL,
	ID_medico						VARCHAR (5) NOT NULL,
	ID_especialidad					VARCHAR (5) NOT NULL,
    ID_paciente						VARCHAR (5) NOT NULL,
	estado_cita					    VARCHAR(100) NOT NULL,
	ultima_modificacion             DATETIME NULL,
	Usu_Registro                    VARCHAR(50) NULL,
	observaciones                   VARCHAR(200) NULL,
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

ALTER TABLE [dbo].[PACIENTE] ADD  CONSTRAINT [fecha_registro_pac]  DEFAULT (getdate()) FOR [fecha_registro]
GO

ALTER TABLE [dbo].[PACIENTE] ADD  CONSTRAINT [def_estado_pac]  DEFAULT ((1)) FOR [estado_pac]
GO

-- TABLA MEDICO
----------------------------

ALTER TABLE MEDICO
	ADD FOREIGN KEY (ID_ubigeo)
	REFERENCES UBIGEO
GO

ALTER TABLE [dbo].[MEDICO] ADD  CONSTRAINT [fecha_registro_doc]  DEFAULT (getdate()) FOR [fecha_registro]
GO

ALTER TABLE [dbo].[MEDICO] ADD  CONSTRAINT [def_estado_med]  DEFAULT ((1)) FOR [estado_med]
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


ALTER TABLE [dbo].[MEDICO_HORARIO] ADD  CONSTRAINT [def_fecha_registro_med]  DEFAULT (getdate()) FOR [fecha_registro_med ]
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

ALTER TABLE [dbo].[CITA] ADD  CONSTRAINT [fecha_registro_cit]  DEFAULT (getdate()) FOR [fecha_registro]
GO
