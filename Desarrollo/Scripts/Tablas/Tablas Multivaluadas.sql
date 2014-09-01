CREATE TABLE multival_mto
(
	id int identity(1, 1),
	clave_proceso varchar(20),
	descripcion varchar(140)
)

CREATE TABLE multival_det
(
	id_det int,
	valor varchar(100), 
	descripcion varchar (200),
	orden int
)

ALTER TABLE dbo.multival_mto
ADD CONSTRAINT PK_multival_mto_id
PRIMARY KEY(id)

ALTER TABLE dbo.multival_det
ADD FOREIGN KEY (id_det)
REFERENCES dbo.multival_mto(id)