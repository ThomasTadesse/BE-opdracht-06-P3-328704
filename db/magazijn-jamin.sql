-- ********************************************************
-- Version:       Date:       Author:           
-- ********       ****        *******         
-- 01             22-11-2024  Thomas Tadesse
-- ********************************************************

CREATE DATABASE IF NOT EXISTS `magazijn-jamin` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `magazijn-jamin`;
-- --------------------------------------------------------

-- Step 01:
-- Goal: Create a new table Product
-- ********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    New table
-- ********************************************************

DROP TABLE IF EXISTS Product;

CREATE TABLE IF NOT EXISTS Product
(
     Id              MEDIUMINT             UNSIGNED        NOT NULL      AUTO_INCREMENT
    ,Naam            VARCHAR(255)                          NOT NULL
    ,Barcode         VARCHAR(13)                           NOT NULL
    ,IsActief        BIT                                   NOT NULL      DEFAULT 1
    ,Opmerkingen     VARCHAR(255)                              NULL      DEFAULT NULL
    ,DatumAangemaakt Datetime(6)                           NOT NULL
    ,DatumGewijzigd  Datetime(6)                           NOT NULL
    ,CONSTRAINT      PK_Product_Id        PRIMARY KEY CLUSTERED (Id)
) ENGINE=InnoDB   AUTO_INCREMENT=1;


-- Step: 02
-- Goal: Fill table Product with data
-- ***********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    Insert Records
-- ***********************************************************

INSERT INTO Product
(
     Naam
    ,Barcode
    ,IsActief
    ,Opmerkingen
    ,DatumAangemaakt
    ,DatumGewijzigd
)
VALUES
    ('Mintnopjes', '8719587231278', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Schoolkrijt', '8719587326713', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Honingdrop', '8719587327836', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Zure Beren', '8719587321441', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Cola Flesjes', '8719587321237', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Turtles', '8719587322245', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Witte Muizen', '8719587328256', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Reuzen Slangen', '8719587325641', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Zoute Rijen', '8719587322739', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Winegums', '8719587327527', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Drop Munten', '8719587322345', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Kruis Drop', '8719587322265', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Zoute Ruitjes', '8719587323256', 1, NULL, SYSDATE(6), SYSDATE(6)),
    ('Drop ninja’s', '8719587323277', 1, NULL, SYSDATE(6), SYSDATE(6));

-- Step 03:
-- Goal: Create a new table Magazijn
-- ********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    New table
-- ********************************************************

DROP TABLE IF EXISTS Magazijn;
CREATE TABLE IF NOT EXISTS Magazijn
(
     Id                   MEDIUMINT       UNSIGNED          NOT NULL      AUTO_INCREMENT
    ,ProductId            MEDIUMINT       UNSIGNED          NOT NULL
    ,VerpakkingsEenheid   DECIMAL(4,1)                      NOT NULL
    ,AantalAanwezig       SMALLINT        UNSIGNED          NOT NULL
    ,IsActief             BIT                               NOT NULL      DEFAULT 1
    ,Opmerkingen          VARCHAR(255)                          NULL      DEFAULT NULL
    ,DatumAangemaakt      Datetime(6)                       NOT NULL
    ,DatumGewijzigd       Datetime(6)                       NOT NULL
    ,CONSTRAINT           PK_Magazijn_Id  PRIMARY KEY CLUSTERED (Id)
    ,CONSTRAINT           FK_Magazijn_ProductId_Product_Id  FOREIGN KEY (ProductId) REFERENCES Product(Id)
) ENGINE=InnoDB   AUTO_INCREMENT=1;

-- Step: 04
-- Goal: Fill table Magazijn with data
-- ***********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    Insert Records
-- ***********************************************************

