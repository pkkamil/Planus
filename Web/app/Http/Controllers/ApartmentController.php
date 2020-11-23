<?php

namespace App\Http\Controllers;

use App\Apartment;
use Illuminate\Http\Request;

class ApartmentController extends Controller
{
    public function index() {
        $apartments = Apartment::paginate(11);
        return view('home', compact('apartments'));
    }
}
