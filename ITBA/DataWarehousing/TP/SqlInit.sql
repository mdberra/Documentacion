CREATE TABLE Dim_Genero (
	IdGenero int NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_Genero PRIMARY KEY (IdGenero)
);
CREATE TABLE Dim_Pais (
	IdPais varchar(2) NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_Pais PRIMARY KEY (IdPais)
);
CREATE TABLE Dim_RangoTamano (
	IdRangoTamano int NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_RangoTamano PRIMARY KEY (IdRangoTamano)
);
CREATE TABLE Dim_Motivo (
	IdMotivo int NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_Motivo PRIMARY KEY (IdMotivo)
);
CREATE TABLE Dim_Clase (
	IdClase int NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_Clase PRIMARY KEY (IdClase)
);
CREATE TABLE Dim_CantViajes (
	IdCantViajes int NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_CantViajes PRIMARY KEY (IdCantViajes)
);
CREATE TABLE Dim_RangoEdad (
	IdRangoEdad int NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_RangoEdad PRIMARY KEY (IdRangoEdad)
);
CREATE TABLE Dim_ComoLlego (
	IdComoLlego int NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_ComoLlego PRIMARY KEY (IdComoLlego)
);
CREATE TABLE Dim_Antelacion (
	IdAntelacion int NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_Antelacion PRIMARY KEY (IdAntelacion)
);
CREATE TABLE Dim_Conexion (
	IdConexion int NOT NULL,
	Descripcion varchar (30) NOT NULL,
	CONSTRAINT PK_Conexion PRIMARY KEY (IdConexion)
);
CREATE TABLE Dim_TipoCliente (
	IdTipoCliente int NOT NULL,
	IdGenero int NOT NULL,
	IdRangoEdad int NOT NULL,
	IdComoLlego int NOT NULL,
	IdAntelacion int NOT NULL,
	IdNacionalidad varchar(2) NOT NULL,
	IdPaisResidencia varchar(2) NOT NULL,
	IdCantViajes int NOT NULL,
	IdMotivo int NOT NULL,
	IdClase int NOT NULL,
	IdConexion int NOT NULL,
	CONSTRAINT PK_TipoCliente PRIMARY KEY (IdTipoCliente),
	CONSTRAINT FK_Genero FOREIGN KEY (IdGenero) REFERENCES Dim_Genero (IdGenero),
	CONSTRAINT FK_RangoEdad FOREIGN KEY (IdRangoEdad) REFERENCES Dim_RangoEdad (IdRangoEdad),
	CONSTRAINT FK_ComoLlego FOREIGN KEY (IdComoLlego) REFERENCES Dim_ComoLlego (IdComoLlego),
	CONSTRAINT FK_Antelacion FOREIGN KEY (IdAntelacion) REFERENCES Dim_Antelacion (IdAntelacion),
	CONSTRAINT FK_Nacionalidad FOREIGN KEY (IdNacionalidad) REFERENCES Dim_Pais (IdPais),
	CONSTRAINT FK_PaisResidencia FOREIGN KEY (IdPaisResidencia) REFERENCES Dim_Pais (IdPais),
	CONSTRAINT FK_CantViajes FOREIGN KEY (IdCantViajes) REFERENCES Dim_CantViajes (IdCantViajes),
	CONSTRAINT FK_Motivo FOREIGN KEY (IdMotivo) REFERENCES Dim_Motivo (IdMotivo),
	CONSTRAINT FK_Clase FOREIGN KEY (IdClase) REFERENCES Dim_Clase (IdClase),
	CONSTRAINT FK_Conexion FOREIGN KEY (IdConexion) REFERENCES Dim_Conexion (IdConexion)
);
CREATE TABLE Dim_Aerolinea (
	IdAerolinea int NOT NULL,
	Codigo varchar (3) NOT NULL UNIQUE,
	Nombre varchar (50) NOT NULL,
	CONSTRAINT PK_Aerolinea PRIMARY KEY (IdAerolinea)
);

