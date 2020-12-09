<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Apartment;
use Chartisan\PHP\Chartisan;
use App\Bill;
use Datetime;
use App\Counter;

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
        if (count($apartments) == 1) {
            // left to the settlement date
            $updated_date_month = $apartments -> first() -> updated_at -> format('m');
            $updated_date_year = $apartments -> first() -> updated_at -> format('Y');
            $updated_date = $updated_date_year.'-'.$updated_date_month.'-'.$apartments -> first() -> settlement_day;
            $remaining_billing_period = date('Y-m-d', strtotime('+'.strval($apartments -> first() -> billing_period).' months', strtotime($updated_date)));
            $from_date = new DateTime();
            $to_date = new DateTime($remaining_billing_period);
            $interval_to_end = $from_date -> diff($to_date);
            if ($interval_to_end -> y > 0) {
                $interval_to_end = $interval_to_end -> y * 12 + $interval_to_end -> m;
            } else {
                $interval_to_end = $interval_to_end -> m;
            }
            $settlement_day = $apartments -> first() -> settlement_day;
            $settlement_date = new DateTime(now());
            $settlement_date = $settlement_day.'-'.$settlement_date -> format('m').'-'.$settlement_date -> format('Y');
            $to_date = new DateTime($settlement_date);
            if ($to_date -> format('d') === $from_date -> format('d')) {
                $days = -1;
            } else {
                $from_date = new DateTime();
                $interval = $from_date -> diff($to_date);
                if ($interval -> invert == 1) {
                    $settlement_date = date('Y-m-d', strtotime('+1 month', strtotime($settlement_date)));
                    $to_date = new DateTime($settlement_date);
                    $interval = $from_date -> diff($to_date);
                }
                $days = $interval -> d;
            }

            // Overdue
            $lastCounter = Counter::select('created_at')->where('id_apartment', $apartments -> first() -> id_apartment)->orderBy('created_at', 'desc')->get();
            if (count($lastCounter) != 0) {
                $from_date = new DateTime();
                $to_date = new DateTime($lastCounter->first() -> created_at);
                $lastCounter = $from_date -> diff($to_date);
                if ($lastCounter -> m > 0) {
                    $overdue = True;
                } else {
                    $overdue = False;
                }
            } else {
                $updated_at = $apartments -> first() -> updated_at;
                $today = new DateTime();
                $has_passed = $updated_at -> diff($today);
                if ($has_passed -> m > 0) {
                    $overdue = True;
                } else {
                    $overdue = False;
                }
            }
            // Count Bills
            $bills = Bill::where('id_apartment', $apartments -> first() -> id_apartment)->get();
            $bills = count($bills);

            return view('dashboard', compact('apartments', 'bills', 'days', 'interval_to_end'));

        } else {
                foreach ($apartments as $apartment) {
                    $today = new Datetime();
                    $settlement_day = $apartment -> settlement_day;
                    $settlement_date = new DateTime();
                    $settlement_date = $settlement_day.'-'.$settlement_date -> format('m').'-'.$settlement_date -> format('Y');
                    $to_date = new DateTime($settlement_date);
                    $days = $today -> diff($to_date)->d;
                    if ($to_date -> format('d') == $today -> format('d')) {
                        array_push($soon, 'Dzisiaj wypada termin rozliczenia mieszkania <span class="orange-text">'.$apartment -> name.'</span>');
                    } else if ($days < 4 and $days >= 0) {
                        array_push($soon, 'Zbliża się termin rozliczenia mieszkania <span class="orange-text">'.$apartment -> name.'</span>');
                    }
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
