<?php

namespace App\Http\Controllers;

use App\Bill;
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

    public function diagrams($diagram, $id_apartment) {
        $bills = Bill::where('id_apartment', $id_apartment)->orderBy('settlement_date', 'asc')->paginate(12);
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

        switch ($diagram) {
            // Cost of single media
            case 'cold_water':
                $chart = Chartisan::build()
                ->labels($months)
                ->dataset('Woda zimna', $cold_water)
                ->toJSON();
            break;
            case 'hot_water':
                $chart = Chartisan::build()
                ->labels($months)
                ->dataset('Woda ciepła', $hot_water)
                ->toJSON();
            break;
            case 'gas':
                $chart = Chartisan::build()
                ->labels($months)
                ->dataset('Gaz', $gas)
                ->toJSON();
            break;
            case 'electricity':
                $chart = Chartisan::build()
               ->labels($months)
               ->dataset('Prąd', $electricity)
               ->toJSON();
            break;
            // case 3:
            //     $chart = Chartisan::build()
            //     ->labels(['Listopad', 'Grudzień', 'Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec', 'Lipiec', 'Sierpień', 'Październik', 'Listopad'])
            //     ->dataset('', [3500, 3000, 2700, 2550, 2879, 2329, 2540, 2570, 2602, 2832, 2994, 3320])
            //     ->toJSON();
            // break;
            // Single Apartment
            case 'sum_bill':
                $chart = Chartisan::build()
                ->labels($months)
                ->dataset('Suma rachunku', $sums)
                ->toJSON();
            break;
        }

        return $chart;
    }

    public function lastMonth($id_apartment) {
        $bills = Bill::where('id_apartment', $id_apartment)->sortBy('settlement_date')->reverse()->take(12)->reverse();
        $names = [];
        $costs = [];

       $lastBill = $bills->last();
       if ($lastBill -> rental_price) {
           array_push($names, 'Cena wynajmu');
           array_push($costs, $lastBill -> rental_price);
       }
       if ($lastBill -> cold_water) {
        array_push($names, 'Woda zimna');
        array_push($costs, $lastBill -> cold_water);
        }
        if ($lastBill -> hot_water) {
            array_push($names, 'Woda ciepła');
            array_push($costs, $lastBill -> hot_water);
        }
        if ($lastBill -> gas) {
            array_push($names, 'Gaz');
            array_push($costs, $lastBill -> gas);
        }
        if ($lastBill -> electricity) {
            array_push($names, 'Prąd');
            array_push($costs, $lastBill -> electricity);
        }
        if ($lastBill -> rubbish) {
            array_push($names, 'Śmieci');
            array_push($costs, $lastBill -> rubbish);
        }
        if ($lastBill -> internet) {
            array_push($names, 'Internet');
            array_push($costs, $lastBill -> internet);
        }
        if ($lastBill -> tv) {
            array_push($names, 'Telewizja');
            array_push($costs, $lastBill -> tv);
        }
        if ($lastBill -> phone) {
            array_push($names, 'Telefon');
            array_push($costs, $lastBill -> phone);
        }
        // Circle Diagram
        $chart = Chartisan::build()
            ->labels($names)
            ->dataset('', $costs)
            ->toJSON();

        return $chart;
    }
}
