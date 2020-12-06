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
            'password' => 'required|string|confirmed|min:8',
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
            return response()->json(['message' => 'Podano błędne dane logowania'], 401);
        $user = $req->user();
        return response()->json($user);
    }

    public function logout(Request $req)
    {
        $req->user()->token()->revoke();
        return response()->json(['message' => 'Wylogowano']);
    }

    public function changeName(Request $req) {
        $req->validate([
            'name' => 'required|string|min:2|max:15',
        ]);
        $user = User::find($req -> user_id);
        $user -> name = $req -> name;
        $user -> save();
        return response()->json(['Message' => 'OK', 'Name' => $req -> name]);
    }

    public function changeEmail(Request $req) {
        $req->validate([
            'email' => 'required|string|email|unique:users',
        ]);
        $user = User::find($req -> user_id);
        $user -> email = $req -> email;
        $user -> save();
        return response()->json(['Message' => 'OK', 'Name' => $req -> email]);
    }

    public function changePassword(Request $req) {
        $req->validate([
            'current_password' => ['required'],
            'new_password' => ['required', 'string', 'min:8'],
            'confirm_password' => ['same:new_password'],
        ]);
        if (!Hash::check($req -> current_password, User::find($req -> user_id)->password))
            return response()->json(['Message' => 'Incorrect current password!']);

        User::find($req -> user_id)->update(['password'=> Hash::make($req->new_password)]);
        return response()->json(['Message' => 'OK']);
    }

    public function delete(Request $req) {
        Auth::destroy($req -> user_id);
        return response()->json(['Message' => 'OK']);
    }
}

