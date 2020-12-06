<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\ApartmentResource;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use App\Apartment;
use Illuminate\Support\Facades\Auth;
use App\User;
use Illuminate\Support\Facades\DB;
use Intervention\Image\Facades\Image;

class ApartmentApiController extends Controller
{
    public function index($id = null) {
        if ($id == null) {
            return ApartmentResource::collection(Apartment::all());
        }
        $owners = Apartment::where('user_id', $id)->get();
        $rented = User::find($id) -> residents;
        $data = $owners->concat($rented);
        return ApartmentResource::collection($data);
    }

    public function paginate($items = 10) {
        return ApartmentResource::collection(Apartment::where('public', 1)->paginate($items));
    }

    public function create(Request $req) {
        if ($req -> cold_water) {
            $req -> cold_water = str_replace(',', '.', $req -> cold_water);
            $req -> cold_water = (float)$req -> cold_water;
        }
        if ($req -> hot_water) {
            $req -> hot_water = str_replace(',', '.', $req -> hot_water);
            $req -> hot_water = (float)$req -> hot_water;
        }
        if ($req -> heating) {
            $req -> heating = str_replace(',', '.', $req -> heating);
            $req -> heating = (float)$req -> heating;
        }
        if ($req -> gas) {
            $req -> gas = str_replace(',', '.', $req -> gas);
            $req -> gas = (float)$req -> gas;
        }
        if ($req -> electricity) {
            $req -> electricity = str_replace(',', '.', $req -> electricity);
            $req -> electricity = (float)$req -> electricity;
        }
        if ($req -> rubbish) {
            $req -> rubbish = str_replace(',', '.', $req -> rubbish);
            $req -> rubbish = (float)$req -> rubbish;
        }
        if ($req -> internet) {
            $req -> internet = str_replace(',', '.', $req -> internet);
            $req -> internet = (float)$req -> internet;
        }
        if ($req -> tv) {
            $req -> tv = str_replace(',', '.', $req -> tv);
            $req -> tv = (float)$req -> tv;
        }
        if ($req -> phone) {
            $req -> phone = str_replace(',', '.', $req -> phone);
            $req -> phone = (float)$req -> phone;
        }

        $req->validate([
            // 'image' => 'required|mimes:jpeg,png,jpg,gif,bmp|image|max:10240',
            'name' => 'required|string|min:5',
            'localization' => 'required|string|min:5',
            'price' => ['required', 'regex:/^([0-9][0-9]{0,5}[.|,][0-9]{1,2}|[0-9]{1,6})$/'],
            'area' => 'required|numeric',
            'rooms' => 'required|numeric',
            'settlement_day' => 'required|numeric|min:1|max:28',
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
        $img = $req -> image;
        if ($img) {
            $img_name = Str::random(30);
            $extension = 'png';
            Image::make($img)->save(public_path('storage/apartment/').$img_name."-bg.".$extension);
            $url = Storage::url('apartment/'.$img_name."-bg.".$extension);
        }
        $apartment = new Apartment;
        // invite code
        $notUnique = true;
        do {
            $code = Str::random(8);
            if (Apartment::where('invite_code', $code)->get())
                $notUnique = false;
        } while ($notUnique);
        $apartment -> invite_code = $code;
        //

        $apartment -> user_id = $req -> user_id;
        $apartment -> name = $req -> name;
        $apartment -> price = (int)$req -> price;
        $apartment -> image = $url;
        $apartment -> area = (int)$req -> area;
        $apartment -> rooms = (int)$req -> rooms;
        $apartment -> localization = $req -> localization;
        $apartment -> settlement_day = (int)$req -> settlement_day;
        $apartment -> billing_period = (int)$req -> billing_period;
        if ($req -> cold_water)
            $apartment -> cold_water = (float)$req -> cold_water;
        if ($req -> hot_water)
            $apartment -> hot_water = (float)$req -> hot_water;
        if ($req -> heating)
            $apartment -> heating = (float)$req -> heating;
        if ($req -> gas)
            $apartment -> gas = (float)$req -> gas;
        if ($req -> electricity)
            $apartment -> electricity = (float)$req -> electricity;
        if ($req -> rubbish)
            $apartment -> rubbish = (float)$req -> rubbish;
        if ($req -> internet)
            $apartment -> internet = (float)$req -> internet;
        if ($req -> tv)
            $apartment -> tv = (float)$req -> tv;
        if ($req -> phone)
            $apartment -> phone = (float)$req -> phone;
        $apartment -> save();
        return response()->json(['message' => 'OK', 'apartment_id' => $apartment -> id_apartment]);
    }

    public function edit(Request $req) {
        if ($req -> cold_water) {
            $req -> cold_water = str_replace(',', '.', $req -> cold_water);
            $req -> cold_water = (float)$req -> cold_water;
        }
        if ($req -> hot_water) {
            $req -> hot_water = str_replace(',', '.', $req -> hot_water);
            $req -> hot_water = (float)$req -> hot_water;
        }
        if ($req -> heating) {
            $req -> heating = str_replace(',', '.', $req -> heating);
            $req -> heating = (float)$req -> heating;
        }
        if ($req -> gas) {
            $req -> gas = str_replace(',', '.', $req -> gas);
            $req -> gas = (float)$req -> gas;
        }
        if ($req -> electricity) {
            $req -> electricity = str_replace(',', '.', $req -> electricity);
            $req -> electricity = (float)$req -> electricity;
        }
        if ($req -> rubbish) {
            $req -> rubbish = str_replace(',', '.', $req -> rubbish);
            $req -> rubbish = (float)$req -> rubbish;
        }
        if ($req -> internet) {
            $req -> internet = str_replace(',', '.', $req -> internet);
            $req -> internet = (float)$req -> internet;
        }
        if ($req -> tv) {
            $req -> tv = str_replace(',', '.', $req -> tv);
            $req -> tv = (float)$req -> tv;
        }
        if ($req -> phone) {
            $req -> phone = str_replace(',', '.', $req -> phone);
            $req -> phone = (float)$req -> phone;
        }

        $req->validate([
            // 'image' => 'required|mimes:jpeg,png,jpg,gif,bmp|image|max:10240',
            'name' => 'nullable|string|min:5',
            'localization' => 'nullable|string|min:5',
            'price' => ['nullable', 'regex:/^([0-9][0-9]{0,5}[.|,][0-9]{1,2}|[0-9]{1,6})$/'],
            'area' => 'nullable|numeric',
            'rooms' => 'nullable|numeric',
            'settlement_day' => 'nullable|numeric|min:1|max:28',
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
        $img = $req -> image;
        if ($img) {
            $img_name = Str::random(30);
            $extension = 'png';
            Image::make($img)->save(public_path('storage/apartment/').$img_name."-bg.".$extension);
            $url = Storage::url('apartment/'.$img_name."-bg.".$extension);
        }
        $apartment = Apartment::find($req -> id_apartment);

        if ($req -> name)
            $apartment -> name = $req -> name;
        if ($req -> price)
            $apartment -> price = (int)$req -> price;
        if ($req -> image)
            $apartment -> image = $url;
        if ($req -> area)
            $apartment -> area = (int)$req -> area;
        if ($req -> rooms)
            $apartment -> rooms = (int)$req -> rooms;
        if ($req -> localization)
            $apartment -> localization = $req -> localization;
        if ($req -> settlement_day)
            $apartment -> settlement_day = (int)$req -> settlement_day;
        if ($req -> billing_period)
            $apartment -> billing_period = (int)$req -> billing_period;
        if ($req -> cold_water)
            $apartment -> cold_water = (float)$req -> cold_water;
        if ($req -> hot_water)
            $apartment -> hot_water = (float)$req -> hot_water;
        if ($req -> heating)
            $apartment -> heating = (float)$req -> heating;
        if ($req -> gas)
            $apartment -> gas = (float)$req -> gas;
        if ($req -> electricity)
            $apartment -> electricity = (float)$req -> electricity;
        if ($req -> rubbish)
            $apartment -> rubbish = (float)$req -> rubbish;
        if ($req -> internet)
            $apartment -> internet = (float)$req -> internet;
        if ($req -> tv)
            $apartment -> tv = (float)$req -> tv;
        if ($req -> phone)
            $apartment -> phone = (float)$req -> phone;
        $apartment -> save();
        return response()->json(['message' => 'OK', 'apartment_id' => $apartment -> id_apartment]);
    }

    public function rent(Request $req) {
        $apartment = Apartment::where('invite_code', $req -> code)->get();
        if (count($apartment) != 0) {
            if(count(DB::table('apartment_user')->where('user_id', $req -> user_id)->where('apartment_id_apartment', $apartment -> first() -> id_apartment)->get()) > 0) {
                return response()->json(['message' => 'You already belong to this apartment.', 'apartment_id' => $apartment -> first() -> id_apartment]);
            }
            DB::table('apartment_user')->insert(
                ['apartment_id_apartment' => $apartment -> first() -> id_apartment, 'user_id' => $req -> user_id]
            );
            return response()->json(['message' => 'OK', 'apartment_id' => $apartment -> first() -> id_apartment]);
        }
        return response()->json(['message' => 'Incorrect invite code']);
    }

    public function delete(Request $req) {
        if(Apartment::find($req -> id_apartment) -> user_id == $req -> user_id)
            Apartment::destroy($req -> id_apartment);
        return response()->json(['message' => 'OK']);
    }
}
