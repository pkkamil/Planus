<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Apartment extends Model
{
    protected $primaryKey = 'id_apartment';

    public function roommates()
    {
        return $this->hasMany('App\User');
    }
}
