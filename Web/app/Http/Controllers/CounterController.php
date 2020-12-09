<?php

namespace App\Http\Controllers;

use App\Apartment;
use Illuminate\Http\Request;
use App\Counter;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;
use App\Bill;

class CounterController extends Controller
{
    public function index() {

    }

    public function firstInput($id) {
        $apartment = Apartment::find($id);
        $lastCounter = Counter::select('cold_water', 'hot_water', 'gas', 'electricity')->where('id_apartment', $id)->orderBy('created_at', 'desc')->first();
        if ($lastCounter) {
            if (is_null($apartment -> cold_water) != is_null($lastCounter -> cold_water) or is_null($apartment -> hot_water) != is_null($lastCounter -> hot_water) or is_null($apartment -> gas) != is_null($lastCounter -> gas) or is_null($apartment -> electricity) != is_null($lastCounter -> electricity))
                return view('initialCounters', compact('apartment'));
            else
                return redirect('/panel/mieszkanie/'.$id);
        } else {
            return view('initialCounters', compact('apartment'));
        }
    }

    public function initialCounters(Request $req) {
        $req->validate([
            'cold_water' => [ Rule::requiredIf($req->cold_water), 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'hot_water' => [Rule::requiredIf($req->hot_water), 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'gas' => [Rule::requiredIf($req->gas), 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'electricity' => [Rule::requiredIf($req->electricity), 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
        ]);
        $req -> cold_water = str_replace(',', '.', $req -> cold_water);
        $req -> cold_water = (float)$req -> cold_water;
        $req -> hot_water = str_replace(',', '.', $req -> hot_water);
        $req -> hot_water = (float)$req -> hot_water;
        $req -> gas = str_replace(',', '.', $req -> gas);
        $req -> gas = (float)$req -> gas;
        $req -> electricity = str_replace(',', '.', $req -> electricity);
        $req -> electricity = (float)$req -> electricity;

        $counter = new Counter;
        if ($req -> cold_water)
            $counter -> cold_water = $req -> cold_water;
        if ($req -> hot_water)
            $counter -> hot_water = $req -> hot_water;
        if ($req -> gas)
            $counter -> gas = $req -> gas;
        if ($req -> electricity)
            $counter -> electricity = $req -> electricity;
        $counter -> id_apartment = $req -> id_apartment;
        $counter -> save();
        return redirect('/panel/mieszkanie/'.$req -> id_apartment);
    }

    public function create($id) {
        $apartment = Apartment::find($id);
        $counters = Apartment::select('cold_water', 'hot_water', 'gas', 'electricity')->where('id_apartment', $id)->first();
        $lastCounter = Counter::select('cold_water', 'hot_water', 'gas', 'electricity')->where('id_apartment', $id)->orderBy('created_at', 'desc')->first();
        if (!$counters -> cold_water and !$counters -> hot_water and !$counters -> gas and !$counters -> electricity or Auth::id() != $apartment -> user_id) {
            return redirect('/panel/mieszkanie/'.$id);
        }
        $bills = Bill::where('id_apartment', $apartment -> id_apartment)->get();
        $bills = count($bills);
        return view('counters', compact('apartment', 'lastCounter', 'bills'));
    }

    public function store(Request $req) {
        $lastCounter = Counter::select('cold_water', 'hot_water', 'gas', 'electricity')->where('id_apartment', $req -> id_apartment)->orderBy('created_at', 'desc')->first();
        $req->validate([
            'cold_water' => [ Rule::requiredIf($req->cold_water), 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'hot_water' => [Rule::requiredIf($req->hot_water), 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'gas' => [Rule::requiredIf($req->gas), 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'electricity' => [Rule::requiredIf($req->electricity), 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
        ]);
        $req -> cold_water = str_replace(',', '.', $req -> cold_water);
        $req -> cold_water = (float)$req -> cold_water;
        $req -> hot_water = str_replace(',', '.', $req -> hot_water);
        $req -> hot_water = (float)$req -> hot_water;
        $req -> gas = str_replace(',', '.', $req -> gas);
        $req -> gas = (float)$req -> gas;
        $req -> electricity = str_replace(',', '.', $req -> electricity);
        $req -> electricity = (float)$req -> electricity;
        if ($lastCounter) {
            if ($req -> cold_water and $req -> cold_water <= (float)$lastCounter -> cold_water) {
                return redirect()->back();
            }
            if ($req -> hot_water and $req -> hot_water <= (float)$lastCounter -> hot_water) {
                return redirect()->back();
            }
            if ($req -> gas and $req -> gas <= (float)$lastCounter -> gas) {
                return redirect()->back();
            }
            if ($req -> electricity and $req -> electricity <= (float)$lastCounter -> electricity) {
                return redirect()->back();
            }
        }

        $counter = new Counter;
        if ($req -> cold_water)
            $counter -> cold_water = $req -> cold_water;
        if ($req -> hot_water)
            $counter -> hot_water = $req -> hot_water;
        if ($req -> gas)
            $counter -> gas = $req -> gas;
        if ($req -> electricity)
            $counter -> electricity = $req -> electricity;
        $counter -> id_apartment = $req -> id_apartment;
        $counter -> save();

        // Tworzenie rachunku

        // Liczenie sumy
        $apartment = Apartment::find($req -> id_apartment);
        $sum = $apartment -> price;
        if ($req -> cold_water) {
            $consumption = (float)$req -> cold_water - (float)$lastCounter -> cold_water;
            $price_cold_water = $consumption * $apartment -> cold_water;
            $sum += $price_cold_water;
        }
        if ($req -> hot_water) {
            $consumption = (float)$req -> hot_water - (float)$lastCounter -> hot_water;
            $price_hot_water = $consumption * $apartment -> hot_water;
            $sum += $price_hot_water;
        }
        if ($req -> gas) {
            $consumption = (float)$req -> gas - (float)$lastCounter -> gas;
            $price_gas = $consumption * $apartment -> gas;
            $sum += $price_gas;
        }
        if ($req -> electricity) {
            $consumption = (float)$req -> electricity - (float)$lastCounter -> electricity;
            $price_electricity = $consumption * $apartment -> electricity;
            $sum += $price_electricity;
        }
        $garbage_sum = (float)$apartment -> rubbish * count($apartment -> roommates);
        $sum += $garbage_sum;
        $sum += (float)$apartment -> internet;
        $sum += (float)$apartment -> tv;
        $sum += (float)$apartment -> phone;
        //

        $bill = new Bill;
        $bill -> id_apartment = $req -> id_apartment;
        $bill -> sum = $sum;
        $bill -> rental_price = $apartment -> price;
        if ($req -> cold_water)
            $bill -> cold_water = $price_cold_water;
        if ($req -> hot_water)
            $bill -> hot_water = $price_hot_water;
        if ($req -> gas)
            $bill -> gas = $price_gas;
        if ($req -> electricity)
            $bill -> electricity = $price_electricity;
        $bill -> rubbish = $garbage_sum;
        $bill -> internet = (float)$apartment -> internet;
        $bill -> tv = (float)$apartment -> tv;
        $bill -> phone = (float)$apartment -> phone;
        $bill -> save();
        return redirect('/panel/mieszkanie/'.$req -> id_apartment.'/rachunki');
    }
}
