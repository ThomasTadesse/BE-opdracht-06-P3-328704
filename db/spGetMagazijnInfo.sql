-- ********************************************************
-- Version:       Date:       Author:           
-- ********       ****        *******         
-- 01             03-03-2025  Thomas Tadesse    
-- ********************************************************

USE `magazijn-jamin`;

-- Step 01:
-- Goal: Create a new Stored Procedure that returns products
-- ********************************************************
-- Version:       Date:       Author:           Description
-- ********       ****        *******           ***********
-- 01             03-03-2025  Thomas Tadesse    New Stored Procedure  
-- ********************************************************

 	   DROP PROCEDURE IF EXISTS spGetMagazijnInfo;
            CREATE PROCEDURE spGetMagazijnInfo()
            BEGIN
                SELECT 
                    PRCT.id                   AS Id,
                    PRCT.Naam                 AS ProductNaam,
                    LVR.Naam                  AS LeverancierNaam,
                    LVR.Contactpersoon        AS Contactpersoon,
                    CONT.Stad                  AS Stad,
                    MGZN.AantalAanwezig       AS AantalAanwezig,
                    PRDLV.DatumLevering       AS DatumLevering,
                    PREDL.EinddatumLevering   AS EinddatumLevering
                FROM 
                    Product PRCT
                LEFT JOIN 
                    Magazijn MGZN ON PRCT.Id = MGZN.ProductId
                LEFT JOIN
                    ProductPerLeverancier PRDLV ON PRCT.Id = PRDLV.ProductId
                LEFT JOIN
                    Leverancier LVR ON PRDLV.LeverancierId = LVR.Id
                LEFT JOIN
                    Contact CONT ON LVR.ContactId = CONT.Id
                LEFT JOIN
                    ProductEinddatumLevering PREDL ON PRCT.Id = PREDL.ProductId
                WHERE 
                    PRCT.IsActief = 1
                ORDER BY 
                    LeverancierNaam DESC;
            END;