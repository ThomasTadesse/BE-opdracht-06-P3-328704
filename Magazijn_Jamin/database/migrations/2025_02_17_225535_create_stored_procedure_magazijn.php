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
                    LeverancierNaam DESC;
            END;
        ');

        DB::unprepared('
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
        ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::unprepared('DROP PROCEDURE IF EXISTS spGetMagazijnInfo');
        DB::unprepared('DROP PROCEDURE IF EXISTS spGetProductAllergenen');
    }
};
