<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Apartment extends Model
{
    public function roommates()
    {
        return $this->hasMany('App\User');
    }
}
