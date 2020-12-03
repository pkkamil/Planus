<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Counter;
use Illuminate\Validation\Rule;

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
            'cold_water' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'hot_water' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'gas' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'electricity' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
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
        return response()->json(['message' => 'OK']);
    }
}
