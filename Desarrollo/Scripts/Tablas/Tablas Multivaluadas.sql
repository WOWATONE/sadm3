CREATE TABLE multival_mto
(
	id INT IDENTITY(1, 1),
	clave_proceso VARCHAR(20),
	descripcion VARCHAR(140)
)

CREATE TABLE multival_det
(
	id_det INT,
	valor VARCHAR(100), 
	descripcion VARCHAR(200),
	orden INT
)

ALTER TABLE dbo.multival_mto
ADD CONSTRAINT PK_multival_mto_id
PRIMARY KEY(id)

ALTER TABLE dbo.multival_det
ADD FOREIGN KEY (id_det)
REFERENCES dbo.multival_mto(id)


CREATE TABLE Folios
(
	Tipo VARCHAR(20),
	Serie VARCHAR(10),
	Consecutivo INT,
	fec_mod DATETIME,
	mod_mod VARCHAR(40),
	usu_mod INT
)