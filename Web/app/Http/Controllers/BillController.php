<?php

namespace App\Http\Controllers;

use App\Bill;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class BillController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

    }

    public function enterCounters(Request $req) {
        $req->validate([
            'cold_water' => ['required', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'hot_water' => ['required', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'gas' => ['required', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'electricity' => ['required', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
        ]);

        $apartment = new Bill;
        $apartment -> user_id = Auth::user()->id;
        $apartment -> name = $req -> name;
        if ($req -> cold_water and $req -> cold_water_active)
            $apartment -> cold_water = (float)$req -> cold_water;
        if ($req -> hot_water and $req -> hot_water_active)
            $apartment -> hot_water = (float)$req -> hot_water;
        if ($req -> heating and $req -> heating_active)
            $apartment -> heating = (float)$req -> heating;
        if ($req -> gas and $req -> gas_active)
            $apartment -> gas = (float)$req -> gas;
        if ($req -> electricity and $req -> electricity_active)
            $apartment -> electricity = (float)$req -> electricity;
        $apartment -> save();
        return redirect('/mieszkanie/'.$apartment -> id_apartment);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $req)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Bill  $bill
     * @return \Illuminate\Http\Response
     */
    public function show(Bill $bill)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Bill  $bill
     * @return \Illuminate\Http\Response
     */
    public function update(Request $req, Bill $bill)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Bill  $bill
     * @return \Illuminate\Http\Response
     */
    public function destroy(Bill $bill)
    {
        //
    }
}
