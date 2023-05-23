--Prije korištenja ove skripte, molimo pokrenite skriptu "MaloprodajniCentar.sql"
--USE MaloprodajniCentar

--Implicitne transakcije

--I. primjer - kreiranje tablice unutar baze

CREATE TABLE Poslovnica(
	IDPoslovnica int NOT NULL,
	Ime nvarchar(50) NOT NULL,
	CONSTRAINT PoslovnicaPK PRIMARY KEY(IDPoslovnica)
)

--II. primjer -  unos podataka u tablicu

INSERT INTO Poslovnica VALUES
(1,'Namještaj'),
(2,'Odjeća i obuća'),
(3,'Bijela tehnika'),
(4,'Alati'),
(5,'Prehrambeni proizvodi'),
(6,'Multimedija'),
(7,'Upava'),
(8,'Tehnička služba')

--Eksplicitne transakcije

--I. primjer - unos podatka u tablicu te trajna pohrana promjena 

BEGIN TRAN
INSERT INTO Zaposlenik VALUES
(9,'Draško','Franković','2002-03-15','Pomoćnik u prodaji','12634091923','dfrankovic@gmail.com',5,4)
COMMIT TRAN
SELECT * FROM Zaposlenik

--II. primjer - unos podataka u tablicu te vraćanje baze u stanje prije provedbe transakcije

BEGIN TRAN
INSERT INTO Zaposlenik VALUES
(10,'Serafim','Jug','1989-07-22','Voditelj prodaje','86492051223','jug.serafim0@yahoo.com',2,2)
ROLLBACK TRAN
SELECT * FROM Zaposlenik WHERE IDZaposlenik = 10