<?php

namespace App\Http\Controllers;

use App\Rules\MatchOldPassword;
use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    public function download() {
        if (count(DB::select('select count from downloads')) == 0)
            DB::insert('insert into downloads (count) values (0)');
        $counter = DB::select('select count from downloads')[0] -> count;
        $counter += 1;
        DB::update('update downloads set count = ?', [$counter]);
        return redirect('/../Planus.apk');
    }

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
        $req->validate([
            'name' => 'required|string|min:2|max:15',
        ]);
        $user = User::find(Auth::id());
        $user -> name = $req -> name;
        $user -> save();
        return redirect('/panel/ustawienia');
    }

    public function changeEmail(Request $req) {
        $req->validate([
            'email' => 'required|string|email|unique:users',
        ]);
        $user = User::find(Auth::id());
        $user -> email = $req -> email;
        $user -> save();
        return redirect('/panel/ustawienia');
    }

    public function changePassword(Request $req) {
        $req->validate([
            'current_password' => ['required', new MatchOldPassword],
            'new_password' => ['required', 'string', 'min:8'],
            'confirm_password' => ['same:new_password'],
        ]);
        User::find(Auth::id())->update(['password'=> Hash::make($req->new_password)]);
        return redirect('/panel/ustawienia')->with(['message' => 'Twoje hasło zostało zmienione']);
    }

    public function delete() {
        User::destroy(Auth::id());
        return redirect('/');
    }
}
