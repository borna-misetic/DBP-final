CREATE DATABASE MaloprodajniCentar
GO
USE MaloprodajniCentar
GO
CREATE TABLE Poslovnica(
	IDPoslovnica int NOT NULL,
	Ime nvarchar(50) NOT NULL,
	CONSTRAINT PoslovnicaPK PRIMARY KEY(IDPoslovnica)
)
GO
CREATE TABLE Centar(
	IDCentar int NOT NULL,
	Ime nvarchar(30) NOT NULL,
	Lokacija nvarchar(30) NOT NULL,
	DatumOtvaranja date NOT NULL,
	CONSTRAINT CentarPK PRIMARY KEY(IDCentar)
)
GO
CREATE TABLE Zaposlenik(
	IDZaposlenik int NOT NULL,
	Ime nvarchar(30) NOT NULL,
	Prezime nvarchar(30) NOT NULL,
	DatumRodenja date NOT NULL,
	Zanimanje nvarchar(40) NOT NULL,
	OIB char(11) NOT NULL,
	Email varchar(30) NULL,
	CentarID int NOT NULL,
	PoslovnicaID int NOT NULL,
	CONSTRAINT ZaposlenikPK PRIMARY KEY(IDZaposlenik),
	CONSTRAINT ZaposlenikFK1 FOREIGN KEY(CentarID)
		REFERENCES Centar(IDCentar),
	CONSTRAINT ZaposlenikFK2 FOREIGN KEY(PoslovnicaID)
		REFERENCES Poslovnica(IDPoslovnica),
	CONSTRAINT ZaposlenikCHK CHECK(OIB LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO
CREATE TABLE Skladiste(
	IDSkladiste int NOT NULL,
	Lokacija nvarchar(30) NOT NULL,
	Kapacitet int NOT NULL,
	CONSTRAINT SkladistePK PRIMARY KEY(IDSkladiste),
	CONSTRAINT SkladisteCHK CHECK (Kapacitet>=25)
)
GO
CREATE TABLE Kategorija(
	IDKategorija int NOT NULL,
	Naziv nvarchar(50) NOT NULL,
	CONSTRAINT KategorijaPK PRIMARY KEY(IDKategorija)
)
GO
CREATE TABLE Proizvod(
	IDProizvod int NOT NULL,
	Ime nvarchar(30) NOT NULL,
	Cijena money NOT NULL,
	KategorijaID int NOT NULL,
	CONSTRAINT ProizvodPK PRIMARY KEY(IDProizvod),
	CONSTRAINT ProizvodFK FOREIGN KEY(KategorijaID)
		REFERENCES Kategorija(IDKategorija)
)
GO
CREATE TABLE NalaziProizvod(
	SkladisteID int NOT NULL,
	ProizvodID int NULL,
	Kolicina int NOT NULL DEFAULT(0),
	CONSTRAINT NalaziProizvodFK1 FOREIGN KEY(SkladisteID)
		REFERENCES Skladiste(IDSkladiste),
	CONSTRAINT NalaziProizvodFK2 FOREIGN KEY(ProizvodID)
		REFERENCES Proizvod(IDProizvod)
)
GO
CREATE TABLE ImaSkladiste(
	SkladisteID int NULL,
	CentarID int NOT NULL,
	CONSTRAINT ImaSkladisteFK1 FOREIGN KEY(SkladisteID)
		REFERENCES Skladiste(IDSkladiste),
	CONSTRAINT ImaSkladisteFK2 FOREIGN KEY(CentarID)
		REFERENCES Centar(IDCentar)
)
GO
CREATE TABLE ProdajePoslovnica(
	ProizvodID int NULL,
	PoslovnicaID int NULL,
	CONSTRAINT ProdajePoslovnicaFK1 FOREIGN KEY(ProizvodID)
		REFERENCES Proizvod(IDProizvod),
	CONSTRAINT ProdajePoslovnicaFK2 FOREIGN KEY(PoslovnicaID)
		REFERENCES Poslovnica(IDPoslovnica)
)
GO
CREATE TABLE SadrziPoslovnicu(
	CentarID int NOT NULL,
	PoslovnicaID int NOT NULL,
	CONSTRAINT SadrziPoslovnicuFK1 FOREIGN KEY(CentarID)
		REFERENCES Centar(IDCentar),
	CONSTRAINT SadrziPoslovnicuFK2 FOREIGN KEY(PoslovnicaID)
		REFERENCES Poslovnica(IDPoslovnica)
)
GO
INSERT INTO Poslovnica VALUES
(1,'Namještaj'),
(2,'Odjeća i obuća'),
(3,'Bijela tehnika'),
(4,'Alati'),
(5,'Prehrambeni proizvodi'),
(6,'Multimedija'),
(7,'Upava'),
(8,'Tehnička služba')
GO
INSERT INTO Centar VALUES
(1,'Distri centar Giga','Zagreb','2019-11-09'),
(2,'Distri centar Mega','Rijeka','2019-11-09'),
(3,'Distri centar Osijek','Osijek','2020-03-11'),
(4,'Distri centar Mini','Bjelovar','2020-06-30'),
(5,'Trgovačko središe Dubrovnik','Dubrovnik','2016-12-2'),
(6,'Trgovačko središte Karlovac','Karlovac','2017-07-21'),
(7,'Centar za Vas','Slavonski Brod','2018-09-03'),
(8,'Shopping is Simple Koprivnica','Koprivnica','2022-04-28')
GO
INSERT INTO Zaposlenik VALUES
(1,'Goran','Vlačić','1979-07-13','Električar','62137016934','goranv79@gmail.com',2,8),
(2,'Valentin','Darija','1991-02-26','Trgovac','87329847452','valentin.darija@gmail.com',5,5),
(3,'Mia','Martina','1980-06-12','Direktor','31652367212','miamm0@outlook.com',1,7),
(4,'Bernard','Nikola','1983-11-05','Blagajnik','23686237623','niko.bernard@gmail.com',8,2),
(5,'Alojzije','Milivoj','1988-12-01','Voditelj prodaje','21666907093','amilivoj@yahoo.com',4,3),
(6,'Marko','Jaga','1990-04-01','Blagajnik','44356473772','markojaga104@gmail.com',3,6),
(7,'Željka','Frane','1968-05-30','Suradnik u nabavi','57997458321','zeljka.frane@aol.com',6,1),
(8,'Boško','Sandi','2000-01-01','Voditelj prodaje','47329165098','sandi2000@proton.me',7,4)
GO
INSERT INTO SadrziPoslovnicu VALUES
(8,2),
(1,7),
(2,8),
(5,5),
(6,1),
(3,6),
(4,3),
(7,4)
GO
INSERT INTO Skladiste VALUES
(1,'Veliko Trojstvo',120),
(2,'Novska',400),
(3,'Vinkovci',240),
(4,'Varaždin',225),
(5,'Rovinj',300),
(6,'Ogulin',250),
(7,'Metković',300),
(8,'Zadar',275)
GO
INSERT INTO ImaSkladiste VALUES
(1,4),
(4,8),
(6,6),
(2,1),
(3,7),
(3,3),
(5,2),
(7,5)
GO
INSERT INTO Kategorija VALUES
(1,'Tenisice'),
(2,'Zdrava prehrana'),
(3,'Francuski ključevi'),
(4,'Stolovi'),
(5,'Audio uređaji'),
(6,'Perilice rublja'),
(7,'Gotova hrana'),
(8,'Igračke')
GO
INSERT INTO Proizvod VALUES
(1,'Pečena piletina 1kg',6.00,7),
(2,'Tarsele 150/200x80 cm',530.00,4),
(3,'Matador viličasti ključ 12″',14.59,3),
(4,'Set reketa i loptica',3.98,8),
(5,'Adidas Duramo tenisice',57.30,1),
(6,'Integralna riža 1kg',2.65,2),
(7,'Sennheiser HD 600',320.00,5),
(8,'LG F4WV309S4E',310.00,6)
GO
INSERT INTO ProdajePoslovnica VALUES
(1,5),
(4,6),
(8,3),
(5,2),
(3,4),
(2,1),
(7,6),
(6,5)
GO
INSERT INTO NalaziProizvod VALUES
(3,6,12),
(6,7,4),
(5,4,10),
(8,5,7),
(1,8,4),
(2,2,6),
(7,3,10),
(4,8,3)