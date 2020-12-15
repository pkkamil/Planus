<?php

namespace App\Http\Controllers;

use App\Apartment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use App\Counter;
use App\User;
use DateTime;
use App\Bill;


class ApartmentController extends Controller
{
    public function index() {
        $apartments = Apartment::paginate(11);
        return view('home', compact('apartments'));
    }

    public function inform() {
        return view('soon');
    }

    public function show($id) {
        $apartment = Apartment::find($id);
        if ($apartment -> public == 1)
            return view('singleApartment', compact('apartment'));
        else
            return redirect('/');
    }

    public function apartmentDetails($id) {
        $apartment = Auth::user() -> apartments -> where('id_apartment', $id);
        if (count($apartment) == 0) {
            $apartment = Auth::user() -> residents -> where('id_apartment', $id);
            if (count($apartment) == 0) {
                return redirect('/panel');
            }
        }

        if (count($apartment->first() -> counters) == 0) {
            if ($apartment -> first() -> cold_water or $apartment -> first() -> hot_water or $apartment -> first() -> gas or $apartment -> first() -> electricity)
                return redirect('/panel/mieszkanie/'.$apartment -> first() -> id_apartment.'/wstepne_liczniki');
        } else {
            $lastCounter = Counter::select('cold_water', 'hot_water', 'gas', 'electricity')->where('id_apartment', $id)->orderBy('created_at', 'desc')->first();
            if (is_null($apartment -> first() -> cold_water) != is_null($lastCounter -> cold_water) or is_null($apartment -> first() -> hot_water) != is_null($lastCounter -> hot_water) or is_null($apartment -> first() -> gas) != is_null($lastCounter -> gas) or is_null($apartment -> first() -> electricity) != is_null($lastCounter -> electricity)) {
                return redirect('/panel/mieszkanie/'.$apartment -> first() -> id_apartment.'/wstepne_liczniki');
            }
        }

        // left to the settlement date
        $updated_date_month = $apartment -> first() -> updated_at -> format('m');
        $updated_date_year = $apartment -> first() -> updated_at -> format('Y');
        $updated_date = $updated_date_year.'-'.$updated_date_month.'-'.$apartment -> first() -> settlement_day;
        $remaining_billing_period = date('Y-m-d', strtotime('+'.strval($apartment -> first() -> billing_period).' months', strtotime($updated_date)));
        $from_date = new DateTime();
        $to_date = new DateTime($remaining_billing_period);
        $interval_to_end = $from_date -> diff($to_date);
        if ($interval_to_end -> y > 0) {
            $interval_to_end = $interval_to_end -> y * 12 + $interval_to_end -> m;
        } else {
            $interval_to_end = $interval_to_end -> m;
        }
        $settlement_day = $apartment -> first() -> settlement_day;
        $settlement_date = new DateTime(now());
        $settlement_date = $settlement_day.'-'.$settlement_date -> format('m').'-'.$settlement_date -> format('Y');
        $to_date = new DateTime($settlement_date);
        if ($to_date -> format('d') === $from_date -> format('d')) {
            $days = -1;
        } else {
            $from_date = new DateTime();
            $interval = $from_date -> diff($to_date);
            if ($interval -> invert == 1) {
                $settlement_date = date('Y-m-d', strtotime('+1 month', strtotime($settlement_date)));
                $to_date = new DateTime($settlement_date);
                $interval = $from_date -> diff($to_date);
            }
            $days = $interval -> d;
        }

        // Overdue

        $lastBill = Bill::select('settlement_date')->where('id_apartment', $id)->orderBy('settlement_date', 'desc')->get();
        if (count($lastBill) != 0) {
            $from_date = new DateTime();
            $to_date = new DateTime($lastBill->first() -> settlement_date);
            $last = $from_date -> diff($to_date);
            if ($last -> m > 0) {
                $overdue = True;
            } else {
                $overdue = False;
            }
            // recorded
            $lastMonth = new DateTime($lastBill -> first() -> settlement_date);
            $lastMonth = $lastMonth -> format('m');
            $today = new DateTime();
            if ($today -> format('m') == $lastMonth)
                $recorded = true;
            else
                $recorded = false;
        // Count bills
        } else {
            $updated_at = $apartment -> first() -> updated_at;
            $today = new DateTime();
            $has_passed = $updated_at -> diff($today);
            if ($has_passed -> m > 0) {
                $overdue = True;
            } else {
                $overdue = False;
            }
            $recorded = false;
        }

        $bills = Bill::where('id_apartment', $id)->get();
        $bills = count($bills);
        $apartment = $apartment->first();

        return view('apartmentDetails', compact('apartment', 'interval_to_end', 'days', 'bills', 'overdue', 'recorded'));
    }

