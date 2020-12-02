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

    public function test($diagram, $allFees = False) {
        $bills = Bill::all()->sortBy('settlement_date')->reverse()->take(12)->reverse();
        $months = [];
        $sums = [];
        if ($allFees) {
            $cold_water = [];
            $hot_water = [];
            $gas = [];
            $electricity = [];
        }
        $month = '';
        foreach ($bills as $bill) {
            $num = date("m", strtotime($bill -> settlement_date));
            switch ($num) {
                case 1:
                    $month = 'Styczeń';
                break;
                case 2:
                    $month = 'Luty';
                break;
                case 3:
                    $month = 'Marzec';
                break;
                case 4:
                    $month = 'Kwiecień';
                break;
                case 5:
                    $month = 'Maj';
                break;
                case 6:
                    $month = 'Czerwiec';
                break;
                case 7:
                    $month = 'Lipiec';
                break;
                case 8:
                    $month = 'Sierpień';
                break;
                case 9:
                    $month = 'Wrzesień';
                break;
                case 10:
                    $month = 'Październik';
                break;
                case 11:
                    $month = 'Listopad';
                break;
                case 12:
                    $month = 'Grudzień';
                break;
            }
            array_push($sums, $bill -> sum);
            array_push($months, $month);
            if ($allFees) {
                if ($bill -> cold_water) {
                    array_push($cold_water, $bill -> cold_water);
                }
                if ($bill -> hot_water) {
                    array_push($hot_water, $bill -> hot_water);
                }
                if ($bill -> gas) {
                    array_push($hot_water, $bill -> gas);
                }
                if ($bill -> electricity) {
                    array_push($hot_water, $bill -> electricity);
                }
            }
        }

        $names = [];
        $costs = [];

       $lastBill = $bills->last();
       if ($lastBill -> rental_price) {
           array_push($names, 'Cena wynajmu');
           array_push($costs, $lastBill -> rental_price);
       }
       if ($lastBill -> cold_water) {
        array_push($names, 'Woda zimna');
        array_push($costs, $lastBill -> cold_water);
        }
        if ($lastBill -> hot_water) {
            array_push($names, 'Woda ciepła');
            array_push($costs, $lastBill -> hot_water);
        }
        if ($lastBill -> gas) {
            array_push($names, 'Gaz');
            array_push($costs, $lastBill -> gas);
        }
        if ($lastBill -> electricity) {
            array_push($names, 'Prąd');
            array_push($costs, $lastBill -> electricity);
        }
        if ($lastBill -> rubbish) {
            array_push($names, 'Śmieci');
            array_push($costs, $lastBill -> rubbish);
        }
        if ($lastBill -> internet) {
            array_push($names, 'Internet');
            array_push($costs, $lastBill -> internet);
        }
        if ($lastBill -> tv) {
            array_push($names, 'Telewizja');
            array_push($costs, $lastBill -> tv);
        }
        if ($lastBill -> phone) {
            array_push($names, 'Telefon');
            array_push($costs, $lastBill -> phone);
        }

        switch ($diagram) {
            case 1:
            // Circle Diagram
                $chart = Chartisan::build()
                ->labels($names)
                ->dataset('', $costs)
                ->toJSON();
            break;
            // Cost of single media
            case 2:
                $chart = Chartisan::build()
                ->labels($months)
                ->dataset('Woda zimna', $cold_water)
                ->toJSON();
            break;
            case 3:
                $chart = Chartisan::build()
                ->labels(['Listopad', 'Grudzień', 'Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec', 'Lipiec', 'Sierpień', 'Październik', 'Listopad'])
                ->dataset('', [3500, 3000, 2700, 2550, 2879, 2329, 2540, 2570, 2602, 2832, 2994, 3320])
                ->toJSON();
            break;
            // Single Apartment
            case 4:
                $chart = Chartisan::build()
                ->labels($months)
                ->dataset('Suma rachunku', $sums)
                ->toJSON();
            break;
        }

        return $chart;
    }
}