INSERT INTO Magazijn
(
     ProductId
    ,VerpakkingsEenheid
    ,AantalAanwezig
    ,IsActief
    ,Opmerkingen
    ,DatumAangemaakt
    ,DatumGewijzigd
)
VALUES
    (1, 5, 453, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (2, 2.5, 400, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (3, 5, 1, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (4, 1, 800, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (5, 3, 234, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (6, 2, 345, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (7, 1, 795, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (8, 10, 233, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (9, 2.5, 123, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (10, 3, 0, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (11, 2, 367, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (12, 1, 467, 1, NULL, SYSDATE(6), SYSDATE(6)),
    (13, 5, 20, 1, NULL, SYSDATE(6), SYSDATE(6));


-- Step: 04
-- Goal: Create a new table Contact
-- ***********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             13-12-2024  Thomas Tadesse    New table
-- ***********************************************************

CREATE TABLE IF NOT EXISTS Contact
(
     Id                             SMALLINT       UNSIGNED          NOT NULL      AUTO_INCREMENT
    ,Straat                         VARCHAR(60)                       NOT NULL
    ,Huisnummer                     VARCHAR(10)                       NOT NULL
    ,Postcode                       VARCHAR(6)                        NOT NULL
    ,Stad                           VARCHAR(60)                       NOT NULL
    ,IsActief                       BIT                               NOT NULL      DEFAULT 1
    ,Opmerkingen                    VARCHAR(255)                          NULL      DEFAULT NULL
    ,DatumAangemaakt                Datetime(6)                       NOT NULL
    ,DatumGewijzigd                 Datetime(6)                       NOT NULL
    ,CONSTRAINT           PK_Contact_Id  PRIMARY KEY CLUSTERED (Id)
) ENGINE=InnoDB   AUTO_INCREMENT=1;


-- Step: 05
-- Goal: Fill table Contact with data
-- ***********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             13-12-2024  Thomas Tadesse    Insert Records
-- ***********************************************************

INSERT INTO Contact
(
    Straat
    ,Huisnummer
    ,Postcode
    ,Stad
    ,IsActief
    ,Opmerkingen
    ,DatumAangemaakt
    ,DatumGewijzigd
)
VALUES
  ('Van Gilslaan', '34', '1045CB', 'Hilvarenbeek', 1, NULL, SYSDATE(6), SYSDATE(6)),
  ('Den Dolderpad', '2', '1067RC', 'Utrecht', 1, NULL, SYSDATE(6), SYSDATE(6)),
  ('Fredo Raalteweg', '257', '1236OP', 'Nijmegen', 1, NULL, SYSDATE(6), SYSDATE(6)),
  ('Bertrand Russellhof', '21', '2034AP', 'Den Haag', 1, NULL, SYSDATE(6), SYSDATE(6)),
  ('Leon van Bonstraat', '213', '145XC', 'Lunteren', 1, NULL, SYSDATE(6), SYSDATE(6)),
  ('Bea van Lingenlaan', '234', '2197FG', 'Sint Pancras', 1, NULL, SYSDATE(6), SYSDATE(6));

-- Step 05:
-- Goal: Create a new table Leverancier
-- ********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    New table
-- ********************************************************

DROP TABLE IF EXISTS Leverancier;

CREATE TABLE IF NOT EXISTS Leverancier
(
     Id                 SMALLINT             UNSIGNED        NOT NULL      AUTO_INCREMENT
    ,ContactId          SMALLINT             UNSIGNED        NOT NULL
    ,Naam               VARCHAR(60)                          NOT NULL
    ,Contactpersoon     VARCHAR(60)                          NOT NULL
    ,Leveranciernummer  VARCHAR(11)                          NOT NULL
    ,Mobiel             VARCHAR(11)                          NOT NULL
    ,IsActief           BIT                                  NOT NULL      DEFAULT 1
    ,Opmerkingen        VARCHAR(255)                             NULL      DEFAULT NULL
    ,DatumAangemaakt Datetime(6)                             NOT NULL
    ,DatumGewijzigd  Datetime(6)                             NOT NULL
    ,CONSTRAINT      PK_Leverancier_Id        PRIMARY KEY CLUSTERED (Id)
    ,CONSTRAINT      FK_Leverancier_ContactId_Contact_Id  FOREIGN KEY (ContactId) REFERENCES Contact (Id)
) ENGINE=InnoDB   AUTO_INCREMENT=1;


-- Step: 06
-- Goal: Fill table Levrancier with data
-- ***********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    Insert Records
-- ***********************************************************

INSERT INTO Leverancier
(
    ContactId
    ,Naam
    ,Contactpersoon
    ,Leveranciernummer
    ,Mobiel
    ,IsActief
    ,Opmerkingen
    ,DatumAangemaakt
    ,DatumGewijzigd
)
VALUES
    (1,'Venco', 'Bert van Linge', 'L1029384719', '06-28493827', 1, NULL, SYSDATE(6), SYSDATE(6)),
    (2,'Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398734', 1, NULL, SYSDATE(6), SYSDATE(6)),
    (3,'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', 1, NULL, SYSDATE(6), SYSDATE(6)),
    (4,'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', 1, NULL, SYSDATE(6), SYSDATE(6)),
    (5,'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', 1, NULL, SYSDATE(6), SYSDATE(6)),
    (6,'Quality Street', 'Johan Nooij', 'L1029234586', '06-23458456', 1, NULL, SYSDATE(6), SYSDATE(6)),
    (7,'Hom Ken Food', 'Hom Ken', 'L1029234599', '06-23458477', 1, NULL, SYSDATE(6), SYSDATE(6));




-- Step 07:
-- Goal: Create a new table ProductPerLeverancier
-- ********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    New table
-- ********************************************************

CREATE TABLE IF NOT EXISTS ProductPerLeverancier
(
     Id                             MEDIUMINT       UNSIGNED          NOT NULL      AUTO_INCREMENT
    ,LeverancierId                  SMALLINT        UNSIGNED          NOT NULL
    ,ProductId                      MEDIUMINT       UNSIGNED          NOT NULL
    ,DatumLevering                  DATE                              NOT NULL
    ,Aantal                         INT             UNSIGNED          NOT NULL
    ,DatumEerstVolgendeLevering     DATE                                  NULL
    ,IsActief                       BIT                               NOT NULL      DEFAULT 1
    ,Opmerkingen                    VARCHAR(255)                          NULL      DEFAULT NULL
    ,DatumAangemaakt                Datetime(6)                       NOT NULL
    ,DatumGewijzigd                 Datetime(6)                       NOT NULL
    ,CONSTRAINT           PK_ProductPerLeverancier_Id  PRIMARY KEY CLUSTERED (Id)
    ,CONSTRAINT           FK_ProductPerLeverancier_LeverancierId_Leverancier_Id  FOREIGN KEY (LeverancierId) REFERENCES Leverancier (Id)
) ENGINE=InnoDB   AUTO_INCREMENT=1;



-- Step: 08
-- Goal: Fill table ProductPerLeverancier with data
-- ***********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    Insert Records
-- ***********************************************************

INSERT INTO ProductPerLeverancier
(
     LeverancierId
    ,ProductID
    ,DatumLevering
    ,Aantal
    ,DatumEerstVolgendeLevering
    ,IsActief
    ,Opmerkingen
    ,DatumAangemaakt
    ,DatumGewijzigd
)
VALUES
(1, 1, '2024-10-09', 23, '2024-10-16', 1, NULL, SYSDATE(6), SYSDATE(6)),
(1, 1, '2024-10-18', 21, '2024-10-25', 1, NULL, SYSDATE(6), SYSDATE(6)),
(1, 2, '2024-10-09', 12, '2024-10-16', 1, NULL, SYSDATE(6), SYSDATE(6)),
(1, 3, '2024-10-10', 11, '2024-10-17', 1, NULL, SYSDATE(6), SYSDATE(6)),
(2, 4, '2024-10-14', 16, '2024-10-21', 1, NULL, SYSDATE(6), SYSDATE(6)),
(2, 4, '2024-10-21', 23, '2024-10-28', 1, NULL, SYSDATE(6), SYSDATE(6)),
(2, 5, '2024-10-14', 45, '2024-10-21', 1, NULL, SYSDATE(6), SYSDATE(6)),
(2, 6, '2024-10-14', 30, '2024-10-21', 1, NULL, SYSDATE(6), SYSDATE(6)),
(3, 7, '2024-10-12', 12, '2024-10-19', 1, NULL, SYSDATE(6), SYSDATE(6)),
(3, 7, '2024-10-19', 23, '2024-10-26', 1, NULL, SYSDATE(6), SYSDATE(6)),
(3, 8, '2024-10-10', 12, '2024-10-17', 1, NULL, SYSDATE(6), SYSDATE(6)),
(3, 9, '2024-10-11', 1, '2024-10-18', 1, NULL, SYSDATE(6), SYSDATE(6)),
(4, 10, '2024-10-16', 24, '2024-10-30', 1, NULL, SYSDATE(6), SYSDATE(6)),
(5, 11, '2024-10-10', 47, '2024-10-17', 1, NULL, SYSDATE(6), SYSDATE(6)),
(5, 11, '2024-10-19', 60, '2024-10-26', 1, NULL, SYSDATE(6), SYSDATE(6)),
(5, 12, '2024-10-11', 45, NULL, 1, NULL, SYSDATE(6), SYSDATE(6)),
(5, 13, '2024-10-12', 23, NULL, 1, NULL, SYSDATE(6), SYSDATE(6)),
(7, 14, '2024-10-13', 20, NULL, 1, NULL, SYSDATE(6), SYSDATE(6));


-- Step 11:
-- Goal: Create a new table Allergeen
-- ********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    New table
-- ********************************************************

DROP TABLE IF EXISTS Allergeen;

CREATE TABLE IF NOT EXISTS Allergeen
(
     Id                 SMALLINT             UNSIGNED        NOT NULL      AUTO_INCREMENT
    ,Naam               VARCHAR(60)                          NOT NULL
    ,Omschrijving       VARCHAR(60)                          NOT NULL
    ,IsActief           BIT                                  NOT NULL      DEFAULT 1
    ,Opmerkingen        VARCHAR(255)                         NULL      DEFAULT NULL
    ,DatumAangemaakt    Datetime(6)                          NOT NULL
    ,DatumGewijzigd     Datetime(6)                          NOT NULL
    ,CONSTRAINT      PK_Allergeen_Id        PRIMARY KEY CLUSTERED (Id)
) ENGINE=InnoDB   AUTO_INCREMENT=1;


-- Step: 12
-- Goal: Fill table Allergeen with data
-- ***********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    Insert Records
-- ***********************************************************

INSERT INTO Allergeen
(
     Naam
    ,Omschrijving
    ,IsActief
    ,Opmerkingen
    ,DatumAangemaakt
    ,DatumGewijzigd
)
VALUES
     ('Gluten', 'Dit product bevat gluten', 1, NULL, SYSDATE(6), SYSDATE(6))
    ,('Gelatine', 'Dit product bevat gelatine', 1, NULL, SYSDATE(6), SYSDATE(6))
    ,('AZO-Kleurstof', 'Dit product bevat AZO-kleurstoffen', 1, NULL, SYSDATE(6), SYSDATE(6))
    ,('Lactose', 'Dit product bevat lactose', 1, NULL, SYSDATE(6), SYSDATE(6))
    ,('Soja', 'Dit product bevat soja', 1, NULL, SYSDATE(6), SYSDATE(6));



-- Step 09:
-- Goal: Create a new table ProductPerAllergeen
-- ********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    New table
-- ********************************************************

CREATE TABLE IF NOT EXISTS ProductPerAllergeen
(
     Id                             MEDIUMINT       UNSIGNED          NOT NULL      AUTO_INCREMENT
    ,ProductId                      MEDIUMINT       UNSIGNED          NOT NULL
    ,AllergeenId                    SMALLINT        UNSIGNED          NOT NULL
    ,IsActief                       BIT                               NOT NULL      DEFAULT 1
    ,Opmerkingen                    VARCHAR(255)                          NULL      DEFAULT NULL
    ,DatumAangemaakt                Datetime(6)                       NOT NULL
    ,DatumGewijzigd                 Datetime(6)                       NOT NULL
    ,CONSTRAINT           PK_ProductPerAllergeen_Id  PRIMARY KEY CLUSTERED (Id)
    ,CONSTRAINT           FK_ProductPerAllergeen_ProductId_Product_Id  FOREIGN KEY (ProductId) REFERENCES Product (Id)
    ,CONSTRAINT           FK_ProductPerAllergeen_AllergeenId_Allergeen_Id  FOREIGN KEY (AllergeenId) REFERENCES Allergeen (Id)
) ENGINE=InnoDB   AUTO_INCREMENT=1;



-- Step: 10
-- Goal: Fill table ProductPerAllergeen with data
-- ***********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             22-11-2024  Thomas Tadesse    Insert Records
-- ***********************************************************

INSERT INTO ProductPerAllergeen
(
     ProductId
    ,AllergeenId
    ,IsActief
    ,Opmerkingen
    ,DatumAangemaakt
    ,DatumGewijzigd
)
VALUES
  (1, 2, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(1, 1, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(1, 3, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(3, 4, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(6, 5, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(9, 2, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(9, 5, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(10, 2, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(12, 4, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(13, 1, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(13, 4, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(13, 5, 1, NULL, SYSDATE(6), SYSDATE(6))
 ,(14, 5, 1, NULL, SYSDATE(6), SYSDATE(6));



CREATE TABLE ProductEinddatumLevering (
    Id INT NOT NULL AUTO_INCREMENT,
    ProductId INT NOT NULL,
    EinddatumLevering DATE NOT NULL
    ,IsActief                       BIT                               NOT NULL      DEFAULT 1
    ,Opmerkingen                    VARCHAR(255)                          NULL      DEFAULT NULL
    ,DatumAangemaakt                Datetime(6)                       NOT NULL
    ,DatumGewijzigd                 Datetime(6)                       NOT NULL
    PRIMARY KEY (Id),
    FOREIGN KEY (ProductId) REFERENCES Product(Id)
);

INSERT INTO ProductEinddatumLevering (Id, ProductId, EinddatumLevering) VALUES
(1, 1, '2024-06-01'),
(2, 2, '2024-05-22'),
(3, 3, '2024-05-30'),
(4, 4, '2024-05-12'),
(5, 7, '2024-05-27'),
(6, 10, '2024-05-03'),
(7, 11, '2024-02-09'),
(8, 14, '2024-01-01');


COMMIT;