    public function add(Request $req) {
        $req -> price = str_replace(',', '.', $req -> price);
        $req -> price = (float)$req -> price;
        $req->validate([
            'image' => 'required|mimes:jpeg,png,jpg,gif,bmp|max:10240',
            'name' => 'required|string|min:5',
            'localization' => 'required|string|min:5',
            'price' => ['required', 'regex:/^([0-9][0-9]{0,5}[.|,][0-9]{1,2}|[0-9]{1,6})$/'],
            'area' => 'required|numeric',
            'rooms' => 'required|numeric',
            'settlement_day' => 'required|numeric|min:1|max:28',
            'billing_period' => 'required',
            'billing_period' => 'required',
            'cold_water' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'hot_water' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            // 'heating' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'gas' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'electricity' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'rubbish' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'internet' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'tv' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'phone' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
        ]);
        // Image
        $img_name = Str::random(30);
        $extension = $req -> image -> extension();
        $req -> image -> storeAs('/public', "apartment/".$img_name."-bg.".$extension);
        $url_bg = Storage::url("apartment/".$img_name."-bg.".$extension);
        $apartment = new Apartment;
        $apartment -> user_id = Auth::id();
        $apartment -> name = $req -> name;
        $apartment -> price = (int)$req -> price;
        $apartment -> image = $url_bg;
        // invite code
        $notUnique = true;
        do {
            $code = Str::random(8);
            if (Apartment::where('invite_code', $code)->get())
                $notUnique = false;
        } while ($notUnique);
        $apartment -> invite_code = $code;
        //
        $apartment -> area = (int)$req -> area;
        $apartment -> rooms = (int)$req -> rooms;
        $apartment -> localization = $req -> localization;
        $apartment -> settlement_day = (int)$req -> settlement_day;
        $apartment -> billing_period = (int)$req -> billing_period;
        if ($req -> cold_water and $req -> cold_water_active)
            $apartment -> cold_water = (float)$req -> cold_water;
        if ($req -> hot_water and $req -> hot_water_active)
            $apartment -> hot_water = (float)$req -> hot_water;
        // if ($req -> heating and $req -> heating_active)
        //     $apartment -> heating = (float)$req -> heating;
        if ($req -> gas and $req -> gas_active)
            $apartment -> gas = (float)$req -> gas;
        if ($req -> electricity and $req -> electricity_active)
            $apartment -> electricity = (float)$req -> electricity;
        if ($req -> rubbish and $req -> rubbish_active)
            $apartment -> rubbish = (float)$req -> rubbish;
        if ($req -> internet and $req -> internet_active)
            $apartment -> internet = (float)$req -> internet;
        if ($req -> tv and $req -> tv_active)
            $apartment -> tv = (float)$req -> tv;
        if ($req -> phone and $req -> phone_active)
            $apartment -> phone = (float)$req -> phone;
        $apartment -> save();
        return redirect('/mieszkanie/'.$apartment -> id_apartment);
    }

    public function rent(Request $req) {
        $apartment = Apartment::where('invite_code', $req -> code)->get();
        if (count($apartment) != 0) {
            if(count(DB::table('apartment_user')->where('user_id', Auth::id())->where('apartment_id_apartment', $apartment -> first() -> id_apartment)->get()) > 0) {
                return redirect('/panel/mieszkanie/'.$apartment -> first() -> id_apartment);
            }
            DB::table('apartment_user')->insert(
                ['apartment_id_apartment' => $apartment -> first() -> id_apartment, 'user_id' => Auth::id()]
            );
            return redirect('/panel/mieszkanie/'.$apartment -> first() -> id_apartment);
        }
        return redirect()->back()->withErrors(['Podany kod zaproszenia nie pasuje do żadnego mieszkania.']);
    }

    public function editPage($id) {
        $apartment = Apartment::find($id);
        if ($apartment -> user_id == Auth::id())
            return view('settingsApartment', compact('apartment'));
        return redirect('/panel');
    }

