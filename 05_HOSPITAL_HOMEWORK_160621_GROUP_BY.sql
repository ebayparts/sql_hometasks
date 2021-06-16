CREATE DATABASE Hospital1606
GO
USE Hospital1606
GO
CREATE TABLE Examinations 
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	[Name] nvarchar(100) NOT NULL check([Name] <> '') UNIQUE
);
GO
CREATE TABLE Doctors 
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	[Name] nvarchar(MAX) NOT NULL check([Name] <> ''),
	Premium MONEY NOT NULL DEFAULT(0) CHECK(Premium >= 0),
	Salary MONEY NOT NULL CHECK(Salary > 0),
	Surname nvarchar(MAX) NOT NULL check(Surname <> '')
);
GO
CREATE TABLE Departments 
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	[Name] nvarchar(100) NOT NULL check([Name] <> '') UNIQUE,
	Building int NOT NULL CHECK(Building BETWEEN 1 AND 5)
);
GO
CREATE TABLE Wards 
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	[Name] nvarchar(20) NOT NULL check([Name] <> '') UNIQUE,
	Places int NOT NULL CHECK(Places >= 1),
	DepartmentId INT NOT NULL FOREIGN KEY REFERENCES Departments(Id)
);
GO
CREATE TABLE DoctorsExaminations 
(
	Id int PRIMARY KEY IDENTITY(1, 1),
	EndTime TIME NOT NULL,
	StartTime TIME NOT NULL CHECK(StartTime BETWEEN '8:00' AND '18:00'),
	DoctorId int NOT NULL FOREIGN KEY REFERENCES Doctors(Id),
	ExaminationId int NOT NULL FOREIGN KEY REFERENCES Examinations(Id),
	WardId int NOT NULL FOREIGN KEY REFERENCES Wards(Id),
	CHECK(EndTime > StartTime)
);

--Запросы
--1. Вывести количество палат, вместимость которых больше 10.
SELECT COUNT(Id) AS 'Wards that can place 10 or more'
FROM Wards
WHERE Places > 10
--2. Вывести названия корпусов и количество палат в каждом
--из них.
SELECT D.Name AS 'Building Name', COUNT(W.Id) AS 'Wards count in Building'
FROM Departments AS D JOIN Wards AS W ON D.Id = W.DepartmentId
GROUP BY D.Name
--3. Вывести названия отделений и количество палат в каждом из них.
SELECT D.Name AS 'Department Name', COUNT(W.Id) AS 'Wards count in Department'
FROM Departments AS D JOIN Wards AS W ON D.Id = W.DepartmentId
GROUP BY D.Name
--4. Вывести названия отделений и суммарную надбавку
--врачей в каждом из них.
SELECT Dep.Name AS 'Department Name', SUM(D.Premium) AS 'Overal doc.Premium in Department'
FROM Departments AS Dep	JOIN Wards AS W ON Dep.Id = W.DepartmentId
						JOIN DoctorsExaminations AS DE ON DE.WardId = W.Id
						JOIN Doctors AS D ON DE.DoctorId = D.Id
GROUP BY Dep.Name
--5. Вывести названия отделений, в которых проводят обследования 5 и более врачей.
SELECT Dep.Name AS 'Department Name', Count(D.Id) AS 'Amount of doctors Examinations in Department'
FROM Departments AS Dep	JOIN Wards AS W ON Dep.Id = W.DepartmentId
						JOIN DoctorsExaminations AS DE ON DE.WardId = W.Id
						JOIN Doctors AS D ON DE.DoctorId = D.Id
GROUP BY Dep.Name
HAVING Count(D.Id) > 5
--6. Вывести количество врачей и их суммарную зарплату
--(сумма ставки и надбавки).
SELECT COUNT(D.Id) AS 'Amount of doctors', SUM(D.Salary) + SUM(D.Premium) AS 'Overall Salary and Premium'
FROM Doctors AS D
--7. Вывести среднюю зарплату (сумма ставки и надбавки)
--врачей.
SELECT AVG(D.Salary + D.Premium) AS 'Average Sum Salary and Premium of Doctors'
FROM Doctors AS D
--8. Вывести названия палат с минимальной вместительностью.
SELECT Places AS 'Minimum placement Ward', Name AS 'Ward name' 
FROM Wards
WHERE Places = (
				SELECT MIN(Places) 
				FROM Wards
				)
Order BY Places
--9. Вывести в каких из корпусов 1, 6, 7 и 8, суммарное количество мест в палатах превышает 100. При этом учитывать
--только палаты с количеством мест больше 10.
SELECT D.Name AS 'Building Name', SUM(W.Places) AS 'Places in Ward'
FROM Departments AS D JOIN Wards AS W ON D.Id = W.DepartmentId
WHERE D.Building IN (1,6,7,8) AND W.Places > 10
GROUP BY D.Name
HAVING SUM(W.Places) > 100


