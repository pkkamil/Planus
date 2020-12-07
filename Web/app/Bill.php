<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Bill extends Model
{
    protected $primaryKey = 'id_bill';

    public function additional_fees() {
        return $this->hasMany('App\Fee');
    }

    public function apartment() {
        return $this->belongsTo('App\Apartment');
    }

    public $timestamps = false;
}
