<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Apartment;
use Chartisan\PHP\Chartisan;
use App\Bill;
use Datetime;

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
        $apartments = $owners->concat($rented)->sortBy('created_at')->reverse();
        $soon = [];
        foreach ($apartments as $apartment) {
            $today = new Datetime();
            $settlement_day = $apartment -> settlement_day;
            $settlement_date = new DateTime();
            $settlement_date = $settlement_day.'-'.$settlement_date -> format('m').'-'.$settlement_date -> format('Y');
            $to_date = new DateTime($settlement_date);
            $days = $today -> diff($to_date)->d;
            if ($to_date -> format('d') === $today -> format('d')) {
                array_push($soon, 'Dzisiaj wypada termin rozliczenia mieszkania <span class="orange-text">'.$apartment -> name.'</span>');
            } else if ($days < 4 and $days > 1) {
                array_push($soon, 'Zbliża się termin rozliczenia mieszkania <span class="orange-text">'.$apartment -> name.'</span>');
            }
        }
        $apartments = $apartments->take(3);
        return view('dashboard', compact('apartments', 'soon'));
    }

    public function showAll() {
        $owners = Auth::user() -> apartments;
        $rented = Auth::user() -> residents;
        $apartments = $owners->concat($rented)->sortBy('created_at')->reverse();
        return view('showAll')->with('apartments', $apartments);
    }

}
