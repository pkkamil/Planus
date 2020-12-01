<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Apartment;
use Chartisan\PHP\Chartisan;


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

    public function apartmentDetails($id) {
        $apartment = Auth::user() -> apartments -> where('id_apartment', $id);
        if (count($apartment) == 0) {
            $apartment = Auth::user() -> residents -> where('id_apartment', $id);
            if (!count($apartment) == 0) {
                if (Auth::id() == $apartment->first() -> pivot -> user_id) {
                    return view('apartmentDetails')->with('apartment', $apartment->first());
                }
            }
        } else {
            $apartment = Apartment::find($id);
            if ($apartment -> user_id == Auth::id()) {
                return view('apartmentDetails')->with('apartment', $apartment);
            }
        }

        return redirect('/panel');
    }

    public function test($diagram) {
        switch ($diagram) {
            case 1:
                $chart = Chartisan::build()
                ->labels(['Cena wynajmu', 'Woda zimna', 'Woda ciepła', 'Gaz', 'Prąd', 'Śmieci', 'Internet', 'Telewizja', 'Telefon'])
                ->dataset('', [2500, 200, 300, 150, 100, 75, 50, 50, 20])
                ->toJSON();
            break;
            case 2:
                $chart = Chartisan::build()
                ->labels(['11', '12', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'])
                ->dataset('', [3500, 3000, 2700, 2550, 2879, 2329, 2540, 2570, 2602, 2832, 2994, 3320])
                ->toJSON();
            break;
            case 3:
                $chart = Chartisan::build()
                ->labels(['Listopad', 'Grudzień', 'Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec', 'Lipiec', 'Sierpień', 'Październik', 'Listopad'])
                ->dataset('', [3500, 3000, 2700, 2550, 2879, 2329, 2540, 2570, 2602, 2832, 2994, 3320])
                ->toJSON();
            break;
        }

        return $chart;
    }
}
