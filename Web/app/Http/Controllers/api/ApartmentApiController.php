<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\ApartmentResource;
use App\Apartment;
use App\User;

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
}
