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

 	DROP PROCEDURE IF EXISTS spGetProductAllergenen;
            CREATE PROCEDURE spGetProductAllergenen(
                IN productId INT
            )
            BEGIN
                SELECT 
                    P.Naam AS ProductNaam,
                    P.Barcode,
                    A.Naam AS AllergeenNaam
                FROM 
                    Product P
                LEFT JOIN 
                    ProductPerAllergeen PPA ON P.Id = PPA.ProductId
                LEFT JOIN 
                    Allergeen A ON PPA.AllergeenId = A.Id
                WHERE 
                    P.IsActief = 1
                    AND P.Id = productId
                ORDER BY 
                    P.Naam ASC;
            END;