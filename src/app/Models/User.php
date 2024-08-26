<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    public $timestamps = false;
    protected $table = 'users';

    // Other model properties and methods...
  
    protected $fillable = ['name'];
}
