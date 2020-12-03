<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Counter;
use stdClass;
use Chartisan\PHP\Chartisan;

class ChartController extends Controller
{
    public function consumptions($id, $type) {
        $counters = Counter::where('id_apartment', $id)->get();
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
        // dd($maxC, $maxH, $maxG, $maxE);
        // $obj = new stdClass();
        // $obj -> min_cold_water = $minC;
        // $obj -> min_hot_water = $minH;
        // $obj -> min_gas = $minG;
        // $obj -> min_electricity = $minE;
        // $obj -> average_cold_water = $averageC;
        // $obj -> average_hot_water = $averageH;
        // $obj -> average_gas = $averageG;
        // $obj -> average_electricity = $averageE;
        // $obj -> max_cold_water = $maxC;
        // $obj -> max_hot_water = $maxH;
        // $obj -> max_gas = $maxG;
        // $obj -> max_electricity = $maxE;

        switch ($type) {
            case 'cold-water':
            // Cold water
                $chart = Chartisan::build()
                ->labels(['Najmniejsze zużycie', 'Średnie zużycie', 'Najwyższe zużycie'])
                ->dataset('', [round($minC, 2), $averageC, round($maxC, 2)])
                ->toJSON();
            break;
            // Hot water
            case 'hot-water':
                $chart = Chartisan::build()
                ->labels(['Najmniejsze zużycie', 'Średnie zużycie', 'Najwyższe zużycie'])
                ->dataset('', [round($minH, 2), $averageH, round($maxH, 2)])
                ->toJSON();
            break;
            // Gas
            case 'gas':
                $chart = Chartisan::build()
                ->labels(['Najmniejsze zużycie', 'Średnie zużycie', 'Najwyższe zużycie'])
                ->dataset('', [round($minG, 2), $averageG, round($maxG, 2)])
                ->toJSON();
            break;
            // Electricity
            case 'electricity':
                $chart = Chartisan::build()
                ->labels(['Najmniejsze zużycie', 'Średnie zużycie', 'Najwyższe zużycie'])
                ->dataset('', [round($minE, 2), $averageE, round($maxE, 2)])
                ->toJSON();
            break;
        }

        return $chart;
    }
}