CREATE TABLE Dim_Aeropuerto (
	IdAeropuerto int NOT NULL,
	Codigo varchar (3) NOT NULL UNIQUE,
	Nombre varchar (50) NOT NULL,
	Continente varchar (30) NOT NULL,
	IdRangoTamano int NOT NULL,
	CONSTRAINT PK_Aeropuerto PRIMARY KEY (IdAeropuerto),
	CONSTRAINT FK_RangoTamano FOREIGN KEY (IdRangoTamano) REFERENCES Dim_RangoTamano (IdRangoTamano)
);
CREATE TABLE Fact_Vuelo (
	IdVuelo int NOT NULL,
	AerolCodigo varchar (3) NOT NULL,
	NroVuelo int NULL,
	AeropCodigoSalida varchar(3) NOT NULL,
	AeropCodigoDestino varchar(3) NULL,
	FechaPartida date NULL,
	CONSTRAINT PK_Vuelo PRIMARY KEY (IdVuelo),
	CONSTRAINT FK_Aerolinea FOREIGN KEY (AerolCodigo) REFERENCES Dim_Aerolinea (Codigo),
	CONSTRAINT FK_AeropuertoSalida FOREIGN KEY (AeropCodigoSalida) REFERENCES Dim_Aeropuerto (Codigo)
);
CREATE TABLE Fact_Encuesta (
	IdEncuesta int NOT NULL,
	IdVuelo int NOT NULL,
	IdTipoCliente int NOT NULL,
	Transporte int,
	Parking int,
	ParkingRelPrecioCal int,
	DispCarritos int,
	CheckInTiempEspera int,
	CheckInEficiencia int,
	CheckInCortesia int,
	CtrlPasTiempoEspera int,
	CtrlPasCortesia int,
	SegCortesia int,
	SegMeticulosidad int,
	SegTiempoEspera int,
	SegSensacionProt int,
	OrientSenalizacion int,
	OrientPantallaInfo int,
	OientDistancia int,
	OrientFacilidConexion int,
	InstalCortesia int,
	InstalRestaurant int,
	InstalRestaurantRelPrecioCal int,
	InstalDispBancoATM int,
	InstalTiendas int,
	InstalTiendasRelPrecioCal int,
	InstalInternetWIFI int,
	InstalSalasVip int,
	InstalBanosDisp int,
	InstalBanosLimpieza int,
	InstalComodidadZonaEspera int,
	InstalLimpiezaGeneral int,
	InstalAmbiente int,
	SatisfaccionGeneral int,
	ControlPasaportes int,
	RapidesEntregaEquipaje int,
	ControlAduanero int,
	CONSTRAINT PK_Encuesta PRIMARY KEY (IdEncuesta),
	CONSTRAINT FK_Vuelo FOREIGN KEY (IdVuelo) REFERENCES Fact_Vuelo (IdVuelo),
	CONSTRAINT FK_TipoCliente FOREIGN KEY (IdTipoCliente) REFERENCES Dim_TipoCliente (IdTipoCliente)
);

INSERT INTO Dim_Genero VALUES (1, 'Masculino');
INSERT INTO Dim_Genero VALUES (2, 'Femenino');
INSERT INTO Dim_Genero VALUES (3, ' ');
select * from Dim_Genero;

INSERT INTO Dim_Pais VALUES ('AR', 'Argentina');
INSERT INTO Dim_Pais VALUES ('*', 'Extranjero');
INSERT INTO Dim_Pais VALUES (' ', 'No informado');
select * from Dim_Pais;

INSERT INTO Dim_RangoTamano VALUES (1, '< 2M');
INSERT INTO Dim_RangoTamano VALUES (2, '2 – 5M');
INSERT INTO Dim_RangoTamano VALUES (3, '5 – 15M');
INSERT INTO Dim_RangoTamano VALUES (4, '15 – 25M');
INSERT INTO Dim_RangoTamano VALUES (5, '25 – 40M');
INSERT INTO Dim_RangoTamano VALUES (6, '> 40M');
select * from Dim_RangoTamano;

