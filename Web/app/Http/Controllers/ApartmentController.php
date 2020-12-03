<?php

namespace App\Http\Controllers;

use App\Apartment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;


class ApartmentController extends Controller
{
    public function index() {
        $apartments = Apartment::paginate(11);
        return view('home', compact('apartments'));
    }

    public function show($id) {
        $apartment = Apartment::find($id);
        if ($apartment -> public == 1)
            return view('singleApartment', compact('apartment'));
        else
            return redirect('/');
    }

    public function add(Request $req) {
        $req -> price = str_replace(',', '.', $req -> price);
        $req -> price = (float)$req -> price;
        $req->validate([
            'image' => 'required|mimes:jpeg,png,jpg,gif,bmp|image|max:10240',
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
            'heating' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
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
        $apartment -> user_id = Auth::user()->id;
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
        $apartment -> invite_code = $req -> invite_code;
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
        if ($req -> heating and $req -> heating_active)
            $apartment -> heating = (float)$req -> heating;
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
            return view('settings-apartment', compact('apartment'));
        return redirect('/panel');
    }

    public function edit(Request $req) {
        $req -> price = str_replace(',', '.', $req -> price);
        $req -> price = (float)$req -> price;
        $req->validate([
            'image' => 'nullable|mimes:jpeg,png,jpg,gif,bmp|image|max:10240',
            'name' => 'nullable|string|min:5',
            'localization' => 'nullable|string|min:5',
            'price' => ['nullable', 'regex:/^([0-9][0-9]{0,5}[.|,][0-9]{1,2}|[0-9]{1,6})$/'],
            'area' => 'nullable|numeric',
            'rooms' => 'nullable|numeric',
            'settlement_day' => 'nullable|numeric|min:1|max:27',
            'billing_period' => 'nullable',
            'billing_period' => 'nullable',
            'cold_water' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'hot_water' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
            'heating' => ['nullable', 'regex:/^([0-9][0-9]{0,2}[.|,][0-9]{1,2}|[0-9]{1,4})$/'],
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
        $apartment = Apartment::find($req -> id_apartment);
        $apartment -> user_id = Auth::user()->id;
        $apartment -> name = $req -> name;
        $apartment -> price = (int)$req -> price;
        $apartment -> image = $url_bg;
        if ($req -> public) {
            $apartment -> public = False;
        }
        $apartment -> area = (int)$req -> area;
        $apartment -> rooms = (int)$req -> rooms;
        $apartment -> localization = $req -> localization;
        $apartment -> settlement_day = (int)$req -> settlement_day;
        $apartment -> billing_period = (int)$req -> billing_period;
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
}
