<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Apartment extends Model
{
    protected $primaryKey = 'id_apartment';

    public function roommates() {
        return $this->belongsToMany('App\User');
    }

    public function bills() {
        return $this->hasMany('App\Bill', 'id_apartment');
    }

    public function counters() {
        return $this->hasMany('App\Counter', 'id_apartment');
    }
}
