<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        DB::unprepared('
            DROP PROCEDURE IF EXISTS spGetMagazijnInfo;
            CREATE PROCEDURE spGetMagazijnInfo(
                IN startDate DATE,
                IN endDate DATE
            )
            BEGIN
                SELECT 
                    PRCT.id                   AS Id,
                    PRCT.Naam                 AS ProductNaam,
                    LVR.Naam                  AS LeverancierNaam,
                    LVR.Contactpersoon        AS Contactpersoon,
                    CONT.Stad                 AS Stad,
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
                    AND (startDate IS NULL OR PREDL.EinddatumLevering >= startDate)
                    AND (endDate IS NULL OR PREDL.EinddatumLevering <= endDate)
                ORDER BY 
                    EinddatumLevering DESC;
            END;
        ');

        DB::unprepared('
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
        ');

        DB::unprepared('
            DROP PROCEDURE IF EXISTS spGetProductAllergenen;
            CREATE PROCEDURE spGetProductAllergenen(
                IN productId INT
            )
            BEGIN
                SELECT 
                    P.Id AS Id,
                    P.Naam AS ProductNaam,
                    P.Barcode,
                    MAX(CASE WHEN A.Naam = "Gluten" THEN 1 ELSE 0 END) AS BevatGluten,
                    MAX(CASE WHEN A.Naam = "Gelatine" THEN 1 ELSE 0 END) AS BevatGelatine,
                    MAX(CASE WHEN A.Naam = "AZO-kleurstoffen" THEN 1 ELSE 0 END) AS BevatAZOKleurstoffen,
                    MAX(CASE WHEN A.Naam = "Soja" THEN 1 ELSE 0 END) AS BevatSoja,
                    MAX(CASE WHEN A.Naam = "Lactose" THEN 1 ELSE 0 END) AS BevatLactose
                FROM 
                    Product P
                LEFT JOIN 
                    ProductPerAllergeen PPA ON P.Id = PPA.ProductId
                LEFT JOIN 
                    Allergeen A ON PPA.AllergeenId = A.Id
                WHERE 
                    P.IsActief = 1
                    AND P.Id = productId
                GROUP BY
                    P.Id, P.Naam, P.Barcode;
            END;
        ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::unprepared('DROP PROCEDURE IF EXISTS spGetMagazijnInfo');
        DB::unprepared('DROP PROCEDURE IF EXISTS spDeleteProduct');
        DB::unprepared('DROP PROCEDURE IF EXISTS spGetProductAllergenen');
    }
};
