<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;
// use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function register(Request $req)
    {
        $req->validate([
            'email' => 'required|string|email|unique:users',
            'password' => 'required|string|confirmed',
            'name' => 'required|string|min:2|max:15',
        ]);
        $user = new User([
            'name' => $req -> name,
            'email' => $req -> email,
            'password' => Hash::make($req -> password),
        ]);
        $user->save();
        return response()->json(['message' => 'OK']);
    }

    public function login(Request $req)
    {
        $req->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);
        $credentials = Request(['email', 'password']);
        if(!Auth::attempt($credentials))
            return response()->json([
                'message' => 'Podano błędne dane logowania'
            ], 401);
        $user = $req->user();
        return response()->json($user);
    }

    public function logout(Request $req)
    {
        $req->user()->token()->revoke();
        return response()->json([
            'message' => 'Wylogowano'
        ]);
    }

    public function changeName(Request $req) {
        $user = User::find($req -> user_id);
        $user -> name = $req -> name;
        return response()->json(['Message' => 'OK', 'Name' => $req -> name]);
    }

    public function changeEmail(Request $req) {
        $user = User::find($req -> user_id);
        $user -> email = $req -> email;
        return response()->json(['Message' => 'OK', 'Name' => $req -> email]);
    }

    public function changePassword(Request $req) {

    }


    public function delete(Request $req) {
        Auth::destroy($req -> user_id);
        return response()->json(['Message' => 'OK']);
    }
}