insert into Examinations (Name) values ('Sulfamethoxazole and Trimethoprim');
insert into Examinations (Name) values ('Conchae 5 comp.');
insert into Examinations (Name) values ('calcitonin salmon');
insert into Examinations (Name) values ('Adenosinum cyclophosphoricum, Adrenalinum, Adrenocorticotrophin, Agraphis nutans, Allium cepa, Collinsonia canadensis, Cortisone aceticum, Euphrasia officinalis, Galphimia glauca, Histaminum hydrochloricum, Kali muriaticum, Mucosa nasalis suis, Natrum muriaticum, RNA, Rumex crispus, Sabadilla, Salvia officinalis, Tanacetum vulgare, Trifolium pratense, Vinca minor');
insert into Examinations (Name) values ('CALCIUM ACETATE');
insert into Examinations (Name) values ('Hydrocortisone');
insert into Examinations (Name) values ('Epstein-barr virus');
insert into Examinations (Name) values ('Diphenhydramine Hydrochloride');
insert into Examinations (Name) values ('Mineral Oil');
insert into Examinations (Name) values ('isosorbide mononitrate');
insert into Examinations (Name) values ('Ciprofloxacin');
insert into Examinations (Name) values ('Aspirin');
insert into Examinations (Name) values ('Fludeoxyglucose F18');
insert into Examinations (Name) values ('Risperidone');
insert into Examinations (Name) values ('PANTOPRAZOLE SODIUM');
insert into Examinations (Name) values ('Cetirizine Hydrochloride');
insert into Examinations (Name) values ('Menthol');
insert into Examinations (Name) values ('Fluocinonide');
insert into Examinations (Name) values ('Tadalafil');
insert into Examinations (Name) values ('BUPIVACAINE HYDROCHLORIDE and EPINEPHRINE BITARTRATE');
insert into Examinations (Name) values ('Coccus cacti, Drosera, Scilla maritima, Arsenicum iodatum, Causticum, Cuprum aceticum, Carbo vegetabilis, Kali Carbonicum, Lachesis mutus,');
insert into Examinations (Name) values ('Mezereum 3X, Croton tiglium 6X, Rhus toxicodendron 4X, Natrum muriaticum 6X');
insert into Examinations (Name) values ('OCTINOXATE, OCTISALATE');
insert into Examinations (Name) values ('benzonatate');
insert into Examinations (Name) values ('eszopiclone');
insert into Examinations (Name) values ('Triclosan');
insert into Examinations (Name) values ('Calcium Carbonate');
insert into Examinations (Name) values ('Docusate calcium');
insert into Examinations (Name) values ('estradiol');
insert into Examinations (Name) values ('Valsartan and Hydrochlorothiazide');
insert into Examinations (Name) values ('Methylphenidate Hydrochloride');
insert into Examinations (Name) values ('Stillingia Sylvatica, Zincum Gluconicum, Thiaminum Hydrochloricum, Fragaria Vesca, Niacin, Serotonin, 5-Hydroxtryptophan, Betainum Muriaticum, Biotin, Cholinum, Co-Enzyme Q-10, DL-Methionine, L-Alanine, Cysteinum,');
insert into Examinations (Name) values ('Furosemide');
insert into Examinations (Name) values ('Pyridostigmine Bromide');
insert into Examinations (Name) values ('Dicyclomine Hydrochloride');
insert into Examinations (Name) values ('SODIUM BICARBONATE');
insert into Examinations (Name) values ('Aluminum Zirconium Tetrachlorohydrex GLY');
insert into Examinations (Name) values ('citalopram hydrobromide');
insert into Examinations (Name) values ('Oxcarbazepine');
insert into Examinations (Name) values ('Nortriptyline Hydrochloride');
insert into Examinations (Name) values ('Mineral oil, Petrolatum, Phenylephrine HCl, Shark liver oil');
insert into Examinations (Name) values ('Titanium Dioxide and Zinc Oxide');
insert into Examinations (Name) values ('Famciclovir');
insert into Examinations (Name) values ('Hydroquinone');
insert into Examinations (Name) values ('Sodium Fluoride');
insert into Examinations (Name) values ('LISINOPRIL');
insert into Examinations (Name) values ('Haloperidol Decanoate');
insert into Examinations (Name) values ('OXYMETAZOLINE HYDROCHLORIDE');
insert into Examinations (Name) values ('Olanzapine');
insert into Examinations (Name) values ('Levonorgestrel');
insert into Examinations (Name) values ('Berberis aquifolium 4X, Hydrocotyle asiatica 4X, Arsenicum album 12X, Calcarea carbonica 30X, Graphites 12X, Natrum muriaticum 30X');
insert into Examinations (Name) values ('Ibuprofen');
insert into Examinations (Name) values ('DEXTROMETHORPHAN HYDROBROMIDE, GUAIFENESIN, and PHENYLEPHRINE HYDROCHLORIDE');
insert into Examinations (Name) values ('TITANIUM DIOXIDE, ZINC OXIDE');
insert into Examinations (Name) values ('OCTINOXATE, OCTISALATE, TITANIUM DIOXIDE');
insert into Examinations (Name) values ('Gatifloxacin');
insert into Examinations (Name) values ('Octinoxate and Titanium Dioxide');
insert into Examinations (Name) values ('Levetiracetam');
insert into Examinations (Name) values ('Triclosan');
insert into Examinations (Name) values ('BENZOCAINE and RESORCINOL');
insert into Examinations (Name) values ('Sodium Bicarbonate');
insert into Examinations (Name) values ('Pyrithione Zinc');
insert into Examinations (Name) values ('HYDROMORPHONE HYDROCHLORIDE');
insert into Examinations (Name) values ('Diphenhydramine HCl, Allantoin');
insert into Examinations (Name) values ('Risperidone');
insert into Examinations (Name) values ('Bryonia, Ruta Graveolens, Bellis Perennis, Argentum Metallicum');
insert into Examinations (Name) values ('Meclizine');
insert into Examinations (Name) values ('Echinacea Thuja Special Order');
insert into Examinations (Name) values ('famotidine, calcium carbonate and magnesium hydroxide');
insert into Examinations (Name) values ('Quetiapine fumarate');
insert into Examinations (Name) values ('valsartan and hydrochlorothiazide');
insert into Examinations (Name) values ('American Cheese, Blue Cheese, Brie Cheese, Cheddar Cheese, Cottage Cheese, Swiss Cheese, Lac Vaccinum, Goat Milk');
insert into Examinations (Name) values ('Gabapentin');
insert into Examinations (Name) values ('Aconitum napellus, Arnica Montana, Arsenicum album, Bellis Perennis, Cartilago suis, Causticum, Chamomilla, Coffea cruda,');
insert into Examinations (Name) values ('Carvedilol');
insert into Examinations (Name) values ('OCTINOXATE, ZINC OXIDE');
insert into Examinations (Name) values ('Protriptyline Hydrochloride');
insert into Examinations (Name) values ('sodium fluoride');
insert into Examinations (Name) values ('Cetirizine Hydrochloride Tablets');
insert into Examinations (Name) values ('Atenolol');
insert into Examinations (Name) values ('Calcium polycarbophil');
insert into Examinations (Name) values ('Acetaminophen, Phenylephrine HCl');
insert into Examinations (Name) values ('Triamcinolone Acetonide');
insert into Examinations (Name) values ('Esomeprazole sodium');
insert into Examinations (Name) values ('Norgestimate and Ethinyl Estradiol');
insert into Examinations (Name) values ('Triclosan');
insert into Examinations (Name) values ('Donepezil Hydrochloride');
insert into Examinations (Name) values ('AMINOCAPROIC ACID');
insert into Examinations (Name) values ('enoxaparin sodium');
insert into Examinations (Name) values ('Nitrous Oxide');
insert into Examinations (Name) values ('Menthol and Methyl Salicylate');
insert into Examinations (Name) values ('Octinoxate, Octisalate, Oxybenzone');
insert into Examinations (Name) values ('clonazepam');
insert into Examinations (Name) values ('Levothyroxine Sodium');
insert into Examinations (Name) values ('Zinc Oxide');
insert into Examinations (Name) values ('One Seed Juniper');
insert into Examinations (Name) values ('Perindopril Erbumine');
insert into Examinations (Name) values ('Acetaminophen, Diphenhydramine hydrochloride, and Phenylephrine hydrochloride');
insert into Examinations (Name) values ('Titanium Dioxide, Zinc Oxide, and Octinoxate');
insert into Examinations (Name) values ('Amlodipine Besylate and Benazepril Hydrochloride');
insert into Doctors (Name, Surname, Premium, Salary) values ('Parsifal', 'Gennings', 422, 545);
insert into Doctors (Name, Surname, Premium, Salary) values ('Frankie', 'Schulken', 206, 501);
insert into Doctors (Name, Surname, Premium, Salary) values ('Erskine', 'Jackson', 232, 481);
insert into Doctors (Name, Surname, Premium, Salary) values ('Fremont', 'Pirie', 408, 733);
insert into Doctors (Name, Surname, Premium, Salary) values ('Dannie', 'Tebbet', 231, 353);
insert into Doctors (Name, Surname, Premium, Salary) values ('Cornell', 'Eyles', 385, 378);
insert into Doctors (Name, Surname, Premium, Salary) values ('Ethelred', 'Roja', 200, 536);
insert into Doctors (Name, Surname, Premium, Salary) values ('Doug', 'Telega', 418, 391);
insert into Doctors (Name, Surname, Premium, Salary) values ('Matty', 'Ronnay', 469, 530);
insert into Doctors (Name, Surname, Premium, Salary) values ('Clayton', 'Knifton', 419, 574);
insert into Doctors (Name, Surname, Premium, Salary) values ('Boothe', 'Giamo', 296, 480);
insert into Doctors (Name, Surname, Premium, Salary) values ('Ingmar', 'Beer', 409, 648);
insert into Doctors (Name, Surname, Premium, Salary) values ('Ronnie', 'Ost', 165, 559);
insert into Doctors (Name, Surname, Premium, Salary) values ('Colman', 'Carragher', 258, 401);
insert into Doctors (Name, Surname, Premium, Salary) values ('Zechariah', 'Gregr', 331, 487);
insert into Doctors (Name, Surname, Premium, Salary) values ('Web', 'Fillgate', 315, 485);
insert into Doctors (Name, Surname, Premium, Salary) values ('Kahlil', 'Torn', 322, 604);
insert into Doctors (Name, Surname, Premium, Salary) values ('Rriocard', 'Land', 211, 533);
insert into Doctors (Name, Surname, Premium, Salary) values ('Linoel', 'Dinesen', 310, 371);
insert into Doctors (Name, Surname, Premium, Salary) values ('Cort', 'McTrustam', 169, 458);
insert into Doctors (Name, Surname, Premium, Salary) values ('Leon', 'Crass', 177, 391);
insert into Doctors (Name, Surname, Premium, Salary) values ('Edan', 'Renshell', 224, 668);
insert into Doctors (Name, Surname, Premium, Salary) values ('Foss', 'Cullington', 291, 688);
insert into Doctors (Name, Surname, Premium, Salary) values ('Sherlock', 'Linkie', 359, 750);
insert into Doctors (Name, Surname, Premium, Salary) values ('Hamid', 'Goldsby', 290, 371);
insert into Doctors (Name, Surname, Premium, Salary) values ('Bert', 'Clooney', 213, 366);
insert into Doctors (Name, Surname, Premium, Salary) values ('Artemus', 'Marioneau', 393, 425);
insert into Doctors (Name, Surname, Premium, Salary) values ('Jarrid', 'Ropkins', 156, 605);
insert into Doctors (Name, Surname, Premium, Salary) values ('Haroun', 'Conerding', 155, 415);
insert into Doctors (Name, Surname, Premium, Salary) values ('Tito', 'Northleigh', 395, 631);
insert into Doctors (Name, Surname, Premium, Salary) values ('Ingram', 'Salmon', 363, 520);
insert into Doctors (Name, Surname, Premium, Salary) values ('Rufe', 'Zavattiero', 240, 486);
insert into Doctors (Name, Surname, Premium, Salary) values ('Carson', 'Twigger', 202, 689);
insert into Doctors (Name, Surname, Premium, Salary) values ('Abey', 'McIver', 383, 638);
insert into Doctors (Name, Surname, Premium, Salary) values ('Taylor', 'Leaf', 172, 737);
insert into Doctors (Name, Surname, Premium, Salary) values ('Armand', 'Gulliman', 438, 625);
insert into Doctors (Name, Surname, Premium, Salary) values ('Rickard', 'Kilgour', 453, 536);
insert into Doctors (Name, Surname, Premium, Salary) values ('Falito', 'Heeney', 395, 473);
insert into Doctors (Name, Surname, Premium, Salary) values ('Pall', 'Scurman', 312, 709);
insert into Doctors (Name, Surname, Premium, Salary) values ('Johannes', 'Warfield', 207, 520);
insert into Doctors (Name, Surname, Premium, Salary) values ('Napoleon', 'Probbing', 500, 711);
insert into Doctors (Name, Surname, Premium, Salary) values ('Pooh', 'Bradder', 347, 450);
insert into Doctors (Name, Surname, Premium, Salary) values ('Marcel', 'Orrobin', 423, 606);
insert into Doctors (Name, Surname, Premium, Salary) values ('Ralph', 'Skylett', 265, 367);
insert into Doctors (Name, Surname, Premium, Salary) values ('Johnnie', 'Teodoro', 368, 424);
insert into Doctors (Name, Surname, Premium, Salary) values ('Claudian', 'Durden', 489, 628);
insert into Doctors (Name, Surname, Premium, Salary) values ('Emmanuel', 'Hickin', 430, 556);
insert into Doctors (Name, Surname, Premium, Salary) values ('Abey', 'Ivison', 222, 517);
insert into Doctors (Name, Surname, Premium, Salary) values ('Redd', 'Nesbitt', 351, 598);
insert into Doctors (Name, Surname, Premium, Salary) values ('Clarance', 'Saynor', 421, 487);
insert into Departments (Name, Building) values ('Man in the Gray Flannel Suit, The', 2);
insert into Departments (Name, Building) values ('Competition, The', 2);
insert into Departments (Name, Building) values ('Dilettante, La', 3);
insert into Departments (Name, Building) values ('Invisible Woman, The', 4);
insert into Departments (Name, Building) values ('Aces High', 5);
insert into Departments (Name, Building) values ('Ice Castles', 4);
insert into Departments (Name, Building) values ('Here Without Me (Inja bedoone man)', 1);
insert into Departments (Name, Building) values ('Immaculate Conception of Little Dizzle', 4);
insert into Departments (Name, Building) values ('Phil Spector', 5);
insert into Departments (Name, Building) values ('Freedom', 1);
insert into Departments (Name, Building) values ('Emerald Forest, The', 3);
insert into Departments (Name, Building) values ('Somebody Up There Likes Me', 4);
insert into Departments (Name, Building) values ('Loser', 1);
insert into Departments (Name, Building) values ('Lucía, Lucía (Hija del caníbal, La)', 5);
insert into Departments (Name, Building) values ('Alice in Wonderland', 1);
insert into Wards (Name, Places, DepartmentId) values ('Procter & Gamble Manufacturing Company', 7, 11);
insert into Wards (Name, Places, DepartmentId) values ('Par Pharmaceutical, Inc.', 21, 7);
insert into Wards (Name, Places, DepartmentId) values ('Energique, Inc.', 23, 13);
insert into Wards (Name, Places, DepartmentId) values ('Macleods Pharmaceuticals Limited', 19, 11);
insert into Wards (Name, Places, DepartmentId) values ('Aurobindo Pharma Limited', 12, 12);
insert into Wards (Name, Places, DepartmentId) values ('Sandoz Inc', 17, 14);
insert into Wards (Name, Places, DepartmentId) values ('VVF Kansas Services LLC', 23, 15);
insert into Wards (Name, Places, DepartmentId) values ('Freds Inc', 13, 7);
insert into Wards (Name, Places, DepartmentId) values ('MedVantx, Inc.', 11, 3);
insert into Wards (Name, Places, DepartmentId) values ('Cardinal Health', 3, 15);
insert into Wards (Name, Places, DepartmentId) values ('TAI GUK PHARM. CO., LTD.', 10, 7);
insert into Wards (Name, Places, DepartmentId) values ('Nature''s Innovation, Inc.', 3, 3);
insert into Wards (Name, Places, DepartmentId) values ('Eisai Inc.', 3, 13);
insert into Wards (Name, Places, DepartmentId) values ('Blue Cross Laboratories, Inc.', 13, 9);
insert into Wards (Name, Places, DepartmentId) values ('Rebel Distributors Corp', 7, 9);
insert into Wards (Name, Places, DepartmentId) values ('Preferred Pharmaceuticals, Inc.', 1, 10);
insert into Wards (Name, Places, DepartmentId) values ('REMEDYREPACK INC.', 27, 12);
insert into Wards (Name, Places, DepartmentId) values ('Exact-Rx, Inc.', 2, 6);
insert into Wards (Name, Places, DepartmentId) values ('Kay Chemical Co', 28, 8);
insert into Wards (Name, Places, DepartmentId) values ('Sesvalia USA LLC', 18, 5);
insert into Wards (Name, Places, DepartmentId) values ('B. Braun Medical Inc.', 29, 1);
insert into Wards (Name, Places, DepartmentId) values ('SKINFOOD CO., LTD.', 25, 9);
insert into Wards (Name, Places, DepartmentId) values ('Concept Laboratories, Inc.', 8, 9);
insert into Wards (Name, Places, DepartmentId) values ('Macleods Pharmaceuticals Limited', 26, 13);
insert into Wards (Name, Places, DepartmentId) values ('Putney Inc', 3, 4);
insert into Wards (Name, Places, DepartmentId) values ('Apotheca Company', 11, 9);
insert into Wards (Name, Places, DepartmentId) values ('Cardinal Health', 28, 9);
insert into Wards (Name, Places, DepartmentId) values ('AuroMedics Pharma LLC', 16, 15);
insert into Wards (Name, Places, DepartmentId) values ('NATURE REPUBLIC CO., LTD.', 20, 14);
insert into Wards (Name, Places, DepartmentId) values ('SOHM Inc.', 2, 1);
insert into Wards (Name, Places, DepartmentId) values ('Central Solutions Inc', 7, 1);
insert into Wards (Name, Places, DepartmentId) values ('Rituals Cosmetics USA, Inc.', 28, 8);
insert into Wards (Name, Places, DepartmentId) values ('Indiana Botanic Gardens', 13, 15);
insert into Wards (Name, Places, DepartmentId) values ('PRESCRIPTIVES INC', 28, 9);
insert into Wards (Name, Places, DepartmentId) values ('Medtech Products Inc.', 1, 5);
insert into Wards (Name, Places, DepartmentId) values ('Procter & Gamble Manufacturing Company', 27, 11);
insert into Wards (Name, Places, DepartmentId) values ('AvPAK', 10, 6);
insert into Wards (Name, Places, DepartmentId) values ('Rebel Distributors Corp', 11, 12);
insert into Wards (Name, Places, DepartmentId) values ('Mylan Institutional LLC', 8, 5);
insert into Wards (Name, Places, DepartmentId) values ('American Health Packaging', 3, 15);
insert into Wards (Name, Places, DepartmentId) values ('Global Pharmaceuticals, Division of Impax Laboratories Inc.', 16, 3);
insert into Wards (Name, Places, DepartmentId) values ('SMART SENSE (Kmart)', 1, 3);
insert into Wards (Name, Places, DepartmentId) values ('SHISEIDO CO., LTD.', 26, 3);
insert into Wards (Name, Places, DepartmentId) values ('HomeopathyStore.com', 21, 6);
insert into Wards (Name, Places, DepartmentId) values ('Apotex Corporation', 22, 14);
insert into Wards (Name, Places, DepartmentId) values ('Silarx Pharmaceuticals,Inc', 4, 5);
insert into Wards (Name, Places, DepartmentId) values ('Avon Products, Inc.', 24, 6);
insert into Wards (Name, Places, DepartmentId) values ('La Prairie, Inc.', 3, 8);
insert into Wards (Name, Places, DepartmentId) values ('GE Healthcare Inc.', 21, 13);
insert into Wards (Name, Places, DepartmentId) values ('MEGASOL COSMETIC GMBH', 27, 8);
insert into Wards (Name, Places, DepartmentId) values ('Hospira, Inc.', 23, 3);
insert into Wards (Name, Places, DepartmentId) values ('ID Biomedical Corporation of Quebec', 7, 10);
insert into Wards (Name, Places, DepartmentId) values ('RITE AID CORPORATION', 29, 2);
insert into Wards (Name, Places, DepartmentId) values ('Kmart Corporation', 20, 2);
insert into Wards (Name, Places, DepartmentId) values ('Elizabeth Arden, Inc', 9, 12);
insert into Wards (Name, Places, DepartmentId) values ('Sigan Industries', 25, 4);
insert into Wards (Name, Places, DepartmentId) values ('Combe Incorporated', 27, 5);
insert into Wards (Name, Places, DepartmentId) values ('NorthStar RxLLC', 24, 13);
insert into Wards (Name, Places, DepartmentId) values ('Safeway, Inc.', 25, 9);
insert into Wards (Name, Places, DepartmentId) values ('Blaine Labs Inc.', 16, 1);
insert into Wards (Name, Places, DepartmentId) values ('Ascend Laboratories, LLC', 6, 2);
insert into Wards (Name, Places, DepartmentId) values ('Lil'' Drug Store Products, Inc', 19, 10);
insert into Wards (Name, Places, DepartmentId) values ('Crosstex International Inc.', 20, 7);
insert into Wards (Name, Places, DepartmentId) values ('Accord Healthcare Inc.', 30, 15);
insert into Wards (Name, Places, DepartmentId) values ('Jubilant HollisterStier LLC', 25, 8);
insert into Wards (Name, Places, DepartmentId) values ('Physicians Total Care, Inc.', 17, 8);
insert into Wards (Name, Places, DepartmentId) values ('Aurobindo Pharma Limited', 10, 1);
insert into Wards (Name, Places, DepartmentId) values ('Watson Laboratories, Inc.', 7, 13);
insert into Wards (Name, Places, DepartmentId) values ('Silarx Pharmaceuticals, Inc', 26, 14);
insert into Wards (Name, Places, DepartmentId) values ('Teva Pharmaceuticals USA Inc', 30, 15);
insert into Wards (Name, Places, DepartmentId) values ('Jubilant HollisterStier LLC', 17, 1);
insert into Wards (Name, Places, DepartmentId) values ('Nelco Laboratories, Inc.', 3, 5);
insert into Wards (Name, Places, DepartmentId) values ('Stat Rx USA', 27, 8);
insert into Wards (Name, Places, DepartmentId) values ('St Marys Medical Park Pharmacy', 9, 13);
insert into Wards (Name, Places, DepartmentId) values ('Genuine First Aid LLC', 11, 2);
insert into Wards (Name, Places, DepartmentId) values ('Hospira, Inc.', 1, 6);
insert into Wards (Name, Places, DepartmentId) values ('Target Corporation', 13, 9);
insert into Wards (Name, Places, DepartmentId) values ('Cardinal Health', 29, 5);
insert into Wards (Name, Places, DepartmentId) values ('Citron Pharma LLC', 16, 5);
insert into Wards (Name, Places, DepartmentId) values ('Pharmaceutics Corporation', 8, 10);
insert into Wards (Name, Places, DepartmentId) values ('Merck Sharp & Dohme Corp.', 29, 14);
insert into Wards (Name, Places, DepartmentId) values ('Rebel Distributors Corp', 23, 1);
insert into Wards (Name, Places, DepartmentId) values ('Rite Aid Corporation', 21, 11);
insert into Wards (Name, Places, DepartmentId) values ('Qualitest Pharmaceuticals', 3, 15);
insert into Wards (Name, Places, DepartmentId) values ('St Marys Medical Park Pharmacy', 24, 8);
insert into Wards (Name, Places, DepartmentId) values ('United Airlines', 13, 6);
insert into Wards (Name, Places, DepartmentId) values ('L Perrigo Company', 21, 14);
insert into Wards (Name, Places, DepartmentId) values ('Alvogen Inc.', 24, 7);
insert into Wards (Name, Places, DepartmentId) values ('REMEDYREPACK INC.', 20, 7);
insert into Wards (Name, Places, DepartmentId) values ('E.R. Squibb & Sons, L.L.C.', 25, 15);
insert into Wards (Name, Places, DepartmentId) values ('Sun Pharma Global FZE', 16, 10);
insert into Wards (Name, Places, DepartmentId) values ('Mallinckrodt, Inc.', 9, 11);
insert into Wards (Name, Places, DepartmentId) values ('Kareway Product, Inc.', 5, 12);
insert into Wards (Name, Places, DepartmentId) values ('Keltman Pharmaceuticals Inc.', 17, 2);
insert into Wards (Name, Places, DepartmentId) values ('AmerisourceBergen', 23, 6);
insert into Wards (Name, Places, DepartmentId) values ('Nelco Laboratories, Inc.', 9, 13);
insert into Wards (Name, Places, DepartmentId) values ('Kroger Company', 21, 5);
insert into Wards (Name, Places, DepartmentId) values ('Ventura International LTD.', 13, 5);
insert into Wards (Name, Places, DepartmentId) values ('Meijer Distribution Inc', 24, 9);
insert into Wards (Name, Places, DepartmentId) values ('REMEDYREPACK INC.', 3, 3);
insert into Wards (Name, Places, DepartmentId) values ('West-Ward Pharmaceutical Corp', 30, 11);
insert into Wards (Name, Places, DepartmentId) values ('Rebel Distributors Corp.', 20, 3);
insert into Wards (Name, Places, DepartmentId) values ('Physicians Total Care, Inc.', 3, 12);
insert into Wards (Name, Places, DepartmentId) values ('Rugby Laboratories Inc.', 22, 3);
insert into Wards (Name, Places, DepartmentId) values ('McKesson Medical-Surgical', 6, 4);
insert into Wards (Name, Places, DepartmentId) values ('PD-Rx Pharmaceuticals, Inc.', 3, 12);
insert into Wards (Name, Places, DepartmentId) values ('Bryant Ranch Prepack', 13, 4);
insert into Wards (Name, Places, DepartmentId) values ('Nelco Laboratories, Inc.', 28, 10);
insert into Wards (Name, Places, DepartmentId) values ('Boots Retail USA Inc', 22, 8);
insert into Wards (Name, Places, DepartmentId) values ('Nelco Laboratories, Inc.', 28, 10);
insert into Wards (Name, Places, DepartmentId) values ('Bryant Ranch Prepack', 17, 12);
insert into Wards (Name, Places, DepartmentId) values ('Sagent Pharmaceuticals', 10, 3);
insert into Wards (Name, Places, DepartmentId) values ('Mondelez Global LLC', 6, 11);
insert into Wards (Name, Places, DepartmentId) values ('Natural Health Supply', 15, 8);
insert into Wards (Name, Places, DepartmentId) values ('Capitol Welders Supply Co., Inc.', 27, 2);
insert into Wards (Name, Places, DepartmentId) values ('NARS Cosmetics', 6, 14);
insert into Wards (Name, Places, DepartmentId) values ('State of Florida DOH Central Pharmacy', 30, 9);
insert into Wards (Name, Places, DepartmentId) values ('CVS', 4, 15);
insert into Wards (Name, Places, DepartmentId) values ('Hospira, Inc.', 13, 4);
insert into Wards (Name, Places, DepartmentId) values ('Amneal Pharmaceuticals of New York, LLC', 17, 2);
insert into Wards (Name, Places, DepartmentId) values ('Carolina Medical Products Company', 24, 7);
insert into Wards (Name, Places, DepartmentId) values ('Bryant Ranch Prepack', 11, 7);
insert into Wards (Name, Places, DepartmentId) values ('BioComp Pharma, Inc.', 22, 9);
insert into Wards (Name, Places, DepartmentId) values ('Physicians Total Care, Inc.', 27, 7);
insert into Wards (Name, Places, DepartmentId) values ('VersaPharm Incorporated', 18, 13);
insert into Wards (Name, Places, DepartmentId) values ('US Pharmaceutical Corporation', 26, 1);
insert into Wards (Name, Places, DepartmentId) values ('Mylan Institutional Inc.', 22, 15);
insert into Wards (Name, Places, DepartmentId) values ('Jubilant HollisterStier LLC', 13, 6);
insert into Wards (Name, Places, DepartmentId) values ('Jubilant HollisterStier LLC', 19, 9);
insert into Wards (Name, Places, DepartmentId) values ('REMEDYREPACK INC.', 6, 5);
insert into Wards (Name, Places, DepartmentId) values ('Army + Air Force Exchange Service', 15, 15);
insert into Wards (Name, Places, DepartmentId) values ('Ricola Ag', 14, 11);
insert into Wards (Name, Places, DepartmentId) values ('Lupin Pharmaceuticals, Inc.', 16, 8);
insert into Wards (Name, Places, DepartmentId) values ('West-ward Pharmaceutical Corp', 11, 3);
insert into Wards (Name, Places, DepartmentId) values ('KC Pharmaceuticals, Inc.', 2, 2);
insert into Wards (Name, Places, DepartmentId) values ('Amylin Pharmaceuticals, LLC', 20, 14);
insert into Wards (Name, Places, DepartmentId) values ('H.J. Harkins Company, Inc.', 10, 12);
insert into Wards (Name, Places, DepartmentId) values ('Qualitest Pharmaceuticals', 29, 13);
insert into Wards (Name, Places, DepartmentId) values ('Bryant Ranch Prepack', 1, 12);
insert into Wards (Name, Places, DepartmentId) values ('Western Family Foods Inc', 30, 4);
insert into Wards (Name, Places, DepartmentId) values ('Nelco Laboratories, Inc.', 17, 4);
insert into Wards (Name, Places, DepartmentId) values ('Mylan Institutional Inc.', 18, 8);
insert into Wards (Name, Places, DepartmentId) values ('AvKARE, Inc.', 13, 10);
insert into Wards (Name, Places, DepartmentId) values ('H.J. Harkins Company, Inc.', 8, 1);
insert into Wards (Name, Places, DepartmentId) values ('State of Florida DOH Central Pharmacy', 23, 5);
insert into Wards (Name, Places, DepartmentId) values ('Healing Natural Oils LLC', 9, 6);
insert into Wards (Name, Places, DepartmentId) values ('American Health Packaging', 2, 13);
insert into Wards (Name, Places, DepartmentId) values ('ESTEE LAUDER INC', 10, 5);
insert into Wards (Name, Places, DepartmentId) values ('GlaxoSmithKline Consumer Healthcare LP', 7, 5);
insert into Wards (Name, Places, DepartmentId) values ('Native Remedies, LLC', 24, 1);
insert into Wards (Name, Places, DepartmentId) values ('NATURE REPUBLIC CO., LTD.', 8, 13);
insert into Wards (Name, Places, DepartmentId) values ('Merck Sharp & Dohme Corp.', 21, 1);
insert into Wards (Name, Places, DepartmentId) values ('Zhejiang Blue Dream Cosmetics Co., Ltd.', 14, 7);
insert into Wards (Name, Places, DepartmentId) values ('Aidarex Pharmaceuticals LLC', 22, 5);
insert into Wards (Name, Places, DepartmentId) values ('Market Basket', 1, 11);
insert into Wards (Name, Places, DepartmentId) values ('Nelco Laboratories, Inc.', 15, 9);
insert into Wards (Name, Places, DepartmentId) values ('KVK-Tech, Inc.', 17, 13);
insert into Wards (Name, Places, DepartmentId) values ('Aidarex Pharmaceuticals LLC', 11, 12);
insert into Wards (Name, Places, DepartmentId) values ('Aidarex Pharmaceuticals LLC', 10, 14);
insert into Wards (Name, Places, DepartmentId) values ('AstraZeneca LP', 30, 10);
insert into Wards (Name, Places, DepartmentId) values ('Cardinal Health', 14, 6);
insert into Wards (Name, Places, DepartmentId) values ('Teva Pharmaceuticals USA Inc', 16, 12);
insert into Wards (Name, Places, DepartmentId) values ('Cardinal Health', 13, 11);
insert into Wards (Name, Places, DepartmentId) values ('Zydus Pharmaceuticals (USA) Inc.', 21, 6);
insert into Wards (Name, Places, DepartmentId) values ('Theraplex Solutions', 15, 15);
insert into Wards (Name, Places, DepartmentId) values ('EQUALINE (SuperValu)', 9, 3);
insert into Wards (Name, Places, DepartmentId) values ('Amerisource Bergen', 13, 10);
insert into Wards (Name, Places, DepartmentId) values ('Amerisource Bergen', 26, 10);
insert into Wards (Name, Places, DepartmentId) values ('Amerisource Bergen', 19, 7);
insert into Wards (Name, Places, DepartmentId) values ('Physicians Total Care, Inc.', 20, 12);
insert into Wards (Name, Places, DepartmentId) values ('St Marys Medical Park Pharmacy', 22, 10);
insert into Wards (Name, Places, DepartmentId) values ('Insight Pharmaceuticals', 22, 1);
insert into Wards (Name, Places, DepartmentId) values ('GREENBRIER INTERNATIONAL INC', 14, 14);
insert into Wards (Name, Places, DepartmentId) values ('Jubilant HollisterStier LLC', 11, 4);
insert into Wards (Name, Places, DepartmentId) values ('Sandoz Inc', 22, 6);
insert into Wards (Name, Places, DepartmentId) values ('Nelco Laboratories, Inc.', 22, 2);
insert into Wards (Name, Places, DepartmentId) values ('Golden State Medical Supply, Inc.', 1, 9);
insert into Wards (Name, Places, DepartmentId) values ('Ventura Corporation Ltd. (San Juan, P.R)', 10, 6);
insert into Wards (Name, Places, DepartmentId) values ('Wise Woman Herbals', 14, 5);
insert into Wards (Name, Places, DepartmentId) values ('Eight and Company', 1, 3);
insert into Wards (Name, Places, DepartmentId) values ('Wal-Mart Stores Inc', 28, 3);
insert into Wards (Name, Places, DepartmentId) values ('L''Oreal USA Products Inc', 22, 7);
insert into Wards (Name, Places, DepartmentId) values ('REMEDYREPACK INC.', 6, 4);
insert into Wards (Name, Places, DepartmentId) values ('Hospira, Inc', 30, 2);
insert into Wards (Name, Places, DepartmentId) values ('Church & Dwight Co., Inc.', 27, 4);
insert into Wards (Name, Places, DepartmentId) values ('Lupin Pharmaceuticals, Inc.', 21, 4);
insert into Wards (Name, Places, DepartmentId) values ('Allergy Laboratories, Inc.', 3, 3);
insert into Wards (Name, Places, DepartmentId) values ('Mylan Pharmaceuticals Inc.', 4, 5);
insert into Wards (Name, Places, DepartmentId) values ('REMEDYREPACK INC.', 23, 4);
insert into Wards (Name, Places, DepartmentId) values ('Dispensing Solutions, Inc.', 1, 11);
insert into Wards (Name, Places, DepartmentId) values ('AvKARE, Inc.', 26, 8);
insert into Wards (Name, Places, DepartmentId) values ('NCS HealthCare of KY, Inc dba Vangard Labs', 30, 11);
insert into Wards (Name, Places, DepartmentId) values ('Cardinal Health', 1, 12);
insert into Wards (Name, Places, DepartmentId) values ('CHANEL PARFUMS BEAUTE', 2, 2);
insert into Wards (Name, Places, DepartmentId) values ('NCS HealthCare of KY, Inc dba Vangard Labs', 16, 9);
insert into Wards (Name, Places, DepartmentId) values ('Rugby Laboratories, Inc.', 10, 5);
insert into Wards (Name, Places, DepartmentId) values ('Torrent Pharmaceuticals Limited', 22, 9);
insert into Wards (Name, Places, DepartmentId) values ('Natural Health Supply', 26, 5);
insert into Wards (Name, Places, DepartmentId) values ('Nelco Laboratories, Inc.', 28, 15);
insert into Wards (Name, Places, DepartmentId) values ('Physicians Total Care, Inc.', 27, 13);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:24', '10:03', 19, 54, 35);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:58', '12:03', 29, 84, 83);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:10', '12:06', 30, 50, 14);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:25', '9:55', 9, 85, 68);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:56', '11:07', 38, 71, 53);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:08', '15:17', 6, 23, 39);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:19', '9:08', 11, 10, 67);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:37', '10:41', 39, 81, 32);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:02', '15:04', 9, 10, 16);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:57', '11:33', 9, 30, 1);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:11', '9:48', 37, 83, 25);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:52', '17:51', 9, 18, 67);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:37', '8:38', 38, 88, 5);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:14', '17:49', 35, 14, 80);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:42', '9:08', 14, 7, 29);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:57', '15:36', 6, 60, 33);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:25', '11:22', 45, 66, 44);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:19', '9:27', 19, 78, 65);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:31', '10:10', 42, 68, 53);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:12', '12:55', 37, 27, 81);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:48', '8:43', 31, 21, 69);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:30', '9:04', 39, 47, 57);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:15', '12:41', 20, 6, 54);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:17', '9:16', 16, 72, 41);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:59', '12:04', 5, 89, 42);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:41', '9:49', 3, 87, 50);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:03', '13:03', 5, 34, 27);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:58', '9:52', 34, 1, 38);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:02', '10:27', 3, 93, 23);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:37', '12:59', 25, 2, 57);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:28', '9:09', 33, 62, 61);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:39', '10:22', 34, 68, 32);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:05', '11:08', 32, 46, 67);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:05', '12:43', 20, 9, 72);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:21', '11:56', 9, 5, 42);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:12', '9:12', 45, 91, 86);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:06', '11:20', 8, 60, 98);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:49', '12:53', 39, 46, 29);
insert into DoctorsExaminations (EndTime, StartTime, DoctorId, ExaminationId, WardId) values ('11:44', '12:57', 24, 92, 37);
INSERT INTO Wards (Name, Places, DepartmentId) VALUES ('SUPER NEW', 120, 13);