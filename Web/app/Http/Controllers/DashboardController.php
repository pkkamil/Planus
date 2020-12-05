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
    public function index()
    {
        $owners = Auth::user() -> apartments;
        // $owners = Apartment::where('user_id', Auth::id())->orderBy('created_at')->get();
        $rented = Auth::user() -> residents;
        $apartments = $owners->concat($rented)->sortBy('created_at');
        return view('dashboard')->with('apartments', $apartments->reverse());
    }

}
