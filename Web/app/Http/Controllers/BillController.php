<?php

namespace App\Http\Controllers;

use App\Bill;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Apartment;

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

    public function create($req, $id) {
        $sum = 0;
        $bill = new Bill;
        $bill -> id_apartment = $req -> id_apartment;
        $bill -> sum = $sum;
        $bill -> rental_price = Apartment::find($id) -> price;
        if ($req -> cold_water)
            $bill -> cold_water = $req -> cold_water;
        if ($req -> hot_water)
            $bill -> hot_water = $req -> hot_water;
        if ($req -> gas)
            $bill -> gas = $req -> gas;
        if ($req -> electricity)
            $bill -> electricity = $req -> electricity;
        $bill -> rubbish = (float)$req -> rubbish;
        $bill -> internet = (float)$req -> internet;
        $bill -> tv = (float)$req -> tv;
        $bill -> phone = (float)$req -> phone;
        $bill -> save();
        dd($bill);
        return redirect('/panel/mieszkanie/'.$bill -> id_apartment.'/rachunki/'.$bill -> id_bill);
    }

    public function addFee(Request $req) {

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
