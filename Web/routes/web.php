<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('/', 'ApartmentController@index');
Route::get('/mieszkanie/{id}', 'ApartmentController@show');
// Auth
Auth::routes();
Route::get('/przedstaw-sie', function() {
    if (Auth::id()) {
        if (Auth::user() -> name == Null)
            return view('auth.setName');
        else
            return redirect('/');
    }
    else
        return redirect('/login');
});
Route::post('/przedstaw-sie/sukces', 'UserController@setName')->name('introduce');

Route::get('/decyzja', function() {
    if (Auth::user()) {
    if (count(Auth::user() -> residents) == 0 or count(Auth::user() -> apartments) == 0)
        return view('decision');
    else
        return redirect('/panel');
    } else
        return redirect('/login');
});

Route::post('/mieszkanie/zapytaj', 'ApartmentController@inform')->middleware('auth')->name('informOwner');

Route::middleware(['introduced', 'auth'])->group(function () {
    Route::middleware(['decided'])->group(function () {
        Route::get('/panel', 'DashboardController@index')->name('dashboard');
    });
    Route::view('/panel/wynajmij', 'rentApartment')->name('rentApartment');
    Route::post('/panel/wynajmij2', 'ApartmentController@rent')->name('joinToApartment');
    Route::view('/panel/dodaj', 'addApartment')->name('addApartment');
    Route::post('/panel/dodaj', 'ApartmentController@add')->name('add');
});

