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
        $req -> cold_water = str_replace(',', '.', $req -> cold_water);
        $req -> cold_water = (float)$req -> cold_water;
        $req -> hot_water = str_replace(',', '.', $req -> hot_water);
        $req -> hot_water = (float)$req -> hot_water;
        $req -> heating = str_replace(',', '.', $req -> heating);
        $req -> heating = (float)$req -> heating;
        $req -> gas = str_replace(',', '.', $req -> gas);
        $req -> gas = (float)$req -> gas;
        $req -> electricity = str_replace(',', '.', $req -> electricity);
        $req -> electricity = (float)$req -> electricity;
        $req -> rubbish = str_replace(',', '.', $req -> rubbish);
        $req -> rubbish = (float)$req -> rubbish;
        $req -> internet = str_replace(',', '.', $req -> internet);
        $req -> internet = (float)$req -> internet;
        $req -> tv = str_replace(',', '.', $req -> tv);
        $req -> tv = (float)$req -> tv;
        $req -> phone = str_replace(',', '.', $req -> phone);
        $req -> phone = (float)$req -> phone;
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
        $img_name = Str::random(30);
        $extension = 'png';
        Image::make($img)->save(public_path('storage/apartment/').$img_name."-bg.".$extension);
        $url = Storage::url('apartment/'.$img_name."-bg.".$extension);
        $apartment = new Apartment;
        $apartment -> user_id = $req -> user_id;
        $apartment -> name = $req -> name;
        $apartment -> price = (int)$req -> price;
        $apartment -> image = $url;
        $apartment -> area = (int)$req -> area;
        $apartment -> rooms = (int)$req -> rooms;
        $apartment -> localization = $req -> localization;
        $apartment -> settlement_day = (int)$req -> settlement_day;
        $apartment -> billing_period = (int)$req -> billing_period;
        $apartment -> cold_water = (float)$req -> cold_water;
        $apartment -> hot_water = (float)$req -> hot_water;
        $apartment -> heating = (float)$req -> heating;
        $apartment -> gas = (float)$req -> gas;
        $apartment -> electricity = (float)$req -> electricity;
        $apartment -> rubbish = (float)$req -> rubbish;
        $apartment -> internet = (float)$req -> internet;
        $apartment -> tv = (float)$req -> tv;
        $apartment -> phone = (float)$req -> phone;
        $apartment -> save();
        return response()->json(['message' => 'OK', 'apartment_id' => $apartment -> id_apartment]);
    }
}
