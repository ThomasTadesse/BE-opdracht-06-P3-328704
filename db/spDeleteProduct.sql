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

DROP PROCEDURE IF EXISTS spDeleteProduct;
            CREATE PROCEDURE spDeleteProduct(
                IN productId INT
            )
            BEGIN
                UPDATE 
                    Product
                SET 
                    IsActief = 0
                WHERE 
                    Id = productId;
            END;