    public function edit(Request $req) {
        $req -> price = str_replace(',', '.', $req -> price);
        $req -> price = (float)$req -> price;
        $req->validate([
            'image' => 'nullable|mimes:jpeg,png,jpg,gif,bmp|max:10240',
            'name' => 'nullable|string|min:5',
            'localization' => 'nullable|string|min:5',
            'price' => ['nullable', 'regex:/^([0-9][0-9]{0,5}[.|,][0-9]{1,2}|[0-9]{1,6})$/'],
            'area' => 'nullable|numeric',
            'rooms' => 'nullable|numeric',
            'settlement_day' => 'nullable|numeric|min:1|max:28',
            'billing_period' => 'nullable',
            'billing_period' => 'nullable',
            'cold_water' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'hot_water' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            // 'heating' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'gas' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'electricity' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'rubbish' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'internet' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'tv' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'phone' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
        ]);
        // Image
        if ($req -> image) {
            $img_name = Str::random(30);
            $extension = $req -> image -> extension();
            $req -> image -> storeAs('/public', "apartment/".$img_name."-bg.".$extension);
            $url_bg = Storage::url("apartment/".$img_name."-bg.".$extension);
        }
        //

        $apartment = Apartment::find($req -> id_apartment);
        if ($req -> public)
            $apartment -> public = 1;
        else
            $apartment -> public = 0;

        $apartment -> name = $req -> name;
        $apartment -> price = (int)$req -> price;
        if ($req -> image)
            $apartment -> image = $url_bg;
        $apartment -> area = (int)$req -> area;
        $apartment -> rooms = (int)$req -> rooms;
        $apartment -> localization = $req -> localization;
        $apartment -> settlement_day = (int)$req -> settlement_day;
        $apartment -> billing_period = (int)$req -> billing_period;
        if ($req -> cold_water and $req -> cold_water_active)
            $apartment -> cold_water = (float)$req -> cold_water;
        else
            $apartment -> cold_water = NULL;
        if ($req -> hot_water and $req -> hot_water_active)
            $apartment -> hot_water = (float)$req -> hot_water;
        else
            $apartment -> hot_water = NULL;
        // if ($req -> heating and $req -> heating_active)
        //     $apartment -> heating = (float)$req -> heating;
        // else
        //     $apartment -> heating = NULL;
        if ($req -> gas and $req -> gas_active)
            $apartment -> gas = (float)$req -> gas;
        else
            $apartment -> gas = NULL;
        if ($req -> electricity and $req -> electricity_active)
            $apartment -> electricity = (float)$req -> electricity;
        else
            $apartment -> electricity = NULL;
        if ($req -> rubbish and $req -> rubbish_active)
            $apartment -> rubbish = (float)$req -> rubbish;
        else
            $apartment -> rubbish = NULL;
        if ($req -> internet and $req -> internet_active)
            $apartment -> internet = (float)$req -> internet;
        else
            $apartment -> internet = NULL;
        if ($req -> tv and $req -> tv_active)
            $apartment -> tv = (float)$req -> tv;
        else
            $apartment -> tv = NULL;
        if ($req -> phone and $req -> phone_active)
            $apartment -> phone = (float)$req -> phone;
        else
            $apartment -> phone = NULL;
        $apartment -> save();
        return redirect('/panel/mieszkanie/'.$apartment -> id_apartment);
    }

    public function code() {
        // invite code
        $notUnique = true;
        do {
            $code = Str::random(8);
            if (Apartment::where('invite_code', $code)->get())
                $notUnique = false;
        } while ($notUnique);
        return $code;
    }

    public function delete($id) {
        if(Apartment::find($id) -> user_id == Auth::id())
            Apartment::destroy($id);
        return redirect('/panel');
    }

    public function createMember(Request $req, $id) {
        if(Apartment::find($id) -> user_id == Auth::id()) {
            $req->validate([
                'name' => 'required|string|min:2|max:15',
            ]);
            $user = new User;
            $user -> name = $req -> name;
            $user -> save();
            DB::table('apartment_user')->insert(
                ['apartment_id_apartment' => $id, 'user_id' => $user -> id]
            );
        }
        return redirect('/panel/mieszkanie/'.$id);
    }

    public function deleteMember($id, $user_id) {
        if(Apartment::find($id) -> user_id == Auth::id()) {
            DB::table('apartment_user')->where('user_id', $user_id)->where('apartment_id_apartment', $id)->delete();
            if (User::find($user_id) -> email == null)
                User::destroy($user_id);
        }
        return redirect('/panel/mieszkanie/'.$id);
    }
}
