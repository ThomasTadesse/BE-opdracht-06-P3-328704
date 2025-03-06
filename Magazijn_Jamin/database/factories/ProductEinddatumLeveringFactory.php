<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\ProductEinddatumLevering;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\ProductEinddatumLevering>
 */
class ProductEinddatumLeveringFactory extends Factory
{
    private static $index = 0;

    private static $einddatumLeveringen = [
        [
            'ProductId' => 1,
            'EinddatumLevering' => '2024-06-01',
            'IsActief' => 1,
            'Opmerkingen' => null,
            'DatumAangemaakt' => '2024-11-22 00:00:00',
            'DatumGewijzigd' => '2024-11-22 00:00:00',
        ],
        [
            'ProductId' => 2,
            'EinddatumLevering' => '2024-05-22',
            'IsActief' => 1,
            'Opmerkingen' => null,
            'DatumAangemaakt' => '2024-11-22 00:00:00',
            'DatumGewijzigd' => '2024-11-22 00:00:00',
        ],
        [
            'ProductId' => 3,
            'EinddatumLevering' => '2024-05-30',
            'IsActief' => 1,
            'Opmerkingen' => null,
            'DatumAangemaakt' => '2024-11-22 00:00:00',
            'DatumGewijzigd' => '2024-11-22 00:00:00',
        ],
        [
            'ProductId' => 4,
            'EinddatumLevering' => '2024-05-12',
            'IsActief' => 1,
            'Opmerkingen' => null,
            'DatumAangemaakt' => '2024-11-22 00:00:00',
            'DatumGewijzigd' => '2024-11-22 00:00:00',
        ],
        [
            'ProductId' => 7,
            'EinddatumLevering' => '2024-05-27',
            'IsActief' => 1,
            'Opmerkingen' => null,
            'DatumAangemaakt' => '2024-11-22 00:00:00',
            'DatumGewijzigd' => '2024-11-22 00:00:00',
        ],
        [
            'ProductId' => 10,
            'EinddatumLevering' => '2024-05-03',
            'IsActief' => 1,
            'Opmerkingen' => null,
            'DatumAangemaakt' => '2024-11-22 00:00:00',
            'DatumGewijzigd' => '2024-11-22 00:00:00',
        ],
        [
            'ProductId' => 11,
            'EinddatumLevering' => '2024-02-09',
            'IsActief' => 1,
            'Opmerkingen' => null,
            'DatumAangemaakt' => '2024-11-22 00:00:00',
            'DatumGewijzigd' => '2024-11-22 00:00:00',
        ],
        [
            'ProductId' => 14,
            'EinddatumLevering' => '2024-01-01',
            'IsActief' => 1,
            'Opmerkingen' => null,
            'DatumAangemaakt' => '2024-11-22 00:00:00',
            'DatumGewijzigd' => '2024-11-22 00:00:00',
        ],
    ];

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $einddatumLevering = self::$einddatumLeveringen[self::$index];
        self::$index = (self::$index + 1) % count(self::$einddatumLeveringen);
        return $einddatumLevering;
    }
}