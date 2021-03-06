<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Counter;
use Illuminate\Validation\Rule;
use App\Bill;
use App\Apartment;

class CounterApiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($id)
    {
        $lastCounter = Counter::select('cold_water', 'hot_water', 'gas', 'electricity')->where('id_apartment', $id)->orderBy('created_at', 'desc')->first();
        return response()->json($lastCounter);
    }

    public function store(Request $req) {
        $lastCounter = Counter::select('cold_water', 'hot_water', 'gas', 'electricity')->where('id_apartment', $req -> id_apartment)->orderBy('created_at', 'desc')->first();
        $req->validate([
            'cold_water' => ['nullable', 'numeric'],
            'hot_water' => ['nullable', 'numeric'],
            'gas' => ['nullable', 'numeric'],
            'electricity' => ['nullable', 'numeric'],
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
                return response()->json(['message' => 'Zużycie zimnej wody nie może być mniejsze niż 0']);
            }
            if ($req -> hot_water and $req -> hot_water <= (float)$lastCounter -> hot_water) {
                return response()->json(['message' => 'Zużycie cipłej wody nie może być mniejsze niż 0']);
            }
            if ($req -> gas and $req -> gas <= (float)$lastCounter -> gas) {
                return response()->json(['message' => 'Zużycie gazu nie może być mniejsze niż 0']);
            }
            if ($req -> electricity and $req -> electricity <= (float)$lastCounter -> electricity) {
                return response()->json(['message' => 'Zużycie prądu nie może być mniejsze niż 0']);
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

        // Creating bill

        // Calculate sum
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
        if ($bill -> internet != NULL)
            $bill -> internet = (float)$apartment -> internet;
        if ($bill -> tv != NULL)
            $bill -> tv = (float)$apartment -> tv;
        if ($bill -> phone != NULL)
            $bill -> phone = (float)$apartment -> phone;
        $bill -> save();
        return response()->json(['message' => 'OK']);
    }

    public function initialCounters(Request $req) {
        $req->validate([
            'cold_water' => [ 'nullable', 'numeric'],
            'hot_water' => ['nullable', 'numeric'],
            'gas' => ['nullable', 'numeric'],
            'electricity' => ['nullable', 'numeric'],
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
        return response()->json(['message' => 'OK']);
    }
}

