<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    public function setName(Request $req) {
        $req -> validate([
            'name' => ['string', 'max:255']
        ]);

        $user = User::find(Auth::id());
        $user -> name = $req -> name;
        $user -> save();
        return redirect('/');
    }

    public function changeName(Request $req) {
        $user = User::find($req -> user_id);
        $user -> name = $req -> name;
        return redirect('/panel/ustawienia');
    }

    public function changeEmail(Request $req) {
        $user = User::find($req -> user_id);
        $user -> email = $req -> email;
        return redirect('/panel/ustawienia');
    }

    public function changePassword(Request $req) {

    }

    public function delete() {
        Auth::destroy(Auth::id());
        return redirect('/');
    }
}
