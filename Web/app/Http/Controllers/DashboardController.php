<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Apartment;
use Chartisan\PHP\Chartisan;
use App\Bill;

class DashboardController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index() {
        $owners = Auth::user() -> apartments;
        $rented = Auth::user() -> residents;
        $apartments = $owners->concat($rented)->sortBy('created_at')->reverse()->take(3);
        return view('dashboard')->with('apartments', $apartments);
    }

    public function showAll() {
        $owners = Auth::user() -> apartments;
        $rented = Auth::user() -> residents;
        $apartments = $owners->concat($rented)->sortBy('created_at')->reverse();
        return view('showAll')->with('apartments', $apartments);
    }

}
