<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
    use HasFactory;

    protected $table = 'address';

    protected $fillable = [
        'user_id',
        'email',
        'type_address',
        'business_model',
        'status',
        'name_hotel',
        'tel_hotel',
        'address',
      
    ];

    public function saleOrders()
    {
        return $this->hasMany(SaleOrder::class, 'hotel_id');
    }
}
