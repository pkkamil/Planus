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
}

