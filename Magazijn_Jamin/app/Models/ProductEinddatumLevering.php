<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Task;
use App\Models\Product;

class ProductEinddatumLevering extends Model
{
    use HasFactory;

    protected $table = 'ProductEinddatumLevering';

    protected $primaryKey = 'Id'; 

    public $timestamps = false;

    protected $guarded = [];

    public function product()
    {
        return $this->belongsTo(Product::class, 'ProductId', 'Id');
    }

    public function tasks()
    {
        return $this->hasMany(Task::class);
    }

}   

