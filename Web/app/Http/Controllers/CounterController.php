<?php

namespace App\Http\Controllers;

use App\Apartment;
use Illuminate\Http\Request;
use App\Counter;
use stdClass;

class CounterController extends Controller
{
    public function index() {

    }

    public function create($id) {
        $counters = Counter::where('id_apartment', $id)->get();
        $apartment = Apartment::find($id);
        $consumption = [];
        $index = 0;
        $last_item = (object)[];
        foreach ($counters as $counter) {
            if ($index != 0) {
                array_push($consumption, ['cold_water' => $counter -> cold_water - $last_item -> cold_water,
                                        'hot_water' => $counter -> hot_water - $last_item -> hot_water,
                                        'gas' => $counter -> gas - $last_item -> gas,
                                        'electricity' => $counter -> electricity - $last_item -> electricity]);
            }
            $last_item = $counter;
            $index++;
        }

        $singleSumcw = [];
        $singleSumhw = [];
        $singleSumg = [];
        $singleSume = [];
        foreach($consumption as $item) {
            foreach($item as $key => $value) {
                switch ($key) {
                    case 'cold_water':
                        array_push($singleSumcw, $value);
                    break;
                    case 'hot_water':
                        array_push($singleSumhw, $value);
                    break;
                    case 'gas':
                        array_push($singleSumg, $value);
                    break;
                    case 'electricity':
                        array_push($singleSume, $value);
                    break;
                }
            }
        }

        $srednia = [];
        $sumC = 0;
        $sumH = 0;
        $sumG = 0;
        $sumE = 0;
        foreach($singleSumcw as $item) {
            $sumC += $item;
        }
        foreach($singleSumhw as $item) {
            $sumH += $item;
        }
        foreach($singleSumg as $item) {
            $sumG += $item;
        }
        foreach($singleSume as $item) {
            $sumE += $item;
        }

        // cold water (Najmniejsza wartość, średnia, obecna, Największa)
        $minC = min($singleSumcw);
        $averageC = round($sumC/count($singleSumcw), 2);
        $currentC = 0;
        $maxC = max($singleSumcw);

        // hot water (Najmniejsza wartość, średnia, obecna, Największa)
        $minH = min($singleSumhw);
        $averageH = round($sumH/count($singleSumhw), 2);
        $currentH = 0;
        $maxH = max($singleSumhw);

        // gas (Najmniejsza wartość, średnia, obecna, Największa)
        $minG = min($singleSumg);
        $averageG = round($sumG/count($singleSumg), 2);
        $currentG = 0;
        $maxG = max($singleSumg);

        // electricity (Najmniejsza wartość, średnia, obecna, Największa)
        $minE = min($singleSume);
        $averageE = round($sumE/count($singleSume), 2);
        $currentE = 0;
        $maxE = max($singleSume);
        $obj = new stdClass();
        $obj -> min_cold_water = $minC;
        $obj -> min_hot_water = $minH;
        $obj -> min_gas = $minG;
        $obj -> min_electricity = $minE;
        $obj -> average_cold_water = $averageC;
        $obj -> average_hot_water = $averageH;
        $obj -> average_gas = $averageG;
        $obj -> average_electricity = $averageE;
        $obj -> max_cold_water = $maxC;
        $obj -> max_hot_water = $maxH;
        $obj -> max_gas = $maxG;
        $obj -> max_electricity = $maxE;

        // dd($apartment -> hot_water);
        return view('counters', compact('obj', 'apartment'));
    }

    public function store(Request $req) {

    }
}
