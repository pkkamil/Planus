<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Counter extends Model
{
    public function bill() {
        return $this->belongsTo('App\Bill');
    }

    public function apartment() {
        return $this->belongsTo('App\Apartment');
    }
}
