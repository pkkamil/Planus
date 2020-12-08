<?php

namespace App\Http\Controllers;

use App\Bill;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Apartment;
use App\Counter;
use App\Fee;
use stdClass;

class BillController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($id) {
        $apartment = Apartment::find($id);
        $bills = Bill::where('id_apartment', $id)->orderBy('settlement_date', 'desc')->select('id_bill', 'sum', 'settlement_date')->get();
        $arrayOfBills = [];
        foreach ($bills as $bill) {
            $num = date("m", strtotime($bill -> settlement_date));
            switch ($num) {
                case 1:
                    $month = 'Stycznia';
                break;
                case 2:
                    $month = 'Lutego';
                break;
                case 3:
                    $month = 'Marca';
                break;
                case 4:
                    $month = 'Kwietnia';
                break;
                case 5:
                    $month = 'Maja';
                break;
                case 6:
                    $month = 'Czerwca';
                break;
                case 7:
                    $month = 'Lipca';
                break;
                case 8:
                    $month = 'Sierpnia';
                break;
                case 9:
                    $month = 'Września';
                break;
                case 10:
                    $month = 'Października';
                break;
                case 11:
                    $month = 'Listopada';
                break;
                case 12:
                    $month = 'Grudnia';
                break;
            }
            if (date("d", strtotime($bill -> settlement_date))[0] == '0')
                $date = str_replace(0, '', date("d", strtotime($bill -> settlement_date))).' '.$month.' '.date("Y", strtotime($bill -> settlement_date));
            else
                $date = date("d", strtotime($bill -> settlement_date)).' '.$month.' '.date("Y", strtotime($bill -> settlement_date));

            $bills = new stdClass();
            $bills -> id = $bill -> id_bill;
            $bills -> sum = (int)$bill -> sum;
            $bills -> date = $date;
            array_push($arrayOfBills, $bills);
        }

        $bills = $arrayOfBills;

        return view('allBills', compact('bills'));
    }

    public function show($id, $id_bill) {
        $bill = Bill::find($id_bill);
        $apartment = Apartment::find($id);
        $counters = Counter::where('id_apartment', $id)->get();
        $counters = count($counters);
        return view('bill', compact('bill', 'apartment', 'counters'));
    }


    public function addFee(Request $req) {
        $bill = Bill::find($req -> id_bill);
        if (Auth::id() != $bill -> apartment -> user_id)
            return redirect('/panel/mieszkanie/'.$bill -> id_apartment);
        $fee = new Fee();
        $fee -> name = $req -> name;
        $fee -> price = $req -> price;
        $fee -> id_bill = $req -> id_bill;
        $fee -> save();
        $bill -> sum += $req -> price;
        $bill -> save();
        return redirect(url()->previous());
    }

}