INSERT INTO Dim_Motivo VALUES (1, 'Negocios');
INSERT INTO Dim_Motivo VALUES (2, 'Ocio');
INSERT INTO Dim_Motivo VALUES (3, 'Otros');
select * from Dim_Motivo;

INSERT INTO Dim_Clase VALUES (1, 'Primera');
INSERT INTO Dim_Clase VALUES (2, 'Ejecutiva');
INSERT INTO Dim_Clase VALUES (3, 'Turista');
INSERT INTO Dim_Clase VALUES (4, ' ');
select * from Dim_Clase;

INSERT INTO Dim_CantViajes VALUES (1, 'Entre 1 y 2');
INSERT INTO Dim_CantViajes VALUES (2, 'Entre 3 y 5');
INSERT INTO Dim_CantViajes VALUES (3, 'Entre 6 y 10');
INSERT INTO Dim_CantViajes VALUES (4, 'Entre 11 y 20');
INSERT INTO Dim_CantViajes VALUES (5, 'mas de 21');
INSERT INTO Dim_CantViajes VALUES (6, ' ');
select * from Dim_CantViajes;

INSERT INTO Dim_RangoEdad VALUES (1, '16 a 21');
INSERT INTO Dim_RangoEdad VALUES (2, '22 a 25');
INSERT INTO Dim_RangoEdad VALUES (3, '26 a 34');
INSERT INTO Dim_RangoEdad VALUES (4, '35 a 44');
INSERT INTO Dim_RangoEdad VALUES (5, '45 a 54');
INSERT INTO Dim_RangoEdad VALUES (6, '55 a 64');
INSERT INTO Dim_RangoEdad VALUES (7, '65 a 75');
INSERT INTO Dim_RangoEdad VALUES (8, '76 o mas');
INSERT INTO Dim_RangoEdad VALUES (9, ' ');
select * from Dim_RangoEdad;

INSERT INTO Dim_ComoLlego VALUES (1, 'Vehiculo Propio');
INSERT INTO Dim_ComoLlego VALUES (2, 'Autobus');
INSERT INTO Dim_ComoLlego VALUES (3, 'Taxi');
INSERT INTO Dim_ComoLlego VALUES (4, 'Tren');
INSERT INTO Dim_ComoLlego VALUES (5, 'Vehiculo Alquiler');
INSERT INTO Dim_ComoLlego VALUES (6, 'Otro');
INSERT INTO Dim_ComoLlego VALUES (7, ' ');
select * from Dim_ComoLlego;

INSERT INTO Dim_Antelacion VALUES (1, '< 30m');
INSERT INTO Dim_Antelacion VALUES (2, '30m y 45m');
INSERT INTO Dim_Antelacion VALUES (3, '45m y 60m');
INSERT INTO Dim_Antelacion VALUES (4, '1h y 1h 15m');
INSERT INTO Dim_Antelacion VALUES (5, '1h 15m y 1h 30m');
INSERT INTO Dim_Antelacion VALUES (6, '1h 30m y 2h');
INSERT INTO Dim_Antelacion VALUES (7, '> 2h');
INSERT INTO Dim_Antelacion VALUES (8, ' ');
select * from Dim_Antelacion;

INSERT INTO Dim_Conexion VALUES (1, 'Si');
INSERT INTO Dim_Conexion VALUES (2, 'No');
INSERT INTO Dim_Conexion VALUES (3, ' ');
select * from Dim_Conexion;

Select * from Dim_TipoCliente;
Select * from Dim_Aeropuerto;
Select * from Dim_Aerolinea;
SET DATESTYLE TO YMD;
Select * from Fact_Vuelo;
Select * from Fact_Encuesta;
