<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    use HasFactory;
    protected $table = 'productos';
    public $timestamps = false;
    protected $primaryKey = 'cod_producto';
    public $incrementing = true;
    protected $keyType = 'string';

    public function categoria(){
        return $this->belongsTo(Categoria::class, 'categoria_id');
    }
}
