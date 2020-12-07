<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Bill;

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
}
