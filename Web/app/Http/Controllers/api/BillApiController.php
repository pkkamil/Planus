<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Bill;
use App\Fee;

class BillApiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($id) {
        $lastBill = Bill::where('id_apartment', $id)->orderBy('settlement_date', 'desc')->first();
        return response()->json(['bill' => $lastBill]);
    }

    public function statistics($id) {
        $bills = Bill::where('id_apartment', $id)->orderBy('settlement_date', 'asc')->paginate(12);
        $months = [];
        $sums = [];
        $cold_water = [];
        $hot_water = [];
        $gas = [];
        $electricity = [];
        $month = '';
        foreach ($bills as $bill) {
            if (date("d", strtotime($bill -> settlement_date))[0] == '0')
                $num = str_replace(0, '', date("m", strtotime($bill -> settlement_date)));
            else
                $num = date("m", strtotime($bill -> settlement_date));
            array_push($sums, $bill -> sum);
            array_push($months, $num);
            if ($bill -> cold_water) {
                array_push($cold_water, $bill -> cold_water);
            }
            if ($bill -> hot_water) {
                array_push($hot_water, $bill -> hot_water);
            }
            if ($bill -> gas) {
                array_push($gas, $bill -> gas);
            }
            if ($bill -> electricity) {
                array_push($electricity, $bill -> electricity);
            }
        }
        return response()->json(['price_sums' => $sums, 'cold_water' => $cold_water, 'hot_water' => $hot_water, 'gas' => $gas, 'electricity' => $electricity, 'months' => $months]);
    }

    public function addFee(Request $req) {
        $bill = Bill::find($req -> id_bill);
        $fee = new Fee();
        $fee -> name = $req -> name;
        $fee -> price = $req -> price;
        $fee -> id_bill = $req -> id_bill;
        $fee -> save();
        $bill -> sum += $req -> price;
        $bill -> save();
    }
}
