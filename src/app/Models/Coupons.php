<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Coupons extends Model
{
    use HasFactory;

    // Define the table associated with the model
    protected $table = 'coupons';

    // Specify which attributes are mass assignable
    protected $fillable = [
        'code',
        'description',
        'discount_type',
        'discount_value',
        'start_date',
        'end_date',
        'usage_limit',
    ];

    // If you have timestamps, you can define their format
    const CREATED_AT = 'created_at';
    const UPDATED_AT = 'updated_at';
}
