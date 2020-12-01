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

    public function edit(Request $req) {

    }
}
